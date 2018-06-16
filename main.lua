WIDTH_SCREEN = 320
HEIGHT_SCREEN = 480
MAX_METEOR = 12
END_GAME = false

plane_14bis = {
	src = "images/14bis.png",
	height = 63,
	width = 55,
	x = WIDTH_SCREEN/2 - 64 / 2, 
	y = HEIGHT_SCREEN - 64 / 2,
	shots = {}
}

function destroy14bis()
	plane_14bis.src = "images/explosion.png"
	plane_14bis.image = love.graphics.newImage(plane_14bis.src)
	plane_14bis.width = 67
	plane_14bis.height = 77

	music_destruction:play()
	changeMusic()

	END_GAME = true
end

function changeMusic()
	music_environment:stop()
	music_gameover:play()
end

function hasACollision(x1, y1, w1, h1 ,x2 , y2, w2, h2)
	return x2 < x1 + w1 and
	 x1< x2 + w2 and
	 y1 < y2 + h2 and
	 y2 < y1 + h1
end

meteors = {}

function createMeteor()
	meteor = {
		x = math.random(WIDTH_SCREEN),
		y = -70,
		height = 44,
		width = 50,
		weight = math.random(3),
		horizontal_displacement = math.random(-1,1)
	}
	table.insert(meteors,meteor)
end

function moveMeteor()
	for k, meteor in pairs(meteors) do
		meteor.y = meteor.y + meteor.weight;
		meteor.x = meteor.x + meteor.horizontal_displacement;
	end
end

function removeMeteors()
	for i = #meteors, 1, -1 do
		if meteors[i].y > HEIGHT_SCREEN then
			table.remove(meteors, i)
		end
	end
end

function move14bis()
	if love.keyboard.isDown('w') then
		plane_14bis.y = plane_14bis.y - 1
	end
	if love.keyboard.isDown('s') then
		plane_14bis.y = plane_14bis.y + 1
	end
	if love.keyboard.isDown('a') then
		plane_14bis.x = plane_14bis.x - 1
	end
	if love.keyboard.isDown('d') then
		plane_14bis.x = plane_14bis.x + 1
	end
end

function shot()
	local shot = {
		x = plane_14bis.x + plane_14bis.width/2,
		y = plane_14bis.y,
		height = 16,
		width = 16
	}

	table.insert(plane_14bis.shots, shot)
	music_shot:play()
end

function moveShots()
	for i = #plane_14bis.shots, 1, -1 do
		if plane_14bis.shots[i].y > 0 then
			plane_14bis.shots[i].y = plane_14bis.shots[i].y - 1
		else
			table.remove(plane_14bis.shots, i)
		end
	end
end

function checkCollisionWithPlane()
	for k, meteor in pairs(meteors) do
		if hasACollision(meteor.x, meteor.y, meteor.width, meteor.height,
			plane_14bis.x, plane_14bis.y, plane_14bis.width, plane_14bis.height) then
			destroy14bis()
		end
	end
end
function checkCollisionWithShots()
	for i = #plane_14bis.shots, 1 , -1 do
		for j = #meteors, 1 , -1 do
			if hasACollision(plane_14bis.shots[i].x, plane_14bis.shots[i].y, plane_14bis.shots[i].width, plane_14bis.shots[i].height,
				meteors[j].x, meteors[j].y, meteors[j].width, meteors[j].height) then
				table.remove(plane_14bis.shots, i)
				table.remove(meteors, j)
				break
			end
		end
	end
end
function checkCollision()
	checkCollisionWithPlane()
	checkCollisionWithShots()
end
function love.load()
	love.window.setMode(WIDTH_SCREEN, HEIGHT_SCREEN, {resizable =false})
	love.window.setTitle("14 bis vs meteor")

	math.randomseed(os.time())

	background = love.graphics.newImage("images/background.png")
	plane_14bis.image = love.graphics.newImage(plane_14bis.src)
	meteor_img = love.graphics.newImage("images/meteor.png")
	shot_img = love.graphics.newImage("images/shot.png")
	gameover_img = love.graphics.newImage("images/gameover.png")

	music_environment = love.audio.newSource("musics/environment.wav","static")
	music_environment:setLooping(true)
	music_environment:play()


	music_destruction = love.audio.newSource("musics/destruction.wav","static")
	music_shot = love.audio.newSource("musics/shot.wav","static")
	music_gameover = love.audio.newSource("musics/game_over.wav","static")
end

function love.update(dt)
	if not END_GAME then
		if love.keyboard.isDown('w','a','s','d') then
			move14bis()
		end

		removeMeteors()
		if #meteors < MAX_METEOR then
			createMeteor()
		end
		moveMeteor()
		moveShots()
		checkCollision()		
	end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	elseif key == "space" then
		if not END_GAME then
			shot()
		end
	end
end

function love.draw()
	love.graphics.draw(background, 0, 0)	
	love.graphics.draw(plane_14bis.image, plane_14bis.x, plane_14bis.y)
	for k,meteor in pairs(meteors) do
		love.graphics.draw(meteor_img, meteor.x, meteor.y)
	end
	for k,shot in pairs(plane_14bis.shots) do
		love.graphics.draw(shot_img, shot.x, shot.y)
	end
	if END_GAME then
		love.graphics.draw(gameover_img, WIDTH_SCREEN/2 - gameover_img:getWidth()/2, HEIGHT_SCREEN/2 - gameover_img:getHeight()/2)
	end
end