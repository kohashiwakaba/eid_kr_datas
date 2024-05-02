
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
  if EID:getLanguage() == "ko_kr" and (#wakaba_krdesc.ERRORS > 0) then
    local game = Game()
    local str = "{{ColorEIDError}}업데이트되지 않은 모드가 있습니다.#창작마당에서 해당 모드를 업데이트하기 전까지 아래 모드의 설명은 적용되지 않습니다."
    for _, err in ipairs(wakaba_krdesc.ERRORS) do
      str = str
        .. "#{{ColorEIDObjName}}" .. err.err_mod
        .. "#{{Blank}}  필요 버전 : " .. err.required
        .. "#{{Blank}}  현재 버전 : " .. err.current
    end

    if not EID.Config["DisableStartOfRunWarnings"] and game:GetFrameCount() < 10*30 then
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
  collectibles = {},
  trinkets = {},
  cards = {},
  pills = {},
}

local managedTable = comb

if _wakaba then
  managedTable = wakaba.descriptions["ko_kr"]
end

do
  for modEntry, e in pairs(wakaba_krdesc_entries) do
    if e and e.targetMod then
      if e.birthright then
        for p, b in pairs(e.birthright) do
          managedTable.birthright[p] = {
            targetMod = b.targetMod,
            playerName = b.Name,
            description = b.Description,
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

do
	local i_queueLastFrame = {}
	local i_queueNow = {}

  ---@param player EntityPlayer
	wakaba_krdesc:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function (_, player)
		if Options.Language ~= "kr" then return end

		local initSeed = tostring(player.InitSeed)

		i_queueNow[initSeed] = player.QueuedItem.Item
		if (i_queueNow[initSeed] ~= nil and i_queueLastFrame[initSeed] == nil) then
      local q = i_queueNow[initSeed] ---@type ItemConfigItem
      if q:IsCollectible() then
        if q.ID == CollectibleType.COLLECTIBLE_BIRTHRIGHT then
          if managedTable.birthright[player:GetPlayerType()] then
            local entry = managedTable.birthright[player:GetPlayerType()]
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
  wakaba_krdesc:AddCallback(ModCallbacks.MC_USE_PILL, function (_, pillEffectID, playerWhoUsedItem, useFlags)
    if Options.Language ~= "kr" or useFlags & UseFlag.USE_NOHUD == UseFlag.USE_NOHUD then return end
    if managedTable.pills[pillEffectID] then
      Game():GetHUD():ShowItemText(managedTable.pills[pillEffectID].Name, managedTable.pills[pillEffectID].QuoteDesc)
    end
  end)

end

-- Reserve current mod indicator for EID
EID._currentMod = "Wakaba_translation_reserved"

