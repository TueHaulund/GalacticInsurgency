--main.lua

local menuState = require "scripts/states/menu"
local gameState = require "scripts/states/game"
local pauseState = require "scripts/states/pause"
local controlState = require "scripts/states/controls"

local currentState = "menu"

local function setup()
    menuState.setupMenu()
    gameState.setupGame()
    pauseState.setupPause()
    controlState.setupControls()
end

local function start(level)
    currentState = "game"
    gameState.startGame(level)
end

local function exit()
    if currentState == "menu" then
        interface.exit()
    else
        currentState = "menu"
        gameState.stopGame()
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

local update = {
    menu = function(dt)
        menuState.updateMenu(dt)
    end,

    game = function(dt)
        gameState.updateGame(dt, false)
    end,

    pause = function(dt)
        gameState.updateGame(dt, true)
        pauseState.updatePause()
    end,

    controls = function(dt)
        menuState.updateMenu(dt)
        controlState.updateControls()
    end
}

return {
    setup = setup,
    start = start,
    exit = exit,
    pause = pause,
    unpause = unpause,
    togglePause = togglePause,
    showControls = showControls,

    update = function(dt)
        update[currentState](dt)
    end,

    keyPressed = function(k)
        if currentState == "menu" then
            menuState.keyPressed(k)
        end
    end
}
