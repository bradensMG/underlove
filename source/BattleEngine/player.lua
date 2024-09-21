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
    heal = love.audio.newSource('assets/sound/sfx/snd_heal_c.wav', 'static'),
    err = love.audio.newSource('assets/sound/sfx/err.mp3', 'static')
}

Player.stats = {name = 'chara', love = 1, hp = 20, maxhp = 20, armor = 3, weapon = 2, atk = 0, def = 0}

Player.mode = 'red'

Player.inventory = {4, 1, 1, 5, 6}

local lastButton

if global.battleState == 'enemyTalk' then
    heart.x = Ui.arenaTo.x - 8
    heart.y = Ui.arenaTo.y - 8
end

local function setDefAtk()
    if Player.stats.armor == 3 then -- if the current armor is bandage
        Player.stats.def = 1        -- set defense to 1
    else                            -- because bandage is a consumable, i have to write custom code for
        --                             the bandage to affect the player's defense
        Player.stats.def = itemManager:getPropertyfromID(Player.stats.armor, 'stat')
    end

    Player.stats.atk = itemManager:getPropertyfromID(Player.stats.weapon, 'stat')
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
    setDefAtk()
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
            if global.choice == 0 or global.choice == 1 then
                sfx.select:stop()
                sfx.select:play()
                Writer:stop()
                global.subChoice = 0
                global.battleState = 'chooseEnemy'
            elseif global.choice == 2 then
                if #Player.inventory > 0 then
                    sfx.select:stop()
                    sfx.select:play()
                    Writer:stop()
                    global.subChoice = 0
                    global.battleState = 'item'
                else
                    sfx.err:stop()
                    sfx.err:play()
                end
            elseif global.choice == 3 then
                sfx.select:stop()
                sfx.select:play()
                Writer:stop()
                global.subChoice = 0
                global.battleState = 'mercy'
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
                heart.gravity = 0
                heart.jumptimer = 0
            end
            if heart.jumpstage == 3 then
                heart.gravity = heart.gravity + 1 * dt * 30
            end
            if heart.jumpstage == 1 then
                if love.keyboard.isDown('up') then
                    heart.gravity = -6 * dt * 30
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
    if global.battleState == 'chooseEnemy' then
        heart.x, heart.y = 55, 279+(global.subChoice*32)
        if input.up then
            if global.subChoice ~= 0 then
                sfx.move:stop()
                sfx.move:play()
                global.subChoice = global.subChoice - 1
            end
        end
        if input.down then
            if global.subChoice ~= enemies.stats.amount-1 then
                sfx.move:stop()
                sfx.move:play()
                global.subChoice = global.subChoice + 1
            end
        end
        if input.secondary then
            input.secondary = false
            buttonPos()
            gotoMenu()
        end
    end
    if global.battleState == 'item' then
        heart.x, heart.y = 472, 348
        if input.secondary then
            input.secondary = false
            buttonPos()
            gotoMenu()
        elseif input.left then
            if global.subChoice ~= 0 then
                sfx.move:stop()
                sfx.move:play()
                global.subChoice = global.subChoice - 1
            else
                sfx.err:stop()
                sfx.err:play()
            end
        elseif input.right then
            if global.subChoice ~= #Player.inventory - 1 then
                sfx.move:stop()
                sfx.move:play()
                global.subChoice = global.subChoice + 1
            else
                sfx.err:stop()
                sfx.err:play()
            end
        elseif input.primary then
            lastButton = global.choice
            heart.show = false
            global.battleState = 'useItem'
            global.choice = -1
            sfx.heal:stop()
            sfx.heal:play()
            useItem()
        end
    end
    if global.battleState == 'mercy' then
        heart.x, heart.y = 55, 279+(global.subChoice*32)
        if input.up then
            if global.subChoice ~= 0 then
                sfx.move:stop()
                sfx.move:play()
                global.subChoice = global.subChoice - 1
            end
        end
        if input.down then
            if enemies.stats.canFlee and global.subChoice ~= 1 then
                sfx.move:stop()
                sfx.move:play()
                global.subChoice = global.subChoice + 1
            end
        end
        if input.secondary then
            input.secondary = false
            buttonPos()
            gotoMenu()
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
    crashx = heart.x - 2
    crashy = heart.y
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