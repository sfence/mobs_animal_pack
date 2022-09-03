if not mobs.mod == "redo" then return end

mobs:register_mob("hades_wolf:wolf", {
	type = "animal",
	visual = "mesh",
	mesh = "mobs_wolf.x",
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	animation = {
		speed_normal = 20,	speed_run = 30,
		stand_start = 10,	stand_end = 20,
		walk_start = 75,	walk_end = 100,
		run_start = 100,	run_end = 130,
		punch_start = 135,	punch_end = 155,
	},
	textures = {
		{"mobs_wolf.png"},
	},
	fear_height = 2,
	runaway = false,
	jump = true,
	jump_height = 4,
	fly = false,
	walk_chance = 75,
	walk_velocity = 2,
	run_velocity = 3,
	view_range = 7,
	passive = false,
	attack_type = "dogfight",
	damage = 2,
	reach = 2,
	attacks_monsters = false,
	pathfinding = true,
	group_attack = true,
	hp_min = 4,
	hp_max = 6,
	armor = 200,
	knock_back = 2,
	lava_damage = 5,
	fall_damage = 4,
	makes_footstep_sound = true,
	sounds = {
		war_cry = "mobs_wolf_attack"
	},
	follow = {
		"mobs:meat_raw", "mobs:chicken_raw", "mobs:mutton_raw", "mobs:pork_raw",
		"hades_animalia:beef_raw", "hades_animalia:mutton_raw",
		"hades_animalia:porkchop_raw", "hades_animalia:poultry_raw",
		"hades_paleotest:dinosaurus_meat_raw",
		"hades_paleotest:reptile_meat_raw", "hades_paleotest:fish_meat_raw",
		"hades_petz:raw_ducky", "hades_petz:raw_parrot", "hades_petz:raw_porkchop", "hades_petz:raw_rabbit"
	},
	on_rightclick = function(self, clicker)
		if self.child then
			if mobs:feed_tame(self, clicker, 6, false, true) then
				if self.food == nil then
					self.food = 6
				end
				if self.food == 0 then
					local mob = minetest.add_entity(self.object:get_pos(), "hades_wolf:dog")
					local ent = mob:get_luaentity()
					ent.owner = clicker:get_player_name()
					ent.following = clicker
					ent.order = "follow"
					ent.child = true
				  mob:set_properties({
						visual_size = {
							x = ent.base_size.x * .5,
							y = ent.base_size.y * .5,
						},
						collisionbox = {
							ent.base_colbox[1] * .5,
							ent.base_colbox[2] * .5,
							ent.base_colbox[3] * .5,
							ent.base_colbox[4] * .5,
							ent.base_colbox[5] * .5,
							ent.base_colbox[6] * .5,
						},
						selectionbox = {
							ent.base_selbox[1] * .5,
							ent.base_selbox[2] * .5,
							ent.base_selbox[3] * .5,
							ent.base_selbox[4] * .5,
							ent.base_selbox[5] * .5,
							ent.base_selbox[6] * .5,
						},
					})
					self.object:remove()
				else
					self.food = self.food - 1
				end
				return
			end
		else
			if mobs:feed_tame(self, clicker, 6, true, true) then return end
		end
	end
})

--[[
local l_spawn_elevation_min = minetest.setting_get("water_level")
if l_spawn_elevation_min then
	l_spawn_elevation_min = l_spawn_elevation_min - 5
else
	l_spawn_elevation_min = -5
end
mobs:spawn({
	name = "hades_wolf:wolf",
	nodes = {
		"default:dirt_with_grass",
		"default:dirt_with_snow",
		"default:dirt_with_coniferous_litter",
		"ethereal:green_dirt_top",
	},
	min_light = 10,
	chance = 300000,
	min_height = l_spawn_elevation_min,
	max_height = 5000,
	day_toggle = true,
})
--]]
mobs:register_egg("hades_wolf:wolf", "Wolf", "wool_grey.png", 1)

