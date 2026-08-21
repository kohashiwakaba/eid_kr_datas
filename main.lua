if not EID then return end
local mod = RegisterMod("Korean EID Descriptions for modded items", 1)

wakaba_krdesc = mod ---@class wakaba_krdesc: ModReference

---@class EIDConditionalEntry
---@field ModifierText string
---@field Function? fun(descObj:EID_DescObj):boolean? condition function. Only on `en_us`
---@field Vars?
---@field Type?
---@field Layer? integer @default: `1`
---@field Description string condition description when condition is met

---@class EIDModifierEntry
---@field ModifierText string
---@field ModifierCond? fun(descObj:EID_DescObj):boolean? condition function. Only on `en_us`
---@field ModifierCallback? fun(descObj:EID_DescObj):EID_DescObj? condition function. Only on `en_us`
---@field Position? integer

---@alias WakabaDescriptionType
---|"player" Wakaba or Modded players.
---|"transformation" Wakaba or Modded transformations
---|"collectible" Wakaba or Modded collectibles.
---|"trinket" Wakaba or Modded trinkets.
---|"card" Wakaba or Modded cards.
---|"pill" Wakaba or Modded pills.
---|"curse" Wakaba or Modded curses.
---|"append" Descriptions for append.
---|"entity" Generic entities.

---@class WakabaDescriptionEntry
---@field _descType WakabaDescriptionType
---@field Mod? string mod entry used by `EID._currentMod`
---@field Name? string @default: Name shown on EID <br>
---@field ReminderName? string @default:
---@field QuoteDesc? string Non-EID. Used for quotes when picking up item. <br> Does not exist for `en_us`
---@field Description? string Description for EID <br> `"player"` - Used for Inventory Descriptions feature.
---@field Insane? string Wakaba mod only. Description for EID while on Insane difficulty
---@field Conditionals? EIDConditionalEntry[]
---@field Modifiers? EIDModifierEntry[]
---@field Icon? string `"curse"`|`"richer_uniform"` - shortcut for EID icon.
---@field Short? string `"player"` - Used for Item Reminder.
---@field Birthright? string `"player"` - Birthright descriptions.
---@field BirthrightQuote? string `"player"` - Used for quotes when picking up Birthright.
---@field Duplicate? string|boolean `"collectible"` - Diplopia, Crooked penny. `false` : no effect
---@field BFFS? string|string[]|number[]|false `"collectible"`|`"trinket"` - BFFS synergies
---@field Belial? string `"collectible"` - Judas + Birthright synergies
---@field Binge? string `"collectible"` - Binge Eater synergies
---@field Wisp? string `"collectible"` - Book of Virtues synergies
---@field Abyss? string `"collectible"` - Abyss synergies
---@field CarBattery? string|string[]|number[]|false `"collectible"` - Car Battery synergies
---@field GoldenTrinketData? EID_GoldenTrinketData `"trinket"` - Golden Trinket meta
---@field Golden? string[] `"trinket"` - Golden Trinket description
---@field Tarot? string|string[]|number[] `"card"` - Tarot Card synergies
---@field TarotBlank? string `"card"` - Tarot Card synergies when using Blank Card
---@field Horse? string `"pill"` - Horse Pill descriptions
---@field AppendEntries? string|string[] shortcut key to append
---@field KeepItemConfig? boolean Don't change itemConfig name and descriptions


local modsToLoad = {
	-- Majors
	FIENDFOLIO = "fiendfolio",
	--RETRIBUTION = "retribution",
	--REVEL = "revelations",
	--GODMODE = "godmode",
	--DELIVERANCE = "deliverance",
	--CR = "community_remix_2024",
	--LOST_AND_FORGOTTEN = "lost_and_forgotten",
	--OP365 = "operation_365",
	-- Middles
	--SAMAEL = "samael",
	--WARPZONE = "warpzone",
	--SACRED_DREAMS = "sacred_dreams",
	--TAINTED_TREASURE = "tainted_treasure",
	--MATT_PACK = "matt_pack",
	--AURI = "auri",
	--ITEMJAM_1 = "itemjam_1",
	SHERIFF = "sheriff",
	-- Characters
	--YONDU = "yondu",
	--ALICE = "alice_ba",
	--KIRBY = "kirby",
}

