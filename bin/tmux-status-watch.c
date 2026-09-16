#include <Carbon/Carbon.h>
#include <CoreServices/CoreServices.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/file.h>
#include <unistd.h>

static pid_t server;
static char home[512], prev_kb[4], fs_key[1536];
static FSEventStreamRef fs;
static int ticks;

static void run(const char *what)
{
  char cmd[640];
  snprintf(cmd, sizeof(cmd), "%s/.config/bin/tmux-status %s", home, what);
  system(cmd);
}

static void kb_up(void)
{
  TISInputSourceRef src = TISCopyCurrentKeyboardLayoutInputSource();
  CFStringRef id;
  char buf[256] = "", cur[4] = "EN", cmd[80];

  if (!src)
    src = TISCopyCurrentKeyboardInputSource();
  if (src) {
    id = TISGetInputSourceProperty(src, kTISPropertyInputSourceID);
    if (id)
      CFStringGetCString(id, buf, sizeof(buf), kCFStringEncodingUTF8);
    CFRelease(src);
    if (strstr(buf, "Russian"))
      strcpy(cur, "RU");
  }
  if (!strcmp(cur, prev_kb))
    return;
  strcpy(prev_kb, cur);
  snprintf(cmd, sizeof(cmd), "tmux set-option -g @cctask_kb %s", cur);
  system(cmd);
}

static void on_fs(ConstFSEventStreamRef s, void *i, size_t n, void *paths, const FSEventStreamEventFlags *fl, const FSEventStreamEventId *ids)
{
  char **p = paths;
  size_t j;
  int git = 0, sys = 0;

  (void)s;
  (void)i;
  (void)fl;
  (void)ids;
  for (j = 0; j < n; j++) {
    if (strstr(p[j], "/node_modules/") || strstr(p[j], "/.git/objects/"))
      continue;
    if (strstr(p[j], "tmux-claude-usage"))
      sys = 1;
    else
      git = 1;
  }
  if (git)
    run("git");
  if (sys)
    run("sys");
}

static void watch(void)
{
  char path[1024] = "", usage[512], key[1536];
  FILE *fp;
  CFStringRef strs[2];
  CFArrayRef arr;
  int n = 0;

  fp = popen("tmux list-clients -F '#{pane_current_path}' 2>/dev/null", "r");
  if (fp) {
    if (fgets(path, sizeof(path), fp))
      path[strcspn(path, "\n")] = 0;
    pclose(fp);
  }
  snprintf(usage, sizeof(usage), "%s/.cache/tmux-claude-usage", home);
  snprintf(key, sizeof(key), "%s|%s", path, usage);
  if (!strcmp(key, fs_key))
    return;
  snprintf(fs_key, sizeof(fs_key), "%s", key);
  if (fs) {
    FSEventStreamStop(fs);
    FSEventStreamInvalidate(fs);
    FSEventStreamRelease(fs);
    fs = NULL;
  }
  if (path[0])
    strs[n++] = CFStringCreateWithCString(NULL, path, kCFStringEncodingUTF8);
  strs[n++] = CFStringCreateWithCString(NULL, usage, kCFStringEncodingUTF8);
  arr = CFArrayCreate(NULL, (const void **)strs, n, &kCFTypeArrayCallBacks);
  while (n)
    CFRelease(strs[--n]);
  fs = FSEventStreamCreate(NULL, on_fs, NULL, arr, kFSEventStreamEventIdSinceNow, 0.4, kFSEventStreamCreateFlagNoDefer);
  CFRelease(arr);
  if (!fs)
    return;
  FSEventStreamScheduleWithRunLoop(fs, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
  FSEventStreamStart(fs);
}

static void on_kb(CFNotificationCenterRef c, void *o, CFNotificationName n, const void *obj, CFDictionaryRef i)
{
  (void)c;
  (void)o;
  (void)n;
  (void)obj;
  (void)i;
  kb_up();
}

static void on_tick(CFRunLoopTimerRef t, void *i)
{
  (void)t;
  (void)i;
  if (kill(server, 0) != 0)
    exit(0);
  run("light");
  watch();
  if (++ticks % 3 == 0)
    run("pane");
}

int main(int argc, char **argv)
{
  char lock[576];
  int fd;

  if (argc < 2 || !getenv("HOME"))
    return 1;
  server = (pid_t)atoi(argv[1]);
  if (server <= 1)
    return 1;
  snprintf(home, sizeof(home), "%s", getenv("HOME"));
  setenv("PATH", "/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin", 1);
  snprintf(lock, sizeof(lock), "%s/.cache/tmux-status.lock", home);
  fd = open(lock, O_CREAT | O_RDWR, 0644);
  if (fd < 0 || flock(fd, LOCK_EX | LOCK_NB) != 0)
    return fd < 0;
  kb_up();
  run("all");
  watch();
  CFNotificationCenterAddObserver(
      CFNotificationCenterGetDistributedCenter(), NULL, on_kb,
      kTISNotifySelectedKeyboardInputSourceChanged, NULL,
      CFNotificationSuspensionBehaviorDeliverImmediately);
  CFRunLoopAddTimer(
      CFRunLoopGetCurrent(),
      CFRunLoopTimerCreate(NULL, CFAbsoluteTimeGetCurrent() + 5, 5.0, 0, 0, on_tick, NULL),
      kCFRunLoopDefaultMode);
  CFRunLoopRun();
  return 0;
}
