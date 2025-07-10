
if SacredDreams then

	if (Isaac.GetItemIdByName("Dreamer's Scroller") <= 0) then
		table.insert(wakaba_krdesc.ERRORS, {
			err_mod = "Sacred Dreams",
			current = "1.1.x",
			required = "Act 1 (1.2.0)",
		})
		return
	end

	EID._currentMod = "Sacred Dreams"
	local mod = SacredDreams
	local Guard = SacredDreams:Guard()

	local Items = SDMod.Item
	local Trinkets = SDMod.Trinket
	local Cards = SDMod.Consumable

	local StatusEffectDesc = {
		SOMNO = "#{{Somno}} {{ColorYellow}}기면 상태의 적은 느려지며 추가 피해를 받으나, 효과 종료 후 일정 시간동안 기면에 면역이 됩니다.",
		DECAY = "#부식 상태의 적은 최대 체력에 비례한 지속 피해를 받습니다. (보스의 경우 최대 25)#부식 상태 적 처치 시 적 기준 랜덤한 방향으로 부식성 눈물을 흩뿌립니다.",
		SLOT_SEL = "{{ButtonRT}}교체 버튼으로 능력을 바꿀 슬롯 선택",
		SLOT_REPLACE = "{{ArrowGrayUp}} !!!{{ColorOrange}}아래 능력을 위 능력으로 교체합니다.",
		SOMNO_DURATION = "#{{Somno}} 기면 상태 시간 ",
		SOMNO_COOLDOWN = "#{{Battery}} Sand Pouch 충전 속도 ",
	}

	local function sandPouchEIDExtra(type)
		local durMult = Guard.PouchSomnolenceMultiplier[type]
		local pouchMult = Guard.PouchChargeMultiplier[type]

		local string1, string2
		local durArrows, pouchArrows

		if durMult == 1 then
				durArrows = "{{ColorYellow}}유지"
		elseif durMult > 1 then
				if durMult >= 1.45 then
						durArrows = "↑{{BlinkYellowGreen}}대폭 증가{{CR}}"
				elseif durMult >= 1.15 then
						durArrows = "↑{{BlinkYellowGreen}}증가{{CR}}"
				else
						durArrows = "↑{{BlinkYellowGreen}}소폭 증가{{CR}}"
				end
		else
				if durMult <= 0.55 then
						durArrows = "↓{{BlinkYellowRed}}대폭 감소{{CR}}"
				elseif durMult <= 0.85 then
						durArrows = "↓{{BlinkYellowRed}}감소{{CR}}"
				else
						durArrows = "↓{{BlinkYellowRed}}소폭 감소{{CR}}"
				end
		end
		string1 = StatusEffectDesc.SOMNO_DURATION..durArrows

		if pouchMult == 1 then
				pouchArrows = "{{ColorYellow}}유지"
		elseif pouchMult > 1 then
				if pouchMult >= 1.45 then
						pouchArrows = "↓{{BlinkYellowRed}}대폭 감소{{CR}}"
				elseif pouchMult >= 1.20 then
						pouchArrows = "↓{{BlinkYellowRed}}감소{{CR}}"
				else
						pouchArrows = "↓{{BlinkYellowRed}}소폭 감소{{CR}}"
				end
		else
				if pouchMult <= 0.55 then
						pouchArrows = "↑{{BlinkYellowGreen}}대폭 증가{{CR}}"
				elseif pouchMult <= 0.80 then
						pouchArrows = "↑{{BlinkYellowGreen}}증가{{CR}}"
				else
						pouchArrows = "↑{{BlinkYellowGreen}}소폭 증가{{CR}}"
				end
		end
		string2 = StatusEffectDesc.SOMNO_COOLDOWN..pouchArrows
		return {
			DurationDesc = string1,
			CooldownDesc = string2
		}
	end

	local CharacterDesc = {
		[SDMod.PlayerType.PLAYER_GUARD] = {
			Name = "The Dreams Guard",
			Description = "",
			Detailed = ""
				.."#아이작의 꿈을 지키려고 노력하는 수호자입니다."
				.."#{{Somno}} 기면 상태의 적에게 피해를 줄 때마다 모래 게이지가 쌓입니다."
				.."#모래 게이지 완충 시 1포인트가 증가하며 증가한 포인트는 스테이지 진입 시 사용할 수 있습니다."
				.."#{{Collectible"..SDMod.Item.SAND_POUCH.."}} 고유 능력 : 모래 주머니"
				.."#최대 3개의 추가 능력을 강화할 수 있으며 교체를 원할 경우 {{ButtonRT}} 버튼을 통해 슬롯을 선택한 상태에서 업그레이드를 선택할 수 있습니다."
				.."",
			Birthright = "{{Somno}} 기면 상태의 적 처치 시 모래 폭발을 일으킵니다.#{{Somno}} 기면 상태에서 깨어난 적은 기면 상태에서 받은 피해의 75%를 추가로 받습니다.",
			QuoteDesc = "잘 자란 말을 하러 왔다",
		},
	}
	local CollectibleDesc = {
		[SDMod.Item.BEDTIME_STORY] = {
			Description = ""
				.."#사용 시 책을 펼쳐 모래 요정을 소환합니다.#모래 요정은 적에게 기면에 빠지게 합니다."
				.. "",
			Name = "꿈 이야기",
			QuoteDesc = "착한 아이들은 잠 잘 시간",
			StatusEffects = {StatusEffectDesc.SOMNO},
		},
		[SDMod.Item.NIGHTMARE_GRIMOIRE] = {
			Description = ""
				.."#사용 시 책을 펼쳐 악몽의 Gaper를 소환합니다."
				.. "",
			Name = "그리모어 악몽",
			QuoteDesc = "나쁜 아이들은 악몽 꿀 시간",
		},
		[SDMod.Item.SAND_POUCH] = {
			Description = ""
				.."!!! 배터리로 충전 불가#{{Somno}} 사용 시 공격방향의 가까운 적을 기면에 빠지게 합니다."
				.. "", -- Conditional : Can be enhanced by the Dream Guard's somnossences
			Name = "모래 주머니",
			QuoteDesc = "마법의 가루가 담겨있어",
			StatusEffects = {StatusEffectDesc.SOMNO},
		},
		[SDMod.Item.SLEEP_PILLS] = {
			Description = ""
				.."#스테이지 입장 및 방 6개 클리어 시마다 Sedative 알약을 추가로 드랍합니다."
				.. "",
			Name = "수면제",
			QuoteDesc = "나 진짜 자야 돼...",
		},
		[SDMod.Item.RATTLE] = {
			Description = ""
				.."#{{Collectible240}} 공격 중 딸랑이를 흔들어 적에게 피해를 주는 별 모양 눈물을 위로 발사합니다. "
				.. "",
			Name = "낡은 딸랑이",
			QuoteDesc = "흔들흔들",
		},
		[SDMod.Item.GLASS_OF_MILK] = {
			Description = ""
				.."#↑ {{TearsSmall}}연사 +0.75#↓ {{ShotspeedSmall}}탄속 -0.15#2.2%의 확률로 {{Confusion}}혼란 or {{Collectible221}}반사 눈물을 발사합니다.#{{LuckSmall}} 행운 40+일 때 100%"
				.. "",
			Name = "넘치는 우유",
			QuoteDesc = "연사력 증가 + 발사 속도 감소",
		},
		[SDMod.Item.COZY_PILLOW] = {
			Description = ""
				.."#{{Chargeable}} 충전형 배게 공격을 추가합니다. ({{ButtonRT}}교체 버튼으로 토글)#공격키를 누르고 있으면 충전되며 충전량에 따라 피해량이 증가합니다.#배게로 적 명중 시 깃털이 나옵니다.(충전량 비례)"
				.. "",
			Name = "편안한 배게",
			QuoteDesc = "배게싸움이다!",
		},
		[SDMod.Item.MOON_FLOWER] = {
			Description = ""
				.."#{{SecretRoom}} 비밀방 입장 시 달빛 꽃잎을 소환합니다.#달빛 꽃잎 획득 시 {{TearsSmall}}연사 +0.5 (최대 6회 {{TearsSmall}}+3)#패널티 피격 시 일정량의 꽃잎을 잃습니다."
				.. "",
			Name = "월화",
			QuoteDesc = "하나하나의 꽃잎으로 영원한 잠을...",
		},
		[SDMod.Item.VINYL] = {
			Description = ""
				.."#{{TreasureRoom}}/{{Shop}} 입장 시 50%의 확률로 그 방의 배열 정보르 바꾸는 레코드 머신이 등장합니다."
				.. "",
			Name = "아빠의 턴테이블",
			QuoteDesc = "이런걸 듣는 걸 좋아하셨지",
		},
		[SDMod.Item.PLUSHY_GUPPY] = {
			Description = ""
				.."#캐릭터를 따라다니며 가까운 탄환을 막아주거나 가까운 적을 공격합니다.#일정 수 이상 탄환 피해를 받으면 비활성화되며 캐릭터가 접촉 시 다시 활성화됩니다."
				.. "",
			Name = "구피 인형",
			QuoteDesc = "...그대로 있어",
		},
		[SDMod.Item.PLUSHY_PLUM] = {
			Description = ""
				.."#캐릭터의 주변을 돌며 가까운 탄환을 막아주거나 주변의 적을 향해 내려찍습니다.#일정 수 이상 탄환 피해를 받으면 비활성화되며 캐릭터가 접촉 시 다시 활성화됩니다."
				.. "",
			Name = "플럼 인형",
			QuoteDesc = "너가 떠난 자리에...",
		},
		[SDMod.Item.PLUSHY_ZIPPER] = {
			Description = ""
				.."#캐릭터를 따라다니며 적이 아주 가까이 있으면 {{Collectible531}}위쪽으로 피눈물병을 던집니다. #일정 수 이상 탄환 피해를 받으면 비활성화되며 캐릭터가 접촉 시 다시 활성화됩니다."
				.. "",
			Name = "악마 인형",
			QuoteDesc = "푹신한 친구",
		},
		[SDMod.Item.DREAM_SNATCHER] = {
			Description = ""
				.."#{{Throwable}} 사용 시 공격방향으로 짧은 단검을 던집니다.#{{Somno}} 단검에 박힌 적은 주기적으로 기면 피해를 받으며 캐릭터에게 멀어지지 못하게 합니다.#{{Somno}} 재사용 시  회수하며 주변의 적에게 기면 피해를 줍니다."
				.. "",
			Name = "드림 스내쳐",
			QuoteDesc = "꿈 뜯어내기",
			StatusEffects = {StatusEffectDesc.SOMNO},
		},
		[SDMod.Item.LITTLE_SHEEP] = {
			Description = ""
				.."#{{Somno}} 적의 주변을 돌며 적에게 20%의 확률로 기면에 빠지게 하는 별조각을 발사합니다."
				.. "",
			Name = "리틀 쉽",
			QuoteDesc = "양 한마리, 양 두마리, 양 세마리...",
			StatusEffects = {StatusEffectDesc.SOMNO},
		},
		[SDMod.Item.FLARING_CANDLE] = {
			Description = ""
				.."#공격키를 누르고 있는 동안 캐릭터 주변을 도는 Mini Min 2마리와 그들이 두르는 오라를 키웁니다.#{{Burning}} 오라 안에 있는 적은 확률적으로 화상에 걸립니다.#{{Burning}} 공격키를 떼면 오라가 사라지며 안에 있는 적에게 화상 피해를 줍니다."
				.. "",
			Name = "불타오르는 양초",
			QuoteDesc = "어둠 속에서 불타올라",
		},
		[SDMod.Item.MIDAS_BOMBS] = {
			Description = ""
				.."#{{Coin}}동전 +15#{{Collectible202}} 폭발이 적을 황금화시킵니다.#{{Bomb}} 폭탄이 없을 경우 5{{Coin}}을 소모하여 {{ColorOrange}}기본형 폭탄{{CR}}을 설치합니다."
				.. "",
			Name = "미다스 폭탄",
			QuoteDesc = "폭발성 탐욕",
		},
		[SDMod.Item.TINY_HORN] = {
			Description = ""
				.."#공격하는 방향으로 공격력 4의 반사+유도 눈물을 발사합니다."
				.. "",
			Name = "타이니 혼",
			QuoteDesc = "웨!",
		},
		[SDMod.Item.LIL_HORNFEL] = {
			Description = ""
				.."#캐릭터를 따라다니며 적의 탄환을 막아줍니다.#탄환을 막을 시 주변에 여러 눈물을 흩뿌립니다.#캐릭터 피격 시 아군 Fly Bomb을 소환합니다.#색돌 파괴 시 추가 보상을 소환합니다."
				.. "",
			Name = "리틀 혼펠",
			QuoteDesc = "폭발하는 친구",
		},
		[SDMod.Item.HARENAS_BLESSINGS] = {
			Description = ""
				.."#스테이지 입장 시 랜덤 축복을 받습니다.# {{ColorYellow}}Scorching Sands{{CR}}: 방 입장 시 일정 시간동안 캐릭터가 둔화 피해를 주는 장판을 깔며 적 처치 시에도 적 위치에 해당 장판이 깔립니다.# {{ColorYellow}}Somnomoon{{CR}}: 그 스테이지에서 달빛 패밀리어를 소환, 캐릭터 주변의 적을 향해 4의 별조각을 발사하며 방 3/6개 클리어 시 강화됩니다.# {{ColorYellow}}Somno Stellarum{{CR}}: 방 입장 시 최대 3마리의 적 위에 별이 떠다니며 해당 적 처치 시 별이 추락, 모래 폭발을 일으킵니다."
				.. "",
			Name = "하레나의 축복",
			QuoteDesc = "꿈나라의 축복",
		},
		[SDMod.Item.KEITH_FETUS] = {
			Description = ""
				.."획득할 때마다 성장합니다.#1단계: 캐릭터 주위를 돌며 적의 탄환을 막아줍니다.#2단계: 적을 따라다니며 적에게 4의 피해를 주는 관통 톱날을 발사합니다. #3단계: 적을 따라다니며 적에게 35의 피해를 주는 {{ColorOrange}}유도 로켓{{CR}}을 발사합니다."
				.. "",
			Name = "태아 든 병",
			QuoteDesc = "",
		},
		[SDMod.Item.TUMOR_HEAD] = {
			Description = ""
				.."#확률적으로 부식성 공격이 나갑니다."
				.. "",
			Name = "종양 머리",
			QuoteDesc = "",
			StatusEffects = {StatusEffectDesc.DECAY},
		},
		[SDMod.Item.DER_SANDMANN] = {
			Description = ""
				.."#{{Somno}} 사용 시 책을 열며 적을 기면에 빠지게 하는 오라를 발산합니다.#{{Blank}} (오라 크기는 열린 상태의 충전량에 비례)#열린 상태에서 적 처치 시 충전량을 소량 채우며;#{{Collectible634}} 열린 상태에서 사용 시 충전량에 비례하여 적에게 피해를 주는 별을 여러개 소환합니다."
				.. "",
			Name = "샌드맨 이야기",
			QuoteDesc = "꿈 속을 안내해 줘",
		},
		[SDMod.Item.PLUSHY_MASCOT] = {
			Description = ""
				.."#스테이지 입장 시 판매 아이템/픽업을 여러 개 소환합니다."
				.. "",
			Name = "마스코트 인형",
			QuoteDesc = "장난감 가게의 흔한 인형",
		},
		[SDMod.Item.DREAMERS_SCROLLER] = {
			Description = ""
				.."#사용 시 꿈의 오브를 하나 지급합니다.#꿈의 오브 사용 시 랜덤 운세 + Sandy 패밀리어 3~4마리와 아래 중 하나를 드랍합니다: # {{Coin}}동전 3개 #{{SoulHeart}}소울하트 반칸 #{{Card}}카드/룬 #{{Trinket}}장신구"
				.. "",
			Name = "꿈의 구슬",
			QuoteDesc = "미래를 바라봐",
		},
	}
	local TrinketDesc = {
		[SDMod.Trinket.PLUSHY_SEAL] = {
			Description = ""
				.."#캐릭터의 주변을 돌며 적의 탄환을 막아줍니다.#스테이지 입장 시 랜덤 하트를 드랍합니다.#일정 수 이상 탄환 피해를 받으면 비활성화되며 캐릭터가 접촉 시 다시 활성화됩니다."
				.. "",
			Name = "표범 인형",
			QuoteDesc = "사랑을 담아 <3",
		},
		[SDMod.Trinket.WISHING_STAR] = {
			Description = ""
				.."!!! 일회용#잠 관련 아이템 수에 따라 별을 소환합니다.#{{ButtonRT}}교체 버튼을 꾹 누르고 버리기 직전에 때면 소원을 빕니다.#소원을 빌면 여러 보상을 드랍합니다."
				.. "",
			Name = "소원의 별",
			QuoteDesc = "반짝반짝 작은 별",
			-- 1/6 확률로 랜덤 배열 아이템, 1/4 확률로 그 방 아이템, 1/4 확률로 자루 2개, 1/3 확률로 페니 5개
		},
		[SDMod.Trinket.TOY_CUBE_1] = {
			Description = ""
				.."#↑ {{TearsSmall}}연사 +1#{{Trinket"..SDMod.Trinket.TOY_CUBE_2.."}} 패널티 피격 없이 다음 스테이지 입장 시 Toy Cube N.2로 강화됩니다."
				.. "",
			Name = "장난감 큐브 N.1",
			QuoteDesc = "1을 셀 수 있어!",
		},
		[SDMod.Trinket.TOY_CUBE_2] = {
			Description = ""
				.."#↑ {{TearsSmall}}연사 +2# ↑ 공격력 +2#{{Trinket"..SDMod.Trinket.TOY_CUBE_3.."}} 패널티 피격 없이 다음 스테이지 입장 시 Toy Cube N.3로 강화됩니다."
				.. "",
			Name = "장난감 큐브 N.2",
			QuoteDesc = "2를 셀 수 있어!",
		},
		[SDMod.Trinket.TOY_CUBE_3] = {
			Description = ""
				.."#↑ {{TearsSmall}}연사 +3# ↑ 공격력 +3# ↑ 사거리 +3"
				.. "",
			Name = "장난감 큐브 N.3",
			QuoteDesc = "3을 셀 수 있어!",
		},
	}

