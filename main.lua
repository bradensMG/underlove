global = {gameState = 'BattleEngine', battleState = 'buttons', choice = 0, subChoice = 0}

BattleEngine = require 'source.BattleEngine'
TestTextRoom = require 'source.TestTextRoom'

fonts = {
    determination = love.graphics.newFont('assets/fonts/determination-mono.ttf', 32),
    mnc = love.graphics.newFont('assets/fonts/Mars_Needs_Cunnilingus.ttf', 23)
}

input = {up = false, down = false, left = false, right = false, primary = false, secondary = false,}

function love.keypressed(key)
    if key == 'up' then input.up = true
    elseif key == 'down' then input.down = true
    elseif key == 'left' then input.left = true
    elseif key == 'right' then input.right = true
    elseif key == 'z' or key == 'enter' then input.primary = true
    elseif key == 'x' or key == 'rshift' or key == 'lshift' then input.secondary = true end
end

function love.load(arg)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    if global.gameState == 'BattleEngine' then BattleEngine:load() end
    if global.gameState == 'TestTextRoom' then TestTextRoom:load() end
end

function love.update(dt)
    if global.gameState == 'BattleEngine' then BattleEngine:update(dt) end
    if global.gameState == 'TestTextRoom' then TestTextRoom:update(dt) end
    input = {up = false, down = false, left = false, right = false, primary = false, secondary = false,}
end

function love.draw()
    if global.gameState == 'BattleEngine' then BattleEngine:draw() end
    if global.gameState == 'TestTextRoom' then TestTextRoom:draw() end
    love.graphics.print(math.floor(1 / love.timer.getDelta()))
end