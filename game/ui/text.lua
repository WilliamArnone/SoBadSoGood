Text = Class{__includes = Object;
	init = function(self, text, x, y, font, color)
		self.text = love.graphics.newText(font, text)
		local width = self.text: getWidth()
		local height = self.text:getHeight()
		
		Object.init(self, x, y, width, height)
		self.color = color or {1, 1, 1, 1}
	end;
	draw = function(self, dx, dy, a)
		dx = dx or 0
		dy = dy or 0
		a = a ~= nil and a or 1

		love.graphics.setColor({self.color[1], self.color[2], self.color[3], self.color[4] * a})
		love.graphics.draw(self.sprite, self.x + dx, self.y + dy, nil, self.scale, self.scale, self.width/2, self.height/2)

		Object.draw(self, dx, dy, a * self.color[4])
	end;
}