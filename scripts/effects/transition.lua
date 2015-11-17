--transition.lua

local options = require "scripts/options"

local shutterVelocity = 450
local shutterDelay = 1
local shutterState = "close"
local transitionCallback = nil

local shutterPosition = {
    topShutter = -300,
    bottomShutter = options.video.h
}

local function reset()
    shutterVelocity = 450
    shutterDelay = 1
    shutterState = "close"
    transitionCallback = nil

    shutterPosition = {
        topShutter = -300,
        bottomShutter = options.video.h
    }
end

local main

return {
    setupTransition = function()
        interface.loadSprite("topShutter", "data/sprites/transition.tga")
        interface.setSpriteClip("topShutter", 0, 0, 800, 300)

        interface.loadSprite("bottomShutter", "data/sprites/transition.tga")
        interface.setSpriteClip("bottomShutter", 0, 300, 800, 300)
        main = require "scripts/main"
    end,

    startTransition = function(callback)
        reset()
        transitionCallback = callback
    end,

    updateTransition = function(dt)
        if shutterState == "delay" then
            shutterDelay = shutterDelay - dt

            if shutterDelay <= 0 then
                shutterState = "open"
                shutterVelocity = -shutterVelocity
            end
        else
            shutterPosition.topShutter = shutterPosition.topShutter + shutterVelocity * dt
            shutterPosition.bottomShutter = shutterPosition.bottomShutter - shutterVelocity * dt
        end

        interface.setSpritePosition("topShutter", 0, shutterPosition.topShutter)
        interface.setSpritePosition("bottomShutter", 0, shutterPosition.bottomShutter)
        interface.drawSprite("topShutter")
        interface.drawSprite("bottomShutter")

        if shutterPosition.topShutter >= 0 and shutterState == "close" then
            transitionCallback()
            shutterState = "delay"
        elseif shutterPosition.topShutter <= -400 and shutterState == "open" then
            main.stopTransition()
        end
    end
}
