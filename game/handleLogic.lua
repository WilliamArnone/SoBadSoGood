
objects = {}

local soldiLabel

function initLogic()
	data = {
		soldi = 0,
		nonni = {}
	}

	soldiLabel = Text("0", 160, 320, fonts.default, {0, 0, 0, 1})
	table.insert(objects, soldiLabel)
end

function logicLoop(dt)

end


function generaNonno()
	local nonno = {
		level = 1,
		happiness = 5
	}

	table.insert(data.nonni, nonno)
	local i = math.min(#data.nonni, 2)
	local phone = Phone(images.nonniPic[i].normal, images.phoneNonno[i], #data.nonni)
	local profilePic = NonnoPic(#data.nonni, images.nonniPic[i].happy, images.nonniPic[i].normal, images.nonniPic[i].sad, 360 + (i - 1) * 660, 140)

	phone.x = 1920 / (#data.nonni + 1)
	phone.y = 2000

	table.insert(objects, phone)
	table.insert(objects, profilePic)
end

Signal.register("chatMessage", function(nonnoIndex)
	data.soldi = data.soldi + data.nonni[nonnoIndex].level
	soldiLabel.text:set(tostring(data.soldi))
	print(data.soldi)
end)