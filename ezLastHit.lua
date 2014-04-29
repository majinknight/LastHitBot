local me = {}
local Menu = nil

local sVersion = 2.194

local stopLastHitKey = 32
local LastHitKey = string.byte("C")
local LaneClearKey = string.byte("V")
local TurnOffKey = string.byte("X")

------------------------------------------Unit Info---------------------------------------------
--Changes: Draven, Jinx, Karma, Kennen, Lucian, Lulu, Malzahar, Sivir, Syndra, Xerath
--Added: Elise, Thresh, Lissandra, Nami

local unitInfo = {
	    Ahri         = { projSpeed = 1.75},
        Anivia       = { projSpeed = 1.4},
        Annie        = { projSpeed = 1.2},
        Ashe         = { projSpeed = 2.0},
        Brand        = { projSpeed = 2.0},
        Caitlyn      = { projSpeed = 2.5},
        Cassiopeia   = { projSpeed = 1.20},
        Corki        = { projSpeed = 2.0},
        Draven       = { projSpeed = 1.7},
		Elise        = { projSpeed = 1.6},
		Ezreal       = { projSpeed = 2.0},
        FiddleSticks = { projSpeed = 1.75},
        Graves       = { projSpeed = 3.0},
        Heimerdinger = { projSpeed = 1.5},
        Janna        = { projSpeed = 1.2},
        Jayce        = { projSpeed = 2.2},
		Jinx         = { projSpeed = 2.75},
        Karma        = { projSpeed = 1.5},
        Karthus      = { projSpeed = 1.20},
        Kayle        = { projSpeed = math.huge},
        Kennen       = { projSpeed = 1.60},
        KogMaw       = { projSpeed = 1.8},
        Leblanc      = { projSpeed = 1.7},
		Lissandra    = { projSpeed = 2.0},
        Lucian       = { projSpeed = 2.8},
        Lulu         = { projSpeed = 1.45},
        Lux          = { projSpeed = 1.6},
        Malzahar     = { projSpeed = 2.0},
        MissFortune  = { projSpeed = 2.0},
        Morgana      = { projSpeed = 1.6},        
		Nami      	 = { projSpeed = 1.5},
		Nidalee      = { projSpeed = 1.75},
        Orianna      = { projSpeed = 1.45},
        Quinn        = { projSpeed = 2.0},
        Ryze         = { projSpeed = 2.4},
        Sivir        = { projSpeed = 1.75},
        Sona         = { projSpeed = 1.5},
        Soraka       = { projSpeed = 1.0},
        Swain        = { projSpeed = 1.6},
        Syndra       = { projSpeed = 1.8},
        Teemo        = { projSpeed = 1.3},
		Thresh       = { projSpeed = math.huge}, --??
        Tristana     = { projSpeed = 2.25},
        TwistedFate  = { projSpeed = 1.5},
        Twitch       = { projSpeed = 2.5},
        Urgot        = { projSpeed = 1.3},
        Varus        = { projSpeed = 2.0},
		Vayne        = { projSpeed = 2.0},
        Veigar       = { projSpeed = 1.1},
		Velkoz		 = { projSpeed = math.huge},
        Viktor       = { projSpeed = 2.3},
        Vladimir     = { projSpeed = 1.4},
        Xerath       = { projSpeed = 2.0},
        Ziggs        = { projSpeed = 1.5},
        Zilean       = { projSpeed = 1.2},
        Zyra         = { projSpeed = 1.7},		
		}
	
	unitInfo["Blue_Minion_Basic"] = 		{aaDelay = 333, projSpeed = 0, delayOffset = 100, isMinion = true, projectileName = "DrawFX"}
	unitInfo["Blue_Minion_Wizard"] =     { aaDelay = 460, projSpeed = 0.68, delayOffset = 100, distOffset = 80, isMinion = true, projectileName = "Mfx_bcm_mis.troy" }
	unitInfo["Blue_Minion_MechCannon"] = { aaDelay = 365, projSpeed = 1.18, delayOffset = 100, isSiegeMinion = true, isMinion = true, projectileName = "SpikeBullet.troy" }
	unitInfo["Blue_Minion_MechMelee"] = { projSpeed = 0, delayOffset = 100, isSiegeMinion = true, isMinion = true }
	
	unitInfo["Red_Minion_Basic"] = 		{aaDelay = 333, projSpeed = 0, delayOffset = 100, isMinion = true, projectileName = "DrawFX"}
	unitInfo["Red_Minion_Wizard"] =     { aaDelay = 460, projSpeed = 0.68, delayOffset = 100, distOffset = 80, isMinion = true, projectileName = "Mfx_pcm_mis.troy" }
	unitInfo["Red_Minion_MechCannon"] = { aaDelay = 365, projSpeed = 1.18, delayOffset = 100, isSiegeMinion = true, isMinion = true, projectileName = "TristannaBasicAttack_mis.troy" }
	unitInfo["Red_Minion_MechMelee"] = { projSpeed = 0, delayOffset = 100, isSiegeMinion = true, isMinion = true }

	-- Blue Turrets
	unitInfo["OrderTurretNormal"] =	{ aaDelay = 150, projSpeed = 1.14, yOffset = 400, delayOffset = 50, isTurret = true, projectileName = "OrderTurretFire2_mis.troy" }
	unitInfo["OrderTurretNormal2"] =	{ aaDelay = 150, projSpeed = 1.14, yOffset = 400, delayOffset = 50, isTurret = true, projectileName = "OrderTurretFire2_mis.troy"  }
	unitInfo["OrderTurretDragon"] =	{ aaDelay = 150, projSpeed = 1.14, yOffset = 400, delayOffset = 50, isTurret = true, projectileName = "OrderTurretFire2_mis.troy" }
	unitInfo["OrderTurretAngel"] =	{ aaDelay = 150, projSpeed = 1.14, yOffset = 400, delayOffset = 50, isTurret = true, projectileName = "OrderTurretFire2_mis.troy" }
	
	-- Red Turrets
	unitInfo["ChaosTurretWorm"] =	{ aaDelay = 150, projSpeed = 1.14, yOffset = 400, delayOffset = 50, isTurret = true, projectileName = "ChaosTurretFire2_mis.troy" }
	unitInfo["ChaosTurretWorm2"] =	{ aaDelay = 150, projSpeed = 1.14, yOffset = 400, delayOffset = 50, isTurret = true, projectileName = "ChaosTurretFire2_mis.troy"  }
	unitInfo["ChaosTurretGiant"] =	{ aaDelay = 150, projSpeed = 1.14, yOffset = 400, delayOffset = 50, isTurret = true, projectileName = "ChaosTurretFire2_mis.troy"  }
	unitInfo["ChaosTurretNormal"] =	{ aaDelay = 150, projSpeed = 1.14, yOffset = 400, delayOffset = 50, isTurret = true, projectileName = "ChaosTurretFire2_mis.troy"  }

