
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
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		[mod.SolarItems.HyperDice] = {
			Name = "아브라함의 지도",
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
			QuoteDesc = "",
		},
		--#endregion
	}

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
			.."#{{PlanetariumChance}} 천체관이 공체관으로 바뀝니다."
			.."#{{PlanetariumChance}} {{ColorGray}}공체관은 ???"
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
			Name = "TESET",
			--"# Defeating the floor boss respawns it as a permanent ally, lasting until it dies # {{Warning}} Some particular bosses are excluded for not being friendly compatible", "Void Matter"
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
			QuoteDesc = "TESET",
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
			Name = "Background Noise",
			Description = ""
			.."#!!! 무효과 (미구현 아이템)"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[mod.Trinkets.Soldier] = {
			Name = "Toy Soldier",
			Description = ""
			.."#!!! 무효과 (미구현 아이템)"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[mod.Trinkets.Silver] = {
			Name = "Mirror Shard",
			Description = ""
			.."#!!! 무효과 (미구현 아이템)"
			.."{{CR}}",
			QuoteDesc = "",
		},
		--#endregion
	}

	local CardDesc = {
		[mod.FoilConsts.FOIL_ID] = {
			Name = "카드 프로텍터",
			--"# Applies a protection to the nearest card # Protected cards have a "..tostring(math.floor(100*(1-mod.FoilConsts.BREAK_CHANCE))).."% chance not to be consumed", "Card Protector"
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
			.."#Screen distortion"
			.."{{CR}}",
			Horse = ""
			.."#Strong Screen distortion"
			.."{{CR}}",
			QuoteDesc = "천체관 확률 감소",
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
			QuoteDesc = "태양계",
		},
	}

	local entityDesc = {
		["INNERENTRYNAME"] = {
			Type = 0,
			Variant = 0,
			SubType = 0,
			Name = "",
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
		["INNERENTRYNAME"] = {
			Type = 0,
			Variant = 0,
			SubType = 0,
			Name = "",
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
		["INNERENTRYNAME"] = {
			Type = 0,
			Variant = 0,
			SubType = 0,
			Name = "",
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
		["INNERENTRYNAME"] = {
			Type = 0,
			Variant = 0,
			SubType = 0,
			Name = "",
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
		["INNERENTRYNAME"] = {
			Type = 0,
			Variant = 0,
			SubType = 0,
			Name = "",
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
		["INNERENTRYNAME"] = {
			Type = 0,
			Variant = 0,
			SubType = 0,
			Name = "",
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
		["INNERENTRYNAME"] = {
			Type = 0,
			Variant = 0,
			SubType = 0,
			Name = "",
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
		["INNERENTRYNAME"] = {
			Type = 0,
			Variant = 0,
			SubType = 0,
			Name = "",
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
		["INNERENTRYNAME"] = {
			Type = 0,
			Variant = 0,
			SubType = 0,
			Name = "",
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
		["INNERENTRYNAME"] = {
			Type = 0,
			Variant = 0,
			SubType = 0,
			Name = "",
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
		["INNERENTRYNAME"] = {
			Type = 0,
			Variant = 0,
			SubType = 0,
			Name = "",
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
	}

	EID:addEntity(mod.EntityInf[mod.Entity.Telescope].ID, mod.EntityInf[mod.Entity.Telescope].VAR, mod.EntityInf[mod.Entity.Telescope].SUB, "망원경", "1{{Coin}}을 소모하여 아래 중 하나 발동:#{{Blank}} {{Collectible584}}불꽃#{{Blank}} {{ItemPoolPlanetarium}}천체관 아이템 불꽃#{{Blank}} {{SoulHeart}}소울하트/불타는하트#{{Blank}} {{ColorCyan}}위성 패밀리어", "ko_kr")
	EID:addEntity(mod.EntityInf[mod.Entity.Statue].ID, mod.EntityInf[mod.Entity.Statue].VAR, mod.EntityInf[mod.Entity.Statue].SUB, "아스트랄 석상", "#{{ItemPoolPlanetarium}} 아이템 획득 시 보스전을 시작합니다.#{{Bomb}} 석상을 파괴하면 아이템이 분해되며 보스전을 시작합니다.", "ko_kr")
	EID:addEntity(mod.EntityInf[mod.Entity.LunarStatue].ID, mod.EntityInf[mod.Entity.Statue].VAR+1, mod.EntityInf[mod.Entity.Statue].SUB, "[달의 계약]", "#{{UltraSecretRoom}} {{Heart}}최대 체력/{{SoulHeart}}소울하트 소모에 더해 {{BrokenHeart}}부서진하트를 얻는 조건으로 거래합니다.#{{Warning}} 거래 시 획득하는 {{BrokenHeart}}부서진하트만큼 {{Heart}}빨간하트/{{SoulHeart}}소울하트를 추가로 차감합니다.(사망하지 않음)", "ko_kr")

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