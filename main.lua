if not EID then return end
local mod = RegisterMod("Korean EID Descriptions for modded items", 1)
wakaba_krdesc = mod

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

wakaba_krdesc.ERRORS = {}
wakaba_krdesc_entries = {}

local skip = false

if REPENTANCE_PLUS then
	wakaba_krdesc.ERRORS.REP_PLUS = true
elseif not (CBEncapsulationFx or REPENTOGON) then
	wakaba_krdesc.ERRORS.NO_REQ = true
	skip = true
end
if not skip then
	wakaba_krdesc_entries.FIENDFOLIO = include("wakaba_krdesc.fiendfolio")
	wakaba_krdesc_entries.RETRIBUTION = include("wakaba_krdesc.retribution")
	wakaba_krdesc_entries.REVEL = include("wakaba_krdesc.revelations")
	wakaba_krdesc_entries.GODMODE = include("wakaba_krdesc.godmode")
	wakaba_krdesc_entries.SAMAEL = include("wakaba_krdesc.samael")
	wakaba_krdesc_entries.DELIVERANCE = include("wakaba_krdesc.deliverance")
	wakaba_krdesc_entries.HEAVENS_CALL = include("wakaba_krdesc.heavens_call")
	wakaba_krdesc_entries.WARPZONE = include("wakaba_krdesc.warpzone")
	wakaba_krdesc_entries.SHERIFF = include("wakaba_krdesc.sheriff")
	wakaba_krdesc_entries.YONDU = include("wakaba_krdesc.yondu")
	wakaba_krdesc_entries.ALICE = include("wakaba_krdesc.alice_ba")
	wakaba_krdesc_entries.CR = include("wakaba_krdesc.community_remix_2024")
	wakaba_krdesc_entries.SACRED_DREAMS = include("wakaba_krdesc.sacred_dreams")
	wakaba_krdesc_entries.TAINTED_TREASURE = include("wakaba_krdesc.tainted_treasure")
	wakaba_krdesc_entries.MATT_PACK = include("wakaba_krdesc.matt_pack")
	wakaba_krdesc_entries.KIRBY = include("wakaba_krdesc.kirby")
	wakaba_krdesc_entries.LOST_AND_FORGOTTEN = include("wakaba_krdesc.lost_and_forgotten")
	--wakaba_krdesc_entries.FOKS_BOOSTER_PACK = include("wakaba_krdesc.foks_booster_pack")
	wakaba_krdesc_entries.AURI = include("wakaba_krdesc.auri")
	wakaba_krdesc_entries.ITEMJAM_1 = include("wakaba_krdesc.itemjam_1")
end

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
--wakaba_krdesc.LIBRARY_EXPANDED = include("wakaba_krdesc.library_expanded")

