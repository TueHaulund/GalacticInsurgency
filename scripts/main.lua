--main.lua

--Import tiny-ecs
tiny = require("scripts/tiny")

local world = tiny.world()

--Global C++ interface object
interface = {}

--Main update function, called from C++
function interface.update(dt)
    world:update(dt)
    print(dt)
    print(interface.is_key_pressed("down"))
end

--Main draw function, called from C++
function interface.draw()
    print("draw")
    os.execute("sleep 1")
end

--Table of actions to take on specific events
local event_actions = {
    ["closed"]       = function() print("closed") interface.exit() end,
    ["resized"]      = function(w, h) print("resized: "..w.." "..h) end,
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
