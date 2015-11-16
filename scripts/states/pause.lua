--pause.lua

local mainFont = "data/fonts/MainFont.ttf"
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

        interface.createText("pauseHeading", "Paused", mainFont)
        interface.setTextColor("pauseHeading", 0, 0, 0, 255)
        interface.setTextSize("pauseHeading", 32)
        interface.setTextPosition("pauseHeading", screenCenter.x - 55, screenCenter.y - 85)

        interface.createText("unpauseText", "Press p to unpause", mainFont)
        interface.setTextColor("unpauseText", 0, 0, 0, 255)
        interface.setTextSize("unpauseText", 20)
        interface.setTextPosition("unpauseText", screenCenter.x - 110, screenCenter.y)

        interface.createText("exitText", "Press escape to exit", mainFont)
        interface.setTextColor("exitText", 0, 0, 0, 255)
        interface.setTextSize("exitText", 20)
        interface.setTextPosition("exitText", screenCenter.x - 117, screenCenter.y + 20)
    end,

    updatePause = function()
        interface.drawShape("pauseOverlay")
        interface.drawSprite("pauseBox")
        interface.drawText("pauseHeading")
        interface.drawText("unpauseText")
        interface.drawText("exitText")
    end
}
