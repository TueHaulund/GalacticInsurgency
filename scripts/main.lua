--main.lua

local menu = require "scripts/states/menu"
local game = require "scripts/states/game"
local pause = require "scripts/states/pause"

local currentState = "menu"

local function newGame()
    if currentState == "menu" then
        currentState = "game"
        game.start(1)
    end
end

local function startGame(level)
    currentState = "game"
    game.start(level)
end

local function exitGame()
    if currentState == "menu" then
        interface.exit()
    else
        currentState = "menu"
        game.stop()
    end
end

local function pauseGame()
    if currentState == "game" then
        currentState = "pause"
    end
end

local function unpauseGame()
    if currentState == "pause" then
        currentState = "game"
    end
end

local function togglePause()
    if currentState == "game" then
        pauseGame()
    elseif currentState == "pause" then
        unpauseGame()
    end
end

local update = {
    menu = function(dt)
        menu.update(dt)
    end,

    game = function(dt)
        game.update(dt, false)
    end,

    pause = function(dt)
        game.update(dt, true)
        pause.update()
    end
}

return {
    newGame = newGame,
    startGame = startGame,
    exitGame = exitGame,
    pauseGame = pauseGame,
    unpauseGame = unpauseGame,
    togglePause = togglePause,
    updateGame = function(dt)
        update[currentState](dt)
    end
}
