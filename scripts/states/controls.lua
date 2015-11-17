--controls.lua

local options = require "scripts/options"
local screenCenter = {
    x = options.video.w / 2,
    y = options.video.h / 2
}

return {
    setupControls = function()
        interface.loadSprite("controlBox", "data/sprites/controlbox.tga")
        interface.setSpritePosition("controlBox", screenCenter.x - 250, screenCenter.y - 250)
    end,

    updateControls = function()
        interface.drawSprite("controlBox")
    end
}
