--transition.lua

local options = require "scripts/options"

local shutterVelocity = 50
local shutterDelay = 2
local shutterState = "close"
local transitionCallback = nil

local shutterPosition = {
    topShutter = -300,
    bottomShutter = options.video.h
}

local function reset()
    shutterVelocity = 50
    shutterDelay = 2
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
            else
                return
            end
        end

        shutterPosition.topShutter = shutterPosition.topShutter + shutterVelocity * dt
        shutterPosition.bottomShutter = shutterPosition.bottomShutter - shutterVelocity * dt

        interface.setSpritePosition("topShutter", 0, position.top)
        interface.setSpritePosition("bottomShutter", 0, position.bottom)
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
