if not mobs.mod == "redo" then return end

local l_colors = {
	"#604000:175",	--brown
	"#604000:100",	--brown2
	"#ffffff:150",	--white
	"#404040:150",	--dark_grey
	"#a0a0a0:150",	--grey
	"#808000:150",	--olive
	"#ff0000:150"	--red
}
local l_skins = {
	{"turtle1.png^turtle2.png^turtle3.png^turtle4.png^turtle5.png^turtle6.png^turtle7.png"},
	{"turtle1.png^(turtle2.png^[colorize:"..l_colors[5]..")^(turtle3.png^[colorize:"..l_colors[4]..")^(turtle4.png^[colorize:"..l_colors[1]..")^(turtle5.png^[colorize:"..l_colors[2]..")^(turtle6.png^[colorize:"..l_colors[6]..")^turtle7.png"}
}
local l_anims = {
	speed_normal = 24,	speed_run = 24,
	stand_start = 1,	stand_end = 50,
	walk_start = 60,	walk_end = 90,
	run_start = 60,		run_end = 90,
	hide_start = 95,	hide_end = 100
}
local l_model			= "mobf_turtle.x"
local l_spawn_chance	= 300000

-- land turtle
mobs:register_mob("hades_turtles:turtle", {
	type = "animal",
	passive = true,
	hp_min = 15,
	hp_max = 20,
	armor = 200,
	collisionbox = {-0.4, 0.0, -0.4, 0.4, 0.35, 0.4},
	visual = "mesh",
	mesh = l_model,
	textures = l_skins,
	makes_footstep_sound = false,
	view_range = 8,
	rotate = 270,
	walk_velocity = 0.1,
	run_velocity = 0.3,
	jump = false,
	fly = false,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 3},
	},
	floats = 1,
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	fall_damage = 1,
	animation = l_anims,
	follow = {
		"bakedclay:mannagrass",
		"hades_core:cactus",
		"cucina_vegana:asparagus",
		"cucina_vegana:flax_raw",
		"cucina_vegana:lettuce",
		"cucina_vegana:parsley",
		"cucina_vegana:soy",
		"hades_extrafarming:beans",
		"hades_extrafarming:blueberries",
		"hades_extrafarming:carrot",
		"hades_extrafarming:chili_pepper",
		"hades_extrafarming:cucumber",
		"hades_extrafarming:grapes",
		"hades_extrafarming:hemp_leaf",
		"hades_extrafarming:melon",
		"hades_extrafarming:melon_8",
		"hades_extrafarming:melon_slice",
		"hades_extrafarming:pea_pod",
		"hades_extrafarming:peas",
		"hades_extrafarming:pepper",
		"hades_extrafarming:pepper_yellow",
		"hades_extrafarming:pepper_red",
		"hades_extrafarming:pumpkin",
		"hades_extrafarming:pumpkin_8",
		"hades_extrafarming:pumpkin_slice",
		"hades_extrafarming:raspberries",
		"hades_extrafarming:rhubarb",
		"hades_farming:tomato",
	},
	on_rightclick = function(self, clicker)
		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 60, 80, 100, false, nil) then return end

		self.state = ""
		self.object:setvelocity({
			x = 0, --sin(yaw) * -v
			y = self.object:getvelocity().y,
			z = 0 --cos(yaw) * v
		})
		self.object:set_animation({x=self.animation.hide_start, y=self.animation.hide_end}, self.animation.speed_normal, 0)
		minetest.after(5, function() self.state = "stand" end)
	end
})
--name, nodes, neighbours, minlight, maxlight, interval, chance, active_object_count, min_height, max_height
--[[
mobs:spawn_specific("hades_turtles:turtle",
	{"default:dirt_with_grass","default:jungle_grass","default:sand","default:desert_sand"},
	{"default:dirt_with_grass","default:jungle_grass","default:sand","default:desert_sand","default:papyrus","default:cactus","dryplants:juncus","dryplants:reedmace"},
	5, 20, 30, l_spawn_chance, 1, 1, 5000)
--]]
mobs:register_egg("hades_turtles:turtle", "Turtle", "default_grass.png", 1)

-- sea turtle
mobs:register_mob("hades_turtles:seaturtle", {
	type = "animal",
	passive = true,
	hp_min = 20,
	hp_max = 30,
	armor = 250,
	collisionbox = {-0.8, 0.0, -0.8, 0.8, 0.7, 0.8},
	visual = "mesh",
	visual_size = {x=2,y=2},
	mesh = l_model,
	textures = l_skins,
	makes_footstep_sound = false,
	view_range = 10,
	rotate = 270,
	walk_velocity = 1,
	run_velocity = 1.5,
	stepheight = 1,
	jump = false,
	fly = true,
	fly_in = "default:water_source",
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 3},
	},
	fall_speed = 0,
	floats = 1,
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	fall_damage = 0,
	animation = l_anims,
	follow = {"default:sand_with_kelp"},
	on_rightclick = function(self, clicker)
		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 60, 80, 100, false, nil) then return end
	end
})
--name, nodes, neighbours, minlight, maxlight, interval, chance, active_object_count, min_height, max_height
--[[
mobs:spawn_specific("hades_turtles:seaturtle",
	{"default:water_flowing","default:water_source"},
	{"default:water_flowing","default:water_source","group:seaplants","seawrecks:woodship","seawrecks:uboot"},
	5, 20, 30, l_spawn_chance, 1, -50, 0)
--]]
mobs:register_egg("hades_turtles:seaturtle", "Sea Turtle", "default_water.png", 1)
