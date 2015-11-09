--game.lua

--Import tiny-ecs
tiny = require "scripts/tiny"

local world = tiny.world()

local systems = require "scripts/systems/systems"
local player = require "scripts/entities/player"
local upgrade = require "scripts/upgrade"

local function setupWorld()
    for _, system in pairs(systems) do
        tiny.addSystem(world, system)
    end

    tiny.refresh(world)

    for _, system in pairs(systems) do
        tiny.setSystemIndex(world, system, system.systemIndex)
    end 

    tiny.addEntity(world, player)
    upgrade.setLaserLevel(player, 1)
    upgrade.setEngineLevel(player, 1)

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

local function isRenderSystem(_, system)
    return system == systems.renderSystem
end

local function updateWorld(dt)
    if not options.pause then
        tiny.update(world, dt)
    else
        tiny.update(world, dt, isRenderSystem)
        interface.drawShape("pause")
    end
end

local function pauseGame()
    if not options.pause then
        options.pause = true
    end

    interface.createRectangle("pause", options.video.w, options.video.h)
    interface.setShapeFillColor("pause", 64, 64, 64, 128)
    interface.setShapePosition("pause", 0, 0)
end

local function unpauseGame()
    if options.pause then
        options.pause = false
    end

    interface.removeShape("pause")
end

local function togglePause()
    if options.pause then
        unpauseGame()
    else
        pauseGame()
    end
end

local function clearWorld()
    tiny.clearEntities(world)
    tiny.clearSystems(world)
end

return {
    setupWorld = setupWorld,
    updateWorld = updateWorld,
    pauseGame = pauseGame,
    unpauseGame = unpauseGame,
    togglePause = togglePause,
    clearWorld = clearWorld
}
