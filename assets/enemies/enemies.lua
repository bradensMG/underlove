enemies = {}

enemies.one = {
    name = 'Poseur',
    x = 200,
    y = 135,
    image = love.graphics.newImage('assets/enemies/images/poseur.png'),
    xOff = 0,
    yOff = 0
}

enemies.two = {
    name = 'Posette',
    x = 440,
    y = 135,
    image = love.graphics.newImage('assets/enemies/images/posette.png'),
    xOff = 0,
    yOff = 0
}

local color

enemies.stats = {amount = 2, canFlee = true}

enemies.encounter = {text = '* The potent posers pose[break]  proposterously!'}
enemies.bgm = love.audio.newSource('assets/sound/mus/fortheworld.mp3', 'stream')

local outlineWidth = 1

local function drawGraphic(image, x, y, color, outlineColor)
    for i = -outlineWidth, outlineWidth do
        love.graphics.setColor(outlineColor)
        for j = -outlineWidth, outlineWidth do
            if i ~= 0 then
                love.graphics.draw(image, x + i, y + j)
            end
        end
    end
    love.graphics.setColor(color)
    love.graphics.draw(image, x, y)
end

function enemies:update(dt)

end

function enemies:draw()
    color = {1, 1, 1}

    if enemies.stats.amount > 0 then
        drawGraphic(enemies.one.image, enemies.one.x - enemies.one.image:getWidth()/2 + enemies.one.xOff, enemies.one.y - enemies.one.image:getHeight()/2 + enemies.one.yOff, color, {0, 0, 0})
    end
    if enemies.stats.amount > 1 then
        drawGraphic(enemies.two.image, enemies.two.x - enemies.two.image:getWidth()/2 + enemies.two.xOff, enemies.two.y - enemies.two.image:getHeight()/2 + enemies.two.yOff, color, {0, 0, 0})
    end
end

return enemies