--bulk append from retribution (cuz i'm lazy)
function mod.BulkAppend(hostTable, appendTable)
	for _, entry in pairs(appendTable) do
		table.insert(hostTable, entry)
	end
end

function mod.IndexedBulkAppend(hostTable, appendTable)
	for _, entry in pairs(appendTable) do
		hostTable[entry[1]] = entry[2]
	end
end

function mod.KeyValueBulkAppend(hostTable, appendTable)
	for index, entry in pairs(appendTable) do
		hostTable[index] = entry
	end
end

local function split(str, delimiter)
	local result = {}
	-- The pattern '([^' .. delimiter .. ']+)' matches one or more characters
	-- that are NOT the delimiter.
	for part in string.gmatch(str, "([^" .. delimiter .. "]+)") do
		table.insert(result, part)
	end
	return result
end

---@param keyString string
---@return number?
---@return number?
---@return number?
---@return string
local function spliceKey(keyString)
	local r = split(keyString, ".")
	local s = {}
	for i, k in ipairs(r) do
		s[i] = tonumber(k)
	end
	return s[1], s[2], s[3], keyString
end

wakaba_krdesc.ERRORS = {}
wakaba_krdesc.entries = {}
wakaba_krdesc.richer_entries = {}

function mod:loadDescriptionData()
	if not (REPENTANCE_PLUS and REPENTOGON) then return end
	--load scripts
	for key, v in pairs(modsToLoad) do
		print("[리셰쨩] ["..key.."] 모드 설명 데이터 로드 중...")
		wakaba_krdesc.richer_entries[key] = include("wakaba_krdesc.richer_descriptions." .. v)
		if type(wakaba_krdesc.richer_entries[key]) == "string" then
			print("[리셰쨩] ["..key.."] 모드 설명 데이터 로드 실패. 스팀 창작마당에서 재구독 요망")
			print("--------------------------------------------")
			print(wakaba_krdesc.richer_entries[key])
			print("--------------------------------------------")
			table.insert(wakaba_krdesc.ERRORS, {
				err_mod = key,
				custom = "설명 파일이 정상적으로 로드되지 않았습니다. 모드를 재설치 해주세요."
			})
			break
		end
	end
end

if not (REPENTANCE_PLUS and REPENTOGON) then
	wakaba_krdesc.ERROR_NO_REQ = true
else
	--wakaba_krdesc.entries.FIENDFOLIO = include("wakaba_krdesc.legacy_descriptions.fiendfolio")
	wakaba_krdesc.entries.RETRIBUTION = include("wakaba_krdesc.legacy_descriptions.retribution")
	wakaba_krdesc.entries.REVEL = include("wakaba_krdesc.legacy_descriptions.revelations")
	wakaba_krdesc.entries.GODMODE = include("wakaba_krdesc.legacy_descriptions.godmode")
	wakaba_krdesc.entries.SAMAEL = include("wakaba_krdesc.legacy_descriptions.samael")
	wakaba_krdesc.entries.DELIVERANCE = include("wakaba_krdesc.legacy_descriptions.deliverance")
	wakaba_krdesc.entries.HEAVENS_CALL = include("wakaba_krdesc.legacy_descriptions.heavens_call")
	wakaba_krdesc.entries.WARPZONE = include("wakaba_krdesc.legacy_descriptions.warpzone")
	wakaba_krdesc.entries.SHERIFF = include("wakaba_krdesc.legacy_descriptions.sheriff")
	wakaba_krdesc.entries.YONDU = include("wakaba_krdesc.legacy_descriptions.yondu")
	wakaba_krdesc.entries.ALICE = include("wakaba_krdesc.legacy_descriptions.alice_ba")
	wakaba_krdesc.entries.CR = include("wakaba_krdesc.legacy_descriptions.community_remix_2024")
	wakaba_krdesc.entries.SACRED_DREAMS = include("wakaba_krdesc.legacy_descriptions.sacred_dreams")
	wakaba_krdesc.entries.TAINTED_TREASURE = include("wakaba_krdesc.legacy_descriptions.tainted_treasure")
	wakaba_krdesc.entries.MATT_PACK = include("wakaba_krdesc.legacy_descriptions.matt_pack")
	wakaba_krdesc.entries.KIRBY = include("wakaba_krdesc.legacy_descriptions.kirby")
	wakaba_krdesc.entries.LOST_AND_FORGOTTEN = include("wakaba_krdesc.legacy_descriptions.lost_and_forgotten")
	--wakaba_krdesc.entries.FOKS_BOOSTER_PACK = include("wakaba_krdesc.legacy_descriptions.foks_booster_pack")
	wakaba_krdesc.entries.AURI = include("wakaba_krdesc.legacy_descriptions.auri")
	wakaba_krdesc.entries.ITEMJAM_1 = include("wakaba_krdesc.legacy_descriptions.itemjam_1")
end

function wakaba_krdesc:ModsLoaded_MakeEntries()
	mod:loadDescriptionData()

	table.insert(EID.TextReplacementPairs, {"<<<", "{{ArrowGrayLeft}}"})
	table.insert(EID.TextReplacementPairs, {">>>", "{{ArrowGrayRight}}"})
	table.insert(EID.TextReplacementPairs, {"↕", "{{ArrowUpDown}}"})
	EID:addIcon("Familiar", "familiar", 0, 10, 10, 5, 5, EID.IconSprite)
	--EID.InlineIcons["Familiar"] = {}
end
wakaba_krdesc:AddPriorityCallback(ModCallbacks.MC_POST_MODS_LOADED, CallbackPriority.EARLY, wakaba_krdesc.ModsLoaded_MakeEntries)

--[[
	Each included objects returns as specific format
	{
		birthright = {insert birthright desc here},
		collectibles = {insert collectibles desc here},
		trinkets = {insert trinkets desc here},
		cards = {insert cards desc here},
		pills = {insert pills desc here},
	}

	each item descriptions in table consists of certain entries:
	[ItemID] = {
			Name = Item Name. Character name for Birthright,
			QuoteDesc = Item Descriptions when picked up,
			Description = Item Descriptions for EID. Follows EID Format,
			Wisps = Synergies for Book of Virtues. Follows EID Format,
			Belial = Synergies for Book of Belial Birthright. Follows EID Format,
	}
]]

-- TODO : Library Expanded
--wakaba_krdesc.LIBRARY_EXPANDED = include("wakaba_krdesc.legacy_descriptions.library_expanded")

local hasShownStartWarning = false
local function checkStartOfRunWarnings()
	if EID:getLanguage() == "ko_kr" then
		local game = Game()
		local str = ""
		local display = false

		local no_rgon = false
		local invalid_version = false
		local custom = false

		if wakaba_krdesc.ERROR_NO_REQ then
			display = true
			str = [[
				!!! {{NoLB}}{{ColorRed}}REPENTOGON+가 적용/설치되지 않았습니다.
				!!! {{NoLB}}{{ColorRed}}REPENTOGON+를 설치하기 전까지 모드 설명이 한글로 표시되지 않습니다.
				만약 아이템을 추가하는 모드를 적용 중이지 않다면 아래 모드를 적용 해제해 주세요.
				{{IND}} z Mod items EID Korean translations]]
		elseif #wakaba_krdesc.ERRORS > 0 then
			display = true
			for _, err in ipairs(wakaba_krdesc.ERRORS) do
				if err.current then
					invalid_version = true
				elseif err.custom then
					custom = true
				end
			end
			if invalid_version then
				str = [[
					!!! {{NoLB}} {{ColorEIDError}}업데이트되지 않은 모드가 있습니다.
					{{NoLB}} {{ColorEIDError}}창작마당에서 해당 모드를 업데이트하기 전까지 아래 모드의 설명은 적용되지 않습니다.]]
				for _, err in ipairs(wakaba_krdesc.ERRORS) do
					if not err.NO_RGON and err.current then
						str = str
								.. "#{{IND}} {{NoLB}}{{ColorEIDObjName}}" .. err.err_mod .. "{{CR}}(" .. err.current .. " -> " .. err.required .. ")"
					end
				end
			end
			if custom then
				str = [[
					!!! {{NoLB}} {{ColorEIDError}}일부 모드 적용에 문제가 발견되었습니다. 
					{{NoLB}} {{ColorEIDError}}해당 문제 해결 전까지 아래 모드의 설명은 적용되지 않습니다.]]
				for _, err in ipairs(wakaba_krdesc.ERRORS) do
					if not err.NO_RGON and err.current then
						str = str
								.. "#{{IND}} {{NoLB}}{{ColorEIDObjName}}" .. err.err_mod .. "{{CR}}(" .. err.custom .. ")"
					end
				end
			end
		end

		if display then
			if not EID.Config["DisableStartOfRunWarnings"] and game:GetFrameCount() < 10 * 30 then
				local demoDescObj = EID:getDescriptionObj(-999, -1, 1)
				demoDescObj.Name = EID:getDescriptionEntry("AchievementWarningTitle") or ""
				demoDescObj.Description = str
				EID:displayPermanentText(demoDescObj, "AchievementWarningTitle")
				hasShownStartWarning = true
			elseif hasShownStartWarning then
				EID:hidePermanentText()
				hasShownStartWarning = false
				mod:RemoveCallback(ModCallbacks.MC_POST_RENDER, checkStartOfRunWarnings)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_RENDER, checkStartOfRunWarnings)

