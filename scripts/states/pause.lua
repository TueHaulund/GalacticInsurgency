--pause.lua

local options = require "scripts/options"
local screenCenter = {
    x = options.video.w / 2,
    y = options.video.h / 2
}

return {
    setupPause = function()
        --Semi-transparent rectangle overlay
        interface.createRectangle("pauseOverlay", options.video.w, options.video.h)
        interface.setShapeFillColor("pauseOverlay", 0, 0, 0, 128)
        interface.setShapePosition("pauseOverlay", 0, 0)

        interface.loadSprite("pauseBox", "data/sprites/pausebox.tga")
        interface.setSpritePosition("pauseBox", screenCenter.x - 200, screenCenter.y - 100)
    end,

    updatePause = function()
        interface.drawShape("pauseOverlay")
        interface.drawSprite("pauseBox")
    end
}