local hasShownStartWarning = false
local function checkStartOfRunWarnings()
	if EID:getLanguage() == "ko_kr" and (wakaba_krdesc.ERRORS.NO_REQ or #wakaba_krdesc.ERRORS > 0) then
		local game = Game()
		local str = ""
		if wakaba_krdesc.ERRORS.REP_PLUS then
			str = "{{ColorEIDError}}Repentance Plus DLC 적용이 확인되었습니다.#일부 모드 기능 및 아이템이 작동하지 않을 수 있습니다."
		elseif wakaba_krdesc.ERRORS.NO_RGON then
			str = "{{ColorEIDError}}REPENTOGON이 설치되지 않은 상태에서 REPENGOTON 전용 모드가 적용되었습니다.#이하의 모드를 적용 해제하거나 REPENGOTON을 설치하기 전까지 모드 설명이 한글로 표시되지 않습니다."
			for _, err in ipairs(wakaba_krdesc.ERRORS) do
				str = str
						.. "#{{ColorEIDObjName}}" .. err.err_mod
			end
		elseif wakaba_krdesc.ERRORS.NO_REQ then
			str = "{{ColorEIDError}}Mod Error Container 혹은 REPENTOGON이 적용/설치되지 않았습니다.#둘 중 하나 이상을 적용/설치하기 전까지 모드 설명이 한글로 표시되지 않습니다."
		else
			str = "{{ColorEIDError}}업데이트되지 않은 모드가 있습니다.#창작마당에서 해당 모드를 업데이트하기 전까지 아래 모드의 설명은 적용되지 않습니다."
			for _, err in ipairs(wakaba_krdesc.ERRORS) do
				str = str
						.. "#{{ColorEIDObjName}}" .. err.err_mod
						.. "#{{Blank}}	필요 버전 : " .. err.required
						.. "#{{Blank}}	현재 버전 : " .. err.current
			end
		end

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
mod:AddCallback(ModCallbacks.MC_POST_RENDER, checkStartOfRunWarnings)

local comb = {
	birthright = {},
	characters = {},
	collectibles = {},
	trinkets = {},
	cards = {},
	pills = {},
}

local managedTable = comb

if _wakaba then
	managedTable = wakaba.descriptions["ko_kr"]
else
	table.insert(EID.TextReplacementPairs, {">>>", "{{ArrowGrayRight}}"})
	table.insert(EID.TextReplacementPairs, {"↕", "{{ArrowUpDown}}"})
end

do
	for modEntry, e in pairs(wakaba_krdesc_entries) do
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

if REPENTOGON then

	wakaba_krdesc:AddPriorityCallback(ModCallbacks.MC_POST_MODS_LOADED, CallbackPriority.LATE, function ()
		if not (REPKOR or Options.Language == "kr") then goto skipItemName end
		if DaRules then goto skipItemName end
		if Encyclopedia then goto skipItemName end

		local ic = Isaac.GetItemConfig()

		for playerType, v in pairs(managedTable.characters) do
			--local item = ic:GetCollectible()
		end

		for itemID, v in pairs(managedTable.collectibles) do
			local item = ic:GetCollectible(itemID)
			if item and v.targetMod then
				if v.itemName and v.itemName ~= "" then
					item.Name = v.itemName or item.Name
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
else
	local i_queueLastFrame = {}
	local i_queueNow = {}

	---@param player EntityPlayer
	wakaba_krdesc:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
		if not (Options.Language == "kr" or REPKOR) then return end

		local initSeed = tostring(player.InitSeed)

		i_queueNow[initSeed] = player.QueuedItem.Item
		if (i_queueNow[initSeed] ~= nil and i_queueLastFrame[initSeed] == nil) then
			local q = i_queueNow[initSeed] ---@type ItemConfigItem
			if q:IsCollectible() then
				if q.ID == CollectibleType.COLLECTIBLE_BIRTHRIGHT then
					if managedTable.characters[player:GetPlayerType()] then
						local entry = managedTable.characters[player:GetPlayerType()]
						local itemName = "생득권"
						local queueDesc = entry.queueDesc
						if queueDesc then
							Game():GetHUD():ShowItemText(itemName, queueDesc)
						end
					end
				else
					if managedTable.collectibles[q.ID] then
						local entry = managedTable.collectibles[q.ID]
						local itemName = (entry.itemName ~= "" and entry.itemName) or q.Name
						local queueDesc = (entry.queueDesc ~= "" and entry.queueDesc) or q.Description
						Game():GetHUD():ShowItemText(itemName, queueDesc)
					end
				end
			elseif q:IsTrinket() then
				if managedTable.trinkets[q.ID] then
					local entry = managedTable.trinkets[q.ID]
					local itemName = (entry.itemName ~= "" and entry.itemName) or q.Name
					local queueDesc = (entry.queueDesc ~= "" and entry.queueDesc) or q.Description
					Game():GetHUD():ShowItemText(itemName, queueDesc)
				end
			end
		end
		i_queueLastFrame[initSeed] = i_queueNow[initSeed]
	end)
	wakaba_krdesc:AddCallback(ModCallbacks.MC_USE_PILL, function(_, pillEffectID, playerWhoUsedItem, useFlags)
		if not (Options.Language == "kr" or REPKOR) or useFlags & UseFlag.USE_NOHUD == UseFlag.USE_NOHUD then return end
		if managedTable.pills[pillEffectID] then
			Game():GetHUD():ShowItemText(managedTable.pills[pillEffectID].Name, managedTable.pills[pillEffectID].QuoteDesc)
		end
	end)
end

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

-- Reserve current mod indicator for EID
EID._currentMod = "Wakaba_translation_reserved"
