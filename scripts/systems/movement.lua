--movement.lua

local tiny = require "scripts/tiny"

local function createMovementSystem()
    local movementSystem = tiny.processingSystem()
    movementSystem.filter = tiny.requireAll("position", "movement")

    function movementSystem:process(e, dt)
        local velocity = e.movement.velocity

        if e.movement.delta ~= nil then
            --Apply acceleration
            velocity.x = velocity.x + (e.movement.delta.x * dt)
            velocity.y = velocity.y + (e.movement.delta.y * dt)
        end

        if e.movement.min ~= nil and e.movement.max ~= nil then
            --Limit velocity in all four directions
            velocity.x = math.max(velocity.x, e.movement.min.x)
            velocity.x = math.min(velocity.x, e.movement.max.x)
            velocity.y = math.max(velocity.y, e.movement.min.y)
            velocity.y = math.min(velocity.y, e.movement.max.y)
        end

        if e.movement.decay ~= nil then
            --Add velocity decay for gliding effect
            velocity.x = e.movement.decay.x * velocity.x
            velocity.y = e.movement.decay.y * velocity.y
        end

        e.position.x = e.position.x + velocity.x * dt
        e.position.y = e.position.y + velocity.y * dt
    end

    return movementSystem
end

return createMovementSystem
