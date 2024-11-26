
if WarpZone then

	EID._currentMod = "WarpZone"

	local V_REPLACE = 0
	local V_APPEND = 1

	local Items = WarpZone.WarpZoneTypes
	local Trinkets = WarpZone.WarpZoneTypes
	local Cards = WarpZone.WarpZoneTypes

	local CollectibleDesc = {
		[Items.COLLECTIBLE_GOLDENIDOL] = {
			Name = "",
			Description = "#↑ 방 클리어 시 50%의 확률로 사라지는 니켈을 추가로 소환합니다.#↓ 피격 시 캐릭터의 {{Coin}}을 50%만큼 잃으며 일부를 떨굽니다.#↓ {{Coin}}이 1개 이상일 때 캐릭터가 최소 1칸 이상의 피해를 받습니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_PASTKILLER] = {
			Name = "",
			Description = "!!! 3회 남음#{{Collectible}} 가장 먼저 획득한 패시브 아이템을 제거하며({{ColorRed}}루트 진행 아이템 포함{{CR}}) 제거한 아이템과 같은 배열의 선택형 아이템을 3개 소환합니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_PASTKILLER_2x] = {
			Name = "",
			Description = "!!! 2회 남음#{{Collectible}} 가장 먼저 획득한 패시브 아이템을 제거하며({{ColorRed}}루트 진행 아이템 포함{{CR}}) 제거한 아이템과 같은 배열의 선택형 아이템을 3개 소환합니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_PASTKILLER_1x] = {
			Name = "",
			Description = "!!! 1회 남음#{{Collectible}} 가장 먼저 획득한 패시브 아이템을 제거하며({{ColorRed}}루트 진행 아이템 포함{{CR}}) 제거한 아이템과 같은 배열의 선택형 아이템을 3개 소환합니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_BIRTHDAY_CAKE] = {
			Name = "",
			Description = "↑ {{Heart}}최대 체력 +1#↑ {{Heart}}빨간하트 +1#스테이지 진입 시 랜덤 픽업을 여러 개 소환합니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_RUSTY_SPOON] = {
			Name = "",
			Description = "#{{BleedingOut}} 공격 시 10%의 확률로 적을 출혈시키는 유도 공격이 나갑니다.#{{LuckSmall}} 행운 18+일 때 100%",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_NEWGROUNDS_TANK] = {
			Name = "",
			Description = "↓ {{SpeedSmall}}이동속도 -0.3#↑ {{TearsSmall}}연사 +0.27#↑ {{DamageSmall}}공격력 +0.5#↑ {{RangeSmall}}사거리 +1#↑ {{ShotspeedSmall}}탄속 +0.16#↑ {{LuckSmall}}행운 +1#10%의 확률로 피격을 막아줍니다.#!!! 적을 놓친 눈물이 폭발합니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_GREED_BUTT] = {
			Name = "",
			Description = "#{{Coin}} 적 및 탄환과 접촉 시 캐릭터의 뒤에서 동전 방귀가 나가며;#{{PoopPickup}} 5%의 확률로 황금똥을 대신 쌉니다.#!!! {{Coin}}동전 5개 획득 시 재발동 가능",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_FOCUS] = {
			Name = "",
			Description = "#{{Heart}} 사용 키를 누르고 있으면 충전량이 줄어들며 충전량이 50% 줄어들면 현재 체력 상태에 따라 체력을 반칸 회복합니다.#!!! 순서 : {{HalfHeart}} > {{HalfSoulHeart}} > {{HolyMantleSmall}}",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_DOORWAY] = {
			Name = "",
			Description = "!!! 일회용;사용 시 그 스테이지에서;#{{Room}} 모든 문이 항상 열린 상태로 유지시킵니다.#(비밀방, 악마/천사방, Mega Satan, 보스러시, Hush 포함)#!!! ({{ChallengeRoom}}도전방의 경우 전투 시작 시 닫힘)#{{UltraSecretRoom}} 특급 비밀방 및 가장 가까운 에러방으로 향하는 빨간 문을 모두 엽니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_STRANGE_MARBLE] = {
			Name = "",
			Description = "#!!! {{MiniBoss}}모든 적이 12.5%의 확률로 챔피언 몬스터로 바뀝니다.#↑ 챔피언 몬스터 처치 시 보상을 추가로 드랍합니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_IS_YOU] = { -- player:GetData().baba_active
			Name = "",
			Description = "사용 시 조준점으로 목표를 설정하며 재사용 시 특정 목표에 따른 액티브 아이템 효과를 발동합니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_NIGHTMARE_TICK] = {
			Name = "",
			Description = "↓ 방 8개 클리어할 때마다 랜덤 패시브 아이템을 하나 제거하며 {{DamageSmall}}공격력 +0.75",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_SPELUNKERS_PACK] = {
			Name = "",
			Description = "#↑ {{Bomb}}폭탄 +12#{{Bomb}} 폭탄을 던질 수 있습니다.",
			QuoteDesc = "",
			_Extra = "#(Effect below is the second effect that can be turned on in configuration)#Pits within your bombs' blast radius are filled in#When your bomb explodes, the resonant force breaks tinted and super secret rocks throughout the room #{{Bomb}} Bomb rocks in the room will break apart, dropping a bomb pickup",
		},
		[Items.COLLECTIBLE_DIOGENES_POT] = {
			Name = "",
			Description = "사용 시 공격이 휘두를 수 있는 근접 곡괭이로 변경됩니다.#곡괭이는 적에게 피해를 주거나 장애물을 부술 수 있습니다.#!!! 곡괭이 공격 중 {{DamageSmall}}공격력이 1.5배로 증가하나, 피격 시 시작 방으로 이동합니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_GEORGE] = {
			Name = "",
			Description = "↑ {{RangeSmall}}사거리 +2.4#특수방 입장 시 입장한 방향으로 빨간 문을 생성합니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_POSSESSION] = {
			Name = "",
			Description = "{{Charm}} 방 입장 시 그 방의 적 하나를 아군으로 만듭니다. (최대 15마리)#!!! 패널티 피격 시 다시 적대적으로 변합니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_LOLLIPOP] = {
			Name = "",
			Description = "{{Charm}} 캐릭터 주변을 돌며 접촉한 적에게 매혹을 겁니다.#{{Heart}} 적의 탄환을 막아주고 일정 수 이상 막으면 파괴되며 하트를 드랍하며 방 클리어 시 복구됩니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_WATER_FULL] = {
			Name = "",
			Description = "↑ {{TearsSmall}}연사 +0.43#↑ {{TearsizeSmall}}눈물크기 증가#적이 있는 방에서 주기적으로 분수가 나오며 분수에 닿으면 {{TearsSmall}}재빠르게 사라지는 연사가 증가합니다.#{{Shop}} 상점에서 알약이 확률적으로 그 스테이지에서 {{TearsSmall}}연사를 증가시키는 물병으로 바뀝니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_AUBREY] = {
			Name = "",
			Description = "!!! 스테이지 당 1회#{{Shop}} 상점 입장 시 무기 거지가 등장합니다.#{{Collectible}} 무기 거지는 동전을 받으며 액티브 아이템을 3개 주고 떠납니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_TONY] = {
			Name = "",
			Description = "↑ 피격 시 그 방에서 1회 한정 2.5초 동안 폭주 상태로 돌입;#폭주 상태에서는 최대 체력이 100 이하인 적을 즉사, 공격력 x5의 큰 주먹을 휘두릅니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_REAL_LEFT] = {
			Name = "",
			Description = "{{Chest}} 사용 시 그 방의 모든 상자를 업그레이드 합니다.#순서: {{SpikedChest}} > {{HauntedChest}} > {{Chest}} > {{RedChest}} > {{GoldenChest}} or {{StoneChest}} > {{WoodenChest}} or {{DirtyChest}} > {{HolyChest}} > {{MegaChest}}#{{RedChest}} 상자가 없을 경우 빨간상자를 소환합니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_HITOPS] = {
			Name = "",
			Description = "↑ {{SpeedSmall}}이동속도({{ColorOrange}}상한{{CR}}) +0.2#{{Charm}} 가까이 있는 적을 매혹시킵니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_POPPOP] = {
			Name = "",
			Description = "공격키를 2번 눌러 그 방향으로 공격력 x3의 눈물을 2발 발사합니다.#!!! {{Timer}}발사 후 잠시동안 {{TearsSmall}}연사 감소",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_FOOTBALL] = {
			Name = "",
			Description = "{{Throwable}} 던질 수 있는 럭비공이 등장하며 럭비공은 적에게 속도에 비례한 피해를 줍니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_BALL_OF_TUMORS] = {
			Name = "",
			Description = "!!! {{Bomb}}/{{Heart}}/{{Key}}/{{Battery}} 픽업이 일정 확률로 종양 픽업으로 바뀝니다.#종양 픽업을 모아 종양 패밀리어를 최대 2마리까지 소환합니다.#종양 패밀리어는 캐릭터 주변을 돌며 탄환을 막아주고 접촉한 적에게 피해를 줍니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_BOW_AND_ARROW] = {
			Name = "",
			Description = "↑ {{DamageSmall}}탄환 수(연사 비례)에 따라 눈물 대신 공격력 x2.5의 화살을 발사합니다.#(탄환 소진 시 일반 공격)#발사한 화살은 주워서 재사용할 수 있습니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_EMERGENCY_MEETING] = {
			Name = "",
			Description = "{{Card1}} 사용 시 그 방의 적과 같이 시작 방으로 이동하며;#{{Confusion}} 그 방의 적을 일정 시간동안 혼란시킵니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_BOXING_GLOVE] = {
			Name = "",
			Description = "{{Chargeable}} 공격키를 2.35초 이상 누르면 충전되며 공격키를 떼면 {{Confusion}}적에게 혼란을 주는 넉백 펀치를 휘두릅니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_GRAVITY] = {
			Name = "",
			Description = "{{Timer}} 사용 시 5초동안 캐릭터의 중력을 반전시킵니다.#{{Seraphim}} {{ColorOrange}}중력 반전일 때:#비행 + 무적# {{TearsSmall}}사거리 +6.25#눈물이 아래로 떨어집니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_JOHNNYS_KNIVES] = {
			Name = "",
			Description = "{{Throwable}} 공격 키를 누르는 동안 적을 향해 돌진합니다.#칼로 적 처치 시 적에게 피해를 주는 빨간 장판을 생성하며 그 방에서 {{TearsSmall}}연사 +0.5",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_SER_JUNKAN] = {
			Name = "",
			Description = "적을 쫓아다니며 피해를 줍니다.#아이템 폭파 시 고물로 바뀌며 고물 획득 시 강화시킵니다.#7단계 달성 시 적에게 유도 눈물을 발사합니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_CROWDFUNDER] = {
			Name = "",
			Description = "사용 시 공격이 특수 미니건으로 변경됩니다.#↓ 미니건 장착 중에는 {{SpeedSmall}}이동속도 배율 x0.75#발사할 때마다 1{{Coin}}이 소모되며 탄환이 무언가에 부딪힐 때 잠시 후 사라지는 동전을 드랍합니다.#미니건으로 적 처치 시 동전을 추가로 드랍합니다.",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_POLARSTAR] = {
			Name = "",
			Description = "!!! 현재 특수 공격 모드#사용 시 특수 공격/비행 모드를 전환합니다.#소지 중 일정 수 이상 적 처치 시 아이템 단계 ↑, 피격 시 ↓ (모드별 공유)#1단계 : 공격력 x1.5의 탄환#2단계 : 공격력 x1.2의 2발 탄환#3단계 : 공격력 x3.75의 탄환",
			QuoteDesc = "",
		},
		[Items.COLLECTIBLE_BOOSTERV2] = {
			Name = "",
			Description = "!!! 현재 비행 모드#사용 시 특수 공격/비행 모드를 전환합니다.#소지 중 일정 수 이상 적 처치 시 아이템 단계 ↑, 피격 시 ↓ (모드별 공유)#1단계 : 이동속도 +0.65#2단계 : 적에게 화상 피해를 주는 장판 생성#3단계 : 피격 1회 무효화",
			QuoteDesc = "",
		},
	}
	CollectibleDesc[Items.COLLECTIBLE_FOCUS_2] = CollectibleDesc[Items.COLLECTIBLE_FOCUS]
	CollectibleDesc[Items.COLLECTIBLE_FOCUS_3] = CollectibleDesc[Items.COLLECTIBLE_FOCUS]
	CollectibleDesc[Items.COLLECTIBLE_FOCUS_4] = CollectibleDesc[Items.COLLECTIBLE_FOCUS]
	CollectibleDesc[Items.COLLECTIBLE_DIOGENES_POT_LIVE] = CollectibleDesc[Items.COLLECTIBLE_DIOGENES_POT]

	local TrinketDesc = {
		[Trinkets.TRINKET_RING_SNAKE] = {
			Name = "",
			Description = "{{Card}} 스테이지 진입 시 카드 2장을 소환합니다.",
			QuoteDesc = "",
		},
		[Trinkets.TRINKET_HUNKY_BOYS] = {
			Name = "",
			Description = "!!! 즉시 버리기 가능#바닥에 놓여진 상태에서 적이 때때로 장신구를 공격합니다.",
			QuoteDesc = "",
		},
		[Trinkets.TRINKET_BIBLE_THUMP] = {
			Name = "",
			Description = "!!! {{Collectible33}} The Bible이 모든 배열에서 등장합니다.#{{Collectible33}} The Bible 및 The Devil? 사용 시 그 방의 적에게 추가로 40의 피해를 줍니다.#{{Satan}} Satan에게 Bible 사용 시 ,캐릭터 즉사를 방지 + 보스를 즉사시킵니다.",
			Golden = "#{{TheLamb}} The Lamb에게 Bible 사용 시 보스를 즉사시킵니다.",
			QuoteDesc = "",
		},
		[Trinkets.TRINKET_CHEEP_CHEEP] = {
			Name = "",
			Description = "{{Fear}} 방 입장 시 적 하나가 3초동안 공포+표식에 걸립니다.",
			Golden = "#{{BleedingOut}} 표식에 걸린 적에 출혈이 추가로 걸립니다.",
			QuoteDesc = "",
		},
	}

	local CardDesc = {
		[Cards.CARD_COW_TRASH_FARM] = {
			Name = "",
			Description = "{{LordoftheFlies}} 그 방의 아이템을 파리 계열 아이템으로 바꿉니다.#그 방의 픽업을 자폭 파리로 바꿉니다.#{{Coin}} {{ColorGray}}캐릭터를 동전으로 되돌리지는 않습니다.",
			QuoteDesc = "",
		},
		[Cards.CARD_LOOT_CARD] = {
			Name = "",
			Description = "{{Collectible}} 랜덤 아이템(배열 랜덤) 혹은 장신구를 소환합니다.",
			QuoteDesc = "",
		},
		[Cards.CARD_BLANK] = {
			Name = "",
			Description = "!!! 1회 남음#적의 탄환을 모두 지우며;#주변의 적을 밀쳐냅니다.",
			QuoteDesc = "",
		},
		[Cards.CARD_BLANK_2] = {
			Name = "",
			Description = "!!! 2회 남음#적의 탄환을 모두 지우며;#주변의 적을 밀쳐냅니다.",
			QuoteDesc = "",
		},
		[Cards.CARD_BLANK_3] = {
			Name = "",
			Description = "!!! 3회 사용 가능#적의 탄환을 모두 지우며;#주변의 적을 밀쳐냅니다.",
			QuoteDesc = "",
		},
		[Cards.CARD_JESTER_CUBE] = {
			Name = "",
			Description = "{{Collectible689}} 사용 시 그 방의 아이템에 5개의 선택지를 추가합니다.",
			QuoteDesc = "",
		},
		[Cards.CARD_WITCH_CUBE] = {
			Name = "",
			Description = "!!! 50%의 확률로;#{{Burn}} 그 방의 적에게 40의 화상 피해를 주거나;#{{Poison}} 독방귀를 뀝니다. (소모되지 않음)",
			QuoteDesc = "",
		},
		[Cards.CARD_MURDER] = {
			Name = "",
			Description = "사용 시 0.25초동안 이동속도가 4로 설정, 닿은 적을 즉사시키며;#{{Stompy}} 그 방에서 Stompy 효과를 얻습니다.",
			QuoteDesc = "",
		},
		[Cards.CARD_AMBER_CHUNK] = {
			Name = "",
			Description = "#{{Coin}} 행운 동전을 소환합니다.#{{Collectible}} 사용 시 모든 아이템 및 픽업({{ColorRed}}엔딩 상자 포함{{CR}})을 제거합니다.#재사용 시 제거된 항목을 재소환합니다.#제거된 항목은 게임이 종료되어도 유지됩니다.",
			QuoteDesc = "",
		},
		[Cards.CARD_DEMON_FORM] = {
			Name = "",
			Description = "↑ {{DamageSmall}}그 방에서 공격력 +1#{{Player7}} 그 방에서 굵기가 굵은 혈사포를 발사하는 Azazel로 변신합니다.",
			QuoteDesc = "",
		},
		[Cards.CARD_FIEND_FIRE] = {
			Name = "",
			Description = "{{Burn}} 모든 픽업을 불로 바꾸며 바꾼 픽업 수에 비례하여 {{SpeedSmall}}/{{TearsSmall}}/{{DamageSmall}}/{{RangeSmall}}/{{LuckSmall}} 중 하나씩 증가시킵니다.",
			QuoteDesc = "",
		},
	}

	for itemID, itemdesc in pairs(CollectibleDesc) do
		local desc = itemdesc.Description
		if itemdesc.StatusEffects then
			for _, eff in ipairs(itemdesc.StatusEffects) do
				itemdesc.Description = itemdesc.Description .. eff
			end
		end
		EID:addCollectible(itemID, desc, itemdesc.Name, "ko_kr")
		if itemdesc.Wisps and itemdesc.Wisps ~= "" then
			EID.descriptions["ko_kr"].bookOfVirtuesWisps[itemID] = itemdesc.Wisps
		end
		if itemdesc.BingeEater and itemdesc.BingeEater ~= "" then
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
				itemdesc.Description = itemdesc.Description .. eff
			end
		end
		EID:addTrinket(itemID, desc, itemdesc.Name, "ko_kr")
	end
	for itemID, itemdesc in pairs(CardDesc) do
		EID:addCard(itemID, itemdesc.Description, itemdesc.Name, "ko_kr")
	end

	return {
		targetMod = "WarpZone",
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
		cards = CardDesc,
	}

end