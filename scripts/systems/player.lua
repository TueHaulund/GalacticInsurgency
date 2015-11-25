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

        e.movement.delta = {
            x = 0,
            y = 0
        }

        if e.player.cooldown > 0 then
            e.player.cooldown = e.player.cooldown - dt
        end

        if interface.isKeyPressed("a") then
            e.movement.delta.x = e.movement.delta.x - 450
            leanLeft = true
        end

        if interface.isKeyPressed("d") then
            e.movement.delta.x = e.movement.delta.x + 450
            leanRight = true
        end

        if interface.isKeyPressed("w") then
            e.movement.delta.y = e.movement.delta.y - 450
        end

        if interface.isKeyPressed("s") then
            e.movement.delta.y = e.movement.delta.y + 450
        end

        if interface.isKeyPressed("space") then
            if e.player.cooldown <= 0 and e.player.fire ~=nil then
                e.player.fire(self.world, e)
            end
        end

        --Update the clip for the sprite according to the direction of movement
        if leanLeft and not leanRight then
            e.sprite.clip.left = 0
        elseif leanRight and not leanLeft then
            e.sprite.clip.left = 2 * e.sprite.clip.width
        else
            e.sprite.clip.left = e.sprite.clip.width
        end
    end

    return playerSystem
end

return createPlayerSystem
