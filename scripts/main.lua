--main.lua

local menuState = require "scripts/menu"
local gameState = require "scripts/game"

local transitionEffect = require "scripts/effects/transition"

local currentState = "menu"
local inTransition = false

local function setup()
    menuState.setupMenu()
    gameState.setupGame()
    transitionEffect.setupTransition()
end

local function startGame(level)
    inTransition = true

    transitionEffect.startTransition(function()
        currentState = "game"
        gameState.startGame(level)
    end)
end

local function exitToMenu()
    inTransition = true

    transitionEffect.startTransition(function()
        currentState = "menu"
        gameState.stopGame()
    end)
end

local function update(dt)
    if currentState == "menu" then
        menuState.updateMenu(dt)
    elseif currentState == "game" then
        gameState.updateGame(dt)
    end

    if inTransition then
        transitionEffect.updateTransition(dt)
    end
end

return {
    setup = setup,
    startGame = startGame,
    exitToMenu = exitToMenu,
    update = update,

    input = function(k)
        if not inTransition then
            if currentState == "menu" then
                menuState.input(k)
            elseif currentState == "game" then
                gameState.input(k)
        end
    end,

    stopTransition = function()
        inTransition = false
    end
}
