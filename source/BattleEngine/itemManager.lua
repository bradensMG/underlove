itemManager = {}

local itemNames = {
    'Monster Candy',
    'Stick',
    'Bandage',
    'Butterscotch Pie',
    'Tough Glove',
    'Faded Ribbon'
}

local itemStats = {
    10,
    1,
    10,
    'all',
    5,
    3
}

local itemDescs = {
    'Has a distinct, non-licorice flavor.',
    'Its bark is worse than its bite.',
    'It has already been used several times.',
    'Butterscotch-cinnamon pie, one slice.',
    'A worn pink leather glove. For five-fingered folk.',
    "If you're cuter, monsters won't hit you as hard."
}

function itemManager:getPropertyfromID(id, property)
        if property == 'name' then
            output = itemNames[id]
        elseif property == 'stat' then
            output = itemStats[id]
        elseif property == 'description' then
            output = itemNames[id]
        end
    return
end

return itemManager