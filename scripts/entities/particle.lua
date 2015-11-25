--particle.lua

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
    local particle = {
        position = {
            x = e.position.x + randomize(source.offset.x),
            y = e.position.y + randomize(source.offset.y)
        },

        size = {
            w = randomize(source.size.w),
            h = randomize(source.size.h)
        },

        movement = {
            velocity = {
                x = randomize(source.velocity.x),
                y = randomize(source.velocity.y)
            }
        },

        shape = {
            identifier = interface.getUniqueIdentifier(),
            z = 1,

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
        particle.rotation = 360 - math.deg(math.atan2(particle.movement.velocity.x, particle.movement.velocity.y))
    end

    return particle
end

return createParticle
