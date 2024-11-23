Object = Class{
	init = function(self, x, y, width, height)
		self.x = x or 0
		self.y = y or 0
		self.width = width or 1
		self.height = height or 1
		self.scale = 1
		self.children = {}
		self.visible = true
	end;

	draw = function(self, dx, dy, a)
		dx = dx or 0
		dy = dy or 0
		--love.graphics.rectangle(dx + self.x - self.width * self.scale/2, dy + self.y - self.height*self.scale/2, self.width*self.scale, self.height*self.scale)
		for _, child in ipairs(self.children) do
			child:draw(dx + self.x, dy + self.y, a)
		end
	end;

	isinside = function(self, x, y, dx, dy)
		dx = dx or 0
		dy = dy or 0
		return (x > dx + self.x - self.width * self.scale / 2 
			and y > dy + self.y - self.height * self.scale / 2
			and x < dx + self.x + self.width * self.scale / 2 
			and y < dy + self.y + self.height * self.scale / 2)
			or lume.any(self.children, function(elem) elem:isinside(x, y, dx, dy) end)
	end;

	update = function(self, dt)
		for _, child in ipairs(self.children) do
			child:update(dt)
		end
	end
}