local CardDesc = {
	[SDMod.Consumable.RUNE_ISA] = {
		Description = "{{Freezing}} 그 방의 적을 얼립니다.#보스의 경우 6초동안 석화시킵니다.",
		Name = "이자",
		QuoteDesc = "냉기",
	},
	[SDMod.Consumable.RUNE_FEHU] = {
		Description = "상점 주인과 거래 아이템을 소환합니다.#아이템의 가격은 등급에 따라 달라집니다.",
		Name = "페후",
		QuoteDesc = "풍요",
	},
	[SDMod.Consumable.OBJ_ORB] = {
		Description = "랜덤 운세 + Sandy 패밀리어 3~4마리와 아래 중 하나를 드랍합니다: # {{Coin}}동전 3개 #{{SoulHeart}}소울하트 반칸 #{{Card}}카드/룬 #{{Trinket}}장신구",
		Name = "꿈의 오브",
		QuoteDesc = "지혜롭게 물어봐",
	},
	--[[ [SamaelMod.ITEMS.SAMAELS_FEATHER] = {
		Description = "아이템설명",
		Name = "아이템이름",
		QuoteDesc = "획득멘트",
	}, ]]
}
local PillDesc = {
	[PillEffect.PILLEFFECT_AMIRMIR] = {
		Description = "↑ {{DamageSmall}}공격력 + 3.5#증가한 공격은 23초에 걸쳐 서서히 감소합니다.#{{Somno}} 그 방에서 캐릭터 및 적이 잠에 빠집니다.",
		Name = "진정제",
		QuoteDesc = "",
	},
}

