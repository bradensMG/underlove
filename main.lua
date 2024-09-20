global = {gameState = 'BattleEngine', battleState = 'buttons', choice = 0, subChoice = 0}
local FPS = 30

BattleEngine = require 'source.BattleEngine'

fonts = {
    determination = love.graphics.newFont('assets/fonts/determination-mono.ttf', 32),
    mnc = love.graphics.newFont('assets/fonts/Mars_Needs_Cunnilingus.ttf', 23),
    dotumche = love.graphics.newFont('assets/fonts/dotumche.ttf'),
    default = love.graphics.newFont(12),
	consolas = love.graphics.newFont('assets/fonts/Consolas.ttf', 16)
}

for _, font in pairs(fonts) do
    font:setFilter("nearest", "nearest")
end

input = {up = false, down = false, left = false, right = false, primary = false, secondary = false}

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
end

function love.load(arg)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.graphics.setBackgroundColor(0, 0, 0)

    yourCanvasName = love.graphics.newCanvas(640, 480)
    if global.gameState == 'BattleEngine' then BattleEngine:load() end
end

function love.update(dt)
    if global.gameState == 'BattleEngine' then BattleEngine:update(dt) end
    input = {up = false, down = false, left = false, right = false, primary = false, secondary = false}
end

local function connect()
    love.graphics.setCanvas(yourCanvasName)
    love.graphics.clear()
end

local function disconnect()
    love.graphics.setCanvas() -- Set rendering to the screen
	local screenW,screenH = love.graphics.getDimensions() -- Get Dimensions of the window
	local canvasW,canvasH = yourCanvasName:getDimensions() -- Get Dimensions of the game canvas
	local scale = math.min(screenW/canvasW , screenH/canvasH) -- Scale canvas to the screen, You can also change this with 1 if you don't want to scale. Or wrap it in a math.floor to only scale integers.
	--local scale = math.floor(math.min(screenW/canvasW , screenH/canvasH)) -- Scale to the nearest integer 
	--local scale = 1 -- Don't scale

	love.graphics.push()
	love.graphics.translate( math.floor((screenW - canvasW * scale)/2) , math.floor((screenH - canvasH * scale)/2)) -- Move to the appropiate top left corner
	love.graphics.scale(scale,scale) -- Scale
    love.graphics.setColor(1, 1, 1)
	love.graphics.draw(yourCanvasName) -- Draw the canvas
	love.graphics.pop() -- pop transformation state

end

function love.draw()
    connect()

    if global.gameState == 'BattleEngine' then BattleEngine:draw() end

    disconnect()

	love.graphics.setColor(.1, 0, .05, .5)
	love.graphics.rectangle('fill', 5, 5, 216, 63, 5)
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.setLineWidth(2)
	love.graphics.rectangle('line', 5, 5, 216, 63, 5)
	love.graphics.setFont(fonts.consolas)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print('FPS: ' .. love.timer.getFPS() .. '\ngameState: ' .. global.gameState .. '\nbattleState: ' .. global.battleState, 10, 10)
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