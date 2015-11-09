--gui.lua

local pause = require "scripts/pause"

local function setupGUI()
    pause.setupPauseScreen()
end

local function updateGUI(dt)
    --Draw gui here

    if options.pause then
        pause.drawPauseScreen()
    end
end

local function clearGUI()
    pause.clearPauseScreen()
end

return {
    setupGUI = setupGUI, 
    updateGUI = updateGUI,
    clearGUI = clearGUI
}
