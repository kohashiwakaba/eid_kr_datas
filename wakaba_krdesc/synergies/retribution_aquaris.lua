
local synergies = {
  [Retribution.Item.BAPTISMAL_SHELL]	= "Aquaris의 장판에도 효과 적용",
  [Retribution.Item.CHOLERA]			= "Aquaris의 장판에도 효과 적용",
  [Retribution.Item.MUSTARD_SEED]	= "Aquaris의 장판에도 씨뿌리기 효과 적용",
  [Retribution.Item.REFLUX]			= "눈물을 떼면 일부 장판이 폭발합니다.(캐릭터는 폭발 피해를 받지 않음)",
  [Retribution.Item.SILVER_FLESH]	= "Aquaris의 장판에도 효과 적용",
  [Retribution.Item.SLICK_SPADE]		= "Aquaris의 장판에도 색상에 따라 효과 적용",
  [Retribution.Item.SOY_BEAN]		= "Aquaris의 장판에도 효과 적용",
  [Retribution.Item.BOOSTER_SHOT]	= "서로 다른 적이 장판을 밟을 때마다 장판의 피해량 증가",
  [Retribution.Item.DEVILS_TOOTH]	= "Aquaris의 장판에도 효과 적용",
  [Retribution.Item.MELATONIN]		= "Aquaris의 장판에도 효과 적용",
  [Retribution.Item.MELITODES]		= "Aquaris의 장판에도 효과 적용",
  [Retribution.Item.GLORIOSA]		= "장판 위에 있는 적에 불길이 휩싸입니다.",
  [Retribution.Item.BLEEDING_HEART]		= "Aquaris의 장판에도 효과 적용",
  [Retribution.Item.CORPSE_FLOWER]		= "Aquaris의 장판에도 효과 적용",
  [Retribution.Item.DEATH_CAP]		= "Aquaris의 장판에도 효과 적용",
  [Retribution.Item.DEATH_CAP_2]		= "Aquaris의 장판에도 효과 적용",
  [Retribution.Item.DEATH_CAP_3]		= "Aquaris의 장판에도 효과 적용",
  [Retribution.Item.DEATH_CAP_4]		= "Aquaris의 장판에도 효과 적용",
  [Retribution.Item.DEATH_CAP_5]		= "Aquaris의 장판에도 효과 적용",
  [Retribution.Item.DEATH_CAP_6]		= "Aquaris의 장판에도 효과 적용",
}

local trinketSynergies = {
  [Retribution.Trinket.THORN_RING]	= "Aquaris의 장판에도 효과 적용",
}

local function FF_EIDKR_RTAquarisCondition(descObj)
  if EID:getLanguage() ~= "ko_kr" and EID:getLanguage() ~= "ko" then return false end
  return descObj.ObjType == 5 and (descObj.ObjVariant == 100 or descObj.ObjVariant == 350) and EID.collectiblesOwned[CollectibleType.COLLECTIBLE_AQUARIUS]
end

local function FF_EIDKR_RTAquarisCallback(descObj)
  local synergy = (descObj.ObjVariant == 350 and trinketSynergies or synergies)[descObj.ObjSubType]

  if synergy ~= nil then
    descObj.Description =  string.gsub(descObj.Description, "(#{{Collectible"..CollectibleType.COLLECTIBLE_AQUARIUS..").+", "")
    local icon = "#{{Collectible" .. CollectibleType.COLLECTIBLE_AQUARIUS .. "}} "
    EID:appendToDescription(descObj, icon .. synergy:gsub("#", icon))
  end

  return descObj
end

EID:addDescriptionModifier("FF_EIDKR_RTAquaris", FF_EIDKR_RTAquarisCondition, FF_EIDKR_RTAquarisCallback)