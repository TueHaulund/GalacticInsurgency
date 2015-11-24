--collision.lua

local tiny = require "scripts/tiny"

local function insertObject(objectList, e1, getBounds)
    table.insert(objectList, e1)
end

local function removeObject(objectList, e1)
    for i, e2 in ipairs(objectList) do
        if e1 == e2 then
            table.remove(objectList, i)
            return objectList
        end
    end
end

--Insertion sort, efficient with high temporal coherence between frames
local function sortObjects(objectList, getBounds)
    local function compare(e1, e2)
        return getBounds(e1).start > getBounds(e2).start
    end

    for j = 2, #objectList do
        local key = objectList[j]
        local i = j - 1
        while i > 0 and compare(objectList[i], key) do
            objectList[i + 1] = objectList[i]
            i = i - 1
        end
        objectList[i + 1] = key
    end

    return objectList
end

local function getBoundingRadius(e)
    --Get diagonal length using Pythagorean theorem
    return 0.5 * math.sqrt(e.size.w ^ 2 + e.size.h ^ 2)
end

local function getHorizontalBounds(e)
    local radius = getBoundingRadius(e)
    return {start = e.position.x - radius, stop = e.position.x + radius}
end

local function getVerticalBounds(e)
    local radius = getBoundingRadius(e)
    return {start = e.position.y - radius, stop = e.position.y + radius}
end

local function sweep(objectList, getBounds)
    local collisionList = {}
    local activeList = {objectList[1]}

    for i = 2, #objectList do
        local j = 1
        while j <= #activeList do
            local start = getBounds(objectList[i]).start
            local stop = getBounds(activeList[j]).stop

            if start > stop then
                table.remove(activeList, j)
            else
                table.insert(collisionList, {e1 = objectList[i], e2 = activeList[j]})
                j = j + 1
            end
        end

        table.insert(activeList, objectList[i])
    end

    return collisionList
end

local function collisionIntersection(a, b)
    local function compareCollisions(c1, c2)
        return (c1.e1 == c2.e1 and c1.e2 == c2.e2) or (c1.e2 == c2.e1 and c1.e1 == c2.e2)
    end

    local collisions = {}

    for i, c1 in ipairs(a) do
        for j, c2 in ipairs(b) do
            if compareCollisions(c1, c2) then
                table.insert(collisions, c1)
            end
        end
    end

    return collisions
end

local function createCollisionSystem()
    local collisionSystem = tiny.system()
    collisionSystem.filter = tiny.requireAll("position", "size", tiny.rejectAny("background", "particle"))

    local horizontalList = {}
    local verticalList = {}

    function collisionSystem:onAdd(e)
        insertObject(horizontalList, e, getHorizontalBounds)
        insertObject(verticalList, e, getVerticalBounds)
    end

    function collisionSystem:onRemove(e)
        removeObject(horizontalList, e)
        removeObject(verticalList, e)
    end

    local foo = 0

    function collisionSystem:update(dt) 
        sortObjects(horizontalList, getHorizontalBounds)
        sortObjects(verticalList, getVerticalBounds)

        if #self.entities >= 2 then
            local horizontalCollisions = sweep(horizontalList, getHorizontalBounds)
            local verticalCollisions = sweep(verticalList, getVerticalBounds)
            local finalCollisions = collisionIntersection(horizontalCollisions, verticalCollisions)

            if #finalCollisions >= 1 then
                print(foo)
                foo = foo + 1
            end
        end
    end

    return collisionSystem
end

return createCollisionSystem