CollectibleDesc[SDMod.Item.DER_SANDMANN_B] = CollectibleDesc[SDMod.Item.DER_SANDMANN]

local somnDesc = {
	["Sandplosion"] = {
		Name = "모래폭발",
		Description = "Sand Pouch의 범위가 캐릭터 주변으로 변경됩니다.",
		QuoteDesc = "범위 공격",
	},
	["Swiftstep"] = {
		Name = "재빠른 스텝",
		Description = "Sand Pouch 사용 시 사용한 방향으로 짧은 거리를 대시합니다. (대시 중 무적)",
		QuoteDesc = "적을 향해 돌진하자!",
	},
	["Pouchtoss"] = {
		Name = "주머니 던지기",
		Description = "Sand Pouch가 지형 관통 투척 공격으로 바뀝니다.",
		QuoteDesc = "휘우우우웅~ 펑!",
	},
	["Sparklingsand"] = {
		Name = "빛나는 모래",
		Description = "{{Somno}} 기면 상태의 적이 지속시간 동안 총합 캐릭터 x5의 피해를 받습니다.",
		QuoteDesc = "졸음은 위험하다구!",
	},
	["Comacloud"] = {
		Name = "코마 구름",
		Description = "Sand Pouch 사용 시 적에게 피해를 주는 코마 구름을 추가로 소환합니다.#코마 구름에 있는 적은 기면 상태에서 벗어나지 못하며 멈추게 됩니다.",
		QuoteDesc = "더 오랫동안 잠들게",
	},
	["Sandy"] = {
		Name = "Sandy!",
		Description = "{{Somno}} 기면 상태 적 처치 시 적을 따라다니며 기면 상태에 걸리게 하는 자폭 모래 요정을 추가로 소환합니다.",
		QuoteDesc = "수면 친구!",
	},
	["Fairytrail"] = {
		Name = "요정의 흔적",
		Description = "Sand Pouch의 공격 범위에 적에게 둔화 피해를 주는 장판을 설치합니다.",
		QuoteDesc = "노란 모랫길",
	},
	["Oversomnia"] = {
		Name = "과수면증",
		Description = "{{Somno}} 기면 상태 중첩 가능 (최대 3)#!!! 중첩 당 추가 피해와 기면 상태 쿨타임 증가",
		QuoteDesc = "못 일어나겠어...",
	},
	["Shootingstar"] = {
		Name = "슈팅 스타",
		Description = "Sand Pouch 사용 시 별조각을 추가로 발사합니다.",
		QuoteDesc = "소원을 빌자!",
	},
	["Deepsleep"] = {
		Name = "깊은 잠",
		Description = "#{{Somno}} 기면 상태 시간 {{BlinkYellowGreen}}50% 증가{{CR}}#{{Battery}} Sand Pouch의 충전 속도 {{BlinkYellowGreen}}소폭 증가{{CR}}",
		QuoteDesc = "기면 시간 증가",
		ExcludeExtra = true,
	},
	["Dreamwarrior"] = {
		Name = "꿈의 전사",
		Description = "{{Somno}} 기면 상태의 적 처치 시 그 방에서 기면 상태의 적에게 5% 추가 피해를 줍니다. (최대 50%)",
		QuoteDesc = "기면 피해 증가",
	},
	["Spindlespikes"] = {
		Name = "스핀들 가시",
		Description = "Sand Pouch를 사용한 위치에 모래 가시를 추가로 소환합니다.",
		QuoteDesc = "손이 찔리지 않도록 조심해",
	},
	["Somnolepticcharge"] = {
		Name = "수면 충전",
		Description = "{{Somno}} 기면 상태의 적 명중 시 주머니를 충전시킵니다.#Sand Pouch 추가 충전 가능",
		QuoteDesc = "주머니의 기력을 모으자!",
	},
	["Sturdystrike"] = {
		Name = "묵직한 공격",
		Description = "Sand Pouch 3번째 사용 시마다 추가 공격을 날립니다.",
		QuoteDesc = "더 많은 모래",
	},
	["Mesmericmortar"] = {
		Name = "메즈메릭 박격포",
		Description = "Q 버튼을 꾹 누르면 주변의 적을 공격하는 대포를 발사합니다. #적의 탄환을 막아주며 너무 많이 맞으면 사라집니다.",
		QuoteDesc = "",
	},
	["Magicmissile"] = {
		Name = "매직 미사일",
		Description = "공격키를 2번 누르면 사거리가 짧은 적 관통 구체를 발사합니다.#구체는 기면 상태의 적에게 추가 피해를 줍니다.#{{Blank}} (구체는 별도의 충전량을 가짐)",
		QuoteDesc = "더블탭 글레이즈",
	},
	["Carelesscarousel"] = {
		Name = "무모한 회오리",
		Description = "Sand Pouch의 공격이 여러번 회전하는 회전 공격으로 바뀝니다.",
		QuoteDesc = "빙글빙글",
	},
	["Cloggyconvolution"] = {
		Name = "콘벌루션 차단",
		Description = "일반 적의 기면 면역 제거#보스의 기면 면역 시간 -75%",
		QuoteDesc = "기면 면역 차단",
	},
	["HourglassHaste"] = {
		Name = "재빠른 모래시계",
		Description = "모래 게이지 충전량 +75%",
		QuoteDesc = "모래 게이지 충전량 증가",
	},
	["Contagiousyawn"] = {
		Name = "전염성 하품",
		Description = "기면 상태의 적이 확률적으로 주변의 적을 기면에 빠지게 합니다.#{{Blank}} (각 적 당 한번만 발동 가능)",
		QuoteDesc = "",
	},
	["Somnambula"] = {
		Name = "Somnambula",
		Description = "가장 가까운 적을 지정합니다.#지정된 적은 기면 상태일 때 추가 피해 +35%",
		QuoteDesc = "그들을 깨우지 마!",
	},
	["Outburst"] = {
		Name = "아웃버스트",
		Description = "기면 상태의 적 명중 시 다른 적을 공격하는 영혼을 소환합니다.#영혼이 적 명중 시 짧은 기면 상태에 빠지게 합니다.",
		QuoteDesc = "모두 꿈나라로",
	},
	["Prettypocketpack"] = {
		Name = "예쁜 주머니 팩",
		Description = "{{Warning}} 포인트 소모 없음 #포인트를 소모하지 않는 업그레이드를 최대 3개 소환합니다.#{{Blank}} (획득 시 즉시 사용, 한 게임 당 1회만 획득 가능)",
		QuoteDesc = "선택은 신중히",
	},
	["Bedtimebundle"] = {
		Name = "베드타임 번들",
		Description = "{{Warning}} 포인트 소모 없음 #스테이지 진입 시 업그레이드 선택지 +1",
		QuoteDesc = "더 많은 능력",
	},
	["Coupon"] = {
		Name = "쿠폰",
		Description = "{{Warning}} 포인트 소모 없음 #업그레이드 하나를 무료로 획득할 수 있습니다. (사용 시 소모)",
		QuoteDesc = "내 이름이 있어!",
	},
	["Freshstart"] = {
		Name = "신선한 시작",
		Description = "{{Warning}} 포인트 소모 없음 #모든 업그레이드를 제거하고 업그레이드에 사용한 포인트를 반환합니다.",
		QuoteDesc = "태초마을이야!",
	},





}
EID:addEntity(1000, SDMod.SOMNOSSENCE, 0, "수면", "음냐음냐", "ko_kr")

