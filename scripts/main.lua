--main.lua

--Import tiny-ecs
tiny = require("scripts/tiny")

local world = tiny.world()

--Main update function, called from C++
function update(dt)
    world:update(dt)
    print(dt)
end

--Main draw function, called from C++
function draw()
    print("draw")
    os.execute("sleep 1")
end
