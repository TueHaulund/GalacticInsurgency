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

local counter = 0

local function createParticle(e, source)
    counter = counter + 1

    return {
        position = {
            x = e.position.x + randomize(source.offset.x),
            y = e.position.y + randomize(source.offset.y)
        },

        velocity = {
            x = randomize(source.velocity.x),
            y = randomize(source.velocity.y)
        },

        shape = {
            identifier = "particle"..counter,
            z = 1,
            rectangle = {
                w = randomize(source.size.w),
                h = randomize(source.size.h)
            },

            fill = {
                r = randomize(source.color.r),
                g = randomize(source.color.g),
                b = randomize(source.color.b),
                a = randomize(source.color.a)
            }
        },

        particle = {
            lifetime = randomize(source.lifetime)
        }
    }
end

return createParticle