EID:addEntity(6, SDMod.Slot.DADS_GRAMOPHONE, 0, "레코드 머신", "1{{Coin}} 소모#사용 시 음악을 바꾸어 그 방의 배열 정보를 바꿉니다.#이후 현재 방에서 주사위류({{Collectible105}}) 아이템 사용 시 이 방에서 재생 중인 음악의 배열을 따릅니다.", "ko_kr")
EID:addEntity(1000, SDMod.SHRINE_SOMNOLEPTIC, 0, "수면 석상", "!!! 일회용#1포인트를 소모하여 능력 슬롯 +1#활성화하지 않은 경우 2{{Bomb}}로 폭파 시 모래 게이지 25% 충전", "ko_kr")

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

SacredDreams:RemoveCallback(ModCallbacks.MC_POST_EFFECT_RENDER, SacredDreams.TDGUpgradesDesc, SDMod.SOMNOSSENCE)

local currlang = "en_us"
function SacredDreams:TDGUpgradesDesc_new(e)
	local s = e:GetSprite()
	local d = e:GetData()
	if d.w_eid_lang and d.w_eid_lang == EID:getLanguage() then return end
	d.w_eid_lang = EID:getLanguage()

	if d.w_eid_lang == "ko_kr" then
		d.EID_Description = nil
	else
		SacredDreams:TDGUpgradesDesc(e)
	end

