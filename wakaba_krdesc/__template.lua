
if GODMODE then

	EID._currentMod = "RegisterMod"

	local V_REPLACE = 0
	local V_APPEND = 1

	local Items = GODMODE.registry.items
	local Trinkets = GODMODE.registry.trinkets
	
	local BirthrightDesc = {
		[PLAYERTYPE] = {
			Name = "Isaac",
			Description = "생득권 설명",
			QuoteDesc = "획득멘트",
			Wisps = "",
			Belial = "",
			BingeEater = "",
		},
	}

	local CollectibleDesc = {
		[Items.abrahams_map] = {
			Description = "!!! 2회 사용 가능#사용 시 방 안에 {{Quality4}}등급을 제외한 아이템이 없을 경우 그 방의 아이템을 하나 생성합니다.#사용 시 방 안에 {{Quality4}}등급을 제외한 아이템이 있을 경우 그 방의 아이템을 랜덤 배열의 {{Quality4}}등급 아이템으로 바꿉니다.",
			Name = "아브라함의 지도",
			QuoteDesc = "",
		},
	}

	local TrinketDesc = {
		[Trinkets.bobs_tongue] = {
			Description = "↑ {{TearsSmall}}연사 +0.25#{{Bob}} Bob 변신세트의 아이템 2개 소지 시 랜덤 Bob 아이템 획득과 동시에 장신구가 흡수됩니다.",
			Name = "밥의 혓바닥",
			QuoteDesc = "",
		},
	}

	local CardDesc = {

	}

	local VanillaCollectibles = {
		[CollectibleType.COLLECTIBLE_MORE_OPTIONS] = {
			Type = V_REPLACE,
			Description = "{{TreasureRoom}}보물방에 아이템이 한 쌍 더 추가되며 각 쌍 당 하나를 선택하면 나머지는 사라집니다.",
		},
		[CollectibleType.COLLECTIBLE_BLACK_CANDLE] = {
			Type = V_APPEND,
			Description = "↓ 더 이상 축복을 받을 수 없습니다.",
		},
	}
	
	for playerType, birthrightdesc in pairs(BirthrightDesc) do
		EID:addBirthright(playerType, birthrightdesc.Description, birthrightdesc.Name, "ko_kr")
	end
	for itemID, itemdesc in pairs(CollectibleDesc) do
		local desc = itemdesc.Description
		if itemdesc.StatusEffects then
			for _, eff in ipairs(itemdesc.StatusEffects) do
				desc = desc .. eff
			end
		end
		EID:addCollectible(itemID, desc, itemdesc.Name, "ko_kr")
		if itemdesc.Wisps then
			EID.descriptions["ko_kr"].bookOfVirtuesWisps[itemID] = itemdesc.Wisps
		end
		if itemdesc.BingeEater then
			EID.descriptions["ko_kr"].bingeEaterBuffs[itemID] = itemdesc.BingeEater
		end
		if itemdesc.Belial and itemdesc.Belial ~= "" then
			EID.descriptions["ko_kr"].bookOfBelialBuffs[itemID] = itemdesc.Belial
		end
	end
	for itemID, itemdesc in pairs(TrinketDesc) do
		local desc = itemdesc.Description
		if itemdesc.StatusEffects then
			for _, eff in ipairs(itemdesc.StatusEffects) do
				desc = desc .. eff
			end
		end
		EID:addTrinket(itemID, desc, itemdesc.Name, "ko_kr")
	end
	for itemID, itemdesc in pairs(CardDesc) do
		EID:addCard(itemID, itemdesc.Description, itemdesc.Name, "ko_kr")
	end

	local function FF_EIDKR_VanillaDescCondition(descObj)
		if EID:getLanguage() ~= "ko_kr" then return false end
		return
			descObj.ObjType == 5
			and descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE
			and VanillaCollectibles[descObj.ObjSubType]
	end

	local function FF_EIDKR_VanillaDescCallback(descObj)
		if VanillaCollectibles[descObj.ObjSubType] then
			local type = VanillaCollectibles[descObj.ObjSubType].Type
			if type == V_REPLACE then
				descObj.Description = VanillaCollectibles[descObj.ObjSubType].Description
			else
				EID:appendToDescription(descObj, "#"..VanillaCollectibles[descObj.ObjSubType].Description)
			end
		end
		return descObj
	end

	EID:addDescriptionModifier("FF_EIDKR_GodmodeVanillaDescs", FF_EIDKR_VanillaDescCondition, FF_EIDKR_VanillaDescCallback)

end