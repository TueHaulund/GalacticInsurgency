--player.lua

local playerSystem = tiny.processingSystem()
playerSystem.filter = tiny.requireAll("player")
playerSystem.systemIndex = 1

local function limitVelocity(velocity, min, max)
    velocity.x = math.max(velocity.x, min.x)
    velocity.x = math.min(velocity.x, max.x)
    velocity.y = math.max(velocity.y, min.y)
    velocity.y = math.min(velocity.y, max.y)
end

local function decayVelocity(velocity, decay)
    velocity.x = decay.x * velocity.x
    velocity.y = decay.y * velocity.y
end

local function limitPosition(position, size)
    local screen = options.video
    position.x = math.max(position.x, 0)
    position.x = math.min(position.x, (screen.w - size.w))
    position.y = math.max(position.y, 0)
    position.y = math.min(position.y, (screen.h - size.h))
end

local fireLaser = require "scripts/entities/lasers"
local upgrade = require "scripts/upgrade"

function playerSystem:process(e, dt)
    local leanLeft = false
    local leanRight = false

    if e.player.cooldown > 0 then
        e.player.cooldown = e.player.cooldown - dt
    end

    if interface.isKeyPressed("a") then
        e.velocity.x = e.velocity.x - (e.player.delta.x * dt)
        leanLeft = true
    end

    if interface.isKeyPressed("d") then
        e.velocity.x = e.velocity.x + (e.player.delta.x * dt)
        leanRight = true
    end

    if interface.isKeyPressed("w") then
        e.velocity.y = e.velocity.y - (e.player.delta.y * dt)
    end

    if interface.isKeyPressed("s") then
        e.velocity.y = e.velocity.y + (e.player.delta.y * dt)
    end

    if interface.isKeyPressed("space") and e.player.cooldown <= 0 then
        fireLaser(self.world, e, 1)
    end

    --[[if interface.isKeyPressed("x") then
        upgrade.upgradeEngine(e, 2)
    end

    if interface.isKeyPressed("c") then
        upgrade.upgradeEngine(e, 3)
    end

    if interface.isKeyPressed("v") then
        upgrade.upgradeEngine(e, 4)
    end

    if interface.isKeyPressed("b") then
        upgrade.upgradeEngine(e, 5)
    end

    if interface.isKeyPressed("n") then
        upgrade.upgradeEngine(e, 6)
    end

    if interface.isKeyPressed("m") then
        upgrade.upgradeEngine(e, 7)
    end--]]
    
    limitVelocity(e.velocity, e.player.min, e.player.max)
    decayVelocity(e.velocity, e.player.decay)
    limitPosition(e.position, e.size)

    --Update the clip for the sprite according to the direction of movement
    if leanLeft and not leanRight then
        e.sprite.clip.left = e.sprite.clip.offset
    elseif leanRight and not leanLeft then
        e.sprite.clip.left = e.sprite.clip.offset + 68
    else
        e.sprite.clip.left = e.sprite.clip.offset + 34
    end
end

return playerSystem
