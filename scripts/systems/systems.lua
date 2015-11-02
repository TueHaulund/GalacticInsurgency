--systems.lua

return {
    controlSystem = require "scripts/systems/control",
    movementSystem = require "scripts/systems/movement",
    backgroundSystem = require "scripts/systems/background",
    emitterSystem = require "scripts/systems/emitter",
    temporarySystem = require "scripts/systems/temporary",
    projectileSystem = require "scripts/systems/projectile",
    renderSystem = require "scripts/systems/render"
}
