Phone = Class{__includes = Object;
	init = function(self, icon, phone, nonno)
		local width = phone:getWidth()
		local height = phone:getHeight()
		Object.init(self, x, y, width, height)
		
		table.insert(self.children, Image(phone, 0, 0))
	end
}