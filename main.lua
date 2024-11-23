lume = require "libs.lume"
anim8 = require "libs.anim8"
bf = require "libs.breezefield"
camera = require "libs.hump.camera"
sti = require "libs.sti"

local push = require "libs.push"

images = {}
animations = {}

function love.load()
	love.graphics.setDefaultFilter("nearest")

	cam = camera()
	cam:zoom(3)
	cam.smoother = camera.smooth.linear(100)
	
	local gameWidth, gameHeight = 720, 640 --fixed game resolution
	local windowWidth, windowHeight = love.window.getDesktopDimensions()
	windowWidth, windowHeight = windowWidth*.7, windowHeight*.7 --make the window a bit smaller than the screen itself

	push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, resizable = true})


	images.cards = love.graphics.newImage("assets/img/cards.png")
	local g = anim8.newGrid(90, 126, images.cards:getWidth(), images.cards:getHeight())
	local frames = g:getFrames("2-4", 1)
	animations.cards = anim8.newAnimation(frames, 0.5)


	map = sti("assets/maps/map_test.lua", {})
	
	-- world = bf.newWorld(0, 90.81, true)
	-- -- bf.World:new also works
	-- -- any function of love.physics.world should work on World
	-- print(world:getGravity())
	
	-- ground = world:newCollider("Polygon",{0, 550, 650, 550 , 650, 650, 0, 650})
	-- ground:setType("static")
	
	-- ball = world:newCollider("Circle", {325, 325, 20})
	
	-- ball:setRestitution(0.8) -- any function of shape/body/fixture works
	-- block1 = bf.Collider.new(world, "Polygon", {150, 375, 250, 375,
	-- 250, 425, 150, 425})
	
end

function love.resize(w, h)
	return push:resize(w, h)
end

function love.update(dt)
	require("libs.lurker").update()

	--world:update(dt)
	-- if love.keyboard.isDown("right") then
	--  	ball:applyForce(400, 0)
   	-- elseif love.keyboard.isDown("left") then
	--  	ball:applyForce(-400, 0)
   	-- elseif love.keyboard.isDown("up") then
	--  	ball:setPosition(325, 325)
	--  	ball:setLinearVelocity(0, 0) 
   	-- elseif love.keyboard.isDown("down") then
	--   	ball:applyForce(0, 600)
	-- end

	for v in pairs(animations) do
		animations[v]:update(dt)
	end
	x = x and x + dt * 100 or 0
	y = y and y + dt * 100 or 0
	cam:lookAt(x, y)
end

function love.draw()
	--world:draw()
	love.graphics.clear(1,1,1)
	push:start()
	cam:attach()
		map:drawLayer(map.layers["Tile Layer 1"])
		for v in pairs(animations) do
			animations[v]:draw(images[v], 256, 256)
		end
	cam:detach()
	push:finish()
end