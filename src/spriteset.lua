--[[
	SPRITESET
	Similar to tileset data but handles sprites with varying sizes and requires an accompanying dataset of x/y values to grab the the sprites from the image.
]]

class "spriteset" {
	__init__ = function(self, filepath, spriteWidth, spriteHeight)
		self.img = love.graphics.newImage(filepath)
		local width = self.img:getWidth()
		local height = self.img:getHeight()
		self.sprite = {}
		
		local gridW = spriteWidth + 1
		local gridH = spriteHeight + 1
		
		for y = 0, (height / gridH)  - 1 do
			for x = 0, (width / gridW) - 1 do
				table.insert(self.sprite, love.graphics.newQuad(x * gridW, y * gridH, spriteWidth, spriteHeight, width, height))
			end
		end
		print("Created " .. # self.sprite .. " sprites in " .. filepath)
	end
}