-- Dog
mobs:register_mob("hades_wolf:dog", {
	type = "animal",
	visual = "mesh",
	mesh = "mobs_wolf.x",
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	animation = {
		speed_normal = 20,	speed_run = 30,
		stand_start = 10,	stand_end = 20,
		walk_start = 75,	walk_end = 100,
		run_start = 100,	run_end = 130,
		punch_start = 135,	punch_end = 155,
	},
	textures = {
		{"mobs_dog.png"},
		{"mobs_medved.png"}
	},
	fear_height = 2,
	runaway = false,
	jump = true,
	jump_height = 4,
	fly = false,
	walk_chance = 75,
	walk_velocity = 2,
	run_velocity = 4,
	view_range = 15,
	passive = false,
	attack_type = "dogfight",
	damage = 2,
	reach = 2,
	attacks_monsters = true,
	pathfinding = true,
	group_attack = true,
	hp_min = 5,
	hp_max = 7,
	armor = 200,
	knock_back = 2,
	lava_damage = 5,
	fall_damage = 5,
	water_damage = 1,
	makes_footstep_sound = true,
	sounds = {
		war_cry = "mobs_wolf_attack"
	},
	follow = {
		"mobs:meat_raw", "mobs:chicken_raw", "mobs:mutton_raw", "mobs:pork_raw",
		"hades_animalia:beef_raw", "hades_animalia:mutton_raw",
		"hades_animalia:porkchop_raw", "hades_animalia:poultry_raw",
		"hades_paleotest:dinosaurus_meat_raw",
		"hades_paleotest:reptile_meat_raw", "hades_paleotest:fish_meat_raw",
		"hades_petz:raw_ducky", "hades_petz:raw_parrot", "hades_petz:raw_porkchop", "hades_petz:raw_rabbit"
	},
	on_rightclick = function(self, clicker)
		if mobs:feed_tame(self, clicker, 6, true, true) then return end
		if mobs:protect(self, clicker) then return end

		if clicker:get_wielded_item():is_empty() and clicker:get_player_name() == self.owner then
			if clicker:get_player_control().sneak then
				self.order = ""
				self.state = "walk"
				self.walk_velocity = 2
				self.stepheight = 0.6
				minetest.chat_send_player(self.owner, "Free!")
			else
				if self.order == "follow" then
					self.order = "stand"
					self.state = "stand"
					self.walk_velocity = 2
					self.stepheight = 0.6
					minetest.chat_send_player(self.owner, "Stand!")
				else
					self.order = "follow"
					self.state = "walk"
					self.walk_velocity = 3
					self.stepheight = 1.1
					minetest.chat_send_player(self.owner, "Follow me!")
				end
			end
			return
		end
		if mobs:capture_mob(self, clicker, 0, 0, 80, false, nil) then return end
	end,
})
minetest.registered_entities["hades_wolf:dog"].follow_flop = function(self)
		-- find player to follow
		if (self.follow ~= "" or self.order == "follow")
		and not self.following
		and self.state ~= "attack"
		and self.state ~= "runaway" then

			local s = self.object:get_pos() ; if not s then return end
			local players = minetest.get_connected_players()
			for n = 1, #players do

				if vector.distance(players[n]:get_pos(), s) < self.view_range
				and not mobs.invis[ players[n]:get_player_name() ] then

					self.following = players[n]
					break
				end
			end
		end
		if self.order ~= "follow" then
			-- stop following player if not holding specific item
			if self.following
			and self.following:is_player()
			and self:follow_holding(self.following) == false then
				self.following = nil
			end
		end
		-- follow that thing
		if self.following then
			local s = self.object:get_pos()
			local p

			if self.following:is_player() then

				p = self.following:get_pos()

			elseif self.following.object then

				p = self.following.object:get_pos()
			end

			if p then

				local dist = vector.distance(p, s)

				-- dont follow if out of range
				if dist > self.view_range then
					self.following = nil
				else
					if self.object then
						mobs.yaw_to_pos(self, self, p)
					end

					-- anyone but standing npc's can move along
					if dist > self.reach
					and self.order ~= "stand" then

						self:set_velocity(self.walk_velocity)

						if self.walk_chance ~= 0 then
							self:set_animation("walk")
						end
					else
						self:set_velocity(0)
						self:set_animation("stand")
					end

					return
				end
			end
		end
	end

mobs:register_egg("hades_wolf:dog", "Dog", "wool_brown.png", 1)
