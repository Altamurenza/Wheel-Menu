--[[
	To add weapons:
	
	1. Create an icon for the weapon with any photo editor you have
	2. Save as ICON_(CODE).png when you're done with that (ex: ICON_EX.png)
	3. Copy (or move) the created icon to '../Bully - Scholarship Edition/_derpy_script_loader/scripts/Wheel Menu/GROUP_01/' folder
	4. Use the function below to register your weapon
	
	GROUP_01_REGISTER(CATEGORY, INDEX, NAME, MAX_AMMO, ICON, CHECK, STATISTIC)
		- CATEGORY		: string (required)
						  choose one among the categories: 'MELEE', 'THROW', 'STYLE', 'SLINGSHOT', 'GUN', 'OTHER'
		- INDEX			: number (required)
						  fill the argument with any weapon id you want
		- NAME			: string (optional)
						  fill the argument with any name you want
						  if nil, wheel menu will automatically name the weapon
		- MAX_AMMO		: number (optional)
						  -1 = hidden, 0 = '1/1', >1 = show (current ammo)/(max ammo)
						  if nil, wheel menu will automatically use recommended setting from its reference
		- ICON			: string (required)
						  fill the argument with a code of icon (ex: ICON_UB.png, fill the argument with 'UB')
		- CHECK			: boolean (optional)
						  true = the mod will not give you the weapon if you don't have one
						  false = the mod will give you the weapon even though you don't have one
						  if nil, wheel menu will recognize it as false
		- STATISTIC		: table (optional)
						  {damage, range, reload, accuracy} --> fill each table content with number, start from 0 to 100
						  if nil, wheel menu will automatically use recommended setting from its reference
	
	Example of adding umbrella to the wheel (ICON_UB.png for Umbrella is already exist in GROUP_01 folder):
		- Simple way	: GROUP_01_REGISTER('MELEE', 404, nil, nil, 'UB', false)
		- Detailed way	: GROUP_01_REGISTER('MELEE', 404, 'Umbrella', 0, 'UB', false, {25, 5, 0, 0})
		
		Both ways will have the same result, unless you want to tweak something in it by choosing the detailed way.
]]

-- These are your 'inventory weapons'
GROUP_01_REGISTER('MELEE', -1, nil, nil, 'FS', true)

GROUP_01_REGISTER('THROW', 301, nil, nil, 'FC', true)
GROUP_01_REGISTER('THROW', 309, nil, nil, 'SB', true)
GROUP_01_REGISTER('THROW', 394, nil, nil, 'IP', true)
GROUP_01_REGISTER('THROW', 349, nil, nil, 'MB', true)
GROUP_01_REGISTER('THROW', 312, nil, nil, 'EC', true)

GROUP_01_REGISTER('STYLE', 437, nil, nil, 'SK', true)
GROUP_01_REGISTER('STYLE', 328, nil, nil, 'CO', true)
GROUP_01_REGISTER('STYLE', 426, nil, nil, 'CD', true)

GROUP_01_REGISTER('SLINGSHOT', 303, nil, nil, 'SS', true)
GROUP_01_REGISTER('SLINGSHOT', 306, nil, nil, 'SSS', true)

GROUP_01_REGISTER('GUN', 305, nil, nil, 'SG', true)
GROUP_01_REGISTER('GUN', 307, nil, nil, 'RL', true)
GROUP_01_REGISTER('GUN', 396, nil, nil, 'SSG', true)

GROUP_01_REGISTER('OTHER', 321, nil, nil, 'SC', true)
GROUP_01_REGISTER('OTHER', 320, nil, nil, 'NP', true)
GROUP_01_REGISTER('OTHER', 325, nil, nil, 'RB', true)
GROUP_01_REGISTER('OTHER', 420, nil, nil, 'FL', true)


--[[
	To add apparels:
	
	1. Use the function below to register your item
	
	GROUP_02_REGISTER(CATEGORY, BODY_PART, MODEL, NAME, STATISTIC)
		- CATEGORY		: string (required)
						  choose one among the categories: 'HEAD', 'TORSO', 'R-HAND', 'L-HAND', 'LEG', 'FEET'
		- BODY_PART		: number (optional)
						  fill the argument with an index of body part, 0 = head, 1 = torso, 2 = left hand, 3 = right hand, 4 = leg, 5 = feet
						  if nil, wheel menu will automatically detect which body part based on the model (except the model is 'none', because it's a hybrid model which can be applied to left hand and right hand)
		- MODEL			: string (required)
						  fill the argument with the file name of clothing model which can be acquired from World.img ..or.. you can also fill it with a special code like 'Hair' or 'none'
		- NAME			: string (optional)
						  fill the argument with any name you want
						  if nil, wheel menu will automatically use a name from its reference
		- STATISTIC		: table (optional)
						  {school, poor, rich, unique} --> fill each table content with number, start from 0 to 100
						  if nil, wheel menu will automatically use recommended setting from its reference
	
	Example of adding bike helmet to the wheel:
		- Simple way	: GROUP_02_REGISTER('HEAD', nil, 'SP_BikeHelmet')
		- Detailed way	: GROUP_02_REGISTER('HEAD', 0, 'SP_BikeHelmet', 'Bike Helmet', {0, 0, 0, 100})
		
		Both ways will have the same result, unless you want to tweak something in it by choosing the detailed way.
]]

-- These are your 'basic clothes' when you undress the player
GROUP_02_REGISTER('HEAD', nil, 'Hair')
GROUP_02_REGISTER('TORSO', nil, 'P_SSleeves11')
GROUP_02_REGISTER('R-HAND', 2, 'none')
GROUP_02_REGISTER('L-HAND', 3, 'none')
GROUP_02_REGISTER('LEG', nil, 'SP_Briefs')
GROUP_02_REGISTER('FEET', nil, 'SP_Socks')


--[[
	To add custom things:
	
	1. Create an icon with any photo editor you have
	2. Save as ICON_(CODE).png when you're done with that (ex: ICON_EX.png)
	3. Copy (or move) the created icon to '../Bully - Scholarship Edition/_derpy_script_loader/scripts/Wheel Menu/GROUP_03/' folder
	4. Use the function below to register anything you desired to add on the wheel
	
	GROUP_03_REGISTER(CATEGORY, NAME, DESCRIPTION, ACTION, ICON, FUNCTION)
		- CATEGORY		: string (required)
						  choose one among the categories: 'BOTTOM', 'BOTTOM_LEFT', 'BOTTOM_RIGHT', 'TOP', 'TOP_LEFT', 'TOP_RIGHT'
		- NAME			: string (required)
						  fill the argument with any name you want
		- DESCRIPTION	: string (optional)
						  fill the argument with a short description to explain the thing
						  if nil, wheel menu will not display anything
		- ACTION		: string (optional)
						  fill the argument with any action name you want (ex: 'Play', 'Stop', 'Drink', 'Kill', etc)
						  if nil, wheel menu will display 'Use' as default
		- ICON			: string (required)
						  fill the argument with a code of icon (ex: ICON_BM.png, fill the argument with 'BM')
		- FUNCTION		: function (required)
						  fill the argument with function to execute once you release the wheel menu key
	
	Example of adding Soda Beam (ICON_BM.png for Soda Beam is already exist in GROUP_03 folder):
		GROUP_03_REGISTER('BOTTOM', 'Soda Beam', 'Restore your health by 75 pts!', 'Drink', 'BM', function()
			PedSetActionNode(gPlayer, '/Global/SodaMach/PedPropsActions/HasSoda/Actions/PickUpSodaAndDrink/PickUpSoda/Drink', 'Act/Props/SodaMach.act')
		end)
]]