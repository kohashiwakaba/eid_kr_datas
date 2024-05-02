
if SacredDreams then

	EID._currentMod = "Sacred Dreams"
	local mod = SacredDreams

	local Items = SDMod.Item
	local Trinkets = SDMod.Trinket
	local Cards = SDMod.Consumable
	
	local StatusEffectDesc = {
		SOMNO = "",
	}

	local BirthrightDesc = {
		[SDMod.PlayerType.PLAYER_GUARD] = {
			Name = "The Dreams Guard",
			Description = "Killing enemies with somnolence will spawn a sandplosion # When somnolence effect expires enemies will take additional 75% of the damage you dealt to them when the effect was active",
			QuoteDesc = "잘 자란 말을 하러 왔다",
		},
	}
	local CollectibleDesc = {
		[SDMod.Item.BTS] = {
			Description = ""
				.."#Spawns a book that summons sandy fairies. #Amount of fairies and their behavior depends on the character using this item"
				.. "",
			Name = "꿈 이야기",
			QuoteDesc = "",
		},
		[SDMod.Item.BON] = {
			Description = ""
				.."#Spawns a book that summons a random bunch of friendly nightmare enemies"
				.. "",
			Name = "그리모어 악몽",
			QuoteDesc = "",
		},
		[SDMod.Item.SAND_POUCH] = {
			Description = ""
				.."#{{Somno}} Applies Somnolence to enemies # Somnolence is a unique status effects that slows enemies and increases the damage they take # Enemies become immune to somnolence for some time after the effect expires # Can be enhanced by the Dream Guard's somnossences (Character exclusive) # Can't be recharged with batteries"
				.. "",
			Name = "모래 주머니",
			QuoteDesc = "",
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
				.."#Shakes above Isaac's head when shooting. # On third shake shoots out 2-3 star tears that cause splash damage on impact with floor # Star tears inherit Isaac's tear effects"
				.. "",
			Name = "낡은 딸랑이",
			QuoteDesc = "",
		},
		[SDMod.Item.GLASSOFMILK] = {
			Description = ""
				.."#{{ArrowUp}} +0.75 Tears up #{{ArrowDown}} -0.15 Shotspeed down # Isaac can shoot a special tear that will slow down enemies or bounce off of them"
				.. "",
			Name = "넘치는 우유",
			QuoteDesc = "",
		},
		[SDMod.Item.COZYPILLOW] = {
			Description = ""
				.."#Passive melee weapon that can be charged for a more powerful swings # Spawns feathers when hits enemies # Amount of feathers depends on charge # Press CTRL to turn off/on"
				.. "",
			Name = "편안한 배게",
			QuoteDesc = "",
		},
		[SDMod.Item.MOON_FLOWER] = {
			Description = ""
				.."#Secret rooms will now contain moon petal pickups that will fill up a special charge bar (max 6 charges) #Passively spawns spores around Isaac that will follow nearby enemies when above 0 charge. # Each petal charge above 6 will give Isaac +0.50 {{Tears}} (max +3.00) # Loses some charge when Isaac takes damage"
				.. "",
			Name = "월화",
			QuoteDesc = "",
		},
		[SDMod.Item.VINYL] = {
			Description = ""
				.."#Shops and treasure rooms will have a 50% chance to contain a slot-machine that changes the room's pool with a corresponding musical track"
				.. "",
			Name = "아빠의 턴테이블",
			QuoteDesc = "",
		},
		[SDMod.Item.PLUSHY_GUPPY] = {
			Description = ""
				.."#Follows Isaac # Will protect Isaac from incoming projectiles # Can attack enemies if they are too close # Dies after taking too much damage and awaits for the Isaac's touch"
				.. "",
			Name = "구피 인형",
			QuoteDesc = "",
		},
		[SDMod.Item.PLUSHY_PLUM] = {
			Description = ""
				.."#Orbits around Isaac # Will protect Isaac from incoming projectiles # Slams on the ground and deals damage when close to enemies # Dies after taking too much damage and awaits for the Isaac's touch"
				.. "",
			Name = "플럼 인형",
			QuoteDesc = "",
		},
		[SDMod.Item.PLUSHY_ZIPPER] = {
			Description = ""
				.."#Follows Isaac # Will start chasing enemies when they are too close then blows a balloon that bursts into large amount of tears #  Dies after taking too much damage and awaits for the Isaac's touch"
				.. "",
			Name = "악마 인형",
			QuoteDesc = "",
		},
		[SDMod.Item.DREAM_SNATCHER] = {
			Description = ""
				.."#Shoots a dagger that sticks in enemies and prevents them from running too far away from you # Upon use when the dagger is attached to the enemy: rips it out, deals damage and spawns a burst of stars"
				.. "",
			Name = "드림 스내쳐",
			QuoteDesc = "",
		},
		[SDMod.Item.LITTLE_SHEEP] = {
			Description = ""
				.."#Circles around enemies and shoots stars # These stars have a 20% change to apply Somnolence to the target"
				.. "",
			Name = "리틀 쉽",
			QuoteDesc = "",
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
				.."##{{Coin}} +15 #Enemies in the explosion's radius gets the Midas' Touch effect #{{Bomb}} If Isaac has no bombs, one can be placed at the cost of 5 {{Coin}} # This bomb is not affected by any bomb-changing items"
				.. "",
			Name = "미다스 폭탄",
			QuoteDesc = "",
		},
		[SDMod.Item.TINY_HORN] = {
			Description = ""
				.."#Shoots a homing tear that bounces off enemies"
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
				.."#LVL1: Orbital # LVL2: Shooting follower (Buzzsaws) # LVL3: Shooting follower (Homing rockets) # F*ck you."
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
		Description = "Changes your Sand Pouch attack to an AoE attack #{{Somno}} Makes somnolence longer #{{Battery}} Increases Sand Pouch's recharge time",
	},
	["Swiftstep"] = {
		Name = "재빠른 스텝",
		Description = "Changes your Sand Pouch attack to a dash that makes you invincible #{{Somno}} Makes Somnolence shorter #{{Battery}} Decreases Sand Pouch's recharge time",
	},
	["Pouchtoss"] = {
		Name = "주머니 던지기",
		Description = "Changes your Sand Pouch attack to a ranged attack #{{Somno}} Makes Somnolence slightly longer #{{Battery}} Slightly increases Sand Pouch's recharge tim",
	},
	["Sparklingsand"] = {
		Name = "빛나는 모래",
		Description = "Enemies with somnolence will take damage over time # Total damage dealt over effect's duration equals 5 times your damage #{{Somno}} Makes Somnolence slightly longer #{{Battery}} Does not affect Sand Pouch's recharge time",
	},
	["Comacloud"] = {
		Name = "코마 구름",
		Description = "Sand Pouch's attacks will spawn a Coma Cloud # This Cloud halts Somnolence's duration and stun time when collides with enemies #{{Somno}} Makes Somnolence slightly shorter #{{Battery}} Slightly increases Sand Pouch's recharge time",
	},
	["Sandy"] = {
		Name = "Sandy!",
		Description = "Killing enemies with Somnolence will spawn a fragile sandy familiar that attacks nearby enemies and applies Somnolence in a small radius when dies #{{Somno}} Does not affect Somnolence's duration #{{Battery}} Slightly decreases Sand Pouch's recharge time",
	},
	["Fairytrail"] = {
		Name = "요정의 흔적",
		Description = "Sand Pouch's attacks will leave a sand trail that slows down and damages ground enemies #{{Somno}} Does not affect Somnolence's duration #{{Battery}} Does not affect Sand Pouch's recharge time",
	},
	["Oversomnia"] = {
		Name = "과수면증",
		Description = "Applying Somnolence to enemies that are already affected by it will give them an Oversomnia stack (max. 3) # Each stack increases damage dealt and makes their somnolence immunity longer after the effect expires #{{Somno}} Does not affect Somnolence's duration #{{Battery}} Slightly increases Sand Pouch's recharge time",
	},
	["Shootingstar"] = {
		Name = "슈팅 스타",
		Description = "Sand Pouch's attacks will shoot stars! #{{Somno}} Makes Somnolence shorter #{{Battery}} Decreases Sand Pouch's recharge time",
	},
	["Deepsleep"] = {
		Name = "깊은 잠",
		Description = "#{{Somno}} Increases somnolence duration by 50% #{{Battery}} Slightly decreases Sand Pouch's recharge time",
	},
	["Dreamwarrior"] = {
		Name = "꿈의 전사",
		Description = "Increases damage dealt to the enemies with somnolence by 25% #{{Somno}} Does not affect Somnolence's duration #{{Battery}} Does not affect Sand Pouch's recharge time",
	},
	["Spindlespikes"] = {
		Name = "Spindle Spikes",
		Description = "Sand Pouch's attacks will spawn deadly spikes! #{{Somno}} Does not affect Somnolence's duration #{{Battery}} Does not affect Sand Pouch's recharge time",
	},
	["Somnolepticcharge"] = {
		Name = "Somnoleptic Charge",
		Description = "Killing and damaging enemies with somnolence will give you a small burst of charge to your Pouch #{{Somno}} Slightly decreases Somnolence's duration #{{Battery}} DRASTICALLY increases Sand Pouch's recharge time",
	},
}
EID:addEntity(1000, SDMod.SOMNOSSENCE, 0, "somnossence", "somnossence description", "ko_kr")

EID:addEntity(1000, SDMod.SHRINE_SOMNOLEPTIC, 0, "Somnoleptic Shrine", "1포인트를 소모하여 Adds +1 notch to your inventory at the cost of 1 point #2{{Bomb}}로 폭파 시 모래 게이지 25% 충전", "ko_kr")

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

	return {
		targetMod = "Sacred Dreams",
		birthright = BirthrightDesc,
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
		cards = CardDesc,
		pills = PillDesc,
	}

end