--game.lua

--Import tiny-ecs
tiny = require "scripts/tiny"
local systems = require "scripts/systems/systems"

local world = tiny.world()
local currentState = "menu"

--GUI states
local pause = require "scripts/pause"
local menu = require "scripts/menu"

local function setupGame()
    pause.setupPauseScreen()
    menu.setupMenuScreen()
end

local function startGame(level)
    currentState = "game"

    --Register systems
    for _, createSystem in pairs(systems) do
        tiny.addSystem(world, createSystem())
    end

    --tiny.refresh(world)

    --for _, system in pairs(systems) do
        --tiny.setSystemIndex(world, system, system.systemIndex)
    --end

    --Test explostion
    tiny.addEntity(world, {
        position = {
            x = 200,
            y = 200
        },

        temporary = 0.5,

        emitter = {
            sources = {
                {
                    rate = 200,
                    temporary = {0.1, 1.0, 0.1},
                    rotate = true,

                    offset = {
                        x = 0,
                        y = 0
                    },

                    size = {
                        w = {1, 2},
                        h = {1, 5}
                    },

                    velocity = {
                        x = {-100, 100},
                        y = {-100, 100}
                    },

                    color = {
                        r = 255,
                        g = {50, 255},
                        b = 0,
                        a = 255
                    }
                }
            }
        }
    })
end

local function stopGame()
    currentState = "menu"
    tiny.clearEntities(world)
    tiny.clearSystems(world)
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

local function isRenderSystem(_, system)
    return system == systems.renderSystem
end

local foo = 5

local gameStates = {
    menu = function(dt)
        foo = foo - dt
        menu.drawMenuScreen(dt)
        if foo < 0 then
            startGame()
        end
    end,

    game = function(dt)
        tiny.update(world, dt)
    end,

    pause = function(dt)
        tiny.update(world, dt, isRenderSystem)
        pause.drawPauseScreen()
    end
}

local function updateGame(dt)
    gameStates[currentState](dt)
end

return {
    setupGame = setupGame,
    startGame = startGame,
    stopGame = stopGame,
    updateGame = updateGame,
    pauseGame = pauseGame,
    unpauseGame = unpauseGame,
    togglePause = togglePause
}
