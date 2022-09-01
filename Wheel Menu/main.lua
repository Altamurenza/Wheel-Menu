-- WHEEL MENU 1.2
-- AUTHOR	: ALTAMURENZA


--[[
	---------------------
	# WHEEL MENU : MAIN #
	---------------------
]]

function main()
	while not SystemIsReady() or AreaIsLoading() do
		Wait(0)
	end
	
	SETUP_WHEEL()
	
	while true do
		Wait(0)
		
		
		---------------------------------
		-- # WHEEL UI - MENU ACTIVATION #
		---------------------------------
		
		if WHEEL.GENERAL.RULE then
			if shared.WHEEL.GENERAL.WAIT < GetTimer() then
				if AreaIsLoading() or PedMePlaying(gPlayer, 'GetIntoBed') or PedMePlaying(gPlayer, 'GetOutBed') or PedIsPlaying(gPlayer, '/Global/Door/PedPropsActions', true) or MinigameIsShowingCompletion() or MinigameIsShowingGrades() or PlayerFellAsleep() or PedIsDead(gPlayer) then
					shared.WHEEL.GENERAL.WAIT = GetTimer() + ((PlayerFellAsleep() or PedIsDead(gPlayer)) and 2500 or 250)
				end
				if shared.WHEEL.GENERAL.WAIT < GetTimer() and shared.gPSCT[1] and not shared.gPWHL[1] and not shared.gCF[1] and not shared.playerShopping and not shared.PlayerInClothingManager and GetCutsceneRunning() == 0 and _G['Is'..(WHEEL.GENERAL.KEY[6] and 'Button' or 'Key')..'Pressed'](WHEEL.GENERAL.KEY[6] and 14 or WHEEL.GENERAL.KEY[1], WHEEL.GENERAL.KEY[6] and 0 or nil) then
					WHEEL.GENERAL.SHOW = PlayerIsInAnyVehicle() and IS_BIKE(VehicleFromDriver(gPlayer)) or true
				else
					WHEEL.GENERAL.SHOW = false
				end
			else
				WHEEL.GENERAL.SHOW = false
			end
		else
			WHEEL.GENERAL.SHOW = _G['Is'..(WHEEL.GENERAL.KEY[6] and 'Button' or 'Key')..'Pressed'](WHEEL.GENERAL.KEY[6] and 14 or WHEEL.GENERAL.KEY[1], WHEEL.GENERAL.KEY[6] and 0 or nil)
		end
		
		shared.WHEEL.GENERAL.ACTIVE = WHEEL.GENERAL.SHOW
		
		
		---------------------------------
		-- # WHEEL UI - MENU NAVIGATION #
		---------------------------------
		
		if WHEEL.GENERAL.SHOW then
			-----------------------------------------------
			-- # WHEEL UI - MANAGE PANEL, CATEGORY, & TAB #
			-----------------------------------------------
			
			if WHEEL.GENERAL.KEY[6] then
				PlayerLockButtonInputsExcept(true, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 15, 16, 17, 24)
			else
				PlayerLockButtonInputsExcept(true, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 15, 16, 17, 24)
			end
			
			if not WHEEL.GENERAL.GAME.MOTION and shared.gPUS[1] then
				PauseSimulation()
			end
			if not WHEEL.GENERAL.GAME.SOUND and shared.gPCS[1] then
				SoundPause()
			end
			
			WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].MOUSE_X = WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].MOUSE_X + shared.gGSV(18, 0) / 10
			WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].MOUSE_Y = WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].MOUSE_Y + shared.gGSV(19, 0) / 20
			
			WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].MOUSE_X = WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].MOUSE_X > 0.3 and 0.3 or (WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].MOUSE_X < -0.3 and -0.3 or WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].MOUSE_X)
			WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].MOUSE_Y = WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].MOUSE_Y > 0.3 and 0.3 or (WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].MOUSE_Y < -0.3 and -0.3 or WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].MOUSE_Y)
			
			if WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].MOUSE_Y > 0.15 then
				if WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].MOUSE_Y < 0.3 then
					if WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].MOUSE_X > 0.15 then
						WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT = 3
					elseif WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].MOUSE_X < -0.15 then
						WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT = 5
					end
				else
					WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT = 4
				end
			elseif WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].MOUSE_Y < -0.15 then
				if WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].MOUSE_Y > -0.3 then
					if WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].MOUSE_X > 0.15 then
						WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT = 2
					elseif WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].MOUSE_X < -0.15 then
						WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT = 6
					end
				else
					WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT = 1
				end
			end
			
			if WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.PREVIOUS ~= WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT then
				if WHEEL.GENERAL.GAME.SOUND then
					SoundPlay2D('NavUp')
				end
				WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.PREVIOUS = WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT
			end
			
			if table.getn(WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].CONTENT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT]) > 0 and (IsButtonBeingPressed(WHEEL.GENERAL.KEY[4], 0) or IsButtonBeingPressed(WHEEL.GENERAL.KEY[5], 0)) then
				if IsButtonBeingPressed(WHEEL.GENERAL.KEY[5], 0) then
					WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].SELECT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][1] = WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].SELECT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][1] + 1 > table.getn(WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].CONTENT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT]) and 1 or WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].SELECT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][1] + 1
				else
					WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].SELECT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][1] = WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].SELECT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][1] - 1 < 1 and table.getn(WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].CONTENT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT]) or WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].SELECT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][1] - 1
				end
				if WHEEL.GENERAL.TAB[1] == 1 then
					WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].SELECT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][2] = WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].CONTENT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].SELECT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][1]].ID
					WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].SELECT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][3] = WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].CONTENT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].SELECT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][1]].CHECK
				elseif WHEEL.GENERAL.TAB[1] == 2 then
					WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].SELECT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][2] = WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].CONTENT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].SELECT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][1]].CODE[1]
					WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].SELECT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][3] = WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].CONTENT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].SELECT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][1]].CODE[2]
				else
					WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].SELECT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][2] = WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].CONTENT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].SELECT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][1]].NAME
					WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].SELECT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][3] = WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].CONTENT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].SELECT[WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT][1]].FUNCTION
				end
				if WHEEL.GENERAL.GAME.SOUND then
					SoundPlay2D('ButtonUp')
				end
			end
			
			if WHEEL.GENERAL.TAB[2] > 1 and (IsButtonBeingPressed(WHEEL.GENERAL.KEY[2], 0) or IsButtonBeingPressed(WHEEL.GENERAL.KEY[3], 0)) then
				if IsButtonBeingPressed(WHEEL.GENERAL.KEY[3], 0) then
					WHEEL.GENERAL.TAB[1] = WHEEL.GENERAL.TAB[1] + 1 > 3 and 1 or WHEEL.GENERAL.TAB[1] + 1
					while WHEEL.GENERAL.TAB[3][WHEEL.GENERAL.TAB[1]] do
						WHEEL.GENERAL.TAB[1] = WHEEL.GENERAL.TAB[1] + 1 > 3 and 1 or WHEEL.GENERAL.TAB[1] + 1
					end
				else
					WHEEL.GENERAL.TAB[1] = WHEEL.GENERAL.TAB[1] - 1 < 1 and 3 or WHEEL.GENERAL.TAB[1] - 1
					while WHEEL.GENERAL.TAB[3][WHEEL.GENERAL.TAB[1]] do
						WHEEL.GENERAL.TAB[1] = WHEEL.GENERAL.TAB[1] - 1 < 1 and 3 or WHEEL.GENERAL.TAB[1] - 1
					end
				end
			end
		else
			---------------------------------------
			-- # WHEEL UI - MANAGE IMPLEMENTATION #
			---------------------------------------
			
			if _G['Is'..(WHEEL.GENERAL.KEY[6] and 'Button' or 'Key')..'BeingReleased'](WHEEL.GENERAL.KEY[6] and 14 or WHEEL.GENERAL.KEY[1], WHEEL.GENERAL.KEY[6] and 0 or nil) then
				if WHEEL.GENERAL.TAB[1] == 1 then
					if WHEEL.GROUP[1].SELECT[WHEEL.GROUP[1].OPTION.CURRENT][2] ~= PedGetWeapon(gPlayer) and (WHEEL.GROUP[1].SELECT[WHEEL.GROUP[1].OPTION.CURRENT][3] == false or WHEEL.GROUP[1].SELECT[WHEEL.GROUP[1].OPTION.CURRENT][2] == -1 or ItemGetCurrentNum(NI_AMMO[WHEEL.GROUP[1].SELECT[WHEEL.GROUP[1].OPTION.CURRENT][2]] or WHEEL.GROUP[1].SELECT[WHEEL.GROUP[1].OPTION.CURRENT][2]) > 0) then
						PlayerSetWeapon(WHEEL.GROUP[1].SELECT[WHEEL.GROUP[1].OPTION.CURRENT][2], WHEEL.GROUP[1].SELECT[WHEEL.GROUP[1].OPTION.CURRENT][3] == false and 1 or ItemGetCurrentNum(NI_AMMO[WHEEL.GROUP[1].SELECT[WHEEL.GROUP[1].OPTION.CURRENT][2]] or WHEEL.GROUP[1].SELECT[WHEEL.GROUP[1].OPTION.CURRENT][2]), false)
					end
				elseif WHEEL.GENERAL.TAB[1] == 2 then
					if PedIsModel(gPlayer, 0) and WHEEL.GROUP[2].SELECT[WHEEL.GROUP[2].OPTION.CURRENT][2] ~= -1 and ClothingGetPlayer(WHEEL.GROUP[2].SELECT[WHEEL.GROUP[2].OPTION.CURRENT][2]) ~= ObjectNameToHashID(WHEEL.GROUP[2].SELECT[WHEEL.GROUP[2].OPTION.CURRENT][3]) then
						if PedMePlaying(gPlayer, 'DEFAULT_KEY') then
							ClothingSetPlayer(WHEEL.GROUP[2].SELECT[WHEEL.GROUP[2].OPTION.CURRENT][2], WHEEL.GROUP[2].SELECT[WHEEL.GROUP[2].OPTION.CURRENT][3])
							ClothingBuildPlayer(true)
						else
							shared.WHEEL.GROUP[2].QUEUE = {WHEEL.GROUP[2].SELECT[WHEEL.GROUP[2].OPTION.CURRENT][2], WHEEL.GROUP[2].SELECT[WHEEL.GROUP[2].OPTION.CURRENT][3]}
						end
					end
				else
					if type(WHEEL.GROUP[3].SELECT[WHEEL.GROUP[3].OPTION.CURRENT][3]) == 'function' then
						WHEEL.GROUP[3].SELECT[WHEEL.GROUP[3].OPTION.CURRENT][3]()
					end
				end
			end
			
			if WHEEL.GENERAL.GAME.FILTER.SHOW and WHEEL.GENERAL.GAME.FILTER.FADE and WHEEL.COMPONENT.BACK.FILTER ~= 0 then
				WHEEL.COMPONENT.BACK.FILTER = WHEEL.COMPONENT.BACK.FILTER - (WHEEL.COMPONENT.BACK.COLOR.OPACITY[2]/30) < 0 and 0 or WHEEL.COMPONENT.BACK.FILTER - (WHEEL.COMPONENT.BACK.COLOR.OPACITY[2]/30)
				DrawRectangle(0, 0, 1, 1, WHEEL.COMPONENT.BACK.COLOR.RED[3], WHEEL.COMPONENT.BACK.COLOR.GREEN[3], WHEEL.COMPONENT.BACK.COLOR.BLUE[3], WHEEL.COMPONENT.BACK.FILTER)
			end
			
			if WHEEL.GENERAL.KEY[6] then
				PlayerLockButtonInputsExcept(true, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 15, 16, 17, 18, 19, 24)
			else
				PlayerLockButtonInputsExcept(true, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 15, 16, 17, 18, 19, 24)
			end
			
			if not WHEEL.GENERAL.GAME.MOTION and not shared.gPUS[1] then
				UnpauseSimulation()
			end
			if not WHEEL.GENERAL.GAME.SOUND and not shared.gPCS[1] then
				SoundContinue()
			end
		end
		
		
		----------------------------
		-- # WHEEL UI - COMPONENTS #
		----------------------------
		
		if WHEEL.GENERAL.SHOW then
			----------------------------------------------
			-- # WHEEL UI - MANAGE BACKGROUND COMPONENTS #
			----------------------------------------------
			
			if WHEEL.GENERAL.GAME.FILTER.SHOW then
				DrawRectangle(0, 0, 1, 1, WHEEL.COMPONENT.BACK.COLOR.RED[3], WHEEL.COMPONENT.BACK.COLOR.GREEN[3], WHEEL.COMPONENT.BACK.COLOR.BLUE[3], WHEEL.COMPONENT.BACK.COLOR.OPACITY[2])
				if WHEEL.GENERAL.GAME.FILTER.FADE and WHEEL.COMPONENT.BACK.FILTER ~= WHEEL.COMPONENT.BACK.COLOR.OPACITY[2] then
					WHEEL.COMPONENT.BACK.FILTER = WHEEL.COMPONENT.BACK.COLOR.OPACITY[2]
				end
			end
			
			for ID, PART in ipairs(WHEEL.COMPONENT.BACK.FILE) do
				SetTextureBounds(WHEEL.COMPONENT.BACK.TEXTURE[PART..'_T'], 0, 0, 1, 1)
				DrawTexture(WHEEL.COMPONENT.BACK.TEXTURE[PART..'_T'], WHEEL.COMPONENT.BACK.X, WHEEL.COMPONENT.BACK.Y, WHEEL.COMPONENT.BACK.SCALE * WHEEL.COMPONENT.BACK.TEXTURE[PART..'_R'], WHEEL.COMPONENT.BACK.SCALE, ID == WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT and WHEEL.COMPONENT.BACK.COLOR.RED[2] or WHEEL.COMPONENT.BACK.COLOR.RED[1], ID == WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT and WHEEL.COMPONENT.BACK.COLOR.GREEN[2] or WHEEL.COMPONENT.BACK.COLOR.GREEN[1], ID == WHEEL.GROUP[WHEEL.GENERAL.TAB[1]].OPTION.CURRENT and WHEEL.COMPONENT.BACK.COLOR.BLUE[2] or WHEEL.COMPONENT.BACK.COLOR.BLUE[1], WHEEL.COMPONENT.BACK.COLOR.OPACITY[1])
			end
			
			SetTextureBounds(WHEEL.COMPONENT.BACK.TEXTURE.MID_T, 0, 0, 1, 1)
			DrawTexture(WHEEL.COMPONENT.BACK.TEXTURE.MID_T, WHEEL.COMPONENT.BACK.X, WHEEL.COMPONENT.BACK.Y, WHEEL.COMPONENT.BACK.SCALE * WHEEL.COMPONENT.BACK.TEXTURE.MID_R, WHEEL.COMPONENT.BACK.SCALE, WHEEL.COMPONENT.BACK.COLOR.RED[1], WHEEL.COMPONENT.BACK.COLOR.GREEN[1], WHEEL.COMPONENT.BACK.COLOR.BLUE[1], WHEEL.COMPONENT.BACK.COLOR.OPACITY[1])
			
			if WHEEL.GENERAL.TAB[2] > 1 then
				DrawRectangle(0.447, 0.142, 0.1, 0.06, WHEEL.COMPONENT.BACK.COLOR.RED[1], WHEEL.COMPONENT.BACK.COLOR.GREEN[1], WHEEL.COMPONENT.BACK.COLOR.BLUE[1], WHEEL.COMPONENT.BACK.COLOR.OPACITY[1])
			end
			
			
			----------------------------------------------
			-- # WHEEL UI - MANAGE FOREGROUND COMPONENTS #
			----------------------------------------------
			
			if WHEEL.GENERAL.TAB[2] > 1 then
				for GROUP = 1, 3 do
					if not WHEEL.GENERAL.TAB[3][GROUP] then
						SetTextureBounds(WHEEL.COMPONENT.FRONT.TEXTURE['DOT_'..GROUP..'_T'], 0, 0, 1, 1)
						DrawTexture(WHEEL.COMPONENT.FRONT.TEXTURE['DOT_'..GROUP..'_T'], WHEEL.COMPONENT.FRONT.DOT_X[WHEEL.GENERAL.TAB[2]][WHEEL.GENERAL.TAB[3][1] and (GROUP == 2 and 1 or GROUP - 1) or (GROUP == 3 and (WHEEL.GENERAL.TAB[2] < 3 and 2 or GROUP) or GROUP)], WHEEL.COMPONENT.FRONT.DOT_Y, 0.01 * WHEEL.COMPONENT.FRONT.TEXTURE['DOT_'..GROUP..'_R'], 0.01, WHEEL.GENERAL.TAB[1] == GROUP and WHEEL.COMPONENT.FRONT.COLOR.DOT.RED[2] or WHEEL.COMPONENT.FRONT.COLOR.DOT.RED[1], WHEEL.GENERAL.TAB[1] == GROUP and WHEEL.COMPONENT.FRONT.COLOR.DOT.GREEN[2] or WHEEL.COMPONENT.FRONT.COLOR.DOT.GREEN[1], WHEEL.GENERAL.TAB[1] == GROUP and WHEEL.COMPONENT.FRONT.COLOR.DOT.BLUE[2] or WHEEL.COMPONENT.FRONT.COLOR.DOT.BLUE[1], WHEEL.COMPONENT.FRONT.COLOR.DOT.OPACITY)
					end
				end
				
				DRAW_TEXT(({'WEAPON', 'APPAREL', 'CUSTOM'})[WHEEL.GENERAL.TAB[1]], 0.8, 0.497, 0.150, 'center', WHEEL.COMPONENT.FRONT.COLOR.TEXT.OPACITY, 'Arial')
			end
			
			for CATEGORY = 1, 6 do
				if WHEEL.GROUP[1].ENABLE and WHEEL.GENERAL.TAB[1] == 1 then
					for ID, CONTENT in ipairs(WHEEL.GROUP[1].CONTENT[CATEGORY]) do
						if ID == WHEEL.GROUP[1].SELECT[CATEGORY][1] then
							SetTextureBounds(WHEEL.COMPONENT.FRONT.TEXTURE['ICON_01_'..CONTENT.ICON..'_T'], 0, 0, 1, 1)
							DrawTexture(WHEEL.COMPONENT.FRONT.TEXTURE['ICON_01_'..CONTENT.ICON..'_T'], WHEEL.COMPONENT.FRONT.ICON_X[CATEGORY], WHEEL.COMPONENT.FRONT.ICON_Y[CATEGORY], WHEEL.COMPONENT.FRONT.SCALE * WHEEL.COMPONENT.FRONT.TEXTURE['ICON_01_'..CONTENT.ICON..'_R'], WHEEL.COMPONENT.FRONT.SCALE, WHEEL.COMPONENT.FRONT.COLOR.ICON.RED, WHEEL.COMPONENT.FRONT.COLOR.ICON.GREEN, WHEEL.COMPONENT.FRONT.COLOR.ICON.BLUE, WHEEL.COMPONENT.FRONT.COLOR.ICON.OPACITY)
							
							DRAW_TEXT(CONTENT.AMMO == 0 and '1/1' or ItemGetCurrentNum(NI_AMMO[WHEEL.GROUP[1].SELECT[CATEGORY][2]] or WHEEL.GROUP[1].SELECT[CATEGORY][2])..'/'..CONTENT.AMMO, 0.8, WHEEL.COMPONENT.FRONT.AMMO_X[CATEGORY], WHEEL.COMPONENT.FRONT.AMMO_Y[CATEGORY], 'center', CONTENT.AMMO == -1 and 0 or WHEEL.COMPONENT.FRONT.COLOR.TEXT.OPACITY, 'Arial')
							if CATEGORY == WHEEL.GROUP[1].OPTION.CURRENT then
								DRAW_TEXT(CONTENT.NAME..'\n< '..WHEEL.GROUP[1].SELECT[CATEGORY][1]..' / '..table.getn(WHEEL.GROUP[1].CONTENT[CATEGORY])..' >', 0.6, WHEEL.COMPONENT.FRONT.INFO_X[1], WHEEL.COMPONENT.FRONT.INFO_Y[1], 'center', WHEEL.COMPONENT.FRONT.COLOR.TEXT.OPACITY, 'Arial')
								DRAW_TEXT('Damage\n\nRange\n\nReload\n\nAccuracy', 0.6, WHEEL.COMPONENT.FRONT.INFO_X[2], WHEEL.COMPONENT.FRONT.INFO_Y[2], 'left', WHEEL.COMPONENT.FRONT.COLOR.TEXT.OPACITY, 'Arial')
								DRAW_TEXT('Release ['..(WHEEL.GENERAL.KEY[6] and 'L3' or WHEEL.GENERAL.KEY[1])..'] to Use', 0.6, WHEEL.COMPONENT.FRONT.INFO_X[3], WHEEL.COMPONENT.FRONT.INFO_Y[3], 'center', WHEEL.COMPONENT.FRONT.COLOR.TEXT.OPACITY, 'Arial')
								
								for STAT = 1, 4 do
									SetTextureBounds(WHEEL.COMPONENT.FRONT.TEXTURE['BAR_01_'..STAT..'_BG_T'], 0, 0, 1, 1)
									DrawTexture(WHEEL.COMPONENT.FRONT.TEXTURE['BAR_01_'..STAT..'_BG_T'], WHEEL.COMPONENT.FRONT.BAR_X, WHEEL.COMPONENT.FRONT.BAR_Y[STAT], (WHEEL.COMPONENT.FRONT.SCALE + 0.005) * WHEEL.COMPONENT.FRONT.TEXTURE['BAR_01_'..STAT..'_BG_R'],  WHEEL.COMPONENT.FRONT.SCALE + 0.005, WHEEL.COMPONENT.FRONT.COLOR.BAR.RED[2], WHEEL.COMPONENT.FRONT.COLOR.BAR.GREEN[2], WHEEL.COMPONENT.FRONT.COLOR.BAR.BLUE[2], WHEEL.COMPONENT.FRONT.COLOR.BAR.OPACITY)
									
									if not WHEEL.GROUP[1].SELECT[CATEGORY][4] or WHEEL.GROUP[1].SELECT[CATEGORY][4] ~= (100-CONTENT.STAT[STAT])/100 then
										WHEEL.GROUP[1].SELECT[CATEGORY][4] = (100-CONTENT.STAT[STAT])/100
									end
									
									SetTextureBounds(WHEEL.COMPONENT.FRONT.TEXTURE['BAR_01_'..STAT..'_T'], 1 - WHEEL.GROUP[1].SELECT[CATEGORY][4], 0, 1, 1)
									DrawTexture(WHEEL.COMPONENT.FRONT.TEXTURE['BAR_01_'..STAT..'_T'], WHEEL.COMPONENT.FRONT.BAR_X + (1 - WHEEL.GROUP[1].SELECT[CATEGORY][4]) * (WHEEL.COMPONENT.FRONT.SCALE + 0.014), WHEEL.COMPONENT.FRONT.BAR_Y[STAT], (WHEEL.COMPONENT.FRONT.SCALE + 0.014) * WHEEL.GROUP[1].SELECT[CATEGORY][4], (WHEEL.COMPONENT.FRONT.SCALE + 0.014) / WHEEL.COMPONENT.FRONT.TEXTURE['BAR_01_'..STAT..'_R'], WHEEL.COMPONENT.FRONT.COLOR.BAR.RED[1], WHEEL.COMPONENT.FRONT.COLOR.BAR.GREEN[1], WHEEL.COMPONENT.FRONT.COLOR.BAR.BLUE[1], WHEEL.COMPONENT.FRONT.COLOR.BAR.OPACITY)
								end
							end
						end
					end
				end
				
				if WHEEL.GROUP[2].ENABLE and WHEEL.GENERAL.TAB[1] == 2 then
					for ID, CONTENT in ipairs(WHEEL.GROUP[2].CONTENT[CATEGORY]) do
						if ID == WHEEL.GROUP[2].SELECT[CATEGORY][1] then
							SetTextureBounds(WHEEL.COMPONENT.FRONT.TEXTURE['ICON_02_'..CATEGORY..'_T'], 0, 0, 1, 1)
							DrawTexture(WHEEL.COMPONENT.FRONT.TEXTURE['ICON_02_'..CATEGORY..'_T'], WHEEL.COMPONENT.FRONT.ICON_X[CATEGORY], WHEEL.COMPONENT.FRONT.ICON_Y[CATEGORY], WHEEL.COMPONENT.FRONT.SCALE * WHEEL.COMPONENT.FRONT.TEXTURE['ICON_02_'..CATEGORY..'_R'], WHEEL.COMPONENT.FRONT.SCALE, WHEEL.COMPONENT.FRONT.COLOR.ICON.RED, WHEEL.COMPONENT.FRONT.COLOR.ICON.GREEN, WHEEL.COMPONENT.FRONT.COLOR.ICON.BLUE, WHEEL.COMPONENT.FRONT.COLOR.ICON.OPACITY)
							
							if CATEGORY == WHEEL.GROUP[2].OPTION.CURRENT then
								DRAW_TEXT(CONTENT.NAME..'\n< '..WHEEL.GROUP[2].SELECT[CATEGORY][1]..' / '..table.getn(WHEEL.GROUP[2].CONTENT[CATEGORY])..' >', 0.6, WHEEL.COMPONENT.FRONT.INFO_X[1], WHEEL.COMPONENT.FRONT.INFO_Y[1], 'center', WHEEL.COMPONENT.FRONT.COLOR.TEXT.OPACITY, 'Arial')
								DRAW_TEXT('School\n\nPoor\n\nRich\n\nUnique', 0.6, WHEEL.COMPONENT.FRONT.INFO_X[2], WHEEL.COMPONENT.FRONT.INFO_Y[2], 'left', WHEEL.COMPONENT.FRONT.COLOR.TEXT.OPACITY, 'Arial')
								DRAW_TEXT('Release ['..(WHEEL.GENERAL.KEY[6] and 'L3' or WHEEL.GENERAL.KEY[1])..'] to Apply', 0.6, WHEEL.COMPONENT.FRONT.INFO_X[3], WHEEL.COMPONENT.FRONT.INFO_Y[3], 'center', WHEEL.COMPONENT.FRONT.COLOR.TEXT.OPACITY, 'Arial')
						
								for STAT = 1, 4 do
									SetTextureBounds(WHEEL.COMPONENT.FRONT.TEXTURE['BAR_02_'..STAT..'_BG_T'], 0, 0, 1, 1)
									DrawTexture(WHEEL.COMPONENT.FRONT.TEXTURE['BAR_02_'..STAT..'_BG_T'], WHEEL.COMPONENT.FRONT.BAR_X, WHEEL.COMPONENT.FRONT.BAR_Y[STAT], (WHEEL.COMPONENT.FRONT.SCALE + 0.005) * WHEEL.COMPONENT.FRONT.TEXTURE['BAR_02_'..STAT..'_BG_R'],  WHEEL.COMPONENT.FRONT.SCALE + 0.005, WHEEL.COMPONENT.FRONT.COLOR.BAR.RED[2], WHEEL.COMPONENT.FRONT.COLOR.BAR.GREEN[2], WHEEL.COMPONENT.FRONT.COLOR.BAR.BLUE[2], WHEEL.COMPONENT.FRONT.COLOR.BAR.OPACITY)
									
									if not WHEEL.GROUP[2].SELECT[CATEGORY][4] or WHEEL.GROUP[2].SELECT[CATEGORY][4] ~= (100-CONTENT.STAT[STAT])/100 then
										WHEEL.GROUP[2].SELECT[CATEGORY][4] = (100-CONTENT.STAT[STAT])/100
									end
									
									SetTextureBounds(WHEEL.COMPONENT.FRONT.TEXTURE['BAR_02_'..STAT..'_T'], 1 - WHEEL.GROUP[2].SELECT[CATEGORY][4], 0, 1, 1)
									DrawTexture(WHEEL.COMPONENT.FRONT.TEXTURE['BAR_02_'..STAT..'_T'], WHEEL.COMPONENT.FRONT.BAR_X + (1 - WHEEL.GROUP[2].SELECT[CATEGORY][4]) * (WHEEL.COMPONENT.FRONT.SCALE + 0.014), WHEEL.COMPONENT.FRONT.BAR_Y[STAT], (WHEEL.COMPONENT.FRONT.SCALE + 0.014) * WHEEL.GROUP[2].SELECT[CATEGORY][4], (WHEEL.COMPONENT.FRONT.SCALE + 0.014) / WHEEL.COMPONENT.FRONT.TEXTURE['BAR_02_'..STAT..'_R'], WHEEL.COMPONENT.FRONT.COLOR.BAR.RED[1], WHEEL.COMPONENT.FRONT.COLOR.BAR.GREEN[1], WHEEL.COMPONENT.FRONT.COLOR.BAR.BLUE[1], WHEEL.COMPONENT.FRONT.COLOR.BAR.OPACITY)
								end
							end
						end
					end
				end
				
				if WHEEL.GROUP[3].ENABLE and WHEEL.GENERAL.TAB[1] == 3 then
					for ID, CONTENT in ipairs(WHEEL.GROUP[3].CONTENT[CATEGORY]) do
						if CONTENT.NAME == WHEEL.GROUP[3].SELECT[CATEGORY][2] then
							SetTextureBounds(WHEEL.COMPONENT.FRONT.TEXTURE['ICON_03_'..CONTENT.ICON..'_T'], 0, 0, 1, 1)
							DrawTexture(WHEEL.COMPONENT.FRONT.TEXTURE['ICON_03_'..CONTENT.ICON..'_T'], WHEEL.COMPONENT.FRONT.ICON_X[CATEGORY], WHEEL.COMPONENT.FRONT.ICON_Y[CATEGORY], WHEEL.COMPONENT.FRONT.SCALE * WHEEL.COMPONENT.FRONT.TEXTURE['ICON_03_'..CONTENT.ICON..'_R'], WHEEL.COMPONENT.FRONT.SCALE, WHEEL.COMPONENT.FRONT.COLOR.ICON.RED, WHEEL.COMPONENT.FRONT.COLOR.ICON.GREEN, WHEEL.COMPONENT.FRONT.COLOR.ICON.BLUE, WHEEL.COMPONENT.FRONT.COLOR.ICON.OPACITY)
							
							if CATEGORY == WHEEL.GROUP[3].OPTION.CURRENT then
								DRAW_TEXT(CONTENT.NAME..'\n< '..WHEEL.GROUP[3].SELECT[CATEGORY][1]..' / '..table.getn(WHEEL.GROUP[3].CONTENT[CATEGORY])..' >', 0.6, WHEEL.COMPONENT.FRONT.INFO_X[1], WHEEL.COMPONENT.FRONT.INFO_Y[1], 'center', WHEEL.COMPONENT.FRONT.COLOR.TEXT.OPACITY, 'Arial')
								DRAW_TEXT(CONTENT.DESCRIPTION, 0.8, WHEEL.COMPONENT.FRONT.INFO_X[3], 0.485, 'center', WHEEL.COMPONENT.FRONT.COLOR.TEXT.OPACITY, 'Arial')
								DRAW_TEXT('Release ['..(WHEEL.GENERAL.KEY[6] and 'L3' or WHEEL.GENERAL.KEY[1])..'] to '..CONTENT.ACTION, 0.6, WHEEL.COMPONENT.FRONT.INFO_X[3], WHEEL.COMPONENT.FRONT.INFO_Y[3], 'center', WHEEL.COMPONENT.FRONT.COLOR.TEXT.OPACITY, 'Arial')
							end
						end
					end
				end
			end
		end
		
		
		--------------------------------------
		-- # WHEEL UI - NON-INVENTORY WEAPON #
		--------------------------------------
		
		X, Y, Z = PlayerGetPosXYZ()
		for ID, _ in pairs(NI_WEAPON) do
			PickupDestroyTypeInAreaXYZ(X, Y, Z, 1, ID)
		end
		
		
		-------------------------------------
		-- # WHEEL UI - CLOTHING ADAPTATION #
		-------------------------------------
		
		if shared.WHEEL.GROUP[2].REBUILD then
			CLOTHING_REBUILD_CONTENT()
		end
		if type(shared.WHEEL.GROUP[2].QUEUE) == 'table' and PedMePlaying(gPlayer, 'DEFAULT_KEY') then
			ClothingSetPlayer(unpack(shared.WHEEL.GROUP[2].QUEUE))
			ClothingBuildPlayer(true)
			shared.WHEEL.GROUP[2].QUEUE = nil
		end
	end
