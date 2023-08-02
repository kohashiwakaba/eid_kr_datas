
if Deliverance then

--[[ 	if not (Deliverance.deliveranceVersion and Deliverance.deliveranceVersion >= "2.5.8.8") then
		table.insert(wakaba_krdesc.ERRORS, {
			err_mod = "Deliverance",
			current = Deliverance.deliveranceVersion,
			required = "2.5.8.8",
		})
		return
	end ]]

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
			QuoteDesc = "보물상자 따기",
		},
		[Items.arterialHeart.id] = {
			Name = "동맥 하트",
			Description = "4방향으로 공격 방향을 살짝 돌아가면서 공격력 3의 눈물을 발사합니다.#캐릭터의 체력이 적을수록 더 빠르게 발사합니다.",
			QuoteDesc = "아직 사랑스럽고 상냥하게",
		},
		[Items.specialDelivery.id] = {
			Name = "특급 배달",
			Description = "사용 시 조준점을 이동시킨 곳으로 60의 피해를 주는 폭탄을 투하합니다.#폭발한 곳에서 랜덤 픽업 혹은 아군 자폭 거미를 드랍합니다.",
			QuoteDesc = "재보급",
		},
		[Items.capBrooch.id] = {
			Name = "캡틴의 브로치",
			Description = "사용 시 랜덤 상자를 소환합니다.",
			QuoteDesc = "상자를 만들자",
		},
		[Items.theApple.id] = {
			Name = "황금사과",
			Description = "!!! 일회용#{{Heart}} 사용 시 체력을 모두 회복합니다.#{{Trinket"..deliveranceContent.trinkets.appleCore.id.."}} 사용 후 Apple Core를 드랍합니다.",
			QuoteDesc = "죄의 맛이 나",
			Belial = "{{BlackHeart}}블랙하트 +2, 모든 최대 체력과 소울하트를 블랙하트로 바꿉니다.#바꾼 {{Heart}} 당 {{DamageSmall}}공격력 +1#바꾼 {{SoulHeart}} 당 {{DamageSmall}}공격력 +0.4",
		},
		[Items.lighter.id] = {
			Name = "라이터",
			Description = "{{Burning}} 사용 시 6초동안 그 방의 적에게 화상을 입힙니다.",
			QuoteDesc = "싹 다 태워버려!",
		},
		[Items.shrinkRay.id] = {
			Name = "작아져라 광선",
			Description = "사용 시 12초동안 그 방의 적을 작아지게 합니다.#작아진 적은 밟아 죽일 수 있습니다.",
			QuoteDesc = "있잖아, 나도 뭔가 과학자같지 않아?",
		},
		[Items.sailorHat.id] = {
			Name = "항해사 모자",
			Description = "↑ {{SpeedSmall}}이동속도 +0.2#적에게 공격 명중 시 25%의 확률로 그 위치에 파란 장판이 생기며 닿은 적은 최대 체력에 비례한 피해를 입습니다.#{{LuckSmall}} :행운 2+일 때 50%",
			QuoteDesc = "부드럽고 젖은",
		},
		[Items.dheart.id] = {
			Name = "",
			Description = "{{UnknownHeart}} 사용 시 그 방의 픽업을 랜덤 하트 픽업으로 바꿉니다.",
			QuoteDesc = "생명을 바꾸다",
			Belial = "바뀐 하트 픽업이 {{BlackHeart}}블랙하트로 나올 확률이 증가합니다.",
		},
		[Items.saltySoup.id] = {
			Name = "소금 항아리",
			Description = "↓ {{SpeedSmall}}이동속도 -0.09#↑ {{TearsSmall}}연사 +0.7#눈물이 살짝 랜덤 방향으로 퍼집니다.",
			QuoteDesc = "이런...",
		},
		[Items.gasoline.id] = {
			Name = "가솔린",
			Description = "적 처치 시 잠시동안 {{Slow}}적을 느려지게 하는 장판과 {{Burning}}적에게 피해를 주는 불을 남깁니다.#장판과 불의 위력은 처치한 적의 최대 체력에 비례합니다.",
			QuoteDesc = "뭔가 타들어가는 냄새가 나",
		},
		[Items.luckySaucer.id] = {
			Name = "행운의 똥 받침대",
			Description = "↑ {{LuckSmall}}행운 +3#!!! 피격 시 그 방에서 {{LuckSmall}}행운 -3",
			QuoteDesc = "내가 맛있는 걸 가져왔어!",
		},
		[Items.bloodyStream.id] = {
			Name = "핏빛 흐름",
			Description = "사용 시 캐릭터의 주위에서 점차 멀어지는 레이저를 여러 발 발사합니다.#레이저는 장애물을 파괴하며 적에게 초당 300의 피해를 줍니다.",
			QuoteDesc = "방을 빨갛게 칠해",
		},
		[Items.theCovenant.id] = {
			Name = "심장 계약",
			Description = "!!! {{UnknownHeart}}모든 하트 픽업이 다른 픽업으로 대체됩니다.#{{DevilRoom}} 악마방 입장 시 {{Heart}}+10/{{SoulHeart}}+1/{{BlackHeart}}+1#{{DevilRoom}}악마방에서 랜덤 픽업 혹은 아이템이 추가로 등장합니다.",
			QuoteDesc = "영원한 죄",
		},
		[Items.adamsRib.id] = {
			Name = "아담의 늑골",
			Description = "적에게 처음으로 공격 명중 시 주변의 적에게 피해를 주고 장애물을 부수는 칼을 떨어뜨립니다.",
			QuoteDesc = "첫 발 어드밴티지지",
		},
		[Items.goodOldFriend.id] = {
			Name = "오랜 나의 친구",
			Description = "↑ 목숨 +1#사망 시 그 방에서 부활합니다.#{{Confusion}}부활 시 그 방의 적에게 60의 혼란 피해를 줍니다.",
			QuoteDesc = "그가 널 기억하고 있어",
		},
		[Items.hotMilk.id] = {
			Name = "뜨거운 우유",
			Description = "↑ {{DamageSmall}}공격력 +0.45#눈물을 발사할 때마다 눈물 공격력이 x0.75~x1.25로 증감합니다.",
			QuoteDesc = "공격력 증가... 감소... 뭐든지",
		},
		[Items.battleRoyale.id] = {
			Name = "배틀로얄",
			Description = "사용 시 일정 시간동안 그 방의 적을 아군으로 복사합니다.#복사된 적은 방을 나가면 사라집니다.",
			QuoteDesc = "내 인생은 구경거리일 뿐이야",
		},
		[Items.sage.id] = {
			Name = "세이지",
			Description = "적을 향해 공격력 5.5의 눈물을 발사합니다.#피격 시 공격력이 소폭 감소하나 한번에 발사하는 눈물이 증가합니다.(최대 4회)#스테이지 진입 시 맞은 횟수가 초기화됩니다.",
			QuoteDesc = "똑똑한 친구",
		},
		[Items.rottenPorkChop.id] = {
			Name = "썩은 돼지고기",
			Description = "공격 시 일정 확률로 공격 반대방향으로 적에게 2의 피해를 주는 방귀를 뀝니다.",
			QuoteDesc = "체력 증가 + 방귀 킬러",
		},
		[Items.lilTummy.id] = {
			Name = "꼬마 터미",
			Description = "6방향으로 공격력 2.5의 눈물을 발사합니다.",
			QuoteDesc = "바아!",
		},
		[Items.scaredyShroom.id] = {
			Name = "겁쟁이 버섯",
			Description = "공격하는 방향으로 공격력 1.5의 눈물을 발사합니다.#!!! 주변에 적이 있을 때 공격하지 않습니다.",
			QuoteDesc = "거기 누구 있어?",
		},
		[Items.drMedicine.id] = {
			Name = "알약 박사",
			Description = "{{Pill}} 알약을 하나 드랍합니다.#{{Pill}} 알약 사용 시 {{HalfHeart}}체력을 반칸 회복합니다.",
			QuoteDesc = "하루 3회, 식후 30분",
		},
		[Items.manuscript.id] = {
			Name = "원고",
			Description = "{{Card}} 카드를 하나 드랍합니다.#{{Card}} 카드/룬 사용 시 {{HalfSoulHeart}}소울하트를 반칸 회복합니다.",
			QuoteDesc = "미신의 힘",
		},
		[Items.roundBattery.id] = {
			Name = "둥근 배터리",
			Description = "적에게 맞을 시 랜덤 방향으로 레이저를 발사합니다.",
			QuoteDesc = "매우 안전하고 효율적이야",
		},
		[Items.airStrike.id] = {
			Name = "공습",
			Description = "사용 시 조준점을 이동시킨 곳을 향해 60의 미사일을 일렬로 5발 발사합니다.",
			QuoteDesc = "온다!",
		},
		[Items.lawful.id] = {
			Name = "법",
			Description = "스테이지 진입 시 랜덤 배열이 선택 됩니다.#아이템 등장 시 선택된 배열의 아이템이 등장합니다.",
			QuoteDesc = "",
		},
		[Items.bileKnight.id] = {
			Name = "화난 기사",
			Description = "공격하는 방향으로 공격력 5.5의 눈물을 발사합니다.#맞으면 공격속도가 증가하나 3회 맞으면 그 스테이지에서 더 이상 눈물을 발사하지 않습니다.",
			QuoteDesc = "약한 친구",
		},
		[Items.dangerRoom.id] = {
			Name = "위험 탐지기",
			Description = "적 탄환 근처에 1초동안 있으면 랜덤 픽업을 드랍합니다.",
			QuoteDesc = "어려움 해쳐나가기",
		},
		[Items.theThreater.id] = {
			Name = "위협하는 자",
			Description = "공격하는 방향으로 공격력 0.6의 레이저를 발사합니다.#보이는 방향의 가장 가까운 적에게 공격력 0.3의 연쇄 레이저를 발사합니다.",
			QuoteDesc = "충격을 주는 친구",
		},
		[Items.beanborne.id] = {
			Name = "빈본",
			Description = "공격하는 방향으로 공격력 2.5의 독방귀를 뀝니다.#방 최초 입장 시 아군 자폭 파리를 하나 소환합니다.",
			QuoteDesc = "진짜 콩 인간!",
		},
		[Items.theDivider.id] = {
			Name = "분할기",
			Description = "사용 시 그 방의 픽업을 최하위 픽업으로 분해합니다.",
			QuoteDesc = "기초로 나누기",
		},
		[Items.sinisterChalk.id] = {
			Name = "불길한 분필",
			Description = "방 입장 시 바닥에 그려진 실루엣이 하나 등장합니다.#실루엣에 1초동안 있으면 해당 모양에 따른 아군 몬스터를 하나 소환합니다.#실루엣 및 소환된 몬스터는 방 클리어 시 사라집니다.",
			QuoteDesc = "그림자 뒤로",
		},
		[Items.momsEarrings.id] = {
			Name = "엄마의 귀걸이",
			Description = "{{DamageSmall}} 그 방의 적 하나 당 공격력 +3.3%p",
			QuoteDesc = "기회를 똑같이",
		},
		[Items.timeGal.id] = {
			Name = "타임 걸",
			Description = "방 입장 시 랜덤 픽업을 들고 있는 유령이 나옵니다.#{{Timer}} 시간 제한 내에 방 클리어 시 유령의 픽업을 획득할 수 있습니다.",
			QuoteDesc = "부지런한 새가 벌레를 잡는다",
		},
		[Items.silverBar.id] = {
			Name = "은색 판",
			Description = "공격하는 동안 0.67초마다 캐릭터의 공격력 x0.33의 레이저를 두릅니다.",
			QuoteDesc = "하이테크가 느껴져",
		},
		[Items.urnOfWant.id] = {
			Name = "소망의 항아리",
			Description = "!!! 방 클리어로 충전 불가, 적 처치로 충전#사용 시 랜덤 카드 혹은 알약의 효과를 발동하며 랜덤 픽업을 드랍합니다.",
			QuoteDesc = "모든 욕망이 채워졌다?",
		},
		[Items.encharmedPenny.id] = {
			Name = "마법 페니",
			Description = "모든 아군 몬스터의 체력을 25% 증가시킵니다.#방 입장 시 랜덤 적 하나를 아군으로 만듭니다.",
			QuoteDesc = "당신이랑 어떤거?",
		},
		[Items.obituary.id] = {
			Name = "사망 소식",
			Description = "{{DamageSmall}} 적 처치 시 빠르게 감소하는 공격력 +200%#{{DamageSmall}} 적 처치 시마다 공격력 +1%p(최대 +50%p)#피격 시 증가한 공격력이 사라집니다.",
			QuoteDesc = "지옥을 즐기라구",
		},
		[Items.shamrockLeaf.id] = {
			Name = "토끼풀잎",
			Description = "{{BossRoom}} 보스방을 피격 없이 클리어 시 추가 보상을 드랍합니다.",
			QuoteDesc = "자아 증가",
		},
		[Items.mysteryBag.id] = {
			Name = "수수께끼의 가방",
			Description = "{{Rune}} 룬을 3개 드랍합니다.",
			QuoteDesc = "희귀한 돌덩이",
		},
		[Items.glassCrown.id] = {
			Name = "유리 왕관",
			Description = "↑ {{DamageSmall}}공격력 +2.55#↑ {{TearsSmall}}연사 +1.05#↑ {{RangeSmall}}사거리 +1.125#↑ {{SpeedSmall}}이동속도 +0.45#↑ {{ShotspeedSmall}}탄속 +0.3#↑ {{LuckSmall}}행운 +3#!!! 피격 시 증가된 능력치의 33%만큼 사라집니다.",
			QuoteDesc = "놓치지 마!",
		},
		[Items.corrosiveBombs.id] = {
			Name = "부식성 폭탄",
			Description = "↑ {{Bomb}}폭탄 +5#폭탄의 폭발이 모든 문을 열 수 있으며 기존 폭탄으로 부술 수 없었던 장애물(강철,열쇠블럭,기둥)을 부술 수 있게 됩니다.",
			QuoteDesc = "녹아내리는 폭탄 +5개",
		},
		[Items.yumRib.id] = {
			Name = "맛있는 뼈",
			Description = "사용 시 {{EmptyBoneHeart}}뼈하트 +1",
			QuoteDesc = "재사용 가능한 칼슘",
			Wisps = "{{ColorOrange}}외부 x1{{CR}}#꺼지면 아군 Bony를 소환합니다.",
			Belial = "아군 Black Bony를 추가로 소환합니다.",
		},
	}

	local TrinketDesc = {
		[Trinkets.uncertainty.id] = {
			Name = "불확실성",
			Description = "{{Collectible406}} 피격 시 {{DamageSmall}}공격력, {{TearsSmall}}연사, {{RangeSmall}}사거리, {{SpeedSmall}}이동속도 배율을 랜덤으로 바꿉니다.#바뀐 배율의 총합은 동일합니다.",
			QuoteDesc = "그거 뭐였어?",
		},
		[Trinkets.appleCore.id] = {
			Name = "사과 씨앗",
			Description = "!!! 일회용#{{Heart}} 피격 시 12.5%의 확률로 빨간하트 +10",
			QuoteDesc = "누군가 이미 먹었어...",
		},
		[Trinkets.krampusHorn.id] = {
			Name = "크람푸스의 뿔",
			Description = "{{DevilChanceSmall}} 피격 시 17%의 확률로 악마방으로 이동합니다.",
			QuoteDesc = "저주받은 느낌",
		},
		[Trinkets.discountBrochure.id] = {
			Name = "할인 브로셔",
			Description = "{{Collectible602}} 스테이지 시작 방에 지하 상점으로 이동합니다.#{{Blank}} ({{Collectible586}}The Stairway 보유 시 천사 상점으로 대체)#!!! 지하 상점 항목의 가격을 50% 할인하나 한 번 나가면 사라집니다.",
			QuoteDesc = "놓치기엔 아까워!",
		},
		[Trinkets.darkLock.id] = {
			Name = "어둠의 자물쇠",
			Description = "{{RedChest}} 빨간상자에서 50% 확률로 다른 픽업이 추가로 드랍되거나 함정이 추가로 등장합니다.",
			QuoteDesc = "빨간 보상",
		},
		[Trinkets.specialPenny.id] = {
			Name = "특별한 페니",
			Description = "모든 상점 주인이 특별한 상점 주인으로 바뀝니다.",
			QuoteDesc = "비밀 부자",
		},
		[Trinkets.littleTransducer.id] = {
			Name = "작은 변환기",
			Description = "빈 방 최초 입장 시 액티브 아이템 게이지를 충전합니다.",
			QuoteDesc = "너그러운 에너지",
		},
		[Trinkets.extinguisher.id] = {
			Name = "소화기",
			Description = "주변의 불을 끕니다.",
			QuoteDesc = "안전제일",
		},
	}

	local CardDesc = {
		[Cards.farewellStone.id] = {
			Name = "이별의 돌",
			Description = "!!! {{Heart}}빨간하트를 모두 제거합니다.#{{SoulHeart}} 제거한 빨간하트 수의 50%만큼 소울하트를 획득합니다.#빨간하트가 없을 경우 {{SoulHeart}}소울하트 +1",
			QuoteDesc = "",
		},
		[Cards.firestorms.id] = {
			Name = "파이어스톰",
			Description = "{{Burning}} 사용 시 그 방의 적에게 화상을 입히며;#{{Collectible257}} 그 방에서 Fire Mind의 효과를 얻습니다.",
			QuoteDesc = "",
		},
		[Cards.glitch.id] = {
			Name = "버그",
			Description = "{{Collectible"..Items.urnOfWant.id.."}} %D@#$FHFXZQ@@*@)",
			QuoteDesc = "",
		},
		[Cards.abyss.id] = {
			Name = "어비스",
			Description = "{{Card}} 사용 시 그 방의 모든 카드/룬을 흡수합니다.#{{Card}} 카드/룬이 없는 방에서 재사용 시 흡수한 모든 카드/룬의 효과를 발동하며 흡수 이력을 초기화합니다.",
			QuoteDesc = "",
		},
	}

	local PillDesc = {
		[Pills.dissReaction.id] = {
			Name = "해리 반응",
			Description = "{{SoulHeart}} 소지 중인 소울하트 절반을 드랍합니다.#소울하트가 없을 경우 소울하트 반칸을 하나 드랍합니다.",
			QuoteDesc = "약한 영혼",
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
		if wakaba and wakaba.intversion and wakaba.intversion >= 10300 then
			wakaba.descriptions["ko_kr"].collectibles[itemID] = {
				targetMod = "Deliverance",
				itemName = itemdesc.Name,
				description = desc,
				queueDesc = itemdesc.QuoteDesc,
			}
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
		if wakaba and wakaba.intversion and wakaba.intversion >= 10300 then
			wakaba.descriptions["ko_kr"].trinkets[itemID] = {
				targetMod = "Deliverance",
				itemName = itemdesc.Name,
				description = desc,
				queueDesc = itemdesc.QuoteDesc,
			}
		end
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


	wakaba_krdesc:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function (_, player)
		if Options.Language ~= "kr" then return end
		local descTable = CollectibleDesc
		local descTableBR = BirthrightDesc
		if not descTable and not descTableBR then return end

		local initSeed = tostring(player.InitSeed)

		i_queueNow[initSeed] = player.QueuedItem.Item
		if (i_queueNow[initSeed] ~= nil) then
			if i_queueNow[initSeed].ID == CollectibleType.COLLECTIBLE_BIRTHRIGHT then
				local playerType = player:GetPlayerType()
				for playerID, itemdesc in pairs(descTableBR) do
					if (playerType == playerID and i_queueNow[initSeed]:IsCollectible() and i_queueLastFrame[initSeed] == nil) then
						local itemName = "생득권"
						local queueDesc = itemdesc.QuoteDesc or i_queueNow[initSeed].Description
						Game():GetHUD():ShowItemText(itemName, queueDesc)
					end
				end
			else
				for itemID, itemdesc in pairs(descTable) do
					if (i_queueNow[initSeed].ID == itemID and i_queueNow[initSeed]:IsCollectible() and i_queueLastFrame[initSeed] == nil) then
						local itemName = (itemdesc.Name ~= "" and itemdesc.Name) or i_queueNow[initSeed].Name
						local queueDesc = itemdesc.QuoteDesc or i_queueNow[initSeed].Description
						Game():GetHUD():ShowItemText(itemName, queueDesc)
					end
				end
			end
		end
		i_queueLastFrame[initSeed] = i_queueNow[initSeed]
	end)


	local t_queueLastFrame = {}
	local t_queueNow = {}
	wakaba_krdesc:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function (_, player)
		if Options.Language ~= "kr" then return end
		local descTable = TrinketDesc
		if not descTable then return end

		local initSeed = tostring(player.InitSeed)

		t_queueNow[initSeed] = player.QueuedItem.Item
		if (t_queueNow[initSeed] ~= nil) then
			for itemID, itemdesc in pairs(descTable) do
				if (t_queueNow[initSeed].ID == itemID and t_queueNow[initSeed]:IsTrinket() and t_queueLastFrame[initSeed] == nil) then
					local itemName = (itemdesc.Name ~= "" and itemdesc.Name) or t_queueNow[initSeed].Name
					local queueDesc = itemdesc.QuoteDesc or t_queueNow[initSeed].Description
					Game():GetHUD():ShowItemText(itemName, queueDesc)
				end
			end
		end
		t_queueLastFrame[initSeed] = t_queueNow[initSeed]
	end)

	return {
		birthright = BirthrightDesc,
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
		cards = CardDesc,
		pills = PillDesc,
	}

end