--movement.lua

local function createMovementSystem()
    local movementSystem = tiny.processingSystem()
    movementSystem.filter = tiny.requireAll("position", "velocity")
    movementSystem.systemIndex = 2

    function movementSystem:process(e, dt)
        e.position.x = e.position.x + e.velocity.x * dt
        e.position.y = e.position.y + e.velocity.y * dt
    end

    return movementSystem
end

return createMovementSystem
