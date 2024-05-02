
if SacredDreams then

	EID._currentMod = "Sacred Dreams"
	local mod = SacredDreams

	local Items = SDMod.Item
	local Trinkets = SDMod.Trinket
	local Cards = SDMod.Consumable
	
	local StatusEffectDesc = {
		SOMNO = "{{Somno}} 기면 상태의 적은 느려지며 추가 피해를 받으나, 효과 종료 후 일정 시간동안 기면에 면역이 됩니다.",
		SLOT_SEL = "{{ButtonRT}}교체 버튼으로 능력을 바꿀 슬롯 선택",
		SLOT_REPLACE = "{{ArrowGrayUp}} !!!{{ColorOrange}}아래 능력을 위 능력으로 교체합니다.",
	}

	local BirthrightDesc = {
		[SDMod.PlayerType.PLAYER_GUARD] = {
			Name = "The Dreams Guard",
			Description = "{{Somno}} 기면 상태의 적 처치 시 모래 폭발을 일으킵니다.#{{Somno}} 기면 상태에서 깨어난 적은 기면 상태에서 받은 피해의 75%를 추가로 받습니다.",
			QuoteDesc = "잘 자란 말을 하러 왔다",
		},
	}
	local CollectibleDesc = {
		[SDMod.Item.BTS] = {
			Description = ""
				.."#사용 시 책을 펼쳐 모래 요정을 소환합니다.#모래 요정은 적에게 기면에 빠지게 합니다."
				.. "",
			Name = "꿈 이야기",
			QuoteDesc = "",
			StatusEffects = {StatusEffectDesc.SOMNO},
		},
		[SDMod.Item.BON] = {
			Description = ""
				.."#사용 시 책을 펼쳐 악몽의 Gaper를 소환합니다."
				.. "",
			Name = "그리모어 악몽",
			QuoteDesc = "",
		},
		[SDMod.Item.SAND_POUCH] = {
			Description = ""
				.."!!! 배터리로 충전 불가#{{Somno}} 사용 시 공격방향의 가까운 적을 기면에 빠지게 합니다."
				.. "", -- Conditional : Can be enhanced by the Dream Guard's somnossences
			Name = "모래 주머니",
			QuoteDesc = "",
			StatusEffects = {StatusEffectDesc.SOMNO},
		},
		[SDMod.Item.SLEEPPILLS] = {
			Description = ""
				.."#스테이지 입장 및 방 6개 클리어 시마다 Sedative 알약을 추가로 드랍합니다."
				.. "",
			Name = "수면제",
			QuoteDesc = "",
		},
		[SDMod.Item.RATTLE] = {
			Description = ""
				.."#{{Collectible240}} 공격 중 딸랑이를 흔들어 적에게 피해를 주는 별 모양 눈물을 위로 발사합니다. "
				.. "",
			Name = "낡은 딸랑이",
			QuoteDesc = "",
		},
		[SDMod.Item.GLASSOFMILK] = {
			Description = ""
				.."#{{ArrowUp}} {{TearsSmall}}연사 +0.75#{{ArrowDown}} {{ShotspeedSmall}}탄속 -0.15#2.2%의 확률로 {{Confusion}}혼란 or {{Collectible221}}반사 눈물을 발사합니다.#{{LuckSmall}} 행운 40+일 때 100%"
				.. "",
			Name = "넘치는 우유",
			QuoteDesc = "",
		},
		[SDMod.Item.COZYPILLOW] = {
			Description = ""
				.."#{{Chargeable}} 충전형 배게 공격을 추가합니다. ({{ButtonRT}}교체 버튼으로 토글)#공격키를 누르고 있으면 충전되며 충전량에 따라 피해량이 증가합니다.#배게로 적 명중 시 깃털이 나옵니다.(충전량 비례)"
				.. "",
			Name = "편안한 배게",
			QuoteDesc = "",
		},
		[SDMod.Item.MOON_FLOWER] = {
			Description = ""
				.."#{{SecretRoom}} 비밀방 입장 시 달빛 꽃잎을 소환합니다.#달빛 꽃잎 획득 시 {{TearsSmall}}연사 +0.5 (최대 6회 {{TearsSmall}}+3)#패널티 피격 시 일정량의 꽃잎을 잃습니다."
				.. "",
			Name = "월화",
			QuoteDesc = "",
		},
		[SDMod.Item.VINYL] = {
			Description = ""
				.."#{{TreasureRoom}}/{{Shop}} 입장 시 50%의 확률로 그 방의 배열 정보르 바꾸는 레코드 머신이 등장합니다."
				.. "",
			Name = "아빠의 턴테이블",
			QuoteDesc = "",
		},
		[SDMod.Item.PLUSHY_GUPPY] = {
			Description = ""
				.."#캐릭터를 따라다니며 가까운 탄환을 막아주거나 가까운 적을 공격합니다.#일정 수 이상 탄환 피해를 받으면 비활성화되며 캐릭터가 접촉 시 다시 활성화됩니다."
				.. "",
			Name = "구피 인형",
			QuoteDesc = "",
		},
		[SDMod.Item.PLUSHY_PLUM] = {
			Description = ""
				.."#캐릭터의 주변을 돌며 가까운 탄환을 막아주거나 주변의 적을 향해 내려찍습니다.#일정 수 이상 탄환 피해를 받으면 비활성화되며 캐릭터가 접촉 시 다시 활성화됩니다."
				.. "",
			Name = "플럼 인형",
			QuoteDesc = "",
		},
		[SDMod.Item.PLUSHY_ZIPPER] = {
			Description = ""
				.."#캐릭터를 따라다니며 적이 아주 가까이 있으면 {{Collectible531}}위쪽으로 피눈물병을 던집니다. #일정 수 이상 탄환 피해를 받으면 비활성화되며 캐릭터가 접촉 시 다시 활성화됩니다."
				.. "",
			Name = "악마 인형",
			QuoteDesc = "",
		},
		[SDMod.Item.DREAM_SNATCHER] = {
			Description = ""
				.."#{{Throwable}} 사용 시 공격방향으로 짧은 단검을 던집니다.#{{Somno}} 단검에 박힌 적은 주기적으로 기면 피해를 받으며 캐릭터에게 멀어지지 못하게 합니다.#{{Somno}} 재사용 시  회수하며 주변의 적에게 기면 피해를 줍니다."
				.. "",
			Name = "드림 스내쳐",
			QuoteDesc = "",
			StatusEffects = {StatusEffectDesc.SOMNO},
		},
		[SDMod.Item.LITTLE_SHEEP] = {
			Description = ""
				.."#{{Somno}} 적의 주변을 돌며 적에게 20%의 확률로 기면에 빠지게 하는 별조각을 발사합니다."
				.. "",
			Name = "리틀 쉽",
			QuoteDesc = "",
			StatusEffects = {StatusEffectDesc.SOMNO},
		},
		[SDMod.Item.FLARING_CANDLE] = {
			Description = ""
				.."#Spawns little orbiting Mini Mins and increases it's aura when shooting # This Aura has a chance to set enemies within it on fire # When Isaac stops shooting: Sets every enemy in aura's radius on fire"
				.. "",
			Name = "불타오르는 양초",
			QuoteDesc = "",
		},
		[SDMod.Item.MIDAS_BOMBS] = {
			Description = ""
				.."#{{Coin}}동전 +15#{{Collectible202}} 폭발이 적을 황금화시킵니다.#{{Bomb}} 폭탄이 없을 경우 5{{Coin}}을 소모하여 {{ColorOrange}}기본형 폭탄{{CR}}을 설치합니다."
				.. "",
			Name = "미다스 폭탄",
			QuoteDesc = "",
		},
		[SDMod.Item.TINY_HORN] = {
			Description = ""
				.."#공격하는 방향으로 공격력 4의 반사+유도 눈물을 발사합니다."
				.. "",
			Name = "타이니 혼",
			QuoteDesc = "",
		},
		[SDMod.Item.LIL_HORNFEL] = {
			Description = ""
				.."#Has a chance to fire bursts of tears when hit by enemy projectile # Spawns a friendly bomb fly when Isaac takes damage # Will reward you for bombing tinted rocks"
				.. "",
			Name = "리틀 혼펠",
			QuoteDesc = "",
		},
		[SDMod.Item.HARENAS_BLESSINGS] = {
			Description = ""
				.."#Each floor gives you a random blessing # Scorching Sands: Isaac will leave a sand trail behind for some time upon entering a room. Enemies will spawn sand spots upon death # Somnomoon: Familiar that upgrades itself on 3rd and 6th cleared room # Somno Stellarum: upon entering a room, up to 3 enemies can have a dangling star above them. These stars will fall down and explode when their enemy is kiled"
				.. "",
			Name = "하레나의 축복",
			QuoteDesc = "",
		},
		[SDMod.Item.KEITH_FETUS] = {
			Description = ""
				.."획득할 때마다 성장합니다.#1단계: 캐릭터 주위를 돌며 적의 탄환을 막아줍니다.#2단계: 적을 따라다니며 적에게 4의 피해를 주는 관통 톱날을 발사합니다. #3단계: 적을 따라다니며 적에게 35의 피해를 주는 {{ColorOrange}}유도 로켓{{CR}}을 발사합니다."
				.. "",
			Name = "태아 든 병",
			QuoteDesc = "",
		},
		[SDMod.Item.TEIN] = {
			Description = ""
				.."#Firing occasionally shoots a decay tear that applies a 'Decay' status effect on enemies # Decay will slowly deals a small % of enemy's max health # The effect's damage caps at 25 for bosses # Enemies with this status effect will burst into decay tears on death"
				.. "",
			Name = "종양 머리",
			QuoteDesc = "",
		},
		[SDMod.Item.DER_SANDMANN] = {
			Description = ""
				.."#Replaces itself with it's open variant and spawns a book with an aura on use # Dealing damage while holding the open variant will recharge it # On open variant's use: Spawns ghost-like stars and dreams that chases enemies and explodes on impact and replaces itself back to closed variant # Aura's radius and amount of stars depends on item's charge"
				.. "",
			Name = "샌드맨 이야기",
			QuoteDesc = "",
		},
		[SDMod.Item.PLUSHY_MASCOT] = {
			Description = ""
				.."#Spawns a set of purchasable items/trinkets from a special pool each floor"
				.. "",
			Name = "마스코트 인형",
			QuoteDesc = "",
		},
	}
	local TrinketDesc = {
		[SDMod.Trinket.PLUSHY_SEAL] = {
			Description = ""
				.."#Orbits around Isaac and protects him from incoming projectiles # Spawns a random heart every floor # Dies after taking too much damage and awaits for the Isaac's touch"
				.. "",
			Name = "표범 인형",
			QuoteDesc = "",
		},
		[SDMod.Trinket.WISHING_STAR] = {
			Description = ""
				.."#Gives you 1 additional orbital star for each sleep related item in your inventory # Hold CTRL to fill up a charge bar and tap it afterwards to make a wish # Upon making a wish, each star will spawn a unique reward with vary rarity #{{Warning}} Removes itself after making a wish"
				.. "",
			Name = "소원의 별",
			QuoteDesc = "",
		},
		[SDMod.Trinket.TOY_CUBE_1] = {
			Description = ""
				.."#{{ArrowUp}} +1 Tears up # Replaces itself with Toy Cube N.2 after beating a floor without taking damage"
				.. "",
			Name = "장난감 큐브 N.1",
			QuoteDesc = "",
		},
		[SDMod.Trinket.TOY_CUBE_2] = {
			Description = ""
				.."#{{ArrowUp}} +2 Tears up # {{ArrowUp}} +2 Damage # Replaces itself with Toy Cube N.3 after beating a floor without taking damage"
				.. "",
			Name = "장난감 큐브 N.2",
			QuoteDesc = "",
		},
		[SDMod.Trinket.TOY_CUBE_3] = {
			Description = ""
				.."#{{ArrowUp}} +3 Tears up # {{ArrowUp}} +3 Damage # {{ArrowUp}} +3 Range # You can't count past 3 :("
				.. "",
			Name = "장난감 큐브 N.3",
			QuoteDesc = "",
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
	--[[ [SamaelMod.ITEMS.SAMAELS_FEATHER] = {
		Description = "아이템설명",
		Name = "아이템이름",
		QuoteDesc = "획득멘트",
	}, ]]
}
local PillDesc = {
	[PillEffect.PILLEFFECT_AMIRMIR] = {
		Description = "{{ArrowUp}} {{DamageSmall}}공격력 + 3.5#증가한 공격은 23초에 걸쳐 서서히 감소합니다.#{{Somno}} 그 방에서 캐릭터 및 적이 잠에 빠집니다.",
		Name = "Sedatives",
		QuoteDesc = "",
	},
}

local somnDesc = {
	["Sandplosion"] = {
		Name = "모래폭발",
		Description = "Sand Pouch의 범위가 캐릭터 주변으로 변경됩니다.#{{Somno}} 기면 상태 시간 {{BlinkYellowGreen}}증가{{CR}}#{{Battery}} Sand Pouch의 충전 속도 {{BlinkYellowRed}}감소{{CR}}",
		QuoteDesc = "범위 공격",
	},
	["Swiftstep"] = {
		Name = "재빠른 스텝",
		Description = "Sand Pouch 사용 시 사용한 방향으로 짧은 거리를 대시합니다. (대시 중 무적)#{{Somno}} 기면 상태 시간 {{BlinkYellowRed}}감소{{CR}}#{{Battery}} Sand Pouch의 충전 속도 {{BlinkYellowGreen}}증가{{CR}}",
		QuoteDesc = "적을 향해 돌진하자!",
	},
	["Pouchtoss"] = {
		Name = "주머니 던지기",
		Description = "Sand Pouch가 투척 공격으로 바뀝니다.#{{Somno}} 기면 상태 시간 {{BlinkYellowGreen}}소폭 증가{{CR}}#{{Battery}} Sand Pouch의 충전 속도 {{BlinkYellowRed}}소폭 감소{{CR}}",
		QuoteDesc = "휘우우우웅~ 펑!",
	},
	["Sparklingsand"] = {
		Name = "빛나는 모래",
		Description = "{{Somno}} 기면 상태의 적이 지속시간 동안 총합 캐릭터 x5의 피해를 받습니다.#{{Somno}} 기면 상태 시간 {{BlinkYellowGreen}}소폭 증가{{CR}}#{{Battery}} Sand Pouch의 충전 속도 유지",
		QuoteDesc = "졸음은 위험하다구!",
	},
	["Comacloud"] = {
		Name = "코마 구름",
		Description = "Sand Pouch 사용 시 적에게 피해를 주는 코마 구름을 추가로 소환합니다.#코마 구름에 있는 적은 기면 상태에서 벗어나지 못하며 멈추게 됩니다.#{{Somno}} 기면 상태 시간 {{BlinkYellowRed}}소폭 감소{{CR}}#Sand Pouch의 충전 속도 {{BlinkYellowRed}}소폭 감소{{CR}}",
		QuoteDesc = "더 오랫동안 잠들게",
	},
	["Sandy"] = {
		Name = "Sandy!",
		Description = "{{Somno}} 기면 상태 적 처치 시 적을 따라다니며 기면 상태에 걸리게 하는 자폭 모래 요정을 추가로 소환합니다.#{{Somno}} 기면 상태 시간 유지#{{Battery}} Sand Pouch의 충전 속도 {{BlinkYellowGreen}}소폭 증가{{CR}}",
		QuoteDesc = "수면 친구!",
	},
	["Fairytrail"] = {
		Name = "요정의 흔적",
		Description = "Sand Pouch의 공격 범위에 적에게 둔화 피해를 주는 장판을 설치합니다.#{{Somno}} 기면 상태 시간 유지#{{Battery}} Sand Pouch의 충전 속도 유지",
		QuoteDesc = "노란 모랫길",
	},
	["Oversomnia"] = {
		Name = "과수면증",
		Description = "{{Somno}} 기면 상태 중첩 가능 (최대 3)#!!! 중첩 당 추가 피해와 기면 상태 쿨타임 증가#{{Somno}} 기면 상태 시간 유지#{{Battery}} Sand Pouch의 충전 속도 {{BlinkYellowRed}}소폭 감소{{CR}}",
		QuoteDesc = "못 일어나겠어...",
	},
	["Shootingstar"] = {
		Name = "슈팅 스타",
		Description = "Sand Pouch 사용 시 별조각을 추가로 발사합니다.#{{Somno}} 기면 상태 시간 {{BlinkYellowRed}}감소{{CR}}#{{Battery}} Sand Pouch의 충전 속도 {{BlinkYellowGreen}}증가{{CR}}",
		QuoteDesc = "소원을 빌자!",
	},
	["Deepsleep"] = {
		Name = "깊은 잠",
		Description = "#{{Somno}} 기면 상태 시간 {{BlinkYellowGreen}}50% 증가{{CR}}#{{Battery}} Sand Pouch의 충전 속도 {{BlinkYellowGreen}}소폭 증가{{CR}}",
		QuoteDesc = "기면 시간 증가",
	},
	["Dreamwarrior"] = {
		Name = "꿈의 전사",
		Description = "{{Somno}} 기면 상태의 적에게 25% 추가 피해를 줍니다.#{{Somno}} 기면 상태 시간 유지#{{Battery}} Sand Pouch의 충전 속도 유지",
		QuoteDesc = "기면 피해 증가",
	},
	["Spindlespikes"] = {
		Name = "스핀들 가시",
		Description = "Sand Pouch를 사용한 위치에 모래 가시를 추가로 소환합니다.#{{Somno}} 기면 상태 시간 유지#{{Battery}} Sand Pouch의 충전 속도 유지",
		QuoteDesc = "손이 찔리지 않도록 조심해",
	},
	["Somnolepticcharge"] = {
		Name = "수면 충전",
		Description = "{{Somno}} 기면 상태의 적 명중 시 주머니를 충전시킵니다.#{{Somno}} 기면 상태 시간 {{BlinkYellowRed}}소폭 감소{{CR}}#{{Battery}} Sand Pouch의 충전 속도 {{BlinkYellowRed}}대폭 감소{{CR}}",
		QuoteDesc = "주머니의 기력을 모으자!",
	},
}
EID:addEntity(1000, SDMod.SOMNOSSENCE, 0, "somnossence", "somnossence description", "ko_kr")

EID:addEntity(6, SDMod.Slot.DADS_GRAMOPHONE, 0, "레코드 머신", "1{{Coin}} 소모#사용 시 음악을 바꾸어 그 방의 배열 정보를 바꿉니다.#이후 현재 방에서 주사위류({{Collectible105}}) 아이템 사용 시 이 방에서 재생 중인 음악의 배열을 따릅니다.", "ko_kr")
EID:addEntity(1000, SDMod.SHRINE_SOMNOLEPTIC, 0, "수면 석상", "!!! 일회용#1포인트를 소모하여 능력 슬롯 +1#활성화하지 않은 경우 2{{Bomb}}로 폭파 시 모래 게이지 25% 충전", "ko_kr")

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

SacredDreams:RemoveCallback(ModCallbacks.MC_POST_EFFECT_RENDER, SacredDreams.TDGUpgradesDesc, SDMod.SOMNOSSENCE)

local currlang = "en_us"
function SacredDreams:TDGUpgradesDesc_new(e)
	local s = e:GetSprite()
	local d = e:GetData()
	if d.w_eid_lang == EID:getLanguage() then return end
	d.w_eid_lang = EID:getLanguage()

	if d.w_eid_lang == "ko_kr" then
		if e.SubType == 0 then
			local ov = s:GetOverlayAnimation()
			if somnDesc[ov] then
				local entry = somnDesc[ov]
				d.EID_Description = {
					Name = entry.Name,
					Description = entry.Description,
				}
			end
		end
	else
		SacredDreams:TDGUpgradesDesc(e)
	end

end
SacredDreams:AddCallback(ModCallbacks.MC_POST_EFFECT_RENDER, SacredDreams.TDGUpgradesDesc_new, SDMod.SOMNOSSENCE)

local function FF_EIDKR_SSCondition(descObj)
	if EID:getLanguage() ~= "ko_kr" then return false end
	if EID.InsideItemReminder then return false end
	return
		descObj.ObjType == 1000
		and descObj.ObjVariant == SDMod.SOMNOSSENCE
		and EID.player
		and EID.player:GetPlayerType() == SDMod.PlayerType.PLAYER_GUARD
end

local function FF_EIDKR_SSDescCallback(descObj)
	local p = EID.player
	local d = p:GetData()
	local pos = d.SDGuardData.SelectedSlot
	local slot = d.SDGuardData.PouchInventory[d.SDGuardData.SelectedSlot + 1]
	if pos == 0 then
		EID:appendToDescription(descObj, "#"..StatusEffectDesc.SLOT_SEL)
	elseif slot then
		local g = SacredDreams:Guard()
		local target
		for k, v in pairs(somnDesc) do
			if g.ItemToSlot[k] then
				target = k
				break
			end
		end
		if target then
			EID:appendToDescription(descObj, "#"..StatusEffectDesc.SLOT_REPLACE)
			local entry = somnDesc[target]
			EID:appendToDescription(descObj, "#"..EID.Config["ItemNameColor"]..entry.Name)
			EID:appendToDescription(descObj, "#"..entry.Description)
		else
			EID:appendToDescription(descObj, "#"..StatusEffectDesc.SLOT_SEL)
		end
	end
	return descObj
end

EID:addDescriptionModifier("FF_EIDKR_GodmodeVanillaDescs", FF_EIDKR_SSCondition, FF_EIDKR_SSDescCallback)

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
		birthright = BirthrightDesc,
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
		cards = CardDesc,
		pills = PillDesc,
	}

end