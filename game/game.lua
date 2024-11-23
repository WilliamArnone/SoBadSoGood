local game = {}
local objects = {}

data = {}

local function generaNonno()
	local nonno = {
		happiness = 5,
		nipoti = {}
	}
	return nonno
end

function game:enter()
	Signal.clear('mousedown')
	Signal.clear('mouseup')
	Signal.clear('mouseclick')

	table.insert(objects, Button(images.cards, 960, 540))

	data = {
		soldi = 0,
		nonni = {
			generaNonno()
		}
	}
end


function game:draw()
	push:start()

	for _, obj in pairs(objects) do obj:draw(0, 0, 1) end

	push:finish()
end

local lastMouseDown

function game:mousepressed()
	Signal.emit('mousedown')
	lastMouseDown = love.timer.getTime()
end

function game:mousereleased()
	Signal.emit('mouseup', x,y, dx,dy)
	if love.timer.getTime() - lastMouseDown < 0.2 then
		Signal.emit('click')
	end

end

function game:update(dt)
	require("./../libs/lurker").update()

	for _, obj in pairs(objects) do if obj.draw ~= nil then obj:update(dt) end end
end

return game