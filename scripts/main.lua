--main.lua

--Global C++ interface object
interface = {}

--Global options object
options = require "scripts/options"

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

    end,

    gainedFocus = function()

    end,

    keyPressed = function(k)

    end,

    keyReleased = function(k)

    end
}

--Event handler, called from C++
function interface.handleEvent(eventType, ...)
    if type(eventActions[eventType]) ~= nil then
        eventActions[eventType](unpack({...}))
    end
end

local game = require "scripts/game"

--Setup function, called from C++
function interface.setup()
    local video = options.video
    interface.createWindow(video.w, video.h, video.bpp, video.fps, options.title)
    game.setupWorld()
end

--Main update function, called from C++
function interface.update(dt)
    game.updateWorld(dt)
end
