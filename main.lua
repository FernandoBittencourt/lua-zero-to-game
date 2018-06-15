plane_14bis = {
	src = "images/14bis.png",
	height = 64,
	width = 64
}

function love.load()
	love.window.setMode(320, 480, {resizable =false})
	love.window.setTitle("14 bis vs meteor")

	background = love.graphics.newImage("images/background.png")
	plane_14bis.image = love.graphics.newImage(plane_14bis.src)

    x, y, w, h = 20, 20, 60, 20
end

function love.update(dt)
	if love.keyboard.isDown('w') then
		y = y - 1
	end
	if love.keyboard.isDown('s') then
		y = y + 1
	end
	if love.keyboard.isDown('a') then
		x = x - 1
	end
	if love.keyboard.isDown('d') then
		x = x + 1
	end
end

function love.draw()
	love.graphics.draw(background, 0, 0)	
	love.graphics.draw(plane_14bis.image, x, y)
end