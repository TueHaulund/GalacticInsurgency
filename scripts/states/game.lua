--game.lua

--Import tiny-ecs
local tiny = require "scripts/tiny"
local world = tiny.world()

local systems = require "scripts/systems/systems"

local gameSystems = {
    playerSystem = systems.createPlayerSystem(),
    movementSystem = systems.createMovementSystem(),
    backgroundSystem = systems.createBackgroundSystem(),
    emitterSystem = systems.createEmitterSystem(),
    temporarySystem = systems.createTemporarySystem(),
    oobSystem = systems.createOobSystem(),
    renderSystem = systems.createRenderSystem()
}

local function start(level)
    --Register systems
    for _, system in pairs(gameSystems) do
        tiny.addSystem(world, system)
    end

    tiny.refresh(world)

    for _, system in pairs(gameSystems) do
        tiny.setSystemIndex(world, system, system.systemIndex)
    end

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

local function stop()
    tiny.clearEntities(world)
    tiny.clearSystems(world)
end

local function isRenderSystem(_, system)
    return system == gameSystems.renderSystem
end

local function update(dt, renderOnly)
    if renderOnly then
        tiny.update(world, dt, isRenderSystem)
    else
        tiny.update(world, dt)
    end
end

return {
    start = start,
    stop = stop,
    update = update
}
