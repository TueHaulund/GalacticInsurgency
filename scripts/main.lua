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
end

--Table of actions to take on specific events
local event_actions = {
    ["closed"] =        function() interface.exit() end,
    ["lost_focus"] =    function() end,
    ["gained_focus"] =  function() end,
    ["mouse_left"] =    function() end,
    ["mouse_entered"] = function() end
}

--Event handler, called from C++
function interface.handle_event(event)
    if type(event_actions[event]) ~= nil then
        event_actions[event]()
    end
end