end


--[[
	----------------------
	# WHEEL MENU : SETUP #
	----------------------
]]

SETUP_WHEEL = function()
	------------------------------------------------------------
	-- # GLOBAL VARIABLES & SHARED VARIABLES OF THE WHEEL MENU #
	------------------------------------------------------------
	
	WHEEL = {
		GROUP = {
			[1] = {
				ENABLE = true, CONTENT = {{}, {}, {}, {}, {}, {}}, OPTION = {PREVIOUS = 1, CURRENT = 1}, SELECT = {}, MOUSE_X = 0, MOUSE_Y = 0,
			},
			[2] = {
				ENABLE = true, CONTENT = {{}, {}, {}, {}, {}, {}}, OPTION = {PREVIOUS = 1, CURRENT = 1}, SELECT = {}, MOUSE_X = 0, MOUSE_Y = 0,
			},
			[3] = {
				ENABLE = true, CONTENT = {{}, {}, {}, {}, {}, {}}, OPTION = {PREVIOUS = 1, CURRENT = 1}, SELECT = {}, MOUSE_X = 0, MOUSE_Y = 0,
			},
		},
		COMPONENT = {
			BACK = {
				FILE = {'BOT_M', 'BOT_L', 'TOP_L', 'TOP_M', 'TOP_R', 'BOT_R'}, TEXTURE = {}, SCALE = 0.65, OPACITY = 180, X = 0.315, Y = 0.180, COLOR = {RED = {0, 140, 0}, GREEN = {0, 100, 0}, BLUE = {0, 0, 0}, OPACITY = {180, 150}}, FILTER = 0,
			},
			FRONT = {
				TEXTURE = {}, SCALE = 0.07, COLOR = {BAR = {RED = {0, 140}, GREEN = {0, 100}, BLUE = {0, 0}, OPACITY = 180}, DOT = {RED = {50, 255}, GREEN = {50, 255}, BLUE = {50, 255}, OPACITY = 255}, ICON = {RED = 255, GREEN = 255, BLUE = 255, OPACITY = 255}, TEXT = {RED = 255, GREEN = 255, BLUE = 255, OPACITY = 255}},
				ICON_X = {0.477, 0.360, 0.355, 0.477, 0.600, 0.600}, AMMO_X = {0.500, 0.400, 0.365, 0.500, 0.630, 0.595}, INFO_X = {0.497, 0.422, 0.497}, DOT_X = {[2] = {0.491, 0.502}, [3] = {0.485, 0.496, 0.507}}, BAR_X = 0.49,
				ICON_Y = {0.715, 0.585, 0.360, 0.225, 0.360, 0.585}, AMMO_Y = {0.757, 0.665, 0.445, 0.275, 0.445, 0.665}, INFO_Y = {0.355, 0.443, 0.615}, DOT_Y = 0.18, BAR_Y = {0.4155, 0.4505, 0.4855, 0.5205},
			},
		},
		GENERAL = {
			KEY = {'Q', 0, 1, 11, 13, false}, TAB = {1, 3, {}}, GAME = {MOTION = false, SOUND = false, FILTER = {SHOW = true, FADE = true}}, SHOW = false, RULE = true, CONFIG = nil
		},
	}
	shared.WHEEL = {
		GROUP = {
			[1] = {REBUILD = false, QUEUE = nil},
			[2] = {REBUILD = false, QUEUE = nil},
			[3] = {REBUILD = false, QUEUE = nil},
		},
		GENERAL = {ACTIVE = false, WAIT = GetTimer() + 1000},
	}
	
	NI_WEAPON, NI_AMMO, X, Y, Z = {}, {[305] = 316, [307] = 308, [396] = 316}, PlayerGetPosXYZ()
	
	
	----------------------------------
	-- # LOAD EXTERNAL CONFIGURATION #
	----------------------------------
	
	WHEEL.GENERAL.CONFIG = LoadConfigFile('config.ini')
	
	if not IsConfigMissing(WHEEL.GENERAL.CONFIG) then
		for ID, KEY in ipairs({'weapon', 'apparel', 'custom'}) do
			WHEEL.GROUP[ID].ENABLE = GetConfigBoolean(WHEEL.GENERAL.CONFIG, 'tab_'..KEY, WHEEL.GROUP[ID].ENABLE)
			if not WHEEL.GROUP[ID].ENABLE then
				WHEEL.GENERAL.TAB[2], WHEEL.GENERAL.TAB[3][ID] = WHEEL.GENERAL.TAB[2] - 1 < 1 and 0 or WHEEL.GENERAL.TAB[2] - 1, true
			end
		end
		if WHEEL.GENERAL.TAB[2] > 0 then
			while WHEEL.GENERAL.TAB[3][WHEEL.GENERAL.TAB[1]] do
				WHEEL.GENERAL.TAB[1] = WHEEL.GENERAL.TAB[1] - 1 < 1 and 3 or WHEEL.GENERAL.TAB[1] - 1
				if not WHEEL.GENERAL.TAB[3][WHEEL.GENERAL.TAB[1] - 1] then
					WHEEL.GENERAL.TAB[1] = WHEEL.GENERAL.TAB[1] - 1
				end
			end
		else
			PrintWarning('Terminated.')
			PrintWarning('See "../_derpy_script_loader/scripts/Wheel Menu/config.ini" for more information.')
			TerminateCurrentScript()
			while true do
				Wait(0)
			end
		end
		
		for _, COLOR in ipairs({'red', 'green', 'blue'}) do
			WHEEL.COMPONENT.BACK.COLOR[string.upper(COLOR)][1] = GetConfigNumber(WHEEL.GENERAL.CONFIG, 'panel_'..COLOR, WHEEL.COMPONENT.BACK.COLOR[string.upper(COLOR)][1])
			WHEEL.COMPONENT.BACK.COLOR[string.upper(COLOR)][2] = GetConfigNumber(WHEEL.GENERAL.CONFIG, 'selected_panel_'..COLOR, WHEEL.COMPONENT.BACK.COLOR[string.upper(COLOR)][2])
			WHEEL.COMPONENT.BACK.COLOR[string.upper(COLOR)][3] = GetConfigNumber(WHEEL.GENERAL.CONFIG, 'filter_'..COLOR, WHEEL.COMPONENT.BACK.COLOR[string.upper(COLOR)][3])
			WHEEL.COMPONENT.FRONT.COLOR.BAR[string.upper(COLOR)][1] = GetConfigNumber(WHEEL.GENERAL.CONFIG, 'bar_'..COLOR, WHEEL.COMPONENT.FRONT.COLOR.BAR[string.upper(COLOR)][1])
			WHEEL.COMPONENT.FRONT.COLOR.BAR[string.upper(COLOR)][2] = GetConfigNumber(WHEEL.GENERAL.CONFIG, 'filled_bar_'..COLOR, WHEEL.COMPONENT.FRONT.COLOR.BAR[string.upper(COLOR)][2])
			WHEEL.COMPONENT.FRONT.COLOR.DOT[string.upper(COLOR)][1] = GetConfigNumber(WHEEL.GENERAL.CONFIG, 'dot_'..COLOR, WHEEL.COMPONENT.FRONT.COLOR.DOT[string.upper(COLOR)][1])
			WHEEL.COMPONENT.FRONT.COLOR.DOT[string.upper(COLOR)][2] = GetConfigNumber(WHEEL.GENERAL.CONFIG, 'selected_dot_'..COLOR, WHEEL.COMPONENT.FRONT.COLOR.DOT[string.upper(COLOR)][2])
			WHEEL.COMPONENT.FRONT.COLOR.ICON[string.upper(COLOR)] = GetConfigNumber(WHEEL.GENERAL.CONFIG, 'icon_'..COLOR, WHEEL.COMPONENT.FRONT.COLOR.ICON[string.upper(COLOR)])
			WHEEL.COMPONENT.FRONT.COLOR.TEXT[string.upper(COLOR)] = GetConfigNumber(WHEEL.GENERAL.CONFIG, 'text_'..COLOR, WHEEL.COMPONENT.FRONT.COLOR.TEXT[string.upper(COLOR)])
		end
		
		WHEEL.COMPONENT.BACK.COLOR.OPACITY[1] = GetConfigNumber(WHEEL.GENERAL.CONFIG, 'panel_opacity', WHEEL.COMPONENT.BACK.COLOR.OPACITY[1])
		WHEEL.COMPONENT.BACK.COLOR.OPACITY[2] = GetConfigNumber(WHEEL.GENERAL.CONFIG, 'filter_opacity', WHEEL.COMPONENT.BACK.COLOR.OPACITY[2])
		WHEEL.COMPONENT.FRONT.COLOR.BAR.OPACITY = GetConfigNumber(WHEEL.GENERAL.CONFIG, 'bar_opacity', WHEEL.COMPONENT.FRONT.COLOR.BAR.OPACITY)
		WHEEL.COMPONENT.FRONT.COLOR.DOT.OPACITY = GetConfigNumber(WHEEL.GENERAL.CONFIG, 'dot_opacity', WHEEL.COMPONENT.FRONT.COLOR.DOT.OPACITY)
		WHEEL.COMPONENT.FRONT.COLOR.ICON.OPACITY = GetConfigNumber(WHEEL.GENERAL.CONFIG, 'icon_opacity', WHEEL.COMPONENT.FRONT.COLOR.ICON.OPACITY)
		WHEEL.COMPONENT.FRONT.COLOR.TEXT.OPACITY = GetConfigNumber(WHEEL.GENERAL.CONFIG, 'text_opacity', WHEEL.COMPONENT.FRONT.COLOR.TEXT.OPACITY)
		
		for ID, KEY in ipairs({'wheel_menu', 'prev_tab', 'next_tab', 'prev_category', 'next_category'}) do
			WHEEL.GENERAL.KEY[ID] = _G['GetConfig'..(ID == 1 and 'Value' or 'Number')](WHEEL.GENERAL.CONFIG, 'key_'..KEY, WHEEL.GENERAL.KEY[ID])
			if ID == 1 then
				if not tonumber(WHEEL.GENERAL.KEY[1]) then
					WHEEL.GENERAL.KEY[1] = {string.upper(WHEEL.GENERAL.KEY[1]), false}
					for _, KEY in ipairs({'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'}) do
						if string.find(WHEEL.GENERAL.KEY[1][1], KEY, 1) then
							WHEEL.GENERAL.KEY[1][2] = true
						end
					end
					WHEEL.GENERAL.KEY[1] = (not WHEEL.GENERAL.KEY[1][2] or string.len(WHEEL.GENERAL.KEY[1][1]) > 1) and 'Q' or WHEEL.GENERAL.KEY[1][1]
				end
				--WHEEL.GENERAL.KEY[1] = IsConfigMissing(LoadConfigFile('WHEEL_UI/BUTTON/'..WHEEL.GENERAL.KEY[1]..'.png')) and 'Q' or WHEEL.GENERAL.KEY[1]
			end
		end
		
		WHEEL.GENERAL.KEY[6] = GetConfigBoolean(WHEEL.GENERAL.CONFIG, 'use_controller', false)
		
		for ID, KEY in ipairs({'motion', 'sound'}) do
			WHEEL.GENERAL.GAME[string.upper(KEY)] = (ID > 1 and WHEEL.GENERAL.GAME.MOTION) and true or GetConfigBoolean(WHEEL.GENERAL.CONFIG, 'game_'..KEY, WHEEL.GENERAL.GAME[string.upper(KEY)])
		end
		
		WHEEL.GENERAL.GAME.FILTER.SHOW = WHEEL.COMPONENT.BACK.COLOR.OPACITY[2] == 0 and false or GetConfigBoolean(WHEEL.GENERAL.CONFIG, 'game_filter_show', WHEEL.GENERAL.GAME.FILTER.SHOW)
		WHEEL.GENERAL.GAME.FILTER.FADE = WHEEL.COMPONENT.BACK.COLOR.OPACITY[2] == 0 and false or GetConfigBoolean(WHEEL.GENERAL.CONFIG, 'game_filter_fade', WHEEL.GENERAL.GAME.FILTER.FADE)
		
		WHEEL.GENERAL.RULE = not GetConfigBoolean(WHEEL.GENERAL.CONFIG, 'ignore_activation_rule', WHEEL.GENERAL.RULE)
	else
		PrintWarning('WARNING: config.ini is missing!')
	end
	
	
	-----------------------------------------------------
	-- # CREATE BACKGROUND COMPONENTS OF THE WHEEL MENU #
	-----------------------------------------------------
	
	for _, PART in ipairs(WHEEL.COMPONENT.BACK.FILE) do
		WHEEL.COMPONENT.BACK.TEXTURE[PART..'_T'] = CreateTexture('COMPONENT/W_'..PART..'.png')
		WHEEL.COMPONENT.BACK.TEXTURE[PART..'_R'] = GetTextureDisplayAspectRatio(WHEEL.COMPONENT.BACK.TEXTURE[PART..'_T'])
	end
	
	WHEEL.COMPONENT.BACK.TEXTURE.MID_T = CreateTexture('COMPONENT/W_MID.png')
	WHEEL.COMPONENT.BACK.TEXTURE.MID_R = GetTextureDisplayAspectRatio(WHEEL.COMPONENT.BACK.TEXTURE.MID_T)
	
	
	-----------------------------------------------------
	-- # CREATE FOREGROUND COMPONENTS OF THE WHEEL MENU #
	-----------------------------------------------------
	
	if WHEEL.GENERAL.TAB[2] > 1 then
		for GROUP = 1, 3 do
			if not WHEEL.GENERAL.TAB[3][GROUP] then
				WHEEL.COMPONENT.FRONT.TEXTURE['DOT_'..GROUP..'_T'] = CreateTexture('COMPONENT/W_DOT.png')
				WHEEL.COMPONENT.FRONT.TEXTURE['DOT_'..GROUP..'_R'] = GetTextureDisplayAspectRatio(WHEEL.COMPONENT.FRONT.TEXTURE['DOT_'..GROUP..'_T'])
			end
		end
	end
	
	LoadScript('item.lua')
	
	if WHEEL.GROUP[1].ENABLE then
		for CATEGORY = 1, 6 do
			for _, CONTENT in ipairs(WHEEL.GROUP[1].CONTENT[CATEGORY]) do
				if not ({[-1] = true, [301] = true, [303] = true, [305] = true, [306] = true, [307] = true, [309] = true, [312] = true, [320] = true, [321] = true, [325] = true, [328] = true, [349] = true, [394] = true, [396] = true,[420] = true, [426] = true, [437] = true})[CONTENT.ID] then
					NI_WEAPON[CONTENT.ID] = true
				end
			end
		end
		for STAT = 1, 4 do
			WHEEL.COMPONENT.FRONT.TEXTURE['BAR_01_'..STAT..'_BG_T'], WHEEL.COMPONENT.FRONT.TEXTURE['BAR_01_'..STAT..'_T'] = CreateTexture('COMPONENT/BAR.png'), CreateTexture('COMPONENT/BAR.png')
			WHEEL.COMPONENT.FRONT.TEXTURE['BAR_01_'..STAT..'_BG_R'], WHEEL.COMPONENT.FRONT.TEXTURE['BAR_01_'..STAT..'_R'] = GetTextureDisplayAspectRatio(WHEEL.COMPONENT.FRONT.TEXTURE['BAR_01_'..STAT..'_BG_T']), GetTextureDisplayAspectRatio(WHEEL.COMPONENT.FRONT.TEXTURE['BAR_01_'..STAT..'_T'])
		end
		for INDEX, CATEGORY in ipairs(WHEEL.GROUP[1].CONTENT) do
			for NUMBER, CONTENT in ipairs(CATEGORY) do
				if type(CONTENT.ID) ~= 'nil' and (CONTENT.ID == -1 or ItemGetCurrentNum(NI_AMMO[CONTENT.ID] or CONTENT.ID) > 0) then
					WHEEL.GROUP[1].SELECT[INDEX] = {CONTENT.ID == -1 and 1 or NUMBER, CONTENT.ID, CONTENT.CHECK and CONTENT.CHECK or false}
					break
				end
			end
			if not WHEEL.GROUP[1].SELECT[INDEX] then
				WHEEL.GROUP[1].SELECT[INDEX] = {1, type(WHEEL.GROUP[1].CONTENT[INDEX][1]) == 'table' and WHEEL.GROUP[1].CONTENT[INDEX][1].ID or -1, type(WHEEL.GROUP[1].CONTENT[INDEX][1]) == 'table' and WHEEL.GROUP[1].CONTENT[INDEX][1].CHECK or true}
			end
			for NUMBER, CONTENT in ipairs(CATEGORY) do
				WHEEL.COMPONENT.FRONT.TEXTURE['ICON_01_'..CONTENT.ICON..'_T'] = CreateTexture('GROUP_01/ICON_'..CONTENT.ICON..'.png')
				WHEEL.COMPONENT.FRONT.TEXTURE['ICON_01_'..CONTENT.ICON..'_R'] = GetTextureDisplayAspectRatio(WHEEL.COMPONENT.FRONT.TEXTURE['ICON_01_'..CONTENT.ICON..'_T'])
			end
		end
	end
	
	if WHEEL.GROUP[2].ENABLE then
		for STAT = 1, 4 do
			WHEEL.COMPONENT.FRONT.TEXTURE['BAR_02_'..STAT..'_BG_T'], WHEEL.COMPONENT.FRONT.TEXTURE['BAR_02_'..STAT..'_T'] = CreateTexture('COMPONENT/BAR.png'), CreateTexture('COMPONENT/BAR.png')
			WHEEL.COMPONENT.FRONT.TEXTURE['BAR_02_'..STAT..'_BG_R'], WHEEL.COMPONENT.FRONT.TEXTURE['BAR_02_'..STAT..'_R'] = GetTextureDisplayAspectRatio(WHEEL.COMPONENT.FRONT.TEXTURE['BAR_02_'..STAT..'_BG_T']), GetTextureDisplayAspectRatio(WHEEL.COMPONENT.FRONT.TEXTURE['BAR_02_'..STAT..'_T'])
		end
		CLOTHING_REBUILD_CONTENT()
		for INDEX = 1, 6 do
			WHEEL.COMPONENT.FRONT.TEXTURE['ICON_02_'..INDEX..'_T'] = CreateTexture('GROUP_02/ICON_'..INDEX..'.png')
			WHEEL.COMPONENT.FRONT.TEXTURE['ICON_02_'..INDEX..'_R'] = GetTextureDisplayAspectRatio(WHEEL.COMPONENT.FRONT.TEXTURE['ICON_02_'..INDEX..'_T'])
		end
	end
	
	if WHEEL.GROUP[3].ENABLE then
		for INDEX, CATEGORY in ipairs(WHEEL.GROUP[3].CONTENT) do
			for NUMBER, CONTENT in ipairs(CATEGORY) do
				if type(CONTENT.NAME) ~= 'nil' then
					WHEEL.GROUP[3].SELECT[INDEX] = {NUMBER, CONTENT.NAME, CONTENT.FUNCTION}
					
					WHEEL.COMPONENT.FRONT.TEXTURE['ICON_03_'..CONTENT.ICON..'_T'] = CreateTexture('GROUP_03/ICON_'..CONTENT.ICON..'.png')
					WHEEL.COMPONENT.FRONT.TEXTURE['ICON_03_'..CONTENT.ICON..'_R'] = GetTextureDisplayAspectRatio(WHEEL.COMPONENT.FRONT.TEXTURE['ICON_03_'..CONTENT.ICON..'_T'])
				end
			end
			if not WHEEL.GROUP[3].SELECT[INDEX] then
				WHEEL.GROUP[3].SELECT[INDEX] = {1, type(WHEEL.GROUP[3].CONTENT[INDEX][1]) == 'table' and WHEEL.GROUP[3].CONTENT[INDEX][1].NAME or 'Unknown', type(WHEEL.GROUP[3].CONTENT[INDEX][1]) == 'table' and WHEEL.GROUP[3].CONTENT[INDEX][1].FUNCTION or function() end}
			end
		end
		for INDEX = 1, 6 do
			if type(WHEEL.GROUP[3].CONTENT[INDEX][1]) == 'table' then
				WHEEL.GROUP[3].SELECT[INDEX][1] = 1
				WHEEL.GROUP[3].SELECT[INDEX][2] = type(WHEEL.GROUP[3].CONTENT[1][WHEEL.GROUP[3].SELECT[1][1]].NAME) == 'string' and WHEEL.GROUP[3].CONTENT[1][WHEEL.GROUP[3].SELECT[1][1]].NAME or 'Unknown'
				WHEEL.GROUP[3].SELECT[INDEX][3] = type(WHEEL.GROUP[3].CONTENT[1][WHEEL.GROUP[3].SELECT[1][1]].FUNCTION) == 'function' and WHEEL.GROUP[3].CONTENT[1][WHEEL.GROUP[3].SELECT[1][1]].FUNCTION or function() end
			end
		end
	end
	
	
	-----------------------------------------------------------------------
	-- # MANIPULATE FUNCTIONS TO GET & DO SOMETHING IN CERTAIN CONDITIONS #
	-----------------------------------------------------------------------
	
	shared.gPWHL = {false, _G.PlayerWeaponHudLock}
	_G.PlayerWeaponHudLock = function(S)
		shared.gPWHL[1] = S
		shared.gPWHL[2](S)
	end
	shared.gPSCT = {true, _G.PlayerSetControl}
	_G.PlayerSetControl = function(S)
		shared.gPSCT[1] = S == 1
		shared.gPSCT[2](S)
	end
	shared.gCF = {false, _G.CameraFade}
	_G.CameraFade = function(MS, S)
		shared.gCF[1] = S == 0
		if S == 1 then
			shared.WHEEL.GENERAL.WAIT = GetTimer() + (MS + 1)
		end
		shared.gCF[2](MS, S)
	end
	shared.gMS = _G.MissionSucceed
	_G.MissionSucceed = function(...)
		if shared.gCF[1] then
			shared.gCF[1] = false
		end
		shared.WHEEL.GENERAL.WAIT = GetTimer() + 2000
		shared.gMS(unpack(arg))
	end
	shared.gMF = _G.MissionFail
	_G.MissionFail = function(...)
		if shared.gCF[1] then
			shared.gCF[1] = false
		end
		shared.WHEEL.GENERAL.WAIT = GetTimer() + 2000
		shared.gMF(unpack(arg))
	end
	shared.gCBP = _G.ClothingBuildPlayer
	_G.ClothingBuildPlayer = function(I)
		if not I then
			shared.WHEEL.GROUP[2].REBUILD = true
		end
		shared.gCBP()
	end
	shared.gTHCV = _G.ToggleHUDComponentVisibility
	_G.ToggleHUDComponentVisibility = function(ID, S)
		if ID == 14 and not S then
			shared.WHEEL.GROUP[2].REBUILD = true
		end
		shared.gTHCV(ID, S)
	end
	shared.gGSV = _G.GetStickValue
	_G.GetStickValue = function(ID, C)
		if (ID == 18 or ID == 19) and C == 0 then
			return shared.WHEEL.GENERAL.ACTIVE and 0 or shared.gGSV(ID, C)
		end
		return shared.gGSV(ID, C)
	end
	shared.gPUS = {true,  _G.PauseSimulation, _G.UnpauseSimulation}
	_G.PauseSimulation = function()
		shared.gPUS[1] = false
		shared.gPUS[2]()
	end
	_G.UnpauseSimulation = function()
		shared.gPUS[1] = true
		shared.gPUS[3]()
	end
	shared.gPCS = {true, _G.SoundPause, _G.SoundContinue}
	_G.SoundPause = function()
		shared.gPCS[1] = false
		shared.gPCS[2]()
	end
	_G.SoundContinue = function()
		shared.gPCS[1] = true
		shared.gPCS[3]()
	end
	
	
	---------------------------------------------
	-- # CLEAR THINGS THAT STORED IN THE MEMORY #
	---------------------------------------------
	
	collectgarbage()
