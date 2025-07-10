
local synergies = {
	[Retribution.Item.BABYS_BREATH] 	= "축소/변화 새싹의 등장 확률 대폭 증가",
	[Retribution.Item.BLEEDING_HEART]	= "매혹/출혈 새싹의 등장 확률 대폭 증가",
	[Retribution.Item.PUFFSTOOL]		= "혼란/둔화 새싹의 등장 확률 대폭 증가",
	[Retribution.Item.GLORIOSA]			= "화상/공포 새싹의 등장 확률 대폭 증가",
	[Retribution.Item.CORPSE_FLOWER]	= "석화/독성 새싹의 등장 확률 대폭 증가",
}

local trinketSynergies = {
}

local function FF_EIDKR_RTPullRootsCondition(descObj)
  if EID:getLanguage() ~= "ko_kr" and EID:getLanguage() ~= "ko" then return false end
  return descObj.ObjType == 5 and (descObj.ObjVariant == 100 or descObj.ObjVariant == 350) and (
		EID.collectiblesOwned[Retribution.Item.SEED_SACK] or
		EID.collectiblesOwned[Retribution.Item.BAG_OF_SEEDS] or
		Retribution.AnyPlayerHasTrinket(Retribution.Trinket.SEED_PACKET)
  )
end

local function FF_EIDKR_RTPullRootsCallback(descObj)
  local synergy = (descObj.ObjVariant == 350 and trinketSynergies or synergies)[descObj.ObjSubType]

  if synergy ~= nil then
    descObj.Description =  string.gsub(descObj.Description, "(#{{RETPullroot).+", "")
    local icon = "#{{RETPullroot}} "
    EID:appendToDescription(descObj, icon .. synergy:gsub("#", icon))
  end

  return descObj
end

EID:addDescriptionModifier("FF_EIDKR_RTPullRoots", FF_EIDKR_RTPullRootsCondition, FF_EIDKR_RTPullRootsCallback)