
if Deliverance then
	--[[ 
		TODO for report:
		- Captain's Brooch spawns Shop Chest, which is graphically glitched
		- Lucky Saucer reduces -3 Luck(= drops poop) even with non-penalty damage unlike Paschal candle

	 ]]

	EID._currentMod = "Deliverance"

	local V_REPLACE = 0
	local V_APPEND = 1

	local Players = deliveranceContent.characters
	local Items = deliveranceContent.items
	local Trinkets = deliveranceContent.trinkets
	local Cards = deliveranceContent.cards
	local Pills = deliveranceContent.pills
	
	local BirthrightDesc = {
		[Players.awan.playerAwan] = {
			Name = "Isaac",
			Description = "생득권 설명",
			QuoteDesc = "획득멘트",
		},
	}

	local CollectibleDesc = {
		[Items.cainsKey.id] = {
			Name = "카인의 잃어버린 열쇠",
			Description = "사용 시 그 방의 모든 상자를 엽니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.arterialHeart.id] = {
			Name = "Arterial Heart",
			Description = "Shoots tears in different directions#Increases firerate when you are low on health",
			QuoteDesc = "획득멘트",
		},
		[Items.specialDelivery.id] = {
			Name = "특급 배달",
			Description = "사용 시 조준점을 이동시킨 곳으로 60의 피해를 주는 폭탄을 투하합니다.#폭발한 곳에서 랜덤 픽업 혹은 아군 자폭 거미를 드랍합니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.capBrooch.id] = {
			Name = "캡틴의 브로치",
			Description = "사용 시 랜덤 상자를 소환합니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.theApple.id] = {
			Name = "황금사과",
			Description = "!!! 일회용# {{Heart}}사용 시 체력을 모두 회복합니다.#{{Trinket"..deliveranceContent.trinkets.appleCore.id.."}}사용 후 Apple Core를 드랍합니다.",
			QuoteDesc = "획득멘트",
			Belial = "↑ {{BlackHeart}}블랙하트 +2, 모든 최대 체력과 소울하트를 블랙하트로 바꿉니다.#↑ 바꾼 {{Heart}} 당 {{DamageSmall}}공격력 +1#↑ 바꾼 {{SoulHeart}} 당 {{DamageSmall}}공격력 +0.4",
		},
		[Items.lighter.id] = {
			Name = "라이터",
			Description = "{{Burn}} 사용 시 6초동안 그 방의 적에게 화상을 입힙니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.shrinkRay.id] = {
			Name = "작아져라 광선",
			Description = "사용 시 12초동안 그 방의 적을 작아지게 합니다.#작아진 적은 밟아 죽일 수 있습니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.sailorHat.id] = {
			Name = "항해사 모자",
			Description = "↑ {{SpeedSmall}}이동속도 +0.2#적에게 공격 명중 시 25%의 확률로 그 위치에 파란 장판이 생기며 닿은 적은 최대 체력에 비례한 피해를 입습니다.#{{LuckSmall}} :행운 2+일 때 50%",
			QuoteDesc = "획득멘트",
		},
		[Items.dheart.id] = {
			Name = "",
			Description = "{{UnknownHeart}} 사용 시 그 방의 픽업을 랜덤 하트 픽업으로 바꿉니다.",
			QuoteDesc = "획득멘트",
			Belial = "바뀐 하트 픽업이 {{BlackHeart}}블랙하트로 나올 확률이 증가합니다.",
		},
		[Items.saltySoup.id] = {
			Name = "소금 항아리",
			Description = "↓ {{SpeedSmall}}이동속도 -0.09#↑ {{TearsSmall}}연사 +0.7#눈물이 살짝 랜덤 방향으로 퍼집니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.gasoline.id] = {
			Name = "가솔린",
			Description = "적 처치 시 잠시동안 {{Slow}}적을 느려지게 하는 장판과 {{Burn}}적에게 피해를 주는 불을 남깁니다.#장판과 불의 위력은 처치한 적의 최대 체력에 비례합니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.luckySaucer.id] = {
			Name = "행운의 똥 받침대",
			Description = "↑ {{LuckSmall}}행운 +3#!!! 피격 시 그 방에서 {{LuckSmall}}행운 -3",
			QuoteDesc = "획득멘트",
		},
		[Items.bloodyStream.id] = {
			Name = "핏빛 흐름",
			Description = "사용 시 캐릭터의 주위에서 점차 멀어지는 레이저를 여러 발 발사합니다.#레이저는 장애물을 파괴하며 적에게 초당 300의 피해를 줍니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.theCovenant.id] = {
			Name = "심장 계약",
			Description = "!!! {{UnknownHeart}}모든 하트 픽업이 다른 픽업으로 대체됩니다.#{{DevilRoom}} 악마방 입장 시 {{Heart}}+10/{{SoulHeart}}+1/{{BlackHeart}}+1#{{DevilRoom}}악마방에서 랜덤 픽업 혹은 아이템이 추가로 등장합니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.adamsRib.id] = {
			Name = "아담의 늑골",
			Description = "적에게 처음으로 공격 명중 시 주변의 적에게 피해를 주고 장애물을 부수는 칼을 떨어뜨립니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.goodOldFriend.id] = {
			Name = "오랜 나의 친구",
			Description = "↑ 목숨 +1#사망 시 그 방에서 부활합니다.#{{Confusion}}부활 시 그 방의 적에게 60의 혼란 피해를 줍니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.hotMilk.id] = {
			Name = "뜨거운 우유",
			Description = "↑ {{DamageSmall}}공격력 +0.45#눈물을 발사할 때마다 눈물 공격력이 x0.75~x1.25로 증감합니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.battleRoyale.id] = {
			Name = "배틀로얄",
			Description = "사용 시 일정 시간동안 그 방의 적을 아군으로 복사합니다.#복사된 적은 방을 나가면 사라집니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.sage.id] = {
			Name = "세이지",
			Description = "적을 향해 공격력 5.5의 눈물을 발사합니다.#피격 시 공격력이 소폭 감소하나 한번에 발사하는 눈물이 증가합니다.(최대 4회)#스테이지 진입 시 맞은 횟수가 초기화됩니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.rottenPorkChop.id] = {
			Name = "썩은 돼지고기",
			Description = "공격 시 일정 확률로 공격 반대방향으로 적에게 2의 피해를 주는 방귀를 뀝니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.lilTummy.id] = {
			Name = "꼬마 터미",
			Description = "6방향으로 공격력 2.5의 눈물을 발사합니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.scaredyShroom.id] = {
			Name = "겁쟁이 버섯",
			Description = "공격하는 방향으로 공격력 1.5의 눈물을 발사합니다.#!!! 주변에 적이 있을 때 공격하지 않습니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.drMedicine.id] = {
			Name = "알약 박사",
			Description = "{{Pill}} 알약을 하나 드랍합니다.#{{Pill}} 알약 사용 시 {{HalfHeart}}체력을 반칸 회복합니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.manuscript.id] = {
			Name = "원고",
			Description = "{{Card}} 카드를 하나 드랍합니다.#{{Card}} 카드/룬 사용 시 {{HalfSoulHeart}}소울하트를 반칸 회복합니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.roundBattery.id] = {
			Name = "둥근 배터리",
			Description = "적에게 맞을 시 랜덤 방향으로 레이저를 발사합니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.airStrike.id] = {
			Name = "공습",
			Description = "사용 시 조준점을 이동시킨 곳을 향해 60의 미사일을 일렬로 5발 발사합니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.lawful.id] = {
			Name = "법",
			Description = "스테이지 진입 시 랜덤 배열이 선택 됩니다.#아이템 등장 시 선택된 배열의 아이템이 등장합니다.",
			QuoteDesc = "획득멘트",
		},
		[Items.bileKnight.id] = {
			Name = "Bile Knight",
			Description = "Rapidly shoots tears at enemies, fire rate increases the more it is hurt#Deactivates for the rest of the floor if it is hurt 3 times",
			QuoteDesc = "획득멘트",
		},
		[Items.dangerRoom.id] = {
			Name = "Danger Room",
			Description = "Tracks nearby enemy projectiles, filling the scale of danger#After filling the scale gives a random pickup item",
			QuoteDesc = "획득멘트",
		},
		[Items.theThreater.id] = {
			Name = "The Threater",
			Description = "Strikes groups of enemies with lightning#Lightning arcs between enemies",
			QuoteDesc = "획득멘트",
		},
		[Items.beanborne.id] = {
			Name = "Beanborne",
			Description = "Farts, poisoning enemies#Spawns a blue fly in every room you visit for the first time",
			QuoteDesc = "획득멘트",
		},
		[Items.theDivider.id] = {
			Name = "The Divider",
			Description = "Brings pickups lying on floor to their simplest form - #Nickel turns into five coins, hearts - into two halves, etc",
			QuoteDesc = "획득멘트",
		},
		[Items.sinisterChalk.id] = {
			Name = "Sinister Chalk",
			Description = "Draws silhouettes on the floor in every room#Stand on the silhouette to summon a shadow#Type of shadow depends on the floor you are on#When room is cleared, the silhouette disappears",
			QuoteDesc = "획득멘트",
		},
		[Items.momsEarrings.id] = {
			Name = "Mom's Earrings",
			Description = "Increases your damage proportionally to the number of enemies in the room",
			QuoteDesc = "획득멘트",
		},
		[Items.timeGal.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
		[Items.silverBar.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
		[Items.urnOfWant.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
		[Items.encharmedPenny.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
		[Items.obituary.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
		[Items.shamrockLeaf.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
		[Items.mysteryBag.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
		[Items.glassCrown.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
		[Items.corrosiveBombs.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
		[Items.yumRib.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
	}

	local TrinketDesc = {
		[Trinkets.uncertainty.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
		[Trinkets.appleCore.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
		[Trinkets.krampusHorn.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
		[Trinkets.discountBrochure.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
		[Trinkets.darkLock.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
		[Trinkets.specialPenny.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
		[Trinkets.littleTransducer.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
		[Trinkets.extinguisher.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
	}

	local CardDesc = {
		[Cards.farewellStone.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
		[Cards.firestorms.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
		[Cards.glitch.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
		[Cards.abyss.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
		},
	}

	local PillDesc = {
		[Pills.dissReaction.id] = {
			Name = "아이템이름",
			Description = "아이템설명",
			QuoteDesc = "획득멘트",
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
	for itemID, itemdesc in pairs(PillDesc) do
		EID:addPill(itemID, itemdesc.Description, itemdesc.Name, "ko_kr")
	end
	wakaba_krdesc:AddCallback(ModCallbacks.MC_USE_PILL, function (_, pillEffectID, playerWhoUsedItem, useFlags)
		if Options.Language ~= "kr" or useFlags & UseFlag.USE_NOHUD == UseFlag.USE_NOHUD then return end
		if PillDesc[pillEffectID] then
			Game():GetHUD():ShowItemText(PillDesc[pillEffectID].Name, PillDesc[pillEffectID].QuoteDesc)
		end
	end)

end