local managedTable = {
	birthright = {},
	characters = {},
	collectibles = {},
	trinkets = {},
	cards = {},
	pills = {},
}
local managedTable2 = wakaba_krdesc.richer_entries ---@type table<string, table<string, WakabaDescriptionEntry>>

wakaba_krdesc.managedTable = managedTable
wakaba_krdesc.managedTable2 = managedTable2

do
	for modEntry, e in pairs(wakaba_krdesc.entries) do
		if e and e.targetMod then
			if e.birthright then
				for p, b in pairs(e.birthright) do
					managedTable.characters[p] = {
						targetMod = b.targetMod,
						playerName = b.Name,
						birthright = b.Description,
						queueDesc = b.QuoteDesc,
					}
				end
			end
			if e.characters then
				for p, b in pairs(e.characters) do
					managedTable.characters[p] = {
						targetMod = b.targetMod,
						playerName = b.Name,
						shortDesc = b.Description,
						detailedDesc = b.Detailed,
						birthright = b.Birthright,
						queueDesc = b.QuoteDesc,
					}
				end
			end
			if e.collectibles then
				for itemID, itemdesc in pairs(e.collectibles) do
					managedTable.collectibles[itemID] = {
						targetMod = e.targetMod,
						itemName = itemdesc.Name,
						description = itemdesc.Description,
						queueDesc = itemdesc.QuoteDesc,
					}
				end
			end
			if e.trinkets then
				for itemID, itemdesc in pairs(e.trinkets) do
					managedTable.trinkets[itemID] = {
						targetMod = e.targetMod,
						itemName = itemdesc.Name,
						description = itemdesc.Description,
						queueDesc = itemdesc.QuoteDesc,
					}
				end
			end
			if e.cards then
				for itemID, itemdesc in pairs(e.cards) do
					managedTable.cards[itemID] = {
						targetMod = e.targetMod,
						itemName = itemdesc.Name,
						description = itemdesc.Description,
						queueDesc = itemdesc.QuoteDesc,
					}
				end
			end
			if e.pills then
				for itemID, itemdesc in pairs(e.pills) do
					managedTable.pills[itemID] = {
						targetMod = e.targetMod,
						itemName = itemdesc.Name,
						description = itemdesc.Description,
						queueDesc = itemdesc.QuoteDesc,
					}
				end
			end
		end
	end
