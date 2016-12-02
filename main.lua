require 'src/list'
require 'src/pathfinding'

platform = {}
player = {}
ghost = {}
is_over = false

level1 = {{0,0,0,0,0,0,0,0,0,0,0,0,0},
          {0,0,0,0,0,0,0,0,0,0,0,0,0},
          {0,0,2,1,1,1,0,0,1,1,0,0,0},
          {0,0,1,0,1,1,1,1,1,0,0,0,0},
          {0,0,1,0,1,0,1,0,0,1,0,0,0},
          {0,0,1,0,1,0,1,1,1,1,1,0,0},
          {0,0,1,1,0,1,1,0,0,1,1,0,0},
          {0,0,1,1,1,1,1,1,1,1,0,0,0},
          {0,0,0,0,0,1,0,0,1,1,1,0,0},
          {0,0,0,0,0,1,0,1,1,1,1,0,0},
          {0,0,0,0,0,0,0,0,1,1,1,0,0},
          {0,0,0,0,0,0,0,0,0,0,0,0,0},
          {0,0,0,0,0,0,0,0,0,0,0,0,0}}

status_bar_height = 17
-- only loaded once at start
function love.load()
	score = 0
	food = 48
	enemy_distance = 5

	love.graphics.setNewFont(16)

	platform.width = love.graphics.getWidth()
	platform.height = love.graphics.getHeight() - status_bar_height

	cell_height = (love.graphics.getHeight() - status_bar_height) / 5
	cell_width = love.graphics.getWidth() /5

	platform.x = 0
	platform.y = status_bar_height

	player.x = 3
	player.y = 3
	player.img = love.graphics.newImage("img/pac.png")
	player.food = love.graphics.newImage("img/food.png")

    ghost.x = 5
    ghost.y = 5
    ghost.img = love.graphics.newImage("img/ghost.png")

	key = ""

	love.graphics.setColor(255,255,255);
end

movement = {{1,0},{0,1},{-1,0},{0,-1}}
function update_ghost()
    direction = find_shortest_path_direction(ghost.x, ghost.y, player.x,player.y, level1,13,13)
    if direction ~= 0 then
        ghost.x = movement[direction][1] + ghost.x
        ghost.y = movement[direction][2] + ghost.y
    end

end

function check_game()
    if ghost.x == player.x and ghost.y == player.y then
        is_over = true
    end
end

function love.keypressed(key)
    check_game()
	success = false
	if key == 'up' then
		if (player.y > 1) then
			if level1[player.y - 1][player.x] ~= 0 then
				player.y  = player.y - 1
				success = true
			end
		end
	elseif key == 'down' then
		if (player.y < 13 and level1[player.y + 1][player.x] ~= 0) then
			player.y = player.y + 1
			success = true
		end
	elseif key == 'left' then
		if (player.x > 1) then
			if (level1[player.y][player.x - 1] ~= 0) then
				player.x = player.x - 1
				success = true
			end
		end
	elseif key =='right' then
			if (player.x < 13 and level1[player.y][player.x + 1] ~= 0) then
			player.x = player.x + 1
			success = true
		end
	end

	if success == true and level1[player.y][player.x] ~= 2 then
		level1[player.y][player.x] = 2
		score = score + 1
		food = food - 1
		success = false
        update_ghost()
        check_game()
	end
	
end

function love.draw()
	love.graphics.printf("Score " .. score .. " --- Food left: " .. food, 0, 0, platform.width, "center")
	love.graphics.printf(key, 0, 0, platform.width, "center")
    
	for i=-2,2 do
		for j=-2,2 do
            --local is_ghost = false
            if ((player.y + i) == ghost.y and (player.x + j) == ghost.x) then
                love.graphics.setColor(34,73,56)
                love.graphics.rectangle('fill', platform.x, platform.y, cell_width, cell_height)
                love.graphics.setColor(255,255,255)
                love.graphics.draw(ghost.img, platform.x + (cell_width - 83) / 2, platform.y + (cell_height - 83) / 2, 0,1,1,0,0)
              --  is_ghost = true
			elseif level1[player.y + i][player.x + j] == 0 then
				love.graphics.setColor(67,23,125)
				love.graphics.rectangle('fill', platform.x, platform.y, cell_width, cell_height)
			elseif level1[player.y + i][player.x + j] == 1 then 
				love.graphics.setColor(34,73,56)
				love.graphics.rectangle('fill', platform.x, platform.y, cell_width, cell_height)
				love.graphics.setColor(255,255,255)
			    love.graphics.draw(player.food, platform.x + (cell_width - 83) / 2, platform.y + (cell_height - 83) / 2, 0,1,1,0,0)
			    
            elseif level1[player.y + i][player.x + j] == 2 then 
				love.graphics.setColor(34,73,56)
				love.graphics.rectangle('fill', platform.x, platform.y, cell_width, cell_height)
			else
				love.graphics.setColor(255,255,255)
				love.graphics.rectangle('fill', platform.x, platform.y, cell_width, cell_height)
			end

			platform.x = platform.x + cell_width
		end
		platform.x = 0
		platform.y = platform.y + cell_height
	end
	platform.y = 17
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(player.img,cell_width*2 + (cell_width - 85) / 2, cell_height*2 +status_bar_height + (cell_height - 85) / 2, 0,1,1,0,0)

    if is_over then


        love.graphics.setColor(0,0,0)
        love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        
        love.graphics.setNewFont(30)
        love.graphics.setColor(255,255,255)
        love.graphics.printf("Game Over", 0, love.graphics.getHeight() / 2 - 30, platform.width, "center")
        
        love.graphics.printf("Score " .. score, 0, love.graphics.getHeight() / 2 + 30, platform.width, "center")


    end   

end