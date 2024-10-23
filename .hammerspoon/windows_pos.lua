local windowPositions = {}

function saveWindowPositions()
	windowPositions = {}
	for _, win in ipairs(hs.window.filter.default:getWindows()) do
		if win:isStandard() then
			local id = win:id()
			windowPositions[id] = win:frame()
		end
	end
end

function maximizeAllWindows()
	for _, win in ipairs(hs.window.filter.default:getWindows()) do
		if win:isStandard() then
			win:maximize()
		end
	end
end

function restoreWindowPositions()
	for _, win in ipairs(hs.window.filter.default:getWindows()) do
		local id = win:id()
		if windowPositions[id] then
			win:setFrame(windowPositions[id])
		end
	end
end

hs.screen.watcher
	.new(function()
		local screens = hs.screen.allScreens()

		if #screens == 1 then
			saveWindowPositions()
			maximizeAllWindows()
		elseif #screens > 1 then
			restoreWindowPositions()
		end
	end)
	:start()