end
SacredDreams:AddCallback(ModCallbacks.MC_POST_EFFECT_RENDER, SacredDreams.TDGUpgradesDesc_new, SDMod.SOMNOSSENCE)

local function FF_EIDKR_SSCondition(descObj)
	if EID:getLanguage() ~= "ko_kr" and EID:getLanguage() ~= "ko" then return false end
	if EID.InsideItemReminder then return false end
	return
		descObj.ObjType == 1000
		and descObj.ObjVariant == SDMod.SOMNOSSENCE
		and descObj.Entity
		and EID.player
		and EID.player:GetPlayerType() == SDMod.PlayerType.PLAYER_GUARD
end

local function FF_EIDKR_SSDescCallback(descObj)
	local e = descObj.Entity
	local ss = e:GetSprite()
	local sd = e:GetData()
	local ov = ss:GetOverlayAnimation()
	local g = SacredDreams:Guard()
	if somnDesc[ov] then
		local entry = somnDesc[ov]
		descObj.Name = entry.Name
		descObj.Description = entry.Description
		if not entry.ExcludeExtra then
			local exDesc = sandPouchEIDExtra(g.ItemToSlot[ov])
			descObj.Description = descObj.Description .. exDesc.DurationDesc .. "" .. exDesc.CooldownDesc
		end

		local p = EID.player
		local d = p:GetData()
		local pos = d.SDGuardData.SelectedSlot
		local slot = d.SDGuardData.PouchInventory[d.SDGuardData.SelectedSlot]
		if pos == 0 or (slot and slot == 0) then
			EID:appendToDescription(descObj, "#{{ColorOrange}}"..StatusEffectDesc.SLOT_SEL)
		elseif slot then
			for k, v in pairs(g.ItemToSlot) do
				if v == slot then
					local entry2 = somnDesc[k]
					EID:appendToDescription(descObj, ""
						.. "#"..StatusEffectDesc.SLOT_REPLACE
						.. "#{{"..EID.Config["ItemNameColor"].."}}"..entry2.Name
						.. "#"..entry2.Description
					)
					break
				end
			end
		end
	end

	return descObj
