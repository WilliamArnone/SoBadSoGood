NonnoPic = Class{__includes = Object;
	init = function(self, nonnoIndex, happy, normal, sad, x, y)
		local width = normal:getWidth()
		local height = normal:getHeight()
		Object.init(self, x, y, width, height)
		
		local picX, picY = 0, 0

		self.normal = Image(normal, picX, picY)
		table.insert(self.children, self.normal)

		self.happy = Image(happy, picX, picY)
		table.insert(self.children, self.happy)

		self.sad = Image(sad, picX, picY)
		table.insert(self.children, self.sad)

		self.nonnoIndex = nonnoIndex

		Signal.register("chatNipote", function(nonnoIndex)
			if nonnoIndex ~= self.nonnoIndex then return end

			data.nonni[nonnoIndex].happiness = math.min(data.nonni[nonnoIndex].happiness + 1, 10)
			self:updatePics()
		end)

		Signal.register("nonnoSad", function(nonnoIndex)
			if nonnoIndex ~= self.nonnoIndex then return end

			data.nonni[nonnoIndex].happiness = math.max(data.nonni[nonnoIndex].happiness - 1, 1)
			self:updatePics()
		end)

		Timer.every(3, function() Signal.emit("nonnoSad", self.nonnoIndex) end)
		Timer.after(5/data.nonni[self.nonnoIndex].happiness, function() self:sendMessage() end)
	end;

	sendMessage = function(self)
		Signal.emit("chatNonno", self.nonnoIndex)
		Timer.after(5/data.nonni[self.nonnoIndex].happiness, function() self:sendMessage() end)
	end;

	updatePics = function(self)
		self.happy.visible = data.nonni[self.nonnoIndex].happiness >= 7
		self.normal.visible = data.nonni[self.nonnoIndex].happiness < 7 and data.nonni[self.nonnoIndex].happiness > 3
		self.sad.visible = data.nonni[self.nonnoIndex].happiness <= 3
	end;

	draw = function(self, dx, dy, a, s)
		dx = dx or 0
		dy = dy or 0
		a = a ~= nil and a or 1
		s = s or 1

		love.graphics.setColor({1, 1, 1, 1})	
		--love.graphics.draw(self.happ, self.x + dx, self.y + dy, nil, self.scale * s, self.scale * s, self.width/2, self.height/2)

		Object.draw(self, dx, dy, a, s)
	end;
}