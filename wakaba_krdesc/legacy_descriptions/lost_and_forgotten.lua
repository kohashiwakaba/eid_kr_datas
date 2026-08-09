
if LNF then

	EID._currentMod = "Lost and Forgotten"

	local Players = LNF.PlayerType
	local Items = LNF.CollectibleType
	local Trinkets = LNF.TrinketType
	local Cards = LNF.Card
	local Pills = LNF.PillEffect

	local CharacterDesc = {
		[LNF.PlayerType.Joseph] = {
			Name = "Joseph",
			Description = "{{DamageSmall}} 모든 공격력 증가량 x0.5"
			.."#{{Collectible" .. LNF.CollectibleType.MOON_ROCK .. "}} Moon Rock의 능력치 증가 효율 증가"
			.."#{{DamageSmall}} Dream Mode 발동시 공격력 +0.5",
			--[[
			Detailed = ""
			.."#"
			.."",
			 ]]
			Birthright = ""
			.."#{{Collectible" .. LNF.CollectibleType.MOON_ROCK .. "}} Moon Rock 사용 시 Dream Mode에서의 랜덤 능력치 증가"
			.."",
		},
		[LNF.PlayerType.TaintedJoseph] = {
			Name = "Tainted Joseph",
			Description = "!!! 주기적으로 Nightmare Gaper가 등장합니다."
			.."#{{BrokenHeart}} Nightmare Gaper 접촉 시 부서진하트 +2"
			.."#방 클리어 시 악몽 강도 증가"
			.."#스테이지 진입 시 악몽 강도 대폭 감소",
			--[[
			Detailed = ""
			.."#"
			.."",
			 ]]
			Birthright = ""
			.."#악몽 요소가 더 자주 등장합니다."
			.."",
		},
		[LNF.PlayerType.Robot] = {
			Name = "Robot",
			Description = ""
			.."#{{Collectible" .. LNF.CollectibleType.ROBOTS_BATTERY .. "}} Robot's Battery 미소지 시에도 모듈이 나올 수 있습니다."
			.."#피격 시 Robot's Battery를 발동하나 랜덤 모듈 하나가 증발합니다."
			.."#하트 픽업이 높은 확률로 모듈로 바뀝니다."
			.."#{{Collectible" .. LNF.CollectibleType.ROBOTS_BATTERY .. "}} Robot's Battery 사용 시 빈 슬롯의 개수만큼 충전량이 보존됩니다."
			.."#{{Collectible68}} 기본 소지 모듈 : 기계 장치",
			--[[
			Detailed = ""
			.."#"
			.."",
			 ]]
			Birthright = ""
			.."#모듈 슬롯 +2"
			.."",
		},
		[LNF.PlayerType.TaintedRobot] = {
			Name = "Tainted Robot",
			Description = "{{Collectible" .. LNF.CollectibleType.SCRAPHEAP .. "}} 모든 보물방의 아이템이 Scrapheap로 교체됩니다."
			.."#픽업이 확률적으로 잡동사니로 바뀝니다."
			.."#머신류 파괴 시 잡동사니가 나옵니다.",
			--[[
			Detailed = ""
			.."#"
			.."",
			 ]]
			Birthright = ""
			.."#분해 시 나오는 잡동사니의 수량 증가"
			.."",
		},
		[LNF.PlayerType.Munitus] = {
			Name = "Munitus",
			Description = "",
			--[[
			Detailed = ""
			.."#"
			.."",
			 ]]
			Birthright = ""
			.."#Slows down the familiar timer"
			.."",
		},
	}

	local CurseDesc = {
		[-995] = {
			Name = "저주 개요",
			Description = ""
			.."#나쁜짓을 하면 올라가며 좋은 짓을 하면 내려갑니다."
			.."#저주 수치가 5 이상일 때 이하의 요소가 등장:"
			.."#{{Collectible"..CollectibleType.COLLECTIBLE_CHAMPION_BELT.."}} {{ColorOrange}}저주받은 존재{{CR}} : 체력이 50% 증가 + 피격 시 {{Heart}}1칸 피해"
			.."#{{ColorOrange}}저주받은 픽업{{CR}} : 획득량 증가 + 획득 시 {{HalfHeart}}반칸 피해"
			.."#{{Card"..LNF.Card.RUNE_BLANK_CURSED.."}} {{ColorOrange}}저주받은 룬{{CR}}"
			.."",
		},
		[-994] = {
			Name = "저주 수치",
			Description = ""
			.."#↑ {{ColorOrange}}저주 수치 증가{{CR}}:"
			.."#>>> {{ColorRed}}[+1]{{CR}} Babtysiery 파괴"
			.."#>>> {{ColorRed}}[+3]{{CR}} {{AngelChanceSmall}}천사 처치"
			.."#>>> {{ColorRed}}[+1~2]{{CR}} {{DevilChanceSmall}}악마 거래"
			.."#>>> {{ColorRed}}[+1]{{CR}} {{DemonBeggar}}악마거지의 보상"
			.."#>>> {{ColorRed}}[+0.5]{{CR}} {{Beggar}}거지 처치"
			.."#↓ {{ColorOrange}}저주 수치 감소{{CR}}:"
			.."#>>> {{ColorLime}}[-5~10]{{CR}} Babtysiery 접촉"
			.."#>>> {{ColorLime}}[-1]{{CR}} {{SacrificeRoom}} 희생방에서 희생"
			.."#>>> {{ColorLime}}[-3]{{CR}} {{Confessional}}고해실 이용"
			.."#>>> {{ColorLime}}[-1]{{CR}} {{DemonBeggar}}악마거지 처치"
			.."#>>> {{ColorLime}}[-1]{{CR}} {{Room}}방 5개 클리어 (하한 10)"
			.."",
		},
	}

	local ModuleDesc = {
		[1] = {
			Description = "{{DamageSmall}} 그 방에서 공격력 +0.7",
		},
		[2] = {
			Description = "{{TearsSmall}} 그 방에서 연사 +0.3",
		},
		[3] = {
			Description = "그 방에서 이하 효과:#>>> {{SpeedSmall}}이동속도 +0.7#>>> {{RangeSmall}}사거리 +2.5#>>> {{ShotspeedSmall}}탄속 +0.1",
		},
		[4] = {
			Description = "아래 아이템 발동:",
		},
		[5] = {
			Description = "그 방에서 아래 아이템의 효과 적용:",
		},
		[6] = {
			Description = "{{HolyMantleSmall}} 그 방에서 1회 피격 방지",
		},
		[7] = {
			Description = "{{Collectible"..CollectibleType.COLLECTIBLE_KAMIKAZE.."}} 캐릭터 위치에 폭발 (자해 없음)",
		},
		[8] = {
			Description = "{{Collectible"..CollectibleType.COLLECTIBLE_TAMMYS_HEAD.."}} 10방향으로 눈물 발사",
		},
		[9] = {
			Description = "소지 중인 모듈 중 하나를 추가로 발동",
		},
	}
	for _, e in ipairs(LNF.Modules) do
		if ModuleDesc[e.id] then
			e.description = ModuleDesc[e.id].Description or e.description
		end
	end

	local CollectibleDesc = {
		[LNF.CollectibleType.CONSCIENCE] = {
			Name = "",
			Description = ""
			.."#↓ {{DamageSmall}}공격력 -0.5"
			.."#{{DamageSmall}} 캐릭터의 공격력이 최대 x2까지 서서히 증가합니다."
			.."#피격 시 혹은 적 처치 시 증가량이 초기화됩니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.MATH_PROBLEM] = {
			Name = "",
			Description = ""
			.."#{{DamageSmall}} 공격력이 실시간으로 바뀝니다."
			.."#>>> {{ColorGray}}(x0.5 ~ x1.7)"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.BROKEN_HOURGLASS] = {
			Name = "",
			Description = ""
			.."#↓ {{ShotspeedSmall}}탄속 -0.3"
			.."#{{Timer}} 캐릭터가 움직이지 않을 때;"
			.."#>>> {{Slow}} 적이 느려집니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.SYRUP] = {
			Name = "",
			Description = ""
			.."#{{Pill}} 획득 시 알약을 하나 드랍합니다."
			.."#{{Pill}} 알약 사용 시 랜덤 알약 효과가 하나 더 발동됩니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.SHAMPOO] = {
			Name = "",
			Description = ""
			.."#↑ {{TearsSmall}}연사 +0.15"
			.."#눈물이 사거리가 짧은 방울로 바뀌며 공격 시 방울이 여러개를 발사합니다."
			.."#방울이 터지면 캐릭터의 공격방향으로 새로운 눈물이 나갑니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.SMALL_KNIVES] = {
			Name = "",
			Description = ""
			.."#↑ {{DamageSmall}}공격력 +0.7"
			.."#↑ {{ShotspeedSmall}}탄속 +0.1"
			.."#눈물이 적을 관통하는 작은 칼로 바뀝니다."
			.."#작은 칼로 적 처치 시 칼과 같은 방향으로 발사되는 눈물과 빨간 장판을 생성합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.PARASITE_EGGS] = {
			Name = "",
			Description = ""
			.."#공격 시 10%의 확률로 기생 눈물을 발사합니다."
			.."#기생 눈물 명중 시 연쇄 명중이 가능한 작은 Maggot을 소환합니다."
			.."#{{LuckSmall}} 행운 12+일 때 40%"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.ANCIENT_TECHNOLOGY] = {
			Name = "",
			Description = ""
			.."#공격 시 양옆에 사거리가 짧은 혈사 2개를 발사합니다."
			.."#발사된 혈사는 캐릭터의 공격력 x0.2의 피해를 주며 캐릭터에게서 멀어집니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.HYDROSIS] = {
			Name = "",
			Description = ""
			.."#놓친 눈물이 짧은 시간동안 살아있는 슬라임이 되어 움직입니다."
			.."#슬라임은 캐릭터의 공격력 x0.25의 피해를 줍니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.MEGAPHONE] = {
			Name = "",
			Description = ""
			.."#캐릭터가 탄환에 맞기 직전 근처의 적과 탄환을 밀쳐냅니다."
			.."#{{TimerSmall}} (쿨타임 4초)"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.WELLINGTONS] = {
			Name = "",
			Description = ""
			.."#랜덤 위치에 물웅덩이가 생깁니다."
			.."#물웅덩이 접촉 시 눈물 여러 발을 흩뿌립니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.MUTATION] = {
			Name = "",
			Description = ""
			.."#공격이 장애물을 관통하는 구체로 바뀝니다."
			.."#{{DamageSmall}} 다단히트로 피해를 줄 때마다 피해량이 감소합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.WEDDING_RING] = {
			Name = "",
			Description = ""
			.."#↑ {{TearsSmall}}연사 +0.3"
			.."#캐릭터 주변에 하얀 고리가 생기며 눈물을 하얀 고리에 두르며;"
			.."#>>> 공격키를 떼면 하얀 고리에 있는 눈물을 같이 발사합니다."
			.."#{{ButtonRT}}버튼으로 고리에 두르지 않게 할 수 있음"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.MONOCLE] = {
			Name = "",
			Description = ""
			.."#공격 시 캐릭터의 앞에 오도록 따라오며 캐릭터의 눈물을 확대시킵니다."
			.."#>>> {{DamageSmall}}확대된 눈물은 적에게 1.5배의 피해를 주며 탄속이 빨라집니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.ENLIGHTENMENT] = {
			Name = "",
			Description = ""
			.."#적 처치 시 5%의 확률로 세피로트의 불꽃을 소환합니다."
			.."#{{LuckSmall}} 행운 8+일 때 30% 확률"
			.."#세피로트 불꽃은 캐릭터의 주변을 돌며;"
			.."#>>> 3회 피해를 주거나 탄환을 막으면 사라집니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.DEMONS_EYE] = {
			Name = "",
			Description = ""
			.."#공격 시 붉은 눈물이 캐릭터를 향해 다가옵니다."
			.."#붉은 눈물은 캐릭터와 접촉 시 사라집니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.CALOTTE] = {
			Name = "",
			Description = ""
			.."#↑ {{ShotspeedSmall}}탄속 +0.5"
			.."#!!! 눈물이 더 빨리 떨어집니다."
			.."#눈물과 캐릭터 사이에 레이저가 생깁니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.CARRION] = {
			Name = "",
			Description = ""
			.."#{{Poison}} 공격이 적을 중독시킵니다."
			.."#눈물 주변에 여러 개의 작은 눈물이 떠다닙니다."
			.."#작은 눈물의 수는 떠다니는 시간에 비례하여 더 많아집니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.PLASTIC_KNIFE] = {
			Name = "",
			Description = ""
			.."#획득 시 아래 중 더 높은 공격력 획득:"
			.."#>>> {{DamageSmall}} x0.8 +1"
			.."#>>> {{DamageSmall}} x1 +0.6"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.TESTAMENT] = {
			Name = "",
			Description = ""
			.."#피격으로 하트를 잃으면 그 하트를 드랍합니다."
			.."#드랍된 하트별로 다른 효과를 발동합니다."
			.."#>>> {{NoLB}}{{Heart}}: 빨간 장판 + 눈물 여러발"
			.."#>>> {{NoLB}}{{SoulHeart}}: 빛줄기 + 눈물 여러발"
			.."#>>> {{NoLB}}{{BlackHeart}}: 4방향으로 짧은 혈사포"
			.."#>>> {{NoLB}}{{EternalHeart}}: 4방향 레이저 + 하트 여러개"
			.."#>>> {{NoLB}}{{EmptyBoneHeart}}: 뼛조각 여러개 + 눈물 여러발"
			.."#>>> {{NoLB}}{{GoldenHeart}}: 폭발 후 판매 아이템 생성"
			.."#>>> {{NoLB}}{{RottenHeart}}: 독방귀 + 자폭 파리/거미 여러 마리"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.CHAMPION_MUSH] = {
			Name = "",
			Description = ""
			.."#캐릭터가 주기적으로 랜덤 챔피언 몬스터의 특성을 얻습니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.OLD_CLOCK] = {
			Name = "",
			Description = ""
			.."#공격 시 다른 눈물이 추가로 발사됩니다."
			.."#추가 눈물은 공격 시마다 시계방향으로 돌아갑니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		--[[
		[LNF.CollectibleType.TOY_ROCKET] = {
			Name = "",
			Description = ""
			.."#Chance to fire an explosive rocket instead of tears"
			.."#Grants immunity to player-placed bombs"
			.."{{CR}}",
			QuoteDesc = "",
		},
		 ]]
		[LNF.CollectibleType.PURPLE_SKULL] = {
			Name = "",
			Description = ""
			.."#저주받은 위습 3개가 캐릭터 혹은 공격 주위를 돕니다."
			.."#{{DamageSmall}} 저주받은 위습은 적에게 초당 8의 피해를 줍니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.CAN_OF_TAR] = {
			Name = "",
			Description = ""
			.."#{{Slow}} 10%의 확률로 타르 공격이 나갑니다."
			.."#{{LuckSmall}} 행운 10+일 때 50% 확률"
			.."#{{Slow}} 타르 공격이 무언가에 닿을 시 타르 방울을 소환합니다."
			.."#{{Slow}} 타르 방울 접촉 시 검은 장판과 눈물 여러 개를 흩뿌립니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.CARD_GAME] = {
			Name = "",
			Description = ""
			.."#획득 시 {{NameK".. LNF.Card.CARD_TREASURE .."}}, {{NameK".. LNF.Card.CARD_LOOT .."}}, {{NameK".. LNF.Card.CARD_MONSTER .."}}를 드랍합니다."
			.."#카드 등장 시 Four Souls 계열의 카드 등장 확률 증가"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.SCHIZOPHRENIA] = {
			Name = "",
			Description = ""
			.."#주기적으로 랜덤 위치에 망상 유령을 소환합니다."
			.."#망상 유령은 캐릭터에게 멀어질수록 강해지며 캐릭터가 가까이 오면 사라집니다."
			.."#망상 유령은 주변의 적에게 유도 눈물을 발사합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.INNER_DEMON] = {
			Name = "",
			Description = ""
			.."#{{Fear}} 피격 시 그 방의 적을 2초간 캐릭터에게 멀어지게 하며;"
			.."#>>> 공격력 2.5의 눈물을 여러 방향으로 흩뿌립니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.FOLLOWERS] = {
			Name = "",
			Description = ""
			.."#공격방향으로 공격력 2.8의 눈물을 발사합니다."
			.."#다른 패밀리어의 수만큼 추가로 소환됩니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.DEAD_WOMB] = {
			Name = "",
			Description = ""
			.."#공격 시 7%의 확률로 태아가 담긴 눈물을 발사합니다."
			.."#명중 시 적 주변을 돌며 적의 탄환을 막아줍니다."
			.."#일정 시간 이후 혹은 일정 회수를 막을 시 폭파되어 주변의 적에게 공격력 x1.35의 피해를 줍니다."
			.."#{{LuckSmall}} 행운 12+일 때 16% 확률"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.KEEPERS_NOOSE] = {
			Name = "",
			Description = ""
			.."#방 입장 시 적 하나 당 자폭 파리를 하나씩 소환합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.SOAKED_SPONGE] = {
			Name = "",
			Description = ""
			.."#↑ {{TearsSmall}}연사 +0.5"
			.."#피격 시 피격 효과를 2회 추가로 발동합니다."
			.."#피격 시 랜덤 방향 일직선으로 눈물을 여러 발 흩뿌립니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.LAMB_SKULL] = {
			Name = "",
			Description = ""
			.."#캐릭터가 검은 오라를 두릅니다."
			.."#검은 오라 안의 적 처치 시 검은 영혼을 소환합니다."
			.."#검은 영혼은 적에게 7의 피해를 주며 3회 명중 이후 사라집니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.GODS_WRATH] = {
			Name = "",
			Description = ""
			.."#주기적으로 노란 조준점이 나타나며;"
			.."#>>> 일정 시간 후 조준점의 위치에 번개가 내려치며 주변의 적에게 20의 폭발 피해를 줍니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.APOLLYONS_HORNS] = {
			Name = "",
			Description = ""
			.."#{{Collectible477}} 스테이지 진입 시 이전 스테이지에 남겨진 아이템이 흡수됩니다."
			.."#!!! 흡수된 아이템 당 아래 중 랜덤 능력치 2개 증가:"
			.."#>>> {{TearsSmall}}연사 +0.15"
			.."#>>> {{DamageSmall}}공격력 +0.8"
			.."#>>> {{ShotspeedSmall}}탄속 +0.1"
			.."#>>> {{LuckSmall}}행운 +1"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.GOLDEN_CROSS] = {
			Name = "",
			Description = ""
			.."#공격 시 10%의 확률로 황금 눈물이 나갑니다."
			.."#황금 눈물 명중 시 명중한 적에게 후광이 생기며 근처의 적에게 초당 60의 피해를 줍니다."
			.."#{{LuckSmall}} 행운 12+일 때 50% 확률"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.PAIMONS_MARK] = {
			Name = "",
			Description = ""
			.."#{{BlackHeart}} 블랙하트 +1"
			.."#적이 주기적으로 잠깐동안 방해 요소 및 폭탄으로 끌려옵니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.DRAGON_SCALES] = {
			Name = "",
			Description = ""
			.."#↑ {{DamageSmall}}공격력 +1.5"
			.."#{{HolyMantleSmall}} 피격을 막아주는 특수 보호막이 3개 추가됩니다. (최대 3)"
			.."#스테이지 진입 시 특수 보호막 +1"
			.."#!!! 피격 시 {{DamageSmall}}증가한 공격력 -0.4"
			.."#!!! 특수 보호막 소진 시 아이템 소멸"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.CORPOREAL] = {
			Name = "",
			Description = ""
			.."#↑ {{SoulHeart}} 소울하트 +1"
			.."#적의 탄환 명중 실패 시 그 적이 피해를 받습니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.MONSTER_CELL] = {
			Name = "",
			Description = ""
			.."#↑ {{BlackHeart}}블랙하트 +2"
			.."#↑ {{SpeedSmall}}이동속도 +0.3"
			.."#↑ {{DamageSmall}}공격력 +2"
			.."#캐릭터의 크기가 커집니다."
			.."#모든 피격에 대한 패널티에 면역"
			.."#!!! 하트 픽업을 주을 수 없습니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.GRAY_FRUIT] = {
			Name = "",
			Description = ""
			.."#↑ {{Heart}}최대 체력 +1"
			.."#↑ {{SpeedSmall}}이동속도 +0.15"
			.."#↑ {{TearsSmall}}연사 +0.3"
			.."#↑ {{RangeSmall}}사거리 + 2.5"
			.."#↑ {{ShotspeedSmall}}탄속 + 0.1"
			.."#캐릭터의 크기가 커집니다."
			.."#{{Quality1}}등급 이하의 아이템이 20% 확률로 다른 아이템으로 변경됩니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.REANIMATOR] = { -- TODO
			Name = "",
			Description = ""
			.."#거지 처치 시 좀비 거지로 부활합니다."
			.."#처치한 거지의 종류에 따라 다른 효과"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.CUISINE] = {
			Name = "",
			Description = ""
			.."#↑ {{Heart}}최대 체력 +1"
			.."#↑ {{RottenHeart}}썩은하트 +4"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.GREEN_CAP] = {
			Name = "",
			Description = ""
			.."#↑ {{DamageSmall}}공격력 +0.3"
			.."#↑ {{RangeSmall}}사거리 +2.5"
			.."#눈물이 포물선 형태로 나갑니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.COLITIS] = {
			Name = "",
			Description = ""
			.."#공격 시 캐릭터의 뒤쪽에 옥수수알을 발사합니다."
			.."#눈물이 옥수수알 명중 시 다른 옥수수알이나 근처의 적에게 날아갑니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.BLESSING] = {
			Name = "",
			Description = ""
			.."#5%의 확률로 공격력 x1.5의 특수 눈물을 발사합니다."
			.."#{{LuckSmall}} 공격 시마다 그 방에서 확률 증가 (최대 20)"
			--.."#{{TearsSmall}} Amount of the luck added is affected by firerate"
			.."#{{LuckSmall}} 행운 30+일 때 50% 확률"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.MEPHISTOS_PACT] = {
			Name = "",
			Description = ""
			.."#적에게 돌진하며 돌진 중 12의 피해를 줍니다."
			.."#스테이지 진입 시 한 마리 더 추가됩니다."
			.."#한 마리 당 제약 조건이 생기며 하나라도 지키지 못할 시 그 스테이지에서 캐릭터를 쫒아옵니다."
			.."#캐릭터에게 피해를 주면 사라집니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.WEALTHY_HEART] = {
			Name = "",
			Description = ""
			.."#↑ {{Heart}}최대 체력 +1"
			.."#↑ {{GoldenHeart}}황금하트 +1"
			.."#{{Beggar}} 거지가 보상을 추가로 드랍할 확률 증가"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.FIRE_AND_ICE] = {
			Name = "",
			Description = ""
			.."#캐릭터가 반반 오라를 두릅니다."
			.."#{{Burning}} 붉은 오라 안의 적에게 화상을 줍니다."
			.."#{{Freezing}} 푸른 오라 안의 적을 느리게 하며 오랫동안 있으면 빙결시킵니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.LUMS] = {
			Name = "",
			Description = ""
			.."#스테이지 전체에 10마리의 반딧불이가 흩어집니다."
			.."#10마리의 반딧불이를 전부 찾으면 픽업 여러 개를 드랍합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.PSYCHEDELIC_SPORES] = {
			Name = "",
			Description = ""
			.."#공격 시 8%의 확률로 구름 눈물이 나갑니다."
			.."#구름 눈물 명중 시 꿈의 구름이 나오며;"
			.."#>>> 꿈의 구름 안에 있으면 색상에 따라 능력치 증가"
			.."#{{LuckSmall}} 행운 15+일 때 40% 확률"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.PERSONALITY_SPLIT] = {
			Name = "",
			Description = ""
			--.."#Grants 2-3 floating masks each room"
			--.."#When Isaac is looking in their direction they grant special effects"
			--.."#These effects depent on their type"
			.."#방 입장 시 2~3개의 마스크가 생깁니다."
			.."#캐릭터가 마스크의 방향을 바라보는 동안 종류에 따라 특수 효과가 생깁니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.PRIMORDIAL_SIN] = {
			Name = "",
			Description = ""
			.."#저주 수치 +10"
			.."#저주 수치 증가량 x2"
			.."#저주받은 존재의 등장 시 요구되는 저주 수치 하한선이 감소합니다."
			.."#{{DamageSmall}} 저주받은 존재 처치 시 공격력 +0.02"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.SCRAPHEAP] = {
			Name = "",
			Description = ""
			.."#{{Collectible"..LNF.CollectibleType.SCRAPHEAP.."}} {{TreasureRoom}}보물방에 Scrapheap를 추가로 소환합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.MENTAL_BREAKDOWN] = {
			Name = "",
			Description = ""
			.."#{{TearsSmall}} 캐릭터가 적에게 다가갈수록 연사 증가"
			.."#증가된 연사는 적과 멀어지면 사라집니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.BATTERY_BAG] = {
			Name = "",
			Description = ""
			.."#{{Battery}} 획득 시 배터리를 드랍합니다."
			.."#{{Battery}} 완충 상태에서 배터리 획득 시 담을 수 있습니다. (최대 9)"
			.."#{{ButtonRT}} 버튼을 꾹 눌러 담은 배터리를 드랍합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.ROTTEN_POTATO] = {
			Name = "",
			Description = ""
			.."#↑ {{Heart}}최대 체력 +1"
			.."#↑ {{RottenHeart}}썩은하트 +1"
			.."#↑ {{DamageSmall}}공격력 +0.5"
			.."#{{Battery}} 획득 시 액티브 아이템을 완충시킵니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.COOL_DRINK] = {
			Name = "",
			Description = ""
			.."#↓ {{UnknownHeart}}빨간하트 -1~3"
			.."#↑ {{SpeedSmall}}이동속도 +0.2"
			.."#↑ {{DamageSmall}}공격력 +1"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.CARROT_STICKS] = {
			Name = "",
			Description = ""
			.."#↑ {{Heart}}최대 체력 +1"
			.."#↑ {{HealingRed}}빨간하트 +2"
			.."#↑ {{RangeSmall}}사거리 +1.25"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.SUGARED_CEREAL] = {
			Name = "",
			Description = ""
			.."#↑ {{SpeedSmall}}이동속도 +0.2"
			.."#↑ {{LuckSmall}}행운 +1"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.RATIONS] = {
			Name = "",
			Description = ""
			.."#↑ {{HealingRed}}빨간하트 +0.5"
			.."#↑ {{DamageSmall}}공격력 +0.25"
			.."#스테이지 진입 시 위의 효과 추가로 발동 (2회 한정)"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.DRY_BISCUIT] = {
			Name = "",
			Description = ""
			.."#↑ {{Heart}}최대 체력 +1"
			.."#스테이지 진입 시 반칸짜리 체력이 한칸으로 채워집니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.BRANDING_IRON] = {
			Name = "",
			Description = ""
			.."#↑ {{SpeedSmall}}이동속도 +0.2"
			.."#↑ {{TearsSmall}}연사 +0.3"
			.."#획득 시 피격 효과를 6회 발동합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.STINGER] = {
			Name = "",
			Description = ""
			.."#↑ {{TearsSmall}}연사 +0.7"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.FRAGILE_STRENGTH] = {
			Name = "",
			Description = ""
			.."#↑ {{DamageSmall}}공격력 배율 x1.6x"
			.."#!!! {{DamageSmall}} 패널티 피격 시 공격력 배율이 x0.9로 감소하며;"
			.."#>>> {{Shop}}상점에서 {{Coin}}으로 복구할 수 있습니다."
			.."#복구 비용은 복구 회수에 비례하여 증가합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.BROKEN_STRENGTH] = {
			Name = "",
			Description = ""
			.."#↓ {{DamageSmall}}공격력 배율 x0.9"
			.."#{{Collectible" .. LNF.CollectibleType.FRAGILE_STRENGTH .. "}} {{Shop}}상점에서 {{Coin}}으로 복구 가능"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.BLOOD_BALL] = {
			Name = "",
			Description = ""
			.."#대각선으로 돌아다닙니다."
			.."#적과 접촉 시 여러 개의 흩뿌리는 눈물로 터집니다."
			.."#일정 시간이 지나면 다시 생깁니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.LIL_GUARDIAN] = {
			Name = "",
			Description = ""
			.."#캐릭터 위쪽에 있는 벽에 붙으며 좌우로 캐릭터를 따라다닙니다."
			.."#주기적으로 아래의 적에게 최대 14의 피해를 줍니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.LIL_FORSAKEN] = {
			Name = "",
			Description = ""
			.."#대각선으로 돌아다니며 보이지 않습니다."
			.."#적과 접촉 시 잠시동안 보이며 접촉한 적에게 8의 피해를 줍니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.TREE_OF_LIFE] = {
			Name = "",
			Description = ""
			.."#{{ColorOrange}}매우 빠르게{{CR}} 대각선으로 돌아다닙니다."
			.."#캐릭터가 근처에 있는 동안 적에게 피해를 받지 않습니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.LIL_MAW] = {
			Name = "",
			Description = ""
			.."#공격방향으로 돌진하며 벽 바깥으로 나갈시 반대편 벽으로 이어서 등장합니다."
			.."#>>> 돌진 중 접촉하는 적에게 초당 20의 피해를 주며;"
			.."#>>> 캐릭터가 근처에 있으면 돌진을 멈춥니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.DIVIDED_BABY] = {
			Name = "",
			Description = ""
			.."#하나는 캐릭터의 주변을 돌며 하나는 빠르게 대각선으로 돌아다닙니다."
			.."#둘 다 접촉하는 적에게 초당 7.5의 피해를 줍니다."
			.."#서로 접촉 시 그 방의 적에게 3의 피해를 줍니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.MUNITUS_BABY] = {
			Name = "",
			Description = ""
			.."#본체와 별개로 부하를 추가로 소환합니다."
			.."#부하는 본체 주변을 돌며 접촉하는 적에게 초당 2.8의 피해를 주며 탄환을 막아줍니다."
			.."#본체는 공격방향으로 4.2의 눈물을 발사합니다."
			.."#부하는 공격방향으로 2.8의 눈물을 발사합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.DRY_BONES] = {
			Name = "",
			Description = ""
			.."#캐릭터의 4방향을 가리킵니다."
			.."#접촉한 적에게 초당 5의 피해를 줍니다."
			.."#공격 시 돌진하며 접촉한 적에게 7의 피해를 주며;"
			.."#>>> 일정 시간 이후 캐릭터에게 돌아옵니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.CUTIE] = {
			Name = "",
			Description = ""
			.."#대각선으로 돌아다닙니다."
			.."#{{Charm}} 접촉한 적을 매혹시킵니다."
			.."#{{Bait}} 탄환을 막아주며 탄환을 발사한 적에게 표식을 겁니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.MASHY] = {
			Name = "",
			Description = ""
			.."#대각선으로 돌아다닙니다."
			.."#2개의 돌 사이에 핏덩이가 달립니다."
			.."#핏덩이가 적 접촉 시 돌이 모이며 접촉한 적에게 초당 120의 피해를 줍니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.DRIZZLE_MAKER] = {
			Name = "",
			Description = ""
			.."#{{Collectible572}} 공격방향으로 공격력 5.6의 오컬트 눈물을 발사합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.REVENANTS_HEAD] = {
			Name = "",
			Description = ""
			.."#캐릭터의 주변을 돕니다."
			.."#접촉한 적에게 초당 11의 피해를 주며;"
			.."#>>> 접촉으로 적 처치 시 충전 후;"
			.."#>>> 공격방향으로 보라색 불 여러 발을 발사합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.FRUIT_OF_EDEN] = {
			Name = "",
			Description = ""
			.."#캐릭터의 주변을 돌며 가장 가까운 적의 방향으로 이끌립니다."
			.."#{{Timer}} 방 당 1회 한정:"
			.."#>>> 접촉한 적에게 300의 피해 + 빛줄기를 소환합니다."
			.."#>>> {{ColorGray}}(보스의 경우 100){{CR}}"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.LOW_PRIEST] = {
			Name = "",
			Description = ""
			.."#캐릭터의 주변을 돕니다."
			.."#단일방향으로 캐릭터의 공격력 x0.5의 눈물을 발사합니다."
			.."#공격방향은 방 입장 시 랜덤으로 바뀝니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.ROBO_BABY_X] = {
			Name = "",
			Description = ""
			.."#대각선으로 돌아다닙니다."
			.."#주변에 원형레이저를 두르며;"
			.."#>>> 레이저는 적에게 0.6의 지속 피해를 줍니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.MARK_ONE] = {
			Name = "",
			Description = ""
			.."#방 입장 시 각 적에게 원형 레이저를 두릅니다."
			.."#>>> 레이저는 적에게 0.33의 지속 피해를 주며;"
			.."#>>> 화면 밖에서 작아지며 최소 크기 이하이면 사라집니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.GLASS_HEART] = {
			Name = "",
			Description = ""
			.."#{{SoulHeart}} 사용 시 소울하트 +1"
			.."#!!! 패널티 피격 시 깨지며 충전량을 채우면 복구할 수 있습니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.BROKEN_GLASS_HEART] = {
			Name = "",
			Description = ""
			.."#{{SoulHeart}} {{ColorGray}}사용 시 소울하트 +1{{CR}}(파괴됨)"
			.."#사용 시 복구됩니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.EPIDEMIC] = {
			Name = "",
			Description = ""
			.."#사용 시 조준점을 이동시킨 곳으로 노란 장판을 생성합니다."
			.."#>>> 조준점 이동 중 조준점의 위치에 작은 초록 장판을 생성합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.ANTHRAX] = {
			Name = "",
			Description = ""
			.."#사용 시 주변의 적을 일정 시간 이후 폭파시켜;"
			.."#>>> 여러 방향으로 눈물을 흩뿌립니다."
			.."#!!! {{ColorGray}}(보스에게 무효과)"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.GONG] = {
			Name = "",
			Description = ""
			.."#{{ChallengeRoom}} 사용 시 새로운 도전방으로 이동합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.CUPIDS_BOW] = {
			Name = "",
			Description = ""
			.."#사용 시 그 방의 적을 한 쌍의 페어로 묶으며;"
			.."#>>> 한 쪽이 피해를 받으면 다른 한 쪽도 피해를 받습니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.DADS_HAMMER] = {
			Name = "",
			Description = ""
			.."#{{BleedingOut}} 사용 시 그 방의 적에게 5의 출혈 피해를 주며;"
			.."#>>> 6초간 이동을 봉인시킵니다."
			.."#!!! {{ColorGray}}(보스의 경우 이동 방향만 초기화)"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.ISAACS_TOYS] = {
			Name = "",
			Description = ""
			.."#사용 시 소지 중인 랜덤 패시브를 하나 제거하고 제거한 패시브와 랜덤 보물방 아이템을 하나 생성합니다."
			.."#둘 중 하나만 획득 가능"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.MOIRAI_STRING] = {
			Name = "",
			Description = ""
			.."#사용 시 그 방의 피해를 입은 적에게 10의 피해를 줍니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.GOSPEL_OF_JUDAS] = {
			Name = "",
			Description = ""
			.."#사용 시 그 방의 판매 중인 아이템 하나를 흡수합니다."
			.."#>>> 흡수된 아이템이 있는 상태에서 패널티 피격 시 그 아이템이 사라집니다."
			.."#!!! 흡수된 아이템이 있는 상태에서 완충 시 강제로 사용되며;"
			.."#>>> 그 아이템을 2개 획득합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.DISSOLVING_CAT] = {
			Name = "",
			Description = ""
			.."#사용 시 하늘색 자폭 파리 2~4마리 소환합니다."
			.."#하늘색 자폭 파리는 주기적으로 하늘색 장판을 생성합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.DEDALS_BLUEPRINT] = {
			Name = "",
			Description = ""
			.."#사용 시 캐릭터 근처의 문 반대편 방으로 이동합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.GROSS_REMOTE] = {
			Name = "",
			Description = ""
			.."#가시공이 좌우로 움직이며 접촉한 적에게 2.5의 지속 피해를 줍니다."
			.."#사용 시 가시공 이동방향을 상하/좌우로 전환합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.CURSED_GEM] = {
			Name = "",
			Description = ""
			.."#!!! 저주 수치 50 이상일 때 제거됨"
			.."#사용 시 그 방의 적을 전부 처치하며;"
			.."#>>> {{Warning}} 저주 수치 +1"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.CURSED_D6] = {
			Name = "",
			Description = ""
			.."#{{Collectible105}} 사용 시 그 방의 아이템을 다른 아이템으로 바꾸며;"
			.."#>>> {{Warning}} 바꾼 아이템 당 저주 수치 +1"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.PRESCRIPTION] = {
			Name = "",
			Description = ""
			.."#{{Pill}} 사용 시 소지 중인 알약을 제거하며 효과를 확인시킵니다."
			.."#>>> 30%의 확률로 제거된 알약을 다시 소환합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.ROBOTS_BATTERY] = {
			Name = "",
			Description = ""
			.."#!!! 소지 중일 때"
			.."#>>> 모듈 슬롯 +2"
			.."#>>> 적 처치 시 확률적으로 모듈을 드랍합니다."
			.."#사용 시 소지 중인 모듈의 효과를 발동합니다."
			.."#{{ButtonRT}} 버튼을 꾹 눌러 소지 중인 모듈을 버립니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.WORKSHOP] = {
			Name = "",
			Description = ""
			.."#아이템을 드는 중 사용 시 여러 개의 픽업 및 상자로 분해합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.MOON_ROCK] = {
			Name = "",
			Description = ""
			.."#{{Timer}} 사용 시 Dream Mode 발동:"
			.."#>>> 체력이 70% 이상인 적 몇 마리를 꿈의 챔피언으로 강화시킵니다."
			.."#>>> 꿈 몬스터 처치 시 Dream Mode 발동 한정 랜덤 능력치 증가"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.NIGHTMARE_FUEL] = {
			Name = "",
			Description = ""
			.."#사용 시 캐릭터를 쫓아다니는 Nightmare Gaper가 등장합니다."
			.."#Nightmare Gaper 처치 시 주변의 적에게 10의 피해를 줍니다."
			.."#!!! Nightmare Gaper 접촉 시 캐릭터에게 피해를 주지 않으나;"
			.."#>>> 효과를 강제로 종료합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.HOT_ROCKS] = {
			Name = "",
			Description = ""
			.."#!!! 소지 중일 때:"
			.."#>>> {{DamageSmall}}공격력 배율 x1.3"
			.."#>>> !!! 3분마다 체력 1칸의 패널티 + 화염 피해를 받습니다."
			.."#사용 시 피해 시점을 지연시킵니다."
			.."#!!! 3회 사용 시 제거됨"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.TWO_HOT_ROCKS] = {
			Name = "",
			Description = ""
			.."#!!! 소지 중일 때:"
			.."#>>> {{DamageSmall}}공격력 배율 x1.3"
			.."#>>> !!! 3분마다 체력 1칸의 패널티 + 화염 피해를 받습니다."
			.."#사용 시 피해 시점을 지연시킵니다."
			.."#!!! 2회 사용 시 제거됨"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.ONE_HOT_ROCK] = {
			Name = "",
			Description = ""
			.."#!!! 소지 중일 때:"
			.."#>>> {{DamageSmall}}공격력 배율 x1.3"
			.."#>>> !!! 3분마다 체력 1칸의 패널티 + 화염 피해를 받습니다."
			.."#사용 시 피해 시점을 지연시킵니다."
			.."#!!! 사용 시 제거됨"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.BLOOD_SHRINE] = {
			Name = "",
			Description = ""
			.."#{{Timer}} 사용 시:"
			.."#>>> {{UnknownHeart}}최대 체력 -1 or 소울하트 -3"
			.."#>>> 피의 제단을 소환합니다."
			.."#{{EmptyHeart}} 피의 제단이 있는 상태에서 체력이 없는 경우;"
			.."#>>> 체력 반칸을 보존하며 피의 제단의 위치로 이동 + 그 제단을 파괴합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.ANIMATRONICS_MASK] = {
			Name = "",
			Description = ""
			.."#사용 시 마스크를 씁니다."
			.."#{{Timer}} 마스크를 쓰는 동안:"
			.."#>>> 공격 불가"
			.."#>>> {{Confusion}} 그 방의 적 혼란"
			.."#>>> 일정 시간 이후 마스크를 벗습니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.RED_MASS] = {
			Name = "",
			Description = ""
			.."#사용 시 그 방의 캐릭터와 적 중 랜덤 개체에게 피해를 줍니다."
			.."#>>> 캐릭터의 경우 체력 1칸의 {{ColorOrange}}패널티 피해{{CR}}"
			.."#>>> 일반 적의 경우 즉사 + 15%의 확률로 {{Heart}} 드랍"
			.."#>>> 보스의 경우 최대 체력 20%의 피해"
			.."#!!! (캐릭터가 무적 상태가 아닐 때만 사용 가능)"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.DYNAMITE] = {
			Name = "",
			Description = ""
			.."#사용 시 폭탄을 설치합니다."
			.."#>>> 캐릭터가 폭탄의 범위 밖으로 나갈 때 폭탄을 추가로 설치합니다."
			.."#>>> 5개의 폭탄의 범위 밖으로 나가면 폭발합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.CollectibleType.TUBE_MILK] = {
			Name = "",
			Description = ""
			.."#!!! 사용 시:"
			.."#>>> {{TearsSmall}}연사 대폭 증가"
			.."#>>> {{DamageSmall}}공격력 대폭 감소"
			.."#{{Timer}} 증감한 연사 및 공격력은 서서히 돌아옵니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
	}

	local TrinketDesc = {
		[Isaac.GetTrinketIdByName("Spider Leg")] = {
			Name = "",
			Description = ""
			.."#자폭 거미의 속도 증가"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.GIFT_OF_MYRRH] = {
			Name = "",
			Description = ""
			.."#방 클리어 시 감소하는 저주 수치 하한선이 사라집니다."
			.."#{{Heart}} 스테이지 진입 시 랜덤 하트를 드랍합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.GIFT_OF_GOLD] = {
			Name = "",
			Description = ""
			.."#저주 수치 증가량 -50%"
			.."#{{Coin}} 스테이지 진입 시 동전 +5"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.GIFT_OF_FRANKINCENSE] = {
			Name = "",
			Description = ""
			.."#저주받은 존재의 등장 시 요구되는 저주 수치 하한선이 증가합니다."
			.."#{{Key}} 스테이지 진입 시 열쇠를 하나 드랍합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.PROCESSION] = {
			Name = "",
			Description = ""
			.."#스테이지 진입 시 가장 가까운 방 중 하나를 자동으로 클리어합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.RITUAL_CANDLE] = {
			Name = "",
			Description = ""
			.."#저주받은 존재가 초당 2.5의 지속 피해를 받습니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.GLADIATORS_AXE] = {
			Name = "",
			Description = ""
			.."#{{Charm}} 방 입장 시 챔피언 몬스터가 확률적으로 매혹에 걸립니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.MOTHERLY_LOVE] = {
			Name = "엄마의 사랑",
			Description = ""
			.."#{{MomBossSmall}} Mom 보스 처치 이전까지:"
			.."#{{Heart}} {{BossRoom}}보스방 입장 시 빨간하트 +3"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.CAESARS_WREATH] = {
			Name = "",
			Description = ""
			.."#적 탄환이 일정 확률로 다른 적에게 피해를 줍니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.DARK_HAND] = {
			Name = "검은 손",
			Description = ""
			.."#{{DemonBeggar}} 악마거지가 아이템을 주고 떠날 시 50/50의 확률로;"
			.."#>>> 그 방의 아이템이 무료화 되거나;"
			.."#>>> 그 방의 아이템이 사라집니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.GARDEN_HOSE] = {
			Name = "정원 호스",
			Description = ""
			.."#{{Collectible383}} 피격 시 그 방의 눈물이 6갈래로 분열합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.GOLDEN_BAG] = {
			Name = "황금 가방",
			Description = ""
			.."#그 스테이지에서 각 황금 픽업을 2번 이상 획득 시;"
			.."#>>> 다음 스테이지에서 해당 황금 픽업을 유지합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.SINGLE_SOCK] = {
			Name = "양말 한 짝",
			Description = ""
			.."#{{Collectible402}} 아이템 등장 시 2%의 확률로 다른 배열의 아이템이 등장합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.CARDBOARD_HOUSE] = {
			Name = "",
			Description = ""
			.."#{{Beggar}} 방 클리어 시 랜덤 거지를 소환합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.SMOOTH_DICE] = {
			Name = "",
			Description = ""
			.."#{{Collectible166}} 픽업 획득 시 다른 픽업이 확률적으로 바뀝니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.ERASER_CRUMBS] = {
			Name = "지우개 가루",
			Description = ""
			.."#!!! 일회용"
			.."#{{Collectible638}} 캐릭터에게 가장 먼저 피해를 준 적을 현재 게임에서 지웁니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.GOD_TEARS] = {
			Name = "신의 눈물",
			Description = ""
			.."#{{Collectible331}} 공격 시 3%의 확률로 거대한 후광 눈물을 발사합니다."
			.."#{{LuckSmall}} 행운 6+일 때 18%"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.MASOCHISM] = {
			Name = "마조히즘",
			Description = ""
			.."#{{Collectible486}} 피격 시:"
			.."#>>> 피격 효과를 1회 추가로 발동하며;"
			.."#>>> 빨간 장판을 생성합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.LAPIS_LAZULI] = {
			Name = "",
			Description = ""
			.."#책 아이템 사용 시 충전량 1칸 당 그 방에서:"
			.."#>>> {{TearsSmall}}연사 +0.1"
			.."#>>> {{DamageSmall}}공격력 +0.25"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.UNSUPPORTED_MODULE] = {
			Name = "",
			Description = ""
			.."#액티브 사용 시 확률적으로 캐릭터가 현재 게임에 소지했던 액티브를 추가로 발동합니다."
			.."#발동 확률은 사용한 액티브의 충전량에 비례"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.BUMBOS_COIN] = {
			Name = "",
			Description = ""
			.."#캐릭터가 동전을 잃어 0{{Coin}}이 되면 50%의 확률로 1{{Coin}}이 됩니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.BLACK_SHEEP] = {
			Name = "",
			Description = ""
			.."#방 입장 시 적 하나가 검은양으로 지정됩니다."
			.."#검은양으로 지정된 적은 방 클리어 조건에서 제외됩니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.COMFY_PILLOW] = {
			Name = "",
			Description = ""
			.."#방 입장 시 10%의 확률로 Dream Mode를 발동합니다."
			.."#꿈의 챔피언 처치 시 랜덤 능력치 증가"
			.."#증가한 능력치는 Dream Mode에서만 적용됩니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.QUESTIONNAIRE] = {
			Name = "",
			Description = ""
			.."#스테이지 진입 시 캐릭터에 기반한 픽업을 하나 드랍합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.NIGHTDUST] = {
			Name = "",
			Description = ""
			.."#주기적으로 Nightmare Gaper가 등장합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.RUSTY_WELD] = {
			Name = "",
			Description = ""
			.."#{{DamageSmall}} 흡수된 경우 공격력 +1"
			.."#{{DamageSmall}} 흡수되지 않은 경우 공격력 +0.2"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.WHITE_DWARF] = {
			Name = "",
			Description = ""
			.."#방 입장 시 7%의 확률로 적 근처에 아이템 위습이 생깁니다. (최대 3)"
			.."#위습이 켜져 있는 동안 캐릭터도 해당 위습의 효과를 받습니다."
			.."#적 처치 시 위습도 같이 꺼집니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.PET_SLUG] = {
			Name = "",
			Description = ""
			.."#{{Collectible486}} 방 입장 시 25%의 확률로 피격 효과를 발동합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.TrinketType.TEDDY_BEAR] = {
			Name = "",
			Description = ""
			.."#↑ {{TearsSmall}}연사 +0.3"
			.."#!!! 클리어한 방 진입 시 해당 방을 다시 시작합니다."
			.."#피격 및 스테이지 진입 시 소멸"
			.."{{CR}}",
			QuoteDesc = "",
		},
	}

	local CardDesc = {
		[LNF.Card.CARD_LOOT] = {
			Name = "일반 뽑기",
			Description = ""
			.."#!!! 아래 중 하나 소환:"
			.."#>>> [20%] {{Coin}}동전"
			.."#>>> [20%] {{Key}}열쇠"
			.."#>>> [20%] {{Bomb}}폭탄"
			.."#>>> [20%] {{Heart}}하트"
			.."#>>> [10%] {{Chest}}상자"
			.."#>>> [10%] {{Pill}}알약"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.Card.CARD_MONSTER] = {
			Name = "몬스터 뽑기",
			Description = ""
			.."#!!! 아래 중 하나 발동:"
			.."#>>> [30%] 몬스터 소환"
			.."#>>> [30%] {{Collectible437}}그 방 다시 시작"
			.."#>>> [20%] 랜덤 보스방 이동"
			.."#>>> [10%] 트랩도어 소환"
			.."#>>> [10%] 랜덤 저주"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.Card.CARD_TREASURE] = {
			Name = "황금 뽑기",
			Description = ""
			.."#!!! 아래 중 하나 소환:"
			.."#>>> [20%] {{Chest}}상자"
			.."#>>> [20%] {{Trinket}}장신구"
			.."#>>> [20%] {{GrabBag}}자루"
			.."#>>> [20%] {{GoldenChest}}황금상자"
			.."#>>> [10%] {{Collectible}}아이템"
			.."#>>> [10%] {{SoulHeart}}/{{DamageSmall}}+0.3/{{LuckSmall}}+1"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.Card.RUNE_TENEBRIS] = {
			Name = "테네브리스",
			Description = ""
			.."#{{Collectible}} 아이템을 2개 소환합니다."
			.."#↓ 다음 스테이지 진입 시 모든 저주가 발동됩니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.Card.RUNE_CAECUS] = {
			Name = "카에쿠스",
			Description = ""
			.."#{{Collectible691}} 그 스테이지에서 {{Quality2}}등급 이하의 아이템이 75%의 확률로 바뀝니다."
			.."#↓ 다음 스테이지에서 {{Quality2}}등급 이상의 아이템이 75%의 확률로 바뀝니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.Card.RUNE_PERDITA] = {
			Name = "페르디타",
			Description = ""
			.."#↑ 그 스테이지에서 {{Heart}}/{{Coin}}/{{Key}}/{{Bomb}}/{{Battery}} 픽업이 하나 더 나옵니다."
			.."#↓ 다음 스테이지에서 픽업을 주울 수 없습니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.Card.RUNE_MISERERE] = {
			Name = "미제레레",
			Description = ""
			.."#{{Heart}} 빨간하트 +4 (초과회복은 {{SoulHeart}})"
			.."#↓ 다음 스테이지에서 적이 70%의 확률로 하나씩 더 등장합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.Card.RUNE_GIGAS] = {
			Name = "기가스",
			Description = ""
			.."#{{Timer}} 사용 시 그 스테이지에서;"
			.."#>>> {{SpeedSmall}}이동속도 +0.3"
			.."#>>> {{TearsSmall}}연사 +0.2"
			.."#>>> {{DamageSmall}}공격력 +3"
			.."#>>> {{ShotspeedSmall}}탄속 +0.4"
			.."#>>> {{LuckSmall}}행운 +4"
			.."#↓ 다음 스테이지에서 증가량의 150%만큼 감소"
			.."# 그 다음 스테이지에서 감소량의 일부 복원"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.Card.RUNE_BLANK_CURSED] = {
			Name = "비어있는 룬",
			Description = ""
			.."#랜덤 저주받은 룬의 효과를 발동합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.Card.GLYPH_HAGALAZ] = {
			Name = "하갈라즈 문양",
			Description = ""
			.."#{{Bomb}} 그 방의 적을 폭파시킵니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.Card.GLYPH_JERA] = {
			Name = "제라 문양",
			Description = ""
			.."#{{Collectible476}} 가장 가까운 픽업 하나를 여러 번 복사합니다."
			.."#{{Blank}} {{ColorGray}}(그 방의 다른 픽업 수 / 2)"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.Card.GLYPH_EHWAZ] = {
			Name = "에와즈 문양",
			Description = ""
			.."#{{Collectible660}} 그 스테이지의 다른 방으로 이동하는 포탈 4개를 소환합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.Card.GLYPH_DAGAZ] = {
			Name = "다가즈 문양",
			Description = ""
			.."#저주 수치 -10"
			.."#{{AngelChanceSmall}} 악마방 확률을 천사방 확률로 바꿉니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.Card.GLYPH_ANSUZ] = {
			Name = "안수즈 문양",
			Description = ""
			.."#맵에 특수방의 위치를 표시하며;"
			.."#>>> {{Collectible333}} 다음 스테이지 진입 시 맵에 특급비밀방을 제외한 모든 방의 위치가 표시 + Lost 저주 해제"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.Card.GLYPH_PERTHRO] = {
			Name = "페트로 문양",
			Description = ""
			.."#소지 중인 랜덤 패시브를 하나 제거하고 제거한 패시브와 랜덤 아이템을 하나 생성합니다."
			.."#둘 중 하나만 획득 가능"
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.Card.GLYPH_BERKANO] = {
			Name = "벨카노 문양",
			Description = ""
			.."#{{Timer}} 사용 시 그 방에서:"
			.."#>>> {{Collectible357}} 소지중인 패밀리어를 복사합니다."
			.."#>>> 소지 중인 파란 아군 파리 및 거미를 2배로 늘립니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.Card.GLYPH_ALGIZ] = {
			Name = "알기즈 문양",
			Description = ""
			.."#{{HolyMantle}} 1분간 Holy Mantle 아이템 효과를 얻습니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.Card.GLYPH_BLANK] = {
			Name = "비어있는 문양",
			Description = ""
			.."#랜덤 문양 효과를 발동합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.Card.CARD_SOUL_JOSEPH] = {
			Name = "요셉의 영혼",
			Description = ""
			.."#{{Timer}} 사용 시 Dream Mode를 발동하며;"
			.."#>>> Dream Mode 종료 시까지 모든 능력치 증가"
			.."#Moon Shard를 3개 소환합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.Card.RUNE_MOON_SHARD] = {
			Name = "월석 조각",
			Description = ""
			.."#{{Timer}} 사용 시 Dream Mode 발동:"
			.."#>>> 체력이 70% 이상인 적 몇 마리를 꿈의 챔피언으로 강화시킵니다."
			.."#>>> 꿈 몬스터 처치 시 Dream Mode 종료 시까지 랜덤 능력치 증가"
			.."#30%의 확률로 Moon Shard를 드랍합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.Card.CARD_SOUL_ROBOT] = {
			Name = "로봇의 영혼",
			Description = ""
			.."#현재 게임에서 획득했던 액티브 중 하나를 사용합니다."
			.."#{{Battery}} 획득했던 액티브가 없을 경우 메가배터리를 하나 소환합니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
	}

	local PillDesc = {
		[LNF.PillEffect.PENICILIN] = {
			Name = "펜실린",
			Description = ""
			.."#{{Heart}} 빨간하트 +1"
			.."#1초간 무적이 됩니다."
			.."{{CR}}",
			Horse = ""
			.."#{{Heart}} 빨간하트 {{ColorCyan}}+2{{CR}}"
			.."#{{ColorCyan}}2{{CR}}초간 무적이 됩니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.PillEffect.INFESTED3] = {
			Name = "감염...",
			Description = ""
			.."#그 방의 픽업을 자폭 거미로 바꿉니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
		[LNF.PillEffect.PSYCHOSIS] = {
			Name = "정신증",
			Description = ""
			.."#그 방을 다시 시작하며 다시 소환된 적이 챔피언으로 바뀝니다."
			.."{{CR}}",
			QuoteDesc = "",
		},
	}

	local ConditionalDesc = {
		["FFEIDKR Robot Battery"] = " :추가 모듈 슬롯 +2",
		["FFEIDKR TRobot Scrapheap"] = " 보물방의 아이템이 Scrapheap으로 바뀌며 획득 시 잡동사니 여러 개로 바뀝니다.",
		["FFEIDKR TRobot Workshop"] = ""
		.." 사용 시 워크샵 트리 창을 엽니다."
		.."#>>> 워크샵 트리에서 Enter 키를 통해 잡동사니를 소모하여 아이템을 획득할 수 있습니다."
		.."#아이템을 드는 중 사용 시 여러 개의 잡동사니로 분해합니다.",
		["FFEIDKR TJoseph Nightmare"] = " 사용 시 그 방에서 Nightmare Gaper가 전부 사라지며;"
		.."#>>> 악몽 강도 감소",
	}
	for entry, desc in pairs(ConditionalDesc) do
		EID.descriptions["ko_kr"].ConditionalDescs[entry] = desc
	end
	EID:AddPlayerConditional(LNF.CollectibleType.ROBOTS_BATTERY, LNF.PlayerType.Robot, "FFEIDKR Robot Battery", nil, false)
	EID:AddPlayerConditional(LNF.CollectibleType.SCRAPHEAP, LNF.PlayerType.TaintedRobot, "FFEIDKR TRobot Scrapheap", nil, false)
	EID:AddPlayerConditional(LNF.CollectibleType.WORKSHOP, LNF.PlayerType.TaintedRobot, "FFEIDKR TRobot Workshop", nil, false)
	EID:AddPlayerConditional(LNF.CollectibleType.NIGHTMARE_FUEL, LNF.PlayerType.TaintedJoseph, "FFEIDKR TJoseph Nightmare", nil, false)

	for playerType, chardesc in pairs(CharacterDesc) do
		EID:addCharacterInfo(playerType, chardesc.Description, chardesc.Name, "ko_kr")
		if InventoryDescriptions then
			chardesc.Detailed = chardesc.Detailed or chardesc.Description -- 임시
			EID:addEntity(InvDescEIDType.PLAYER, InvDescEIDVariant.DEFAULT, playerType, chardesc.Name, chardesc.Detailed, "ko_kr")
		end
		EID:addBirthright(playerType, chardesc.Birthright, chardesc.Name, "ko_kr")
	end

	if InventoryDescriptions then
		local idesc = InventoryDescriptions
		EID:addEntity(-1021, 0, -995, CurseDesc[-995].Name, CurseDesc[-995].Description, "ko_kr")
		EID:addEntity(-1021, 0, -994, CurseDesc[-994].Name, CurseDesc[-994].Description, "ko_kr")
		EID:AddIconToObject(-1021, 0, -995, "Collectible"..CollectibleType.COLLECTIBLE_CHAOS)
		EID:AddIconToObject(-1021, 0, -994, "Collectible"..CollectibleType.COLLECTIBLE_CHAOS)
		---@return InventoryDescEntry[]
		local function getCurseEntries()
			local entries = {} ---@type InventoryDescEntry[]
			do
				---@type InventoryDescEntry
				local entry = {
					Type = -1021,
					Variant = 0,
					SubType = -995,
					Frame = function()
						return 10
					end,
					Icon = "{{Collectible"..CollectibleType.COLLECTIBLE_CHAOS.."}}",
					LeftIcon = "{{EmptyBoneHeart}}",
					ListSecondaryTitle = "LNF 추가 시스템",
				}
				table.insert(entries, entry)
			end
			do
				---@type InventoryDescEntry
				local entry = {
					Type = -1021,
					Variant = 0,
					SubType = -994,
					Frame = function()
						return 10
					end,
					Icon = "{{Collectible"..CollectibleType.COLLECTIBLE_CHAOS.."}}",
					LeftIcon = "{{EmptyBoneHeart}}",
					ListSecondaryTitle = "LNF 추가 시스템",
				}
				table.insert(entries, entry)
			end
			return entries
		end
		wakaba_krdesc:AddPriorityCallback("WakabaCallbacks.INVENTORY_DESCRIPTIONS_BASIC_ENTRIES", -359, function (_) return getCurseEntries() end)
	end

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
	for itemID, itemdesc in pairs(PillDesc) do
		EID:addPill(itemID, itemdesc.Description, itemdesc.Name, "ko_kr")
		if itemdesc.Horse then
			EID:addHorsePill(itemID, itemdesc.Horse, itemdesc.Name, "ko_kr")
		end
	end

	return {
		targetMod = "Lost and Forgotten",
		characters = CharacterDesc,
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
		cards = CardDesc,
	}

end