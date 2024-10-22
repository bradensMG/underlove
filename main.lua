local debugMode = true
local FPS = 30

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

local timerSleep = function () return 1/FPS end
function love.run()
	if love.math then
		love.math.setRandomSeed(os.time())
	end
 
	if love.load then love.load(arg) end
 
	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end
 
	local dt = 0
 
	-- Main loop time.
	while true do
		-- Process events.
		local startT = love.timer.getTime()
		
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end
 
		-- Update dt, as we'll be passing it to update
		if love.timer then
			love.timer.step()
			dt = love.timer.getDelta()
		end
 
		-- Call update and draw
		if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled
 
		if love.graphics and love.graphics.isActive() then
			love.graphics.clear(love.graphics.getBackgroundColor())
			love.graphics.origin()
			if love.draw then love.draw() end
			love.graphics.present()
		end
 
		if love.timer then
			local endT = love.timer.getTime()
			love.timer.sleep(timerSleep() - (endT - startT))
		end
	end
end

local utf8 = require("utf8")

local function error_printer(msg, layer)
	print((debug.traceback("Error: " .. tostring(msg), 1+(layer or 1)):gsub("\n[^\n]+$", "")))
end

function love.errorhandler(msg)
	msg = tostring(msg)

	error_printer(msg, 2)

	if not love.window or not love.graphics or not love.event then
		return
	end

	if not love.graphics.isCreated() or not love.window.isOpen() then
		local success, status = pcall(love.window.setMode, 800, 600)
		if not success or not status then
			return
		end
	end

	-- Reset state.
	if love.mouse then
		love.mouse.setVisible(true)
		love.mouse.setGrabbed(false)
		love.mouse.setRelativeMode(false)
		if love.mouse.isCursorSupported() then
			love.mouse.setCursor()
		end
	end
	if love.joystick then
		-- Stop all joystick vibrations.
		for i,v in ipairs(love.joystick.getJoysticks()) do
			v:setVibration()
		end
	end

	if love.audio then
		love.audio.stop()
		local err = love.audio.newSource('assets/sound/error oh no.mp3', 'stream')
        err:setLooping(true)
		love.audio.play(err)
	end

	love.graphics.reset()

	love.graphics.setColor(1, 1, 1)

	local trace = debug.traceback()

	love.graphics.origin()

	local sanitizedmsg = {}
	for char in msg:gmatch(utf8.charpattern) do
		table.insert(sanitizedmsg, char)
	end
	sanitizedmsg = table.concat(sanitizedmsg)

	local err = {}

	table.insert(err, sanitizedmsg)

	if #sanitizedmsg ~= #msg then
		table.insert(err, "Invalid UTF-8 string in error message.")
	end

	table.insert(err, "\n")

	for l in trace:gmatch("(.-)\n") do
		if not l:match("boot.lua") then
			l = l:gsub("stack traceback:", "Traceback\n")
			table.insert(err, l)
		end
	end

	local p = table.concat(err, "\n")

	p = p:gsub("\t", "")
	p = p:gsub("%[string \"(.-)\"%]", "%1")

	i = 0

	local function draw()
		if not love.graphics.isActive() then return end
		local pos = 70
		love.graphics.clear(0, 0, 0)

        love.graphics.setColor(1, 1, 0)
		love.graphics.setFont(fonts.determination)
		love.graphics.print('O', 5 + math.sin(love.timer.getTime() * -8 + 0) * 1.5, 5 + math.cos(love.timer.getTime() * -8 + 0) * 1.5)
        love.graphics.print('o', 21 + math.sin(love.timer.getTime() * -8 + 1) * 1.5, 5 + math.cos(love.timer.getTime() * -8 + 1) * 1.5)
        love.graphics.print('p', 37 + math.sin(love.timer.getTime() * -8 + 2) * 1.5, 5 + math.cos(love.timer.getTime() * -8 + 2) * 1.5)
        love.graphics.print('s', 53 + math.sin(love.timer.getTime() * -8 + 3) * 1.5, 5 + math.cos(love.timer.getTime() * -8 + 3) * 1.5)
        love.graphics.print('!', 69 + math.sin(love.timer.getTime() * -8 + 4) * 1.5, 5 + math.cos(love.timer.getTime() * -8 + 4) * 1.5)

		love.graphics.setColor(1, 1, 1)
		love.graphics.setFont(fonts.dotumche)
		love.graphics.printf(p, 5, 45, 640)

		love.graphics.setColor(1, 1, 0)
		love.graphics.print(control, 5, 300)

		i = i + love.timer.getDelta()

        enemies[1].image:setFilter('nearest', 'nearest')
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(enemies[1].image, 500, 340, math.sin(i) / 5, 1, 1, enemies[1].image:getWidth()/2, enemies[1].image:getHeight()/2)

		love.graphics.present()
	end

	local fullErrorText = p
	local function copyToClipboard()
		if not love.system then return end
		love.system.setClipboardText(fullErrorText)
		control = control .. "\nCopied to clipboard!"
	end

	control = ''
	if love.system then
		control = control .. "\n\nPress CTRL+C or tap to copy this error\nPress CTRL+R to restart the game\nPress ESC to close the game"
	end

	return function()
		love.event.pump()

		for e, a, b, c in love.event.poll() do
			if e == "quit" then
				return 1
			elseif e == "keypressed" and a == "escape" then
				return 1
			elseif e == "keypressed" and a == "c" and love.keyboard.isDown("lctrl", "rctrl") then
				copyToClipboard()
			elseif e == "keypressed" and a == "r" and love.keyboard.isDown("lctrl", "rctrl") then
				return 'restart'
			elseif e == "touchpressed" then
				local name = love.window.getTitle()
				if #name == 0 or name == "Untitled" then name = "Game" end
				local buttons = {"OK", "Cancel"}
				if love.system then
					buttons[3] = "Copy to clipboard"
				end
				local pressed = love.window.showMessageBox("Quit "..name.."?", "", buttons)
				if pressed == 1 then
					return 1
				elseif pressed == 3 then
					copyToClipboard()
				end
			end
		end

		draw()
	end
end