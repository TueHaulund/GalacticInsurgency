--collision.lua

local tiny = require "scripts/tiny"

local function getBoundingRadius(size)
    --Get diagonal length using Pythagorean theorem
    return 0.5 * math.sqrt(size.width ^ 2 + size.height ^ 2)
end

local function getHorizontalBounds(size, position)
    local radius = getBoundingRadius(size)
    return position.x - radius, position.x + radius
end

local function getVerticalBounds(size, position)
    local radius = getBoundingRadius(size)
    return position.y - radius, position.y + radius
end

local function createCollisionSystem()
    local collisionSystem = tiny.system()
    collisionSystem.filter = tiny.requireAll("position", "size", tiny.rejectAny("background", "particle"))

    local verticalList = {}
    local horizontalList = {}

    function collisionSystem:onAdd(e)
        table.insert(horizontalList, {
            entity = e,
            left, right = getHorizontalBounds(e.size, e.position)
        })

        table.insert(verticalList, {
            entity = e,
            top, bottom = getVerticalBounds(e.size, e.position)
        })
    end

    function collisionSystem:onRemove(e)
        for i, v in ipairs(verticalList)
            if e == v.entity then
                table.remove(verticalList, i)
                break
            end
        end

        for i, v in ipairs(horizontalList)
            if e == v.entity then
                table.remove(horizontalList, i)
                break
            end
        end
    end

    function collisionSystem:update(dt)
        table.sort(verticalList, function(e1, e2) return e1.top < e2.top end)
        table.sort(horizontalList, function(e1, e2) return e1.left < e2.left end)

        local active = {}
        table.insert(active, horizontalList[1])

        for i = 2, #horizontalList do
            local j = 1
            while j <= #active do
                if horizontalList[i].left > active[j].right then
                    table.remove(active, j)
                else
                    j = j + 1
                    --Collision
                end

                table.insert(active, horizontalList[i])
            end
        end
    end

    return collisionSystem
end

return createCollisionSystem
