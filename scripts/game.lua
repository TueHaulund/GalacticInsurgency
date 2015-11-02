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
