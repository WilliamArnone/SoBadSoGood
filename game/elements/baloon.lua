local function generateRandomContent()
	local type = lume.weightedchoice({ ["chat"] = 30, ["news"] = 15, ["fake"] = 20 })
	return {
		type = type,
		from = "nonno",
		img = lume.randomchoice(images[type])
	}

end

local function generateRandomNipote()

	return {
		type = "chat",
		from = "nipote",
		img = lume.randomchoice(images.chat)
	}

end

Baloon = Class{__includes = Button;
	init = function(self, nonnoIndex)
		self.nonnoIndex = nonnoIndex

		self.cancel = nil

		Button.init(self, images.baloon, 0, 0, nil, function()
			if self.highlighted and self.content then
				if self.content.from == "nipote" then
				elseif self.content.type == "chat" then
					Signal.emit("chatMessage", self.nonnoIndex)
				elseif self.content.type == "fake" then
					Signal.emit("chatWrong", self.nonnoIndex)
					love.audio.play(sounds.wrong)
				elseif self.content.type == "news" then
					Signal.emit("chatRight", self.nonnoIndex)
					love.audio.play(sounds.right)
				end

				self:exitMessage()
			end
		end)
		-- Signal.register("click", function()
		-- 	if self.highlighted then
		-- 		print("EXIT")
		-- 		self:exitMessage()
		-- 	end
		-- end)

		self.allegato = Image(images.chat[1], 0, 0)
		self.allegato.scale = 0.8
		table.insert(self.image.children, self.allegato)
		self.content = nil

		self.close = Button(images.close, 190, -80, nil, function()
			self:exitMessage()
		end)
		table.insert(self.children, self.close)
		self.close.visible = false
		self.close.enabled = false


		self.enabled = false
		self.image.a = 0
		
		Signal.register("chatNonno", function(nonnoIndex)
			if nonnoIndex ~= self.nonnoIndex then return end
			
			if not self.content then
				self:enterMessage(generateRandomContent())
			end
		end)

		Signal.register("chatNipote", function(nonnoIndex)
			if self.nonnoIndex ~= nonnoIndex then return end

			self:enterMessage(generateRandomNipote())
		end)
	end;
	
	enterMessage = function(self, message)
		self.enabled = false
		if self.tween and self.tween.cancel then
			self.tween:cancel()
			self.tween = nil
		end

		if self.content then
			self:exitMessage(function() self:enterMessage(message) end)
			return
		end

		self.image.y = 100
		self.allegato.sprite = message.img
		self.content = message
		self.image.sprite = message.from == "nonno" and images.baloon or images.baloonPlayer
		self.close.visible = message.type ~= "chat"
		self.close.enabled = message.type ~= "chat"
		self.tween = flux.to(self.image, 0.1, {y = 0, a = 1}):oncomplete(function()
			self.tween = nil
			if self.content and self.content.from == "nipote" then
				self.timer = Timer.after(1, function() self:exitMessage() end)
			end 
			self.enabled = true 
		end)
	end;

	exitMessage = function(self, callback)
		self.close.visible = false
		self.close.enabled = false
		self.enabled = false
		if self.tween and self.tween.cancel then
			self.tween:cancel()
			self.tween = nil
		end

		if self.timer then
			Timer.cancel(self.timer) -- self.timer:cancel()
			self.timer = nil
		end
		
		if not self.content then
			if callback then
				callback()
			end
		else
			self.content = nil
			self.tween = flux.to(self.image, 0.1, {y = -100, a = 0}):oncomplete(function()
				self.cancel = nil
				if callback then
					callback()
				end
			end)
		end
	end;
}