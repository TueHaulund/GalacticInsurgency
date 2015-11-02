--game.lua

--Import tiny-ecs
tiny = require "scripts/tiny"

local world = tiny.world()

local systems = require "scripts/systems/systems"
local player = require "scripts/player"

local function setupWorld()
    tiny.addEntity(world, player)
    tiny.addSystem(world, systems.controlSystem)
    tiny.addSystem(world, systems.movementSystem)
    tiny.addSystem(world, systems.backgroundSystem)
    tiny.addSystem(world, systems.emitterSystem)
    tiny.addSystem(world, systems.particleSystem)
    tiny.addSystem(world, systems.renderSystem)
    tiny.refresh(world)

    tiny.setSystemIndex(world, systems.controlSystem, 1)
    tiny.setSystemIndex(world, systems.movementSystem, 2)
    tiny.setSystemIndex(world, systems.backgroundSystem, 3)
    tiny.setSystemIndex(world, systems.emitterSystem, 4)
    tiny.setSystemIndex(world, systems.particleSystem, 5)
    tiny.setSystemIndex(world, systems.renderSystem, 6)

    --[[tiny.addEntity(world, {
        position = {
            x = 200,
            y = 200
        },

        emitter = {
            sources = {
                {
                    rate = 2000,
                    lifetime = {0.1, 2.0, 0.1},
                    rotate = true,

                    offset = {
                        x = 0,
                        y = 0
                    },

                    size = {
                        w = {1, 1},
                        h = {1, 5}
                    },

                    velocity = {
                        x = {-50, 50},
                        y = {-50, 50}
                    },

                    color = {
                        r = 255,
                        g = 255,
                        b = 255,
                        a = 255
                    }
                }
            }
        }
    })--]]
end

local function isRenderSystem(_, system)
    return system == systems.renderSystem
end

local function updateWorld(dt)
    if not options.pause then
        tiny.update(world, dt)
    else
        tiny.update(world, dt, isRenderSystem)
    end
end

local function togglePause()
    options.pause = not options.pause
end

local function clearWorld()
    tiny.clearEntities(world)
    tiny.clearSystems(world)
end

return {
    setupWorld = setupWorld,
    updateWorld = updateWorld,
    togglePause = togglePause,
    clearWorld = clearWorld
}
