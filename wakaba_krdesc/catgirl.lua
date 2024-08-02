
if cat_mod then
	local versionRequ = 3.141

	if not (cat_mod.Version and cat_mod.Version >= versionRequ) then
		table.insert(wakaba_krdesc.ERRORS, {
			err_mod = "Catgirl With Gambling Addiction",
			current = cat_mod.Version,
			required = versionRequ,
		})
		return
	end

	EID._currentMod = "Catgirl With Gambling Addiction"

	local Mod = cat_mod

	local V_REPLACE = 0
	local V_APPEND = 1

	local Items = Mod.Item
	local Trinkets = Mod.Trinket
	local Cards = Mod.Pickup
	
	local CharacterDesc = {
		[Mod.Character.GABY] = {
			Name = "Catgirl W. G. A.",
			Description = "냥이의 운을 시험해 보세요!",
			Detailed = "도박중독자 고양이입니다.#냥이와 함께 여러분의 운세를 시험해 보세요.#{{Collectible"..Mod.Item.TRY_MY_LUCK.."}} 고유 능력 : 나의 운을 시험해보자",
			Birthright = "스테이지 진입 시 50%의 확률로 랜덤 긍정효과 혹은 부정효과가 발동됩니다.",
			QuoteDesc = "획득멘트",
		},
		[Mod.Character.WHISKY] = {
			Name = "Alcoholic Catgirl",
			Description = "술에 취했어? 뭐가 일어날까?",
			Detailed = "알콜중독자 고양이입니다.#클리어하지 않은 방 진입 시 랜덤 효과가 발동됩니다.#{{Collectible"..Mod.Item.ONE_LAST_BEER.."}} 고유 능력 : 한 모금 더!",
			Birthright = "2가지의 랜덤 효과가 발동됩니다.#스테이지 진입 시 취한 거지를 소환합니다.",
			QuoteDesc = "획득멘트",
		},
		--[[ [Mod.Character.LUCKY_CORPE] = {
			Name = "The unfortuned Catgirl",
			Description = "",
			Detailed = "",
			Birthright = "생득권 설명",
			QuoteDesc = "획득멘트",
		},
		[Mod.Character.RAKU_CHAN] = {
			Name = "Raku-chan",
			Description = "",
			Detailed = "",
			Birthright = "생득권 설명",
			QuoteDesc = "획득멘트",
		}, ]]
		[Mod.Character.TEQUILA] = {
			Name = "Tequila",
			Description = "",
			Detailed = "",
			Birthright = "Activates the effects of four books",
			QuoteDesc = "획득멘트",
		},
	}

	local CollectibleDesc = {
		---- Gaby unlocks ----
		[Mod.Item.TRY_MY_LUCK] = {
			Description = "!!! 완충 시 아래 중 하나 발동:#{{Key}} 랜덤 픽업 소환 or 소지 중인 픽업 감소#{{Heart}} 체력 회복 or 1칸 피해#랜덤 능력치 하나 증가 or 감소#랜덤 아이템 소환 or 소지 중인 아이템 제거",
			Name = "나의 운을 시험해보자",
			QuoteDesc = "몇번이든지 다시 해보자",
		},
		[Mod.Item.D_BROKEN] = {
			Description = "사용 시 50%의 확률로 그 방의 아이템 하나를 더 높은 등급의 아이템으로 바꾸거나 더 낮은 아이템으로 바꿉니다.",
			Name = "망가진 주사위",
			QuoteDesc = "더 나아진 운명?",
		},
		[Mod.Item.FORTUNE_CHIPS] = {
			Description = "{{Slotmachine}} 방 클리어 시 20%의 확률로 도박기계를 생성합니다.#스테이지 진입 시 랜덤 거지를 소환합니다.",
			Name = "운세 칩",
			QuoteDesc = "너의 운을 퍼트려라",
		},
		[Mod.Item.MUTANT_HEART] = {
			Description = "{{Heart}} 하트 픽업 획득 시 추가 랜덤 하트 +1",
			Name = "변이된 심장",
			QuoteDesc = "항상 변화해",
		},
		---- Whisky unlocks ----
		[Mod.Item.ONE_LAST_BEER] = {
			Description = "On use:#Give a special effect to the next unclear room#The room with this effect will spawn a extra drop on clear#The drop can be:#A pickup#A chest#Using multiple times makes more problable of a better drop#Boss room have their own effects and only chests and collectibles can drop",
			-- Greed : "On use:#Give a special effect to the next wave#The wave with this effect will spawn a extra coin#Using multiple times makes more problable of droping#Boss wave drop a nickel"
			Name = "한 모금 더",
			QuoteDesc = "",
		},
		[Mod.Item.A_CUP_OF_WHISKEY] = {
			Description = "↑ + 1.5 Damage#↑ + 0.2 Tears#↑ + 0.1 ShotSpeed#Beggars have a 20% of being repleace with a Drunk Beggar",
			Name = "위스키 한 컵",
			QuoteDesc = "",
		},
		---- Challenges unlocks ----
		[Mod.Item.HEARTBROKEN] = {
			Description = "↑ + 0.12 Tears for every {{BrokenHeart}} the player have#{{Heart}} On pickup gives 2 {{BrokenHeart}}#On a new floor adds a {{BrokenHeart}}#All ways keeps 1 {{Heart}}",
			Name = "",
			QuoteDesc = "",
		},
		[Mod.Item.BOOK_NOTES] = {
			Description = "Using an active item has a chance of activate a book effect#This chance scales with the active charge#Single us items has 100% of activate a book effect",
			Name = "",
			QuoteDesc = "",
		},
		---- Misc Items ----
		[Mod.Item.SQUIRREL_TAIL] = {
			Description = "↑ + 10% Tears#↑ + 10% Damage#↑ + 0.05 Movement speed#{{Timer}} Adds a timer that kills you in 5 minutes#{{Timer}} More uses will remove 30 seconds of this timer",
			Name = "",
			QuoteDesc = "",
		},
		[Mod.Item.RESUME_STORY] = {
			Description = "On use activates the effects of two books",
			Name = "",
			QuoteDesc = "",
		},
	}

	local TrinketDesc = {
		[Mod.Trinket.LEAKING_BATTERY] = {
			Description = "When clearing a room has a 50/50 of given a extra charge or remove a charge",
			Name = "",
			GoldenMeta = {},
			QuoteDesc = "",
		},
		[Mod.Trinket.GABYS_ROULLETE] = {
			Description = "The player has a 15% of shoting a Shotgun tear#On hit has 50/50 of doing 6x player damage or damaging the player#After Mom's foot it's doubles the damage",
			Name = "",
			GoldenMeta = {},
			QuoteDesc = "",
		},
		[Mod.Trinket.DEBT_PAPERS] = {
			Description = "Will the player has this trinket can't gain pickups#Picking a pickup will give a small stat up#Is remove automatically when picking 50 to 100 pickups",
			Name = "",
			QuoteDesc = "",
		},
		[Mod.Trinket.TAX_PAPERS] = {
			Description = "When picking a item the player lost it#It give a random stat up#The amount of stats up depends of the item quality",
			Name = "",
			QuoteDesc = "",
		},
		[Mod.Trinket.DRUNK_RAGE] = {
			Description = "The player has a 10% of shoting a Bottle#Hitting an enemy it will 3 tears to the oposite direction#Scale with how many room effects are",
			Name = "",
			GoldenMeta = {},
			QuoteDesc = "",
		},
		[Mod.Trinket.LOST_TOOTH] = {
			Description = "Hitting an enemy has a chance of shoting a Tooth to a random direction#This tooth will do x3.2 the player damage#Scale with the player damage",
			Name = "",
			GoldenMeta = {},
			QuoteDesc = "",
		},
	}

	local CardDesc = {
		[Mod.Pickup.APPLE_TO_APPLE.SubType] = {
			Description = "On use can activate one of the next effects:#Turn over: spawn a turn over machine#BIG BOMBS: spawns 1 to 3 Mega bombs#2 for 1: spawn an item for 30 coins#Quick pick: spawn 4 extra temporal pickups for every pickup in the room#Potpourri: active d20 effect",
			Name = "",
			QuoteDesc = "",
		},
		[Mod.Pickup.SOUL_OF_GABY.SubType] = {
			Description = "Rerolls the player pickups#If the player doesn't have any pickup give a coin",
			Name = "",
			QuoteDesc = "",
		},
		[Mod.Pickup.SOUL_OF_WHISKY.SubType] = {
			Description = "Give 1 to 10 room effects to the next unclear room",
			Name = "",
			QuoteDesc = "",
		},
		[Mod.Pickup.RULELESS_CARD.SubType] = {
			Description = "",
			Name = "",
			QuoteDesc = "",
		},
		[Mod.Pickup.APPLE_JUICE.SubType] = {
			Description = "Give 1 room effects to the next unclear room",
			Name = "",
			QuoteDesc = "",
		},
		[Mod.Pickup.ORANGE_JUICE.SubType] = {
			Description = "Give 3 room effects to the next unclear room",
			Name = "",
			QuoteDesc = "",
		},
		[Mod.Pickup.LEMON_JUICE.SubType] = {
			Description = "Give 6 room effects to the next unclear room",
			Name = "",
			QuoteDesc = "",
		},
		[Mod.Pickup.BLUEBERRY_JUICE.SubType] = {
			Description = "Give 5 to 10 room effects to the next unclear room#{{Heart}} Give a {{SoulHeart}} Soul heart",
			Name = "",
			QuoteDesc = "",
		},
		[Mod.Pickup.DEATH_SENTENCE.SubType] = {
			Description = "Give 10 room effects to the next unclear room#{{Heart}} Give a {{BlackHeart}} Black heart",
			Name = "",
			QuoteDesc = "",
		},
		[Mod.Pickup.PAIN_KILLER.SubType] = {
			Description = "Give 8 room effects to the next unclear room and heals 1#{{Heart}} Heals a {{Heart}} Red heart#20% of removing 1 {{BrokenHeart}} Broken heart",
			Name = "",
			QuoteDesc = "",
		},
		[Mod.Pickup.HOTDOG.SubType] = {
			Description = "{{Heart}} Heals a {{Heart}} Red heart#20% of giving {{HalfSoulHeart}} half Soul heart",
			Name = "",
			QuoteDesc = "",
		},
		[Mod.Pickup.HAMBURGER.SubType] = {
			Description = "{{Heart}} Heals 2 {{Heart}} Red heart#20% of giving a {{SoulHeart}} Soul heart",
			Name = "",
			QuoteDesc = "",
		},
		[Mod.Pickup.MEAT_PIE.SubType] = {
			Description = "{{Heart}} Heals 3 {{Heart}} Red heart#20% of giving 2 {{SoulHeart}} Soul heart",
			Name = "",
			QuoteDesc = "",
		},
		[Mod.Pickup.CAKE.SubType] = {
			Description = "{{Heart}} Gives a random Heart",
			Name = "",
			QuoteDesc = "",
		},
		[Mod.Pickup.ICE_CREAM.SubType] = {
			Description = "{{Heart}} Gives a {{SoulHeart}} Soul heart#20% of giving another {{SoulHeart}} Soul heart",
			Name = "",
			QuoteDesc = "",
		},
	}

	EID:addEntity(6, Mod.Slot.SLOT_DRUNK_BEGGAR, 0, "취한 거지", "Interacting with the beggar can happen 1 of 3#Drink a beer#Add a extra effect for each room for the rest of the floor#취한거지 배열 아이템 하나 소환", "ko_kr")

	for playerType, birthrightdesc in pairs(CharacterDesc) do
		EID:addCharacterInfo(playerType, birthrightdesc.Description, birthrightdesc.Name, "ko_kr")
		if InventoryDescriptions then
			EID:addEntity(wakaba.INVDESC_TYPE_PLAYER, wakaba.INVDESC_VARIANT, playerType, birthrightdesc.Name, birthrightdesc.Detailed, "ko_kr")
		end
		EID:addBirthright(playerType, birthrightdesc.Birthright, birthrightdesc.Name, "ko_kr")
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

	return {
		targetMod = "Catgirl With Gambling Addiction",
		birthright = CharacterDesc,
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
		cards = CardDesc,
	}
	
end