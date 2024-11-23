local game = {}
local objects = {}

data = {}
local phones = {}

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

	--table.insert(objects, Button(images.cards, 960, 540))

	data = {
		soldi = 0,
		nonni = {
			generaNonno()
		}
	}

	local phone = Phone(nil, images.phoneNonno, data.nonni[1])
	table.insert(phones, phone)
	table.insert(objects, phone)

	phone.x = 1920 / (#phones + 1)
	phone.y = 1080 / 2
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
	flux.update(dt)

	for _, obj in pairs(objects) do if obj.draw ~= nil then obj:update(dt) end end
end

return game