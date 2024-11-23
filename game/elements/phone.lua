Phone = Class{__includes = Object;
	init = function(self, icon, phone, nonnoIndex)
		local width = phone:getWidth()
		local height = phone:getHeight()
		Object.init(self, x, y, width, height)

		table.insert(self.children, Image(phone, 0, 0))

		self.baloon = Baloon(nonnoIndex)
		table.insert(self.children, self.baloon)
		self.nonnoIndex = nonnoIndex

		self.nonnoLevel = Text("Lv."..tostring(data.nonni[nonnoIndex].level), 130, -320, fonts.default, {0, 0, 0, 1})
		table.insert(self.children, self.nonnoLevel)

		self.sendMessage = Button(images.sendMessage, 180, 270, nil, function()
			Signal.emit("chatNipote", self.nonnoIndex)
		end)
		table.insert(self.children, self.sendMessage)

		-- self.upgrade = Button(images.upgrade, 0, 0, nil, function()
		-- 	--controlla soldi, crea nipoti se va bene
		-- 	if data.nonni[self.nonnoIndex].level >= 10 then return end
		-- 	Signal.emit("upgrade", self.nonnoIndex)
		-- end)
		-- table.insert(self.children, self.upgrade)

		Signal.register("chatRight", function(nonnoIndex)
			if self.nonnoIndex ~= nonnoIndex then return end

			data.nonni[nonnoIndex].level = data.nonni[nonnoIndex].level + 1
			self.nonnoLevel.text:set("Lv."..tostring(data.nonni[nonnoIndex].level))
		end)

		Signal.register("chatWrong", function(nonnoIndex)
			if self.nonnoIndex ~= nonnoIndex then return end
			
			data.nonni[nonnoIndex].level = math.max(data.nonni[nonnoIndex].level - 1, 1)
			self.nonnoLevel.text:set("Lv."..tostring(data.nonni[nonnoIndex].level))
		end)
	end;
	update = function(self, dt, dx, dy)
		self.x = lume.smooth(self.x, self.nonnoIndex / (#data.nonni + 1) * 1920, 40 * dt)
		self.y = lume.smooth(self.y, 1080 / 2, 40 * dt)

		Object.update(self, dt, dx, dy)
	end
}