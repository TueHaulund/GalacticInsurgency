--main.lua

local menuState = require "scripts/states/menu"
local gameState = require "scripts/states/game"
local pauseState = require "scripts/states/pause"
local controlState = require "scripts/states/controls"
local transitionState = require "scripts/states/transition"

local currentState = "menu"
local inTransition = false

local function setup()
    menuState.setupMenu()
    gameState.setupGame()
    pauseState.setupPause()
    controlState.setupControls()
    transitionState.setupTransition()
end

local function start(level)
    inTransition = true
    transitionState.startTransition(function()
        currentState = "game"
        gameState.startGame(level)
    end)
end

local function exit()
    if inTransition then
        return
    end

    if currentState == "menu" then
        interface.exit()
    elseif currentState == "controls" then
        currentState = "menu"
    elseif currentState == "game" or currentState == "pause" then
        inTransition = true
        transitionState.startTransition(function()
            currentState = "menu"
            gameState.stopGame()
        end)
    end
end

local function pause()
    if currentState == "game" then
        currentState = "pause"
    end
end

local function unpause()
    if currentState == "pause" then
        currentState = "game"
    end
end

local function togglePause()
    if currentState == "game" then
        pause()
    elseif currentState == "pause" then
        unpause()
    end
end

local function showControls()
    if currentState == "menu" then
        currentState = "controls"
    end
end

local function update(dt)
    if currentState == "menu" then
        menuState.updateMenu(dt)
    elseif currentState == "controls" then
        menuState.updateMenu(dt)
        controlState.updateControls()
    elseif currentState == "game" then
        gameState.updateGame(dt, false)
    elseif currentState == "pause" then
        gameState.updateGame(dt, true)
        pauseState.updatePause()
    end

    if inTransition then
        transitionState.updateTransition(dt)
    end
end

return {
    setup = setup,
    start = start,
    exit = exit,
    pause = pause,
    unpause = unpause,
    togglePause = togglePause,
    showControls = showControls,
    update = update,

    input = function(k)
        if k == "escape" then
            exit()
        end

        if k == "p" then
            togglePause()
        end

        if currentState == "menu" then
            menuState.keyPressed(k)
        end
    end,

    stopTransition = function()
        inTransition = false
    end
}
