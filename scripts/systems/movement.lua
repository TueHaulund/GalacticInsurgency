--movement.lua

local movementSystem = tiny.processingSystem()
movementSystem.filter = tiny.requireAll("position", "velocity")

function movementSystem:process(e, dt)
    e.position.x = e.position.x + e.velocity.x * dt
    e.position.y = e.position.y + e.velocity.y * dt
end

return movementSystem
