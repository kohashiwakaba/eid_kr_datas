
if Retribution then

  EID._currentMod = "Retribution"
  --EID:setModIndicatorName("Retribution")
  local rtBirthrightDesc = {
		[Retribution.PLAYER_TYPE.ICARUS] = {
			Name = "Icarus",
			Description = "↓ 태양의 저주 : 모든 적이 강화되어서 등장합니다.#↑ 태양의 저주로 강화된 적의 체력이 33% 감소합니다.#{{Collectible"..Retribution.ITEMS.WAX_WING.."}} Wax Wing의 {{DamageSmall}}/{{TearsSmall}} 증가치가 2배로 증가합니다.",
			QuoteDesc = "젠장할 확률",
		},
		[Retribution.PLAYER_TYPE.MAMMON] = {
			Name = "Mammon",
			Description = "수상한 돌 모양 패밀리어를 소환합니다.#돌 모양 패밀리어 폭파 시 깨어나며 캐릭터의 공격력 x0.5의 공격을 자동으로 발사하며 돼지 동전을 대신 모아줍니다.",
			QuoteDesc = "석수",
		},
  }
  local rtCollectibleDesc = {
  	[Retribution.ITEMS.ARROW_OF_LIGHT] 		= {
  		Name = "빛의 화살",
  		QuoteDesc = "성숙하게 승천하라",
  		Description = "↑ {{ShotspeedSmall}}탄속 +0.5#↑ {{TearsSmall}}연사 +0.25#공격이 적을 더 강하게 밀쳐냅니다.#{{CurseDarknessSmall}}Darkness 저주 상태일 때 공격이 적을 관통합니다.",
  	},
  	[Retribution.ITEMS.AXOLOTL] 				= {
  		Name = "아홀로틀",
  		QuoteDesc = "난 단지 크리쳐일 뿐이라네",
  		Description = "공격하는 방향으로 공격력 3.5의 빠른 눈물을 발사합니다.#적의 탄환을 3번 막으면 기절하여 눈물을 발사할 수 없으나 그 위치에서 주기적으로 파란 자폭 파리를 소환합니다.#방 이동 시 다시 깨어납니다.",
  	},
  	[Retribution.ITEMS.AZAZELS_HORN] 			= {
  		Name = "아자젤의 뿔",
  		QuoteDesc = "광적인 검은 하트",
  		Description = "↑ {{BlackHeart}}블랙하트 +1#{{BlackHeart}}블랙하트 피격 시 블랙하트를 소진했을 때와 같은 효과를 발동합니다.",
  	},
  	[Retribution.ITEMS.BAD_APPLE] 				= {
  		Name = "썩은 사과",
  		QuoteDesc = "하나면 돼",
  		Description = '↑ {{TearsSmall}}연사 +0.6#공격 시 8% 방 안의 모든 눈물을 공격력 x0.5의 피해를 주는 "썩은 사과"로 바꿉니다.#사과 계열의 아이템과의 시너지 존재',
  	},
  	[Retribution.ITEMS.BAPTISMAL_SHELL] 		= {
  		Name = "세례수 껍질",
  		QuoteDesc = "세례의 영혼으로부터 태어나다",
  		Description = "8%의 확률로 맞으면 적을 약화된 형태로 바꾸는 공격이 나갑니다.#{{LuckSmall}} :행운 7+일 때 20%",
  	},
  	[Retribution.ITEMS.BAPTISMAL_FONT] 		= {
  		Name = "세례대",
  		QuoteDesc = "세례의 홍수",
  		Description = "사용 시 확률적으로 적을 약화된 형태로 바꿉니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.BAR_OF_SOAP] 			= {
  		Name = "세례 비누",
  		QuoteDesc = "불순물 제거",
  		Description = "↑ {{Heart}}최대 체력 +1#스테이지 진입 시 {{SoulHeart}}소울하트 +1",
  	},
  	[Retribution.ITEMS.BARON_FLY] 				= {
  		Name = "남작 파리",
  		QuoteDesc = "내 명예는 소중하다구",
  		Description = "캐릭터 주위를 돌며 적의 탄환을 막아줍니다.#적의 탄환을 5번 막을 때마다 작은 눈물 여러개를 흩뿌립니다.",
  	},
  	[Retribution.ITEMS.BEDBUG] 				= {
  		Name = "쿨쿨 파리",
  		QuoteDesc = "졸려...",
  		Description = "캐릭터의 주위에 있으며 적의 탄환을 막아줍니다.#적에 탄환을 막을 시 잠시동안 매우 빠른 속도로 돌아갑니다.",
  	},
  	[Retribution.ITEMS.BLACK_BOX] 				= {
  		Name = "블랙박스",
  		QuoteDesc = "무엇이 들었을까?",
  		Description = "!!! 소지 중일 때:#↑ {{LuckSmall}}행운 +4#사용 시 아이템, 블랙하트, 카드, 혹은 거미를 소환하며 {{LuckSmall}}행운 -0.5.#{{LuckSmall}} :행운 20+일 때 아이템 100%#!!! {{LuckSmall}}행운 수치가 0 이하일 때 사용 불가",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.BLACK_HAMMER] 			= {
  		Name = "검은 망치",
  		QuoteDesc = "내가 곧 너를 심판하리라",
  		Description = "사용 시 그 방에서 숫자 공격을 합니다.#숫자에 따라 랜덤 효과 발동:#1: x0.33/캐릭터가 뒤로 밀려남#2: {{DamageSmall}} x0.66#3: {{DamageSmall}} x1 #4: {{DamageSmall}} x1.33#5: {{DamageSmall}} x1.66/{{Collectible494}}#6: {{DamageSmall}} x2/{{Burning}}화상#7: {{DamageSmall}} x2.33/처치 시 33%의 확률로 {{Heart}} 드랍#8: {{DamageSmall}} x2.66/{{Freezing}}즉사/빙걸 #9: {{DamageSmall}} x5/{{ColorOrange}}폭발성{{CR}}",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.BLOOD_OF_SATAN] 		= {
  		Name = "사탄의 피",
  		QuoteDesc = "영혼이 피에 메말랐나오니",
  		Description = "↑ {{DamageSmall}}공격력 +0.66#{{Heart}} 체력을 모두 회복합니다.#이 아이템은 가격이 항상 {{SoulHeart}}소울하트 1개로 고정됩니다.",
  	},
  	[Retribution.ITEMS.BOBS_HEART] 			= {
  		Name = "밥의 심장",
  		QuoteDesc = "폭발하는 친구",
  		Description = "캐릭터를 따라다니며 적과 접촉 시 폭발하여 100의 피해를 입히며 6초 후 다시 생성됩니다.#{{Poison}} 완충제가 캐릭터와 심장 사이에 추가되며 완충제는 적과 접촉 시 적을 중독시킵니다.",
  	},
  	[Retribution.ITEMS.BOOK_OF_GENESIS] 		= {
  		Name = "창세기 1장",
  		QuoteDesc = "하나님이 지으신 그 모든 것을 보시니 보시기에 심히 좋았더라",
  		Description = "!!! 소지 중 피격 시 캐릭터가 받는 피해량이 2배로 증가합니다.#사용 시 {{BlackHeart}}블랙하트 +1",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.BOOK_OF_MORMON] 		= {
  		Name = "모르몬의 책",
  		QuoteDesc = "나 좀 도와주게나?",
  		Description = "{{Fear}} 사용 시 책을 들고 있으며 주변의 적을 캐릭터에게서 멀어지게 합니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.BUCKET_OF_BLOOD] 		= {
  		Name = "피투성이",
  		QuoteDesc = "체력 증가 + 섞여버린 피",
  		Description = "↑ {{UnknownHeart}}하트 +3#{{UnknownHeart}} 전체 체력이 랜덤 개수의 {{Heart}}/{{SoulHeart}}/{{BlackHeart}}으로 변환됩니다.",
  	},
  	[Retribution.ITEMS.CACTUS] 				= {
  		Name = "선인장",
  		QuoteDesc = "예민함 주의",
  		Description = "방마다 랜덤 위치에 항아리가 생성됩니다.#눈물 및 탄환을 5번 주면 주변에 여러 개의 눈물을 흩뿌립니다.",
  	},
  	[Retribution.ITEMS.CADUCEUS] 				= {
  		Name = "카두세우스",
  		QuoteDesc = "공평한 회복",
  		Description = "{{BlendedHeart}} 빨간하트 및 소울하트 픽업이 혼합하트로 바뀝니다.",
  	},
  	[Retribution.ITEMS.CATARACT] 				= {
  		Name = "백내장",
  		QuoteDesc = "흐릿해...",
  		Description = "↑ {{TearsizeSmall}}눈물크기 증가#눈물이 더 오래 떠 있으며 탄속이 점차 감소합니다.",
  	},
  	[Retribution.ITEMS.CHASTITY_BELT] 			= {
  		Name = "순결의 벨트",
  		QuoteDesc = "너의 몸을 신성시해라",
  		Description = "↑ {{DamageSmall}}공격력 +(2/{{Key}}+1)#열쇠 소지 수에 비례하여 증가된 공격력 감소#방 재입장 시 그 방의 {{Key}}열쇠가 사라집니다.",
  	},
  	[Retribution.ITEMS.CELESTIAL_BERRY] 		= {
  		Name = "날개 달린 딸기",
  		QuoteDesc = "떠나기 전에 따자",
  		Description = "적이 있는 방에 최초 진입 시 랜덤 위치에 날개 달린 열매가 생깁니다.#열매는 3초 후에 사라집니다.#열매를 집을 때마다 그 방에서 {{DamageSmall}}공격력 +1, {{TearsSmall}}연사 +0.5 증가하며 비행 능력을 얻습니다.#열매를 집을 때마다 영구적으로 {{LuckSmall}}행운 +0.05",
  	},
  	[Retribution.ITEMS.CHIMERISM] 				= {
  		Name = "키메리즘",
  		QuoteDesc = "나 자신을 개조",
  		Description = "↑ {{Heart}}최대 체력 +2#↑ {{DamageSmall}}공격력 +2#↑ {{Bomb}}폭탄 +2#{{Trinket164}} 폭탄 설치 시 1개의 폭탄을 추가로 설치합니다.",
  	},
  	[Retribution.ITEMS.CHOLERA] 				= {
  		Name = "콜레라",
  		QuoteDesc = "잘 못 맞춤",
  		Description = "↑ {{LuckSmall}}행운 +1#{{PoopSpell1}} 3%의 확률로 적을 똥으로 바꾸는 공격이 나갑니다.#{{LuckSmall}} :행운 13+일 때 25%#똥 공격은 명중률이 살짝 낮습니다.",
  	},
  	[Retribution.ITEMS.CHUNK_OF_TOFU] 			= {
  		Name = "두부 한 덩이",
  		QuoteDesc = "식물성 에스트로겐 가득",
  		Description = "획득할 때마다 성장합니다.#!!! 모든 보스방의 아이템이 {{Collectible"..Retribution.ITEMS.CHUNK_OF_TOFU.."}}Chunk of Tofu로 교체됩니다.#1단계: 캐릭터 주위를 돌며 적의 탄환을 막아줍니다.#2단계: 1단계 + 공격하는 방향으로 공격력 3.5의 눈물을 발사합니다.#3/4단계: 적을 따라다니며 접촉한 적에게 초당 10/20의 피해를 입힙니다.",
  	},
  	[Retribution.ITEMS.COIL] 					= {
  		Name = "코일",
  		QuoteDesc = "둘둘 감긴 친구",
  		Description = "캐릭터 주위를 돌며 적의 탄환을 막아줍니다.#적의 탄환을 막을 시 잠시동안 캐릭터에게서 멀어집니다.",
  	},
  	[Retribution.ITEMS.COMMUNION] 				= {
  		Name = "성찬",
  		QuoteDesc = "파문의 눈물",
  		Description = "사용 시 적의 탄환을 유도 탄환으로, 트롤 폭탄을 유도성 폭탄으로 바꿉니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "유도 탄환으로 바뀐 탄환이 적을 관통하며 적에게 2배의 피해를 줍니다.",
  	},
  	[Retribution.ITEMS.COOTIE] 				= {
  		Name = "쿠티",
  		QuoteDesc = "으휴, 지독해!",
  		Description = "{{Charm}} 그 방에서 체력이 가장 많은 적을 매혹시킵니다.",
  	},
  	[Retribution.ITEMS.CRACKED_INFAMY] 		= {
  		Name = "깨진 악명",
  		QuoteDesc = "공격을 막아낸다..?",
  		Description = "{{Collectible" .. CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS .. "}} 피격 시 2.5%의 확률로 모든 상태를 그 방의 시점으로 시간을 되돌립니다.#발동되지 않았을 경우 확률이 2.5%p씩 증가합니다.(최대 20%)#!!! 체크리스트 관련 방에서는 발동되지 않음",
  	},
  	[Retribution.ITEMS.CYST] 					= {
  		Name = "포낭",
  		QuoteDesc = "선제공격",
  		Description = "방 입장 시마다 처음 공격이 공격력 x10의 공격으로 나갑니다.",
  	},
  	[Retribution.ITEMS.DEAD_LUNG] 				= {
  		Name = "사폐",
  		QuoteDesc = "피나는 기침",
  		Description = "↑ {{BlackHeart}}블랙하트 +1#피격 시 거대한 빨간 장판이 생성됩니다.",
  	},
  	[Retribution.ITEMS.DEATH_CAP] 				= {
  		Name = "죽음의 버섯",
  		QuoteDesc = "독을 통해서 생존",
  		Description = "!!! 사용 시 체력 반칸을 깎고;#↓ {{DamageSmall}}공격력 -0.35#↓ {{SpeedSmall}}이동속도 -0.06#↓ {{ShotspeedSmall}}탄속 -0.06#독성 눈물이 나올 확률 +5%p",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.DEATH_CAP_2] 			= {
  		Name = "죽음의 버섯",
  		QuoteDesc = "독을 통해서 생존",
  		Description = "!!! 사용 시 체력 반칸을 깎고;#↓ {{DamageSmall}}공격력 -0.35#↓ {{SpeedSmall}}이동속도 -0.06#↓ {{ShotspeedSmall}}탄속 -0.06#독성 눈물이 나올 확률 +5%p",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.DEATH_CAP_3] 			= {
  		Name = "죽음의 버섯",
  		QuoteDesc = "독을 통해서 생존",
  		Description = "!!! 사용 시 체력 반칸을 깎고;#↓ {{DamageSmall}}공격력 -0.35#↓ {{SpeedSmall}}이동속도 -0.06#↓ {{ShotspeedSmall}}탄속 -0.06#독성 눈물이 나올 확률 +5%p",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.DEATH_CAP_4] 			= {
  		Name = "죽음의 버섯",
  		QuoteDesc = "독을 통해서 생존",
  		Description = "!!! 사용 시 체력 반칸을 깎고;#↓ {{DamageSmall}}공격력 -0.35#↓ {{SpeedSmall}}이동속도 -0.06#↓ {{ShotspeedSmall}}탄속 -0.06#독성 눈물이 나올 확률 +5%p",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.DEATH_CAP_5] 			= {
  		Name = "죽음의 버섯",
  		QuoteDesc = "독을 통해서 생존",
  		Description = "!!! 사용 시 체력 반칸을 깎고;#↓ {{DamageSmall}}공격력 -0.35#↓ {{SpeedSmall}}이동속도 -0.06#↓ {{ShotspeedSmall}}탄속 -0.06#독성 눈물이 나올 확률 +5%p",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.DEATH_CAP_6] 			= {
  		Name = "죽음의 버섯",
  		QuoteDesc = "독을 통해서 생존",
  		Description = "!!! 사용 시:#{{Heart}}체력을 모두 회복합니다.#↑ {{DamageSmall}}공격력 +2.75#↑ {{DamageSmall}}공격력 배율 x1.5#↑ {{SpeedSmall}}이동속도 +0.5#↑ {{ShotspeedSmall}}탄속 +0.5#!!! 아이템이 사라집니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.DEFIBRILLATOR] 			= {
  		Name = "제세동기",
  		QuoteDesc = "어둠이 보여",
  		Description = "홀수번째 방마다 {{DamageSmall}}공격력 배율 x1.5",
  	},
  	[Retribution.ITEMS.EFFIGY] 				= {
  		Name = "조각상",
  		QuoteDesc = "불타는 것을 지켜보아라",
  		Description = "방 입장 시 15%의 확률로 그 방의 모든 적을 불타는 인형으로 바꾸며 그 방을 스킵합니다.",
  	},
  	[Retribution.ITEMS.EMPIRIC] 				= {
  		Name = "돌팔이",
  		QuoteDesc = "사기 알약",
  		Description = "!!! 모든 알약의 효과를 알 수 없습니다.#{{Pill}} 모든 알약이 거대 형태로 바뀝니다.#{{Pill}} 기존의 거대 알약이 고래 형태로 바뀝니다.",
  	},
  	[Retribution.ITEMS.ETERNAL_BOMBS] 			= {
  		Name = "이터널 폭탄",
  		QuoteDesc = "짐승은 유황 속에서 밤낮 괴로움을 받으리라",
  		Description = "↑ {{Bomb}}폭탄 +5#폭탄이 보스에게 2배의 피해를 줍니다.",
  	},
  	[Retribution.ITEMS.EVES_NAIL_POLISH] 		= {
  		Name = "이브의 매니큐어",
  		QuoteDesc = "한 발 한 발이 중요해",
  		Description = "적 명중 시 다음 눈물을 더 빨리 발사합니다.",
  	},
  	[Retribution.ITEMS.FALSE_IDOL] 			= {
  		Name = "가짜 우상",
  		QuoteDesc = "거짓된 운명",
  		Description = "사용 시 그 방에서 {{LuckSmall}}행운 +10.9#나르시스트 장식 패밀리어도 같이 따라다닙니다.",
			Wisps = "소환되어 있는 동안 {{LuckSmall}}행운 +1.09",
			Belial = "{{LuckSmall}}행운 증가량이 +16.5로 증가",
  	},
  	[Retribution.ITEMS.FALSE_PROMISE] 			= {
  		Name = "거짓된 약속",
  		QuoteDesc = "망가진 소통",
  		Description = "↑ {{LuckSmall}}행운 +1.09",
			Belial = "{{LuckSmall}}행운 증가량이 +1.65로 증가",
  	},
  	[Retribution.ITEMS.FORBIDDEN_FRUIT] 		= {
  		Name = "선악과",
  		QuoteDesc = "공격력 증가?",
  		Description = "↓ {{DamageSmall}}공격력 배율 x0.65#↑ {{DamageSmall}}최종 공격력 +5",
  	},
  	[Retribution.ITEMS.FOP] 					= {
  		Name = "",
  		QuoteDesc = "보전",
  		Description = "획득 시 {{EmptyBoneHeart}}뼈하트를 하나 드랍합니다.#피격 시 체력이 없을 경우 최대 체력을 {{EmptyBoneHeart}}뼈하트로 바꿉니다.",
  	},
  	[Retribution.ITEMS.FRAIL_FLY] 				= {
  		Name = "무른 파리",
  		QuoteDesc = "너무 약해",
  		Description = "캐릭터 주위를 돌며 적의 탄환을 막아줍니다.#접촉한 적에게 초당 60의 피해를 줍니다.#탄환을 3번 막으면 사라지며 다른 방으로 이동시 다시 생겨납니다.",
  	},
  	[Retribution.ITEMS.FRIENDLY_MONSTER] 		= {
  		Name = "친근한 몬스터",
  		QuoteDesc = "궤도 이탈",
  		Description = "적의 주위를 돌면서 접촉하는 적에게 초당 6의 피해를 입힙니다.#공격하는 방향으로 공격력 3.5의 장애물을 관통하는 눈물을 발사합니다",
  	},
  	[Retribution.ITEMS.GUPPYS_PRIDE] 			= {
  		Name = "구피 떼",
  		QuoteDesc = "무슨 일이야?",
  		Description = "획득 시 및 스테이지 진입 시마다 구피 머리를 소환합니다.#공격하는 방향으로 캐릭터의 공격력 x0.5의 눈물을 발사합니다",
  	},
  	[Retribution.ITEMS.HEART_SHAPED_BALLOON] 	= {
  		Name = "하트 풍선",
  		QuoteDesc = "이쁜 풍선",
  		Description = "{{Heart}} 피격 시 풍선이 터지며 풍선의 색상에 따른 하트를 드랍합니다.#피격당하지 않고 방을 넘어갈수록 드랍하는 하트의 등급이 상승합니다.#최대 단계인 상태에서 방 클리어 시 풍선이 강제로 터집니다.#풍선은 새로운 방 이동 시 다시 생깁니다.",
  	},
  	[Retribution.ITEMS.HUNDRED_DOLLAR_STEAK] 	= {
  		Name = "100달러 스테이크",
  		QuoteDesc = "천천히 먹어",
  		Description = "획득 후 30분이 지날 때마다 {{Heart}}최대 체력 +1",
  	},
  	[Retribution.ITEMS.HYPEROPIA] 				= {
  		Name = "원시",
  		QuoteDesc = "가까이선 안보여",
  		Description = "↑ {{TearsSmall}}연사 +0.3#↓ {{ShotspeedSmall}}탄속 -0.5#눈물이 서서히 빨라지며 탄속이 빨라질 때 적을 관통합니다.",
  	},
  	[Retribution.ITEMS.JOYFUL] 				= {
  		Name = "흥분",
  		QuoteDesc = "나는 아무 생각이 없다, 왜냐면 나는 아무 생각이 없기 때문이다.",
  		Description = "피격 시 확률적으로 그 방에서 {{DamageSmall}}공격력이 x2배로 증가하나 그 다음 방에서 {{DamageSmall}}공격력이 x0.85배로 감소합니다.#방 클리어 시 35%의 확률로 흥분제를 추가로 드랍합니다.",
  	},
  	[Retribution.ITEMS.KAPALA] 				= {
  		Name = "카팔라",
  		QuoteDesc = "피해 공유",
  		Description = "↑ {{DamageSmall}}공격력 배율 x1.5#적을 맞출 시 같은 종류의 적에게 피해가 분산됩니다.",
  	},
  	[Retribution.ITEMS.LAUGHING_GAS] 			= {
  		Name = "웃음 가스",
  		QuoteDesc = "승자는 약 따윈 하지 않는다",
  		Description = "↑ {{TearsSmall}}공격 딜레이 -1(연사 증가)#↑ {{ShotspeedSmall}}탄속 +0.3",
  	},
  	[Retribution.ITEMS.LEMON_HEAD] 			= {
  		Name = "레몬 헬멧",
  		QuoteDesc = "연사, 주름 증가",
  		Description = "↑ {{TearsSmall}}연사 +0.8#↑ {{RangeSmall}}사거리 +2.5#↓ {{TearsizeSmall}}눈물크기 감소",
  	},
  	[Retribution.ITEMS.LENT] 					= {
  		Name = "사순절",
  		QuoteDesc = "금욕과 절제",
  		Description = "!!! 그 스테이지의 하트를 줍지 않고 다음 스테이지 이동 시:#↑ {{DamageSmall}}공격력 +0.5#{{Heart}} 체력을 모두 회복합니다.",
  	},
  	[Retribution.ITEMS.LILY] 					= {
  		Name = "백합",
  		QuoteDesc = "이제 평화는 없다",
  		Description = "사용 시 체력이 33% 이하인 일반 적을 즉사 및 폭파 시킵니다.#폭파시킬 수 있는 적은 붉게 표시됩니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "폭파된 적에게서 4방향으로 혈사포를 발사합니다.",
  	},
  	[Retribution.ITEMS.MAD_ONION] 				= {
  		Name = "화난 양파",
  		QuoteDesc = "순수하게 매운",
  		Description = "5%의 확률로 모든 눈물효과가 제거된 캐릭터의 공격력 x3.2의 공격이 나갑니다#{{LuckSmall}} :행운 13+일 때 50%",
  	},
  	[Retribution.ITEMS.MARK_OF_CAIN] 			= {
  		Name = "카인의 표식",
  		QuoteDesc = "부끄러워하리라",
  		Description = "적이 있는 일반방에서 10초가 지나면 문이 열립니다.#캐릭터에게 피해를 준 적에게 공격력 x7의 피해만큼 반사합니다.",
  	},
  	[Retribution.ITEMS.MILK_TEETH] 			= {
  		Name = "우유 이빨",
  		QuoteDesc = "지연된 분할 눈물",
  		Description = "↓ {{TearsSmall}}공격 딜레이 x2(연사 감소)#공격이 일정 거리 이후 5발로 분열됩니다.",
  	},
  	[Retribution.ITEMS.SCULPTING_CLAY] 		= {
  		Name = "조각상",
  		QuoteDesc = "충전식 아이템 복제",
  		Description = "!!! 스테이지 당 1회만 사용 가능#사용 시 가장 가까운 패시브 아이템 하나를 복사 후 흡수합니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "복사된 아이템의 원본을 체력 거래가 필요한 {{DevilRoom}}악마방 아이템으로 바꿉니다.",
  	},
  	[Retribution.ITEMS.USED_SCULPTING_CLAY] 	= {
  		Name = "조각상",
  		QuoteDesc = "충전식 아이템 복제",
  		Description = "!!! 스테이지 당 1회만 사용 가능#이미 사용됨#{{ColorGray}}사용 시 가장 가까운 패시브 아이템 하나를 복사 후 흡수합니다.{{CR}}",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.MOXIES_HEAD] 			= {
  		Name = "모시의 머리",
  		QuoteDesc = "공격력 증가",
  		Description = "↑ {{DamageSmall}}공격력 배율 x1.2",
  	},
  	[Retribution.ITEMS.MUSTARD_SEED] 			= {
  		Name = "겨자 씨앗",
  		QuoteDesc = "운명을 심는 능력",
  		Description = "↑ {{Heart}}최대 체력 +1#↑ {{Heart}}빨간하트 +1#↑ {{DamageSmall}}공격력 +0.6#↑ {{TearsSmall}}연사 +0.3#↑ {{SpeedSmall}}이동속도 +0.2#스테이지 진입 시 이전 스테이지와 액티브/패시브 아이템의 개수가 동일한 경우 위의 증가량이 추가로 적용됩니다.",
  	},
  	[Retribution.ITEMS.OLD_BELL] 				= {
  		Name = "낡은 종",
  		QuoteDesc = "공격력 증가 + 활기가 없어",
  		Description = "↑ {{DamageSmall}}공격력 +3#스테이지 진입 시마다 {{DamageSmall}}증가한 공격력 -0.6",
  	},
  	[Retribution.ITEMS.PEASHY] 				= {
  		Name = "피시",
  		QuoteDesc = "진심이야?",
  		Description = "↑ {{Heart}}최대 체력 +1#↑ {{Heart}}빨간하트 +1#↑ {{DamageSmall}}공격력 +0.5",
  	},
  	[Retribution.ITEMS.PHILOSOPHERS_STONE] 	= {
  		Name = "현자의 돌",
  		QuoteDesc = "부유한 체력",
  		Description = "↑ {{Heart}}최대 체력 +1#↑ {{GoldenHeart}}황금하트 +3",
  	},
  	[Retribution.ITEMS.PHOTON] 				= {
  		Name = "광자",
  		QuoteDesc = "탄속 대폭 증가",
  		Description = "{{ShotspeedSmall}} 탄속이 4로 고정됩니다.#↑ {{DamageSmall}}공격력 +1#↑ {{DamageSmall}}공격력 배율 x1.5",
  	},
  	[Retribution.ITEMS.PUMPKIN_MASK] 			= {
  		Name = "호박 마스크",
  		QuoteDesc = "영혼을 위한 영혼",
  		Description = "!!! 일회용 !!!#!!! 사용 시:#↑ {{SoulHeart}}소울하트 +12#이후 현재 게임에서 60초마다 캐릭터가 체력 반칸의 피해를 받으며 이동/몸통방향으로 혈사포를 발사합니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "소울하트 대신 {{BlackHeart}}블랙하트를 추가합니다.",
  	},
  	[Retribution.ITEMS.RAPTURE] 				= {
  		Name = "황홀",
  		QuoteDesc = "뒤틀린 이야기, 천리안, 영원한 감옥",
  		Description = "적 탄환 크기를 60% 감소시킵니다.#적 처치 시 그 적의 탄환을 모두 제거합니다.",
  	},
  	[Retribution.ITEMS.REFLUX] 				= {
  		Name = "환류",
  		QuoteDesc = "참을 수 없어",
  		Description = "↓ {{TearsSmall}}공격 딜레이 x2(연사 감소)#눈물이 0.66초 후 연기가 나며 공격 키를 떼면 연기가 난 눈물이 폭발합니다.",
  	},
  	[Retribution.ITEMS.REWARDS_CARD] 			= {
  		Name = "VIP 카드",
  		QuoteDesc = "충성 고객에게 할인을",
  		Description = "↑ {{GoldenHeart}}황금하트 +1#{{Shop}} 상점 품목 구매 시마다 그 스테이지에서 상점의 판매 가격이 1{{Coin}}씩 할인됩니다.",
  	},
  	[Retribution.ITEMS.RICKETS] 				= {
  		Name = "구루병",
  		QuoteDesc = "연약한 뼈",
  		Description = "↑ {{DamageSmall}}공격력 +1#공격이 적을 더 강하게 밀쳐내나 공격할 때마다 캐릭터가 뒤로 밀려납니다.",
  	},
  	[Retribution.ITEMS.ROLL_FILM] 				= {
  		Name = "필름",
  		QuoteDesc = "운명을 정할 시간",
  		Description = "획득 시 {{Trinket69}}Faded Polaroid를 드랍합니다.#{{Collectible" .. CollectibleType.COLLECTIBLE_WAFER .. "}} 전체 체력이 3칸 이하인 경우 받는 피해를 절반으로 줄여줍니다.#{{Collectible327}}Polaroid 및 {{Collectible328}}Negative의 효과 발동 조건이 전체 체력 3칸 이하로 완화됩니다.",
  	},
  	[Retribution.ITEMS.SALESMANS_EYE]			= {
  		Name = "상인의 눈",
  		QuoteDesc = "무슨 변칙성인가",
  		Description = "상점 아이템의 판매 가격이 0~4{{Coin}}만큼 할인합니다.",
  	},
  	[Retribution.ITEMS.SHATTERED_DICE] 		= {
  		Name = "부서진 주사위",
  		QuoteDesc = "무의식적인 영향",
  		Description = "!!! 소지 시:#아이템 획득 시 다른 아이템으로 획득됩니다.#액티브 아이템 교체 시 사라집니다.#!!! 일회용 !!!#사용 시 {{Card49}}Shattered Shard 및 {{Coin}}여러 개의 동전을 드랍합니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "사용 시 그 방의 아이템을 최소 {{Quality2}}등급의 {{DevilRoom}}악마방 아이템으로 바꿉니다.",
  	},
  	[Retribution.ITEMS.SHYCOIN] 				= {
  		Name = "샤이코인",
  		QuoteDesc = "버려진 화폐",
  		Description = "↑ {{Coin}}동전 +50",
  	},
  	[Retribution.ITEMS.SILVER_CHARM] 			= {
  		Name = "은빛 목걸이",
  		QuoteDesc = "푸른 피",
  		Description = "↑ {{SoulHeart}}소울하트 +2#획득 시 최대 체력을 소울하트 3개씩 바꿉니다.#(최대 체력 소진 및 전체 체력이 꽉 차있을 경우를 예상하여 일부 체력만 변경)",
  	},
  	[Retribution.ITEMS.SILVER_FLESH] 			= {
  		Name = "은빛 고기덩이",
  		QuoteDesc = "이거 뭔가 이상해...",
  		Description = "5%의 확률로 캐릭터의 공격력 x1.5의 링이 나갑니다.#{{LuckSmall}} :행운 7+일 때 15%#{{HalfSoulHeart}} 링으로 적 처치 시 소울하트 반칸을 드랍합니다.",
  	},
  	[Retribution.ITEMS.SLICK_SPADE] 			= {
  		Name = "핏빛 스페이드",
  		QuoteDesc = "탐욕스러운 분노",
  		Description = "10%의 확률로 특정 효과의 문양이 새겨진 공격이 나갑니다:#- 하트: {{Charm}}매혹#- 다이아몬드: 석화#- 스페이드: {{Fear}}공포#- 클럽: {{BleedingOut}}출혈#플레잉 카드 사용 시 방 안의 적에게 그 문양에 맞는 효과를 적용합니다.",
  	},
  	[Retribution.ITEMS.SLOTHS_TOE] 			= {
  		Name = "나태의 발가락",
  		QuoteDesc = "게으름의 메리트",
  		Description = "↓ {{SpeedSmall}}이동속도 -0.1#2.5초동안 가만히 있으면 {{DamageSmall}}공격력 +2,{{TearsSmall}}연사 +0.8",
  	},
  	[Retribution.ITEMS.SMOOTH_STONE] 			= {
  		Name = "부드러운 돌",
  		QuoteDesc = "위에 있는 것들을 끌어내려",
  		Description = "↑ {{DamageSmall}}공격력 +0.5#최대 체력이 150 이상인 적은 1.5배의 피해를 받습니다.",
  	},
  	[Retribution.ITEMS.SNAKE_OIL] 				= {
  		Name = "뱀 기름",
  		QuoteDesc = "눈물크기 증가",
  		Description = "↑ {{TearsizeSmall}}눈물크기 대폭 증가",
  	},
  	[Retribution.ITEMS.SOAP_BOX] 				= {
  		Name = "비누곽",
  		QuoteDesc = "아늑한 플랫폼",
  		Description = "↑ {{RangeSmall}}사거리 +2#스테이지 진입 시 {{Heart}}체력을 2칸 회복합니다.",
  	},
  	[Retribution.ITEMS.SOME_OPTIONS] 			= {
  		Name = "때때로 선택권",
  		QuoteDesc = "선택, 또 선택",
  		Description = "픽업이 등장할 때 20%의 확률로 작은 나무 자루가 등장하며 하나를 선택하면 나머지는 사라집니다.#나무 자루에서는 랜덤 나무 픽업이 등장하며 효과는 기존의 픽업과 동일합니다.",
  	},
  	[Retribution.ITEMS.SOY_BEAN] 				= {
  		Name = "콩",
  		QuoteDesc = "가스 눈물",
  		Description = "5%의 확률로 명중 시 방귀를 뀌는 공격이 나갑니다.#{{LuckSmall}} :행운 7+일 때 15%#{{Collectible447}} 방귀 공격으로 적 처치 시 Linger Bean의 구름을 남깁니다.",
  	},
  	[Retribution.ITEMS.SUCKER_SAC] 			= {
  		Name = "빨판 주머니",
  		QuoteDesc = "병들어가는 체력",
  		Description = "자폭 파리가 적 공격 시 독가스를 생성합니다.#체력을 반칸 회복할 때마다 자폭 파리를 1~3마리 생성합니다.",
  	},
  	[Retribution.ITEMS.SUNKEN_FLY] 			= {
  		Name = "잠긴 파리",
  		QuoteDesc = "자주 부풀어",
  		Description = "캐릭터 주위를 돌며 적의 탄환을 막아줍니다.#접촉 시 적 및 트롤 폭탄을 밀쳐냅니다.",
  	},
  	[Retribution.ITEMS.MOMS_SUPPOSITORY] 		= {
  		Name = "엄마의 좌약",
  		QuoteDesc = "공격력 증가?",
  		Description = "↑ {{DamageSmall}}공격력 배율 x1.5#↓ {{DamageSmall}}최종 공격력 -2#{{Pill}} 알약을 1~3개 드랍합니다.",
  	},
  	[Retribution.ITEMS.THE_SIGN] 				= {
  		Name = "표식",
  		QuoteDesc = "공격력 증가?",
  		Description = "획득 시 {{DamageSmall}}기본 공격력을 7로 설정합니다.#이후 획득하는 공격력 증가 아이템에는 영향을 주지 않습니다.",
  	},
  	[Retribution.ITEMS.TITHE] 					= {
  		Name = "십일조",
  		QuoteDesc = "헌금 낼 시간",
  		Description = "↑ {{EternalHeart}}이터널하트 +1#{{AngelChanceSmall}} 스테이지 진입 시 픽업({{Coin}}/{{Key}}/{{Bomb}}) 하나씩 소모하여 3%의 확률로 특수한 천사방으로 순간이동합니다.#특수한 천사방으로 이동 시, 혹은 각각 10{{Coin}}/1{{Bomb}}/1{{Key}} 이하일 때 픽업 소모를 중단합니다.#{{AngelDevilChanceSmall}} 스테이지의 악마방/천사방 확률에는 영향을 끼치지 않습니다.",
  	},
  	[Retribution.ITEMS.TOOL] 					= {
  		Name = "",
  		QuoteDesc = "태어난 순간을 기억하는가?",
  		Description = "적이 피해를 입을 때 15%의 확률로 같은 종류의 적에게 피해를 줍니다.#{{LuckSmall}} :행운 13+일 때 35%",
  	},
  	[Retribution.ITEMS.TOY_DRUM] 				= {
  		Name = "장난감 드럼",
  		QuoteDesc = "심장이 더 크게 두근거려",
  		Description = "↑ 2초마다 0.5초간 {{DamageSmall}}공격력 배율 x2",
  	},
  	[Retribution.ITEMS.VANILLA_WAFER] 			= {
  		Name = "바닐라 성체",
  		QuoteDesc = "피해 복구",
  		Description = "{{Heart}} 방 클리어 시 그 방에서 잃은 빨간하트의 절반을 회복합니다.",
  	},
  	[Retribution.ITEMS.WAX_WING] 				= {
  		Name = "밀랍 날개",
  		QuoteDesc = "너무 높이 날아오르지 마",
  		Description = "↑ {{TearsSmall}}연사 +0.6#↑ {{SpeedSmall}}이동속도 +0.3#↑ {{DamageSmall}}공격력 배율 x1.35#↑ {{LuckSmall}}행운 +2,#비행 능력을 얻습니다.#피격 시 위의 효과가 사라지며 시작 방으로 순간이동합니다.#스테이지 진입 시 날개가 복원됩니다.",
  	},
  	[Retribution.ITEMS.WELTLING_SAC] 			= {
  		Name = "핏덩이 자루",
  		QuoteDesc = "혈액 폭발",
  		Description = "↑ {{Bomb}} 폭탄 +5#폭탄이 터질 때 적에게 추가 피해를 주며 폭발한 위치에 있는 적의 탄환을 지웁니다.",
  	},
  	[Retribution.ITEMS.BELL_OF_CIRCE] 			= {
  		Name = "키르케의 종",
  		QuoteDesc = "돼지를 위해 종은 울린다",
  		Description = "사용 시 확률적으로 적 하나를 돼지로 바꿉니다.#성공 확률은 적의 수에 비례하며 실패 시 {{ColorOrange}}캐릭터가 돼지로 변하며 종이 깨집니다.{{CR}}#돼지 상태에서는 모든 능력치가 감소하며 방 이동 시 돌아옵니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "성공 시마다 그 방에서 {{DamageSmall}}공격력 +0.5",
  	},
  	[Retribution.ITEMS.CRACKED_BELL_OF_CIRCE] 	= {
  		Name = "키르케의 종",
  		QuoteDesc = "돼지를 위해 종은 울린다",
  		Description = "사용 시 확률적으로 적 하나를 돼지로 바꿉니다.#성공 확률은 적의 수에 비례하며 실패 시 {{ColorOrange}}캐릭터가 돼지로 변하며 종이 깨집니다.{{CR}}#돼지 상태에서는 모든 능력치가 감소하며 방 이동 시 돌아옵니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "성공 시마다 {{DamageSmall}}공격력 +0.5",
  	},
  	[Retribution.ITEMS.BOOSTER_SHOT] 			= {
  		Name = "부스터 샷",
  		QuoteDesc = "합성 눈물",
  		Description = "↓ {{DamageSmall}}공격력 -0.5#공격이 적을 관통하며 관통할 때마다 피해량이 공격력이 x1.5배씩 증가합니다.",
  	},
  	[Retribution.ITEMS.BOTTLED_FAIRY] 			= {
  		Name = "병에 든 요정",
  		QuoteDesc = "만병통치약",
  		Description = "!!! 일회용 !!!#{{Heart}} 체력을 전부 회복합니다.#피격 시 체력이 없을 경우 자동으로 사용합니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "사용될 경우 모든 최대 체력을 {{BoneHeart}}뼈하트로 바꾸며 그 방에서 {{DamageSmall}}공격력 +3",
  	},
  	[Retribution.ITEMS.CARAPACE] 				= {
  		Name = "등딱지",
  		QuoteDesc = "골격",
  		Description = "1회 한정으로 피격을 막아주며 피격 전까지 {{DamageSmall}}공격력 +1, {{SpeedSmall}}이동속도 배율 x0.75#적이 있는 방 진입 시 다시 활성화됩니다.",
  	},
  	[Retribution.ITEMS.EYE_OF_BALOR] 			= {
  		Name = "발러의 눈",
  		QuoteDesc = "지배와 파괴",
  		Description = "체력이 꽉 차있지 않은 적 중 체력의 비율이 가장 낮은 적에 추가 피해를 줍니다.",
  	},
  	[Retribution.ITEMS.GLIOMA] 				= {
  		Name = "교종",
  		QuoteDesc = "원가 잊은 듯한 기분",
  		Description = "↑ {{TearsSmall}}연사 +0.3#{{Confusion}} 15%의 확률로 적에게 혼란을 거는 공격이 나갑니다.#{{BossRoom}}보스방 클리어 시 스테이지의 모든 방이 클리어하지 않은 상태로 바뀝니다.",
  	},
  	[Retribution.ITEMS.HAM] 					= {
  		Name = "햄",
  		QuoteDesc = "기다란 돼지고기",
  		Description = "↑ {{Heart}}최대 체력 +1#{{Heart}} 체력을 모두 회복합니다.#↑ {{BlackHeart}}블랙하트 +2#↑ {{DamageSmall}}공격력 +0.75#↑ {{RangeSmall}}사거리 +5#이 아이템은 일반적인 방법으로 등장하지 않습니다.",
  	},
  	[Retribution.ITEMS.MEAT_GRINDER] 			= {
  		Name = "고기 분쇄기",
  		QuoteDesc = "자신의 맛",
  		Description = "체력 반칸을 깎고 돼지 거지를 소환합니다.#빨간하트를 우선적으로 깎습니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.SNAP_BANG] 				= {
  		Name = "스냅뱅",
  		QuoteDesc = "지지지직, 펑!",
  		Description = "사용 시 캐릭터의 위치에 스냅을 설치합니다.#스냅에 적 접촉 시 주변의 적에게 캐릭터의 공격력 x5의 폭발 피해를 입으며 {{Confusion}}혼란에 걸립니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "설치한 스냅의 피해량이 2배로 증가합니다.",
  	},
  	[Retribution.ITEMS.SPOILS_POUCH] 			= {
  		Name = "전리품 파우치",
  		QuoteDesc = "삥뜯기",
  		Description = "적 처치 시 확률적으로 2초 후 사라지는 돼지 코인을 드랍합니다.#드랍률은 행운, 스테이지 진행도, 적의 최대 체력에 비례합니다.",
  	},
  	[Retribution.ITEMS.STAINED_SHARD] 			= {
  		Name = "스테인드글래스 조각",
  		QuoteDesc = "약한 보호",
  		Description = "사용 시 캐릭터 주변에 원형의 빨간 가시를 소환합니다. 각 가시별로 적의 탄환을 한번씩 막을 수 있습니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.TECHNOLOGY_OMICRON] 	= {
  		Name = "오미크론 기계",
  		QuoteDesc = "레이저를 두른 눈물",
  		Description = "↓ {{TearsSmall}}공격 딜레이 x1.2(연사 감소)#공격에 원형 레이저를 두릅니다.",
  	},
  	[Retribution.ITEMS.FRIEND_FOLIO] 			= {
  		Name = "",
  		QuoteDesc = "라이벌 챕터",
  		Description = "방마다 Retribution 모드 출신의 랜덤 패밀리어가 등장합니다.",
  	},
  	[Retribution.ITEMS.BEECONOMY] 				= {
  		Name = "비코노미",
  		QuoteDesc = "흔들리는 경제",
  		Description = "↑ {{Coin}}동전 +30#다른 아이템을 구매할 때까지 적이 있는 방 입장 시 3마리의 자폭 꿀벌을 소환합니다.#이 아이템은 판매 가격이 15{{Coin}}으로 고정됩니다.",
  	},
  	[Retribution.ITEMS.BELL_CLAPPER] 			= {
  		Name = "추",
  		QuoteDesc = "공격력 증가 + 둔탁한 소리",
  		Description = "↑ {{DamageSmall}}공격력 + 1.5#↑ {{TearsSmall}}연사 +0.3#공격할 때마다 공격력 증가량 배율이 x0.9로 감소하며 다른 방 이동 시 돌아옵니다.",
  	},
  	[Retribution.ITEMS.BROWNIE] 				= {
  		Name = "브라우니",
  		QuoteDesc = "공격력 증가 + 내장이 흔들려",
  		Description = "↑ {{DamageSmall}}공격력 +1.5#주기적으로 옥수수 함정을 까며 잠시동안 캐릭터의 위치에 미끄러지는 장판을 깝니다.",
  	},
  	[Retribution.ITEMS.BRUNCH] 				= {
  		Name = "브런치",
  		QuoteDesc = "체력 증가",
  		Description = "↑ {{Heart}}최대 체력 +1#↑ {{Heart}}빨간하트 +1",
  	},
  	[Retribution.ITEMS.CONJUNCTIVITIS] 		= {
  		Name = "결막염",
  		QuoteDesc = "눈에 주름이 생겨",
  		Description = "↑ {{TearsSmall}}공격 딜레이 -1(연사 증가)#{{Slow}} 10%의 확률로 적을 둔화시키는 공격이 나갑니다.#{{Slow}} 공격이 무언가에 부딪힐 때 적을 느려지게 하는 장판을 생성합니다.",
  	},
  	[Retribution.ITEMS.MILK_OF_BAPHOMET] 		= {
  		Name = "바포메트의 우유",
  		QuoteDesc = "체력 증가 + 무작위 피격 효과",
  		Description = '↑ {{Heart}}최대 체력 +1#피격 시 랜덤 피격 아이템의 효과를 발동합니다.',
  	},
  	[Retribution.ITEMS.DEVILS_TOOTH] 			= {
  		Name = "악마의 이빨",
  		QuoteDesc = "방혈",
  		Description = "8%의 확률로 적을 강화 형태로 바꾸는 공격이 나갑니다.#강화 형태로 바뀐 적의 체력을 절반으로 감소시킵니다.#{{LuckSmall}} :행운 7+일 때 20%",
  	},
  	[Retribution.ITEMS.DOWSING_ROD] 			= {
  		Name = "다우징 막대",
  		QuoteDesc = "매혹적인 흐름",
  		Description = "사용 시 막대기를 듭니다.#막대기를 드는 동안 캐릭터의 주변의 눈물과 빛줄기가 쏟아지며 오래 들고 있을수록 더 많이 쏟아집니다.#방 이동 시에도 계속 들고 있는 상태가 유지됩니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "빛줄기 대신 혈사포가 쏟아집니다.",
  	},
  	[Retribution.ITEMS.EVERLASTING_PILL] 		= {
  		Name = "영원한 알약",
  		QuoteDesc = "능력치는 없지만",
  		Description = "{{Pill}} 사용 시 능력치를 제외한 랜덤 알약을 사용합니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.FRYS_PAW] 				= {
  		Name = "프라이의 발",
  		QuoteDesc = "뼈 변환기",
  		Description = "사용 시 {{Heart}}{{ColorOrange}}꽉 찬 최대 체력{{CR}}을 {{EmptyBoneHeart}}뼈하트 2개로 바꿉니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "체력을 바꿀 때마다 영구적으로 {{DamageSmall}}공격력 +0.5",
  	},
  	[Retribution.ITEMS.IMPACT_WAX] 			= {
  		Name = "충격 왁스",
  		QuoteDesc = "방금 뭔가 말했어?",
  		Description = "↑ {{DamageSmall}}공격력 +0.5#공격하는 동안 공격방향의 양 옆에 사거리가 매우 짧은 캐릭터의 공격력 x0.75 눈물을 발사하며 무언가에 부딪힐 때 {{Slow}}적을 느려지게 하는 장판을 깝니다.",
  	},
  	[Retribution.ITEMS.BOOTLICKER] 			= {
  		Name = "부트리커",
  		QuoteDesc = "마조히스트",
  		Description = "↑ {{EmptyHeart}}빈 최대 체력 +1#획득 이후 {{BossRoom}}보스방을 클리어하기 전까지는 하트를 주울 수 없으며 그 사이에 피격 시마다 {{DamageSmall}}공격력 +0.25#보스방 클리어 시 더 이상 공격력이 증가하지 않습니다.",
  	},
  	[Retribution.ITEMS.MELATONIN] 				= {
  		Name = "멜라토닌",
  		QuoteDesc = "Zzz...",
  		Description = "소지한 상태에서 침대 사용 시 {{Heart}}최대 체력 +1#!!! 사용 시:#↓ 잠시동안 캐릭터가 움직일 수 없습니다.#↑ 그 방에서 {{TearsSmall}}연사가 +0.75 증가하며;#공격이 적을 점차 느려지게 합니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.MELITODES] 				= {
  		Name = "단물",
  		QuoteDesc = "달콤달콤",
  		Description = "20%의 확률로 적에게 명중 시 자폭 꿀벌을 소환하는 공격이 나갑니다.#{{LuckSmall}} :행운 13+일 때 50%",
  	},
  	[Retribution.ITEMS.MONSTER_CANDY] 			= {
  		Name = "이상한 사탕",
  		QuoteDesc = "진화의 증거",
  		Description = "사용 시 공격하는 방향으로 사탕을 던집니다.#사탕에 닿은 적은 아군이 되며 확률적으로 강화 형태로 진화합니다.#놓친 사탕은 사용 시 아군 몬스터의 체력을 전부 회복시킵니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.MOONLIT_MIRROR] 		= {
  		Name = "달빛 거울",
  		QuoteDesc = "초차원 입찰",
  		Description = "사용 시 판매 중이지 않은 모든 픽업을 3{{Coin}} 혹은 니켈로 바꿉니다.#(동전 및 열린 상자는 제외)",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.MYOPIA] 				= {
  		Name = "근시",
  		QuoteDesc = "단계적 눈물",
  		Description = "↑ {{ShotspeedSmall}}탄속 +0.2#↑ {{TearsSmall}}눈물 딜레이 -1(연사 증가)#눈물이 천천히 투명해지고 0.25초 이후 장애물을 관통하며 적에게 유도됩니다.",
  	},
  	[Retribution.ITEMS.SCULPTED_SOAPSTONE] 	= {
  		Name = "조각 동석",
  		QuoteDesc = "체력 증가 + 체력 증가",
  		Description = "↑ {{SoulHeart}}소울하트 +1#스테이지 입장 시 {{Heart}}최대 체력 +1",
  	},
  	[Retribution.ITEMS.SOUR_PATCH] 			= {
  		Name = "신 천조각",
  		QuoteDesc = "시큼한 공격력 증가",
  		Description = "↑ {{DamageSmall}}공격력 +1.2#↑ {{ShotspeedSmall}}탄속 +0.15#↓ {{TearsizeSmall}}눈물크기 감소",
  	},
  	[Retribution.ITEMS.SWINDLER] 				= {
  		Name = "사기꾼",
  		QuoteDesc = "",
  		Description = "방 안을 돌아다니며 {{Coin}}동전과 획득할 수 없는 {{Bomb}}폭탄,{{Key}}열쇠를 모읍니다.#{{Chest}} 상자를 자동으로 열어주며 가능한 경우 모은 {{Bomb}}/{{Key}}를 사용합니다.#방 클리어 시 확률적으로 판매 아이템/픽업을 소환하며 모은 {{Coin}}에 따라 가격을 할인합니다.(최소 1{{Coin}})",
  	},
  	[Retribution.ITEMS.MULTI_CAPSULE] 			= {
  		Name = "커다란 캡슐",
  		QuoteDesc = "3연차를 한번에!",
  		Description = "능력치 캡슐을 3개 소환합니다.#하나 이상의 캡슐은 반드시 {{DamageSmall}}/{{LuckSmall}}/{{TearsSmall}}/{{Heart}}가 등장합니다.",
  	},
  	[Retribution.ITEMS.KOMPU_GACHA] 			= {
  		Name = "꿀꿀이 가챠",
  		QuoteDesc = "돈이 너무 좋아",
  		Description = "획득 시 능력치 캡슐({{DamageSmall}}/{{LuckSmall}}/{{TearsSmall}}/{{Heart}} 중 하나)을 하나 소환하며;#5{{Coin}}을 강제로 소모하여 최대 9개까지 캡슐을 추가로 뽑습니다.",
  	},
  	[Retribution.ITEMS.GACHA_GO] 				= {
  		Name = "가챠-GO",
  		QuoteDesc = "단차 뽑기",
  		Description = "사용 시 5{{Coin}}을 소모하여 아래 중 하나를 드랍합니다:#능력치 캡슐 (40%)#미니 능력치 캡슐 (25%)#알약 (20%)#장신구(15%)",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "알약이 {{BlackHeart}}블랙하트로, 장신구가 {{EmptyBoneHeart}}뼈하트로 교체됩니다.",
  	},
  	[Retribution.ITEMS.HEEL_SPUR] 				= {
  		Name = "골주",
  		QuoteDesc = "속도 = 공격력",
  		Description = "↑ {{EmptyBoneHeart}}뼈하트 +1#{{DamageSmall}} 공격력 배율이 캐릭터의 현재 속력으로 설정됩니다.",
  	},
  	[Retribution.ITEMS.BANDAGE_BINDER] 		= {
  		Name = "바인딩",
  		QuoteDesc = "조심히 입을 것",
  		Description = "↑ {{RangeSmall}}사거리 +2#↑ {{DamageSmall}}공격력 +0.4#피격 시 일회용 뼛조각 배리어 1~3개를 소환합니다.",
  	},
  	[Retribution.ITEMS.SINNERS_PRAYER] 		= {
  		Name = "죄인의 기도",
  		QuoteDesc = "우리를 죄에서 구하옵소서",
  		Description = "↑ {{DamageSmall}}공격력 +1.4#피격 시 체력이 없을 경우 25%의 확률로 체력을 반칸 남기며 적에게 빛줄기로 반격합니다.#{{LuckSmall}} :행운 7+일 때 50%#피격 시 5%의 확률로 적에게 빛줄기로 반격합니다.#{{LuckSmall}} :행운 14+일 때 25%",
  	},
  	[Retribution.ITEMS.HEARTBROKER]			= {
  		Name = "부서진 심장",
  		QuoteDesc = "피투성이 거래",
  		Description = "↑ {{GoldenHeart}}황금하트 +1#↓ {{BrokenHeart}}부서진하트 +2#{{BrokenHeart}} 부서진하트를 체력 거래에 사용할 수 있습니다.",
  	},
  	[Retribution.ITEMS.JET_FEATHER] 			= {
  		Name = "제트 깃털",
  		QuoteDesc = "타천하리라",
  		Description = "{{AngelRoom}} 천사방 아이템이 체력을 요구하게 되나 선택형 상태가 제거됩니다.#{{DevilRoom}} 악마방 아이템을 무료로 획득할 수 있으나 하나를 선택하면 나머지는 사라집니다.",
  	},
  	[Retribution.ITEMS.DERELICT_ANCHOR] 		= {
  		Name = "버려진 닻",
  		QuoteDesc = "조난당한 것 같다",
  		Description = "적이 닻에 묶이며 적의 이동을 매우 크게 방해합니다.#닻은 오브젝트를 부술 수 있습니다.",
  	},
  	[Retribution.ITEMS.BONE_SAW] 				= {
  		Name = "뼈톱",
  		QuoteDesc = "면허를 버릴 시간",
  		Description = "사용 시 근처의 거지를 처치합니다.#거지를 처치할 때마다 일회용 뼛조각 배리어 2개를 소환하며 낮은 확률로 특정 아이템을 드랍합니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "처치한 거지에서의 뼛조각이 증가하며 50%의 확률로 {{EmptyBoneHeart}}뼈하트를 드랍합니다.",
  	},
  	[Retribution.ITEMS.RED_CHAIN] 				= {
  		Name = "붉은 사슬",
  		QuoteDesc = "자연스럽게 묶여있어",
  		Description = "↑ {{Key}}열쇠 +3#방 입장 시 33%의 확률로 빨간 기둥이 생성됩니다.#기둥에 {{Key}}열쇠를 소모할 시 랜덤 빨간 방으로 순간이동하는 포탈을 생성합니다.",
  	},
  	[Retribution.ITEMS.THE_ILIAD] 				= {
  		Name = "일리아스",
  		QuoteDesc = "아킬레스의 분노",
  		Description = "사용 시 공격방향으로 벽에서 화살을 발사합니다.#화살은 오브젝트에 부딪히면 사라지나 적을 관통하며 50의 피해를 줍니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.THE_ODYSSEY] 			= {
  		Name = "오디세이아",
  		QuoteDesc = "포세이돈의 분노",
  		Description = "사용 시 적에게 피해를 주는 장판을 생성하며 주변의 오브젝트를 파괴, 주변의 적에게 닻을 묶어 적의 이동을 매우 크게 방해합니다.#닻은 오브젝트를 부술 수 있습니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.TIMED_ILIAD] 			= {
  		Name = "일리아스",
  		QuoteDesc = "아킬레스의 분노",
  		Description = "사용 시 공격방향으로 벽에서 화살을 발사합니다.#화살은 오브젝트에 부딪히면 사라지나 적을 관통하며 50의 피해를 줍니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.TIMED_ODYSSEY] 			= {
  		Name = "오디세이아",
  		QuoteDesc = "포세이돈의 분노",
  		Description = "사용 시 적에게 피해를 주는 장판을 생성하며 주변의 오브젝트를 파괴, 주변의 적에게 닻을 묶어 적의 이동을 매우 크게 방해합니다.#닻은 오브젝트를 부술 수 있습니다.",
			Wisps = "(특수 효과 없음/일반 불꽃이 소환됨)",
			Belial = "",
  	},
  	[Retribution.ITEMS.DOMINICUS] 				= {
  		Name = "지배자",
  		QuoteDesc = "잊혀진 탄생의 태양",
  		Description = "캐릭터의 주변을 돌며 눈물로 맞출 시 그 방향으로 날아갑니다.#각각의 효과는 모습에 따라 달라집니다.",
  	},
  	[Retribution.ITEMS.HEART_RUPTURE] 			= {
  		Name = "심장 파열",
  		QuoteDesc = "심장을 흘리고 있어",
  		Description = "적 처치 시 확률적으로 하트를 위로 떨구며 착지한 위치가 맞을 때 하트를 주울 수 있습니다.#잡지 못했을 경우 하트가 사라집니다.",
  	},
  	[Retribution.ITEMS.PRIDE_PIN]				= {
  		Name = "프라이드 핀",
  		QuoteDesc = "킨제이 눈물",
  		Description = "5초마다 두 종류의 Retribution 모드의 랜덤 눈물 효과가 적용됩니다.",
    },
		[Retribution.ITEMS.HEMORRHOID] = {
  		Name = "치질",
  		QuoteDesc = "뒤로 모아 쏘기",
  		Description = "{{Chargeable}} 공격을 충전한 다음 {{ColorOrange}}캐릭터의 몸통 반대방향으로{{CR}} 여러 개의 눈물을 흩뿌리면서 발사합니다.#!!! 피격 시 빨간 똥을 쌉니다.",
		},

  } 
  local rtTrinketDesc = {
  	[Retribution.TRINKETS.BOOKMARK] 		= {
  		Name = "책갈피",
  		QuoteDesc = "욕심 많은 책벌레",
  		Description = "책 아이템 사용 시 충전량 2칸을 보존합니다.#최대치까지 충전하지 않음",
  	},
  	[Retribution.TRINKETS.CRUTCH] 			= {
  		Name = "버팀목",
  		QuoteDesc = "자그마한 보조",
  		Description = "행운 관련 눈물이 적에게 유도되며 눈물 크기가 커집니다.",
  	},
  	[Retribution.TRINKETS.GOATS_EYE] 		= {
  		Name = "염소의 눈",
  		QuoteDesc = "카피캣",
  		Description = "픽업 아이템이 10%의 확률로 하나 더 소환됩니다.",
  	},
  	[Retribution.TRINKETS.GRUBBY_PENNY] 	= {
  		Name = "구더기 페니",
  		QuoteDesc = "친구 부자",
  		Description = "동전 획득 시 아군 자폭 거미를 소환합니다.",
  	},
  	[Retribution.TRINKETS.MOXIES_EYE] 		= {
  		Name = "모시의 눈",
  		QuoteDesc = "지도 시야 증가",
  		Description = "캐릭터가 있는 방에서 2칸 이내에 있는 스테이지 구조 및 특수방을 맵에 표시합니다.#!!! 비밀방류의 위치는 표시하지 않습니다.",
  	},
  	[Retribution.TRINKETS.HEART_WORM] 		= {
  		Name = "심장 벌레",
  		QuoteDesc = "두근두근",
  		Description = "눈물이 Mom's Heart의 탄환과 유사하게 멈추다가 이동하는 것을 반복합니다.#눈물의 최대 사거리가 캐릭터의 사거리보다 20% 더 멀리 나갑니다.",
  	},
  	[Retribution.TRINKETS.ISAACS_BINDLE] 	= {
  		Name = "아이작의 보자기",
  		QuoteDesc = "달려!",
  		Description = "랜덤 픽업 아이템 3개를 드랍합니다.#슬롯/거지류의 속도가 빨라집니다.",
  	},
  	[Retribution.TRINKETS.OPEN_MIND] 		= {
  		Name = "오픈 마인드",
  		QuoteDesc = "더 많은 기회",
  		Description = "선택형 아이템을 모두 획득할 수 있습니다.",
  	},
  	[Retribution.TRINKETS.POCKET_BIBLE] 	= {
  		Name = "미니 성경",
  		QuoteDesc = "악마 배제",
  		Description = "{{MomBossSmall}}Mom, {{MomsHeartSmall}}Mom's Heart/It Lives 보스의 체력이 절반으로 감소합니다.",
  	},
  	[Retribution.TRINKETS.POPSICLE_STICK] 	= {
  		Name = "막대 아이스크림",
  		QuoteDesc = "아~~~앙",
  		Description = "{{Pill}} 부정 알약 사용 시 알약을 하나 드랍합니다.",
  	},
  	[Retribution.TRINKETS.PYRITE] 			= {
  		Name = "황철석",
  		QuoteDesc = "금광",
  		Description = "픽업 아이템이 3%의 확률로 황금 형태로 바뀝니다.#{{LuckSmall}} :행운 7+일 때 5%",
  	},
  	[Retribution.TRINKETS.RAINBOW_PENNY] 	= {
  		Name = "무지개 페니",
  		QuoteDesc = "모든 걸 가진 자",
  		Description = "동전을 주울 시 랜덤 페니류 장신구의 효과를 발동합니다.",
  	},
  	[Retribution.TRINKETS.ROSE_THORNS] 		= {
  		Name = "장미 가시",
  		QuoteDesc = "세상을 향한 채찍",
  		Description = "피격 시 16방향으로 사거리가 짧은 공격력 7의 장미 가시를 발사합니다.",
  	},
  	[Retribution.TRINKETS.RUSTED_PIPE] 		= {
  		Name = "녹슨 파이프",
  		QuoteDesc = "철은 적혈구를 막아버리지",
  		Description = "모든 빨간 똥을 일반 똥으로 바꿉니다.",
  	},
  	[Retribution.TRINKETS.SILVER_TONGUE] 	= {
  		Name = "은색 혓바닥",
  		QuoteDesc = "물물교환",
  		Description = "모든 상점 판매 아이템의 가격이 1{{Coin}} 할인됩니다.",
  	},
  	[Retribution.TRINKETS.SPIRO] 			= {
  		Name = "스피로",
  		QuoteDesc = "성장 차단",
  		Description = "소지한 상태에서 {{Pill}}Puberty 알약 사용 시 {{DamageSmall}}공격력 +0.35#장신구 교체 시 증가한 공격력이 사라지며 다시 주우면 복원됩니다.",
  	},
  	[Retribution.TRINKETS.STRENGTH_BADGE] 	= {
  		Name = "파워 플러스",
  		QuoteDesc = "공격력 증가",
  		Description = "↑ {{DamageSmall}}공격력 +1",
  	},
  	[Retribution.TRINKETS.TRAINING_SEAT] 	= {
  		Name = "트레이닝 시트",
  		QuoteDesc = "이런...",
  		Description = "캐릭터와 패밀리어가 생성하는 장판의 지속시간이 2배로 늘어납니다.#적이 생성하는 장판의 지속시간이 절반으로 짧아집니다.",
  	},
  	[Retribution.TRINKETS.TURNIP] 			= {
  		Name = "무트코인",
  		QuoteDesc = "주식 시장",
  		Description = "방 진입 시 동전의 수가 일정 패턴에 따라 변화합니다.#{{Trinket"..Retribution.TRINKETS.ROTTEN_TURNIP.."}} 방 7개 입장, 교체 및 버리기 시 썩게 됩니다.#썩은 이후에 동전의 변화가 없으며 스테이지 진입 시 다시 복원됩니다.",
  	},
  	[Retribution.TRINKETS.ROTTEN_TURNIP] 	= {
  		Name = "썩은 무트코인",
  		QuoteDesc = "존버",
  		Description = "{{Trinket"..Retribution.TRINKETS.TURNIP.."}} 스테이지 진입 시 다시 복원됩니다.",
  	},
  	[Retribution.TRINKETS.SPOILED_COIN]		= {
  		Name = "코인 대폭락",
  		QuoteDesc = "폭발성 경제",
  		Description = "적 처치 시 적의 최대 체력과 스테이지 진행도에 비례한 확률로 돼지 코인을 드랍합니다..#돼지 코인은 주울 수 있으나 3초 후 폭발합니다.#{{Collectible" .. Retribution.ITEMS.SPOILS_POUCH .. "}}Spoils Pouch로 소환된 코인도 적용됩니다.",
  	},
  	[Retribution.TRINKETS.THICK_SKIN] 		= {
  		Name = "두꺼운 피부",
  		QuoteDesc = "후피동물",
  		Description = "20%의 확률로 받는 피해를 반칸으로 줄입니다.#{{LuckSmall}} :행운 7+일 때 50%",
  	},
  	[Retribution.TRINKETS.THORN_RING] 		= {
  		Name = "가시 반지",
  		QuoteDesc = "체력을 흡수하는 황홀한 얼음",
  		Description = "{{Freezing}} 3%의 확률로 적을 즉사 및 얼리는 눈물을 발사합니다.#전체 체력이 3칸 이상인 경우 30초마다 체력 반칸의 피해를 받으며;#3분동안 빙결 공격 확률이 +7%p 증가합니다.",
  	},
  	[Retribution.TRINKETS.GIRL_PILL] 		= {
  		Name = "에스트라디올",
  		QuoteDesc = "혓바닥의 슬픔",
  		Description = "↑ 피격 시 {{TearsSmall}}공격 딜레이 -3%p(연사 증가)#20회 피격 시 자동으로 흡수됩니다.",
  	},
  	[Retribution.TRINKETS.GLUTTONOUS_SNOUT] = {
  		Name = "탐욕스러운 주둥이",
  		QuoteDesc = "5원으로 자동 흡수",
  		Description = "소지한 장신구를 강제로 5{{Coin}}을 소모하여 흡수합니다.",
  	},
  	[Retribution.TRINKETS.BRANDED_BOWTIE] 	= {
  		Name = "정품 넥타이 리본",
  		QuoteDesc = "부타 사 공식 제품",
  		Description = "방 클리어 시 능력치 캡슐의 등장할 확률 증가#가챠퐁의 등장확률이 증가합니다.",
  	},
  	[Retribution.TRINKETS.YEN_PENNY] 		= {
  		Name = "엔 페니",
  		QuoteDesc = "뽑기 천국",
  		Description = "동전을 주울 시 낮은 확률로 능력치 캡슐을 드랍합니다.#능력치 캡슐 사용 시 그 스테이지에서 랜덤 능력치가 증가합니다.",
  	},
  	[Retribution.TRINKETS.OCCAMS_RAZOR] 		= {
  		Name = "오컴의 면도날",
  		QuoteDesc = "희생의 영광",
  		Description = "{{Collectible" .. CollectibleType.COLLECTIBLE_SANGUINE_BOND .. "}} 희생방 및 Sanguine Bone의 가시에 희생 시 1회분을 추가로 희생합니다.",
  	},
  }
  local rtCardDesc = {
  -- Cards
  	[Retribution.CARDS.DAMAGE_CAPSULE] 				= {
  		Name = "검 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{DamageSmall}}공격력 +0.5",
  	},
  	[Retribution.CARDS.HEALTH_CAPSULE] 				= {
  		Name = "하트 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{Heart}}최대 체력 +1",
  	},
  	[Retribution.CARDS.FIREDELAY_CAPSULE] 				= {
  		Name = "눈물 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{TearsSmall}}연사 +0.25",
  	},
  	[Retribution.CARDS.RANGE_CAPSULE] 					= {
  		Name = "활 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{RangeSmall}}사거리 +1",
  	},
  	[Retribution.CARDS.SHOTSPEED_CAPSULE] 				= {
  		Name = "투척 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{ShotspeedSmall}}탄속 +0.1",
  	},
  	[Retribution.CARDS.SPEED_CAPSULE] 					= {
  		Name = "부츠 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{SpeedSmall}}이동속도 +0.1",
  	},
  	[Retribution.CARDS.LUCK_CAPSULE] 					= {
  		Name = "클로버 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{LuckSmall}}행운 +1",
  	},
  	[Retribution.CARDS.HEALTH_DAMAGE_CAPSULE] 			= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{Heart}}최대 체력 +1#↑ {{DamageSmall}}공격력 +0.5",
  	},
  	[Retribution.CARDS.LUCK_DAMAGE_CAPSULE] 			= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{LuckSmall}}행운 +1#↑ {{DamageSmall}}공격력 +0.5",
  	},
  	[Retribution.CARDS.RANGE_DAMAGE_CAPSULE] 			= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{RangeSmall}}사거리 +1#↑ {{DamageSmall}}공격력 +0.5",
  	},
  	[Retribution.CARDS.SHOTSPEED_DAMAGE_CAPSULE] 		= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{ShotspeedSmall}}탄속 +0.1#↑ {{DamageSmall}}공격력 +0.5",
  	},
  	[Retribution.CARDS.SPEED_DAMAGE_CAPSULE] 			= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{SpeedSmall}}이동속도 +0.1#↑ {{DamageSmall}}공격력 +0.5",
  	},
  	[Retribution.CARDS.FIREDELAY_DAMAGE_CAPSULE] 		= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{TearsSmall}}연사 +0.25#↑ {{DamageSmall}}공격력 +0.5",
  	},
  	[Retribution.CARDS.HEALTH_LUCK_CAPSULE] 			= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{Heart}}최대 체력 +1#↑ {{LuckSmall}}행운 +1",
  	},
  	[Retribution.CARDS.HEALTH_RANGE_CAPSULE] 			= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{Heart}}최대 체력 +1#↑ {{RangeSmall}}사거리 +1",
  	},
  	[Retribution.CARDS.HEALTH_SHOTSPEED_CAPSULE] 		= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{Heart}}최대 체력 +1#↑ {{ShotspeedSmall}}탄속 +0.1",
  	},
  	[Retribution.CARDS.HEALTH_SPEED_CAPSULE] 			= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{Heart}}최대 체력 +1#↑ {{SpeedSmall}}이동속도 +0.1",
  	},
  	[Retribution.CARDS.HEALTH_FIREDELAY_CAPSULE] 		= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{Heart}}최대 체력 +1#↑ {{TearsSmall}}연사 +0.25",
  	},
  	[Retribution.CARDS.LUCK_RANGE_CAPSULE] 			= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{LuckSmall}}행운 +1#↑ {{RangeSmall}}사거리 +1",
  	},
  	[Retribution.CARDS.LUCK_SHOTSPEED_CAPSULE] 		= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{LuckSmall}}행운 +1#↑ {{ShotspeedSmall}}탄속 +0.1",
  	},
  	[Retribution.CARDS.LUCK_SPEED_CAPSULE] 			= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{LuckSmall}}행운 +1#↑ {{SpeedSmall}}이동속도 +0.1",
  	},
  	[Retribution.CARDS.LUCK_FIREDELAY_CAPSULE] 		= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{LuckSmall}}행운 +1#↑ {{TearsSmall}}연사 +0.25",
  	},
  	[Retribution.CARDS.RANGE_SHOTSPEED_CAPSULE] 		= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{RangeSmall}}사거리 +1#↑ {{ShotspeedSmall}}탄속 +0.1",
  	},
  	[Retribution.CARDS.RANGE_SPEED_CAPSULE] 			= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{RangeSmall}}사거리 +1#↑ {{SpeedSmall}}이동속도 +0.1",
  	},
  	[Retribution.CARDS.RANGE_FIREDELAY_CAPSULE] 		= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{RangeSmall}}사거리 +1#↑ {{TearsSmall}}연사 +0.25",
  	},
  	[Retribution.CARDS.SHOTSPEED_SPEED_CAPSULE] 		= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{ShotspeedSmall}}탄속 +0.1#↑ {{SpeedSmall}}이동속도 +0.1",
  	},
  	[Retribution.CARDS.SHOTSPEED_FIREDELAY_CAPSULE] 	= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{ShotspeedSmall}}탄속 +0.1#↑ {{TearsSmall}}연사 +0.25",
  	},
  	[Retribution.CARDS.SPEED_FIREDELAY_CAPSULE] 		= {
  		Name = "콤보 캡슐",
  		QuoteDesc = "",
  		Description = "↑ {{SpeedSmall}}이동속도 +0.1#↑ {{TearsSmall}}연사 +0.25",
  	},
  	[Retribution.CARDS.WHALE_PILL] 					= {
  		Name = "고래 알약",
  		QuoteDesc = "",
  		Description = "4개의 랜덤한 {{Pill}}알약을 사용합니다#1~2개는 거대 알약이 사용됩니다.",
  	},
  	[Retribution.CARDS.GOLDEN_WHALE_PILL] 				= {
  		Name = "황금 고래 알약",
  		QuoteDesc = "",
  		Description = "4개의 랜덤한 {{Pill}}알약을 사용합니다#1~2개는 거대 알약이 사용됩니다.#25%의 확률로 사라집니다.",
  	},
  	[Retribution.CARDS.WHALE_CARD] 					= {
  		Name = "고래 카드",
  		QuoteDesc = "",
  		Description = "6개의 랜덤한 {{Card}}카드를 사용합니다.",
  	},
  	[Retribution.CARDS.JOY_PILL] 						= {
  		Name = "흥분제",
  		QuoteDesc = "",
  		Description = "{{DamageSmall}} 사용 시 흥분 스택 +1, 그 방에서 공격력 배율 x2, 그 다음 방에서 공격력 배율 x0.8#최근 10개의 방 동안 흥분 스택이 3 이상일 때 방 이동 시 최소 1칸의 피해를 받습니다.",
  	},
  	[Retribution.CARDS.EUPHORIA_PILL] 					= {
  		Name = "행복제",
  		QuoteDesc = "",
  		Description = "{{DamageSmall}} 사용 시 흥분 스택 +2, 그 방에서 공격력 배율 x4 + 피격 시 최소 체력 1칸 피해, 그 다음 방에서 공격력 배율 x0.8#최근 10개의 방 동안 흥분 스택이 3 이상일 때 방 이동 시 최소 1칸의 피해를 받습니다.",
  	},
  	[Retribution.CARDS.MONSTER_CANDY] 					= {
  		Name = "몬스터 캔디",
  		QuoteDesc = "",
  		Description = "아군 적의 체력을 전부 회복합니다.",
  	},
  	[Retribution.CARDS.SHATTERED_SHARD] 				= {
  		Name = "주사위 파편",
  		QuoteDesc = "",
  		Description = "방 안의 모든 아이템을 더 높은 등급의 아이템으로 바꿉니다.",
  	},

  -- Runes
  	[Retribution.RUNES.WUNJO] 		= {
  		Name = "원조",
  		QuoteDesc = "",
  		Description = "흥분제 3개를 드랍합니다.",
  	},
  	[Retribution.RUNES.THURISAZ] 	= {
  		Name = "휴리사즈",
  		QuoteDesc = "",
  		Description = "확률적으로 적을 Icarus 스타일로 업그레이드 시키며#업그레이드된 적은 체력이 절반으로 감소합니다.",
  	},
  	[Retribution.RUNES.MANNAZ] 	= {
  		Name = "만나즈",
  		QuoteDesc = "",
  		Description = "{{Collectible" .. Retribution.ITEMS.KAPALA .. "}} 그 방에서 {{DamageSmall}}공격력 배율 x1.5;#적을 맞출 시 같은 종류의 적에게 피해가 분산됩니다.",
  	},
  	[Retribution.RUNES.NAUDIZ]		= {
  		Name = "나우디즈",
  		QuoteDesc = "",
  		Description = "10초동안 0.4초마다 돼지 코인을 뿌립니다.#!!! 3초 후 사라지거나 33%의 확률로 폭발합니다.",
  	},
  }

	for playerType, birthrightdesc in pairs(rtBirthrightDesc) do
		EID:addBirthright(playerType, birthrightdesc.Description, birthrightdesc.Name, "ko_kr")
	end
	for itemID, itemdesc in pairs(rtCollectibleDesc) do
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
		if itemdesc.Belial and itemdesc.Belial ~= "" then
			EID.descriptions["ko_kr"].bookOfBelialBuffs[itemID] = itemdesc.Belial
		end
	end
	for itemID, itemdesc in pairs(rtTrinketDesc) do
		local desc = itemdesc.Description
		if itemdesc.StatusEffects then
			for _, eff in ipairs(itemdesc.StatusEffects) do
				desc = desc .. eff
			end
		end
		EID:addTrinket(itemID, desc, itemdesc.Name, "ko_kr")
	end
	for itemID, itemdesc in pairs(rtCardDesc) do
		EID:addCard(itemID, itemdesc.Description, itemdesc.Name, "ko_kr")
	end
	
	local i_queueLastFrame
	local i_queueNow
	wakaba_krdesc:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function (_, player)
		if Options.Language ~= "kr" then return end
		local descTable = rtCollectibleDesc
		local descTableBR = rtBirthrightDesc
		if not descTable and not descTableBR then return end

		i_queueNow = player.QueuedItem.Item
		if (i_queueNow ~= nil) then
			if i_queueNow.ID == CollectibleType.COLLECTIBLE_BIRTHRIGHT then
				local playerType = player:GetPlayerType()
				for playerID, itemdesc in pairs(descTableBR) do
					if (playerType == playerID and i_queueNow:IsCollectible() and i_queueLastFrame == nil) then
						local itemName = "생득권"
						local queueDesc = itemdesc.QuoteDesc or i_queueNow.Description
						Game():GetHUD():ShowItemText(itemName, queueDesc)
					end
				end
			else
				for itemID, itemdesc in pairs(descTable) do
					if (i_queueNow.ID == itemID and i_queueNow:IsCollectible() and i_queueLastFrame == nil) then
						local itemName = (itemdesc.Name ~= "" and itemdesc.Name) or i_queueNow.Name
						local queueDesc = itemdesc.QuoteDesc or i_queueNow.Description
						Game():GetHUD():ShowItemText(itemName, queueDesc)
					end
				end
			end
		end
		i_queueLastFrame = i_queueNow
	end)


	local t_queueLastFrame
	local t_queueNow
	wakaba_krdesc:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function (_, player)
		if Options.Language ~= "kr" then return end
		local descTable = rtTrinketDesc
		if not descTable then return end

		t_queueNow = player.QueuedItem.Item
		if (t_queueNow ~= nil) then
			for itemID, itemdesc in pairs(descTable) do
				if (t_queueNow.ID == itemID and t_queueNow:IsTrinket() and t_queueLastFrame == nil) then
					local itemName = (itemdesc.Name ~= "" and itemdesc.Name) or t_queueNow.Name
					local queueDesc = itemdesc.QuoteDesc or t_queueNow.Description
					Game():GetHUD():ShowItemText(itemName, queueDesc)
				end
			end
		end
		t_queueLastFrame = t_queueNow
	end)
  
end
