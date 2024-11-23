Text = Class{__includes = Object;
	init = function(self, text, x, y, font, color)
		self.text = love.graphics.newText(font, text)
		local width = self.text:getWidth()
		local height = self.text:getHeight()
		
		Object.init(self, x, y, width, height)
		self.color = color or {1, 1, 1, 1}
	end;
	draw = function(self, dx, dy, a, s)
		dx = dx or 0
		dy = dy or 0
		a = a ~= nil and a or 1
		s = s or 1

		love.graphics.setColor({self.color[1], self.color[2], self.color[3], self.color[4]})
		love.graphics.draw(self.text, self.x + dx, self.y + dy, nil, self.scale * s, self.scale * s, self.width/2, self.height/2)

		Object.draw(self, dx, dy, a * self.color[4], s)
	end;
}