end

wakaba_krdesc:AddPriorityCallback(ModCallbacks.MC_POST_MODS_LOADED, CallbackPriority.LATE, function ()

	local ic = Isaac.GetItemConfig()
	
	for modKey, modEntries in pairs(managedTable2) do
		if (type(modEntries) ~= "table") then
			break
		end
	end

	-- 신규 설명 데이터
	for modKey, modEntries in pairs(managedTable2) do
		for key, itemDesc in pairs(modEntries) do
			for k, v in pairs(itemDesc) do
				if type(itemDesc[k]) == "string" then
					itemDesc[k] = string.gsub(itemDesc[k], "#$", "")
				end
			end

			EID._currentMod = itemDesc.Mod or "부끄부끄 리셰쨩"
			if EID._currentMod == "부끄부끄 리셰쨩" then
				EID:setModIndicatorName("부끄부끄 리셰쨩")
			end
			local d = itemDesc._descType
			local n = itemDesc.Name

			-- 어펜드 설명 추가
			if d ~= "append" then
				local appendDescs = itemDesc.AppendEntries
				if type(appendDescs) == "string" then
					appendDescs = {appendDescs}
				end
				---@cast appendDescs string[]?
				if appendDescs then
					for _, appendKey in ipairs(appendDescs) do
						local entry = modEntries[appendKey]
						if entry and entry.Description then
							itemDesc.Description = itemDesc.Description .. entry.Description
						end
					end
				end
			end

			local t, v, s, fallback = spliceKey(key)
			if not (t and v and s) then
			elseif d == "transformation" then
				EID:addEntity(t, v, s, n, itemDesc.Description, "ko_kr")
				EID:createTransformation(itemDesc.TransKey, n, "ko_kr")
			elseif d == "player" then
				-- Reminder Desc
				local shortDesc = itemDesc.Short
				EID:addCharacterInfo(s, shortDesc, n, "ko_kr")
				-- Birthright
				local brDesc = itemDesc.Birthright
				EID:addBirthright(s, brDesc, n, "ko_kr")
				-- Inventory Desc
				if InventoryDescriptions then
					local idDesc = itemDesc.Description
					EID:addEntity(InvDescEIDType.PLAYER, InvDescEIDVariant.DEFAULT, s, n, idDesc, "ko_kr")
				end
			elseif d == "collectible" then
				local itemConf = ic:GetCollectible(s)
				local desc = itemDesc.Description
				EID:addCollectible(s, desc, n, "ko_kr")
				-- TODO 영어 아이템 이름
				-- Car Battery
				if type(itemDesc.CarBattery) == "boolean" and itemDesc.CarBattery == false then
					EID.CarBatteryNoSynergy[s] = true
				else
					EID.descriptions["ko_kr"].carBattery[s] = itemDesc.CarBattery
				end
				-- BFFS
				EID.descriptions["ko_kr"].BFFSSynergies["5.100."..s] = itemDesc.BFFS
				-- Belial
				EID.descriptions["ko_kr"].bookOfBelialBuffs[s] = itemDesc.Belial
				-- Binge
				EID.descriptions["ko_kr"].bingeEaterBuffs[s] = itemDesc.Binge
				-- TODO Book of Virtues
				EID.descriptions["ko_kr"].bookOfVirtuesWisps[s] = itemDesc.Wisp
				-- TODO Abyss
				EID.descriptions["ko_kr"].abyssSynergies[s] = itemDesc.Abyss
				-- TODO Duplicate
				if type(itemDesc.Duplicate) == "string" then
					EID.descriptions["ko_kr"].ConditionalDescs["5.100."..s.." (Copies)"] = itemDesc.Duplicate
				end
			elseif d == "trinket" then
				local desc = itemDesc.Description
				EID:addTrinket(s, desc, n, "ko_kr")
				-- TODO Golden Trinket Data
				--EID.descriptions["ko_kr"].goldenTrinketData = itemDesc.GoldenTrinketData
				--EID.descriptions["ko_kr"].goldenTrinketEffects = itemDesc.Golden
			elseif d == "card" then
				local desc = itemDesc.Description
				EID:addCard(s, desc, n, "ko_kr")
				EID.descriptions["ko_kr"].tarotClothBuffs[s] = itemDesc.Tarot
			elseif d == "pill" then
				local desc = itemDesc.Description
				EID:addPill(s, desc, n, "ko_kr")
				if itemDesc.Horse then
					local horse = itemDesc.Horse
					EID:addHorsePill(s, horse, n, "ko_kr")
				end
			elseif d == "curse" then
				if InventoryDescriptions then
					local desc = itemDesc.Description
					EID:addEntity(InvDescEIDType.CURSE, InvDescEIDVariant.DEFAULT, s, n, desc, "ko_kr")
				end
			else
				local desc = itemDesc.Description
				EID:addEntity(t, v, s, n, desc, "ko_kr")
				EID:AddIconToObject(t, v, s, itemDesc.Icon)
			end

			if itemDesc.Modifiers then
				for _, m in ipairs(itemDesc.Modifiers) do
					if m.ModifierText and m.ModifierCond and m.ModifierCallback then
						EID:addDescriptionModifier(m.ModifierText, m.ModifierCond, m.ModifierCallback, m.Position)
					end
				end
			end

			EID._currentMod = "부끄부끄 리셰쨩"
		end
	end

	-- 인게임 ui 한글 표기
	if not (REPKOR or Options.Language == "kr") then goto skipItemName end
	if DaRules then goto skipItemName end
	if Encyclopedia then goto skipItemName end

	-- 신규 설명 데이터
	for modKey, modEntries in pairs(managedTable2) do
		for key, itemDesc in pairs(modEntries) do
			local d = itemDesc._descType
			local n = itemDesc.Name
			local t, v, s, fallback = spliceKey(key)
			local item
			if not (t and v and s) or itemDesc.KeepItemConfig then
			elseif d == "collectible" then
				item = ic:GetCollectible(s)
			elseif d == "trinket" then
				item = ic:GetTrinket(s)
			elseif d == "card" then
				item = ic:GetCard(s)
			elseif d == "pill" then
				item = ic:GetPillEffect(s)
			end

			if item --[[ and itemDesc.Mod ]] then
				if itemDesc.Name and itemDesc.Name ~= "" then
					item.Name = itemDesc.Name or item.Name
				end
				if item.Description and itemDesc.QuoteDesc and itemDesc.QuoteDesc ~= "" then
					item.Description = itemDesc.QuoteDesc or item.Description
				end
			end

		end
	end

	-- 이전 설명 데이터
	for playerType, v in pairs(managedTable.characters) do
		--local item = ic:GetCollectible()
	end

	for itemID, v in pairs(managedTable.collectibles) do
		local item = ic:GetCollectible(itemID)
		if item and v.Mod then
			if v.Name and v.Name ~= "" then
				item.Name = v.Name or item.Name
			end
			if v.queueDesc and v.queueDesc ~= "" then
				item.Description = v.queueDesc or item.Description
			end
		end
	end

	for trinketID, v in pairs(managedTable.trinkets) do
		local item = ic:GetTrinket(trinketID)
		if item and v.targetMod then
			if v.itemName and v.itemName ~= "" then
				item.Name = v.itemName or item.Name
			end
			if v.queueDesc and v.queueDesc ~= "" then
				item.Description = v.queueDesc or item.Description
			end
		end
	end

	for cardID, v in pairs(managedTable.cards) do
		local item = ic:GetCard(cardID)
		if item and v.targetMod then
			if v.itemName and v.itemName ~= "" then
				item.Name = v.itemName or item.Name
			end
			if v.queueDesc and v.queueDesc ~= "" then
				item.Description = v.queueDesc or item.Description
			end
		end
	end

	for pillID, v in pairs(managedTable.pills) do
		local item = ic:GetPillEffect(pillID)
		if item and v.targetMod then
			if v.itemName and v.itemName ~= "" then
				item.Name = v.itemName
			end
			if item.Description and v.queueDesc and v.queueDesc ~= "" then
				item.Description = v.queueDesc
			end
		end
	end

	::skipItemName::
end)

