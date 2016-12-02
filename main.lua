platform = {}
player = {}

level1 = {{0,0,0,0,0,0,0,0,0,0,0,0,0},
		  {0,0,0,0,0,0,0,0,0,0,0,0,0},
		  {0,0,1,1,1,1,0,0,1,1,0,0,0},
		  {0,0,1,0,1,1,1,1,0,0,0,0,0},
		  {0,0,1,0,1,0,1,0,0,1,0,0,0},
		  {0,0,1,0,1,0,1,1,1,1,1,0,0},
		  {0,0,1,1,0,1,1,0,0,1,1,0,0},
		  {0,0,1,1,1,1,1,1,1,1,0,0,0},
		  {0,0,0,0,0,1,0,0,1,1,1,0,0},
		  {0,0,0,0,0,1,0,1,1,1,1,0,0},
		  {0,0,0,0,0,0,0,0,1,1,1,0,0},
		  {0,0,0,0,0,0,0,0,0,0,0,0,0},
		  {0,0,0,0,0,0,0,0,0,0,0,0,0}}

delay = 0
interval = 1000
-- only loaded once at start
function love.load()
	food = 48
	enemy_distance = 5

	love.graphics.setNewFont(16)

	platform.width = love.graphics.getWidth()
	platform.height = love.graphics.getHeight() - 17

	cell_height = (love.graphics.getHeight() - 17) / 5
	cell_width = love.graphics.getWidth() /5

	platform.x = 0
	platform.y = 17

	player.x = 3
	player.y = 3
	player.img = love.graphics.newImage("img/pac.png")

	key = ""

	love.graphics.setColor(255,255,255);
end

function love.keypressed(key)
	if key == 'up' then
		if (player.y > 1) then
			if level1[player.y - 1][player.x] ~= 0 then
				player.y  = player.y - 1
			end
		end
	elseif key == 'down' then
		if (player.y < 13 and level1[player.y + 1][player.x] ~= 0) then
			player.y = player.y + 1
		end
	elseif key == 'left' then
		if (player.x > 1) then
			if (level1[player.y][player.x - 1] ~= 0) then
				player.x = player.x - 1
			end
		end
	elseif key =='right' then
			if (player.x < 13 and level1[player.y][player.x + 1] ~= 0) then
			player.x = player.x + 1
		end
	end

end

function love.draw()
	love.graphics.printf("Food left: " .. food .. 
		" --- Enemy distance: " .. enemy_distance .. " player.x " .. player.x 
		.. " player.y " .. player.y, 0, 0, platform.width, "center")
	love.graphics.printf(key, 0, 0, platform.width, "center")
	for i=-2,2 do
		for j=-2,2 do
			if level1[player.y + i][player.x + j] == 0 then
				love.graphics.setColor(67,23,125)
				love.graphics.rectangle('fill', platform.x, platform.y, cell_width, cell_height)
			elseif level1[player.y + i][player.x + j] == 1 then 
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
	love.graphics.draw(player.img,cell_width*2 + (cell_width - 85) / 2, cell_height*2 +17 + (cell_height - 85) / 2, 0,1,1,0,0)


end