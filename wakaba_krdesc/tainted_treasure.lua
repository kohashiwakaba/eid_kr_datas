
if TaintedTreasure then

	EID._currentMod = "Tainted Treasure Rooms"
	local mod = TaintedTreasure

	local Items = TaintedCollectibles
	local Trinkets = TaintedTrinkets

	local CollectibleDesc = {
		[TaintedCollectibles.ATLAS] = {
			Description = "스테이지 입장 시 최대 4개의 방을 추가로 생성합니다."
			.."#추가되는 방의 종류는 랜덤입니다.",
			Name = "아틀라스",
			QuoteDesc = "더 많은 방",
		},
		[TaintedCollectibles.BAD_ONION] = {
			Description = "{{DamageSmall}} 적 처치 시 빠르게 감소하는 공격력 +1",
			Name = "나쁜 양파",
			QuoteDesc = "나 화났어!",
		},
		[TaintedCollectibles.FORK_BENDER] = {
			Description = "적 탄환을 20%의 확률로 유도 탄환으로 반사합니다.",
			Name = "포크 벤더",
			QuoteDesc = "유도성 반사",
		},
		[TaintedCollectibles.RAW_SOYLENT] = {
			Description = "{{Collectible330}} 공격 시 추가로 360도 기준 나머지 7방향으로 약한 공격을 합니다.",
			Name = "생간장",
			QuoteDesc = "모래 맛이 나...",
		},
		[TaintedCollectibles.YEARNING_PAGE] = {
			Description = "↑ {{BlackHeart}}블랙하트 +1"
			.."#↑ {{DamageSmall}}공격력 +1.5"
			.."#!!! 이후 등장하는 모든 아이템이 확률적으로 {{Collectible35}}The Necronomicon으로 바뀝니다.",
			Name = "그리운 페이지",
			QuoteDesc = "악함, 공격력 증가 + 돌아오고 싶어해",
		},
		[TaintedCollectibles.BUZZING_MAGNETS] = {
			Description = "{{Magnetize}} 17%의 확률로 적을 반발 상태로 만드는 공격이 나갑니다.#{{LuckSmall}} 행운 6+일 때 100%"
			.."#반발 상태의 적은 캐릭터에게 멀어지며 반발력으로 다른 적 및 장애물에 접촉 시 피해를 입습니다.",
			Name = "진동자석",
			QuoteDesc = "극성 뒤집기",
		},
		[TaintedCollectibles.CLANDESTINE_CARD] = {
			Description = "{{Shop}} 상점에 블랙마켓으로 향하는 입구가 등장합니다.",
			Name = "은밀한 카드",
			QuoteDesc = "지하로",
		},
		[TaintedCollectibles.GLAD_BOMBS] = {
			Description = "↑ {{Bomb}}폭탄 +5"
			.."#폭탄이 더 늦게 터집니다."
			.."#폭탄이 적을 향해 눈물을 발사합니다.",
			Name = "웃음 폭탄",
			QuoteDesc = "터렛 폭발 + 폭탄 5개",
		},
		[TaintedCollectibles.CRICKETS_CRANIUM] = {
			Description = "↑ {{DamageSmall}}공격력 +0.5"
			.."#↑ {{DamageSmall}}공격력 배율 x2"
			.."#!!! {{DamageSmall}}공격력이 더 이상 증가하지 않습니다.",
			Name = "크리켓의 머리뼈",
			QuoteDesc = "공격력 증가?",
		},
		[TaintedCollectibles.DIONYSIUS] = {
			Description = "{{Collectible577}} 방 입장 시 랜덤 적 하나 위에 검이 생깁니다."
			.."#검이 있는 적 명중 시 검이 떨어지며 그 적을 즉사, 보스의 경우 80의 피해를 줍니다.",
			Name = "디오니소스",
			QuoteDesc = "그들의 차례다",
		},
		[TaintedCollectibles.CONSECRATION] = {
			Description = "{{Burning}} 10%의 확률로 명중 시 4방향의 화염을 나가게 하는 공격이 나갑니다.#{{LuckSmall}} 행운 9+일 때 50%",
			Name = "축성",
			QuoteDesc = "불꽃 웨이브 공격",
		},
		[TaintedCollectibles.CRYSTAL_SKULL] = {
			Description = "↑ 목숨 +1"
			.."#{{Player16}} 사망 시 전 방에서 The Forgotten({{EmptyBoneHeart}}+{{HalfSoulHeart}})으로 부활합니다.",
			Name = "크리스탈 해골",
			QuoteDesc = "너의 운명을 드려다볼 수 있어",
		},
		[TaintedCollectibles.NO_OPTIONS] = {
			Description = "!!! {{BossRoom}}보스방 처치 시 아이템이 등장하지 않으며 {{DamageSmall}}공격력 +0.8이 대신 증가합니다.",
			Name = "없어진 선택권",
			QuoteDesc = "더 이상의 선택지는 없다",
		},
		[TaintedCollectibles.STEAMY_SURPRISE] = {
			Description = "↓ {{Shop}}상점의 입고량 감소"
			.."#{{Trinket13}} 상점마다 Store Credit 장신구가 하나씩 제공됩니다.",
			Name = "스팀 서프라이즈",
			QuoteDesc = "오! 공짜!",
		},
		[TaintedCollectibles.FINALE] = {
			Description = "!!! 획득 시 Home 스테이지로 즉시 이동하며;"
			.."#{{Heart}} 체력을 전부 회복"
			.."#{{Card78}} Cracked Key + {{TreasureRoom}}보물방 아이템 + 20개의 랜덤 픽업을 소환합니다.",
			Name = "피날레",
			QuoteDesc = "선택된 운명...",
		},
		[TaintedCollectibles.SKELETON_LOCK] = {
			Description = "!!! {{Key}}열쇠 상한이 5개로 감소"
			.."#↑ 열쇠 소모 시 랜덤 능력치 증가",
			Name = "해골 자물쇠",
			QuoteDesc = "제한된 열쇠 + 더 나은 자물쇠",
		},
		[TaintedCollectibles.SALT_OF_MAGNESIUM] = {
			Description = "{{PoopPickup}} 10%의 확률로 적을 강하게 밀쳐내고 똥을 싸게 하는 공격이 나갑니다.#{{LuckSmall}} 행운 9+일 때 50%",
			Name = "마그네슘 소금",
			QuoteDesc = "안정된 느낌",
		},
		[TaintedCollectibles.WHORE_OF_GALILEE] = {
			Description = "!!! {{Heart}}빨간하트가 1칸 이상 + 최대 체력일 때: "
			.."#↑ {{TearsSmall}}연사 +1.35"
			.."#↑ {{RangeSmall}}사거리 +1.5"
			.."#↑ {{LuckSmall}}행운 +1",
			Name = "갈릴레아의 창녀",
			QuoteDesc = "애정 증가",
		},
		[TaintedCollectibles.ETERNAL_CANDLE] = {
			Description = "↑ {{EternalHeart}}이터널하트 +1"
			.."#!!! 항상 저주에 걸립니다."
			.."#↑ 각 저주별 이로운 부가 효과가 제공됩니다.",
			-- 다크니스 : 역선
			-- 메이즈 : 50%의 확률로 모든 맵 제공
			-- 언노운 : 체력이 적을수록 공격력 증가
			-- 블라인드 : 성스러운 오브 효과
			-- 로스트 : 방 클리어 시 20%의 확률로 특수방으로 향하는 포탈 소환
			-- xl : 추가 상점, 악마/천사 방에 추가 품목 (블랙2/이터널2+소울1)
			Name = "영원한 양초",
			QuoteDesc = "저주를 받아들여라",
		},
		[TaintedCollectibles.OVERSTOCK] = {
			Description = "{{Shop}} 모든 상점이 Tainted Keeper의 상점으로 바뀝니다."
			.."#{{Shop}} Womb/Corpse 스테이지에서 상점이 생성됩니다."
			.."#{{Player33}} Tainted Keeper: 가능한 경우, 스테이지 입장 시 상점이 추가로 등장합니다.",
			Name = "과입고",
			QuoteDesc = "끝없는 상점",
		},
		[TaintedCollectibles.SPIDER_FREAK] = {
			Description = "↓ {{TearsSmall}}연사 배율 x0.34#공격이 6발로 나갑니다.",
			Name = "괴물 거미",
			QuoteDesc = "섹스튜플 샷",
		},
		[TaintedCollectibles.BUGULON_SUPER_FAN] = {
			Description = "↑ {{SpeedSmall}}이동속도 +0.3"
			.."#↑ {{LuckSmall}}행운 +1"
			.."#방 입장 시 적에게 던져 피해를 주는 랜덤 오브젝트를 소환합니다.#!!! 폭발물도 있음",
			Name = "버그론 슈퍼 팬",
			QuoteDesc = "게임 만들기 싫어",
		},
		[TaintedCollectibles.ARROWHEAD] = {
			Description = "↑ {{ShotspeedSmall}}탄속 +0.3"
			.."#↑ {{RangeSmall}}사거리 +3"
			.."#공격이 공격방향 앞에서 뒤로 나가며 장애물을 관통합니다."
			.."#캐릭터를 지나간 눈물은 적을 관통하며 x1.5배의 피해를 줍니다.",
			Name = "애로우헤드",
			QuoteDesc = "거꾸로 눈물",
		},
		[TaintedCollectibles.THE_BOTTLE] = {
			Description = "{{Chargeable}} 공격이 발사 후 돌아오는 근접 유리병으로 변경됩니다.#공격키를 누르고 있으면 충전되며 충전량에 따라 공격력과 사거리가 증가합니다.#유리병 공격력: 기본 x0.5 ~ 최대 x18"
			.."#충전 공격 명중 시 병이 깨져 5초동안 공격할 수 없으며 이후 방 입장 시까지 최소 피해량이 x2로 증가합니다.",
			Name = "소주병",
			QuoteDesc = "충전형 스매시",
		},
		[TaintedCollectibles.WHITE_BELT] = {
			Description = "적이 챔피언의 형태로 나올 확률이 감소합니다."
			.."#방 입장 및 피격 시 4초동안 적과 탄환이 캐릭터에게 가까이 가지 못합니다.",
			Name = "하얀 벨트",
			QuoteDesc = "더 쉽게 해!",
		},
		[TaintedCollectibles.D_PAD] = {
			Description = "클리어하지 않은 방에서 때때로 캐릭터 위에 십자키가 등장합니다."
			.."#주어진 방향으로 재빨리 공격 시 {{DamageSmall}}서서히 사라지는 공격력 +3.5"
			.."#!!! 입력 실패 시 무효과",
			Name = "십자키",
			QuoteDesc = "재빠른 반응",
		},
		[TaintedCollectibles.WAR_MAIDEN] = {
			Description = "벽을 향해 돌진하면 반대쪽 벽에서 나옵니다.",
			Name = "워메이든",
			QuoteDesc = "멈출 수 없는",
		},
		[TaintedCollectibles.BASILISK] = {
			Description = "캐릭터와 연결되어 이동하며 적을 따라다니며 접촉한 적에게 공격력 x1.5의 피해를 줍니다."
			.."#!!! 가끔 돌진하며 캐릭터가 살짝 당겨집니다."
			.."#피격 시 33%의 확률로 그 방에서 캐릭터와의 연결이 끊기며 자유롭게 이동합니다.",
			Name = "바실리스크",
			QuoteDesc = "지옥에서 태어난 자",
		},
		[TaintedCollectibles.POISONED_DART] = {
			Description = "{{Weakness}} 캐릭터가 적에게 가까이 다가가면 6초동안 적을 약화시킵니다.",
			Name = "포이즌 다트",
			QuoteDesc = "가까이 가서 약화",
		},
		[TaintedCollectibles.POLYCORIA] = {
			Description = "↓ {{TearsSmall}}연사 배율 x0.25#눈물 여러발을 한번에 발사하며 무언가에 부딪힐 때 각 눈물이 랜덤 방향으로 퍼집니다.",
			Name = "폴리코리아",
			QuoteDesc = "클러스터 샷",
		},
		[TaintedCollectibles.COLORED_CONTACTS] = {
			Description = "↓ {{ShotspeedSmall}}탄속 -0.15#눈물이 적의 탄환을 관통하며 관통한 눈물은 피해량이 1.5배로 증가합니다.",
			Name = "컬러 렌즈",
			QuoteDesc = "프리즘 공격",
		},
		[TaintedCollectibles.REAPER] = {
			Description = "{{Chargeable}} 공격키를 2.5초 이상 누르면 충전되며 공격키를 떼면 공격방향으로 공격력 x0.67의 하얀 불꽃을 여러 발 발사합니다."
			.."#{{Collectible634}} 하얀 불꽃으로 적 처치 시 17%의 확률로 연옥의 유령이 나옵니다.",
			Name = "사신 고추",
			QuoteDesc = "영혼 화염",
		},
		[TaintedCollectibles.DRYADS_BLESSING] = {
			Description = "{{LuckSmall}} 10%의 확률로 적에게 씨앗을 심는 공격이 나갑니다.#{{LuckSmall}} 행운 9+일 때 100%"
			.."#씨앗이 심어진 적 주변에 있으면 모든 능력치 소량 증가",
			Name = "드리아드의 축복",
			QuoteDesc = "생명의 씨앗",
		},
		[TaintedCollectibles.ATG_IN_A_JAR] = {
			Description = "↑ {{Bomb}}폭탄 +5"
			.."#{{Collectible47}} 공격 중 폭탄 설치 시 설치된 폭탄이 조준형 미사일로 바뀝니다.",
			Name = "ATG 병",
			QuoteDesc = "공습 폭격 + 폭탄 5개",
		},
		[TaintedCollectibles.BROODMIND] = {
			Description = "!!! 모든 자폭 파리/거미가 더 이상 적을 향해 자동으로 공격하지 않으며 확률적으로 2회 이상 피해를 줍니다."
			.."#자폭 파리가 공격방향을 향해 갔다가 돌아옵니다."
			.."#자폭 거미가 공격방향에 있는 적을 우선합니다."
			.."#아군 파란 파리 또는 거미의 소환량이 2배로 증가합니다.",
			Name = "브루드 마인드",
			QuoteDesc = "그들은 명령을 기다리고 있다",
		},
		[TaintedCollectibles.TECH_ORGANELLE] = {
			Description = "캐릭터와 모든 눈물 및 폭탄 사이에 전류 레이저가 흐르며 레이저에 접촉한 적은 초당 공격력 x0.33의 피해를 입습니다.",
			Name = "테크 오르가넬",
			QuoteDesc = "미트웨어 전류",
		},
		[TaintedCollectibles.GAZEMASTER] = {
			Description = "{{SecretRoom}} 스테이지 입장 시 비밀방과 일급비밀방의 구조가 특수하게 바뀝니다.",
			Name = "게이즈마스터",
			QuoteDesc = "과거 엿보기",
		},
		[TaintedCollectibles.SEARED_CLUB] = {
			Description = "!!! 적 처치 시 폭발합니다."
			.."#캐릭터의 폭탄 아이템의 영향을 받습니다."
			.."#!!! 폭발 반경은 적의 최대 체력에 비례합니다.",
			Name = "찢어진 클럽",
			QuoteDesc = "폭발하는 적",
		},
		[TaintedCollectibles.LEVIATHAN] = {
			Description = "↓ 모든 능력치 대폭 감소"
			.."#클리어하지 않은 방 입장 시 50%의 확률로 {{Collectible36}}똥이나 {{Collectible56}}오줌을 쌉니다."
			.."#↑ 위 효과 10회 발생 시 모든 능력치 대폭 증가",
			Name = "레비아탄",
			QuoteDesc = "무언가가 안에서 자라고 있어",
		},
		[TaintedCollectibles.RAVENOUS] = {
			Description = "{{Coin}}동전, {{Bomb}}폭탄, {{Key}}열쇠 +1#↑ 가장 많이 소지중인 픽업 +11"
			.."#모든 능력치의 10%를 가장 높은 능력치로 바꿉니다.",
			Name = "굶주림",
			QuoteDesc = "힘을 몰빵",
		},
		[TaintedCollectibles.SORROWFUL_SHALLOT] = {
			Description = "주기적으로 캐릭터에게서 랜덤 방향으로 눈물을 흩뿌립니다. ({{DamageSmall}}/{{Tears}} 비례)"
			.."#적 처치 시 짧은 시간동안 더 많이 흩뿌립니다.",
			Name = "외로운 샬롯",
			QuoteDesc = "우울함 증가",
		},
		[TaintedCollectibles.OVERCHARGED_BATTERY] = {
			Description = "액티브 아이템에 추가 충전량이 생깁니다."
			.."#추가 충전량이 꽉 찬 상태에서 액티브 아이템 사용 시 랜덤 방향으로 공격력 x3의 장애물을 파괴하는 짧은 레이저가 나갑니다.",
			Name = "초과충전 배터리",
			QuoteDesc = "머리카락이 솟아나",
		},
		[TaintedCollectibles.LIL_SLUGGER] = {
			Description = "↓ {{TearsSmall}}연사 배율 x0.4#공격이 톱날로 변경됩니다.#톱날은 적에게 다단히트로 공격력 x1의 피해를 주며 적을 관통, 벽을 따라서 움직입니다."
			.."#캐릭터의 바로 앞에 있는 적에게 다단히트 피해를 줍니다.",
			Name = "리틀 슬러거",
			QuoteDesc = "톱날 공격",
		},
		[TaintedCollectibles.BLUE_CANARY] = {
			Description = "캐릭터의 몸통이 바라보는 방향으로 손전등을 비추며 빛 안에 들어온 적을 발광시킵니다."
			.."#7.5초마다 발광된 적이 (캐릭터의 공격력 x1.3 x 발광된 적 수)의 피해를 입으며 발광 상태가 해제됩니다.",
			Name = "파랑새",
			QuoteDesc = "조심스러운 필리버스터",
		},
		[TaintedCollectibles.WORMWOOD] = {
			Description = "오라를 가지고 {{BossRoom}}보스방이 있는 곳으로 이동합니다."
			.."#!!! 캐릭터가 오라 안에 있을 시 {{DamageSmall}}x0.2, {{TearsSmall}}x0.2"
			.."#캐릭터가 먼저 {{BossRoom}}보스방 도달 시 영구적으로 {{TearsSmall}}연사 +0.5"
			.."#오라가 먼저 {{BossRoom}}보스방 도달 시 그 스테이지에서 범위가 보스방 전체로 확대",
			Name = "웜우드",
			QuoteDesc = "빛으로부터 피해",
		},
		[TaintedCollectibles.MAELSTROM] = {
			Description = "피격 시 '칼날 소용돌이' 스택이 추가됩니다. (최대 3)"
			.."#공격키를 2번 누르면 스택을 하나 소모하여 칼날 소용돌이를 발동, 톱날을 0.6초동안 반시계 4방향으로 날립니다.",
			Name = "마엘스트롬",
			QuoteDesc = "더블탭 소용돌이",
		},
		[TaintedCollectibles.EVANGELISM] = {
			Description = "↑ {{DamageSmall}}공격력 +0.5"
			.."#↓ {{ShotspeedSmall}}탄속 -0.3"
			.."#↓ {{Tears}}연사 -0.6"
			.."#눈물에 후광이 생기며 후광에 오랫동안 닿은 적은 공격력 x5의 빛줄기 피해를 받습니다.",
			Name = "에반겔리즘",
			QuoteDesc = "도그마 눈물",
		},
		[TaintedCollectibles.LIL_ABYSS] = {
			Description = "대각선으로 돌아다니며 접촉한 적에게 초당 30의 피해를 줍니다."
			.."#주변의 눈물과 적 탄환을 끌어들여 흡수, 12회 흡수 시 적을 향해 눈물을 대량으로 발사합니다."
			.."#!!! 주변의 장신구를 2개 소모하여 심연의 유령 1마리를 소환합니다.",
			Name = "리틀 어비스",
			QuoteDesc = "항상 배고파",
		},
		[TaintedCollectibles.SWORD] = {
			Description = "캐릭터가 보는 방향에서 앞뒤로 움직이면서 접촉하는 적에게 초당 1의 피해를 줍니다."
			.."#적을 일정 시간동안 꽂을 수 있으며 꽃힌 적은 적에게 피해를 주며 장애물에 피해를 받습니다.#적을 꽃은 후 일정 시간동안 다시 꽂을 수 없습니다.",
			Name = "소드",
			QuoteDesc = "상어 코",
		},
		[TaintedCollectibles.CONTRACT_OF_SERVITUDE] = {
			Description = "획득한 캐릭터에 따라 효과가 달라집니다.",
			Name = "예속의 계약",
			QuoteDesc = "???",
		},
	}
	local TrinketDesc = {
		[Trinkets.PURPLE_STAR] = {
			Name = "퍼플스타",
			Description = "Tainted Treasure 방 확률 증가#Womb/Corpse 스테이지에서 Tainted Treasure 방이 등장할 수 있습니다.",
			QuoteDesc = "뒤틀린 보물",
		},
	}
	local ContractDesc = { --Index = player type, first entry = item description, second entry = EID description
		[PlayerType.PLAYER_BLUEBABY] = {"이제 외롭지 않아", "#{{Player4}} {{Collectible320}}???'s Only Friend의 강화 파리가 제공됩니다."},
		[PlayerType.PLAYER_JUDAS] = {"벨리알 소년", "#{{Player3}} 액티브 아이템 사용 시 순간적으로 강해지는 패밀리어가 추가됩니다."},
		[PlayerType.PLAYER_AZAZEL_B] = {"벨페고르", "#{{Player28}} 캐릭터의 반대방향으로 재채기하는 패밀리어가 추가됩니다."},
		[PlayerType.PLAYER_BETHANY] = {"그녀의 소중한 것", "#{{Player18}} 적의 눈물을 막아주는 눈물을 발사하는 무적 불꽃이 추가됩니다."},
		[PlayerType.PLAYER_BLUEBABY_B] = {"잊어버렸어", "#{{Player25}} 아군 Polty 패밀리어가 추가됩니다.#Polty에게 똥을 던지면 Polty가 적을 향해 자동으로 던져줍니다."},
		[PlayerType.PLAYER_LILITH] = {"아스모데우스", "#{{Player13}} {{Collectible360}} Incubus 주변을 돌며 공격력 x0.25의 눈물을 발사하는 패밀리어가 추가됩니다."},
		[PlayerType.PLAYER_MAGDALENE] = {"나도 사랑해", "#{{Player1}} 대각선으로 돌아다니며 주변에 있는 캐릭터의 피격을 확률적으로 방지해주는 패밀리어가 추가됩니다."},
		[PlayerType.PLAYER_SAMSON] = {"자기자극", "#{{Player6}} 방 입장 시 50%의 확률로 피격 효과를 1회 발동합니다."},
		[PlayerType.PLAYER_THEFORGOTTEN] = {"내 동생", "#{{Player16}} The Forgotten: 적을 향해 공격력 x0.5의 눈물을 자동으로 발사합니다.#The Soul: 본체 근처의 적에게 공격력 x2의 뼈다귀를 자동으로 휘두릅니다."},
		[PlayerType.PLAYER_THESOUL] = {"내 동생", "#{{Player16}} The Forgotten: 적을 향해 공격력 x0.5의 눈물을 자동으로 발사합니다.#The Soul: 본체 근처의 적에게 공격력 x2의 뼈다귀를 자동으로 휘두릅니다."},
		[PlayerType.PLAYER_CAIN_B] = {"더블탭 복제", "#{{Player23}} {{Throwable}} 공격 키를 두 번 누른 방향으로 날아가며 픽업에 접촉 시 그 픽업을 복사합니다.#방 클리어 시 확률적으로 재사용 가능"},
	}

	local currlang = "en_us"
	wakaba_krdesc:AddPriorityCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, CallbackPriority.LATE, function(_, pickup) ---@param pickup EntityPickup
		if pickup.SubType ~= TaintedCollectibles.CONTRACT_OF_SERVITUDE then return end
		local d = pickup:GetData()
		local currlang = "en_us"
		if d.w_eid_lang and d.w_eid_lang == EID:getLanguage() then return end
		d.w_eid_lang = EID:getLanguage()

		if d.w_eid_lang == "ko_kr" then
			d.EID_Description = nil
		else
			if collectible.SubType == TaintedCollectibles.CONTRACT_OF_SERVITUDE and EID then
				local players = mod:GetAllPlayers()
				for i, player in pairs(players) do
					if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) and mod.ContractEffects[player:GetPlayerType()][2] then
						if not collectible:GetData()["EID_Description"] then
							collectible:GetData()["EID_Description"] = "Grants a unique familiar for each character" .. mod.ContractEffects[player:GetPlayerType()][2]
						else
							collectible:GetData()["EID_Description"] = collectible:GetData()["EID_Description"] .. mod.ContractEffects[player:GetPlayerType()][2]
						end
					end
				end
			end
		end
	end, PickupVariant.PICKUP_COLLECTIBLE)



	local i_queueLastFrame = {}
	local i_queueNow = {}

  ---@param player EntityPlayer
	wakaba_krdesc:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function (_, player)
		if not (Options.Language == "kr" or REPKOR) then return end

		local initSeed = tostring(player.InitSeed)

		i_queueNow[initSeed] = player.QueuedItem.Item
		if (i_queueNow[initSeed] ~= nil and i_queueLastFrame[initSeed] == nil) then
      local q = i_queueNow[initSeed] ---@type ItemConfigItem
      if q:IsCollectible() then
        if q.ID == TaintedCollectibles.CONTRACT_OF_SERVITUDE then
          if ContractDesc[player:GetPlayerType()] then
            local entry = ContractDesc[player:GetPlayerType()]
						local itemName = "예속의 계약"
						local queueDesc = entry[1]
            if queueDesc then
              Game():GetHUD():ShowItemText(itemName, queueDesc)
            end
          end
        end
      end
		end
		i_queueLastFrame[initSeed] = i_queueNow[initSeed]
	end)

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

	local function FF_EIDKR_TTCCondition(descObj)
		if EID:getLanguage() ~= "ko_kr" and EID:getLanguage() ~= "ko" then return false end
		return
			descObj.ObjType == 5
			and descObj.ObjVariant == 100
			and descObj.ObjSubType == TaintedCollectibles.CONTRACT_OF_SERVITUDE
			and EID.player
			and ContractDesc[EID.player:GetPlayerType()] ~= nil
	end

	local function FF_EIDKR_TTCDescCallback(descObj)
		local player = EID.player
		local d = ContractDesc[player:GetPlayerType()] and ContractDesc[player:GetPlayerType()][2]
		if d ~=nil then
			local playerName = player:GetName()
			local playerID = player:GetPlayerType()
			EID:appendToDescription(descObj, "#"..EID:GetPlayerIcon(playerID) .. " {{ColorGray}}"..playerName.."{{CR}}#"..d.."#")
		end
		return descObj
	end

	EID:addDescriptionModifier("FF_EIDKR_Contract", FF_EIDKR_TTCCondition, FF_EIDKR_TTCDescCallback)

	return {
		targetMod = "Tainted Treasure Rooms",
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
	}

end