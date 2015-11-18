--player.lua

local generateIdentifier = require "scripts/identifier"

local function createPlayer()
    return {
        position = {
            x = 383,
            y = 500
        },

        size = {
            w = 40,
            h = 46
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
                width = 40,
                height = 46
            }
        },

        emitter = {
            sources = {}
        }
    }
end

return createPlayer
