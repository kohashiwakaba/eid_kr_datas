
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
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			QuoteDesc = "TESET",
		},
	}

	local TrinketDesc = {
		[Trinkets.bobs_tongue] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			QuoteDesc = "TESET",
		},
	}

	local CardDesc = {
		[Cards.bobs_tongue] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			QuoteDesc = "TESET",
		},
	}

	local PillDesc = {
		[Pills.bobs_tongue] = {
			Name = "TESET",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			Horse = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
			QuoteDesc = "TESET",
		},
	}

	local entityDesc = {
		["INNERENTRYNAME"] = {
			Type = 0,
			Variant = 0,
			SubType = 0,
			Name = "",
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
		},
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
		if EID:getLanguage() ~= "ko_kr" and EID:getLanguage() ~= "ko" then return false end
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


	return {
		targetMod = "Mod",
		characters = CharacterDesc,
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
		cards = CardDesc,
		pills = PillDesc,
	}

end