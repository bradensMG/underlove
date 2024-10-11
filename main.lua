local debugMode = true

require 'source.errhand'
require 'source.fpsLimiter'

Enemies = require('assets.enemies.testEnemy')

function reload()
	love.audio.stop()
	love.graphics.clear()
	love.load()
	playMusic = true
end

function love.keypressed(key)
    if key == 'up' then
        input.up = true
    elseif key == 'down' then
        input.down = true
    elseif key == 'left' then
        input.left = true
    elseif key == 'right' then
        input.right = true
    elseif key == 'z' or key == 'return' then
        input.primary = true
    elseif key == 'x' or key == 'rshift' or key == 'lshift' then
        input.secondary = true
    elseif key == "f4" then
		fullscreen = not fullscreen
		love.window.setFullscreen(fullscreen, "desktop")
	end
	if debugMode then
		if key == '1' then
			love.graphics.captureScreenshot('screenie.png') 
		elseif key == '2' then
			error('forceCrash')
		elseif key == 'r' then
			reload()
		elseif key == 'q' then
			Enemies = require('assets.enemies.testSans')
			reload()
		elseif key == 'w' then
			Enemies = require('assets.enemies.testEnemy')
			reload()
		end
	end
end

function love.load(arg)
	love.audio.setVolume(1)
	global = {gameState = 'BattleEngine', battleState = nil, choice = 0, subChoice = 0}

	BattleEngine = require 'source.BattleEngine'

	fonts = {

		determination = love.graphics.newFont('assets/fonts/determination-mono.ttf', 32),
		mnc = love.graphics.newFont('assets/fonts/Mars_Needs_Cunnilingus.ttf', 23),
		dotumche = love.graphics.newFont('assets/fonts/dotumche.ttf', 13),
		default = love.graphics.newFont(12),
		consolas = love.graphics.newFont('assets/fonts/Consolas.ttf', 16),
		fredoka = love.graphics.newFont('assets/fonts/Fredoka-Medium.ttf', 16)
	}

	outlineWidth = 2

	for _, font in pairs(fonts) do
		font:setFilter("nearest", "nearest")
	end

	input = {up = false, down = false, left = false, right = false, primary = false, secondary = false}
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.graphics.setBackgroundColor(0, 0, 0)

    yourCanvasName = love.graphics.newCanvas(640, 480)
	local joysticks = love.joystick.getJoysticks()

    if global.gameState == 'BattleEngine' then BattleEngine:load() end
end

function love.update(dt)
    if global.gameState == 'BattleEngine' then BattleEngine:update(dt) end
    input = {up = false, down = false, left = false, right = false, primary = false, secondary = false}
end

-- didn't make these two functions :( sulfur gave them to me from the love2d forums but we can't find the source
local function connect()
    love.graphics.setCanvas(yourCanvasName)
    love.graphics.clear()
end

local function disconnect()
    love.graphics.setCanvas()
	local screenW,screenH = love.graphics.getDimensions()
	local canvasW,canvasH = yourCanvasName:getDimensions()
	local scale = math.min(screenW/canvasW , screenH/canvasH)
	love.graphics.push()
	love.graphics.translate( math.floor((screenW - canvasW * scale)/2) , math.floor((screenH - canvasH * scale)/2))
	love.graphics.scale(scale,scale)
    love.graphics.setColor(1, 1, 1)
	love.graphics.draw(yourCanvasName)
	love.graphics.pop()
end

function love.draw()
    connect()
    if global.gameState == 'BattleEngine' then BattleEngine:draw() end
    disconnect()

	if debugMode then
		local width = 230
		local height = 81

		love.graphics.setColor(0, 0, 0, .5)
		love.graphics.rectangle('fill', 5, 5, width, height, 5)

		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.setLineWidth(2)
		love.graphics.setLineStyle('rough')
		love.graphics.rectangle('line', 5, 5, width, height, 5)

		love.graphics.setColor(0, 0, 0)
		love.graphics.setLineWidth(2)
		love.graphics.setLineStyle('rough')
		love.graphics.rectangle('line', 3, 3, width + 4, height + 4, 5)
		
		love.graphics.setFont(fonts.consolas)
		love.graphics.setColor(1, 1, 1)
		love.graphics.print('FPS: ' .. love.timer.getFPS() .. '\ngameState: ' .. global.gameState .. '\nbattleState: ' .. global.battleState .. '\nRAM Usage: ' .. math.floor(collectgarbage("count")) .. ' KB', 10, 10)
	end
end