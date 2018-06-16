WIDTH_SCREEN = 320
HEIGHT_SCREEN = 480
MAX_METEOR = 12

plane_14bis = {
	src = "images/14bis.png",
	height = 64,
	width = 64,
	x = WIDTH_SCREEN/2 - 64 / 2, 
	y = HEIGHT_SCREEN - 64 / 2
}

meteors = {}

function createMeteor()
	meteor = {
		x = math.random(WIDTH_SCREEN),
		y = 0
	}
	table.insert(meteors,meteor)
end

function moveMeteor()
	for k, meteor in pairs(meteors) do
		meteor.y = meteor.y +1;
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

function love.load()
	love.window.setMode(WIDTH_SCREEN, HEIGHT_SCREEN, {resizable =false})
	love.window.setTitle("14 bis vs meteor")

	background = love.graphics.newImage("images/background.png")
	plane_14bis.image = love.graphics.newImage(plane_14bis.src)
	meteor_img = love.graphics.newImage("images/meteor.png")

end

function love.update(dt)
	if love.keyboard.isDown('w','a','s','d') then
		move14bis()
	end

	removeMeteors()
	if #meteors < MAX_METEOR then
		createMeteor()
	end
	moveMeteor()
end

function love.draw()
	love.graphics.draw(background, 0, 0)	
	love.graphics.draw(plane_14bis.image, plane_14bis.x, plane_14bis.y)
	for k,meteor in pairs(meteors) do
		love.graphics.draw(meteor_img, meteor.x, meteor.y)
	end
end