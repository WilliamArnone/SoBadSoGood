local LERP_AMOUNT = 0.4
local SCALE_HIGHLIGHT = 1.2
local SCALE_MOUSEDOWN = 0.8

Button = Class{__includes = Object;
	init = function(self, sprite, x, y, text, callback)
		if sprite then
			self.image = Image(sprite, 0, 0)
		end

		if text then
			self.text = Text(text)
		end

		local width = sprite:getWidth()
		local height = sprite:getHeight()
		Object.init(self, x, y, width, height)
		self.callback = callback

		self.enabled = true
		self.highlighted = false
		self.mousedown = false
		self.color = color or {1, 1, 1, 1}

		self.scalehighlight = SCALE_HIGHLIGHT
		self.scalemousedown = SCALE_MOUSEDOWN

		Signal.register("mousedown", function() if self.highlighted then self.mousedown = true end end)
		Signal.register("mouseup", function() self.mousedown = false end)
		Signal.register("click", function() if self.mousedown and self.callback then self.callback() end end)
	end;

	draw = function(self, dx, dy, a)
		dx = dx or 0
		dy = dy or 0
		
		if self.image then
			self.image:draw(dx + self.x, dy + self.y, a * self.color[4])
		end

		if self.text then
			self.text:draw(dx + self.x, dy + self.y, a * self.color[4])
		end

		Object.draw(self, dx, dy, a * self.color[4])
	end;

	update = function(self, dt)
		local x, y = love.mouse.getPosition()
		x, y = push:toGame(x, y)
		
		self.highlighted = self.enabled and x and y and self:isinside(x, y)
		self.mousedown = self.mousedown and self.highlighted

		if self.mousedown and self.image then
			self.image.scale = lume.smooth(self.image.scale, SCALE_MOUSEDOWN, LERP_AMOUNT)
			return
		elseif self.highlighted and self.image then
			self.image.scale = lume.smooth(self.image.scale, SCALE_HIGHLIGHT, LERP_AMOUNT)
			return 
		elseif self.image then
			self.image.scale = lume.smooth(self.image.scale, 1, LERP_AMOUNT)
		end

		Object.update(self, dt)
	end;
}