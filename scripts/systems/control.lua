--control.lua

controlSystem = tiny.processingSystem()
controlSystem.filter = tiny.requireAll("position", "size", "velocity", "control")

local limit_velocity = function(velocity)
    velocity.x = math.max(velocity.x, velocity.min.x)
    velocity.x = math.min(velocity.x, velocity.max.x)
    velocity.y = math.max(velocity.y, velocity.min.y)
    velocity.y = math.min(velocity.y, velocity.max.y)
end

local limit_position = function(position, size)
    local screen = options.video
    position.x = math.max(position.x, 0)
    position.x = math.min(position.x, (screen.w - size.w))
    position.y = math.max(position.y, 0)
    position.y = math.min(position.y, (screen.h - size.h))
end

function controlSystem:process(e, dt)
    if(interface.is_key_pressed(e.control.left)) then
        e.velocity.x = e.velocity.x - (e.velocity.delta.x * dt) 
    end

    if(interface.is_key_pressed(e.control.right)) then
        e.velocity.x = e.velocity.x + (e.velocity.delta.x * dt)
    end

    if(interface.is_key_pressed(e.control.up)) then
        e.velocity.y = e.velocity.y - (e.velocity.delta.y * dt)
    end

    if(interface.is_key_pressed(e.control.down)) then
        e.velocity.y = e.velocity.y + (e.velocity.delta.y * dt)
    end
    
    limit_velocity(e.velocity)
    limit_position(e.position, e.size)
end
