
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
			QuoteDesc = "더 높은 지점으로",
		},
		[Mod.Character.WHISKY] = {
			Name = "Alcoholic Catgirl",
			Description = "술에 취했어? 뭐가 일어날까?",
			Detailed = "알콜중독자 고양이입니다.#클리어하지 않은 방 진입 시 랜덤 효과가 발동됩니다.#{{Collectible"..Mod.Item.ONE_LAST_BEER.."}} 고유 능력 : 한 모금 더!",
			Birthright = "2가지의 랜덤 효과가 발동됩니다.#스테이지 진입 시 취한 거지를 소환합니다.",
			QuoteDesc = "음주력 증가",
		},
		--[[ [Mod.Character.LUCKY_CORPE] = {
			Name = "The unfortuned Catgirl",
			Description = "",
			Detailed = "",
			Birthright = "생득권 설명",
			QuoteDesc = "획득멘트",
		}, ]]
		[Mod.Character.RAKU_CHAN] = {
			Name = "Raku-chan",
			Description = "",
			Detailed = "",
			Birthright = "",
			QuoteDesc = "",
		},
		[Mod.Character.TEQUILA] = {
			Name = "Tequila",
			Description = "",
			Detailed = "",
			Birthright = "Resume Story 사용 시 효과 2배",
			QuoteDesc = "독해력 증가",
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
			Description = "{{Timer}} 사용 시 다음 미클리어 방에서 랜덤 효과 발동:#발동한 방 클리어 시 방 보상을 추가로 드랍합니다.#{{BossRoom}} 보스방의 경우 일반 방과 효과가 다르나 {{Chest}} 혹은 {{Collectible}}만 드랍",
			-- Greed : "{{Timer}} 사용 시 다음 웨이브 랜덤 효과 발동:#발동 웨이브 진입 시 동전을 추가로 드랍합니다.#{{BossRoom}} 보스 웨이브의 경우 니켈을 드랍"
			Name = "한 모금 더",
			QuoteDesc = "또 조심 안하지",
		},
		[Mod.Item.A_CUP_OF_WHISKEY] = {
			Description = "↑ {{DamageSmall}}공격력 +1.5#↑ {{TearsSmall}}연사 +0.2#↑ {{ShotspeedSmall}}탄속 +0.1#거지 소환 시 20%의 확률로 취한 거지로 바뀝니다.",
			Name = "위스키 한 컵",
			QuoteDesc = "건배!",
		},
		---- Challenges unlocks ----
		[Mod.Item.HEARTBROKEN] = {
			Description = "↓ {{BrokenHeart}}부서진하트 +2#{{BrokenHeart}} 부서진하트 당 {{TearsSmall}}연사 +0.12#{{BrokenHeart}} 스테이지 진입 시 부서진하트 +1#최소 체력 상한 1칸을 보존합니다.",
			Name = "부서진 하트",
			QuoteDesc = "나의 감정",
		},
		[Mod.Item.BOOK_NOTES] = {
			Description = "액티브 아이템 사용 시 확률적으로 랜덤 책 액티브 아이템을 추가로 발동합니다.#!!! {{ColorOrange}}액티브 게이지 미소진 시 발동 안함#{{Blank}} 추가 발동 확률은 원본 액티브 아이템의 최대 충전량에 비례, 일회용의 경우 100%",
			Name = "도서 노트",
			QuoteDesc = "지식의 바다",
		},
		---- Misc Items ----
		[Mod.Item.SQUIRREL_TAIL] = {
			Description = "!!! 챌린지 전용#{{Timer}} 사용 시 이하 효과 발동:#↑ {{TearsSmall}}연사 배율 +10%p#↑ {{DamageSmall}}공격력 배율 +10%p#↑ {{SpeedSmall}}이동속도 +0.05#{{Timer}} {{ColorRed}}사용 후 5분동안만 생존 가능#!!! {{ColorRed}}재사용 시마다 생존 가능 시간 -30초",
			Name = "다람쥐 꼬리",
			QuoteDesc = "푹신푹신 :3",
		},
		[Mod.Item.RESUME_STORY] = {
			Description = "!!! 챌린지 전용#사용 시 2종류의 랜덤 책 액티브를 발동합니다.",
			Name = "요약본",
			QuoteDesc = "독학",
		},
	}

	local TrinketDesc = {
		[Mod.Trinket.LEAKING_BATTERY] = {
			Description = "{{Battery}} 방 클리어 시 50%의 확률로 충전량을 추가로 충전하거나 차감합니다.",
			Name = "흘러내리는 배터리",
			GoldenMeta = {},
			QuoteDesc = "충전량 증가?",
		},
		[Mod.Trinket.GABYS_ROULLETE] = {
			Description = "15%의 확률로 샷건 눈물이 나갑니다.#샷건 눈물 명중 시 50%의 확률로 캐릭터 공격력 x8의 피해를 주거나 {{ColorOrange}}캐릭터가 반칸의 피해를 받습니다.{{CR}}#7스테이지부터 피해량 2배",
			Name = "가비의 룰렛",
			GoldenMeta = {},
			QuoteDesc = "어어어....",
		},
		[Mod.Trinket.DEBT_PAPERS] = {
			Description = "!!! 소지 중일 때 픽업을 주울 수 없음#픽업 습득 시도 시 해당 픽업이 흡수되며 랜덤 능력치 소량 증가#!!! 50~100개 흡수 시 제거됨",
			Name = "대출 청구서",
			QuoteDesc = "나... 지금 아무것도 없어냥...",
		},
		[Mod.Trinket.TAX_PAPERS] = {
			Description = "!!! 소지 중일 때 아이템을 주울 수 없음#아이템 습득 시도 시 해당 아이템이 소모되며 소모된 아이템 등급에 비례하여 랜덤 능력치 증가",
			Name = "세금 청구서",
			QuoteDesc = "이건 없는 것보다도 못하잖아",
		},
		[Mod.Trinket.DRUNK_RAGE] = {
			Description = "10%의 확률로 소주병 눈물이 나갑니다.#소주로 적 명중 시 반대 방향으로 3방향 눈물이 나갑니다.",
			Name = "분노의 만취",
			GoldenMeta = {},
			QuoteDesc = "깨질듯 한 힘",
		},
		[Mod.Trinket.LOST_TOOTH] = {
			Description = "적 명중 시 확률적으로 그 적에서 랜덤 방향으로 캐릭터의 공격력 x3.2의 이빨이 나갑니다.",
			Name = "잃어버린 치아",
			GoldenMeta = {},
			QuoteDesc = "내꺼 아냐",
		},
	}

	local CardDesc = {
		[Mod.Pickup.APPLE_TO_APPLE.SubType] = {
			Description = "On use can activate one of the next effects:#Turn over: spawn a turn over machine#BIG BOMBS: spawns 1 to 3 Mega bombs#2 for 1: spawn an item for 30 coins#Quick pick: spawn 4 extra temporal pickups for every pickup in the room#Potpourri: active d20 effect",
			Name = "애플 투 애플",
			QuoteDesc = "",
		},
		[Mod.Pickup.SOUL_OF_GABY.SubType] = {
			Description = "소지 중인 픽업 수량을 랜덤으로 재분배합니다.#{{Coin}}/{{Bomb}}/{{Key}}가 모두 0일 때 동전 +1",
			Name = "가비의 영혼",
			QuoteDesc = "주머니를 확인해 봐",
		},
		[Mod.Pickup.SOUL_OF_WHISKY.SubType] = {
			Description = "Give 1 to 10 room effects to the next unclear room",
			Name = "위스키의 영혼",
			QuoteDesc = "잊혀진 술",
		},
		[Mod.Pickup.RULELESS_CARD.SubType] = {
			Description = "",
			Name = "무규칙 카드",
			QuoteDesc = "너만의 규칙",
		},
		[Mod.Pickup.APPLE_JUICE.SubType] = {
			Description = "Give 1 room effects to the next unclear room",
			Name = "애플 주스",
			QuoteDesc = "",
		},
		[Mod.Pickup.ORANGE_JUICE.SubType] = {
			Description = "Give 3 room effects to the next unclear room",
			Name = "오렌지 주스",
			QuoteDesc = "",
		},
		[Mod.Pickup.LEMON_JUICE.SubType] = {
			Description = "Give 6 room effects to the next unclear room",
			Name = "레몬 주스",
			QuoteDesc = "",
		},
		[Mod.Pickup.BLUEBERRY_JUICE.SubType] = {
			Description = "Give 5 to 10 room effects to the next unclear room#{{Heart}} Give a {{SoulHeart}} Soul heart",
			Name = "블루베리 주스",
			QuoteDesc = "",
		},
		[Mod.Pickup.DEATH_SENTENCE.SubType] = {
			Description = "Give 10 room effects to the next unclear room#{{Heart}} Give a {{BlackHeart}} Black heart",
			Name = "사형선고",
			QuoteDesc = "",
		},
		[Mod.Pickup.PAIN_KILLER.SubType] = {
			Description = "Give 8 room effects to the next unclear room and heals 1#{{Heart}} Heals a {{Heart}} Red heart#20% of removing 1 {{BrokenHeart}} Broken heart",
			Name = "페인킬러",
			QuoteDesc = "",
		},
		[Mod.Pickup.HOTDOG.SubType] = {
			Description = "{{Heart}} Heals a {{Heart}} Red heart#20% of giving {{HalfSoulHeart}} half Soul heart",
			Name = "핫도그",
			QuoteDesc = "",
		},
		[Mod.Pickup.HAMBURGER.SubType] = {
			Description = "{{Heart}} Heals 2 {{Heart}} Red heart#20% of giving a {{SoulHeart}} Soul heart",
			Name = "햄버거",
			QuoteDesc = "",
		},
		[Mod.Pickup.MEAT_PIE.SubType] = {
			Description = "{{Heart}} Heals 3 {{Heart}} Red heart#20% of giving 2 {{SoulHeart}} Soul heart",
			Name = "미트파이",
			QuoteDesc = "",
		},
		[Mod.Pickup.CAKE.SubType] = {
			Description = "{{Heart}} Gives a random Heart",
			Name = "케이크",
			QuoteDesc = "",
		},
		[Mod.Pickup.ICE_CREAM.SubType] = {
			Description = "{{Heart}} Gives a {{SoulHeart}} Soul heart#20% of giving another {{SoulHeart}} Soul heart",
			Name = "아이스크림",
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