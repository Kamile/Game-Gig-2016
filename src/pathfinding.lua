
function find_shortest_path_direction(sx, sy, tx, ty, map, width, height)
    if (sx == tx and sy == ty) then
        return 0
    end
    local visited = {}
    for y = 1, height do
        visited[y] = {}
        for x = 1, width do
            visited[y][x] = 0
        end
    end
    visited[sy][sx] = 1

    local queue = List.new()

    local movement = {{1,0},{0,1},{-1,0},{0,-1}}

    for i = 1, 4 do
        local data = {}
        data[1] = sx + movement[i][1]
        data[2] = sy + movement[i][2]
        data[3] = i
        List.pushright(queue, data)
    end 


    while queue.first <= queue.last do

        local current = {}
        current = List.popleft(queue)
        --print (current[1] .. "-" .. current[2] .. "-" .. current[3])

        if current[1] == tx and current[2] == ty then
            return current[3]
        end
        if current[1] >= 1 and current[1] <= width and current[2] >= 1 and current[2] <= height and visited[current[2]][current[1]] == 0 and map[current[2]][current[1]] > 0 then
            visited[current[2]][current[1]] = 1

            for i = 1, 4 do
                local data = {}
                data[1] = current[1] + movement[i][1]
                data[2] = current[2] + movement[i][2]
                data[3] = current[3]
                List.pushright(queue, data)
            end 

        end
    end
    
end

function find_suboptimal_escape_direction(sx, sy, tx, ty, map, width, height)

end