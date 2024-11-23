lume = require "libs.lume"
camera = require "libs.hump.camera"
Gamestate = require "libs.hump.gamestate"
Class = require "libs.hump.class"
Signal = require 'libs.hump.signal'
Timer = require 'libs.hump.timer'
push = require "libs.push"
flux = require "libs.flux"

require "game.handleLogic"

require "game.sounds"
require "game.ui.object"
require "game.ui.image"
require "game.ui.text"
require "game.ui.button"

require "game.elements.nonnoPic"
require "game.elements.baloon"
require "game.elements.phone"


images = {}
sounds = {}
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
	images.phoneNonno = {
		love.graphics.newImage("assets/img/UI/telefono_nonno.png"), 
		love.graphics.newImage("assets/img/UI/telefono_nonna.png")
	}
	images.baloon = love.graphics.newImage("assets/img/UI/balloon.png")
	images.baloonPlayer = love.graphics.newImage("assets/img/UI/balloon_player.png")
	images.sendMessage = love.graphics.newImage("assets/img/UI/invio.png")
	images.background = love.graphics.newImage("assets/img/UI/background.png")
	images.news = {
		love.graphics.newImage("assets/img/Vere/alluvione.png"),
		love.graphics.newImage("assets/img/Vere/erba.png"),
		love.graphics.newImage("assets/img/Vere/festivalori.png"),
		love.graphics.newImage("assets/img/Vere/mazzarelle.png"),
		love.graphics.newImage("assets/img/Vere/missionarie.png"),
		love.graphics.newImage("assets/img/Vere/pesce.png"),
		love.graphics.newImage("assets/img/Vere/uncinetto.png"),
		love.graphics.newImage("assets/img/Vere/vescovo.png"),
	}
	images.fake = {
		love.graphics.newImage("assets/img/False/berlusconi.png"),
		love.graphics.newImage("assets/img/False/curcuma.png"),
		love.graphics.newImage("assets/img/False/donmatteo.png"),
		love.graphics.newImage("assets/img/False/molise.png"),
		love.graphics.newImage("assets/img/False/musk.png"),
		love.graphics.newImage("assets/img/False/starnutire.png"),
		love.graphics.newImage("assets/img/False/studioaperto.png"),
		love.graphics.newImage("assets/img/False/vaccini.png"),
		love.graphics.newImage("assets/img/False/vesuvio.png"),
		love.graphics.newImage("assets/img/False/videogiochi.png"),
	}
	images.chat = {
		love.graphics.newImage("assets/img/Immagini_so_bad/barbone_coi_soldi.png"),
		love.graphics.newImage("assets/img/Immagini_so_bad/buongiorno_sabato.png"),
		love.graphics.newImage("assets/img/Immagini_so_bad/buongiorno_caffe.png"),
		love.graphics.newImage("assets/img/Immagini_so_bad/buongiorno_ritardo.png"),
		love.graphics.newImage("assets/img/Immagini_so_bad/cagnini_supereroi.png"),
		love.graphics.newImage("assets/img/Immagini_so_bad/cane_in_cielo.png"),
		love.graphics.newImage("assets/img/Immagini_so_bad/gattini.png"),
		love.graphics.newImage("assets/img/Immagini_so_bad/gatto_dottore.png"),
		love.graphics.newImage("assets/img/Immagini_so_bad/trump_gattini.png"),
	}

	images.nonniPic = {
		{
			sad = love.graphics.newImage("assets/img/UI/nonno_triste.png"),
			normal = love.graphics.newImage("assets/img/UI/nonno_normale.png"),
			happy = love.graphics.newImage("assets/img/UI/nonno_felice.png")
		},
		{
			sad = love.graphics.newImage("assets/img/UI/nonna_triste.png"),
			normal = love.graphics.newImage("assets/img/UI/nonna_normale.png"),
			happy = love.graphics.newImage("assets/img/UI/nonna_felice.png")
		}
	}

	images.soldibg = love.graphics.newImage("assets/img/UI/euro_label_counter.png")
	images.soldiicon = love.graphics.newImage("assets/img/UI/soldi_zero.png")
	images.close = love.graphics.newImage("assets/img/UI/notiziafalsa.png")
	images.legenda = love.graphics.newImage("assets/img/UI/legenda.png")

	sounds.music = love.audio.newSource("assets/audio/main_music.wav", "stream")
	sounds.click = love.audio.newSource("assets/audio/click.wav", "static")
	sounds.right = love.audio.newSource("assets/audio/corretto.wav", "static")
	sounds.wrong = love.audio.newSource("assets/audio/sbagliato.wav", "static")

	-- FONTS
	fonts.default = love.graphics.newFont("assets/img/UI/Permanent_Marker/PermanentMarker-Regular.ttf", 64, "normal", love.graphics.getDPIScale())


	push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, resizable = true})
    Gamestate.registerEvents()
    Gamestate.switch(states.game)
end

function love.resize(w, h)
	return push:resize(w, h)
end