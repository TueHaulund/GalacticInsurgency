--systems.lua

return {
    createPlayerSystem = require "scripts/systems/player",
    createMovementSystem = require "scripts/systems/movement",
    createBackgroundSystem = require "scripts/systems/background",
    createEmitterSystem = require "scripts/systems/emitter",
    createTemporarySystem = require "scripts/systems/temporary",
    createCullingSystem = require "scripts/systems/culling",
    createCollisionSystem = require "scripts/systems/collision",
    createRenderSystem = require "scripts/systems/render"
}
