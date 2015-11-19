--main.lua

local options = require "scripts/options"
local createMenu = require "scripts/menu"
local createGame = require "scripts/game"
local createTransition = require "scripts/transition"

local inTransition = false
local transition = createTransition(function() inTransition = false end)

local menu
local game
local currentState

menu = createMenu(function()
    inTransition = true
    transition.start(function()
        currentState = game
        game.start(1)
    end)
end)

game = createGame(function()
    inTransition = true
    transition.start(function()
        currentState = menu
        game.stop()
    end)
end)

currentState = menu

function interface.update(dt)
    currentState.update(dt)

    if inTransition then
        transition.update(dt)
    end
end

local eventActions = {
    closed = function()
        interface.exit()
    end,

    resized = function(w, h)
        options.video.h = h
        options.video.w = w
        interface.resizeWindow(w, h)
    end,

    keyReleased = function(k)
        if not inTransition then
            currentState.input(k)
        end
    end
}

function interface.handleEvent(eventType, ...)
    if eventActions[eventType] ~= nil then
        eventActions[eventType](unpack({...}))
    end
end

math.randomseed(os.time())
local options = require "scripts/options"
interface.createWindow(options.video.w, options.video.h, options.video.bpp, options.video.fps, options.title)