------------------------------------------Unit Info---------------------------------------------

local startAttackSpeed = 0.665

local allyMinions = {}
local enemyMinions = {}

local incomingDetails = {}

local displayObj = nil

local movePerSec = 1/6
local lastMoveCommand = 0

if unitInfo[myHero.charName] ~= nil then
	me.projSpeed = unitInfo[myHero.charName].projSpeed
else
	me.projSpeed = 0
	--print("Hero projectile speed not found.")
end

function OnTick()
	LastHitOnTick()
end

function LastHitOnTick()
	enemyMinions:update()
	allyMinions:update()	
	
	if Menu.TurnOffRange and Menu.TurnOffRange > 0 then
		
		local foundEnemy = false
		for i=1, heroManager.iCount do
			local hero = heroManager:getHero(i)
	
			if hero.team == TEAM_ENEMY and ValidTarget(hero) and GetDistance(myHero, hero) < Menu.TurnOffRange then
				Menu.LastHitOn = false
				foundEnemy = true
				break
			end	
		end
		
		if Menu.AutoTurnOn and foundEnemy == false then
			Menu.LastHitOn = true
		end
	end
	
	if Menu.AutoTurnOn == false then
		Menu.LastHitOn = false
	end	
	
	if ( Menu.LastHitOn or Menu.LaneClearOn or Menu.ForceLastHit) and me.projSpeed ~= nil
		and Menu.StopLastHit == false then
	
		if Menu.OrbWalk and GetGameTimer() * 1000 > me.lastWindup 
			and GetGameTimer() * 1000 > me.lasthitWindup
			and GetGameTimer() * 1000 - lastMoveCommand > movePerSec then
		
		if GetDistance(mousePos) < Menu.OrbWalkHoldZone then
			if not me.holdPos then
				myHero:HoldPosition()
				me.holdPos = true
			end
		else
			myHero:MoveTo(mousePos.x, mousePos.z)
			me.holdPos = false
		end
		
		end
		
	if GetGameTimer() * 1000 > me.nextBasicTime then
	
	local selectedMinion = {}
	local laneClearMinions = {}
	local doLaneClear = true
	
	for _, minion in pairs(enemyMinions.objects) do	
		if ValidTarget(minion, GetTrueRange(myHero)) then			
					
			local predictDamage = 0
			local predictNextBasicDamage = 0						
			local sumDmg = 1
						
			local sumViableDmg = 1
			
			for sourceName, attackDetails in pairs(incomingDetails) do
				
			
				if attackDetails.target.name == minion.name and attackDetails.spellParticle
					and checkAttackStillViable(attackDetails, sourceName) then
						
				if GetMyTimeToHit(minion) > GetTimeWhenHit(attackDetails, minion) then
					predictDamage = predictDamage + attackDetails.dmg
				end
				
				if GetMyNextBasicTime() > GetTimeWhenHit(attackDetails, minion) then
					predictNextBasicDamage = predictNextBasicDamage + attackDetails.dmg
				end

				sumViableDmg = sumViableDmg + attackDetails.dmg
				end
				
				if attackDetails.target.name == minion.name then
				sumDmg = sumDmg + attackDetails.dmg
				end
			end
		
			
			if predictDamage < minion.health and predictDamage + myCalcDamage(myHero, minion) - 2 > minion.health then
				selectedMinion[#selectedMinion+1] = {minion = minion, sumIncoming = minion.health/sumDmg, sumViableDmg = sumViableDmg }
			end			
			
			laneClearMinions[#laneClearMinions+1] = {minion = minion, sumIncoming = minion.health/sumDmg }			
			
			if sumDmg + myCalcDamage(myHero, minion) - 2 > minion.health then
			doLaneClear = false
			end

		end	
	end

	if #selectedMinion > 0 then
		table.sort(selectedMinion, 
		function (a, b)
			return a.sumIncoming < b.sumIncoming 
		end)		
		
		if ValidTarget(selectedMinion[1].minion, GetTrueRange(myHero)) then
		
		local minion = selectedMinion[1].minion
		
		HeroAttack(selectedMinion[1].minion)		
		return
		end
	end
	
	if Menu.LaneClearOn and #laneClearMinions > 0 and doLaneClear then
		table.sort(laneClearMinions, 
		function (a, b)
			return a.sumIncoming < b.sumIncoming 
		end)
		
		if ValidTarget(laneClearMinions[#laneClearMinions].minion, GetTrueRange(myHero)) then
		HeroAttack(laneClearMinions[#laneClearMinions].minion)
		return
		end
	end
	
	end

	end
end

function HeroAttack(target)

	if ValidTarget(target, GetTrueRange(myHero)) and me.lastWindup < GetGameTimer() * 1000 then
	myHero:Attack(target)	
	
	me.lasthitWindup = GetGameTimer() * 1000 + 500
	me.lastWindup = GetGameTimer() * 1000 + 500
	me.nextBasicTime = GetGameTimer() * 1000 + 500
	me.movedToMouse = false
	me.attackStartTime = GetGameTimer() * 1000
	me.target = target
	
	
	--Packet('S_MOVE', { type = 3, x = target.networkID, y = target.networkID, targetNetworkId = target.networkID}):send()
	end
end

function OnSendPacket(p)	

	if Menu.BlockMovement and GetGameTimer() * 1000 < me.lasthitWindup - GetLatency() then
		packet = Packet(p)
		packetName = Packet(p):get('name')		
		
		if packetName == 'S_MOVE' or packetName == 'S_CAST' then		
			packet:block()		
		end
	end
end

function GetMissileParticle(attackDetails)
	if attackDetails.spellParticle == nil then
		local mis = objManager:GetObjectByNetworkId(attackDetails.spell.projectileID)
				
		if mis then
		attackDetails.spellParticle = mis
		end				
	end
end

function GetTrueRange(source)
	return source.range + GetDistance(source, source.minBBox)
end

function GetMyTimeToHit(target)

	if myHero.range < 400 then
		return GetGameTimer() * 1000 + me.windupTime - 50 - Menu["ChampionSettings".. myHero.charName].LastHitDelay
	else
		return GetGameTimer() * 1000 + GetDistance(target)/me.projSpeed + me.windupTime - 50 - Menu["ChampionSettings".. myHero.charName].LastHitDelay
	end

end

function GetMyNextBasicTime()

	if myHero.range < 400 then
		return GetGameTimer() * 1000 + GetAttackTime() + me.windupTime + GetLatency()
	else
		return GetGameTimer() * 1000 + GetAttackTime() + me.windupTime + myHero.range/me.projSpeed + GetLatency()
	end
end

function GetTimeWhenHit(attackDetails, target)

	local source = getAllyMinion(attackDetails.source.name)
	

	if attackDetails.speed == 0 and attackDetails.spellParticle ~= nil then
		return attackDetails.startTime + attackDetails.delayOffset
	elseif attackDetails.speed > 0 and attackDetails.spellParticle ~= nil then
		return GetGameTimer() * 1000 + GetDistance(attackDetails.spellParticle, target)/attackDetails.speed + attackDetails.delayOffset
	else
		return GetGameTimer() * 1000 + 2000
	end	
end

function getAllyMinion(name)
	for i, minion in pairs(allyMinions.objects) do
		if minion ~= nil and minion.valid and minion.name == name then
			return minion
		end
	end
	return nil
end
 
function getEnemyMinion(name)
	for i, minion in pairs(enemyMinions.objects) do
		if minion ~= nil and ValidTarget(minion) and minion.name == name then
			return minion
		end
	end
	return nil
end


function OnDraw()
	LastHitOnDraw()
end

function LastHitOnDraw()	
	if Menu.DrawRangeCircle then
		DrawCircle(myHero.x, myHero.y, myHero.z, getTrueRange(), 0x19A712)
		DrawCircle(myHero.x, myHero.y,myHero.z, Menu.OrbWalkHoldZone, 0xFFFFFF)
	end	
end

function getTrueRange()
    return myHero.range + GetDistance(myHero.minBBox)
end

function getMinionAttackDetails(source, target, spell)
	return {startTime = GetGameTimer() * 1000,
			windupTime = (spell.windUpTime or 0) * 1000,
			speed = unitInfo[source.charName].projSpeed or 0, 
			dmg = myCalcDamage(source,target), -- source:CalcDamage(target),
			source = source,
			target = target,
			spell = spell,
			delayOffset = unitInfo[source.charName].delayOffset or 0,
			spellParticle = nil,
			projectileName = unitInfo[source.charName].projectileName,
			stillViable = true
			}
end

function myCalcDamage(source, target)
	local armorPen = 0
	local armorPenPercent = 0
	
	local magicPen = 0
	local magicPenPercent = 0
	
	local magicDamage = 0
	local physDamage = source.totalDamage
	
	local dmgReductionPercent = 0

	local totalDamage = physDamage

		
	if source.name == myHero.name then
		if Menu.Mastery.ArcaneBladeOn then
			magicDamage = myHero.ap * .05
		end
		
		if Menu.Mastery.DevestatingStrike then
			armorPenPercent = .06
		end
		
		if Menu.Mastery.HavocOn then
			physDamage = physDamage * 1.03
			magicDamage = magicDamage * 1.03
		end
		
		if Menu.Mastery.ExecutionerOn then
			physDamage = physDamage * 1.05
			magicDamage = magicDamage * 1.05
		end
				
		if Menu.Mastery.DEdgedSwordOn then
			physDamage = myHero.range < 400 and physDamage*1.02 or (physDamage*1.015)
			magicDamage = myHero.range < 400 and magicDamage*1.02 or (magicDamage*1.015)
		end
		
		if Menu.Mastery.ButcherOn then
			physDamage = physDamage + 2
		end
	
	end
	
	if unitInfo[source.charName] ~= nil then
		if unitInfo[source.charName].isTurret ~= nil then	
			armorPenPercent = .3
		end
		
		if unitInfo[source.charName].isTurret ~= nil and unitInfo[target.charName].isMinion ~= nil then	
			armorPenPercent = 0
			physDamage = physDamage * 1.3
		end
		
		if unitInfo[source.charName].isTurret ~= nil and unitInfo[target.charName].isSiegeMinion ~= nil then
			dmgReductionPercent = .3
		end
	end

	return (physDamage * (100/(100 + target.armor * (1-armorPenPercent)))  
	 + magicDamage * (100/(100 + target.magicArmor * (1-magicPenPercent))) ) * (1-dmgReductionPercent)
end

function checkAttackStillViable (attackDetails)
			
	if attackDetails == nil then return false end
	
	if attackDetails.stillViable == false then return false end
	
	local source = attackDetails.source
	local target = attackDetails.target
	
	if source == nil or target == nil 
		or source.dead or target.dead then
		attackDetails.stillViable = false
		
		local key = attackDetails.source.name
		incomingDetails[key] = nil		
		return false
	end
	
	local timeElapsed = GetGameTimer() * 1000 - attackDetails.startTime	
	
	if timeElapsed > 2000 then	
		attackDetails.stillViable = false
		
		local key = attackDetails.source.name
		incomingDetails[key] = nil
		return false
	end
	
	return true
end

function OnProcessSpell(object, spell)


	if unitInfo[object.charName] ~= nil and object.charName ~= myHero.charName then
	
	for _, minion in pairs(enemyMinions.objects) do
					
		if ValidTarget(minion) and minion ~= nil and GetDistance(minion, spell.endPos) < 25 then
			
			
			incomingDetails[object.name] = getMinionAttackDetails(object, minion, spell)
			if spell.projectileID then
			DelayAction(GetMissileParticle, spell.windUpTime + 0.05, {incomingDetails[object.name]})
			end
		end
	end
	
	end
	

	if object.name == myHero.name then
		if spell.name:find("Attack")
		or spell.name == "frostarrow"
		or spell.name == "CaitlynHeadshotMissile"
		or spell.name == "KennenMegaProc"
		or spell.name == "QuinnWEnhanced"
		or spell.name == "LucianPassiveShot" then
		
			me.windupTime = spell.windUpTime*1000
			me.basicAttackSpell = spell
			
			me.lastWindup = GetGameTimer() * 1000 + spell.windUpTime*1000 + 50
			me.nextBasicTime = GetGameTimer() * 1000 + spell.animationTime*1000
						
			if GetGameTimer() * 1000 < me.lasthitWindup then
				me.lasthitWindup = me.lastWindup
			end			
		end
		
		if refreshAttack(spell.name) then
			me.lastWindup = GetGameTimer() * 1000 - 50
			me.nextBasicTime = GetGameTimer() * 1000 - 50
		end
	end
end

function refreshAttack(spellName)
    return (
		--Blitzcrank
		spellName == "PowerFist"
		--Darius
		or spellName == "DariusNoxianTacticsONH"
		--Nidalee
		or spellName == "Takedown"
		--Sivir
		or spellName == "Ricochet"
		--Teemo
		or spellName == "BlindingDart"
		--Vayne
		or spellName == "VayneTumble"
		--Jax
		or spellName == "JaxEmpowerTwo"
		--Mordekaiser
		or spellName == "MordekaiserMaceOfSpades"
		--Nasus
		or spellName == "SiphoningStrikeNew"
		--Rengar
		or spellName == "RengarQ"
		--Wukong
		or spellName == "MonkeyKingDoubleAttack"
		--Yorick
		or spellName == "YorickSpectral"
		--Vi
		or spellName == "ViE"
		--Garen
		or spellName == "GarenSlash3"
		--Hecarim
		or spellName == "HecarimRamp"
		--XinZhao
		or spellName == "XenZhaoComboTarget"
		--Leona
		or spellName == "LeonaShieldOfDaybreak"
		--Shyvana
		or spellName == "ShyvanaDoubleAttack"
		or spellName == "shyvanadoubleattackdragon"
		--Talon
		or spellName == "TalonNoxianDiplomacy"
		--Trundle
		or spellName == "TrundleTrollSmash"
		--Volibear
		or spellName == "VolibearQ"
		--Poppy
		or spellName == "PoppyDevastatingBlow"
    )
end

function OnRecall(hero, channelTimeInMs)
	if hero.name == myHero.name then
		Menu.LastHitOn = false
		Menu.AutoTurnOn = false
		Menu.LaneClearOn = false
		Menu.ForceLastHit = false
	end
end


function OnAnimation(unit, animation)    
	if unit.name == myHero.name then
		if GetGameTimer() * 1000 < me.lastWindup and not animation:find("Attack") then
			me.lastWindup = GetGameTimer() * 1000 - 50
			me.nextBasicTime = GetGameTimer() * 1000 - 50
		end
	end
	
	if incomingDetails[unit.name] then
		if GetGameTimer() * 1000 < incomingDetails[unit.name].windupTime and not animation:find("Attack") then
			incomingDetails[unit.name].stillViable = false
		end
		
		if animation == "Death" then
			incomingDetails[unit.name] = nil
		end		
	end	
end

function lastHitOnLoad()

	enemyMinions = minionManager(MINION_ENEMY, 2000, player, MINION_SORT_HEALTH_ASC)
    allyMinions = minionManager(MINION_ALLY, 2000, player, MINION_SORT_HEALTH_ASC)

	me.windupTime = 100
	me.lastWindup = 0
	me.nextBasicTime = 0
	me.lasthitWindup = 0
	me.movedToMouse = true
end

function GetAttackTime ()
	return (1/(startAttackSpeed * myHero.attackSpeed))*1000
end

function OnLoad()	
		
        PrintChat("<font color=\"#3F92D2\" >ezLastHit v" .. sVersion .. " Loaded </font>")
		
		CheckForUpdates()
		
		Menu = scriptConfig("ezLastHit v" .. sVersion, "ezLastHit")
		Menu:addParam("LastHitOn", "LastHit On", SCRIPT_PARAM_ONOFF, false)
		Menu:addParam("ForceLastHit", "Force LastHit", SCRIPT_PARAM_ONKEYDOWN, false, LastHitKey)
		Menu:addParam("StopLastHit", "Stop LastHit Key", SCRIPT_PARAM_ONKEYDOWN, false, stopLastHitKey)
		Menu:addParam("AutoTurnOn", "Auto turn on", SCRIPT_PARAM_ONKEYTOGGLE, true, TurnOffKey)
		Menu:addParam("LaneClearOn", "LaneClear Mode", SCRIPT_PARAM_ONKEYDOWN, false, LaneClearKey)
		Menu:addParam("DrawRangeCircle", "Draw Range Circle", SCRIPT_PARAM_ONOFF, false)
		Menu:addParam("OrbWalk", "Last hit while Orbwalking", SCRIPT_PARAM_ONOFF, false)
		Menu:addParam("BlockMovement", "Block Movement when LastHitting (VIP)", SCRIPT_PARAM_ONOFF, true)
		Menu:addParam("TurnOffRange", "LastHit Range", SCRIPT_PARAM_SLICE, 700, 0, 2000, 0)
		Menu:addParam("OrbWalkHoldZone", "Orbwalk Hold Zone", SCRIPT_PARAM_SLICE, 125, 0, 700, 0)
		
		Menu:addSubMenu("LastHit Delay", "ChampionSettings" .. myHero.charName)
		Menu["ChampionSettings".. myHero.charName]:addParam("LastHitDelay", "LastHit Delay", SCRIPT_PARAM_SLICE, 0, -200, 200, 0)
		
		Menu.LastHitOn = false
		Menu.AutoTurnOn = false
		Menu.LaneClearOn = false
		Menu.ForceLastHit = false
		
		Menu:permaShow("AutoTurnOn")
		Menu:permaShow("LastHitOn")
		Menu:permaShow("ForceLastHit")
		Menu:permaShow("LaneClearOn")		
				
		Menu:addSubMenu("Mastery", "Mastery")
		Menu.Mastery:addParam("DevestatingStrike", "DevestatingStrike", SCRIPT_PARAM_ONOFF, true)
		Menu.Mastery:addParam("HavocOn", "HavocOn", SCRIPT_PARAM_ONOFF, true)
		Menu.Mastery:addParam("DEdgedSwordOn", "DEdgedSwordOn", SCRIPT_PARAM_ONOFF, true)
		Menu.Mastery:addParam("ButcherOn", "ButcherOn", SCRIPT_PARAM_ONOFF, true)
		Menu.Mastery:addParam("ArcaneBladeOn", "ArcaneBladeOn", SCRIPT_PARAM_ONOFF, true)
		
		lastHitOnLoad()
end

----------------AUTO Update------------------------------

function DownloadScript (scriptName, scriptVersion, url, scriptPath)
	local UPDATE_TMP_FILE = LIB_PATH.. scriptName .. "Tmp.txt"
	
	DownloadFile(url, UPDATE_TMP_FILE, 
		function ()
		
		file = io.open(UPDATE_TMP_FILE, "rb")
		if file ~= nil then
        downloadContent = file:read("*all")
        file:close()
        os.remove(UPDATE_TMP_FILE)
		end
		
	
	if downloadContent then
		
		file = io.open(scriptPath, "w")
        
		if file then
            file:write(downloadContent)
            file:flush()
            file:close()
            print("Successfully updated " .. scriptName .. " to Version " .. scriptVersion)
			print("Please press F9 to reload script.")
        else
            print("Error updating!")
        end
		
	end
	
		
	end)	
end

function ReadLastUpdateTime ()

	local updateTimeFile = LIB_PATH.."ezUpdateTime"
	
	file = io.open(updateTimeFile, "rb")
	if file ~= nil then
    content = file:read("*all")
    file:close()
	
	return tonumber(content)
	end
	
	return 0
end

function WriteLastUpdateTime ()
	local updateTimeFile = LIB_PATH.."ezUpdateTime"
	
	file = io.open(updateTimeFile, "w")
     
	if file then
        file:write(os.time())
        file:flush()
        file:close()
    end
end

function CheckForUpdates ()
	
	local lastUpdateTime = ReadLastUpdateTime()
			
	--if true then
	if os.time()-lastUpdateTime > 3*86400 and os.time() > lastUpdateTime then --a day has passed
		
	local URL = "https://bitbucket.org/Xgs/bol/raw/master/Versions.txt"
	local UPDATE_TMP_FILE = LIB_PATH.."TmpVersions.txt"
	
	DownloadFile(URL, UPDATE_TMP_FILE, 
	function ()
		file = io.open(UPDATE_TMP_FILE, "rb")
		if file ~= nil then
        versionTextContent = file:read("*all")
        file:close()
        os.remove(UPDATE_TMP_FILE)
		end
	
	if versionTextContent then		
		local url = "https://bitbucket.org/Xgs/bol/raw/master/ezLastHit.lua"
		Update(versionTextContent, "ezLastHit", sVersion, url, SCRIPT_PATH.."ezLastHit.lua")
	end
		
	end)
	
	WriteLastUpdateTime()
	end
	
end
	
function Update(versionText, scriptName, scriptVersion, url, scriptPath)
	local content = versionText
	
	--print("Checking updates for " .. scriptName .. "...")
	
    if content then		
        tmp, sstart = string.find(content, "\"" .. scriptName .. "\" : \"")
        if sstart then
            send, tmp = string.find(content, "\"", sstart+1)
        end
		
        if send then
            Version = tonumber(string.sub(content, sstart+1, send-1))
        end
		
		if (Version ~= nil) and (Version > scriptVersion) then 
		
		print("Found update for " .. scriptName .. ", downloading...")
		DelayAction(DownloadScript,2,{scriptName, Version, url, scriptPath})
		
			
        elseif (Version ~= nil) and (Version <= scriptVersion) then
            --print("No updates found. Latest Version: " .. Version)
        end
    end
end
----------------AUTO Update------------------------------