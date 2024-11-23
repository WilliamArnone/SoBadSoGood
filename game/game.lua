local game = {}

function game:enter()
	Signal.clear('mousedown')
	Signal.clear('mouseup')
	Signal.clear('mouseclick')

	table.insert(objects, Image(images.background, 960, 540))
	table.insert(objects, Image(images.soldibg, 130, 320))
	table.insert(objects, Image(images.soldiicon, 60, 320))
	table.insert(objects, Image(images.legenda, 130, 740))
	--table.insert(objects, Button(images.cards, 960, 540))

love.audio.stop() -- Stop any currently playing audio
sounds.music:setLooping(true) -- Set the music to loop
love.audio.play(sounds.music) -- Play the music

	initLogic()
	generaNonno()
end


function game:draw()
	push:start()

	for _, obj in pairs(objects) do 
		if obj.visible then
			obj:draw(0, 0, 1)
		end
	end

	push:finish()
end

local lastMouseDown

function game:mousepressed()
	Signal.emit('mousedown')
	lastMouseDown = love.timer.getTime()
end

function game:mousereleased()
	if love.timer.getTime() - lastMouseDown < 0.2 then
		print("CLICCO")
		Signal.emit('click')
	end
	Signal.emit('mouseup', x,y, dx,dy)

end

function game:update(dt)
	require("./../libs/lurker").update()
	flux.update(dt)
    Timer.update(dt)

	logicLoop(dt)

	for _, obj in pairs(objects) do if obj.update ~= nil then obj:update(dt) end end
end

function game:keyreleased()
	generaNonno()
end

return game