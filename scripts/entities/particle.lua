--particle.lua

local generateIdentifier = require "scripts/identifier"

local function randomize(interval)
    if type(interval) == "number" then
        return interval
    else
        local start, _end, step = interval[1], interval[2], interval[3]
        if start == _end then
            return start
        elseif step == nil then
            return math.random(start, _end)
        else
            local n = (_end - start) / step
            local i = math.random(0, n)
            return start + (i * step)
        end
    end
end

local function createParticle(e, source)
    local size = {
        w = randomize(source.size.w),
        h = randomize(source.size.h)
    }

    local particle = {
        position = {
            x = e.position.x + randomize(source.offset.x),
            y = e.position.y + randomize(source.offset.y)
        },

        size = size,

        velocity = {
            x = randomize(source.velocity.x),
            y = randomize(source.velocity.y)
        },

        shape = {
            identifier = generateIdentifier "particle",
            z = 1,
            rectangle = size,

            fill = {
                r = randomize(source.color.r),
                g = randomize(source.color.g),
                b = randomize(source.color.b),
                a = randomize(source.color.a)
            }
        },

        lifetime = randomize(source.lifetime),

        particle = true
    }

    if source.rotate then
        particle.shape.rotation = 360 - math.deg(math.atan2(particle.velocity.x, particle.velocity.y))
    end

    return particle
end

return createParticle
