--main.lua

local createMenu = require "scripts/menu"
local gameState = require "scripts/game"
local transitionEffect = require "scripts/effects/transition"

local currentState = menuState
local inTransition = false

math.randomseed(os.time())
local video = require "scripts/options".video
interface.createWindow(video.w, video.h, video.bpp, video.fps, "abe")

menuState.setupMenu()
gameState.setupGame()
transitionEffect.setupTransition()

local function startGame(level)
    inTransition = true

    transitionEffect.startTransition(function()
        currentState = gameState
        gameState.startGame(level)
    end, function()
        inTransition = false
    end)
end

local function exitToMenu()
    inTransition = true

    transitionEffect.startTransition(function()
        currentState = menuState
        gameState.stopGame()
    end, function()
        inTransition = false
    end)
end

function interface.update(dt)
    currentState.update(dt)

    if inTransition then
        transitionEffect.updateTransition(dt)
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
            if currentState == menuState then
                currentState.input(k, function() startGame(1) end)
            elseif currentState == gameState then
                currentState.input(k, function() exitToMenu() end)
            end
        end
    end
}

function interface.handleEvent(eventType, ...)
    if type(eventActions[eventType]) ~= nil then
        eventActions[eventType](unpack({...}))
    end
end

return {
    startGame = startGame,
    exitToMenu = exitToMenu,

    stopTransition = function()
        inTransition = false
    end
}
