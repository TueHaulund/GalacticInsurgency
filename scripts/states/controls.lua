--controls.lua

local mainFont = "data/fonts/MainFont.ttf"
local options = require "scripts/options"
local screenCenter = {
    x = options.video.w / 2,
    y = options.video.h / 2
}

return {
    setupControls = function()
        interface.createText("controlsHeading", "Controls", mainFont)
        interface.setTextColor("controlsHeading", 255, 255, 255, 255)
        interface.setTextSize("controlsHeading", 32)
        interface.setTextPosition("controlsHeading", screenCenter.x, screenCenter.y)
    end,

    updateControls = function()
        interface.drawText("controlsHeading")
    end
}