end


--[[
	-------------------------
	# WHEEL MENU : REGISTER #
	-------------------------
]]

GROUP_01_REGISTER = function(CATEGORY, INDEX, NAME, AMMO, ICON, CHECK, STAT)
	if WHEEL.GROUP[1].ENABLE then
		local ERROR = type(INDEX) ~= 'number' and 'INDEX' or (type(ICON) ~= 'string' and 'ICON' or nil)
		if type(ERROR) == 'nil' then
			table.insert(WHEEL.GROUP[1].CONTENT[({['MELEE'] = 1, ['THROW'] = 2, ['STYLE'] = 3, ['SLINGSHOT'] = 4, ['GUN'] = 5, ['OTHER'] = 6})[CATEGORY] or 6], {
				ID = INDEX, AMMO = AMMO or GET_WEAPON_REFERENCE(INDEX, 2), NAME = NAME or GET_WEAPON_REFERENCE(INDEX, 1), ICON = ICON, CHECK = CHECK or false, STAT = STAT or GET_WEAPON_REFERENCE(INDEX, 3)
			})
		else
			PrintWarning('GROUP_01_REGISTER: '..ERROR..' is required to register '..(NAME or GET_WEAPON_REFERENCE(INDEX, 1))..'.')
		end
	end
end

GROUP_02_REGISTER = function(CATEGORY, INDEX, MODEL, NAME, STAT)
	if WHEEL.GROUP[2].ENABLE then
		if type(MODEL) == 'string' then
			table.insert(WHEEL.GROUP[2].CONTENT[({['FEET'] = 1, ['LEG'] = 2, ['TORSO'] = 3, ['HEAD'] = 4, ['L-HAND'] = 5, ['R-HAND'] = 6})[CATEGORY] or 1], {
				CODE = {INDEX or GET_CLOTHING_REFERENCE(ObjectNameToHashID(MODEL), 1), MODEL}, NAME = NAME or GET_CLOTHING_REFERENCE(ObjectNameToHashID(MODEL), 3), STAT = STAT or GET_CLOTHING_REFERENCE(ObjectNameToHashID(MODEL), 4)
			})
		else
			PrintWarning('GROUP_02_REGISTER: MODEL is required to register '..(type(NAME) == 'string' and NAME or 'Unknown')..'.')
		end
	end
