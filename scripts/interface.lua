--interface.lua

--Global C++ interface object
interface = {}

local options = require "scripts/options"
local main = require "scripts/main"

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
        main.input(k)
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
    main.setup()
end

--Main update function, called from C++
function interface.update(dt)
    main.update(dt)
end

--Teardown function, called from C++
function interface.tearDown()
    interface.clearSprites()
    interface.clearShapes()
    interface.clearText()
    interface.clearSounds()
    interface.clearMusic()
    interface.closeWindow()
end
