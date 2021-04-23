--- LOVE.blast() 1.02
-- Shooter example game for Love2d
-- by YellowAfterlife

-- game dimensions:
width = love.graphics.getWidth()--800
height = love.graphics.getHeight()--600
score = 0
state = 0 -- 1 = game, 0 = menu
scoreFont = love.graphics.newFont(24)
menuFont = love.graphics.newFont(48)
--- collides(x1, y1, radius1, x2, y2, radius2): boolean
-- Returns if given circles collide. Is pretty fast.
function collide(x1, y1, r1, x2, y2, r2)
	local dx = x2 - x1
	local dy = y2 - y1
	local dr = r1 + r2
	if (dx > dr) or (dx < -dr) or (dy > dr) or (dy < -dr) then
		return false
	end
	return (dx * dx + dy * dy) < (dr * dr)
end
-- enemy functions & variables:
enemies = { } -- enemy array
function addEnemy(px, py)
	local o = {
		x = px, -- position X
		y = py, -- posi3ion Y
		r = 20, -- radius
		health =  5, -- health
		moveSpeed =  200, -- movement speed
		knockSpeed = 0, -- knock speed
		knockDir = 0, -- knock direction
		knockCos = 0, -- knock X multiplier
		knockSin = 0, -- knock Y multiplier
		knockFrict = 500 -- knock friction
	}
	table.insert(enemies, o)
	return o
end
function knockEnemy(o, mx, my)
	local x, y, l
	x = math.cos(o.knockDir) * o.knockSpeed + mx
	y = math.sin(o.knockDir) * o.knockSpeed + my
	l = math.sqrt(x * x + y * y)
	o.knockDir = math.atan2(y, x)
	o.knockSpeed = l
	o.knockCos = x / l
	o.knockSin = y / l
end
-- bullet functions & variables:
bullets = { }
function addBullet(px, py, d, s)
	local o = {
		x = px, -- position X
		y = py, -- position Y
		r =  8, -- radius
		moveSpeed = s, -- movement speed
		moveDir = d, -- movement direction
		moveX = math.cos(d) * s,
		moveY = math.sin(d) * s
	}
	table.insert(bullets, o)
	return o
end
-- explosions
explosions = { }
function addExplosion(px, py, pr)
	local o = {
		x = px, -- position X
		y = py, -- position Y
		r = pr, -- radius
		a =  1  -- alpha
	}
	table.insert(explosions, o)
	return o
end
--
function start()
	player = {
		x = width / 2, y = height / 2, r = 20,
		angle = 0,
		speedX = 0, speedY = 0,
		speedAcc = 2500, speedFrc = 750, speedMax = 300,
		cooldown = 0, cooldownAdd = 0.10,
		health = 100, healthMax = 100, healthRegen = 30, hit = false
	}
	enemies = { }
	bullets = { }
	explosions = { }
	score = 0
	spawnRate = 70
	spawnTimer = 0
	state = 1
end
function gameOver()
	state = 0
end
function love.load()
	love.graphics.setBackgroundColor(0, 200, 225)
