lume = require "libs.lume"
camera = require "libs.hump.camera"
Gamestate = require "libs.hump.gamestate"
Class = require "libs.hump.class"
Signal = require 'libs.hump.signal'
push = require "libs.push"
flux = require "flux"

require "game.ui.object"
require "game.ui.image"
require "game.ui.text"
require "game.ui.button"

require "game.elements.phone"

images = {}
fonts = {}
states = {}

function love.load()	
	local gameWidth, gameHeight = 1920, 1080 --fixed game resolution
	local windowWidth, windowHeight = love.window.getDesktopDimensions()
	windowWidth, windowHeight = windowWidth*.7, windowHeight*.7 --make the window a bit smaller than the screen itself

	-- STATES
	states.title = require "game.title"
	states.game = require "game.game"

	-- IMAGES
	images.phoneNonno = love.graphics.newImage("assets/img/UI/telefono_nonno.png")
	images.baloon = love.graphics.newImage("assets/img/UI/balloon.png")
	images.baloonPlayer = love.graphics.newImage("assets/img/UI/balloon_player.png")


	-- FONTS
	fonts.default = love.graphics.getFont()


	push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, resizable = true})
    Gamestate.registerEvents()
    Gamestate.switch(states.game)
end

function love.resize(w, h)
	return push:resize(w, h)
end