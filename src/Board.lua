---@class Board
Board = Class {}

local CELL_WIDTH, CELL_HEIGHT = 70, 70

function Board:init()
    self._anchorX, self._anchorY = 20, 20

    self:reset()
end

function Board:render()
    love.graphics.setColor(0, 0, 0)
    for i = 1, 4 do
        for j = 1, 4 do
            local thisCellX, thisCellY = self._anchorX + (j - 1) * CELL_WIDTH, self._anchorY + (i - 1) * CELL_HEIGHT
            love.graphics.rectangle("line", thisCellX, thisCellY, CELL_WIDTH, CELL_HEIGHT)
            if (self._matrix[i][j] ~= 0) then
                love.graphics.printf(
                    self._matrix[i][j],
                    thisCellX,
                    thisCellY + CELL_HEIGHT / 2 - 10,
                    CELL_WIDTH,
                    "center"
                )
            end
        end
    end
    love.graphics.setColor(1, 1, 1)
end

function Board:update(dt)
    if (love.keyboard.wasPressed("up")) then
        if (self._emptyRow > 1) then
            self:swap(self._emptyRow - 1, self._emptyColumn, self._emptyRow, self._emptyColumn)
            self._emptyRow = self._emptyRow - 1
        end
    elseif (love.keyboard.wasPressed("down")) then
        if (self._emptyRow < 4) then
            self:swap(self._emptyRow + 1, self._emptyColumn, self._emptyRow, self._emptyColumn)
            self._emptyRow = self._emptyRow + 1
        end
    end

    if (love.keyboard.wasPressed("left")) then
        if (self._emptyColumn > 1) then
            self:swap(self._emptyRow, self._emptyColumn - 1, self._emptyRow, self._emptyColumn)
            self._emptyColumn = self._emptyColumn - 1
        end
    elseif (love.keyboard.wasPressed("right")) then
        if (self._emptyColumn < 4) then
            self:swap(self._emptyRow, self._emptyColumn + 1, self._emptyRow, self._emptyColumn)
            self._emptyColumn = self._emptyColumn + 1
        end
    end
end

function Board:reset()
    self._matrix = {}

    local numberSet = {}
    for i = 0, 15 do
        table.insert(numberSet, i)
    end

    for i = 1, 4 do
        self._matrix[i] = {}
        for j = 1, 4 do
            self._matrix[i][j] = self:getRandomFromSet(numberSet)
            if (self._matrix[i][j] == 0) then
                self._emptyRow, self._emptyColumn = i, j
            end
        end
    end
end

function Board:getRandomFromSet(set)
    local gotIndex = math.random(1, #set)
    local returnValue = set[gotIndex]
    table.remove(set, gotIndex)
    return returnValue
end

function Board:swap(row1, column1, row2, column2)
    local temp = self._matrix[row1][column1]
    self._matrix[row1][column1] = self._matrix[row2][column2]
    self._matrix[row2][column2] = temp
end

function Board:checkCompletion()
    local completeValues = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0}
    local index = 1
    for i = 1, 4 do
        for j = 1, 4 do
            if (self._matrix[i][j] ~= completeValues[index]) then
                return false
            end
            index = index + 1
        end
    end
    return true
end