end
function updateGame(dt)
	local i, j, l, n, o, q, x, y, d, r
	-- spawn enemies
	spawnTimer = spawnTimer + dt
	d = 350 / spawnRate
	if spawnTimer >= d then
		spawnTimer = math.random() / 4 * d
		j = math.ceil(math.random(3))
		while j > 0 do -- add two enemies at once
			i = math.floor(math.random() * 4)
			if (i == 0) or (i == 2) then
				x = math.random(width)
				if (i == 0) then
					y = -20
				else
					y = height + 20
				end
			end
			if (i == 1) or (i == 3) then 
				y = math.random(height)
				if (i == 1) then
					x = -20
				else
					x = width + 20
				end
			end
			addEnemy(x, y)
			j = j - 1
		end
	end
	-- update enemies:
	i = 1
	l = #enemies
	while i <= l do
		o = enemies[i]
		if (o == nil) then break end
		-- find difference between enemy and player:
		x = player.x - o.x
		y = player.y - o.y
		-- find length of difference vector:
		d = math.sqrt(x * x + y * y)
		if (d > 0) then
			n = math.min(d, o.moveSpeed * dt)
			-- normalize; we"ll have a vector of o.moveSpeed length afterwards:
			x = x * n / d
			y = y * n / d
			-- actually move the enemy:
			o.x = o.x + x
			o.y = o.y + y
		end
		if (not player.hit) and (d < player.r + o.r) then
			player.health = player.health - dt * 100
			player.hit = true
		end
		-- knockback:
		if (o.knockSpeed > 0) then
			-- move the enemy:
			o.x = o.x + o.knockSpeed * o.knockCos * dt
			o.y = o.y + o.knockSpeed * o.knockSin * dt
			-- apply friction to knockback speed:
			if (o.x < 0) or (o.x > width) or (o.y < 0) or (o.y > height) then
				o.knockSpeed = math.max(0, o.knockSpeed - o.knockFrict * 3 * dt)
			else
				o.knockSpeed = math.max(0, o.knockSpeed - o.knockFrict * dt)
			end
		end
		-- collide with enemies:
		j = 1
		n = #enemies
		while j <= n do
			q = enemies[j]
			if not(i == j) then
				x = q.x - o.x
				y = q.y - o.y
				r = q.r + o.r
				if (x * x + y * y < r * r) then
					d = math.sqrt(x * x + y * y)
					x = x * (r - d) / r
					y = y * (r - d) / r
					o.x = o.x - x * dt * 4
					o.y = o.y - y * dt * 4
				end
			end
			j = j + 1
		end
		-- collide with bullets:
		j = 1
		n = #bullets
		while j <= n do
			q = bullets[j]
			if (collide(o.x, o.y, o.r, q.x, q.y, q.r)) then
				o.health = o.health - 1
				-- out of health?
				if (o.health <= 0) then
					table.remove(enemies, i)
					spawnRate = spawnRate + 1
					score = score + spawnRate / 10
					addExplosion(o.x, o.y, o.r)
					i = i - 1 -- counter the variable increment below
					l = l - 1
					break
				else
					knockEnemy(o, q.moveX * 0.5, q.moveY * 0.5)
				end
				-- remove bullet:
				table.remove(bullets, j)
				n = n - 1
			else
				j = j + 1
			end
		end
		i = i + 1
	end
	-- update bullets:
	i = 1
	l = #bullets
	while i <= l do
		o = bullets[i]
		o.x = o.x + o.moveX * dt
		o.y = o.y + o.moveY * dt
		if (o.x < -o.r) or (o.x > width + o.r) or (o.y < -o.r) or (o.y > height + o.r) then
			table.remove(bullets, i)
			l = l - 1
		else
			i = i + 1
		end
	end
	-- explosions:
	i = 1
	l = #explosions
	while i <= l do
		o = explosions[i]
		o.a = o.a - dt * 1.7
		if (o.a <= 0) then
			table.remove(explosions, i)
			l = l - 1
		else
			i = i + 1
		end
	end
	-- update player:
	player.hit = false
	x = player.speedX
	y = player.speedY
	-- control:
	if (love.keyboard.isDown("a")) then x = x - player.speedAcc * dt end
	if (love.keyboard.isDown("d")) then x = x + player.speedAcc * dt end
	if (love.keyboard.isDown("w")) then y = y - player.speedAcc * dt end
	if (love.keyboard.isDown("s")) then y = y + player.speedAcc * dt end
	-- friction, limits:
	l = math.sqrt(x * x + y * y)
	d = l
	if (l > 0) then
		l = math.max(0, math.min(l - player.speedFrc * dt, player.speedMax))
		player.speedX = x * l / d
		player.speedY = y * l / d
	else
		player.speedX = 0
		player.speedY = 0
	end
	-- actually move:
	player.x = player.x + player.speedX * dt
	player.y = player.y + player.speedY * dt
	-- limit
	if (player.x < 0) then player.x = 0 end
	if (player.y < 0) then player.y = 0 end
	if (player.x > width) then player.x = width end
	if (player.y > height) then player.y = height end
	-- rotate:
	x = love.mouse.getX() - player.x
	y = love.mouse.getY() - player.y
	player.angle = math.atan2(y, x)
	-- regenerate
	player.health = math.min(player.health + player.healthRegen * dt, player.healthMax)
	if (player.health <= 0) then
		gameOver()
	end
	-- shoot:
	player.cooldown = math.max(0, player.cooldown - dt)
	if love.mouse.isDown(1,1) and (player.cooldown <= 0) then
		player.cooldown = player.cooldownAdd
		addBullet(player.x, player.y, player.angle + math.random() * 0.1 - 0.05, 500)
	end
