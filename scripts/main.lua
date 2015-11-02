--main.lua

--Global C++ interface object
interface = {}

--Global options object
options = require "scripts/options"

options.focus = true
options.pause = false

local game = require "scripts/game"

--Table of actions to take on specific events
local eventActions = {
    closed = function()
        interface.exit()
    end,

    resized = function(w, h)
        options.video.h = h
        options.video.w = w
        interface.resizeWindow(w, h)
    end,

    lostFocus = function()
        options.focus = false
    end,

    gainedFocus = function()
        options.focus = true
    end,

    keyPressed = function(k)

    end,

    keyReleased = function(k)
        if k == "escape" then
            interface.exit()
        end

        if k == "p" then
            game.togglePause()
        end
    end
}

--Event handler, called from C++
function interface.handleEvent(eventType, ...)
    if type(eventActions[eventType]) ~= nil then
        eventActions[eventType](unpack({...}))
    end
end

--Setup function, called from C++
function interface.setup()
    math.randomseed(os.time())
    local video = options.video
    interface.createWindow(video.w, video.h, video.bpp, video.fps, options.title)
    game.setupWorld()
end

--Main update function, called from C++
function interface.update(dt)
    game.updateWorld(dt)
end

--Teardown function, called from C++
function interface.tearDown()
    game.clearWorld()
    interface.clearSprites()
    interface.clearSounds()
    interface.clearMusic()
    interface.closeWindow()
end
