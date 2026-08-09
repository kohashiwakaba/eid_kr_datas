
if _FOKS_BOOSTER_PACK_MOD then

	EID._currentMod = "Foks' Booster Pack"

	local V_REPLACE = 0
	local V_APPEND = 1

	local Items = _FOKS_BOOSTER_PACK_MOD.Collectible
	local Trinkets = _FOKS_BOOSTER_PACK_MOD.Trinket

	local CollectibleDesc = {
		[Items.TOY_SOLDIER] = {
			Description = ""
			.."#{{Shield}} 스테이지 진입 시 피격을 1회 막아주는 특수 보호막을 생성합니다."
			.."#{{Shield}} 체력 거래 시 체력 대신 특수 보호막을 소모합니다."
			.."#!!! {{DevilRoom}}악마방/{{Collectible292}}Satanic Bible 거래 시 여전히 악마 거래로 취급됩니다."
			.."",
			Name = "",
			QuoteDesc = "",
		},
		[Items.EPHEMERAL_TORCH] = {
			Description = ""
			.."#↑ {{LuckSmall}}행운 +10"
			.."#↓ 방 클리어 시 {{LuckSmall}}행운 -1"
			.."#방 입장 시 돌 오브젝트가 5%의 확률로 모닥불로 바뀝니다."
			.."#{{LuckSmall}} 모닥불 피해를 받으면 감소한 행운이 돌아옵니다."
			.."",
			Name = "",
			QuoteDesc = "",
		},
		[Items.CLAY_JAR] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "",
		},
		[Items.BAALS_ALTAR] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "",
		},
		[Items.ASHERAH_POLE] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "",
		},
		[Items.COVENANT] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "",
		},
		[Items.BATTLE_BANNER] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "",
		},
		[Items.DEMISE_OF_THE_FAITHFUL] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "",
		},
		[Items.APPETIZER] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "",
		},
		[Items.HAPPY_FLY] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "",
		},
		[Items.GROCERY_BAG] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "",
		},
		[Items.TOY_SHOVEL] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "",
		},
		[Items.DEL_KEY] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "",
		},
		[Items.CRACKED_MIRROR] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "",
		},
		[Items.BOX_CUTTER] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "",
		},
		[Items.PLASTIC_BRICK] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "",
		},
		[Items.DIRGE_BELL] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "",
		},
		[Items.DEAD_ORANGE] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "",
		},
		[Items.SNARED_FOX] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "",
		},
	}

	local TrinketDesc = {
		[Trinkets.TRUMPET] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "Cast terror into their hearts",
		},
		[Trinkets.WHITE_FLAG] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "I give up",
		},
		[Trinkets.THRESHED_WHEAT] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "Bountiful harvest",
		},
		[Trinkets.LUCKY_BUG] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "Feels lucky?",
		},
		[Trinkets.MOMS_TELEPHONE] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "You know the number",
		},
		[Trinkets.CAUTION_SIGN] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "Stay away",
		},
		[Trinkets.RUNE_STONE] = {
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."",
			Name = "",
			QuoteDesc = "Seek the truth",
		},
	}

	local CardDesc = {

	}

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

	return {
		targetMod = "Mod",
		characters = CharacterDesc,
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
		cards = CardDesc,
		pills = PillDesc,
	}

end