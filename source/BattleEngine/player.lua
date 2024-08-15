Player = {}

local heart = {
    image = love.graphics.newImage('assets/images/ut-heart.png'),
    x = Ui.arenaTo.x - 8,
    y = Ui.arenaTo.y - 8
}

local sfx = {
    move = love.audio.newSource('assets/sound/sfx/menumove.wav', 'static')
}

Player.stats = {name = 'Chara', love = 1, hp = 20, maxhp = 20}

Player.inventory = {
    'Pie',
    'M. Candy',
    'M. Candy',
    'Tough Glove',
    'Filler',
    'Filler',
    'Filler',
    'Filler'
}

if global.battleState == 'enemyTalk' then
    heart.x = Ui.arenaTo.x - 8
    heart.y = Ui.arenaTo.y - 8
end

function Player:update(dt)
    if global.battleState == 'buttons' then
        if input.right then
            sfx.move:stop()
            sfx.move:play()
            global.choice = global.choice + 1
            if global.choice == 4 then
                global.choice = 0
            end
        elseif input.left then
            sfx.move:stop()
            sfx.move:play()
            global.choice = global.choice - 1
            if global.choice == -1 then
                global.choice = 3
            end
        elseif input.primary then
            if global.choice == 2 then
                Writer:stop()
                global.battleState = 'item'
            end
        end
        if global.choice == 0 then heart.x, heart.y = 40, 446
        elseif global.choice == 1 then heart.x, heart.y = 193, 446
        elseif global.choice == 2 then heart.x, heart.y = 353, 446
        elseif global.choice == 3 then heart.x, heart.y = 508, 446 end
    end
    if global.battleState == 'enemyTurn' then
        heart.x = heart.x + ((love.keyboard.isDown('right')and 1 or 0) - (love.keyboard.isDown('left')and 1 or 0)) * 4 / ((love.keyboard.isDown('x')and 1 or 0) + 1) * love.timer.getDelta() * 30
        heart.y = heart.y + ((love.keyboard.isDown('down')and 1 or 0) - (love.keyboard.isDown('up')and 1 or 0)) * 4 / ((love.keyboard.isDown('x')and 1 or 0) + 1) * love.timer.getDelta() * 30
        heart.x = math.max(maxLeft, math.min(heart.x, maxRight))
        heart.y = math.max(maxUp, math.min(heart.y, maxDown))
    end
    if global.battleState == 'item' then
        if input.secondary then
            input.secondary = false
            gotoMenu()
        end
    end
end

function Player:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.draw(heart.image, math.floor(heart.x), math.floor(heart.y))
end

return Player