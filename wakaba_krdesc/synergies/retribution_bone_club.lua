
local synergies = {
	[Retribution.Item.BAPTISMAL_SHELL]	= "휘두르기 및 던지기 공격에 효과 적용",
	[Retribution.Item.CHOLERA]			= "휘두르기 및 던지기 공격에 효과 적용",
	[Retribution.Item.MILK_TEETH]		= "휘두르기 공격 명중 시 5발의 눈물 추가 발사",
	[Retribution.Item.REFLUX]			= "던지기 공격 시 캐릭터가 작게 폭발합니다.(자해 미적용)",
	[Retribution.Item.SILVER_FLESH]		= "휘두르기 및 던지기 공격에 효과 적용",
	[Retribution.Item.SLICK_SPADE]		= "휘두르기 및 던지기 공격에 효과 적용",
	[Retribution.Item.SOY_BEAN]			= "휘두르기 및 던지기 공격에 효과 적용",
	[Retribution.Item.BOOSTER_SHOT]		= "던지기 공격에만 효과 적용",
	[Retribution.Item.TECHNOLOGY_OMICRON] = "던지기 공격에 레이저를 두릅니다.",
	[Retribution.Item.CONJUNCTIVITIS]	= "휘두르기 및 던지기 공격에 효과 적용",
	[Retribution.Item.DEVILS_TOOTH]		= "휘두르기 및 던지기 공격에 효과 적용",
	[Retribution.Item.MELATONIN]		= "휘두르기 및 던지기 공격에 효과 적용",
	[Retribution.Item.MELITODES]		= "휘두르기 및 던지기 공격에 효과 적용",
	[Retribution.Item.COINFLIP]			= "돼지 코인을 밀쳐낼 수 있으며 밀쳐낸 동전이 적에게 큰 피해를 줍니다.",
	[Retribution.Item.BLEEDING_HEART]	= "휘두르기 및 던지기 공격에 매혹 효과 적용",
	[Retribution.Item.GLORIOSA]			= "휘두르기 공격 명중 시 그 방향으로 불길을 소환합니다.#휘두르기 및 던지기 공격에 독 효과 적용",
	[Retribution.Item.CORPSE_FLOWER]	= "휘두르기 및 던지기 공격에 독 효과 적용",

	-- Death Caps
	[Retribution.Item.DEATH_CAP]		= "휘두르기 및 던지기 공격에 독 효과 적용",
	[Retribution.Item.DEATH_CAP_2]		= "휘두르기 및 던지기 공격에 독 효과 적용",
	[Retribution.Item.DEATH_CAP_3]		= "휘두르기 및 던지기 공격에 독 효과 적용",
	[Retribution.Item.DEATH_CAP_4]		= "휘두르기 및 던지기 공격에 독 효과 적용",
	[Retribution.Item.DEATH_CAP_5]		= "휘두르기 및 던지기 공격에 독 효과 적용",
	[Retribution.Item.DEATH_CAP_6]		= "휘두르기 및 던지기 공격에 독 효과 적용",
}

local trinketSynergies = {
}

local function FF_EIDKR_RTCondition(descObj)
  if EID:getLanguage() ~= "ko_kr" then return false end
  return Retribution.GameHasPlayerType(PlayerType.PLAYER_THEFORGOTTEN, PlayerType.PLAYER_THESOUL, PlayerType.PLAYER_SAMSON_B, PlayerType.PLAYER_THEFORGOTTEN_B)
end

local function FF_EIDKR_RTCallback(descObj)
  local synergy = (descObj.ObjVariant == 350 and trinketSynergies or synergies)[descObj.ObjSubType]

  if synergy ~= nil then
    descObj.Description =  string.gsub(descObj.Description, "(#{{Player" .. PlayerType.PLAYER_THEFORGOTTEN .. ").+", "")
    local icon = "#{{Player" .. PlayerType.PLAYER_THEFORGOTTEN .. "}} "
    EID:appendToDescription(descObj, icon .. synergy:gsub("#", icon))
  end

  return descObj
end

EID:addDescriptionModifier("FF_EIDKR_RTBoneClub", FF_EIDKR_RTCondition, FF_EIDKR_RTCallback)