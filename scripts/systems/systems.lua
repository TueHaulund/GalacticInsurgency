--systems.lua

return {
    createPlayerSystem = require "scripts/systems/player",
    createMovementSystem = require "scripts/systems/movement",
    createBackgroundSystem = require "scripts/systems/background",
    createEmitterSystem = require "scripts/systems/emitter",
    createTemporarySystem = require "scripts/systems/temporary",
    createOobSystem = require "scripts/systems/oob",
    createRenderSystem = require "scripts/systems/render"
}