end

GROUP_03_REGISTER = function(CATEGORY, NAME, DESC, ACTION, ICON, FUNC)
	if WHEEL.GROUP[3].ENABLE then
		if type(ICON) == 'string' then
			table.insert(WHEEL.GROUP[3].CONTENT[({['BOTTOM'] = 1, ['BOTTOM_LEFT'] = 2, ['TOP_LEFT'] = 3, ['TOP'] = 4, ['TOP_RIGHT'] = 5, ['BOTTOM_RIGHT'] = 6})[CATEGORY] or 1], {
				NAME = NAME or 'Unknown', DESCRIPTION = DESC or '', ACTION = ACTION or 'Use', ICON = ICON, FUNCTION = FUNC or function() end
			})
		else
			PrintWarning('GROUP_03_REGISTER: ICON is required to register '..(type(NAME) == 'string' and NAME or 'Unknown')..'.')
		end
	end
end


--[[
	--------------------------
	# WHEEL MENU : REFERENCE #
	--------------------------
]]

GET_CLOTHING_REFERENCE = function(HASH_ID, OUTPUT)
	if type(TABLE_CLOTHING_REFERENCE) == 'nil' then
		TABLE_CLOTHING_REFERENCE = {
			[ObjectNameToHashID('Hair')] = {0, 'Hair', 'Hair', {0, 0, 0, 0}},
			[ObjectNameToHashID('R_Hat1')] = {0, 'R_Hat1', 'Luxury Stud Hat Gray', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Hat2')] = {0, 'R_Hat2', 'Luxury Stud Hat Brown', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Hat3')] = {0, 'R_Hat3', 'Luxury Stud Hat Black', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Hat4')] = {0, 'R_Hat4', 'Panama Hat', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Hat5')] = {0, 'R_Hat5', 'Porkpie Hat', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Hat6')] = {0, 'R_Hat6', 'Top Hat', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('P_BHat1')] = {0, 'P_BHat1', 'Cap Blue', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_BHat2')] = {0, 'P_BHat2', 'Cap Purple & Black', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_BHat3')] = {0, 'P_BHat3', 'Cap Red & Tan', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_BHat4')] = {0, 'P_BHat4', 'Cap White & Black', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_BHat5')] = {0, 'P_BHat5', 'Cap Yellow & Black', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_BHat6')] = {0, 'P_BHat6', 'Cap Black & Red', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Bandana1')] = {0, 'P_Bandana1', 'Bandana Blue', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Bandana2')] = {0, 'P_Bandana2', 'Bandana Red', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Bandana3')] = {0, 'P_Bandana3', 'Bandana Black', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('S_BHat1')] = {0, 'S_BHat1', 'Bullworth Cap Classic', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_BHat2')] = {0, 'S_BHat2', 'Bullworth Cap Team', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_BHat3')] = {0, 'S_BHat3', 'Bullworth Cap Green', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_Sunvisor1')] = {0, 'S_Sunvisor1', 'Bullworth Visor Classic', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_Sunvisor2')] = {0, 'S_Sunvisor2', 'Bullworth Visor Red', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_Sunvisor3')] = {0, 'S_Sunvisor3', 'Bullworth Visor Green', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('P_Army1')] = {0, 'P_Army1', 'Army Cap', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Army2')] = {0, 'P_Army2', 'Army Bucket Hat', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Army3')] = {0, 'P_Army3', 'Army Wool Hat', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('B_BHat1')] = {0, 'B_BHat1', 'Ball Cap Blue & White', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_BHat2')] = {0, 'B_BHat2', 'Ball Cap Black', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_BHat3')] = {0, 'B_BHat3', 'Ball Cap White', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_BHat4')] = {0, 'B_BHat4', 'Ball Cap Quartered', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_BHat5')] = {0, 'B_BHat5', 'Ball Cap White & Green', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_BHat6')] = {0, 'B_BHat6', 'Ball Cap White & Blue', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Bucket1')] = {0, 'B_Bucket1', 'Beach Bucket Hat', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Bucket2')] = {0, 'B_Bucket2', 'Urban Bucket Hat', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Various1')] = {0, 'B_Various1', 'Lumberjack Hat', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Various2')] = {0, 'B_Various2', 'Shortbeacked Hat', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Various3')] = {0, 'B_Various3', 'Tradesman Cap Blue', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Various4')] = {0, 'B_Various4', 'Tradesman Cap Brown', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Various5')] = {0, 'B_Various5', 'Cowboy Hat Brown', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Hunter1')] = {0, 'B_Hunter1', 'Newsie Hat', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Hunter2')] = {0, 'B_Hunter2', 'Old Time Racing Hat', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Hunter3')] = {0, 'B_Hunter3', 'Unionist Hat', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('SP_Alien_H')] = {0, 'SP_Alien_H', 'Alien Mask', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_BMXhelmet')] = {0, 'SP_BMXhelmet', 'BMX Helmet', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Antlers')] = {0, 'SP_Antlers', 'Reindeer Antlers', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Colum_H')] = {0, 'SP_Colum_H', 'Explorer Hat', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Elf_H')] = {0, 'SP_Elf_H', 'Elf Hat', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Fries_H')] = {0, 'SP_Fries_H', 'Frice Headpiece', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Gnome_H')] = {0, 'SP_Gnome_H', 'Gnome Hat', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Goldsuit_H')] = {0, 'SP_Goldsuit_H', 'Burns & Shades', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_MBand_H')] = {0, 'SP_MBand_H', 'Marching Band Hat', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Mascot_H')] = {0, 'SP_Mascot_H', 'Mascot Head', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Nascar_H')] = {0, 'SP_Nascar_H', 'Racing Hat', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Nerd_H')] = {0, 'SP_Nerd_H', 'Nerd Glasses', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Ninja_H')] = {0, 'SP_Ninja_H', 'Black Ninja Mask', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_NinjaW_H')] = {0, 'SP_NinjaW_H', 'Green Ninja Mask', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_NinjaR_H')] = {0, 'SP_NinjaR_H', 'Red Ninja Mask', {0, 0, 100, 100}}, 
			[ObjectNameToHashID('SP_Nutcrack_H')] = {0, 'SP_Nutcrack_H', 'Nutcracker Hat', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_80Rocker_H')] = {0, 'SP_80Rocker_H', "80's Rocker", {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Ween_H')] = {0, 'SP_Ween_H', 'Skull Mask', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Wrestling_H')] = {0, 'SP_Wrestling_H', 'Wrestling Helmet', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Panda_H')] = {0, 'SP_Panda_H', 'Panda Head', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_BikeHelmet')] = {0, 'SP_BikeHelmet', 'Bike Helmet', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Cowboyhat')] = {0, 'SP_Cowboyhat', 'Cowboy Hat Black', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('C_AngelHalo')] = {0, 'C_AngelHalo', 'Angelic Halo', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('C_CanadaHat')] = {0, 'C_CanadaHat', 'Checkered Party Hat', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_PigMask')] = {0, 'SP_PigMask', 'Pig Head', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_PirateHat')] = {0, 'SP_PirateHat', 'Pirate Hat', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Duncehat')] = {0, 'SP_Duncehat', 'Dunce Cap', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_EdnaMask')] = {0, 'SP_EdnaMask', 'Edna Mask', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_EiffelHat')] = {0, 'SP_EiffelHat', 'Eiffel Tower Hat', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Einstein')] = {0, 'SP_Einstein', 'Genius Hat', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Firehat')] = {0, 'SP_Firehat', 'Firefighter Helmet', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_GK_Helmet')] = {0, 'SP_GK_Helmet', 'Crash Helmet', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Zorromask')] = {0, 'SP_Zorromask', 'Bandit Mask', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_PithHelmet')] = {0, 'SP_PithHelmet', 'Pith Helmet', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Pophat')] = {0, 'SP_Pophat', 'Two Can Hat', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Pumpkin_head')] = {0, 'SP_Pumpkin_head', 'Pumpkin Head', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_VHelmet')] = {0, 'SP_VHelmet', 'Viking Helmet Plastic', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Werewolf')] = {0, 'SP_Werewolf', 'Werewolf Mask', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_GymDisguise')] = {0, 'SP_GymDisguise', 'Incognito Hat', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Basshat')] = {0, 'SP_Basshat', 'Bass Hat', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Hazmat')] = {0, 'SP_Hazmat', 'Hazmat Headgear', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_MortarBhat')] = {0, 'SP_MortarBhat', 'Graduation Hat', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('C_ClownWig')] = {0, 'C_ClownWig', 'Clown Wig', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('C_DevilHorns')] = {0, 'C_DevilHorns', 'Devil Horns', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('C_StrangeHat')] = {0, 'C_StrangeHat', 'Strange Hat', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('R_Jacket1')] = {1, 'R_Jacket1', 'Tuxedo Jacket', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Jacket2')] = {1, 'R_Jacket2', 'Duffel Coat', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Jacket5')] = {1, 'R_Jacket5', 'LS Casual Jacket', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Sweater1')] = {1, 'R_Sweater1', 'Aquaberry Vest', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Sweater2')] = {1, 'R_Sweater2', 'Urban Parade Sweater', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Sweater3')] = {1, 'R_Sweater3', 'Lambswool V-Neck Sweater', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Sweater4')] = {1, 'R_Sweater4', 'LS Training Jacket', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Sweater5')] = {1, 'R_Sweater5', 'Aquaberry Sweater', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_SSleeves1')] = {1, 'R_SSleeves1', "Rough 'n Rich Shirt White", {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_SSleeves2')] = {1, 'R_SSleeves2', "Rough 'n Rich Shirt Blue", {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_SSleeves4')] = {1, 'R_SSleeves4', 'AB Casual Polo Black', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_SSleeves5')] = {1, 'R_SSleeves5', 'AB Casual Polo Brown', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_SSleeves6')] = {1, 'R_SSleeves6', 'AB Casual Polo Blue', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_LSleeves1')] = {1, 'R_LSleeves1', 'Aquaberry Shirt', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_LSleeves2')] = {1, 'R_LSleeves2', 'Zip Sewater Crimson', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_LSleeves4')] = {1, 'R_LSleeves4', 'Zip Sweater Forest', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_LSleeves5')] = {1, 'R_LSleeves5', 'Zip Sweater Coal', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('S_Jacket3')] = {1, 'S_Jacket3', 'Bullworth Letterman Jacket', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_Jacket4')] = {1, 'S_Jacket4', 'Bullworth Sport Jacket', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_Sweater1')] = {1, 'S_Sweater1', 'Astronomy Club Vest', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_Sweater2')] = {1, 'S_Sweater2', 'School Sweater', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_Sweater5')] = {1, 'S_Sweater5', 'Bullworth Vest', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_LSleeves1')] = {1, 'S_LSleeves1', 'Bullworth Hoodie Gray', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_LSleeves2')] = {1, 'S_LSleeves2', 'Bullworth Hoodie Blue', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_LSleeves3')] = {1, 'S_LSleeves3', 'Team Zip-Up', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_LSleeves4')] = {1, 'S_LSleeves4', 'Team Zip-Up Green', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('P_Jacket1')] = {1, 'P_Jacket1', 'Black Bomber Jacket', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Jacket2')] = {1, 'P_Jacket2', 'Leather Jacket', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Jacket3')] = {1, 'P_Jacket3', 'Old School Punk Vest', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Jacket4')] = {1, 'P_Jacket4', 'Army Jacket', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Jacket5')] = {1, 'P_Jacket5', 'Arctic Camo Jacket', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Jacket6')] = {1, 'P_Jacket6', 'Forest Camo Jacket', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sweater1')] = {1, 'P_Sweater1', 'Punk Hoodie', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sweater2')] = {1, 'P_Sweater2', 'Army Sweater Green', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sweater3')] = {1, 'P_Sweater3', 'Army Sweater Black', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sweater4')] = {1, 'P_Sweater4', 'Hoodie Black', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sweater5')] = {1, 'P_Sweater5', 'Hoodie Blue', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sweater6')] = {1, 'P_Sweater6', 'Hoodie Gray', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sweater7')] = {1, 'P_Sweater7', 'Rock On Shirt', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sweater8')] = {1, 'P_Sweater8', 'Rocker Hoodie', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_SSleeves1')] = {1, 'P_SSleeves1', 'Metal T-Shirt', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_SSleeves2')] = {1, 'P_SSleeves2', 'Creepy Clown T-Shirt', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_SSleeves3')] = {1, 'P_SSleeves3', 'T-Shirt White', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_SSleeves4')] = {1, 'P_SSleeves4', 'T-Shirt Blue', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_SSleeves5')] = {1, 'P_SSleeves5', 'Fool Hammer T-Shirt', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_SSleeves6')] = {1, 'P_SSleeves6', 'T-Shirt Red', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_SSleeves7')] = {1, 'P_SSleeves7', 'T-Shirt Yellow', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_SSleeves8')] = {1, 'P_SSleeves8', 'T-Shirt Green', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_SSleeves9')] = {1, 'P_SSleeves9', 'T-Shirt Black', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_SSleeves10')] = {1, 'P_SSleeves10', 'T-Shirt Gray', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_SSleeves11')] = {1, 'P_SSleeves11', 'Undershirt White', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_SSleeves12')] = {1, 'P_SSleeves12', 'Undershirt Black', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_SSleeves13')] = {1, 'P_SSleeves13', 'Undershirt Blue', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_SSleeves14')] = {1, 'P_SSleeves14', 'Undershirt Gray', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_LSleeves1')] = {1, 'P_LSleeves1', 'Long T-Shirt White', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_LSleeves2')] = {1, 'P_LSleeves2', 'Long T-Shirt Dark Blue', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_LSleeves3')] = {1, 'P_LSleeves3', 'Long T-Shirt Light Blue', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_LSleeves4')] = {1, 'P_LSleeves4', 'Long T-Shirt Red', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_LSleeves5')] = {1, 'P_LSleeves5', 'Long T-Shirt Yellow', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_LSleeves6')] = {1, 'P_LSleeves6', 'Long T-Shirt Green', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_LSleeves7')] = {1, 'P_LSleeves7', 'Long T-Shirt Black', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_LSleeves8')] = {1, 'P_LSleeves8', 'Long T-Shirt Gray', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_LSleeves9')] = {1, 'P_LSleeves9', 'New Flannel Shirt', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_LSleeves10')] = {1, 'P_LSleeves10', 'Worn Flannel Shirt', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('B_Jacket1')] = {1, 'B_Jacket1', 'Green Bomber Jacket', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Jacket2')] = {1, 'B_Jacket2', 'Black Hooded Jacket', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Jacket3')] = {1, 'B_Jacket3', 'Jean Jacket', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Jacket6')] = {1, 'B_Jacket6', 'Brown Jacket', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Sweater2')] = {1, 'B_Sweater2', 'Zip Up Black Hoodie', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Sweater3')] = {1, 'B_Sweater3', 'Sevener Black Hoodie', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Sweater4')] = {1, 'B_Sweater4', 'Conduct Hoodie', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_SSleeves1')] = {1, 'B_SSleeves1', 'Dark Side Baseball Jersey', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_SSleeves2')] = {1, 'B_SSleeves2', 'Tiki Shirt', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_SSleeves3')] = {1, 'B_SSleeves3', 'Hawaiian Shirt', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_LSleeves2')] = {1, 'B_LSleeves2', 'Lips Long T-Shirt', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_LSleeves3')] = {1, 'B_LSleeves3', '68 Long T-Shirt', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_LSleeves4')] = {1, 'B_LSleeves4', 'Urban Sports Long T-Shirt', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Jersey1')] = {1, 'B_Jersey1', 'Bright Side Baseball Jersey', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Jersey3')] = {1, 'B_Jersey3', 'Soccer Polo Snow', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Jersey4')] = {1, 'B_Jersey4', 'Soccer Polo Emerald', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Jersey5')] = {1, 'B_Jersey5', 'Rugby Jersey LB', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Jersey6')] = {1, 'B_Jersey6', 'Rugby Jersey Celt', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Jersey7')] = {1, 'B_Jersey7', 'Football Jersey Green', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Jersey8')] = {1, 'B_Jersey8', 'Football Jersey Black', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Jersey9')] = {1, 'B_Jersey9', 'Hockey Jersey Blue', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Jersey10')] = {1, 'B_Jersey10', 'Hockey Jersey Black', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('SP_Alien_T')] = {1, 'SP_Alien_T', 'Alien Shirt', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Boxing_T')] = {1, 'SP_Boxing_T', 'Boxing Tank Top', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_BikeJersey')] = {1, 'SP_BikeJersey', 'Bike Jersey', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Colum_T')] = {1, 'SP_Colum_T', 'Explorer Coat', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Elf_T')] = {1, 'SP_Elf_T', 'Elf Jacket', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Fries_T')] = {1, 'SP_Fries_T', 'Minimum Wage Shirt', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Gnome_T')] = {1, 'SP_Gnome_T', 'Gnome Tunic', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Goldsuit_T')] = {1, 'SP_Goldsuit_T', 'Glamor Jacket', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_MBand_T')] = {1, 'SP_MBand_T', 'Marching Band Coat', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Nascar_T')] = {1, 'SP_Nascar_T', 'Racing Shirt', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Nerd_T')] = {1, 'SP_Nerd_T', 'Nerd Shirt', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Ninja_T')] = {1, 'SP_Ninja_T', 'Black Ninja Jacket', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_NinjaW_T')] = {1, 'SP_NinjaW_T', 'Green Ninja Jacket', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_NinjaR_T')] = {1, 'SP_NinjaR_T', 'Red Ninja Jacket', {0, 0, 100, 100}}, 
			[ObjectNameToHashID('SP_Nutcrack_T')] = {1, 'SP_Nutcrack_T', 'Nutcracker Jacket', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Orderly_T')] = {1, 'SP_Orderly_T', 'Orderly Shirt', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_PJ_T')] = {1, 'SP_PJ_T', 'Skull Jammie Shirt', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Prison_T')] = {1, 'SP_Prison_T', 'Prison Shirt', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_80Rocker_T')] = {1, 'SP_80Rocker_T', "80's Rocket Coat", {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Ween_T')] = {1, 'SP_Ween_T', 'Skeleton Shirt', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Wrestling_T')] = {1, 'SP_Wrestling_T', 'Gym Shirt', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_BandShirt')] = {1, 'SP_BandShirt', 'Band Shirt', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_XmsSweater')] = {1, 'SP_XmsSweater', 'Cheerful Reindeer Sweater', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_PieShirt')] = {1, 'SP_PieShirt', 'Shut Your Pi Hole Shirt', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_HipShirt')] = {1, 'SP_HipShirt', 'Hip 2B Squared Shirt', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_MathShirt')] = {1, 'SP_MathShirt', 'Math Shirt', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_MuscleShirt')] = {1, 'SP_MuscleShirt', 'Muscle Shirt', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_MusicPJ_T')] = {1, 'SP_MusicPJ_T', 'Music Jammie Shirt', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_MusicShirt')] = {1, 'SP_MusicShirt', 'Music Keys Shirt', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('C_StpdShrt')] = {1, 'C_StpdShrt', 'Stupid T-Shirt', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('none')] = {2, 'none', 'No Accessories', {0, 0, 0, 0}},
			[ObjectNameToHashID('R_Watch1')] = {2, 'R_Watch1', 'Aquaberry Watch Gold', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Watch2')] = {2, 'R_Watch2', 'Aquaberry Watch Steel', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Watch3')] = {2, 'R_Watch3', 'Aquaberry Watch Silver', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Watch4')] = {2, 'R_Watch4', 'Aquaberry Watch White Gold', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('C_PinkWatch')] = {2, 'C_PinkWatch', 'Novelty Watch', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('S_Wristband1')] = {2, 'S_Wristband1', 'Team Sweatband Blue', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_Wristband4')] = {2, 'S_Wristband4', 'Team Sweatband Red', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_Wristband6')] = {2, 'S_Wristband6', 'Team Sweatband White', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('P_Watch1')] = {2, 'P_Watch1', 'Cheap Digital Watch', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('SP_Boxing_G_L')] = {2, 'SP_Boxing_G_L', 'Boxing Glove', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_NerdWatch')] = {3, 'SP_NerdWatch', 'Nerd Watch', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('R_Wristband1')] = {3, 'R_Wristband1', 'Bracelet Gold', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Wristband2')] = {3, 'R_Wristband2', 'Bracelet Silver', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Wristband3')] = {3, 'R_Wristband3', 'Bracelet Steel', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Wristband4')] = {3, 'R_Wristband4', 'Bracelet Onyx', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('S_Wristband2')] = {3, 'S_Wristband2', 'Team Sweatband Blue', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_Wristband3')] = {3, 'S_Wristband3', 'Team Sweatband Red', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_Wristband5')] = {3, 'S_Wristband5', 'Team Sweatband White', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('P_Wristband1')] = {3, 'P_Wristband1', 'Red Bandana', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Wristband2')] = {3, 'P_Wristband2', 'Narrow Studded Punk Brace', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Wristband3')] = {3, 'P_Wristband3', 'Square Studded Brace', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Wristband4')] = {3, 'P_Wristband4', 'Wide Studded Punk Brace', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Wristband5')] = {3, 'P_Wristband5', 'Spiky Studded Punk Brace', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Wristband6')] = {3, 'P_Wristband6', 'Leather Archer Brace', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Wristband7')] = {3, 'P_Wristband7', 'Black Restraint Brace', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Wristband8')] = {3, 'P_Wristband8', 'Black Bracelet', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('B_Wristband1')] = {3, 'B_Wristband1', 'Good Luck Wrist Band', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Wristband2')] = {3, 'B_Wristband2', 'Wide Wrist Band Black', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Wristband3')] = {3, 'B_Wristband3', 'Wide Wrist Band Brown', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Wristband4')] = {3, 'B_Wristband4', 'Wristband Black', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Wristband5')] = {3, 'B_Wristband5', 'Wristband Brown', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('SP_Boxing_G_R')] = {3, 'SP_Boxing_G_R', 'Boxing Glove', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('R_Pants1')] = {4, 'R_Pants1', 'Tuxedo Pants', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Pants2')] = {4, 'R_Pants2', 'LS Casual Pants Gray', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Pants3')] = {4, 'R_Pants3', 'LS Casual Pants Black', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Pants4')] = {4, 'R_Pants4', 'Aquaberry Slacks Slate', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Pants5')] = {4, 'R_Pants5', 'Aquaberry Slacks Cream', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Shorts1')] = {4, 'R_Shorts1', 'RnR Shorts Black', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Shorts2')] = {4, 'R_Shorts2', 'RnR Shorts Burgundy', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Shorts3')] = {4, 'R_Shorts3', 'RnR Shorts Green', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Shorts4')] = {4, 'R_Shorts4', 'RnR Shorts Tan', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Shorts5')] = {4, 'R_Shorts5', 'RnR Shorts Blue', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('S_Pants1')] = {4, 'S_Pants1', 'School Slacks', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_Pants3')] = {4, 'S_Pants3', 'Bullworth Gym Pants', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_Shorts1')] = {4, 'S_Shorts1', 'School Shorts', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_Shorts4')] = {4, 'S_Shorts4', 'Bullworth Gym Shorts Blue', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_Shorts5')] = {4, 'S_Shorts5', 'Bullworth Gym Shorts White', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_Shorts6')] = {4, 'S_Shorts6', 'Bullworth Gym Shorts Red', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('P_Pants1')] = {4, 'P_Pants1', 'Plaid Punk Pants', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Pants2')] = {4, 'P_Pants2', 'Ripped Jeans', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Pants3')] = {4, 'P_Pants3', 'High Cuffed Jeans', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Pants4')] = {4, 'P_Pants4', 'Pistol Pants', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Pants5')] = {4, 'P_Pants5', 'Black Cargo Pants', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Pants6')] = {4, 'P_Pants6', 'Forest Camo Cargo Pants', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Pants7')] = {4, 'P_Pants7', 'Jogging Pants', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('B_Pants1')] = {4, 'B_Pants1', 'Army Cargo Pants', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Pants2')] = {4, 'B_Pants2', 'Jeans Casual', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Pants3')] = {4, 'B_Pants3', 'Ratty Jeans', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Pants4')] = {4, 'B_Pants4', 'Crisp Jeans', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Pants6')] = {4, 'B_Pants6', 'Track Pants Green', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Pants7')] = {4, 'B_Pants7', 'Track Pants Black', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Pants8')] = {4, 'B_Pants8', 'Desert Cargo Pants', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Shorts1')] = {4, 'B_Shorts1', 'Beach Shorts', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Shorts2')] = {4, 'B_Shorts2', '3/4 Shorts Tan', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Shorts3')] = {4, 'B_Shorts3', 'Cargo Shorts', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Shorts4')] = {4, 'B_Shorts4', 'Soccer Shorts Snow', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Shorts5')] = {4, 'B_Shorts5', 'Soccer Shorts Emerald', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Shorts6')] = {4, 'B_Shorts6', '3/4 Shorts Brown', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Shorts7')] = {4, 'B_Shorts7', '3/4 Shorts Black', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('C_ClownPants')] = {4, 'C_ClownPants', 'Clown Pants', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Alien_L')] = {4, 'SP_Alien_L', 'Alien Pants', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Boxing_L')] = {4, 'SP_Boxing_L', 'Boxing Shorts', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_BikeShorts')] = {4, 'SP_BikeShorts', 'Bike Shorts', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Colum_L')] = {4, 'SP_Colum_L', 'Explorer Pants', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Elf_L')] = {4, 'SP_Elf_L', 'Elf Pants', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Fries_L')] = {4, 'SP_Fries_L', 'Minimum Wage Pants', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Gnome_L')] = {4, 'SP_Gnome_L', 'Gnome Trousers', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Goldsuit_L')] = {4, 'SP_Goldsuit_L', 'Glamor Pants', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_MBand_L')] = {4, 'SP_MBand_L', 'Marching Band Pants', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Nascar_L')] = {4, 'SP_Nascar_L', 'Racing Pants', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Nerd_L')] = {4, 'SP_Nerd_L', 'Nerd Slacks', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Ninja_L')] = {4, 'SP_Ninja_L', 'Black Ninja Pants', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_NinjaW_L')] = {4, 'SP_NinjaW_L', 'Green Ninja Pants', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_NinjaR_L')] = {4, 'SP_NinjaR_L', 'Red Ninja Pants', {0, 0, 100, 100}}, 
			[ObjectNameToHashID('SP_Nutcrack_L')] = {4, 'SP_Nutcrack_L', 'Nutcracker Pants', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Orderly_P')] = {4, 'SP_Orderly_P', 'Orderly Pants', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_PJ_L')] = {4, 'SP_PJ_L', 'Jammie Pants', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Prison_L')] = {4, 'SP_Prison_L', 'Prison Pants', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_80Rocker_L')] = {4, 'SP_80Rocker_L', "80's Rocker Pants", {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Ween_L')] = {4, 'SP_Ween_L', 'Skeleton Pants', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Wrestling_L')] = {4, 'SP_Wrestling_L', 'Gym Shorts', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Swimsuit')] = {4, 'SP_Swimsuit', 'Tiny Swimsuit', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Briefs')] = {4, 'SP_Briefs', 'Tightic Whities', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_MusicPJ_L')] = {4, 'SP_MusicPJ_L', 'Music Jammie Pants', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Shorts')] = {4, 'SP_Shorts', 'Running Shorts', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Socks')] = {5, 'SP_Socks', 'Socks', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('R_Sneakers1')] = {5, 'R_Sneakers1', 'Italian Shoes', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Sneakers2')] = {5, 'R_Sneakers2', 'LS Casual Moccasins', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Sneakers3')] = {5, 'R_Sneakers3', 'LS Casual Sneakers', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Sneakers4')] = {5, 'R_Sneakers4', 'Aquaberry Loafers', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Sneakers5')] = {5, 'R_Sneakers5', 'RnR Suede Sneakers', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Boots2')] = {5, 'R_Boots2', 'Aquaberry Boots', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('R_Boots3')] = {5, 'R_Boots3', 'Country Boots', {0, 0, 100, 0}}, 
			[ObjectNameToHashID('S_Sneakers1')] = {5, 'S_Sneakers1', 'Gym Shoes', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('S_Sneakers2')] = {5, 'S_Sneakers2', 'Cheap Dress Shoes', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('P_Sneakers1')] = {5, 'P_Sneakers1', 'White B-Ball Shoes', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sneakers2')] = {5, 'P_Sneakers2', 'Classic White Sneakers', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sneakers3')] = {5, 'P_Sneakers3', 'Low Tops Black', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sneakers4')] = {5, 'P_Sneakers4', 'Low Tops Gray', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sneakers5')] = {5, 'P_Sneakers5', 'Low Tops Green', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sneakers6')] = {5, 'P_Sneakers6', 'Low Tops Red', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sneakers7')] = {5, 'P_Sneakers7', 'Low Tops Brown', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sneakers8')] = {5, 'P_Sneakers8', 'Shiny White Sneakers', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sneakers9')] = {5, 'P_Sneakers9', 'Fat Sneakers Black & White', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sneakers10')] = {5, 'P_Sneakers10', 'Fat Sneakers Gray & White', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sneakers11')] = {5, 'P_Sneakers11', 'Skate Shoes Green', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sneakers12')] = {5, 'P_Sneakers12', 'Skate Shoes Red', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sneakers13')] = {5, 'P_Sneakers13', 'Skate Shoes Brown & Tan', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sneakers14')] = {5, 'P_Sneakers14', 'Fat Sneakers Gray', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sneakers15')] = {5, 'P_Sneakers15', 'Fat Sneakers Red & Gold', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sneakers16')] = {5, 'P_Sneakers16', 'Blue Runners', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sneakers17')] = {5, 'P_Sneakers17', 'Fat Sneakers Black & Red', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sneakers18')] = {5, 'P_Sneakers18', 'Brown Runners', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Sneakers19')] = {5, 'P_Sneakers19', 'Skate Shoes Black', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Boots1')] = {5, 'P_Boots1', 'Old Worn Boots', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Boots2')] = {5, 'P_Boots2', 'Work Boots', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Boots3')] = {5, 'P_Boots3', 'Motorcycle Boots', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('P_Boots4')] = {5, 'P_Boots4', 'Army Boots', {0, 100, 0, 0}}, 
			[ObjectNameToHashID('B_Sneakers1')] = {5, 'B_Sneakers1', 'Skate Shoes Black', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Sneakers2')] = {5, 'B_Sneakers2', 'Country Shoes', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Sneakers3')] = {5, 'B_Sneakers3', 'Brown Loafers', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Sneakers4')] = {5, 'B_Sneakers4', 'Urban Loafers Brown', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Sneakers5')] = {5, 'B_Sneakers5', 'Urban Loafers Black', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Sneakers6')] = {5, 'B_Sneakers6', 'Riot Shoes Classic', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Sneakers8')] = {5, 'B_Sneakers8', 'Riot Shoes Caramel', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Sneakers9')] = {5, 'B_Sneakers9', 'Riot Shoes Chocolate', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Sneakers10')] = {5, 'B_Sneakers10', 'Riot Shoes Black', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Sneakers11')] = {5, 'B_Sneakers11', 'Urban Walker Classic', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Sneakers12')] = {5, 'B_Sneakers12', 'Budget Basketball Sneaks', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Sneakers13')] = {5, 'B_Sneakers13', 'Urban Walker Canvas', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Boots1')] = {5, 'B_Boots1', 'Fancy Angst Boots', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Boots2')] = {5, 'B_Boots2', 'Cowboy Boots', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Boots3')] = {5, 'B_Boots3', 'Fashion Boots Tan', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Boots4')] = {5, 'B_Boots4', 'Fashion Boots Brown', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('B_Boots5')] = {5, 'B_Boots5', 'Workman Boots', {100, 0, 0, 0}}, 
			[ObjectNameToHashID('C_ClownShoes')] = {5, 'C_ClownShoes', 'Clown Shoes', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Boxing_ft')] = {5, 'SP_Boxing_ft', 'Boxing Boots', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Colum_FT')] = {5, 'SP_Colum_FT', 'Explorer Shoes', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Elf_FT')] = {5, 'SP_Elf_FT', 'Elf Boots', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Gnome_ft')] = {5, 'SP_Gnome_ft', 'Gnome Boots', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Goldsuit_ft')] = {5, 'SP_Goldsuit_ft', 'Glamor Shoes', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_MBand_FT')] = {5, 'SP_MBand_FT', 'Marching Band Shoes', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Mascot_B')] = {5, 'SP_Mascot_B', 'Mascot Boots', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Nascar_FT')] = {5, 'SP_Nascar_FT', 'Racing Shoes', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Nerd_FT')] = {5, 'SP_Nerd_FT', 'Nerd Shoes', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Ninja_FT')] = {5, 'SP_Ninja_FT', 'Black Ninja Socks', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_NinjaW_FT')] = {5, 'SP_NinjaW_FT', 'Green Ninja Socks', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_NinjaR_FT')] = {5, 'SP_NinjaR_FT', 'Red Ninja Socks', {0, 0, 100, 100}}, 
			[ObjectNameToHashID('SP_Nutcrack_FT')] = {5, 'SP_Nutcrack_FT', 'Nutcracker Boots', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Orderly_B')] = {5, 'SP_Orderly_B', 'Orderly Boots', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_80Rocker_FT')] = {5, 'SP_80Rocker_FT', "80's Rocker Boots", {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Wrestling_ft')] = {5, 'SP_Wrestling_ft', 'Wrestling Shoes', {0, 0, 0, 100}}, 
			[ObjectNameToHashID('SP_Panda_B')] = {5, 'SP_Panda_B', 'Panda Boots', {0, 0, 0, 100}}, 
		}
	end
	
	return TABLE_CLOTHING_REFERENCE[HASH_ID] and (TABLE_CLOTHING_REFERENCE[HASH_ID][OUTPUT] or ({0, 'Unknown', 'Unknown'})[OUTPUT]) or ({0, 'Unknown', 'Unknown'})[OUTPUT]
end

GET_WEAPON_REFERENCE = function(ID, OUTPUT)
	if type(TABLE_WEAPON_REFERENCE) == 'nil' then
		TABLE_WEAPON_REFERENCE = {
			[-1] = {'Unarmed', -1, {20, 5, 0, 0}},
			[299] = {'Yardstick', 0, {25, 10, 0, 0}}, 
			[300] = {'Bat', 0, {25, 10, 0, 0}}, 
			[301] = {'Fire Cracker', 5, {60, 40, 0, 20}}, 
			[302] = {'Baseball', 0, {5, 40, 0, 5}}, 
			[303] = {'Slingshot', 1, {30, 60, 80, 50}}, 
			[305] = {'Spud Gun', 8, {90, 50, 50, 60}}, 
			[306] = {'Super Slingshot', 1, {70, 90, 100, 90}}, 
			[307] = {'Rocket Launcher', 12, {80, 30, 20, 40}}, 
			[309] = {'Stink Bomb', 5, {0, 40, 0, 20}}, 
			[310] = {'Apple', 0, {5, 40, 0, 20}}, 
			[311] = {'Brick', 0, {10, 40, 0, 20}}, 
			[312] = {'Carton of Eggs', 12, {5, 40, 0, 20}}, 
			[313] = {'Snowball', 0, {5, 40, 0, 20}}, 
			[315] = {'Trash Lid', 0, {10, 40, 0, 20}}, 
			[320] = {'Newspaper', 30, {5, 40, 0, 20}}, 
			[321] = {'Spray Can', 12, {40, 10, 0, 0}}, 
			[323] = {'Wood Plank', 0, {5, 10, 0, 0}}, 
			[324] = {'Sledge Hammer', 0, {60, 15, 0, 0}}, 
			[325] = {'Rubber Ball', 1, {75, 40, 0, 20}}, 
			[326] = {'Fire Extinguisher', 0, {5, 25, 0, 90}}, 
			[328] = {'Camera', 1, {0, 0, 0, 0}}, 
			[329] = {'Soccer Ball', 0, {5, 40, 0, 20}}, 
			[330] = {'Big Snowball', 0, {20, 40, 0, 20}}, 
			[331] = {'Football', 0, {10, 40, 0, 20}}, 
			[335] = {'Frisbee', 0, {5, 25, 0, 5}}, 
			[338] = {'Dish', 0, {5, 40, 0, 20}}, 
			[341] = {'Pom-Pom', 0, {0, 0, 0, 0}}, 
			[342] = {'Water Pipe', 0, {40, 10, 0, 0}}, 
			[345] = {'Vase', 0, {50, 25, 0, 20}}, 
			[346] = {'Dead Rat', 0, {5, 20, 0, 10}}, 
			[348] = {'Cafeteria Tray', 0, {20, 5, 0, 0}}, 
			[349] = {'Bag of Marbles', 5, {20, 20, 0, 10}}, 
			[353] = {'Vase', 0, {50, 25, 0, 20}}, 
			[354] = {'Vase', 0, {50, 25, 0, 20}}, 
			[355] = {'Plate', 0, {20, 25, 0, 20}}, 
			[357] = {'Wood Paddle', 0, {30, 10, 0, 0}}, 
			[358] = {'Banana', 0, {5, 40, 0, 20}}, 
			[360] = {'Metal Plate', 0, {40, 25, 0, 20}}, 
			[372] = {'Kick Me', 0, {0, 0, 0, 0}}, 
			[377] = {'Broom', 0, {25, 10, 0, 0}}, 
			[381] = {'Basket Ball', 0, {10, 40, 0, 20}}, 
			[387] = {'Shield', 0, {35, 10, 0, 0}}, 
			[394] = {'Itching Powder', 5, {10, 20, 0, 60}}, 
			[395] = {'Poison Gun', 0, {5, 25, 0, 90}}, 
			[396] = {'Super Spud Gun', 8, {90, 50, 50, 60}}, 
			[397] = {'Big Firework', 0, {60, 40, 0, 0}}, 
			[399] = {'Poo Bag', 0, {0, 0, 0, 0}}, 
			[400] = {'Football (Bomb)', 0, {75, 40, 0, 60}}, 
			[401] = {'Broken Water Pipe', 0, {40, 10, 0, 0}}, 
			[402] = {'Damaged Water Pipe', 0, {40, 10, 0, 0}}, 
			[403] = {'Tissue Roll', 0, {5, 40, 0, 20}}, 
			[404] = {'Umbrella', 0, {25, 5, 0, 0}}, 
			[405] = {'Book', 0, {20, 5, 0, 0}}, 
			[409] = {'Devil Fork', 0, {40, 15, 0, 0}}, 
			[410] = {'Pinky Wand', 0, {30, 10, 0, 0}}, 
			[411] = {'Whip', 0, {30, 10, 0, 0}}, 
			[413] = {'Book', 0, {20, 5, 0, 0}}, 
			[414] = {'Book', 0, {20, 5, 0, 0}}, 
			[415] = {'Book', 0, {20, 5, 0, 0}}, 
			[416] = {'Book', 0, {20, 5, 0, 0}}, 
			[418] = {'Gold Pipe', 0, {40, 10, 0, 0}}, 
			[420] = {'Flashlight', 1, {0, 0, 0, 0}}, 
			[426] = {'Digital Camera', 1, {0, 0, 0, 0}}, 
			[437] = {'Skateboard', 1, {0, 0, 0, 0}}, 
		}
	end
	
	return TABLE_WEAPON_REFERENCE[ID] and (TABLE_WEAPON_REFERENCE[ID][OUTPUT] or ({'Unknown', 0, {0, 0, 0, 0}})[OUTPUT]) or ({'Unknown', 0, {0, 0, 0, 0}})[OUTPUT]
end


--[[
	------------------------
	# WHEEL MENU : SUPPORT #
	------------------------
]]

CLOTHING_REBUILD_CONTENT = function()
	for INDEX, CATEGORY in ipairs(WHEEL.GROUP[2].CONTENT) do
		local CLOTHING_ID = {5, 4, 1, 0, 2, 3}
		
		if type(WHEEL.GROUP[2].CONTENT[INDEX][1]) == 'table' then
			if ClothingGetPlayer(CLOTHING_ID[INDEX]) == ObjectNameToHashID(WHEEL.GROUP[2].CONTENT[INDEX][1].CODE[2]) then
				if table.getn(WHEEL.GROUP[2].CONTENT[INDEX]) > 1 then
					table.remove(WHEEL.GROUP[2].CONTENT[INDEX], table.getn(WHEEL.GROUP[2].CONTENT[INDEX]))
				end
			else
				if table.getn(WHEEL.GROUP[2].CONTENT[INDEX]) > 1 then
					table.remove(WHEEL.GROUP[2].CONTENT[INDEX], table.getn(WHEEL.GROUP[2].CONTENT[INDEX]))
				end
				table.insert(WHEEL.GROUP[2].CONTENT[INDEX], {CODE = {CLOTHING_ID[INDEX], GET_CLOTHING_REFERENCE(ClothingGetPlayer(CLOTHING_ID[INDEX]), 2)}, NAME = GET_CLOTHING_REFERENCE(ClothingGetPlayer(CLOTHING_ID[INDEX]), 3), STAT = GET_CLOTHING_REFERENCE(ClothingGetPlayer(CLOTHING_ID[INDEX]), 4)})
			end
			
			WHEEL.GROUP[2].SELECT[INDEX] = {table.getn(WHEEL.GROUP[2].CONTENT[INDEX]) > 1 and table.getn(WHEEL.GROUP[2].CONTENT[INDEX]) or 1, CLOTHING_ID[INDEX], GET_CLOTHING_REFERENCE(ClothingGetPlayer(CLOTHING_ID[INDEX]), 2)}
		end
	end
	
	if shared.WHEEL.GROUP[2].REBUILD then
		shared.WHEEL.GROUP[2].REBUILD = false
	end
end

IS_BIKE = function(VEHICLE)
	local OTHER_ID = {
		[275] = true, [284] = true, [285] = true, [286] = true, [287] = true, [288] = true, [289] = true, [290] = true, 
		[291] = true, [292] = true, [293] = true, [294] = true, [295] = true, [296] = true, [297] = true, [298] = true,
	}
	
	return OTHER_ID[VehicleGetModelId(VEHICLE)] and false or true
end

DRAW_TEXT = function(TEXT, SCALE, X, Y, ALIGN, OPACITY, FONT)
	for KEY, ARGUMENT in pairs({['Outline'] = {}, ['Scale'] = {SCALE}, ['Position'] = {X, Y}, ['Align'] = {ALIGN}, ['Color'] = {WHEEL.COMPONENT.FRONT.COLOR.TEXT.RED, WHEEL.COMPONENT.FRONT.COLOR.TEXT.GREEN, WHEEL.COMPONENT.FRONT.COLOR.TEXT.BLUE, OPACITY}, ['Font'] = {FONT}}) do
		_G['SetText'..KEY](unpack(ARGUMENT))
	end
	DrawText(TEXT)
end