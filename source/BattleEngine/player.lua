Player = {}

local lastButton

local heart = {
    image = love.graphics.newImage('assets/images/ut-heart.png'),
    x = Ui.arenaTo.x - 8,
    y = Ui.arenaTo.y - 8,
    gravity = 0,
    jumpstage = 3,
    jumptimer = 0,
    show = true
}

local sfx = {
    move = love.audio.newSource('assets/sound/sfx/menumove.wav', 'static'),
    select = love.audio.newSource('assets/sound/sfx/menuconfirm.wav', 'static'),
    heal = love.audio.newSource('assets/sound/sfx/snd_heal_c.wav', 'static')
}

Player.stats = {name = 'Chara', love = 1, hp = 20, maxhp = 20, armor = 'Bandage', weapon = 'Stick'}
Player.vars = {def = 1, atk = 1} -- don't edit these

Player.mode = 'blue'

Player.inventory = {4, 1, 1, 1, 5, 6, 1, 1}

local lastButton

if global.battleState == 'enemyTalk' then
    heart.x = Ui.arenaTo.x - 8
    heart.y = Ui.arenaTo.y - 8
end

local function buttonPos()
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
                Writer:stop()
                global.battleState = 'item'
            end
            input.primary = false
        end
        buttonPos()
    end
    if global.battleState == 'enemyTurn' then
        if Player.mode == 'red' then
            heart.x = heart.x + ((love.keyboard.isDown('right')and 1 or 0) - (love.keyboard.isDown('left')and 1 or 0)) * 4 / ((love.keyboard.isDown('x')and 1 or 0) + 1) * dt * 30
            heart.y = heart.y + ((love.keyboard.isDown('down')and 1 or 0) - (love.keyboard.isDown('up')and 1 or 0)) * 4 / ((love.keyboard.isDown('x')and 1 or 0) + 1) * dt * 30
        end
        if Player.mode == 'blue' then
            heart.y = heart.y + heart.gravity
            heart.x = heart.x + ((love.keyboard.isDown('right')and 1 or 0) - (love.keyboard.isDown('left')and 1 or 0)) * 4 / ((love.keyboard.isDown('x')and 1 or 0) + 1) * dt * 30
            if heart.y >= maxDown then
                heart.jumpstage = 1
                heart.jumptimer = 0
            end
            if heart.jumpstage == 3 then
                heart.gravity = heart.gravity + .5 * (dt * 30)
            end
            if heart.jumpstage == 1 then
                if love.keyboard.isDown('up') then
                    heart.gravity = -6 * (dt * 30)
                    heart.jumptimer = heart.jumptimer + (dt * 30)
                else
                    if heart.y < maxDown then
                        heart.gravity = -1 * dt * 30
                        heart.jumpstage = 3
                    end
                end
                if heart.jumptimer > 10 then
                    heart.jumpstage = 3
                end
            end
        end
        heart.x = math.max(maxLeft, math.min(heart.x, maxRight))
        heart.y = math.max(maxUp, math.min(heart.y, maxDown))
    end
    if global.battleState == 'item' then
        heart.x, heart.y = 472, 348
        if input.secondary then
            input.secondary = false
            buttonPos()
            gotoMenu()
        end
        if input.left then
            if global.subChoice ~= 0 then
                sfx.move:stop()
                sfx.move:play()
                global.subChoice = global.subChoice - 1
            end
        end
        if input.right then
            if global.subChoice ~= #Player.inventory - 1 then
                sfx.move:stop()
                sfx.move:play()
                global.subChoice = global.subChoice + 1
            end
        end
        if input.primary then
            lastButton = global.choice
            heart.show = false
            global.battleState = 'useItem'
            global.choice = -1
            sfx.heal:stop()
            sfx.heal:play()
            useItem()
        end
    end
    if global.battleState == 'useItem' then
        if Writer.isDone and input.primary then
            global.choice = lastButton
            global.battleState = 'buttons'
            gotoMenu()
            buttonPos()
            heart.show = true
        end
    end
end

function Player:draw()
    if Player.mode == 'red' then
        love.graphics.setColor(1, 0, 0)
    elseif Player.mode == 'blue' then
        love.graphics.setColor(0, 0, 1)
    end
    if heart.show then
        love.graphics.draw(heart.image, heart.x, heart.y)
    end
end

return Player