-- 모드에 의한 순정템 설명 직접수정 사항 제거
wakaba_krdesc:AddPriorityCallback(ModCallbacks.MC_POST_GAME_STARTED, CallbackPriority.LATE, function ()
	for i = 1, CollectibleType.NUM_COLLECTIBLES - 1 do
		if EID.descriptions["en_us"].custom["5.100."..i] then
			EID.descriptions["en_us"].custom["5.100."..i] = nil
		end
	end

	for i = 1, TrinketType.NUM_TRINKETS - 1 do
		if EID.descriptions["en_us"].custom["5.350."..i] then
			EID.descriptions["en_us"].custom["5.350."..i] = nil
		end
	end
end)

local _lastPillUsed = -1

---@param pillEffect PillEffect
---@param player EntityPlayer
---@param flags UseFlag
---@param pillColor PillColor
wakaba_krdesc:AddCallback(ModCallbacks.MC_PRE_USE_PILL, function (_, pillEffect, pillColor, player, flags)
	if pillEffect >= PillEffect.NUM_PILL_EFFECTS and flags & UseFlag.USE_NOHUD == 0 then
		_lastPillUsed = pillEffect
		Isaac.CreateTimer(function ()
			_lastPillUsed = -1
		end, 2 , 1, true)
	end
end)

---@param title string
---@param subTitle string
---@param isSticky boolean
---@param isCurseDisplay boolean
wakaba_krdesc:AddCallback(ModCallbacks.MC_PRE_ITEM_TEXT_DISPLAY, function (_, title, subTitle, isSticky, isCurseDisplay)
	if not (REPKOR or Options.Language == "kr") then return end

	-- 신규 설명 데이터
	for modKey, modEntries in pairs(managedTable2) do
		if _lastPillUsed >= PillEffect.NUM_PILL_EFFECTS then
			if modEntries["5.70.".._lastPillUsed] then
				local itemDesc = modEntries["5.70.".._lastPillUsed]
				if itemDesc.Name and itemDesc.Name == title and itemDesc.QuoteDesc and subTitle ~= itemDesc.QuoteDesc then
					Game():GetHUD():ShowItemText(itemDesc.Name, itemDesc.QuoteDesc, false, false)
					return false
				end
			end
		end
	end
end)

-- 모드 표시 수정 대기열
EID._currentMod = "Wakaba_translation_reserved"
