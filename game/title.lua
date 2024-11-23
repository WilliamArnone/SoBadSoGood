title = {}

function title:draw()
	push:start()
    	love.graphics.print("Press Enter to continue", 960, 540)
	push:finish()
end

function title:keyreleased(key, code)
    if key == 'return' then
        Gamestate.switch(states.game)
    end
end

function title:update(dt)
	require("./../libs/lurker").update()
end

return title