
if GODMODE then

	EID._currentMod = "AOIGodmodeAchieved"

	local V_REPLACE = 0
	local V_APPEND = 1

	local Items = GODMODE.registry.items
	local Trinkets = GODMODE.registry.trinkets
	
	local BirthrightDesc = {
		[Isaac.GetPlayerTypeByName("Recluse",false)] = {
			Name = "Recluse",
			Description = "{{Collectible"..Items.larval_therapy.."}}진드기의 공격력 +50%",
			QuoteDesc = "",
		},
		[Isaac.GetPlayerTypeByName("Tainted Recluse",true)] = {
			Name = "Tainted Recluse",
			Description = "{{Collectible"..Items.reclusive_tendencies.."}} Reculsive Tendencies 사용 시 진드기가 2배로 소환됩니다.#{{Collectible"..Items.reclusive_tendencies.."}} Reculsive Tendencies로 소환된 거미의 공격력 +50%",
			QuoteDesc = "",
		},
		[Isaac.GetPlayerTypeByName("Xaphan",false)] = {
			Name = "Xaphan",
			Description = "↑ {{LuckSmall}}행운 +5#{{Collectible"..Items.adramolechs_blessing.."}}Adramolech's Blessing의 충전량이 2배로 증가합니다.",
			QuoteDesc = "",
		},
		[Isaac.GetPlayerTypeByName("Tainted Xaphan",true)] = {
			Name = "Tainted Xaphan",
			Description = "{{Collectible"..Items.adramolechs_fury.."}} 챔피언이 Adramolech's Fury의 표식에 걸릴 확률 +25%#25%의 확률로 표식 걸린 챔피언 속성이 제거됩니다.",
			QuoteDesc = "",
		},
		[Isaac.GetPlayerTypeByName("Elohim",false)] = {
			Name = "Elohim",
			Description = "{{AngelRoom}} 특수한 천사방으로 순간이동합니다.#{{AngelRoom}} 특수한 천사방에는 천사방 아이템 3개를 획득할 수 있습니다.",
			QuoteDesc = "",
		},
		[Isaac.GetPlayerTypeByName("Tainted Elohim",true)] = {
			Name = "Tainted Elohim",
			Description = "{{BossRoom}} 보스방의 보스 처치시 모든 능력치가 추가로 증가합니다.",
			QuoteDesc = "",
		},
		[Isaac.GetPlayerTypeByName("Gehazi",false)] = {
			Name = "Gehazi",
			Description = "{{Collectible"..Items.crown_of_gold.."}} 피격 시 잃는 {{Coin}}동전의 개수 -2",
			QuoteDesc = "",
		},
		[Isaac.GetPlayerTypeByName("Deli",false)] = {
			Name = "Deli",
			Description = "↑ {{DamageSmall}}공격력 배율 x1.2#↑ {{TearsSmall}}연사 배율 x1.1",
			QuoteDesc = "",
		},
		[Isaac.GetPlayerTypeByName("Tainted Deli",true)] = {
			Name = "Tainted Deli",
			Description = "적 처치 시 등장하는 Delirious Pile 처치 시 나오는 탄환이 더 이상 캐릭터에게 피해를 주지 않습니다.",
			QuoteDesc = "",
		},
		[Isaac.GetPlayerTypeByName("The Sign",false)] = {
			Name = "The Sign",
			Description = "{{BrokenHeart}}모든 부서진하트를 제거합니다.#↑ {{SpeedSmall}}이동속도 배율 x1.33",
			QuoteDesc = "",
		},
	}

	local CollectibleDesc = {
		[Items.abrahams_map] = {
			Description = "!!! 2회 사용 가능#사용 시 방 안에 {{Quality4}}등급을 제외한 아이템이 없을 경우 그 방의 아이템을 하나 생성합니다.#사용 시 방 안에 {{Quality4}}등급을 제외한 아이템이 있을 경우 그 방의 아이템을 랜덤 배열의 {{Quality4}}등급 아이템으로 바꿉니다.",
			Name = "아브라함의 지도",
			QuoteDesc = "",
		},
		[Items.adramolechs_blessing] = {
			Description = "!!! 방 클리어로 충전되지 않음#표시된 챔피언 몬스터 4마리 처치 시 1칸이 충전됩니다.#피격 시 충전량이 있을 경우 충전량 1칸을 소모하여 그 피격을 무효화합니다.#!!! 소지 한 상태에서 (충전량 +10)%p만큼:#방 입장 시 챔피언 몬스터의 등장 확률이 증가하며;#{{DevilRoom}} 악마방 배열의 아이템을 더 높은 등급의 아이템으로 바꿉니다.#↑ 사용 시 아이템을 소지하는 동안 모든 능력치 증가",
			Name = "아드라몰렉의 축복",
			QuoteDesc = "내 말을 따르면 너의 시간이 올지오다",
		},
		[Items.adramolechs_fury] = {
			Description = "!!! 최대 충전량 100/방 클리어로 충전되지 않음#피격 시 충전량 20을 소모하여 그 피격을 무효화합니다.#챔피언 몬스터 등장 시 50%의 확률로 표식이 걸립니다.#표식에 걸린 챔피언 및 보스 처치 시 및 악마방 아이템 획득 시 드랍되는 붉은 구슬로 충전되며 사용 시 특수한 악마방으로 순간이동합니다.#!!! 완충되지 않은 상태에서는 {{DevilRoom}}악마방/{{AngelRoom}}천사방을 제외한 아이템을 획득할 수 없습니다.#↑ 소지 중일 때 충전량에 비례하여 모든 능력치 증가",
			Name = "아드라몰렉의 분노",
			QuoteDesc = "내 말을 따르면 너의 시간이 올지오다",
		},
		[Items.angel_food] = {
			Description = "↑ {{SoulHeart}}소울하트 +1#↑ {{GoldenHeart}}황금하트 +1#↑ {{TearsSmall}}연사 +0.5",
			BingeEater = "↑ {{RangeSmall}}사거리 +2",
			Name = "천사의 식사",
			QuoteDesc = "금기",
		},
		[Items.angry_apple_juice] = {
			Description = "사용 시 {{Heart}}체력을 한칸 회복하며 그 방에서 {{DamageSmall}}공격력 배율 x1.2, {{DamageSmall}}추가 공격력 +1 증가하나 화면이 약간 일그러집니다.",
			Name = "화난 애플 주스",
			QuoteDesc = "내가 뭘 한거지?",
		},
		[Items.arcade_ticket] = {
			Description = "{{ArcadeRoom}} 사용 시 스테이지에 방문하지 않은 오락실이 있을 경우 오락실로 순간이동합니다.#오락실에서 사용 시 10%의 확률로 빨간 코인/90%의 확률로 랜덤 픽업을 소환합니다.",
			Name = "오락실 티켓",
			QuoteDesc = "게임할 시간?",
		},
		[Items.baptismal_cross] = {
			Description = "사용 시 1초동안 캐릭터의 위치에 공격력 x0.5~x1.5의 눈물세례를 퍼붓습니다.",
			Name = "세례 십자가",
			QuoteDesc = "",
		},
		[Items.black_mushroom] = {
			Description = "!!! 일회용#!!! 사용 시;#↓ {{EmptyHeart}}최대 체력 -1#↑ {{SoulHeart}}소울하트 +3#{{Heart}} 체력을 전부 회복합니다.#사용한 방에서 나가면 스테이지를 재시작합니다.",
			Name = "암흑 버섯",
			QuoteDesc = "",
		},
		[Items.blood_pudding] = {
			Description = "↑ {{LuckSmall}}행운 +5#!!! {{CurseCursedSmall}}항상 저주에 걸립니다.",
			Name = "핏투성이 푸딩",
			QuoteDesc = "",
		},
		[Items.bubble_wand] = {
			Description = "방 입장 시 적에게 캐릭터의 공격력의 피해를 주는 방울을 소환합니다.#!!! 소환 개수 : 3~5+({{EmptyHeart}}+{{SoulHeart}})/2#각 방울마다 5%의 확률로 터지면 8방향으로 눈물을 쏘는 큰 방울이 됩니다.#{{LuckSmall}} :행운 10+일 때 25%",
			Name = "방울방울 완드",
			QuoteDesc = "",
		},
		[Items.burnt_diary] = {
			Description = "사용 시 방 안을 돌아다니며 적에게 5+{{Burning}}30의 피해를 주는 불타는 종이를 5장 소환합니다.",
			Name = "불타는 일기",
			QuoteDesc = "",
		},
		[Items.impending_doom] = {
			Description = "사용 시 적에게 최대 체력의 25%의 피해를 줍니다.(최소 10)#!!! 소지한 상태에서 스테이지 진입 시 {{BrokenHeart}}부서진하트 +1",
			Name = "다가오는 운명",
			QuoteDesc = "",
		},
		[Items.the_carrot] = {
			Description = "↑ {{Heart}}최대 체력 +1#스테이지 진입 시 {{Collectible21}}/{{Collectible54}}/{{Collectible246}} 중 하나의 효과를 발동합니다.",
			Name = "당근",
			QuoteDesc = "",
		},
		[Items.celestial_collar] = {
			Description = "15%의 확률로 {{TreasureRoom}}보물방/{{Shop}}상점/{{BossRoom}}보스방의 아이템이 {{Collectible11}}1up!로 교체됩니다.#↑ 목숨 개수 당 {{DamageSmall}}공격력 배율 +10%",
			Name = "천체 목걸이",
			QuoteDesc = "",
		},
		[Items.celestial_paw] = {
			Description = "{{HalfSoulHeart}} 사용 시 최대 체력이 -1 감소하며 그 방의 모든 적을 소울하트 반칸 픽업으로 바꿉니다.#보스의 경우 최대 체력 25%의 피해를 줍니다.",
			Name = "천체 발바닥",
			QuoteDesc = "",
		},
		[Items.celestial_tail] = {
			Description = "{{Key}} 열쇠 픽업이 1+1로 나옵니다.#{{EternalChest}} 상자가 50%의 확률로 이터널 상자로 교체됩니다.",
			Name = "천체 꼬리",
			QuoteDesc = "",
		},
		[Items.crossbones] = {
			Description = "적 4마리 처치 시마다 3초간 무적이 됩니다.",
			Name = "십자가로 묶은 뼈",
			QuoteDesc = "",
		},
		[Items.crown_of_gold] = {
			Description = "방 입장 시 랜덤 적 하나를 석화시킵니다. #↑ {{Coin}}동전 25개마다 {{LuckSmall}}행운 +1#↓ 피격 시 일정 수량만큼의 동전을 잃습니다.#!!! 수량 : (5 + {{DamageSmall}} - (1~3))",
			Name = "황금 왕관",
			QuoteDesc = "",
		},
		[Items.dads_balloon] = {
			Description = "!!! 사용 시:#캐릭터의 위치에 적을 석화시키는 장판을 깔거나;#4/8/16방향의 눈물을 발사합니다.",
			Name = "아빠의 풍선",
			QuoteDesc = "이거 물이 잘 담기지 않는 것 같아",
		},
		[Items.devils_food] = {
			Description = "↑ {{BlackHeart}}블랙하트 +2#↑ {{DamageSmall}}공격력 +1",
			BingeEater = "↑ {{ShotspeedSmall}}탄속 +0.2",
			Name = "악마의 먹잇감",
			QuoteDesc = "",
		},
		[Items.divine_approval] = {
			Description = "{{GoldHeart}} 획득 시 모든 블랙하트가 제거되며 황금하트를 최대 개수만큼 채웁니다.#↑ {{SoulHeart}}소울하트 +3#↑ 스테이지 진입 시 {{GoldenHeart}}황금하트 +1#↑ {{GoldenHeart}}황금하트 개수만큼 {{TearsSmall}}연사 +0.25",
			Name = "신성한 찬의",
			QuoteDesc = "비쌀수록 아픈 법",
		},
		[Items.divine_wrath] = {
			Description = "방 클리어 시 {{DamageSmall}}공격력 배율이 +3%p씩 최대 100%p까지 증가합니다.#패널티 피격 시 그 방의 적의 체력의 공격력 배율 증가치 %만큼의 방어 무시 피해를 주며 공격력 배율 증가치가 초기화됩니다.",
			Name = "신성한 분노",
			QuoteDesc = "",
		},
		[Items.diya] = {
			Description = "{{Weakness}} 사용 시 그 방에서 적의 속도가 느려지며 적에게 주는 피해량이 2배 증가합니다.",
			Name = "디야",
			QuoteDesc = "",
		},
		[Items.dragon_fruit] = {
			Description = "사용 시 {{HalfHeart}}체력을 반칸 회복하며 랜덤 능력치 하나를 5분간 증가시킵니다.",
			Name = "용의 과일",
			QuoteDesc = "",
		},
		[Items.edible_soul] = {
			Description = "↑ {{BlackHeart}}블랙하트 +1#사망 시 {{BlackHeart}}3/비행/{{BrokenHeart}}3 상태로 부활하며 아군 Furnace Knight를 3마리 소환합니다.",
			Name = "식용 영혼",
			QuoteDesc = "",
		},
		[Items.fallen_guardian] = {
			Description = "적을 쫓아다니며 접촉한 적에게 캐릭터의 공격력 x0.15 + 1.3의 피해를 줍니다.#적을 오래 공격할수록 공격 주기가 더 짧아집니다.",
			Name = "타락한 수호자",
			QuoteDesc = "",
		},
		[Items.fatal_attraction] = {
			Description = "↓ {{EmptyHeart}}빨간하트 -3#↑ {{BlackHeart}}블랙하트 +1#스테이지 진입 시 특정 능력치를 10% 증가하나 다른 능력치를 7.5% 감소하는 선택지를 3개 소환합니다.",
			Name = "치명적 매혹",
			QuoteDesc = "",
		},
		[Items.feather_duster] = {
			Description = "↑ {{SpeedSmall}}이동속도 +0.1#부정적인 문 효과가 발생하지 않습니다.#거미줄을 밟으면 거미줄이 사라집니다.",
			Name = "더스터 깃털",
			QuoteDesc = "",
		},
		[Items.forbidden_knowledge] = {
			Description = "{{Heart}} 빨간하트를 집을 때마다 확률적으로 랜덤 픽업을 소환합니다:#25% : 없음#{{Blank}} 20% : {{Bomb}}폭탄#{{Blank}} 15% : {{Key}}열쇠#{{Blank}} 40% : {{Coin}}동전",
			Name = "금지된 지식",
			QuoteDesc = "",
		},
		[Items.four_leaf_clover] = {
			Description = "↑ {{LuckSmall}}행운 +2#{{LuckSmall}} 행운 1당 {{DamageSmall}}공격력 +0.25, {{TearsSmall}}연사 +0.25",
			Name = "네잎클로버",
			QuoteDesc = "",
		},
		[Items.fruit_flies] = {
			Description = "과일 파리를 3마리 소환합니다.#방 클리어 시 3%의 확률로(누적) 터지면서 랜덤 스탯을 5분간 증가시키는 과일을 드랍합니다.#터진 파리는 즉시 재생산됩니다.",
			Name = "과일 파리",
			QuoteDesc = "",
		},
		[Items.fruit_salad] = {
			Description = "↑ {{Heart}}최대 체력 +1#↑ {{Heart}}빨간하트 +2#↑ {{SoulHeart}}소울하트 +1#획득 시 랜덤 스탯을 5분간 증가시키는 과일을 8개 드랍합니다.",
			Name = "과일 샐러드",
			QuoteDesc = "",
		},
		[Items.fuzzy_dice] = {
			Description = "사용 시 각각 소지 중인 {{Coin}}/{{Bomb}}/{{Key}}의 33%를 섞습니다.",
			Name = "애매한 주사위",
			QuoteDesc = "",
		},
		[Items.gangrene] = {
			Description = "주기적으로 캐릭터의 위치에 공격력 x0.1의 독성 눈물을 남깁니다.",
			Name = "회저",
			QuoteDesc = "",
		},
		[Items.ghanta] = {
			Description = "{{SoulHeart}} 사용 시 {{EmptyHeart}}최대 체력이 -1 감소, 빨간하트를 한칸만 남기고 전부 제거, 제거한 만큼 소울하트를 드랍합니다.",
			Name = "간트",
			QuoteDesc = "",
		},
		[Items.gold_plated_battery] = {
			Description = "액티브 아이템 버튼을 5초간 누르고 있으면 5{{Coin}}을 소모하여 충전량 1칸을 충전합니다.",
			Name = "도금 배터리",
			QuoteDesc = "",
		},
		[Items.golden_stopwatch] = {
			Description = "사용 시 {{Coin}}동전을 하나 소환하며 그 방에서 동전이 차감되지 않습니다.",
			Name = "황금 스탑워치",
			QuoteDesc = "",
		},
		[Items.cloth_of_gold] = {
			Description = "적을 맞출 시 같은 종류의 적에게 피해가 분산됩니다.#소지 중이지 않은 경우 5%의 확률로 아이템이 {{Collectible"..Items.cloth_on_a_string.."}}Cloth on a String으로 바뀝니다.",
			Name = "황금 옷감",
			QuoteDesc = "",
		},
		[Items.heart_arrest] = {
			Description = "↑ {{TearsSmall}}연사 +0.25#눈물 발사 간격이 심장 박동 방식으로 바뀝니다.#체력이 비어 있수록 눈물 딜레이가 감소합니다.",
			Name = "심정지",
			QuoteDesc = "",
		},
		[Items.holy_chalice] = {
			Description = "방 클리어 시 {{DamageSmall}}공격력이 +0.75씩 최대 4회 증가합니다.#패널티 피격 시 공격력 증가치가 초기화됩니다.",
			Name = "신성한 성배",
			QuoteDesc = "",
		},
		[Items.anguish_jar] = {
			Description = "사용 시 6.666초간 닿은 위치에 적을 느려지게 하는 장판을 깔며 초당 170의 피해를 주는 레이저를 조종합니다.",
			Name = "격통의 유리병",
			QuoteDesc = "",
		},
		[Items.hysteria] = {
			Description = "방 안의 적 당 {{TearsSmall}}연사 +0.05#방 안의 보스 당 {{TearsSmall}}연사 +0.25",
			Name = "히스테리",
			QuoteDesc = "",
		},
		[Items.the_ladle] = {
			Description = "↑ {{Heart}}최대 체력 +1#↑ {{SpeedSmall}}이동속도 +0.1#피격 시 {{SpeedSmall}}이동속도가 +0.1씩 최대 5회 증가합니다.#스테이지 진입 시 이동속도 증가치가 초기화됩니다.",
			Name = "국자",
			QuoteDesc = "",
		},
		[Items.larval_therapy] = {
			Description = "적 처치 시 체력이 가장 높은 적을 쫒아가는 진드기를 소환합니다.#진드기는 적에게 캐릭터의 공격력 x0.25의 피해를 주며 10번의 피해를 주면 사라집니다.",
			Name = "벌레 테라피",
			QuoteDesc = "",
		},
		[Items.late_delivery] = {
			Description = "↑ {{TearsSmall}}연사 +0.5#적에게 2500의 피해를 줄 시 그 방의 아이템을 하나 소환합니다.#아이템 소환 시마다 다음 소환에 필요한 피해량이 5000씩 증가합니다.",
			Name = "느릿느릿 배달",
			QuoteDesc = "",
		},
		[Items.marshall_scarf] = {
			Description = "↑ 스테이지에 따라 {{TearsSmall}}연사 증가#Womb/Corpse 이전 : +0.5#Womb/Corpse : +0.75#Womb 이후 : +1",
			Name = "마샬 스카프",
			QuoteDesc = "",
		},
		[Items.maxs_head] = {
			Description = "!!! 사용 시마다(최대 5회);#↑ {{DamageSmall}}공격력 배율 +25%p#↓ {{TearsSmall}}연사 배율 -10%p#↓ {{SpeedSmall}}이동속도 배율 -5%p",
			Name = "맥스의 머리",
			QuoteDesc = "",
		},
		[Items.moms_wish] = {
			Description = "사용 시 {{Card51}}Holy Card를 드랍하며 {{ColorOrange}}모든 능력치가 -5%p씩 영구적으로 감소합니다.{{CR}} (최대 90%)",
			Name = "엄마의 소원",
			QuoteDesc = "",
		},
		[Items.morphine] = {
			Description = "↓ {{BrokenHeart}}부서진하트 +2#↓ {{SpeedSmall}}이동속도 배율 -20%#↑ {{DamageSmall}}공격력 +1#30%의 확률로 피해를 무시합니다.",
			Name = "모르핀",
			QuoteDesc = "아무것도 느껴지지 않아!",
		},
		[Items.nirvana] = {
			Description = "모든 적의 최대 체력을 20% 깎습니다.",
			Name = "니르바나",
			QuoteDesc = "",
		},
		[Items.nosebleed] = {
			Description = "방 입장 시 5초동안 서서히 감소하는 {{DamageSmall}}공격력 배율이 +50% 증가합니다.",
			Name = "코피",
			QuoteDesc = "",
		},
		[Items.opia] = {
			Description = "{{Charm}} 사용 시 공격방향으로 영혼을 던지며 영혼에 닿은 적을 아군으로 만들며 같은 종류의 적을 매혹시킵니다.#보스의 경우 위의 효과 대신 캐릭터의 공격력 x4의 피해를 줍니다.",
			Name = "오피아",
			QuoteDesc = "",
		},
		[Items.pair_of_cans] = {
			Description = "방 입장 시 캐릭터의 주변을 돌며 적의 탄환을 1회 막아주는 보호막을 4개 소환합니다.",
			Name = "캔 한 쌍",
			QuoteDesc = "",
		},
		[Items.papal_cross_holy] = {
			Description = "#{{AngelRoom}} 사용 시 특수한 천사방으로 이동합니다.#{{AngelRoom}} 특수한 천사방에는 천사방 아이템이 있으나 여러 몬스터가 존재합니다.#!!! (100-천사방확률)%의 확률로 {{Collectible"..Items.papal_cross_unholy.."}}unholy Papal Cross 아이템으로 바뀝니다.",
			Name = "교황의 십자가",
			QuoteDesc = "",
		},
		[Items.papal_cross_unholy] = {
			Description = "#{{DevilRoom}} 사용 시 특수한 악마방으로 이동합니다.#{{DevilRoom}} 특수한 악마방에는 거래가 필요 없는 악마방 아이템이 있으나 여러 몬스터가 존재합니다.#!!! 50%의 확률로 아이템이 제거되며 제거되지 않은 경우 천사방 확률만큼 {{Collectible"..Items.papal_cross_holy.."}}Papal Cross 아이템으로 바뀝니다.",
			Name = "교황의 십자가",
			QuoteDesc = "",
		},
		[Items.portable_confessional] = {
			Description = "{{SoulHeart}} 사용 시 체력 반칸을 깎고 소울하트를 하나 드랍합니다.#{{AngelRoom}} 천사방 입장 시 아이템이 완충되며 천사방에서 사용 시 소울하트 대신 {{BrokenHeart}}부서진하트를 최대 3개까지 제거합니다.",
			Name = "휴대용 고해실",
			QuoteDesc = "",
		},
		[Items.prayer_mat] = {
			Description = "클리어하지 않은 방에 10초동안 움직이지 않을 시 캐릭터의 위치에 빛줄기를 하나 소환하며 {{HalfSoulHeart}}소울하트 반칸을 획득합니다. (방당 1회 한정)",
			Name = "기도자의 매트",
			QuoteDesc = "",
		},
		[Items.quran] = {
			Description = "사용 시 모든 {{BlackHeart}}블랙하트를 1.5배의 {{SoulHeart}}소울하트로 바꿉니다.#{{MomBossSmall}}Mom, {{MomsHeartSmall}}Mom's Heart/It Lives 보스에게 사용 시 보스를 즉사시킵니다.#!!! {{SatanSmall}}Satan 보스에게 사용 시 캐릭터가 즉사합니다.",
			Name = "쿠란",
			QuoteDesc = "",
		},
		[Items.orb_of_radiance] = {
			Description = "사용 시 캐릭터의 주변을 돌며 공격력 x0.3 +1의 후광 눈물을 6개 발사합니다.",
			Name = "발광체 오브",
			QuoteDesc = "",
		},
		[Items.reclusive_tendencies] = {
			Description = "공격이 적에게 맞을 시 특수한 Spider를 소환합니다.#특수한 Spider는 5초동안 적에게 캐릭터의 공격력 x0.1의 피해를 주나 5초 이후에는 아군 상태가 풀립니다.#사용 시 3 +(Small Spider개수)만큼의 진드기를 소환합니다.#진드기는 적에게 캐릭터의 공격력 x0.25의 피해를 주며 10번의 피해를 주면 사라집니다.",
			Name = "은둔 성향",
			QuoteDesc = "",
		},
		[Items.book_of_saints] = {
			Description = "사용 시 {{SoulHeart}}소울하트 +1, {{GoldenHeart}}황금하트 +2",
			Name = "성인의 책",
			QuoteDesc = "",
		},
		[Items.a_second_thought] = {
			Description = "↑ {{SpeedSmall}}이동속도 +0.2#보스러시 및 Hush의 입구가 항상 열립니다.#Call of the Void 패널티가 더 이상 발동하지 않습니다.",
			Name = "다른 생각",
			QuoteDesc = "",
		},
		[Items.seraphim_warhorn] = {
			Description = "사용 시 그 방에 아군 Uriel을 소환합니다.",
			Name = "천사의 뿔",
			QuoteDesc = "",
		},
		[Items.sharing_is_caring] = {
			Description = "↑ 모든 패밀리어가 33% 빨라집니다.",
			Name = "나눔이 곧 배려",
			QuoteDesc = "",
		},
		[Items.soft_serve] = {
			Description = "↑ {{SoulHeart}}소울하트 +1#↑ 빈 체력이 없을 경우 추가 소울하트 +2#공격 시 10의 확률로 적에게 피해를 주며 색상별로 다른 효과를 대는 장판이 생성됩니다.#{{LuckSmall}} :행운 13.3+일 때 50%",
			Name = "소프트 아이스크림",
			QuoteDesc = "",
		},
		[Items.soul_food] = {
			Description = "↑ {{SoulHeart}}소울하트 +2#↑ {{LuckSmall}}행운 +1",
			BingeEater = "↑ {{SpeedSmall}}이동속도 +0.2",
			Name = "영혼의 먹이",
			QuoteDesc = "",
		},
		[Items.sugar] = {
			Description = "!!! 획득 시 이후 등장하는 3개의 아이템이 50%의 확률로 {{Collectible"..Items.sugar.."}}Sugar!로 교체되며;#↓ {{EmptyHeart}}최대 체력 -1#↑ {{SpeedSmall}}이동속도 +0.125#↑ {{DamageSmall}}공격력 +0.25/0.55(5회이후)/0.2(10회이후)#↑ {{TearsSmall}}연사 +0.35/0.2(5회이후)",
			Name = "각설탕",
			QuoteDesc = "",
		},
		[Items.taenia] = { -- TearRange adds 5, not 200
			Description = "↑ {{RangeSmall}}사거리 +5#↓ {{ShotspeedSmall}}탄속 -0.25#공격 시 공격 키를 뗄 때까지 같은 공격방향을 유지합니다.",
			Name = "태니아",
			QuoteDesc = "",
		},
		[Items.cloth_on_a_string] = {
			Description = "적을 맞출 시 같은 종류의 적에게 105%의만큼 추가 피해를 줍니다.#소지 중이지 않은 경우 1%의 확률로 아이템이 {{Collectible"..Items.cloth_of_gold.."}}Cloth of Gold로 바뀝니다.",
			Name = "실에 달린 옷감",
			QuoteDesc = "",
		},
		[Items.tecpatl] = {
			Description = "사용 시 {{BrokenHeart}}부서진하트가 +1개 증가하며 20초간 무적 상태가 됩니다.",
			Name = "텍패틀",
			QuoteDesc = "",
		},
		[Items.tramp_of_babylon] = {
			Description = "↑ 스테이지에 비례하여 {{DamageSmall}}공격력 증가#소지한 상태에서 피격 시 그 방의 적 및 보스가 둘로 복제됩니다.",
			Name = "바빌론의 창녀",
			QuoteDesc = "힘에는 대가가 따르지",
		},
		[Items.childs_trophy] = {
			Description = "!!! 스테이지 2회 진입 시 재충전#사용 시 그 방에서 {{DamageSmall}}공격력 배율 x6, {{TearsSmall}}연사 +3",
			Name = "아이의 트로피",
			QuoteDesc = "",
		},
		[Items.uncommon_cough] = {
			Description = "공격이 여러 개의 눈물을 흩뿌리는 공격으로 바뀝니다.",
			Name = "익숙하지 않은 기침",
			QuoteDesc = "",
		},
		[Items.vajra] = {
			Description = "피격 시 랜덤 방향으로 공격력 x2 +10의 짧은 레이저 6발을 발사하며;#추가로 그 방의 모든 적에게 공격력 x1의 레이저를 발사합니다.",
			Name = "바쥬라",
			QuoteDesc = "",
		},
		[Items.war_banner] = {
			Description = "↑ {{Bomb}}폭탄 +5#폭탄 설치 시 최대 10개까지 설치한 위치에 랜덤 오라를 발산합니다.#오라 안에 있을 시 색상에 따라:#{{ColorRed}}빨강{{CR}} : {{DamageSmall}}공격력 +0.25#{{ColorBlue}}파랑{{CR}} : {{TearsSmall}}연사 +0.25#{{ColorYellow}}노랑{{CR}} : {{ShotspeedSmall}}탄속 +0.1",
			Name = "전쟁의 배너",
			QuoteDesc = "",
		},
		[Items.wings_of_betrayal] = {
			Description = "피격 시 그 방에서 {{DamageSmall}}공격력 +2.5 증가하며 비행 능력을 얻습니다.",
			Name = "배반의 날개",
			QuoteDesc = "고통 없이는 얻는 것이 없다",
		},



		[Items.jack_of_all_trades] = {
			Description = "획득 시 모든 변신세트 카운터 +1",
			Name = "만물박사",
			QuoteDesc = "",
		},
		[Items.questrock_1] = {
			Description = "!!! 미구현#조각 4개를 모두 모으면 Sheol 스테이지에서 Gatekeeper에게 접근할 수 있습니다.",
			Name = "돌 조각 1",
			QuoteDesc = "",
		},
		[Items.questrock_2] = {
			Description = "!!! 미구현#조각 4개를 모두 모으면 Sheol 스테이지에서 Gatekeeper에게 접근할 수 있습니다.",
			Name = "돌 조각 2",
			QuoteDesc = "",
		},
		[Items.questrock_3] = {
			Description = "!!! 미구현#조각 4개를 모두 모으면 Sheol 스테이지에서 Gatekeeper에게 접근할 수 있습니다.",
			Name = "돌 조각 3",
			QuoteDesc = "",
		},
		[Items.questrock_4] = {
			Description = "!!! 미구현#조각 4개를 모두 모으면 Sheol 스테이지에서 Gatekeeper에게 접근할 수 있습니다.",
			Name = "돌 조각 4",
			QuoteDesc = "",
		},
		[Items.blood_key] = {
			Description = "Sheol 스테이지에서 Ivory Palace에 진입할 수 있습니다.",
			Name = "핏빛 열쇠",
			QuoteDesc = "",
		},
		[Items.brass_cross] = {
			Description = "↑ {{SoulHeart}}소울하트 +2#↑ 스테이지 입장 시 축복 확률 +25%",
			Name = "축복 십자가",
			QuoteDesc = "",
		},
	}

	local TrinketDesc = {
		[Trinkets.bobs_tongue] = {
			Description = "↑ {{TearsSmall}}연사 +0.25#{{Bob}} Bob 변신세트의 아이템 2개 소지 시 랜덤 Bob 아이템 획득과 동시에 장신구가 흡수됩니다.",
			Name = "밥의 혓바닥",
			QuoteDesc = "",
		},
		[Trinkets.bombshell] = {
			Description = "{{Poison}} {{Bomb}}폭탄 설치 시 5초동안 캐릭터의 위치에 독장판을 생성하며 폭탄의 위치에 독가스를 생성합니다.",
			Name = "폭발물",
			QuoteDesc = "",
		},
		[Trinkets.gesture_of_the_deep] = {
			Description = "클리어하지 않은 방 입장 시 액티브 아이템이 충전되어 있을 경우 자동으로 사용합니다.#최대 충전량이 2칸 이하인 경우 1%의 확률로 실패합니다.#방 클리어 시 5%의 확률로 배터리 픽업을 추가로 소환합니다.",
			Name = "깊은 곳으로부터의 손짓",
			QuoteDesc = "",
		},
		[Trinkets.godmode] = {
			Description = "!!! {{ColorOrange}}교체 및 버리기 불가{{CR}}#{{Collectible422}} 패널티 피격 시 {{BrokenHeart}}부서진하트를 +1개 추가하며 전 방의 시점으로 돌아갑니다.",
			Name = "GODMODE",
			QuoteDesc = "",
		},
		[Trinkets.cake_pop] = {
			Description = "스테이지 진입 시 소지 중인 장신구를 흡수합니다.",
			Name = "마블 사탕",
			QuoteDesc = "",
		},
		[Trinkets.snack_lock] = {
			Description = "스테이지 진입 시 랜덤 스탯을 5분간 증가시키는 과일을 3개 드랍합니다.",
			Name = "도난방지 장치",
			QuoteDesc = "",
		},
		[Trinkets.snapped_cross] = {
			Description = "적 처치 시 10%의 확률로 3초간 무적 상태가 됩니다.",
			Name = "부서진 십자가",
			QuoteDesc = "",
		},


		[Trinkets.mood_ring_blue] = {
			Description = "!!! 현재 3회 남음#Call of the Void의 탄환을 3회 막아줍니다.#막아줄 때마다 한 단계씩 차감하며 스테이지 진입 시 단계가 돌아옵니다.#파란색일 때 스테이지 진입 시 랜덤 능력치가 영구적으로 증가합니다.#위 설정 비활성화 시 소지 중일 때 {{DamageSmall}}공격력 +0.5, {{LuckSmall}}행운 +0.5",
			Name = "무드 링",
			QuoteDesc = "",
		},
		[Trinkets.mood_ring_yellow] = {
			Description = "!!! 현재 2회 남음#Call of the Void의 탄환을 2회 막아줍니다.#스테이지 진입 시 파란색으로 변합니다.",
			Name = "무드 링",
			QuoteDesc = "",
		},
		[Trinkets.mood_ring_green] = {
			Description = "!!! 현재 1회 남음#Call of the Void의 탄환을 1회 막아줍니다.#스테이지 진입 시 노란색으로 변합니다.",
			Name = "무드 링",
			QuoteDesc = "",
		},
		[Trinkets.mood_ring_black] = {
			Description = "!!! 무효과#스테이지 진입 시 초록색으로 변합니다.",
			Name = "무드 링",
			QuoteDesc = "",
		},


		[Trinkets.cracked_nazar] = {
			Description = "{{CurseCursedSmall}} 스테이지 진입 시 50%의 확률로 저주를 제거합니다.",
			Name = "깨진 나자르",
			QuoteDesc = "",
		},
		[Trinkets.cursed_pendant] = {
			Description = "↑ {{SpeedSmall}}이동속도 +0.2#↑ {{DamageSmall}}공격력 배율 x1.1#{{CurseCursedSmall}} 스테이지 진입 시 저주에 걸리지 않았을 경우 10%의 확률로 저주에 걸립니다.",
			Name = "저주받은 펜던트",
			QuoteDesc = "",
		},
		[Trinkets.shattered_moonrock] = {
			Description = "{{Collectible"..Items.fatal_attraction.."}} 스테이지 진입 시 Fatal Attraction의 능력치 증감 선택지가 2개 나타납니다.#{{Collectible"..Items.fatal_attraction.."}}Fatal Attraction 소지 시 능력치 감소량 -2.5%p",
			Name = "조각난 월석",
			QuoteDesc = "",
		},
		[Trinkets.white_candle] = {
			Description = "↑ 스테이지 입장 시 축복 확률 +5%",
			Name = "하얀 양초",
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
		if wakaba and wakaba.intversion and wakaba.intversion >= 10300 then
			wakaba.descriptions["ko_kr"].collectibles[itemID] = {
				targetMod = "AOIGodmodeAchieved",
				itemName = itemdesc.Name,
				description = itemdesc.Description,
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
				targetMod = "AOIGodmodeAchieved",
				itemName = itemdesc.Name,
				description = itemdesc.Description,
				queueDesc = itemdesc.QuoteDesc,
			}
		end
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

	return {
		birthright = BirthrightDesc,
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
		cards = CardDesc,
		pills = PillDesc,
	}

end