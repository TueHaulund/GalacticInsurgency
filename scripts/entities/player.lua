--player.lua

local generateIdentifier = require "scripts/identifier"

local player = {
    position = {
        x = 383,
        y = 450
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

return player
