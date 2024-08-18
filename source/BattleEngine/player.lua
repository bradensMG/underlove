Player = {}

local hideHeart = false

local heart = {
    image = love.graphics.newImage('assets/images/ut-heart.png'),
    x = Ui.arenaTo.x - 8,
    y = Ui.arenaTo.y - 8
}

local sfx = {
    move = love.audio.newSource('assets/sound/sfx/menumove.wav', 'static'),
    select = love.audio.newSource('assets/sound/sfx/menuconfirm.wav', 'static'),
    heal = love.audio.newSource('assets/sound/sfx/snd_heal_c.wav', 'static')
}

Player.stats = {name = 'chara', love = 1, hp = 20, maxhp = 20}

Player.inventory = {}
Player.inventory[1] = {name = 'Butterscotch Pie', type = 'consumable', change = 'All', note = 'Butterscotch-cinnamon pie, one\n  slice.'}
Player.inventory[2] = {name = 'Monster Candy', type = 'consumable', change = 10, note = 'Has a distinct, non-licorice\n  flavor.'}
Player.inventory[3] = {name = 'Monster Candy', type = 'consumable', change = 10, note = 'She said not to take more\n  than one.'}
Player.inventory[4] = {name = 'Snowman Piece', type = 'consumable', change = 45, note = 'Please take this to the ends\n  of the earth.'}
Player.inventory[5] = {name = 'Tough Glove', type = 'weapon', change = '11', note = 'A worn pink leather glove. For\n  five-fingered folk.'}

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
            sfx.select:stop()
            sfx.select:play()
            if global.choice == 2 then
                global.battleState = 'item'
                Writer:stop()
            end
            input.primary = false
        end
        heart.y = 446
        if global.choice == 0 then 
            heart.x = 40
        elseif global.choice == 1 then
            heart.x = 194
        elseif global.choice == 2 then
            heart.x = 353
        elseif global.choice == 3 then
            heart.x = 507
        end
    end
    if global.battleState == 'enemyTurn' then
        heart.x = heart.x + ((love.keyboard.isDown('right')and 1 or 0) - (love.keyboard.isDown('left')and 1 or 0)) * 4 / ((love.keyboard.isDown('x')and 1 or 0) + 1) * love.timer.getDelta() * 30
        heart.y = heart.y + ((love.keyboard.isDown('down')and 1 or 0) - (love.keyboard.isDown('up')and 1 or 0)) * 4 / ((love.keyboard.isDown('x')and 1 or 0) + 1) * love.timer.getDelta() * 30
        heart.x = math.max(maxLeft, math.min(heart.x, maxRight))
        heart.y = math.max(maxUp, math.min(heart.y, maxDown))
    end
    if global.battleState == 'item' then
        heart.x, heart.y = 472, 348
        if input.secondary then
            input.secondary = false
            gotoMenu()
        end
        if input.primary then
            sfx.heal:stop()
            sfx.heal:play()

            hideHeart = true
            global.choice = -1
            global.battleState = 'useItem'

            Writer:setParams('[clear]* Placeholder text you didnt[break]  equip anything sorry    [green][break]* Heres some green text instead[clear] ', 52, 274, fonts.determination, 0.02, 1)
        end
        if input.right then
            if global.subChoice ~= #Player.inventory - 1 then
                sfx.move:stop()
                sfx.move:play()
            end
            global.subChoice = global.subChoice + 1
            if global.subChoice == #Player.inventory then
                global.subChoice = #Player.inventory - 1
            end
        end
        if input.left then
            if global.subChoice ~= 0 then
                sfx.move:stop()
                sfx.move:play()
            end
            global.subChoice = global.subChoice - 1
            if global.subChoice == -1 then
                global.subChoice = 0
            end
        end
    end
end

function Player:draw()
    love.graphics.setColor(1, 0, 0)
    if not hideHeart then
        love.graphics.draw(heart.image, math.floor(heart.x), math.floor(heart.y))
    end
end

return Player