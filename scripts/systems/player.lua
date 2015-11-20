--player.lua

local tiny = require "scripts/tiny"

local createPlayer = require "scripts/entities/player"

local function createPlayerSystem()
    local playerSystem = tiny.processingSystem()
    playerSystem.filter = tiny.requireAll("player")

    function playerSystem:onAddToWorld(world)
        local player = createPlayer()

        --TEST--
        local upgrade = require "scripts/upgrade"
        upgrade.setLaserLevel(player, 1)
        upgrade.setEngineLevel(player, 1)
        --/TEST--

        tiny.addEntity(world, player)
    end

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

        if interface.isKeyPressed("space") then
            if e.player.cooldown <= 0 and e.player.fire ~=nil then
                e.player.fire(self.world, e)
            end
        end

        --Limit velocity in all four directions
        e.velocity.x = math.max(e.velocity.x, e.player.min.x)
        e.velocity.x = math.min(e.velocity.x, e.player.max.x)
        e.velocity.y = math.max(e.velocity.y, e.player.min.y)
        e.velocity.y = math.min(e.velocity.y, e.player.max.y)

        --Add velocity decay for gliding effect
        e.velocity.x = e.player.decay.x * e.velocity.x
        e.velocity.y = e.player.decay.y * e.velocity.y

        --Keep player within viewport
        e.position.x = math.max(e.position.x, 0)
        e.position.x = math.min(e.position.x, (800 - e.size.w))
        e.position.y = math.max(e.position.y, 0)
        e.position.y = math.min(e.position.y, (600 - e.size.h))

        --Update the clip for the sprite according to the direction of movement
        if leanLeft and not leanRight then
            e.sprite.clip.left = e.player.spriteOffset.x
        elseif leanRight and not leanLeft then
            e.sprite.clip.left = e.player.spriteOffset.x + 2 * e.sprite.clip.width
        else
            e.sprite.clip.left = e.player.spriteOffset.x + e.sprite.clip.width
        end

        e.sprite.clip.top = e.player.spriteOffset.y
    end

    return playerSystem
end

return createPlayerSystem
