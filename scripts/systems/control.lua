--control.lua

local controlSystem = tiny.processingSystem()
controlSystem.filter = tiny.requireAll("position", "size", "velocity", "player", "control")
controlSystem.systemIndex = 1

local function limitVelocity(velocity, movement)
    velocity.x = math.max(velocity.x, movement.min.x)
    velocity.x = math.min(velocity.x, movement.max.x)
    velocity.y = math.max(velocity.y, movement.min.y)
    velocity.y = math.min(velocity.y, movement.max.y)
end

local function decayVelocity(velocity, movement)
    velocity.x = movement.decay.x * velocity.x
    velocity.y = movement.decay.y * velocity.y
end

local function limitPosition(position, size)
    local screen = options.video
    position.x = math.max(position.x, 0)
    position.x = math.min(position.x, (screen.w - size.w))
    position.y = math.max(position.y, 0)
    position.y = math.min(position.y, (screen.h - size.h))
end

function controlSystem:process(e, dt)
    local control = e.control
    local movement = e.player.movement
    local offensive = e.player.offensive
    
    movement.direction.left = false
    movement.direction.right = false
    
    if offensive.remaining > 0 then
        offensive.remaining = offensive.remaining - dt
    end

    if options.focus then
        if interface.isKeyPressed(control.left) then
            e.velocity.x = e.velocity.x - (movement.delta.x * dt)
            movement.direction.left = true
        end

        if interface.isKeyPressed(control.right) then
            e.velocity.x = e.velocity.x + (movement.delta.x * dt)
            movement.direction.right = true
        end

        if interface.isKeyPressed(control.up) then
            e.velocity.y = e.velocity.y - (movement.delta.y * dt)
        end

        if interface.isKeyPressed(control.down) then
            e.velocity.y = e.velocity.y + (movement.delta.y * dt)
        end

        if interface.isKeyPressed(control.fire) then
            offensive.fire(self.world, e, dt)
        end
    end
    
    limitVelocity(e.velocity, movement)
    decayVelocity(e.velocity, movement)
    limitPosition(e.position, e.size)
end

return controlSystem
