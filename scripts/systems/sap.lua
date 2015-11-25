--sap.lua

--Sweep and Prune algorithm for broad-phase collision detection
local function createSAP()
    --Continually updated arrays with collidables sorted by starting points projected on X/Y axis
    local horizontalProjection = {}
    local verticalProjection = {}

    local function setBoundingSphereRadius(e)
        --Set diagonal length using Pythagorean theorem
        e.size.boundingSphereRadius = 0.5 * math.sqrt(e.size.w ^ 2 + e.size.h ^ 2)
    end

    local function setBoundingSphereCenter(e)
        e.position.boundingSphereCenter = {
            x = e.position.x + (0.5 * e.size.w),
            y = e.position.y + (0.5 * e.size.h)
        }
    end

    local function getBounds(e, key)
        if e.size.boundingSphereRadius == nil then
            setBoundingSphereRadius(e)
        end

        if e.size.boundingSphereCenter == nil then
            setBoundingSphereCenter(e)
        end

        local radius = e.size.boundingSphereRadius
        local center = e.position.boundingSphereCenter

        return {start = center[key] - radius, stop = center[key] + radius}
    end

    --Insertion sort, efficient with high temporal coherence between frames (O(n) for nearly sorted arrays)
    local function sortProjection(projection, key)
        local function compare(e1, e2)
            return getBounds(e1, key).start > getBounds(e2, key).start
        end

        for j = 2, #projection do
            local e = projection[j]
            local i = j - 1
            while i > 0 and compare(projection[i], e) do
                projection[i + 1] = projection[i]
                i = i - 1
            end
            projection[i + 1] = e
        end

        return projection
    end

    local function insert(projection, e1)
        table.insert(projection, e1)
    end

    local function remove(projection, e1)
        for i, e2 in ipairs(projection) do
            if e1 == e2 then
                table.remove(projection, i)
                return projection
            end
        end
    end

    local function sweep(projection, key)
        local intersections = {}

        if #projection > 1 then
            local active = {projection[1]}

            for i = 2, #projection do
                local j = 1
                while j <= #active do
                    local start = getBounds(projection[i], key).start
                    local stop = getBounds(active[j], key).stop

                    if start > stop then
                        table.remove(active, j)
                    else
                        table.insert(intersections, {projection[i], active[j]})
                        j = j + 1
                    end
                end

                table.insert(active, projection[i])
            end
        end

        return intersections
    end

    local function prune(horizontalIntersections, verticalIntersections)
        local function compare(c1, c2)
            return (c1[1] == c2[1] and c1[2] == c2[2])
                or (c1[2] == c2[1] and c1[1] == c2[2])
        end

        local candidates = {}

        for _, c1 in ipairs(horizontalIntersections) do
            for _, c2 in ipairs(verticalIntersections) do
                if compare(c1, c2) then
                    table.insert(candidates, c1)
                end
            end
        end

        return candidates
    end

    return {
        insertEntity = function(e)
            insert(horizontalProjection, e)
            insert(verticalProjection, e)
        end,

        removeEntity = function(e)
            remove(horizontalProjection, e)
            remove(verticalProjection, e)
        end,

        getCandidates = function()
            sortProjection(horizontalProjection, "x")
            sortProjection(verticalProjection, "y")

            local horizontalIntersections = sweep(horizontalProjection, "x")
            local verticalIntersections = sweep(verticalProjection, "y")

            return prune(horizontalIntersections, verticalIntersections)
        end
    }
end

return createSAP
