function love.load()
	love.window.setMode(320, 480, {resizable =false})
	love.window.setTitle("14 bis vs meteor")

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
    love.graphics.setColor(0, 0.4, 0.4)
    love.graphics.rectangle("fill", x, y, w, h)
end