
local function shouldModifyBadApple()
	return (
		EID.collectiblesOwned[CollectibleType.COLLECTIBLE_APPLE] or
		EID.collectiblesOwned[Retribution.Item.FORBIDDEN_FRUIT] or
		Retribution.AnyPlayerHasTrinket(TrinketType.TRINKET_APPLE_OF_SODOM)
	)
end

local synergies = {
	[CollectibleType.COLLECTIBLE_APPLE] = "썩은 사과 대신 공격력 x4의 공격이 나갑니다.",
	[Retribution.Item.FORBIDDEN_FRUIT]			= "썩은 사과 대신 공격력 x0.65 +5의 공격이 나갑니다."
}

local synergiesTrinket = {
	[TrinketType.TRINKET_APPLE_OF_SODOM] = "썩은 사과가 자폭 거미를 소환합니다."
}

local function badAppleCallback(descObj)
	if EID.collectiblesOwned[CollectibleType.COLLECTIBLE_APPLE] then
    descObj.Description =  string.gsub(descObj.Description, "(#{{Collectible"..CollectibleType.COLLECTIBLE_APPLE..").+", "")
		EID:appendToDescription(descObj, "#{{Collectible" .. CollectibleType.COLLECTIBLE_APPLE .. "}} " .. synergies[CollectibleType.COLLECTIBLE_APPLE])
	elseif EID.collectiblesOwned[Retribution.Item.FORBIDDEN_FRUIT] then
    descObj.Description =  string.gsub(descObj.Description, "(#{{Collectible"..Retribution.Item.FORBIDDEN_FRUIT..").+", "")
		EID:appendToDescription(descObj, "#{{Collectible" .. Retribution.Item.FORBIDDEN_FRUIT .. "}} " .. synergies[Retribution.Item.FORBIDDEN_FRUIT])
	end

	if Retribution.AnyPlayerHasTrinket(TrinketType.TRINKET_APPLE_OF_SODOM) then
    descObj.Description =  string.gsub(descObj.Description, "(#{{Trinket" .. TrinketType.TRINKET_APPLE_OF_SODOM .. ").+", "")
		EID:appendToDescription(descObj, "#{{Trinket" .. TrinketType.TRINKET_APPLE_OF_SODOM .. "}} " .. synergiesTrinket[TrinketType.TRINKET_APPLE_OF_SODOM])
	end

	return descObj
end

EID:addDescriptionModifier("FF_EIDKR_RTbadAppleSynergyAlt", function(descObj)
  if EID:getLanguage() ~= "ko_kr" and EID:getLanguage() ~= "ko" then return false end
	return descObj.ObjType == 5 and descObj.ObjVariant == 100 and descObj.ObjSubType == Retribution.Item.BAD_APPLE and shouldModifyBadApple()
end, badAppleCallback)

local function otherItemsCallback(descObj)
	local synergy = (descObj.ObjVariant == 350 and synergiesTrinket or synergies)[descObj.ObjSubType]

	if synergy then
    descObj.Description =  string.gsub(descObj.Description, "(#{{Collectible"..Retribution.Item.BAD_APPLE..").+", "")
		local icon = "#{{Collectible" .. Retribution.Item.BAD_APPLE .. "}} "
		EID:appendToDescription(descObj, icon .. synergy:gsub("#", icon))
	end

	return descObj
end

EID:addDescriptionModifier("FF_EIDKR_RTbadAppleSynergy", function(descObj)
  if EID:getLanguage() ~= "ko_kr" and EID:getLanguage() ~= "ko" then return false end
	return descObj.ObjType == 5 and descObj.ObjVariant == 100 and EID.collectiblesOwned[Retribution.Item.BAD_APPLE]
end, otherItemsCallback)

EID:addDescriptionModifier("FF_EIDKR_RTbadAppleSynergyTrinket", function(descObj)
  if EID:getLanguage() ~= "ko_kr" and EID:getLanguage() ~= "ko" then return false end
	return descObj.ObjType == 5 and descObj.ObjVariant == 350 and EID.collectiblesOwned[Retribution.Item.BAD_APPLE]
end, otherItemsCallback)