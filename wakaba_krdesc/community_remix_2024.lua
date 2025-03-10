
if communityRemix then

	EID._currentMod = "Community Remix"

	local Items = communityRemix.CollectibleType
	local Trinkets = communityRemix.TrinketType
	local Cards = communityRemix.Card

	local CharacterDesc = {
		[communityRemix.PlayerType.PLAYER_ADAM] = {
			Name = "Adam",
			Description = "",
			Detailed = ""
				.. "#최초로 태어난 사람입니다. 뱀의 꾀에 빠져 선악과를 먹고 동산에 쫒겨나며 저주를 받았습니다."
				.. "#{{Collectible"..Items.COLLECTIBLE_THE_APPLE.."}} 시작 아이템 : 선악과"
				.. "",
			Birthright = "{{Collectible"..Items.COLLECTIBLE_THE_APPLE.."}} {{ColorWhite}}흰색 모드{{CR}}: 움직이지 않을 때 {{ShotspeedSmall}}+0.34, {{RangeSmall}}+2, 조준 보정#{{Collectible"..Items.COLLECTIBLE_THE_APPLE.."}} {{ColorRed}}빨간색 모드{{CR}}: 공격 중이지 않을 때 {{SpeedSmall}}+1",
			QuoteDesc = "???",
		},
		[communityRemix.PlayerType.PLAYER_ABEL] = {
			Name = "Abel",
			Description = "{{Collectible421}} 공격키를 3초 이상 누르면 충전되며 공격키를 떼면 매혹 방귀를 뀌며 주변의 적에게 5의 피해를 줍니다.",
			Detailed = ""
				.. "#아담의 아들 중 하나입니다. 처음으로 죽는 기구한 운명을 가졌습니다."
				.. "#{{Collectible421}} 공격키를 3초 이상 누르면 충전되며 공격키를 떼면 매혹 방귀를 뀌며 주변의 적에게 5의 피해를 줍니다."
				.. "#{{Collectible421}} 시작 아이템 : 강낭콩"
				.. "",
			Birthright = "방귀를 여러 번 충전 및 발사할 수 있습니다. (최대 10회)",
			QuoteDesc = "???",
		},
		[communityRemix.PlayerType.PLAYER_ADAM_B] = {
			Name = "Tainted Adam",
			Description = "",
			Detailed = "",
			Birthright = "",
			QuoteDesc = "",
		},
		[communityRemix.PlayerType.PLAYER_ABEL_B] = {
			Name = "Tainted Abel",
			Description = "",
			Detailed = "",
			Birthright = "",
			QuoteDesc = "",
		},
		[communityRemix.PlayerType.PLAYER_DOPLE] = {
			Name = "Dople",
			Description = "",
			Detailed = "",
			Birthright = "",
			QuoteDesc = "",
		},
	}

	local CollectibleDesc = {
		[Items.COLLECTIBLE_THE_APPLE] = {
			Description = "사용 시 사과의 색상을 바꿉니다.#흰색일 때:#↑ {{TearsSmall}}눈물 딜레이 배율 x0.75#↓ {{DamageSmall}}공격력 배율 x0.75#↑ {{LuckSmall}}행운 +5#↑ {{SpeedSmall}}이동속도 +0.2#↓ {{ShotspeedSmall}}탄속 -0.2#↑ {{RangeSmall}}사거리 +0.8#빨간색일 때:#↑ {{DamageSmall}}공격력 배율 x1.75#↓ {{TearsSmall}}눈물 딜레이 배율 x1.4#↓ {{SpeedSmall}}이동속도 -0.3#↑ {{ShotspeedSmall}}탄속 +0.2#↓ {{RangeSmall}}사거리 -0.8",
			Name = "선악과",
			QuoteDesc = "궁극의 희생",
		},

		[Items.COLLECTIBLE_THE_BOOK_OF_SORROW] = {
			Description = "{{Timer}} 사용 시 그 방에서:#↑ {{TearsSmall}}연사 +0.8#↑ {{ShotspeedSmall}}탄속 +0.16#↑ {{LuckSmall}}행운 +5",
			Name = "고독의 책",
			QuoteDesc = "읽고 펑펑 울기",
		},

		[Items.COLLECTIBLE_CHILLY_BEAN] = {
			Description = "{{Freezing}} 사용 시 주변의 적에게 14의 빙결 피해를 줍니다.",
			Name = "칠리 콩",
			QuoteDesc = "얼음 방귀",
		},

		[Items.COLLECTIBLE_CRYOBOMBS] = {
			Description = "↑ {{Bomb}}폭탄 +5#{{Freezing}} 폭발이 적에게 빙결 피해를 줍니다.",
			Name = "얼음 폭탄",
			QuoteDesc = "얼려버리는 폭탄 +5개",
		},

		[Items.COLLECTIBLE_COUNTERFEIT_DOLLAR] = {
			Description = "↑ {{Coin}}동전 +100#패널티 피격 시 동전 0~2개를 잃습니다.",
			Name = "위조 지폐",
			QuoteDesc = "",
		},

		[Items.COLLECTIBLE_MAXS_HEAD] = {
			Description = "↑ {{DamageSmall}}공격력 +1#↑ {{DamageSmall}}공격력 배율 x1.25#↑ {{SpeedSmall}}이동속도 +0.16",
			Name = "맥스의 머리",
			QuoteDesc = "공격력 + 속도 증가",
		},

		[Items.COLLECTIBLE_MARK_OF_CAIN] = {
			Description = "↑ {{DamageSmall}}공격력 배율 x1.5#↑ {{TearsSmall}}눈물 딜레이 배율 x0.77#!!! {{Collectible188}}Abel이 모든 배열에 등장합니다.",
			Name = "카인의 증표",
			QuoteDesc = "형제의 사랑",
		},

		[Items.COLLECTIBLE_BOX_OF_WIRES] = {
			Description = "10%의 확률로 전류 눈물이 나갑니다.#전류 눈물이 떠다닐 때 주변의 적에게 공격력 x0.5의 피해를 줍니다.#{{LuckSmall}} 행운 10+일 때 100%",
			Name = "선이 든 상자",
			QuoteDesc = "전류 눈물",
		},

		[Items.COLLECTIBLE_MORTAL_COIL] = {
			Description = "↑ {{BlackHeart}}블랙하트 +1#!!! {{HalfHeart}}빨간하트가 반칸 이하일 때:#방 클리어 시 10%의 확률로 {{SoulHeart}}소울하트 혹은 {{BlackHeart}}블랙하트를 추가로 드랍합니다.#{{LuckSmall}} 행운 10+일 때 100%",
			Name = "모탈 코일",
			QuoteDesc = "벼랑 끝",
		},

		[Items.COLLECTIBLE_TACO] = {
			Description = "↑ {{Heart}}최대 체력 +1#↑ {{Heart}}빨간하트 +1#↑ {{SpeedSmall}}이동속도 +0.16#↑ {{RangeSmall}}사거리 +1.5#↑ {{DamageSmall}}공격력 배율 x1.25#↑ {{ShotspeedSmall}}탄속 +0.16#↑ {{LuckSmall}}행운 +1#↑ {{TearsSmall}}눈물 딜레이 배율 x0.8",
			Name = "타코",
			QuoteDesc = "모든 능력치 증가 XD",
		},

		[Items.COLLECTIBLE_SNAKE_EYES] = {
			Description = "{{DevilRoom}} 사용 시 그 방의 아이템을 전부 악마방 아이템으로 바꿉니다. (거래 필요)",
			Name = "뱀의 눈",
			QuoteDesc = "운명을 바꾸는 능력...?",
		},

		[Items.COLLECTIBLE_THE_RULER] = {
			Description = "↑ {{TearsSmall}}눈물 딜레이 배율 x0.77#↑ {{RangeSmall}}사거리 +1.5",
			Name = "자",
			QuoteDesc = "공격 속도 + 사거리 증가",
		},

		[Items.COLLECTIBLE_VOODOO_PIN] = {
			Description = "25%의 확률로 피해를 막아줍니다.#피격 시 효과는 그대로 발동됩니다.",
			Name = "부두 침",
			QuoteDesc = "헛통증",
		},

		[Items.COLLECTIBLE_BOWL_O_BEANS] = { -- TODO
			Description = "사용 시 랜덤 콩 액티브를 발동합니다.",
			Name = "콩이 든 그릇",
			QuoteDesc = "마법의 과일",
		},

		[Items.COLLECTIBLE_MUSTY_MUSH] = {
			Description = "↑ {{BlackHeart}}블랙하트 +3#↓ {{SpeedSmall}}이동속도 -0.16#↓ {{TearsSmall}}눈물 딜레이 배율 x1.125#↓ {{DamageSmall}}공격력 배율 x0.875#↓ {{RangeSmall}}사거리 -0.28#↓ {{ShotspeedSmall}}탄속 -0.16#↓ {{LuckSmall}}행운 -1",
			Name = "곰팡이 버섯",
			QuoteDesc = "악함 증가 + 모든 능력치 감소",
		},

		[Items.COLLECTIBLE_OCCAMS_RAZOR] = {
			Description = "{{BrokenHeart}} 사용 시 부서진하트 1개를 추가하며 아래 효과 적용;#↑ {{SpeedSmall}}이동속도 +0.09#↑ {{DamageSmall}}공격력 배율 x1.09#↑ {{ShotspeedSmall}}탄속 +0.05#↑ {{LuckSmall}}행운 +0.91#↑ {{TearsSmall}}눈물 딜레이 배율 x0.94",
			Name = "오캄의 면도날",
			QuoteDesc = "깎아내리기",
		},

		[Items.COLLECTIBLE_PATIENT_ZERO] = {
			Description = "{{Charm}} 접촉한 적을 매혹시킵니다.#{{Charm}} 매혹된 적이 다른 적 접촉 시 그 적도 매혹시킵니다.",
			Name = "페이션트 제로",
			QuoteDesc = "사랑의 터치",
		},

		[Items.COLLECTIBLE_THE_HIVE] = {
			Description = "자폭 파리를 공격키로 조종할 수 있습니다.#방 입장 시 및 방 클리어 시 자폭 파리를 최소 8마리까지 보충합니다.",
			Name = "하이브",
			QuoteDesc = "딥테트라 소나타",
		},

		[Items.COLLECTIBLE_FISH_HOOK] = {
			Description = "↑ {{TearsSmall}}눈물 딜레이 배율 x0.77#↑ {{ShotspeedSmall}}탄속 +0.16",
			Name = "낚시 바늘",
			QuoteDesc = "공격 속도 증가",
		},

		[Items.COLLECTIBLE_GUMMY_BEAR] = {
			Description = "↑ {{Heart}}최대 체력 +1#↑ {{Heart}}빨간하트 +1#↑ {{SpeedSmall}}이동속도 +0.16#↑ {{RangeSmall}}사거리 +1.5#↑ {{DamageSmall}}공격력 배율 x1.25#↑ {{ShotspeedSmall}}탄속 +0.16#↑ {{LuckSmall}}행운 +1#↑ {{TearsSmall}}눈물 딜레이 배율 x0.8#캐릭터의 크기가 작아집니다.",
			Name = "곰돌이 젤리",
			QuoteDesc = "모든 능력치 증가",
		},

		[Items.COLLECTIBLE_SPICE] = {
			Description = "사용 시 75%의 확률로 그 방에서 모든 능력치를 증가시키거나;#!!! 25%의 확률로 영구적으로 감소합니다.",
			Name = "스파이스",
			QuoteDesc = "모든 능력치 증가...?",
		},

		[Items.COLLECTIBLE_HEARTACHE] = {
			Description = "{{HalfSoulHeart}} 방 클리어 시 소울/블랙하트가 반칸일 때 1칸으로 채워줍니다.",
			Name = "심장앓이",
			QuoteDesc = "심장 생성기",
		},

		[Items.COLLECTIBLE_POTTY] = {
			Description = "사용 시 3~5마리의 아군 Dip을 소환합니다.",
			Name = "항아리",
			QuoteDesc = "똥이 든 항아리",
		},

		[Items.COLLECTIBLE_MOLOTOV_COCKTAIL] = {
			Description = "사용 시 공격하는 방향으로 공격력 25~50의 칵테일을 던집니다.#{{Slow}} 던진 자리에 적을 느려지게 하는 장판이 깔립니다.",
			Name = "몰토브 칵테일",
			QuoteDesc = "불꽅이 든 병",
		},

		[Items.COLLECTIBLE_PB_J] = {
			Description = "↑ {{Heart}}최대 체력 +1#↑ {{Heart}}빨간하트 +1",
			Name = "브런치",
			QuoteDesc = "체력 증가",
		},

		[Items.COLLECTIBLE_ADAMS_RIB] = {
			Description = "{{Player5}} Eve 캐릭터가 2p 플레이어로 소환됩니다.#!!! Eve 캐릭터도 아이템을 획득할 수 있으며 사망 시 획득한 아이템({{ColorRed}}루트 진행 아이템 포함{{CR}})이 영구적으로 사라집니다.",
			Name = "아담의 늑골",
			QuoteDesc = "상상 속의 여친",
		},

		[Items.COLLECTIBLE_BENADRYL] = {
			Description = "{{Pill}} 알약을 2개 드랍합니다.#{{Pill}} 알약 사용 시 I'm Drowsy 효과를 추가로 발동합니다.",
			Name = "베나드릴",
			QuoteDesc = "나른해...",
		},

		[Items.COLLECTIBLE_BLOOD_MONEY] = {
			Description = "{{Coin}} 보스 처치 시 동전을 3~4개 드랍합니다.",
			Name = "피묻은 지폐",
			QuoteDesc = "죽음을 원해",
		},

		[Items.COLLECTIBLE_MOMS_CELLPHONE] = {
			Description = "사용 시 Dople이 2p 플레이어로 소환됩니다.#Dople 캐릭터는 아이템을 집을 수 없으나 능력치와 아이템이 랜덤으로 정해집니다.",
			Name = "엄마의 삐삐",
			QuoteDesc = "친구의 전화기",
		},

		[Items.COLLECTIBLE_MYSTERY_MEAT] = {
			Description = "↑ {{Heart}}최대 체력 +1#↑ {{Heart}}빨간하트 +1#!!! 아래 중 2개 적용:#↑ {{SpeedSmall}}이동속도 +0.16#↑ {{TearsSmall}}눈물 딜레이 배율 x0.77#↑ {{DamageSmall}}공격력 배율 x1.25#↑ {{ShotspeedSmall}}탄속 +0.16#↑ {{LuckSmall}}행운 +1#↑ {{RangeSmall}}사거리 +1.5",
			Name = "수상한 고기",
			QuoteDesc = "체력 + ??? 증가",
		},

		[Items.COLLECTIBLE_PUMPKIN_MASK] = {
			Description = "↑ {{BlackHeart}}블랙하트 +1#{{Fear}} 적 처치 시 다른 적을 25%의 확률로 공포에 걸리게 합니다.#공포에 걸린 적은 모든 피해를 2배로 받습니다.",
			Name = "잭-오-랜턴",
			QuoteDesc = "악함 증가 + 두려워해라",
		},

		[Items.COLLECTIBLE_OPHIUCHUS] = {
			Description = "↑ {{BlackHeart}}블랙하트 +1#아군 Needle을 소환합니다.#모든 Needle 몬스터들이 항상 아군이 됩니다.#방 클리어 시 50%의 확률로 아군 Needle을 추가로 소환합니다.",
			Name = "뱀주인자리",
			QuoteDesc = "핀과 니들",
		},

		[Items.COLLECTIBLE_FORBIDDEN_SEED] = {
			Description = "↑ {{Bomb}}폭탄 +5#적이 폭탄을 향해 공격합니다.",
			Name = "금단의 씨앗",
			QuoteDesc = "매혹적인 폭탄 +5개",
		},

		[Items.COLLECTIBLE_GEODE] = {
			Description = "{{Rune}} 사용 시 임의의 룬을 지급합니다.",
			Name = "정동석",
			QuoteDesc = "충전식 룬 생성기",
		},

		[Items.COLLECTIBLE_COUSIN_CLETUS] = {
			Description = "공격하는 방향으로 공격력 1.75의 매우 빠른 눈물을 발사합니다.",
			Name = "이웃 클레투스",
			QuoteDesc = "영원한 친구",
		},

		[Items.COLLECTIBLE_BLUE_WAFFLE] = {
			Description = "↑ {{TearsSmall}}눈물 딜레이 배율 x0.5#↓ 눈물 정확도 감소",
			Name = "푸른 와플",
			QuoteDesc = "공격 속도 증가 + 정확도 감소",
		},

		[Items.COLLECTIBLE_BEAST_OF_PROPHECY] = {
			Description = "!!! {{HalfHeart}}빨간하트가 반칸 이하일 때: #↑ {{SpeedSmall}}이동속도 +0.32#↑ {{DamageSmall}}공격력 배율 x1.5#↓ {{TearsSmall}}눈물 딜레이 배율 x1.5#공격이 3발로 나갑니다.",
			Name = "짐승의 예언",
			QuoteDesc = "저주 증가",
		},

		[Items.COLLECTIBLE_CONQUEROR_BABY] = {
			Description = "캐릭터를 따라다니며 적의 탄환을 막아줍니다.#{{Collectible160}} 탄환을 막을 시 10% 확률로 적 주변에 빛줄기를 5번 떨어트립니다.",
			Name = "지배자 아기",
			QuoteDesc = "열정적인 친구",
		},

		[Items.COLLECTIBLE_THE_PEBBLE] = {
			Description = "사용 시 공격방향으로 적에게 1의 피해를 주는 돌덩이를 던집니다.#{{Blank}} (0.5%의 확률로 맞춘 적 즉사)",
			Name = "돌덩이",
			QuoteDesc = "",
		},

		[Items.COLLECTIBLE_MAXS_PAW] = {
			Description = "{{DamageSmall}} 사용 시 최대 체력 1칸을 소모하여 공격력 +25%",
			Name = "맥스의 발",
			QuoteDesc = "공격력 전환기",
		},

		[Items.COLLECTIBLE_MAXS_TAIL] = {
			Description = "↑ {{DamageSmall}} 이동속도에 따라 캐릭터의 배율이 증가합니다. (최대 x2)",
			Name = "맥스의 꼬리",
			QuoteDesc = "이동속도 = 공격력",
		},

		[Items.COLLECTIBLE_TAMMYS_PAW] = {
			Description = "사용 시 최대 체력 1칸을 4~6개의 픽업으로 바꿉니다.",
			Name = "태미의 발",
			QuoteDesc = "픽업 전환기",
		},

		[Items.COLLECTIBLE_TAMMYS_TAIL] = {
			Description = "{{TearsSmall}} 적 처치 시 서서히 사라지는 연사가 증가합니다.",
			Name = "태미의 꼬리",
			QuoteDesc = "그들을 위해 울어라",
		},

		[Items.COLLECTIBLE_SINNERS_SCARS] = {
			Description = "{{CurseRoom}} 저주방 입장 시 마법진이 생성되며 마법진 접촉 시 그 스테이지에서 아래 효과 발동:#↑ {{BlackHeart}}블랙하트 +1#↑ {{DamageSmall}}공격력 배율 x1.33",
			Name = "죄인의 상처",
			QuoteDesc = "핏투성이 속죄", -- TODO
		},

		[Items.COLLECTIBLE_AKEDAH] = {
			Description = "↑ {{Heart}}최대 체력 +3#↑ {{Heart}}빨간하트 +1#↑ {{SpeedSmall}}이동속도 +0.32#↑ {{DamageSmall}}공격력 배율 x1.75#↑ {{TearsSmall}}눈물 딜레이 배율 x0.8#비행 능력을 얻습니다.#{{Warning}} 일정 간격으로 캐릭터의 위치에 엄마발이 떨어집니다.",
			Name = "아케다",
			QuoteDesc = "아이작의 번제",
		},

		[Items.COLLECTIBLE_BONER_BABY] = {
			Description = "공격하는 방향으로 공격력 3.5의 뼈다귀 눈물을 발사합니다.",
			Name = "뼈다귀 아기",
			QuoteDesc = "딱딱한 친구",
		},

		[Items.COLLECTIBLE_MISERICORDE] = {
			Description = "적의 체력이 50% 미만일 때 즉사시킵니다.#{{Blank}} (보스의 경우 25%)",
			Name = "마지막 일격",
			QuoteDesc = "달콤한 릴리스",
		},

		[Items.COLLECTIBLE_OVEN_MITT] = {
			Description = "↑ {{Bomb}}폭탄 +5#폭탄 키를 꾹 눌러 폭탄을 던질 수 있습니다.",
			Name = "오븐 장갑",
			QuoteDesc = "뜨거운 감자",
		},

		[Items.COLLECTIBLE_D3] = {
			Description = "사용 시 그 방의 장신구를 다른 장신구로 바꿉니다.",
			Name = "3면 주사위",
			QuoteDesc = "장신구를 바꾸는 능력",
		},

		[Items.COLLECTIBLE_MOMS_EYELASHES] = {
			Description = "↓ {{RangeSmall}}사거리 -3.5#↓ {{DamageSmall}}공격력 배율 x0.5#공격이 5발로 나갑니다.",
			Name = "엄마의 눈썹",
			QuoteDesc = "펜타 샷",
		},

		[Items.COLLECTIBLE_COCONUT_MILK] = {
			Description = "↓ {{ShotspeedSmall}}탄속 -0.16#눈물이 더 이상 떨어지지 않으며 사거리에 따라 눈물이 일정 시간 떠 있게 바뀝니다.",
			Name = "코코넛 우유",
			QuoteDesc = "영원한 눈물",
		},

		[Items.COLLECTIBLE_MENORAH] = {
			Description = "피격 시 공격 발사 수가 하나씩 증가하나 연사 배율이 감소합니다. (최대 7)#{{ColorGray}}({{TearsSmall}}딜레이배율:(0.5)*촛불수)#7개인 상태에서 피격 시 불꽃을 6방향으로 발사하며 1개로 초기화됩니다.",
			Name = "촛대",
			QuoteDesc = "눈물 복제기",
		},

		[Items.COLLECTIBLE_CLAY_DREIDEL] = {
			Description = "사용 시 25% 확률로 방 안의 모든 아이템 및 픽업을 4배로 복사하며 복사 실패 시 모두 없앱니다.",
			Name = "점토 팽이",
			QuoteDesc = "승자 독식",
		},

		[Items.COLLECTIBLE_COMMUNION_WINE] = {
			Description = "{{Collectible108}} 사용 시 {{HolyMantleSmall}}보호막을 1개 지급하며 그 방에서 캐릭터가 받는 피해를 절반으로 줄여줍니다.",
			Name = "만찬 와인",
			QuoteDesc = "내 피를 마시게나",
		},

		[Items.COLLECTIBLE_THE_BOOK_OF_LOVE] = {
			Description = "사용 시 작은 아이작 패밀리어를 5~6마리 소환합니다.",
			Name = "사랑의 책",
			QuoteDesc = "충전식 친구",
		},

		[Items.COLLECTIBLE_HOW_TO_JUMP_2] = {
			Description = "사용 시 이동 방향으로 점프합니다.#점프 중 사용 시 아래로 내려찍습니다.#적을 밟아서 연속적으로 점프할 수 있습니다.",
			Name = "점프 하는 법 2.0",
			QuoteDesc = "이제 현대 기술도 같이",
		},

		[Items.COLLECTIBLE_TULIP] = {
			Description = "{{Timer}} 사용 시 그 방에서:#↑ {{DamageSmall}}공격력 배율 x1.5#{{Collectible257}} 적에게 화상을 입히는 공격이 나가며 확률적으로 폭발합니다.#{{LuckSmall}} 행운 13+ 100%",
			Name = "튤립",
			QuoteDesc = "일시적 꽃 능력",
		},

		[Items.COLLECTIBLE_TOOTHPASTE] = {
			Description = "{{Freezing}} 접촉한 적을 즉시 얼립니다.",
			Name = "치약",
			QuoteDesc = "차가운 손길",
		},

		[Items.COLLECTIBLE_CEREMONIAL_BLADE] = {
			Description = "적 처치 시 가장 가까운 적에게 피해를 주는 칼을 소환합니다.",
			Name = "희생의 단검",
			QuoteDesc = "피를 원해!",
		},

		[Items.COLLECTIBLE_DONKEY_JAWBONE] = {
			Description = "피격 시 뼈를 휘둘러 주변의 적에 넉백 피해 + 탄환을 막아줍니다.",
			Name = "당나귀 뼈",
			QuoteDesc = "내게 오라!",
		},

		[Items.COLLECTIBLE_GOAT_HEART] = {
			Description = "{{DevilChanceSmall}} 최대 체력이 적을수록 악마방 확률 증가",
			Name = "염소의 심장",
			QuoteDesc = "피의 희생",
		},

		[Items.COLLECTIBLE__NULL] = {
			Description = "보스방을 제외한 모든 방의 타입을 뒤섞습니다.",
			Name = "",
			QuoteDesc = "",
		},

		[Items.COLLECTIBLE_GACHA_BOMBS] = {
			Description = "↑ {{Bomb}}폭탄 +5#폭탄이 폭발할 때 확률적으로 랜덤 아군 몬스터를 소환합니다.",
			Name = "가챠 폭탄",
			QuoteDesc = "다 모으자! 폭탄 +5개",
		},

		[Items.COLLECTIBLE_DADS_SECRET] = {
			Description = "일급비밀방이 오류방으로 바뀝니다.",
			Name = "아빠의 작은 비밀",
			QuoteDesc = "누구한테도 말하지 마",
		},

		[Items.COLLECTIBLE_CRIMSON_STICK] = {
			Description = "↑ {{Bomb}}폭탄 +5#가능한 경우, 폭탄이 가까운 빨간 방을 열어줍니다.",
			Name = "붉은 막대기",
			QuoteDesc = "저 너머로 뚫기",
		},

		[Items.COLLECTIBLE_BUSTED_FLARE] = {
			Description = "6.7%의 확률로 눈물을 포물선으로 발사하며 무언가에 부딪힐 시 X자 방향으로 불길을 생성합니다.#{{LuckSmall}} 행운 15+일 때 100% 확률",
			Name = "고장난 플레어",
			QuoteDesc = "불꽃 폭탄",
		},

		[Items.COLLECTIBLE_TWIN_CANDLES] = {
			Description = "사용 시 8방향으로 빨간 불꽃과 파란 불꽃을 발사합니다.",
			Name = "쌍둥이 양초",
			QuoteDesc = "카스토르와 폴룩스",
		},

		[Items.COLLECTIBLE_MUDPIE] = {
			Description = "↑ {{Heart}}최대 체력 +1#↑ {{Heart}}빨간하트 +1#획득 시 랜덤 벌레류 장신구를 하나 획득합니다.#!!! 벌레류 장신구가 자동으로 흡수됩니다.",
			Name = "진흙 파이",
			QuoteDesc = "체력 증가 + 달콤한 벌레",
		},

		[Items.COLLECTIBLE_CLOUD_NINE] = {
			Description = "스테이지 진입 시 소지 중인 패시브 아이템 하나를 소환합니다.#!!! 11%의 확률로 Cloud Nine이 삭제됨",
			Name = "클라우드 9",
			QuoteDesc = "할 수 있다면 말이지...",
		},

		[Items.COLLECTIBLE_SALINE_BAG] = {
			Description = "↑ {{TearsSmall}}연사(상한) +1#캐릭터의 크기가 커집니다.",
			Name = "식염수 팩",
			QuoteDesc = "공격 속도 + 크기 증가",
		},

		[Items.COLLECTIBLE_GREEN_CANDLE] = {
			Description = "{{Poison}} 캐릭터 주변의 적을 중독시킵니다.",
			Name = "초록 양초",
			QuoteDesc = "역겨운 광채",
		},

		[Items.COLLECTIBLE_MOLDYD6] = {
			Description = "사용 시 그 방의 아이템을 썩은 배열의 아이템으로 바꿉니다. (버섯, 파리류 중심)",
			Name = "썩은 주사위",
			QuoteDesc = "너의 으..음...",
		},

		[Items.COLLECTIBLE_MANDRAKE] = {
			Description = "캐릭터를 따라다니며 적의 탄환을 막아줍니다.#{{Collectible35}} 탄환을 막을 시 5% 확률로 방 안의 모든 적에게 200의 혼란 피해를 입힙니다.",
			Name = "맨드레이크",
			QuoteDesc = "",
		},

		[Items.COLLECTIBLE_OLD_BIB] = {
			Description = "↑ {{Heart}}최대 체력 +1#↑ {{HealingRed}}빨간하트 +1#피격 시 5%의 확률로 소지 중인 음식류 아이템을 제거 후 드랍합니다.{{LuckSmall}} 행운 20+일때 100%",
			Name = "낡은 턱받이",
			QuoteDesc = "체력 증가 + 계속 갖고 있지 못해",
		},

		[Items.COLLECTIBLE_POWER_BALL] = {
			Description = "↑ {{TearsSmall}}눈물 딜레이 배율 x0.9#↑ {{DamageSmall}}공격력 배율 x1.2",
			Name = "파워볼 마약",
			QuoteDesc = "공격력 + 연사 증가",
		},

		[Items.COLLECTIBLE_RUBBER_DUCKY] = {
			Description = "↑ {{BlackHeart}}블랙하트 +3#↑ {{LuckSmall}}행운 +1",
			Name = "러버덕",
			QuoteDesc = "행운 + 악의 증가",
		},

		[Items.COLLECTIBLE_CROISSANT] = {
			Description = "↑ {{Heart}}최대 체력 +1#↑ {{HealingRed}}빨간하트 +1#방 입장 시25%의 확률로 몬스터가 더 적게 등장합니다.",
			Name = "크로와상",
			QuoteDesc = "체력 증가 + 도전 회피",
		},

		[Items.COLLECTIBLE_BURNT_BABY] = {
			Description = "{{Burning}} 공격하는 방향으로 공격력 3.5의 화염 눈물을 발사합니다.#!!! 10% 확률로 적 명중 시 폭발합니다.",
			Name = "타버린 아기",
			QuoteDesc = "다 불타버려",
		},

		[Items.COLLECTIBLE_MAGIC_POWDER] = {
			Description = "↑ {{SpeedSmall}}이동속도 +0.32#↑ {{ShotspeedSmall}}탄속 +0.32#{{Pill}} 알약을 2개 드랍합니다.#{{Pill}} 알약 사용 시 I'm Excited 효과를 추가로 발동합니다.",
			Name = "마법의 파우더",
			QuoteDesc = "신나!",
		},

		[Items.COLLECTIBLE_ESSENTIAL_OIL] = {
			Description = "{{UnknownHeart}} 랜덤 하트 4개를 드랍합니다.#{{SoulHeart}} 초과 회복 시 소울하트를 회복합니다.",
			Name = "에센셜 오일",
			QuoteDesc = "또 다른 처방",
		},

		[Items.COLLECTIBLE_PLUM_MANIFESTO] = {
			Description = "{{Charm}} 근처의 적에게 5초동안 피해를 주지 않으면 아군으로 바뀝니다.#{{Heart}} 방 클리어 시 아군 몬스터의 체력을 회복합니다.",
			Name = "플럼 매니페스토",
			QuoteDesc = "싸우지 말고 서로 사랑하자 - by 플럼이",
		},

		[Items.COLLECTIBLE_LMAOBOX] = {
			Description = "",
			Name = "",
			QuoteDesc = "",
		},

		[Items.COLLECTIBLE_THE_ROT] = {
			Description = "",
			Name = "",
			QuoteDesc = "",
		},

		[Items.COLLECTIBLE_BOOK_OF_VIRTUES] = {
			Description = "",
			Name = "",
			QuoteDesc = "",
		},

		[Items.COLLECTIBLE_ADAMBAPPLE] = {
			Description = "",
			Name = "",
			QuoteDesc = "",
		},
	}
	local TrinketDesc = {
		[Trinkets.TRINKET_FIG_LEAF] = {
			Description = "피격 시 발생하는 패널티를 막아줍니다."
			.. "#!!! {{Trinket145}}/{{Collectible577}}/{{Collectible567}}...",
			Name = "무화과 잎",
			QuoteDesc = "너의 믿음을 지키리라",
		},

		[Trinkets.TRINKET_INFANTICIDE] = {
			Description = "!!! 일회용#{{MotherSmall}} 공격하는 방향으로 칼을 날릴 수 있으며 특정 스테이지로 가는 빨간 문을 열 수 있습니다.",
			Name = "존속살해",
			QuoteDesc = "안티버스",
		},

		[Trinkets.TRINKET_GABRIELS_HALO] = {
			Description = "{{AngelRoom}} 스테이지 입장 시 상점이 천사 상점으로 바뀝니다.",
			Name = "가브리엘의 광륜",
			QuoteDesc = "신성한 운명",
		},

		[Trinkets.TRINKET_INSANE_PENDANT] = {
			Description = "{{DamageSmall}} 공격력 배율 +100%#!!! 모든 캐릭터 피격이 2배로 들어옵니다.",
			Name = "인세인 펜던트",
			QuoteDesc = "아주 어려워!",
		},

		[Trinkets.TRINKET_PIN_WORM] = {
			Description = "눈물을 곡선형으로 발사합니다.",
			Name = "핀 벌레",
			QuoteDesc = "푸후!",
		},

		[Trinkets.TRINKET_SUGAR] = {
			Description = "{{Heart}} 알약 사용 시 빨간하트를 1칸 회복합니다.#{{HalfSoulHeart}} 빨간하트가 꽉 차있을 때 소울하트 반칸을 드랍합니다.",
			Name = "설탕 한 숟가락",
			QuoteDesc = "약 잘 먹기",
		},

		[Trinkets.TRINKET_SUPPOSITORY] = {
			Description = "알약 사용 시 아군 Dip을 2~4마리 소환합니다.",
			Name = "좌약",
			QuoteDesc = "뭔가 엄청난 게 들어와",
		},

		[Trinkets.TRINKET_BLOODY_FEATHER] = {
			Description = "{{Collectible160}} 피격 시 적 주변에 빛줄기를 5번 떨어트립니다.",
			Name = "피 묻은 깃털",
			QuoteDesc = "신성한 복수",
		},

		[Trinkets.TRINKET_PENNY_ON_A_STRING] = {
			Description = "{{Coin}} 12.5%의 확률로 슬롯머신 사용 시 동전을 소모하지 않습니다.#!!! 0{{Coin}}일 때 슬롯머신 사용 시 25%의 확률로 장신구가 제거됩니다.",
			Name = "묶인 페니",
			QuoteDesc = "속임수 부자",
		},

		[Trinkets.TRINKET_SHARP_PENNY] = {
			Description = "{{Collectible486}} 동전을 주울 시 피격 시 효과를 발동합니다.",
			Name = "뾰족한 페니",
			QuoteDesc = "고통 부자",
		},

		[Trinkets.TRINKET_DARK_PENNY] = {
			Description = "동전 획득 시 17% 확률로 {{HalfSoulHeart}}블랙하트를 반칸 드랍합니다.",
			Name = "암흑 페니",
			QuoteDesc = "그림자 부자",
		},

		[Trinkets.TRINKET_SILVER_PADLOCK] = {
			Description = "{{Key}} 열쇠 소모 시 33%의 확률로 열쇠를 드랍합니다.",
			Name = "은색 자물쇠",
			QuoteDesc = "중복성 해답",
		},

		[Trinkets.TRINKET_GILDED_FUSE] = {
			Description = "{{Coin}} 폭탄이 터지면 동전 1~3개를 드랍합니다.",
			Name = "도금 퓨즈",
			QuoteDesc = "불협화음",
		},

		[Trinkets.TRINKET_ROTTEN_PADLOCK] = {
			Description = "{{Key}} 열쇠 소모 시 자폭 파리 4마리를 소환합니다.",
			Name = "썩은 자물쇠",
			QuoteDesc = "역병의 해답",
		},

		[Trinkets.TRINKET_BURNT_FUSE] = {
			Description = "{{Bomb}} 폭탄이 터지면 33%의 확률로 폭탄을 드랍합니다.",
			Name = "타버린 퓨즈",
			QuoteDesc = "불협화음",
		},

		[Trinkets.TRINKET_GAME_SQUID] = {
			Description = "{{Slow}} 피격 시 적을 느려지게 하는 장판을 생성합니다.",
			Name = "",
			QuoteDesc = "꾸웩!",
		},

		[Trinkets.TRINKET_LUCKY_CHARM] = {
			Description = "슬롯머신 사용 시 6회를 추가로 사용합니다.",
			Name = "럭키 챰",
			QuoteDesc = "잭팟!",
		},

		[Trinkets.TRINKET_BETHS_VIRTUE] = {
			Description = "소울하트 및 블랙하트를 집으면 해당 하트에 따른 불꽃을 소환합니다.",
			Name = "베타니의 미덕",
			QuoteDesc = "덕담의 심장",
		},

		[Trinkets.TRINKET_HAND_ME_DOWNS] = {
			Description = "획득 후 {{ColorOrange}}버리거나 교체하지 않고{{CR}} 게임 종료 시 다음 게임에서 랜덤한 아이템을 하나 들고 시작합니다.",
			Name = "헌옷",
			QuoteDesc = "오랫동안 잊혀질 운명",
		},

		[Trinkets.TRINKET_BUM_MUG] = {
			Description = "거지가 보상을 줄 때 항상 아이템을 드랍합니다.",
			Name = "거지 머그컵",
			QuoteDesc = "단 1페니",
		},

		[Trinkets.TRINKET_BYGONE] = {
			Description = "{{SoulHeart}} 모든 빨간하트 픽업이 소울하트 픽업으로 교체됩니다.#{{BlackHeart}} 모든 1+1 하트가 블랙하트 픽업으로 교체됩니다.#!!! {{SuperSecretRoom}}일급비밀방에서는 무효과",
			Name = "사라져라!",
			QuoteDesc = "몸을 갈아버리기",
		},

		[Trinkets.TRINKET_DRINK_ME] = {
			Description = "캐릭터 크기가 작을수록 {{DamageSmall}}공격력 및 {{SpeedSmall}}이동속도 증가",
			Name = "특별한 물",
			QuoteDesc = "날 마셔줘",
		},

		[Trinkets.TRINKET_EAT_ME] = {
			Description = "캐릭터 크기가 클수록 {{DamageSmall}}공격력 및 {{SpeedSmall}}이동속도 증가",
			Name = "특별한 쿠키",
			QuoteDesc = "날 먹어줘",
		},

		[Trinkets.TRINKET_FORKED_TONGUE] = {
			Description = "{{Poison}} 방 입장 시 랜덤한 적을 8초간 중독시킵니다.#{{BlackHeart}}중독된 적 처치 시 10%의 확률로 블랙하트를 드랍합니다.",
			Name = "구부러진 혀",
			QuoteDesc = "쓰다쓴 모습",
		},

		[Trinkets.TRINKET_SHRUNKEN_HEAD] = {
			Description = "스테이지 진입 시 특별한 저주방이 더 자주 등장합니다.",
			Name = "시든 머리",
			QuoteDesc = "저주받았어...",
		},

		[Trinkets.TRINKET_MOMS_PUBE] = {
			Description = "",
			Name = "",
			QuoteDesc = "",
		},
	}

	local CardDesc = {
		[Cards.CARD_THE_COLD] = {
			Description = "{{Freezing}} 그 방의 적을 얼리거나 40의 둔화 피해를 줍니다.",
			Name = "I - 냉기",
			QuoteDesc = "눈처럼 차갑고 고요하리라",
		},

		[Cards.CARD_THE_SERVANT] = {
			Description = "사용 시 작은 아이작 패밀리어를 4~6마리 소환합니다.",
			Name = "II - 종신",
			QuoteDesc = "당신의 명령을 기다리리라",
		},

		[Cards.CARD_WISDOM] = {
			Description = "{{SuperSecretRoom}} 사용 시 일급비밀방으로 이동합니다.",
			Name = "III - 지혜",
			QuoteDesc = "당신의 지식이 강인함을 가져오리라",
		},

		[Cards.CARD_REPENTANCE] = {
			Description = "{{Collectible114}} 사용 시 그 방에서 공격이 칼 공격으로 바뀝니다.",
			Name = "IV - 회개",
			QuoteDesc = "반드시 기억하리라",
		},

		[Cards.CARD_ETERNITY] = {
			Description = "사용 시 {{EternalHeart}}이터널하트 +1, {{HolyMantleSmall}}보호막 +1",
			Name = "V - 영원",
			QuoteDesc = "영원히 축복받으리라",
		},

		[Cards.CARD_CORRUPTION] = {
			Description = "{{ErrorRoom}} 사용 시 오류방으로 이동합니다.",
			Name = "VI - 부패",
			QuoteDesc = "미지의 공간으로 이끌어가리라",
		},

		[Cards.CARD_IMMOLATION] = {
			Description = "{{CurseRoom}} 사용 시 저주방으로 이동합니다.#{{SacrificeRoom}} 저주방이 없을 경우, 희생방으로 이동합니다.",
			Name = "VII - 희생",
			QuoteDesc = "주를 향한 희생",
		},

		[Cards.CARD_WORSHIP] = {
			Description = "사용 시 50%의 확률로 그 방의 아이템을 소환하거나;#실패 시 캐릭터에게 2칸의 피해를 줍니다.",
			Name = "VIII - 숭배",
			QuoteDesc = "육체와 영혼을 바치리라",
		},

		[Cards.CARD_DISSENSION] = {
			Description = "{{Timer}} 사용 시 그 방에서:#↑ {{SpeedSmall}}이동속도 +0.32#↑ {{DamageSmall}}공격력 배율 x1.5#↓ {{TearsSmall}}눈물 딜레이 배율 x1.5#Triple shot",
			Name = "IX - 분쟁",
			QuoteDesc = "열광",
		},

		[Cards.CARD_THE_DAMNED] = {
			Description = "뼛조각을 10개 소환합니다.",
			Name = "X - 저주",
			QuoteDesc = "병자를 위한 십계명",
		},

		[Cards.CARD_OCCULT] = {
			Description = "{{DevilRoom}} 그 방의 아이템을 전부 악마방 아이템으로 바꿉니다. (거래 필요)",
			Name = "XI - 오컬트",
			QuoteDesc = "금단의 의식",
		},

		[Cards.RED_RUNE] = {
			Description = "",
			Name = "",
			QuoteDesc = "",
		},
	}

	for playerType, birthrightdesc in pairs(CharacterDesc) do
		EID:addCharacterInfo(playerType, birthrightdesc.Description, birthrightdesc.Name, "ko_kr")
		if InventoryDescriptions then
			EID:addEntity(InvDescEIDType.PLAYER, InvDescEIDVariant.DEFAULT, playerType, birthrightdesc.Name, birthrightdesc.Detailed, "ko_kr")
		end
		EID:addBirthright(playerType, birthrightdesc.Birthright, birthrightdesc.Name, "ko_kr")
	end
	for itemID, itemdesc in pairs(CollectibleDesc) do
		local desc = itemdesc.Description
		if itemdesc.StatusEffects then
			for _, eff in ipairs(itemdesc.StatusEffects) do
				itemdesc.Description = itemdesc.Description .. eff
			end
		end
		EID:addCollectible(itemID, desc, itemdesc.Name, "ko_kr")
		if itemdesc.Wisps then
			EID.descriptions["ko_kr"].bookOfVirtuesWisps[itemID] = itemdesc.Wisps
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
		targetMod = "Community Remix",
		characters = CharacterDesc,
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
		cards = CardDesc,
	}

end