end

EID:addDescriptionModifier("FF_EIDKR_Somni", FF_EIDKR_SSCondition, FF_EIDKR_SSDescCallback)

local function FF_EIDKR_SPCondition(descObj)
	if EID:getLanguage() ~= "ko_kr" and EID:getLanguage() ~= "ko" then return false end
	--if (EID.InsideItemReminder) then return false end

	local num_players = Game():GetNumPlayers()
	for i=1,(num_players) do
		local p = Isaac.GetPlayer(i)
		local d = p:GetData()
		if not p:GetPlayerType() == SDMod.PlayerType.PLAYER_GUARD then
			return false
		end
		if not p:HasCollectible(SDMod.Item.SAND_POUCH) then
			return false
		end
		if d.SDGuardData and d.SDGuardData.SelectedSlot ~= 0 then
			if descObj.ObjType == 5 and descObj.ObjVariant == 100 and descObj.ObjSubType == SDMod.Item.SAND_POUCH then return true end
		end
	end
end

local function FF_EIDKR_SPDescCallback(descObj)
	local num_players = Game():GetNumPlayers()
	for i=1,(num_players) do
		local p = Isaac.GetPlayer(i)
		local d = p:GetData()
		if d.SDGuardData and d.SDGuardData.SelectedSlot ~= 0 then
			local slot = d.SDGuardData.PouchInventory[d.SDGuardData.SelectedSlot]
			local g = SacredDreams:Guard()
			local keyStr = g.UpgradeOverlay[slot]
			if keyStr and somnDesc[keyStr] then
				descObj.Description = string.gsub(descObj.Description, "(#{{Player"..SDMod.PlayerType.PLAYER_GUARD..").+", "")
				local name = somnDesc[keyStr].Name
				local desc = somnDesc[keyStr].Description
				EID:appendToDescription(descObj, "#{{Player"..SDMod.PlayerType.PLAYER_GUARD.."}} {{ColorObjName}}".. name.."#"..desc)
				return descObj
			end
		end
	end
	return descObj
end
EID:addDescriptionModifier("FF_EIDKR_SandPouch", FF_EIDKR_SPCondition, FF_EIDKR_SPDescCallback)

if Options.Language == "kr" then
	local g = SacredDreams:Guard()
	for k, v in pairs(somnDesc) do
		if g.UpgradeNames[k] then
			g.UpgradeNames[k] = v.Name
		end
		if g.UpgradeText[k] then
			g.UpgradeText[k] = v.QuoteDesc
		end
	end
end

	return {
		targetMod = "Sacred Dreams",
		characters = CharacterDesc,
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
		cards = CardDesc,
		pills = PillDesc,
	}

end