end
function updateMenu(dt)
	--if love.keyboard.isDown("up") then
  --if love.keyboard.isDown("up") then
		start()
	--end
end
function love.update(dt)
	if (state == 0) then
		updateMenu(dt)
	end
	if (state == 1) then
		updateGame(dt)
	end
end
function drawGame()
	local i, l, o
	-- draw enemies:
	i = 1
	l = #enemies
	while i <= l do
		o = enemies[i]
		love.graphics.setColor(255, 255, 255, 255 - (5 - o.health) * 25)
		love.graphics.push()
		love.graphics.translate(o.x, o.y)
		love.graphics.circle("fill", 0, 0, o.r - 3, 17)
		love.graphics.circle("line", 0, 0, o.r + 2, 17)
		love.graphics.pop()
		i = i + 1
	end
	-- draw bullets:
	i = 1
	l = #bullets
	love.graphics.setColor(255, 255, 255, 255)
	while i <= l do
		o = bullets[i]
		love.graphics.circle("fill", o.x, o.y, 6, 13)
		love.graphics.circle("line", o.x, o.y, 9, 13)
		i = i + 1
	end
	-- draw explosions:
	i = 1
	l = #explosions
	while i <= l do
		o = explosions[i]
		love.graphics.setColor(255, 255, 255, 255 * o.a)
		love.graphics.push()
		love.graphics.translate(o.x, o.y)
		love.graphics.circle("fill", 0, 0, o.r - 3 + (1 - o.a) * o.r * 2, 17)
		love.graphics.circle("line", 0, 0, o.r + 2 + (1 - o.a) * o.r * 2, 17)
		love.graphics.pop()
		i = i + 1
	end
	love.graphics.setColor(255, 255, 255, 255)
	-- draw player:
	love.graphics.push()
	love.graphics.translate(player.x, player.y)
	love.graphics.rotate(player.angle)
	-- "body":
	love.graphics.circle("fill", 0, 0, 15, 17)
	love.graphics.circle("line", 0, 0, 18, 17)
	-- "nose":
	love.graphics.circle("fill", 11, 0, 10, 17)
	love.graphics.circle("line", 11, 0, 13, 17)
	-- "left wing"
	love.graphics.circle("fill", -13, -13, 7, 13)
	love.graphics.circle("line", -13, -13, 10, 13)
	-- "right wing"
	love.graphics.circle("fill", -13, 13, 7, 13)
	love.graphics.circle("line", -13, 13, 10, 13)
	love.graphics.pop()
	-- draw interface:
	love.graphics.push()
	love.graphics.translate(width / 2, 0)
	l = width / 6
	i = player.health / player.healthMax * l
	love.graphics.rectangle("line", -l, 5, l*2, 20)
	love.graphics.rectangle("fill", -i, 5, i*2, 20)
	l = string.format(": %d :", score)
	love.graphics.setFont(scoreFont)
	love.graphics.print(l, -scoreFont:getWidth(l) / 2, 25)
	love.graphics.pop()
end
function drawMenu()
	love.graphics.setColor(255, 255, 255, 255)
	local t, w, h, g
	t = "LOVE.blast()"
	w = menuFont:getWidth(t)
	h = menuFont:getHeight(t)
	love.graphics.setFont(menuFont)
	love.graphics.print(t, (width - w) / 2, (height - h) / 2)
	love.graphics.setFont(scoreFont)
	if (score ~= 0) then
		t = string.format(": %d :", score)
		w = scoreFont:getWidth(t)
		g = scoreFont:getHeight(t)
		love.graphics.print(t, (width - w) / 2, (height - h) / 2 - g)
	end
	t = "Press Space to start!"
	w = scoreFont:getWidth(t)
	h = (height + h) / 2
	love.graphics.print(t, (width - w) / 2, h)
	h = h + scoreFont:getHeight(t)
	t = "* WASD & Mouse *"
	w = scoreFont:getWidth(t)
	love.graphics.print(t, (width - w) / 2, h)
end
function love.draw()
	if (state == 0) then drawMenu() end
	if (state == 1) then drawGame() end
love.graphics.print(tostring(#bullets),10,10)
end