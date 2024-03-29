
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

wakaba_krdesc.FIENDFOLIO = include("wakaba_krdesc.fiendfolio")
wakaba_krdesc.RETRIBUTION = include("wakaba_krdesc.retribution")
wakaba_krdesc.REVEL = include("wakaba_krdesc.revelations")
wakaba_krdesc.GODMODE = include("wakaba_krdesc.godmode")
wakaba_krdesc.SAMAEL = include("wakaba_krdesc.samael")
wakaba_krdesc.DELIVERANCE = include("wakaba_krdesc.deliverance")
wakaba_krdesc.HEAVENS_CALL = include("wakaba_krdesc.heavens_call")

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



-- Reserve current mod indicator for EID
EID._currentMod = "Wakaba_translation_reserved"

