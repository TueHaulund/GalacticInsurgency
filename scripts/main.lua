--main.lua

--Global C++ interface object
interface = {}

require("scripts/options")

--Import tiny-ecs
tiny = require("scripts/tiny")

--Import systems and entities
require("scripts/systems/movement")
require("scripts/systems/control")
require("scripts/systems/render")
require("scripts/player")

--Set up world and systems
local world = tiny.world()

--Setup function, called from C++
function interface.setup()
    tiny.addEntity(world, player)

    tiny.addSystem(world, controlSystem)
    tiny.addSystem(world, movementSystem)
    tiny.addSystem(world, renderSystem)

    tiny.refresh(world)
    tiny.setSystemIndex(world, controlSystem, 1)
    tiny.setSystemIndex(world, movementSystem, 2)
    tiny.setSystemIndex(world, renderSystem, 3)
end

--Main update function, called from C++
function interface.update(dt)
    tiny.update(world, dt)
end

--Table of actions to take on specific events
local event_actions = {
    ["closed"]       = function() print("closed") interface.exit() end,
    ["resized"]      = function(w, h) end,-- options.screen.h = h options.screen.w = w end,
    ["lost_focus"]   = function() print("lost focus") end,
    ["gained_focus"] = function() print("gained focus") end,
    ["key_pressed"]  = function(key) print("press: "..key) end,
    ["key_released"] = function(key) print("released: "..key) end
}

--Event handler, called from C++
function interface.handle_event(event_type, ...)
    if type(event_actions[event_type]) ~= nil then
        event_actions[event_type](unpack({...}))
    end
end
