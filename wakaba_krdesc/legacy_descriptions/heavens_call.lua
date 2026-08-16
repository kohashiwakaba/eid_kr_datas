
if HeavensCall then
	if not REPENTOGON then
		table.insert(wakaba_krdesc.ERRORS, {
			NO_RGON = true,
			err_mod = "Heaven's call",
		})
		return
	end

	EID._currentMod = "Heaven's call"
	local mod = HeavensCall

	local V_REPLACE = 0
	local V_APPEND = 1

	local Items = mod.Items
	local Trinkets = mod.Trinkets

	local CollectibleDesc = {
		--#region TAINTED PLANETARIUMS
		[Items.Mercurius] = {
			Description = "↑ {{SpeedSmall}}이동속도 +0.23#비행 능력을 얻습니다.#7%의 확률로 적 처치 시 꼬마 아이작 패밀리어를 소환하는 {{ColorTransform}}비스무트{{ColorText}} 공격이 나갑니다.#{{LuckSmall}} 행운 14+일 때 50%#{{Collectible77}} 방 입장 시 5%의 확률로 My Little Unicorn 아이템의 효과를 발동합니다.",
			Name = "수성?",
			QuoteDesc = "당신만의 군대",
		},
		[Items.Venus] = {
			Description = "#{{Collectible687}} 적 15마리 처치 시 캐릭터가 움직이는 방향으로 움직이며 공격하는 방향으로 공격하는 아군 적을 소환합니다.#{{Burning}} 아군 몬스터는 Ctrl 버튼을 꾹 누르면 처치되며 최대 체력에 반비례한 확률로 {{Burning}}불타는 하트를 드랍합니다.#{{Trinket186}} 불타는 하트를 집으면 공격하는 방향으로 돌진하는 Willo를 소환합니다.",
			Name = "금성?",
			QuoteDesc = "밀랍 친구들!",
		},
		[Items.Terra] = {
			Description = "방 입장 시 사과를 소환합니다.#사과를 집으면 체력이 가장 많은 적에게 초당 7의 피해를 주는 뱀을 소환합니다.#시간이 지날 수록 사과가 익으며(최대 2회) 사과 단계에 따라 뱀의 피해량이 증가합니다.",
			Name = "지구?",
			QuoteDesc = "선악과",
		},
		[Items.Mars] = {
			Description = "#사용 시 일정 시간동안 캐릭터가 강한 넉백을 받는 폭발성 레이저를 발사합니다.#발동 중일 때 {{ColorLime}}{{DamageSmall}}x2.5/{{TearsSmall}}x15/{{RangeSmall}}+1.75/{{ShotspeedSmall}}x3{{CR}}, {{ColorRed}}{{SpeedSmall}}-1.2{{CR}}#{{Blank}} 적 처치 시 남은 시간 연장 가능 #!!! 가능한 경우, 카드/알약 슬롯에 배정됩니다.",
			Name = "화성?",
			QuoteDesc = "죽이기 위해 태어난 존재",
		},
		[Items.Jupiter] = {
			Description = "#캐릭터의 위치에 전류가 생깁니다.#전류를 원형으로 완성하면 그 전류에서 레이저 공격을 생성합니다.#!!! 특정 오브젝트에 레이저 공격이 닿을 경우:#{{Slotmachine}} 슬롯류: 폭발 or 무료 1회#{{Battery}} 배터리: 폭발 or 픽업 업그레이드#!!! 상점 주인 : 아군 몬스터로 부활",
			Name = "목성?",
			QuoteDesc = "고압 전류",
		},
		[Items.Saturnus] = {
			Description = "#{{TimerSmall}} 사용 시 방 안의 모든 적 및 눈물/레이저/폭탄의 움직임이 5초간 멈춥니다.#{{Blank}} (레이저는 {{Collectible222}} 효과 적용)#{{Blank}} (설치한 폭탄은 효과 종료 즉시 폭발)#{{ArrowUp}} 발동 중일 때 {{SpeedSmall}}=2/{{TearsSmall}}x3#!!! 가능한 경우, 카드/알약 슬롯에 배정됩니다.",
			Name = "토성?",
			QuoteDesc = "간이 슬로우 모션",
		},
		[Items.Uranus] = {
			Description = "{{PoopPickup}} 공격 반대방향으로 똥 방울이 나갑니다.#{{PoopPickup}} 똥 방울에 맞은 적은 5초동안 {{Weakness}}약화되며 캐릭터의 {{TearsSmall}}/{{DamageSmall}}을 증가시키는 장판을 생성합니다.#{{Collectible725}} 약화된 적 처치 시 그 위치에 IBS 똥을 소환하며; #{{Collectible576}} 적 처치 실패 시 아군 Dip 패밀리어를 소환합니다.",
			Name = "천왕성?",
			QuoteDesc = "뿌지직 천국",
		},
		[Items.Neptunus] = {
			Description = "{{Throwable}} 공격하는 방향으로 삼지창을 날릴 수 있습니다.#삼지창으로 적 처치 시 4%의 확률로 블랙홀을 소환합니다.#{{LuckSmall}} 행운 20+일 때 15%",
			Name = "해왕성?",
			QuoteDesc = "심연이 우리를 드려다볼 때",
		},
		[Items.Luna] = {
			Name = "달?",
			Description = ""
			.."#!!! 무효과 (미구현 아이템)"
			.."{{CR}}",
			QuoteDesc = "곁에 있지만, 네 것이 아냐",
		},
		[Items.Sol] = {
			Name = "태양?",
			Description = ""
			.."#!!! 무효과 (미구현 아이템)"
			.."{{CR}}",
			QuoteDesc = "The morning star, bearer of light",
		},
		--#endregion

		--#region SOLAR ITEMS
		[mod.SolarItems.HyperDice] = {
			Name = "하이퍼 주사위",
			Description = ""
			.."#특수방 근처에서 사용 시 그 방을 다른 특수방으로 바꿉니다."
			.."#!!! 이미 들어간 방에는 사용 불가"
			.."{{CR}}",
			QuoteDesc = "공간을 바꾸는 능력",
		},
		[mod.SolarItems.SpaceJam] = {
			Name = "우주 잼",
			Description = ""
			.."#하늘에서 과일이 떨어집니다."
			.."#과일 획득 시 증발성 능력치 증가"
			.."#과일이 땅에 닿을 때 주변의 적에게 {{DamageSmall}}/{{TearsSmall}} 비례 폭발 피해를 줍니다."
			.."{{CR}}",
			QuoteDesc = "스타베리",
		},
		[mod.SolarItems.AsteroidBelt] = {
			Name = "소행성 벨트",
			Description = ""
			.."#{{Coin}}/{{Bomb}}/{{Key}} 각각 20개마다:"
			.."#>>> 각 픽업별 공전형 패밀리어를 얻습니다."
			.."{{CR}}",
			QuoteDesc = "우주의 허리",
		},
		[mod.SolarItems.Stallion] = {
			Name = "헤랄드의 종마",
			Description = ""
			.."#종마 근처에서 {{ButtonRT}} 버튼을 꾹 누르면 탑승합니다."
			.."#!!! {{ColorTransform}}탑승 중일 때:"
			.."#>>> {{SpeedSmall}}+0.25/가시,장판면역/장애물파괴"
			.."#>>> 돌진 시 적에게 피해"
			.."#!!! {{ColorTransform}}탑승 중이지 않을 때:"
			.."#>>> 적 경로 방해 및 탄환 방어"
			.."#>>> 방귀 및 독구름 생성"
			.."#>>> 종마를 밀어 움직일 수 있음"
			.."{{CR}}",
			QuoteDesc = "[버리기]를 꾹 눌러 타자",
		},
		[mod.SolarItems.Panspermia] = {
			Name = "팬스페르미아",
			-- "#{{ArrowUp}} {{Heart}} +1 Health # Damaging enemies charges blood # Double tap the attack button to release a flesh whip that does heavy damage, consuming one blood charge # Overcharging blood consumes it all and drops half a red heart #{{HealingRed}} 25% chance to heal half a heart every 30 seconds"
			Description = ""
			.."#↑ {{Heart}}최대 체력 +1"
			.."#적 명중 시 심장 게이지를 충전합니다. (최대 3)"
			.."#!!! 공격 키를 두 번 눌러 심장 게이지를 1칸 소모하고:"
			.."#>>> 공격방향으로 적에게 최대 90의 피해를 주는 채찍을 휘두릅니다."
			.."#!!! 심장 게이지 초과 충전 시 전부 소진 후 {{HalfHeart}}를 드랍합니다."
			.."#{{HealingRed}} 30초마다 25%의 확률로 빨간하트 반칸을 회복합니다."
			.."{{CR}}",
			QuoteDesc = "피의 그릇",
		},
		[mod.SolarItems.Theia] = {
			Name = "테이아",
			-- "# Grants a large Theia familiar chained to the player # Theia leaps at enemies to attack and may occasionally target the player # When idle, the player can pull her by moving # While attacking, the player is dragged by the chain # Theia breaks rocks #{{Rune}} Holding a rune grants Theia special abilities"
			Description = ""
			.."#캐릭터와 연결되어 이동하며 접촉한 장애물을 부숩니다."
			.."#접촉한 적에게 초당 30의 피해를 줍니다."
			.."#근처의 적을 향해 돌진하며;"
			.."#>>> !!! 캐릭터도 같이 끌려갑니다."
			.."#!!! 2%의 확률로 적이 아닌 캐릭터를 공격합니다. ({{HalfHeart}}, 패널티 미발동)"
			.."#{{Rune}} 룬 소지 중일 때 ???"
			.."{{CR}}",
			QuoteDesc = "아틀라스의 족쇄",
		},
		[mod.SolarItems.Engine] = {
			Name = "로켓 엔진",
			-- "# Replaces Isaac's attack with a continuous short-range flame # The engine overheats if used too long, disabling the flame until it cools down # Higher {{Tears}} increases flame duration before overheating # Higher {{Shotspeed}} speeds up cooling"
			Description = ""
			.."#{{Chargeable}} 공격이 짧은 불길 레이저로 바뀝니다."
			.."#{{DamageSmall}} 불길은 적에게 초당 캐릭터의 공격력 x10의 피해를 줍니다."
			.."#!!! 오랫동안 공격 시 일정 시간동안 공격 불가"
			.."#{{TearsSmall}} 연사에 비례하여 공격 가능 지속시간 증가"
			.."#{{ShotspeedSmall}} 탄속에 비례하여 충전속도 증가"
			.."{{CR}}",
			QuoteDesc = "오버드라이브!",
		},
		[mod.SolarItems.Battery] = {
			Name = "천체 배터리",
			-- "# Using an active item discharges it and spawns an {{ColorTransform}}item spark{{ColorText}} # Item sparks behave like active item wisps, triggering the effect when destroyed # If the active item is used without enough charge, the oldest spark is consumed instead"
			Description = ""
			.."#{{Battery}} 액티브 아이템 사용 시도 시:"
			.."#>>> 아이템 발동을 무효화하며;"
			.."#>>> 아이템 스파크를 하나 소환합니다."
			.."#완충 상태가 아닐 때 스파크를 소모하여 액티브 아이템을 사용할 수 있습니다."
			.."{{CR}}",
			QuoteDesc = "별빛 키우기",
		},
		[mod.SolarItems.Mothership_01] = {
			Name = "수정 모듈",
			-- "#{{1}} Fires a laser that infects enemies; infected enemies spawn friendly maggots on death #{{2}} Infected enemies become charmed #{{3}} Isaac can keep 2 additional maggots between rooms # Increases power when combined with other Mothership modules # Other Mothership modules appear more often", "The Inseminator"
			Description = ""
			.."#!!! 모듈 소지 종류에 따라 효과 강화:"
			.."#{{1}} 적에게 감염성 레이저 발사 + 감염된 적 처치 시 아군 Maggot 소환"
			.."#{{2}} {{Charm}} 감염된 적 매혹"
			.."#{{3}} 방 입장 시 최대 2마리의 Maggot 유지"
			.."#!!! 소지 중일 때 모듈 등장 확률 증가"
			.."{{CR}}",
			QuoteDesc = "생명 파츠",
		},
		[mod.SolarItems.Mothership_02] = {
			Name = "권총 모듈",
			-- "#{{1}} Automatically fires at nearby enemies #{{2}} Increased damage and spectral tears #{{3}} Rocket launcher # Increases power when combined with other Mothership modules # Other Mothership modules appear more often", "The Pistol"
			Description = ""
			.."#!!! 모듈 소지 종류에 따라 효과 강화:"
			.."#{{1}} 적을 향해 자동으로 눈물 발사 ({{Damage}}:2 x6)"
			.."#{{2}} {{Damage}}:4 x9 / 장애물 관통"
			.."#{{3}} 로켓을 추가로 발사 ({{Damage}}:50/자해 없음)"
			.."#!!! 소지 중일 때 모듈 등장 확률 증가"
			.."{{CR}}",
			QuoteDesc = "공격 파츠",
		},
		[mod.SolarItems.Mothership_03] = {
			Name = "관통 모듈",
			-- "#{{1}} Destroys tinted and golden rocks #{{2}} Opens secret rooms and stone chests #{{2}} Destroys spiked rocks and Bishops #{{3}} Opens crawlspaces # Increases power when combined with other Mothership modules # Other Mothership modules appear more often", "The Penetrator"
			Description = ""
			.."#!!! 모듈 소지 종류에 따라 효과 강화:"
			.."#{{1}} 색돌, 황금돌 파괴"
			.."#{{2}} {{SecretRoom}} 비밀방, 돌상자 개방"
			.."#{{2}} 가시돌, Bishop 파괴"
			.."#{{3}} {{LadderRoom}} 사다리방으로 가는 다락문 생성"
			.."#!!! 소지 중일 때 모듈 등장 확률 증가"
			.."{{CR}}",
			QuoteDesc = "지원 파츠",
		},
		[mod.SolarItems.Mothership_04] = {
			Name = "보호 모듈",
			-- "#{{1}} Grants a shield every 5 rooms #{{2}} Grants a shield every 3 rooms #{{2}} Blocks projectiles #{{3}} Isaac can stack two shields # Increases power when combined with other Mothership modules # Other Mothership modules appear more often", "The Protector"
			Description = ""
			.."#!!! 모듈 소지 종류에 따라 효과 강화:"
			.."#{{1}} 방 5개 클리어 시 피해 무효 +1회 (최대 1)"
			.."#{{2}} 방 3개 클리어 시 피해 무효 +1회 (최대 1)"
			.."#{{2}} 모선이 적 탄환을 막아줍니다."
			.."#{{3}} 방 3개 클리어 시 피해 무효 +1회 (최대 2)"
			.."#!!! 소지 중일 때 모듈 등장 확률 증가"
			.."{{CR}}",
			QuoteDesc = "보호 파츠",
		},
		[mod.SolarItems.Telescope] = {
			Name = "황금 망원경",
			-- "# When leaving a floor, all unvisited rooms convert into bonus golden rooms on the next floor # Golden rooms are lower weight than standard rooms # Large rooms count as multiple # Unvisited golden rooms also carry over #{{ArrowUp}} +2 Luck", "Golden Telescope"
			Description = ""
			.."#↑ {{LuckSmall}}행운 +2"
			.."#가능한 경우, 스테이지 진입 시 이전 스테이지의 방문하지 않은 방의 수만큼 황금의 방을 추가로 생성합니다."
			.."#황금의 방은 일반 방에 비해 희귀한 구조가 더 많이 등장합니다."
			.."{{CR}}",
			QuoteDesc = "더 많은 방",
		},
		[mod.SolarItems.Quasar] = {
			Name = "퀘이사",
			-- "# On use, if collectibles are present in the room, consumes no charges and absorbs them # Each absorbed item grants charges based on its quality + 1 x4 # On use, if no collectibles are present, creates two twin giant lasers for a few seconds, consuming one charge #{{Warning}} This item can only be recharged by absorbing collectibles", "Quasar"
			Description = ""
			.."#!!! 방 클리어로 충전 불가"
			.."#{{Battery}} 사용 시:"
			.."#>>> 그 방의 아이템을 흡수하여 (등급+1)*4만큼 충전합니다."
			.."#{{Battery}} 그 방에 아이템이 없을 때 사용 시 충전량 1칸을 소모하여;"
			.."#>>> 2초간 양쪽으로 거대 레이저를 발사, 적에게 최대 3500의 피해를 줍니다."
			.."{{CR}}",
			QuoteDesc = "천체 파괴자",
		},
		[mod.SolarItems.RedShovel] = {
			Name = "붉은 삽",
			-- "# On use, Isaac enters a red trapdoor leading to a parallel floor at the same progression point # While on the red floor, the shovel becomes {{Collectible84}} and reverts after completing the floor", "Red Shovel"
			Description = ""
			.."#{{Battery}} 사용 시:"
			.."#>>> 빨간 트랩도어를 소환합니다."
			.."#빨간 트랩도어 입장 시 스테이지를 재시작합니다."
			.."#>>> !!! 진행 루트가 바뀔 수 있음"
			.."#{{RedRoom}} 재시작한 스테이지에서는 삽이 {{Collectible84}}로 바뀌며 모든 방이 빨간방으로 설정됩니다."
			.."#다음 스테이지 진입 시 삽이 복원됩니다."
			.."{{CR}}",
			QuoteDesc = "토끼굴로",
		},
		[mod.SolarItems.Picatrix] = {
			Name = "피카트릭스",
			-- "# On use, spawns an astral image of the player that orbits around them # The astral image has all the player's original items as item wisps and attacks simultaneously with the player # The astral image disappears when changing rooms or if all wisps are lost", "Picatrix"
			Description = ""
			.."#{{Room}} 사용 시 그 방에서 환영을 소환합니다."
			.."#>>> 환영은 캐릭터 주변을 돌며 공격방향으로 캐릭터의 공격과 같은 공격을 발사합니다."
			.."#>>> 환영 소환 시 캐릭터가 소지한 아이템 위습을 같이 할당합니다."
			.."#할당된 아이템 위습이 전부 사라지거나 방 이동 시 환영이 사라집니다."
			.."{{CR}}",
			QuoteDesc = "별의 수호자",
		},
		[mod.SolarItems.LilSol] = {
			Name = "리틀 솔",
			-- "# Grants a Lil Sol familiar that bounces around the room # Has an aura similar to {{Collectible417}}, behaving like the one from {{Collectible543}} # All Lil Moon familiars will orbit Lil Sol instead of Isaac", "Lil Sol"
			Description = ""
			.."#{{Collectible417}} 흰 오라를 가지고 대각선으로 이동합니다."
			.."#{{Collectible543}} 오라 안에 들어온 캐릭터의 공격력 x1.2, 연사 x2.5"
			.."#모든 위성 패밀리어가 Lil Sol 주변을 돕니다."
			.."{{CR}}",
			QuoteDesc = "무적의 태양",
		},
		[mod.SolarItems.Mochi] = {
			Name = "모찌",
			-- "# {{ArrowUp}} +1 Health # {{HealingRed}} Heals 1 heart # {{ArrowUp}} +0.25 Tears # {{ArrowUp}} +0.25 Damage # {{ArrowUp}} +1 Luck # {{LunarHC}} x2 Lunar Pact chance", "Mochi"
			Description = ""
			.."#↑ {{Heart}}최대 체력 +1"
			.."#↑ {{HealingRed}}빨간하트 +1"
			.."#↑ {{TearsSmall}}연사 +0.25"
			.."#↑ {{DamageSmall}}공격력 +0.25"
			.."#↑ {{LuckSmall}}행운 +1"
			.."#{{LunarHC}} 악마방이 공월방으로 으로 대체될 확률 x2"
			.."#{{LunarHC}} {{ColorGray}}공월방은 거래 아이템의 등급이 높으나 거래 시 {{BrokenHeart}}가 추가됩니다."
			.."{{CR}}",
			QuoteDesc = "수제 모찌",
		},
		[mod.SolarItems.Wormhole] = {
			--Name = "",
			Description = ""
			.."#!!! 미구현"
			.."{{CR}}",
			--QuoteDesc = "",
		},
		[mod.SolarItems.Friend] = {
			--Name = "",
			Description = ""
			.."#!!! 미구현"
			.."{{CR}}",
			--QuoteDesc = "",
		},
		--#endregion
	}

	--unimplemented
	CollectibleDesc[mod.SolarItems.SunGlasses] = CollectibleDesc[mod.SolarItems.Wormhole]
	CollectibleDesc[mod.SolarItems.Jupiter] = CollectibleDesc[mod.SolarItems.Wormhole]
	CollectibleDesc[mod.SolarItems.Scepter] = CollectibleDesc[mod.SolarItems.Wormhole]
	CollectibleDesc[mod.SolarItems.Dial+0] = CollectibleDesc[mod.SolarItems.Wormhole]
	CollectibleDesc[mod.SolarItems.Dial+1] = CollectibleDesc[mod.SolarItems.Wormhole]
	CollectibleDesc[mod.SolarItems.Dial+2] = CollectibleDesc[mod.SolarItems.Wormhole]
	CollectibleDesc[mod.SolarItems.Dial+3] = CollectibleDesc[mod.SolarItems.Wormhole]
	CollectibleDesc[mod.SolarItems.Dial+4] = CollectibleDesc[mod.SolarItems.Wormhole]
	CollectibleDesc[mod.SolarItems.Dial+5] = CollectibleDesc[mod.SolarItems.Wormhole]
	CollectibleDesc[mod.SolarItems.Dial+6] = CollectibleDesc[mod.SolarItems.Wormhole]
	CollectibleDesc[mod.SolarItems.Dial+7] = CollectibleDesc[mod.SolarItems.Wormhole]
	CollectibleDesc[mod.SolarItems.Dial+8] = CollectibleDesc[mod.SolarItems.Wormhole]
	CollectibleDesc[mod.SolarItems.Dial+9] = CollectibleDesc[mod.SolarItems.Wormhole]
	CollectibleDesc[mod.OtherItems.CatFish] = CollectibleDesc[mod.SolarItems.Wormhole]
	CollectibleDesc[mod.SolarItems.AdInfinitum] = CollectibleDesc[mod.SolarItems.Wormhole]
	CollectibleDesc[mod.SolarItems.Whistle] = CollectibleDesc[mod.SolarItems.Wormhole]

	--internal only
	CollectibleDesc[mod.SolarItems.CursedHead] = CollectibleDesc[mod.SolarItems.Friend]
	CollectibleDesc[mod.SolarItems.CursedBody] = CollectibleDesc[mod.SolarItems.Friend]
	CollectibleDesc[mod.SolarItems.CursedSoul] = CollectibleDesc[mod.SolarItems.Friend]

	local TrinketDesc = {
		--#region
		[Trinkets.Shard] = {
			Name = "퀀텀 파편",
			Description = ""
			.."#"..tostring(math.floor(100*mod.SHARD_CHANCE)).."%의 확률로 피해를 막으나;"
			.."#>>> !!! 그 방의 랜덤 위치로 순간이동합니다.",
			QuoteDesc = "언제 어디서나",
		},
		--#endregion

		--#region NO-HIT TRINKETS
		[mod.Trinkets.BismuthPenny] = {
			Name = "비스무트 페니",
			--"#{{BismuthHC}} Picking up a coin has a 25% chance to spawn a bismuth crystal # Nickels and dimes have a higher chance # Holding bismuth increases the chance of finding higher quality items # Taking damage drops all Bismuth on the floor", "Bismuth Penny"
			Description = ""
			.."#{{BismuthHC}} 동전을 집으면 25%의 확률로 비스무트 크리스탈을 소환합니다."
			.."#동전 가치가 높을수록 확률 증가"
			.."#비스무트 크리스탈 소지량에 따라 등급 보정 확률 증가"
			.."#!!! 피격 시 소지 중인 비스무트 크리스탈이 떨궈집니다."
			.."{{CR}}",
			QuoteDesc = "색깔 부자",
		},
		[mod.Trinkets.Incense] = {
			Name = "열기",
			--"#{{Trinket}} Collectibles are replaced with fervent trinkets # Fervent trinkets are automatically smelted on pickup", "Fervent Incense"
			Description = ""
			.."#{{Trinket}} 모든 아이템이 뜨거운 장신구로 바뀝니다."
			.."#뜨거운 장신구는 획득 즉시 흡수됩니다."
			.."{{CR}}",
			QuoteDesc = "뜨거워",
		},
		[mod.Trinkets.BadApple] = {
			Name = "썩은 사과",
			--"#{{AppleHC}} Rotten apples randomly spawn on the floor # A giant snake will sweep vertically through apples positions # The snake deals heavy damage to anything it touches, including Isaac", "Bad Apple"
			Description = ""
			.."#{{AppleHC}} 주기적으로 썩은 사과가 생깁니다."
			.."#썩은 사과가 생기면 거대한 뱀이 사과를 향해 세로로 돌진합니다."
			.."#!!! 거대한 뱀은 캐릭터를 포함한 모든 적에게 큰 피해를 줍니다."
			.."{{CR}}",
			QuoteDesc = "뼛속까지 사악해",
		},
		[mod.Trinkets.Nanite] = {
			Name = "나노봇",
			--"#{{Bomb}} Placed bombs have 7% chance to be upgraded into Giga Bombs", "Nanite"
			Description = ""
			.."#{{Bomb}} 폭탄 설치 시 7%의 확률로 기가폭탄으로 바뀝니다."
			.."{{CR}}",
			QuoteDesc = "나노머신",
		},
		[mod.Trinkets.Battery] = {
			Name = "부서진 배터리",
			--"# Using an active item creates electric flies based on its charges # {{Warning}} Doesn't work with 0 or +12 charges items", "Broken Battery"
			Description = ""
			.."#액티브 아이템 사용 시 레이저를 두른 자폭 파리를 소환합니다."
			.."#!!! 충전량이 1~12칸인 경우에만 적용"
			.."{{CR}}",
			QuoteDesc = "누수",
		},
		[mod.Trinkets.Gear] = {
			Name = "황금 기어",
			--"# Taking damage has a 10% chance to trigger the effect of {{Collectible422}} # Dying has a 30% chance to trigger the effect of {{Collectible422}} #{{Warning}} Has a 10% chance to break when activated", "Golden Gear"
			Description = ""
			.."#{{Collectible422}} 피격 시 10%의 확률로 시점을 전 방으로 되돌립니다."
			.."#{{Collectible422}} 사망 시 30%의 확률로 시점을 전 방으로 되돌립니다."
			.."#!!! 발동 시 10%의 확률로 부서집니다."
			.."{{CR}}",
			QuoteDesc = "다시 또 다시",
		},
		[mod.Trinkets.ClayBrick] = {
			Name = "지점토 벽돌",
			--"# Rocks and blocks have a 10% chance to be replaced with poops #{{PoopPickup}} Special poops can also spawn", "Clay Brick"
			Description = ""
			.."#{{PoopPickup}} 장애물이 10%의 확률로 똥으로 바뀝니다."
			.."{{CR}}",
			QuoteDesc = "직접 만든 거야!",
		},
		[mod.Trinkets.Lure] = {
			Name = "넵튠의 매혹",
			--"# Room items have a 50% chance to be upgraded by one quality level # Upgraded items will have their sprites hidden # Does not affect {{Quality4}} items", "Neptune's Lure"
			Description = ""
			.."#방 입장시 50%의 확률로 아이템의 등급이 한 단계 증가합니다."
			.."#>>> !!! 효과가 적용된 아이템의 모습이 가려집니다."
			.."#{{Quality4}} 등급 이상의 아이템의 경우 무효과"
			.."{{CR}}",
			QuoteDesc = "TESET",
		},
		[mod.Trinkets.Effigy] = {
			Name = "저주받은 인형",
			--"# At the start of the floor, 75% chance to replace a curse with a blessing # If blessings are locked, the curse is just removed #{{Warning}} Blessings are not implemented yet", "Cursed Effigy"
			Description = ""
			.."#!!! 스테이지 진입 시 75%의 확률로;"
			.."#>>> {{Collectible260}} 저주가 제거됩니다."
			--.."#>>> 저주가 축복으로 바뀝니다."
			--.."#"
			.."{{CR}}",
			QuoteDesc = "희생양",
		},
		[mod.Trinkets.Crown] = {
			Name = "달빛 왕관",
			--"#{{LunarHC}} +66.6% to Lunar Pact #{{Warning}} 33% chance to turn into {{Trinket146}} after a Lunar Pact spawns #{{PlanetariumChance}} Planetariums are replaced with Void Planetariums", "Lunar Crown"
			Description = ""
			.."#{{LunarHC}} 악마방이 공월방으로 으로 대체될 확률 +66.6%"
			.."#{{LunarHC}} {{ColorGray}}공월방은 거래 아이템의 등급이 높으나 거래 시 {{BrokenHeart}}가 추가됩니다."
			.."#!!! {{Trinket146}} 공월방 등장 시 33%의 확률로 장신구가 Devil's Crown으로 바뀝니다."
			--.."#{{PlanetariumChance}} 천체관이 공체관으로 바뀝니다."
			--.."#{{PlanetariumChance}} {{ColorGray}}공체관은 ???"
			.."{{CR}}",
			QuoteDesc = "이 세계는 이 몸의 것이니라",
		},
		[mod.Trinkets.Sol] = {
			Name = "적절한 튜닝",
			--"# At the start of each floor, most rooms are rerolled multiple times, keeping the rarest outcome", "Fine Tuning"
			Description = ""
			.."#!!! 스테이지 진입 시:"
			.."#{{Room}} 대부분의 방의 구조가 희귀한 구조로 바뀝니다."
			.."{{CR}}",
			QuoteDesc = "희귀한 방!",
		},
		[mod.Trinkets.i] = {
			Name = "",
			--"#{{Collectible"..mod.SolarItems.HyperDice.."}} At the start of each floor, special rooms have a 50% chance to be rerolled into other types", "i"
			Description = ""
			.."#!!! 스테이지 진입 시:"
			.."#{{Collectible"..mod.SolarItems.HyperDice.."}} 특수방이 50%의 확률로 다른 특수방으로 바뀝니다."
			.."{{CR}}",
			QuoteDesc = "차원 드리프트",
		},
		--#endregion

		--#region SOLAR ITEMS
		[mod.Trinkets.Void] = {
			Name = "공허 물질",
			--"# Defeating the floor boss respawns it as a permanent ally, lasting until it dies # {{Warning}} Some particular bosses are excluded for not being friendly compatible", "Void Matter"
			Description = ""
			.."#{{BossRoom}} 보스방의 보스 처치 시 아군으로 부활시킵니다."
			.."#!!! {{ColorGray}}(일부 보스는 제외)"
			.."{{CR}}",
			QuoteDesc = "절망스러운 드롭",
		},
		--#endregion

		--#region OTHER
		[mod.Trinkets.Sputnik] = {
			Name = "스푸트닉",
			--"# Grants a satellite orbital #{{Throwable}} Orbitals orbit farther from Isaac and move more slowly", "Sputnik"
			Description = "캐릭터의 주변을 돌며 접촉하는 적에게 초당 6의 피해를 줍니다.",
			QuoteDesc = "위성 친구",
		},
		[Trinkets.Flag] = {
			Name = "흐려진 깃발",
			Description = "↑ 망원경 발견 확률 +15%"
			.."#↑ 망원경이 위성 패밀리어를 줄 확률 +6%"
			.."#{{DamageSmall}} 위성 패밀리어의 피해량 +50%"
			.."#{{TearsSmall}} 위성 패밀리어의 공격 속도 +100%",
			QuoteDesc = "달을 향해서",
		},
		[mod.Trinkets.Noise] = {
			--Name = "Background Noise",
			Description = ""
			.."#!!! 무효과 (미구현 아이템)"
			.."{{CR}}",
			--QuoteDesc = "",
		},
		[mod.Trash.Soldier] = {
			--Name = "Toy Soldier",
			Description = ""
			.."#!!! 무효과 (미구현 아이템)"
			.."{{CR}}",
			--QuoteDesc = "",
		},
		[mod.Trash.Silver] = {
			--Name = "Mirror Shard",
			Description = ""
			.."#!!! 무효과 (미구현 아이템)"
			.."{{CR}}",
			--QuoteDesc = "",
		},
		--#endregion
	}

	local CardDesc = {
		[mod.FoilConsts.FOIL_ID] = {
			Name = "카드 프로텍터",
			--"# Applies a protection to the nearest card # Protected cards have a "..tostring(math.floor(100*(1-mod.FoilConsts.BREAK_CHANCE))).."% chance not to be consumed", "Card Protector"
			Description = ""
			.."#{{Card}} 사용 시 가장 가까운 카드 하나에 '보호'를 겁니다."
			.."#{{Card}} 보호된 카드는 사용 시 "..tostring(math.floor(100*(1-mod.FoilConsts.BREAK_CHANCE))).."%의 확률로 소모되지 않습니다."
			.."{{CR}}",
			QuoteDesc = "더 오래",
		},
	}

	local PillDesc = {
		[mod.Pills.CLAIRVOYANCE] = {
			Name = "투영",
			Description = ""
			.."#{{Planetarium}} 현재 게임에서 천체관 확률 +1%"
			.."{{CR}}",
			Horse = ""
			.."#{{Planetarium}} 현재 게임에서 천체관 확률 {{ColorCyan}}+3{{CR}}%"
			.."{{CR}}",
			QuoteDesc = "천체관 확률 증가",
		},
		[mod.Pills.CLAIRVOYANCE_BAD] = {
			Name = "투영",
			Description = ""
			.."#{{Collectible582}} 화면이 어지러워집니다."
			.."{{CR}}",
			Horse = ""
			.."#{{Collectible582}} 화면이 {{ColorYellow}}더 크게{{CR}} 어지러워집니다."
			.."{{CR}}",
			QuoteDesc = "왜곡된 시야",
		},
		[mod.Pills.BALLS_UP] = {
			Name = "위성 증가",
			Description = ""
			.."#{{Throwable}} 위성 패밀리어 +1 (최대 3)"
			.."{{CR}}",
			Horse = ""
			.."#{{Throwable}} 위성 패밀리어 {{ColorCyan}}+2{{CR}} (최대 3)"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[mod.Pills.BALLS_DOWN] = {
			Name = "위성 감소",
			Description = ""
			.."#{{Throwable}} 위성 패밀리어 -1"
			.."{{CR}}",
			Horse = ""
			.."#{{Throwable}} 위성 패밀리어 {{ColorYellow}}-2{{CR}}"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[mod.Pills.MARSHMALLOW] = {
			Name = "마시멜로!?",
			Description = ""
			.."#{{Throwable}} 그 방에서 위성 패밀리어 9개를 지급합니다."
			.."{{CR}}",
			Horse = ""
			.."#{{Throwable}} 그 방에서 위성 패밀리어 9개를 지급합니다."
			.."#{{Collectible247}} {{ColorCyan}}그 방에서 패밀리어가 더 강해집니다.{{CR}}"
			.."{{CR}}",
			QuoteDesc = "나만의 태양계",
		},
	}

	local entityDesc = {
		["ABYSS_COIN"] = {
			Type = EntityType.ENTITY_PICKUP,
			Variant = PickupVariant.PICKUP_COIN,
			SubType = mod.EntityVoidSub,
			Name = "심연의 동전",
			-- "# Will take all your coins and create a golden explosion, gilding pickups, trinkets, enemies and more!"
			Description = ""
			.."#!!! 모든 동전을 소모하여:"
			.."#>>> 가능한 경우, 그 방의 픽업 황금화"
			.."#>>> {{Collectible202}} 그 방의 적 황금화"
			.."#>>> {{Trinket}} 소지 중인 장신구 황금화"
			.."#>>> {{Trinket}} 그 방의 장신구 황금화"
			.."{{CR}}",
		},
		["ABYSS_BOMB"] = {
			Type = EntityType.ENTITY_PICKUP,
			Variant = PickupVariant.PICKUP_BOMB,
			SubType = mod.EntityVoidSub,
			Name = "심연의 폭탄",
			-- "# Next bomb placed will try to absorb anything in the room and then do a {{Collectible483}} explosion"
			Description = ""
			.."#{{Collectible483}} 폭탄 설치 시 블랙홀을 설치하며 이후 그 방에 거대한 폭발을 일으킵니다."
			.."{{CR}}",
		},
		["ABYSS_KEY"] = {
			Type = EntityType.ENTITY_PICKUP,
			Variant = PickupVariant.PICKUP_KEY,
			SubType = mod.EntityVoidSub,
			Name = "심연의 열쇠",
			-- "# The next door opened will create a line of red rooms in its direction, reaching the I'm Error room # Triggers {{Collectible175}} when used # Colliding with a closed door will also trigger the effect"
			Description = ""
			.."#{{Collectible175}} 잠긴 문을 열 때:"
			.."#>>> {{ErrorRoom}} 방을 연 방향으로 I AM ERROR가 나올 때까지 연쇄적으로 빨간방을 엽니다."
			.."#!!! 닫힌 문에 오랫동안 접촉 시에도 발동"
			.."{{CR}}",
		},
		["ABYSS_HEART"] = {
			Type = EntityType.ENTITY_PICKUP,
			Variant = PickupVariant.PICKUP_HEART,
			SubType = mod.EntityVoidSub,
			Name = "심연의 하트",
			-- "# +1 {{AbyssalHC}} (+1 {{BrokenHeart}} if no free hearts available) # Works as a shield, "..tostring(math.floor(100*mod.VoidHeartConsts.BREAK_CHANCE)).."% chance to break # If not broken, may be restored when picking up a {{Heart}} at full health #  Triggers {{Collectible35}} on use # Picking up a {{Heart}} while both health and {{AbyssalHC}} are full grants a permanent damage up # Amount of {{AbyssalHC}} acts as a damage multiplier"
			Description = ""
			.."#{{AbyssalHC}} 획득 시 반전하트 +1"
			.."#!!! 반전하트 피격 시 :"
			.."#>>> "..tostring(math.floor(100*mod.VoidHeartConsts.BREAK_CHANCE)).."%의 확률로 {{BrokenHeart}}로 바뀝니다."
			.."#>>> 바뀌지 않은 경우 {{Heart}}를 획득하여 확률적으로 회복"
			.."#!!! 일부 피해는 반전하트에 영향을 주지 않음"
			.."#{{AbyssalHC}} 체력 상한이 꽉 찬 상태에서 {{Heart}} 획득 시 반전하트 수만큼 공격력 배율 증가"
			.."{{CR}}",
		},
		["ABYSS_BATTERY"] = {
			Type = EntityType.ENTITY_PICKUP,
			Variant = PickupVariant.PICKUP_LIL_BATTERY,
			SubType = mod.EntityVoidSub,
			Name = "심연의 배터리",
			-- "# Will take all your item charge and can only be picked up when fully charged # Grants you 5 item sparks of your active item"
			Description = ""
			.."#!!! 소지 중인 액티브 아이템이 완충 상태에서만 획득 가능"
			.."#!!! 획득 시 액티브 아이템의 충전량을 소진시키며;"
			.."#>>> 아이템 스파크를 5개 소환합니다."
			.."#완충 상태가 아닐 때 스파크를 소모하여 액티브 아이템을 사용할 수 있습니다."
			.."{{CR}}",
		},
		["TELESCOPE"] = {
			Type = mod.EntityInf[mod.Entity.Telescope].ID,
			Variant = mod.EntityInf[mod.Entity.Telescope].VAR,
			SubType = mod.EntityInf[mod.Entity.Telescope].SUB,
			Name = "망원경",
			-- "{{Coin}} Costs one coin, can reward you with: # Wisps # Astral item wisps and sparks # Soul Hearts # Blaze Hearts # Astral items # {{ColorCyan}}Lil {{ColorCyan}}Moon orbitals"
			Description = ""
			.."#1{{Coin}}을 소모하여 아래 중 하나 발동:"
			.."#>>> {{Collectible584}} 위습"
			.."#>>> {{ItemPoolPlanetarium}} 천체관 아이템 위습"
			.."#>>> {{SoulHeart}} 소울하트"
			.."#>>> {{BlazeHeartHC}} 불타는하트"
			.."#>>> {{ColorCyan}}위성 패밀리어"
			.."{{CR}}",
		},
		["TITAN"] = {
			Type = mod.EntityInf[mod.Entity.Titan].ID,
			Variant = mod.EntityInf[mod.Entity.Titan].VAR,
			SubType = mod.EntityInf[mod.Entity.Titan].SUB,
			Name = "타이탄 거지",
			-- "Takes an increasing number of coins and can reward you with golden pickups and trinkets"
			Description = ""
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."#"
			.."{{CR}}",
		},
		["ASTRAL_STATUE"] = {
			Type = mod.EntityInf[mod.Entity.Statue].ID,
			Variant = mod.EntityInf[mod.Entity.Statue].VAR,
			SubType = mod.EntityInf[mod.Entity.Statue].SUB,
			Name = "아스트랄 석상",
			-- persistentData:Unlocked(Isaac.GetAchievementIdByName("double_nothing (HC)")) "#{{Planetarium}} Take the item to trigger a boss fight #{{Bomb}} Bombing the statue turns the item into pickups (and also spawns the boss!) # {{ColorTransform}}Collect all stars in the room to activate Double-or-Nothing:{{ColorText}} # Gain an extra reward item, but lose both if hit # Isaac receives a free {{Collectible313}} shield # Boss difficulty increases to Ascended"
			-- "#{{Planetarium}} Take the item to trigger a boss fight #{{Bomb}} Bombing the statue turns the item into pickups (and also spawns the boss!)"
			Description = ""
			.."#{{Planetarium}} 아이템 획득 시 보스전을 시작합니다."
			.."#{{Bomb}} 석상을 파괴하면 아이템이 분해되며 보스전을 시작합니다."
			.."{{CR}}",
			AllOrNothing = ""
			.."#!!! {{ColorTransform}}방에 있는 별조각을 전부 모아 추가 챌린지 발동"
			.."#>>> 보스전 클리어 시 추가 아이템 ({{Quality2}} 이상) 드랍"
			.."#>>> 피격 시 획득 아이템 + 추가 보상이 전부 사라집니다."
			.."#>>> {{HolyMantleSmall}} 보스전 시작 시 {{Collectible313}}보호막 1개 지급"
			.."#>>> 추가 패턴 존재"
			.."{{CR}}",
		},
		["LUNAR_STATUE"] = {
			Type = mod.EntityInf[mod.Entity.LunarStatue].ID,
			Variant = mod.EntityInf[mod.Entity.LunarStatue].VAR,
			SubType = mod.EntityInf[mod.Entity.LunarStatue].SUB,
			Name = "달의 계약",
			-- "#Trade {{BrokenHeart}}, {{Heart}}, and {{SoulHeart}} for an item # This room is under the effects of {{Collectible691}}"
			-- "#{{UltraSecretRoom}} {{Heart}}최대 체력/{{SoulHeart}}소울하트 소모에 더해 {{BrokenHeart}}부서진하트를 얻는 조건으로 거래합니다.#{{Warning}} 거래 시 획득하는 {{BrokenHeart}}부서진하트만큼 {{Heart}}빨간하트/{{SoulHeart}}소울하트를 추가로 차감합니다.(사망하지 않음)"
			Description = ""
			.."#{{UltraSecretRoom}} {{Heart}}최대 체력/{{SoulHeart}}소울하트 소모에 더해 {{BrokenHeart}}부서진하트를 얻는 조건으로 거래합니다."
			.."#{{Warning}} 거래 시 획득하는 {{BrokenHeart}}부서진하트만큼 {{Heart}}빨간하트/{{SoulHeart}}소울하트를 추가로 차감합니다. (사망하지 않음)"
			.."#{{Collectible691}} {{Quality2}} 등급 이상의 아이템이 등장합니다."
			.."{{CR}}",
		},
		["BABEL_BUTTON"] = {
			Type = mod.EntityInf[mod.Entity.BabelButton].ID,
			Variant = mod.EntityInf[mod.Entity.BabelButton].VAR,
			SubType = mod.EntityInf[mod.Entity.BabelButton].SUB,
			Name = "바벨탑 보스러시 난이도",
			-- "#{{NormalHC}} Standard difficulty, same as normal runs #{{AttunedHC}} Extra and deadlier attacks + double damage #{{AscendedHC}} Further enhanced attacks {{ColorTransform}}[Complete the tower in this mode to finish the challenge]{{ColorText}} #{{RadiantHC}} No-hit mode {{ColorTransform}}[No rewards for completing the tower in this mode]{{ColorText}}"
			Description = ""
			.."#{{NormalHC}} 일반 난이도"
			.."#{{AttunedHC}} 1차 보스 패턴 추가 + 피해량 2배"
			.."#{{AscendedHC}} 2차 보스 패턴 추가 {{ColorTransform}}[해당 난이도로 클리어해야 챌린지 클리어로 인정]{{CR}}"
			.."#{{RadiantHC}} 피격 시 사망 {{ColorTransform}}[추가 보상 없음]{{CR}}"
			.."{{CR}}",
		},
	}

	for _, itemdesc in pairs(entityDesc) do
		EID:addEntity(itemdesc.Type, itemdesc.Variant or -1, itemdesc.SubType or -1, itemdesc.Name, itemdesc.Description, "ko_kr")
	end

	local function FF_EIDKR_HC_AstralStatueCond(descObj)
	  if EID:getLanguage() ~= "ko_kr" and EID:getLanguage() ~= "ko" then return false end
	  if not descObj.Entity then return end
		if descObj.ObjType == mod.EntityInf[mod.Entity.Statue].ID
		and descObj.ObjVariant == mod.EntityInf[mod.Entity.Statue].VAR
		and descObj.ObjSubType == mod.EntityInf[mod.Entity.Statue].SUB
		then
			local pers = Isaac.GetPersistentGameData()
			return pers:Unlocked(Isaac.GetAchievementIdByName("double_nothing (HC)"))
		end
	end

	local function FF_EIDKR_HC_AstralStatueCallback(descObj)

	  local appendDesc = entityDesc["ASTRAL_STATUE"].AllOrNothing
	  EID:appendToDescription(descObj, appendDesc)

	  return descObj
	end

	EID:addDescriptionModifier("FF_EIDKR_HC_AstralStatue", FF_EIDKR_HC_AstralStatueCond, FF_EIDKR_HC_AstralStatueCallback)

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

	local i_queueLastFrame = {}
	local i_queueNow = {}
	wakaba_krdesc:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function (_, player)
		if not (Options.Language == "kr" or REPKOR) then return end
		local descTable = CollectibleDesc
		if not descTable and not descTableBR then return end

		local initSeed = tostring(player.InitSeed)

		i_queueNow[initSeed] = player.QueuedItem.Item
		if (i_queueNow[initSeed] ~= nil) then
			for itemID, itemdesc in pairs(descTable) do
				if (i_queueNow[initSeed].ID == itemID and i_queueNow[initSeed]:IsCollectible() and i_queueLastFrame[initSeed] == nil) then
					local itemName = (itemdesc.Name ~= "" and itemdesc.Name) or i_queueNow[initSeed].Name
					local queueDesc = itemdesc.QuoteDesc or i_queueNow[initSeed].Description
					Game():GetHUD():ShowItemText(itemName, queueDesc)
				end
			end
		end
		i_queueLastFrame[initSeed] = i_queueNow[initSeed]
	end)


	local t_queueLastFrame = {}
	local t_queueNow = {}
	wakaba_krdesc:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function (_, player)
		if not (Options.Language == "kr" or REPKOR) then return end
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
		targetMod = "Heaven's call",
		birthright = BirthrightDesc,
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
		cards = CardDesc,
		pills = PillDesc,
	}

end