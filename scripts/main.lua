--main.lua

local createMenu = require "scripts/menu"
local createGame = require "scripts/game"
local createTransition = require "scripts/effects/transition"

local currentState
local menu
local game
local transition
local inTransition = false

local function startGame(level)
    inTransition = true
    transition.start(function()
        currentState = game
        game.startGame(level)
    end)
end

local function exitToMenu()
    inTransition = true
    transition.start(function()
        currentState = menu
        game.stopGame()
    end)
end

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
    if type(eventActions[eventType]) ~= nil then
        eventActions[eventType](unpack({...}))
    end
end

math.randomseed(os.time())
local options = require "scripts/options"
interface.createWindow(options.video.w, options.video.h, options.video.bpp, options.video.fps, options.title)

menu = createMenu(function() startGame(1) end)
game = createGame(function() exitToMenu() end)
transition = createTransition(function() inTransition = false end)
currentState = menu
