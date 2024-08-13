Player = {}

local randomShit = {
    image = love.graphics.newImage('assets/images/ut-heart.png'),
    x = 0,
    y = 0
}

local sfx = {
    move = love.audio.newSource('assets/sound/sfx/menumove.wav', 'static')
}

Player.stats = {name = 'Chara', love = 1, hp = 20, maxhp = 20}

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
        end
        if global.choice == 0 then randomShit.x, randomShit.y = 40, 446
        elseif global.choice == 1 then randomShit.x, randomShit.y = 193, 446
        elseif global.choice == 2 then randomShit.x, randomShit.y = 353, 446
        elseif global.choice == 3 then randomShit.x, randomShit.y = 508, 446 end
    end
end

function Player:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.draw(randomShit.image, randomShit.x, randomShit.y)
end

return Player