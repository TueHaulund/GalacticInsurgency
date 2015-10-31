--control.lua

local controlSystem = tiny.processingSystem()
controlSystem.filter = tiny.requireAll("position", "size", "velocity", "control")

local function limitVelocity(velocity, control)
    velocity.x = math.max(velocity.x, control.min.x)
    velocity.x = math.min(velocity.x, control.max.x)
    velocity.y = math.max(velocity.y, control.min.y)
    velocity.y = math.min(velocity.y, control.max.y)
end

local function decayVelocity(velocity, control)
    velocity.x = control.decay.x * velocity.x
    velocity.y = control.decay.y * velocity.y
end

local function limitPosition(position, size)
    local screen = options.video
    position.x = math.max(position.x, 0)
    position.x = math.min(position.x, (screen.w - size.w))
    position.y = math.max(position.y, 0)
    position.y = math.min(position.y, (screen.h - size.h))
end

function controlSystem:process(e, dt)
    if options.focus then
        if interface.isKeyPressed(e.control.left) then
            e.velocity.x = e.velocity.x - (e.control.delta.x * dt) 
        end

        if interface.isKeyPressed(e.control.right) then
            e.velocity.x = e.velocity.x + (e.control.delta.x * dt)
        end

        if interface.isKeyPressed(e.control.up) then
            e.velocity.y = e.velocity.y - (e.control.delta.y * dt)
        end

        if interface.isKeyPressed(e.control.down) then
            e.velocity.y = e.velocity.y + (e.control.delta.y * dt)
        end
    
        limitVelocity(e.velocity, e.control)
        decayVelocity(e.velocity, e.control)
        limitPosition(e.position, e.size)
    end
end

return controlSystem
