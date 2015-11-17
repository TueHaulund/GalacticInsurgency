--transition.lua

local options = require "scripts/options"
local screenCenter = {
    x = options.video.w / 2,
    y = options.video.h / 2
}

local position = {
    top = -400,
    bottom = options.video.h + 400
}

local main
local phase
local transitionFunction

return {
    setupTransition = function()
        interface.loadSprite("topShutter", "data/sprites/transition.tga")
        interface.setSpriteClip("topShutter", 0, 0, 800, 300)
        
        interface.loadSprite("bottomShutter", "data/sprites/transition.tga")
        interface.setSpriteClip("bottomShutter", 0, 300, 800, 300)
        main = require "scripts/main"
    end,

    startTransition = function(f)
        phase = "close"
        transitionFunction = f
        position = {
            top = -300,
            bottom = options.video.h
        }
    end,

    updateTransition = function(dt)
        if position.top == 0 and phase == "close" then
            transitionFunction()
            phase = "open"
        elseif position.top == -400 and phase == "open" then
            main.stopTransition()
        end

        if phase == "close" then
            position.top = position.top + 5
            position.bottom = position.bottom - 5
        else
            position.top = position.top - 5
            position.bottom = position.bottom + 5
        end

        interface.setSpritePosition("topShutter", 0, position.top)
        interface.setSpritePosition("bottomShutter", 0, position.bottom)
        interface.drawSprite("topShutter")
        interface.drawSprite("bottomShutter")
    end
}
