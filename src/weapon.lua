--[[
	WEAPON
]]

class "weapon" {
	__init__ = function(self, bulletSpr, spawnOffsetX, spawnOffsetY, damage, cool, fireMode, spawnVelX, spawnVelY)
		self.bullet = {} --table of 'bullets' spawned by this weapon
		self.spawnOffsetX = spawnOffsetX or 0
		self.spawnOffsetY = spawnOffsetY or 0 --these cause the bullet to spawn in line with the users' sprite
		self.bulletSpr = bulletSpr or spriteset("spr/power.png", 4, 5)
		self.spawnVelX = spawnVelX or 200
		self.spawnVelY = spawnVelY or self.spawnVelX
		self.cool = cool or 0.1 --weapon cooldown
		self.time = love.timer.getTime()
		self.fireMode = fireMode
		if type(self.fireMode) == "number" then self.burst = 0 end
		self.damage = damage or 25
	end,
	
	update = function(self, dt, t, map, offsetX, offsetY, check)
		for k, bullet in ipairs(self.bullet) do
			bullet:update(dt, t, map, offsetX, offsetY, check)
			if bullet.kill then table.remove(self.bullet, k) end
		end
	end,
	
	--no draw yet as weapons are included in the entity sprite
	--HOWEVER, it may be that case that I want to have weapons display whilst moving around... we'll see.
	draw = function(self)
		--somecode
	end,
	
	fire = function(self, t, posX, posY, velX, velY)
		if t - self.time >= self.cool then
			if self.burst then
				self.burst = self.burst + 1 < self.fireMode and self.burst + 1 or 0
			end
			local newBullet = bullet(self.bulletSpr, posX + (self.spawnOffsetX * velX), posY + self.spawnOffsetY, self.spawnVelX * velX, self.spawnVelY * velY, self.damage)
			table.insert(self.bullet, newBullet)
			self.time = t
			print("Fire! " .. tostring(fire))
		end
		local fire = true
		if self.fireMode == "semi" then
			fire = nil
		elseif type(self.fireMode) == "number" then
			if self.burst == 0 then 
				fire = nil end
		else--if self.fireMode == "auto" or not self.fireMode then
			fire = true
		end
		return fire
	end
}
		