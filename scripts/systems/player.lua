--player.lua

local function createPlayerSystem()
    local generateIdentifier = require "scripts/identifier"

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
        position.y = math.min(position.y, (screen.h - 100))
    end

    local upgrade = require "scripts/upgrade"

    function playerSystem:onAddToWorld(world)
        local player = {
            position = {
                x = 383,
                y = 500
            },

            size = {
                w = 34,
                h = 26
            },

            velocity = {
                x = 0,
                y = 0
            },

            player = {
                delta = {
                    x = 450,
                    y = 450
                },

                max = {
                    x = 200,
                    y = 200
                },

                min = {
                    x = -200,
                    y = -200
                },

                decay = {
                    x = 0.95,
                    y = 0.95
                },

                spriteOffset = {
                    x = 0,
                    y = 0
                },

                cooldown = 0,
                fire = nil
            },

            sprite = {
                path = "data/sprites/player.tga",
                identifier = generateIdentifier "playerShip",
                z = 10,

                scale = {
                    x = 1,
                    y = 1
                },

                clip = {
                    left = 0,
                    top = 0,
                    width = 34,
                    height = 25
                }
            },

            emitter = {
                sources = {}
            }
        }
    
        upgrade.setLaserLevel(player, 1)
        upgrade.setEngineLevel(player, 1)
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

        if interface.isKeyPressed("z") then
            upgrade.setEngineLevel(e, 1)
        end

        if interface.isKeyPressed("x") then
            upgrade.setEngineLevel(e, 2)
        end

        if interface.isKeyPressed("c") then
            upgrade.setEngineLevel(e, 3)
        end

        if interface.isKeyPressed("v") then
            upgrade.setEngineLevel(e, 4)
        end

        if interface.isKeyPressed("b") then
            upgrade.setEngineLevel(e, 5)
        end

        if interface.isKeyPressed("n") then
            upgrade.setEngineLevel(e, 6)
        end

        if interface.isKeyPressed("f") then
            upgrade.setLaserLevel(e, 1)
        end

        if interface.isKeyPressed("g") then
            upgrade.setLaserLevel(e, 2)
        end

        if interface.isKeyPressed("h") then
            upgrade.setLaserLevel(e, 3)
        end

        if interface.isKeyPressed("j") then
            upgrade.setLaserLevel(e, 4)
        end

        if interface.isKeyPressed("k") then
            upgrade.setLaserLevel(e, 5)
        end

        if interface.isKeyPressed("l") then
            upgrade.setLaserLevel(e, 6)
        end

        if interface.isKeyPressed("o") then
            upgrade.setLaserLevel(e, 7)
        end
    
        limitVelocity(e.velocity, e.player.min, e.player.max)
        decayVelocity(e.velocity, e.player.decay)
        limitPosition(e.position, e.size)

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
