--control.lua

local controlSystem = tiny.processingSystem()
controlSystem.filter = tiny.requireAll("position", "size", "velocity", "control")

local function limitVelocity(velocity)
    velocity.x = math.max(velocity.x, velocity.min.x)
    velocity.x = math.min(velocity.x, velocity.max.x)
    velocity.y = math.max(velocity.y, velocity.min.y)
    velocity.y = math.min(velocity.y, velocity.max.y)
end

local function limitPosition(position, size)
    local screen = options.video
    position.x = math.max(position.x, 0)
    position.x = math.min(position.x, (screen.w - size.w))
    position.y = math.max(position.y, 0)
    position.y = math.min(position.y, (screen.h - size.h))
end

function controlSystem:process(e, dt)
    if(interface.isKeyPressed(e.control.left)) then
        e.velocity.x = e.velocity.x - (e.velocity.delta.x * dt) 
    end

    if(interface.isKeyPressed(e.control.right)) then
        e.velocity.x = e.velocity.x + (e.velocity.delta.x * dt)
    end

    if(interface.isKeyPressed(e.control.up)) then
        e.velocity.y = e.velocity.y - (e.velocity.delta.y * dt)
    end

    if(interface.isKeyPressed(e.control.down)) then
        e.velocity.y = e.velocity.y + (e.velocity.delta.y * dt)
    end
    
    limitVelocity(e.velocity)
    limitPosition(e.position, e.size)
end

return controlSystem
