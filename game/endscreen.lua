local endscreen = {}


function endscreen:draw()
	push:start()
    	love.graphics.print("Press Enter to continue", 960, 540)
	push:finish()
end

function endscreen:update(dt)
	require("./../libs/lurker").update()
end

return endscreen