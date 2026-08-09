if not FiendFolio then return end

local versionRequ = "3.1.0"
local versionNext = "3.1.0"

if (FiendFolio and FiendFolio.REHEATED) or FiendFolio:CheckFiendFolioModVersion(versionRequ, true) then then
	table.insert(wakaba_krdesc.ERRORS, {
		err_mod = "Fiend Folio",
		current = FiendFolio.modVersionNumber,
		required = versionRequ,
	})
	return
end

local mod = FiendFolio

local CHAR = "-997.-1."
local ITEM = "5.100."
local TRINKET = "5.350."
local CARD = "5.300."
local PILL = "5.70."
local CURSE ="-998.-1."

EID._currentMod = "Fiend Folio"

---@type table<string, WakabaDescriptionEntry>
local entries = {
	--#region APPENDS
	--#region
	["FF_APPEND_IMMORAL_HEART"] = {
		_descType = "append",
		Description = [[
			{{ffImmoralHeart}} {{ColorOrange}}이모럴하트 : {{ColorGray}}피격 시 소지 중 {{ffImmoralHeart}}가 Fiend의 부하로 바뀌며;
			>>> {{ColorGray}}바뀐 부하는 방 클리어 시 다시 {{ffImmoralHeart}} 픽업으로 변환
		]],
	},
	["FF_APPEND_CURSED_PENNY"] = {
		_descType = "append",
		Description = [[
			{{ffCursedPenny}} {{ColorOrange}}저주페니 : {{ColorGray}}{{Coin}}을 얻거나 잃을 수 있음, 낮은 확률로 폭발
		]],
	},
	["FF_APPEND_COPPER_BOMB"] = {
		_descType = "append",
		Description = [[
			{{ffCopperBomb}} {{ColorOrange}}구리폭탄 : {{ColorGray}}폭탄이 불발하거나 범위가 큰 폭발을 일으킴
		]],
	},
	["FF_APPEND_SPICY_KEY"] = {
		_descType = "append",
		Description = [[
			{{ffSpicyKey}} {{ColorOrange}}매운열쇠 : {{ColorGray}}획득 시 체력 반칸의 피해
		]],
	},
	--#endregion
	--#region STATUS EFFECTS
	["FF_APPEND_BERSERK"] = {
		_descType = "append",
		Description = [[
			{{ffBerserk}} {{ColorOrange}}폭주 : {{ColorGray}}공격 목표를 수시로 바꾸고 추가 피해를 받으나 더 빠르게 행동
		]],
	},
	["FF_APPEND_BRUISE"] = {
		_descType = "append",
		Description = [[
			{{ffBruise}} {{ColorOrange}}명듦 : {{ColorGray}}해당 상태 중첩 수만큼 추가 피해
		]],
	},
	["FF_APPEND_DOOM"] = {
		_descType = "append",
		Description = [[
			{{ffDoom}} {{ColorOrange}}둠 : {{ColorGray}}명중 시마다 카운트가 감소
			{{Blank}} {{ColorGray}}카운트가 0이 될 때 추가 피해 + 상태 제거
		]],
	},
	["FF_APPEND_DROWSY"] = {
		_descType = "append",
		Description = [[
			{{ffSleeping}} {{ColorOrange}}나른함 : {{ColorGray}}서서히 둔화되며 잠듦
			{{Blank}} {{ColorGray}}잠든 적 명중 시 추가 피해 + 상태 제거
		]],
	},
	["FF_APPEND_HEMORRHAGE"] = {
		_descType = "append",
		Description = [[
			{{ffHemorrhage}} {{ColorOrange}}대출혈 : {{ColorGray}}주기적으로 피해를 받고 붉은 장판을 깔며 랜덤 방향으로 핏방울을 흩뿌림
		]],
	},
	["FF_APPEND_MARTYR"] = {
		_descType = "append",
		Description = [[
			{{ffMartyr}} {{ColorOrange}}순교 : {{ColorGray}}처치 시 오라와 함께 5초동안 행동불능
			{{Blank}} {{ColorGray}}오라 안에 있는 캐릭터는 {{DamageSmall}}/{{TearsSmall}} 증가 + 유도공격 + 50%의 확률로 피해 무시
		]],
	},
	["FF_APPEND_SEW"] = {
		_descType = "append",
		Description = [[
			{{ffSew}} {{ColorOrange}}귀속 : {{ColorGray}}피해를 받으면 다른 귀속된 적도 같이 피해
		]],
	},
	["FF_APPEND_MULTIEUCLIDEAN"] = {
		_descType = "append",
		Description = [[
			{{ffMultieuclidean}} {{ColorOrange}}기하 : {{ColorGray}}공격이 해당 적을 관통
			{{Blank}} {{ColorGray}}관통 시 공격이 2개로 복제 + 유도공격
		]],
	},
	["FF_APPEND_EXCOMMUNICATED"] = {
		_descType = "append",
		Description = [[
			{{ffBruise}} {{ColorOrange}}명듦 : {{ColorGray}}Excommunicated enemies are teleported away for a short time
			Upon teleporting back, they and nearby enemies take damage
		]],
	},
	["FF_APPEND_OVERLOADED"] = {
		_descType = "append",
		Description = [[
			{{ffBruise}} {{ColorOrange}}명듦 : {{ColorGray}}Overloaded enemies short-circuit and fire short-ranged lasers around themselves
			Enemies hit by the lasers have a chance to become overloaded
		]],
	},
	["FF_APPEND_MUGGED"] = {
		_descType = "append",
		Description = [[
			{{ffBruise}} {{ColorOrange}}명듦 : {{ColorGray}}Mugged enemies drop lil' pennies
		]],
	},
	["FF_APPEND_PACIFIED"] = {
		_descType = "append",
		Description = [[
			{{ffBruise}} {{ColorOrange}}명듦 : {{ColorGray}}Pacified enemies are unable to deal damage to Isaac
		]],
	},
	["FF_APPEND_NURSING"] = {
		_descType = "append",
		Description = [[
			{{ffBruise}} {{ColorOrange}}명듦 : {{ColorGray}}Nursing enemies heal Isaac when he would normally deal damage
		]],
	},
	["FF_APPEND_GLEAMING"] = {
		_descType = "append",
		Description = [[
			{{ffBruise}} {{ColorOrange}}명듦 : {{ColorGray}}Gleaming enemies have an aura that inflicts nearby enemies with other status effects
		]],
	},
	--#endregion
	--#region GOLEM INFOS
	--#endregion
	--#endregion

	--#region PLAYERS
	--#region MAIN PLAYERS
	[CHAR .. FiendFolio.PLAYER.FIEND] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "",
	}
	[CHAR .. FiendFolio.PLAYER.FIEND] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "",
	}
	[CHAR .. FiendFolio.PLAYER.FIEND] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "",
	}
	[CHAR .. FiendFolio.PLAYER.FIEND] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "",
	}
	[CHAR .. FiendFolio.PLAYER.FIEND] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "",
	}
	[CHAR .. FiendFolio.PLAYER.FIEND] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "",
	}
	[CHAR .. FiendFolio.PLAYER.FIEND] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "",
	}
	[CHAR .. FiendFolio.PLAYER.FIEND] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "",
	}
	--#endregion
	--#region CHALLENGE PLAYERS
	[CHAR .. FiendFolio.PLAYER.FIEND] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "",
	}
	[CHAR .. FiendFolio.PLAYER.FIEND] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "",
	}
	--#endregion
	--#region BONUS PLAYERS
	[CHAR .. FiendFolio.PLAYER.FIEND] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "",
	}
	[CHAR .. FiendFolio.PLAYER.FIEND] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "",
	}
	[CHAR .. FiendFolio.PLAYER.FIEND] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "",
	}
	[CHAR .. FiendFolio.PLAYER.FIEND] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "",
	}
	[CHAR .. FiendFolio.PLAYER.FIEND] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "",
	}
	[CHAR .. FiendFolio.PLAYER.FIEND] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "",
	}
	[CHAR .. FiendFolio.PLAYER.FIEND] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "",
	}
	[CHAR .. FiendFolio.PLAYER.FIEND] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "",
	}
	[CHAR .. FiendFolio.PLAYER.FIEND] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "",
	}
	[CHAR .. FiendFolio.PLAYER.FIEND] = {
		_descType = "player",
		Name = "",
		ReminderName = "",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "",
	}
	--#endregion
	--#endregion

	--#region COLLECTIBLES
	--#region HARVEST COLLECTIBLES
	--#endregion
	--#region REHEATED COLLECTIBLES
	--#endregion
	--#region RELOADED COLLECTIBLES
	--#endregion
	--#endregion

	--#region TRINKETS
	--#region HARVEST TRINKETS
	--#endregion
	--#region REHEATED TRINKETS
	--#endregion
	--#region RELOADED TRINKETS
	--#endregion
	--#region REHEATED ROCKS
	--#endregion
	--#region RELOADED ROCKS
	--#endregion
	--#endregion

	--#region CARDS
	[CARD..FiendFolio.ITEM.CARD.PLUS_3_FIREBALLS] = {
		_descType = "card",
		Name = "파이어볼 +3"
		QuoteDesc = '',
		Description = [[
			파이어볼 불꽃을 3마리 소환합니다.(최대 12)
			공격키를 두번 누르면 불꽃을 소모하여 공격하는 방향으로 파이어볼을 발사합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.REVERSE_3_FIREBALLS] = {
		_descType = "card",
		Name = "파이어볼? +3",
		QuoteDesc = '',
		Description = [[
			{{Collectible]] .. FiendFolio.ITEM.COLLECTIBLE.MALICE .. [[}} 캐릭터의 공격방향으로 벽에 여러번 부딪힐 때까지 돌진합니다.
			{{HalfBlackHeart}} 돌진 상태에서 적 처치 시 낮은 확률로 블랙하트를 드랍합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.IMPLOSION] = {
		_descType = "card",
		Name = "내부파열",
		QuoteDesc = '',
		Description = [[
			사용 시 3방향으로 초록색 Fiend의 파이어볼 불꽃을 즉시 발사합니다.
			파이어볼 폭파 시 Fiend의 부하를 소환합니다.
			Fiend의 부하는 방 클리어 시 소멸합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CALLING_CARD] = {
		_descType = "card",
		Name = "사신 호출 카드",
		QuoteDesc = '',
		Description = [[
			{{Charm}} 사용 시 아군 Psi Hunter 몬스터를 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.PLAGUE_OF_DECAY] = {
		_descType = "card",
		Name = "부패 역병",
		QuoteDesc = '',
		Description = [[
			{{RottenHeart}} 사용 시 썩은하트 +5
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GROTTO_BEAST] = {
		_descType = "card",
		Name = "어두운 곳의 짐승",
		QuoteDesc = '',
		Description = [[
			{{Charm}} 사용 시 Fiend Folio 출신의 아군 몬스터를 하나 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.DEFUSE] = {
		_descType = "card",
		Name = "해체",
		QuoteDesc = '',
		Description = [[
			{{Bomb}} 사용 시 트롤폭탄 및 폭탄이 박힌 돌을 해체하여 폭탄 픽업으로 바꾸며;
			폭발성 몬스터를 일반형으로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.POT_OF_GREED] = {
		_descType = "card",
		Name = "욕망의 항아리",
		QuoteDesc = '',
		Description = [[
			{{Card}} 카드를 2장 드랍합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.DARK_HOLE] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Collectible512}} Lets Isaac throw a Black Hole, which sucks in everything
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.EYE_OF_TRUTH] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Collectible665}} Grants Isaac Guppy's Eye for a room, revealing the contents of chests, sacks, shopkeepers, and fireplaces
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.DESTINY_BOARD] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Warning}} Isaac consumes a deadly cyanide pill
			{{Timer}} While active:
			↑ x1.5 Damage multiplier
			↑ x1.5 Fire rate multiplier
			↑ +0.05 Speed
			↑ +0.62 Range
			High chance of pills spawning on room clear
			{{Warning}} Kills Isaac after 60 seconds
			{{Pill}} Death can be prevented by taking a pill
		]],
	},


	[CARD..FiendFolio.ITEM.CARD.DOWNLOAD_FAILURE] = {
		_descType = "card",
		Name = "다운로드 실패",
		QuoteDesc = '',
		Description = [[
			사용 시 그 방에 오류가 생깁니다.
			{{Card]] .. FiendFolio.ITEM.CARD.DOWNLOAD_FAILURE .. [[}} 오류가 생긴 적은 미끄러집니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SMALL_CONTRABAND] = {
		_descType = "card",
		Name = "작은 밀매품",
		QuoteDesc = '',
		Description = [[
			!!! 사용 효과 없음
			!!! 소지하지 않은 상태에서는 특정 몬스터가 해당 카드를 훔칠 수 있습니다!
			해당 카드를 다음 스테이지에 있는 검은 모자의 거지에게 배달 시 특수 배열의 아이템을 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SKIP_CARD] = {
		_descType = "card",
		Name = "스킵 카드",
		QuoteDesc = '',
		Description = [[
			사용 시 모든 오브젝트 및 엔티티(적/아이템 등)을 지웁니다.
			스킵 카드로 방 클리어 시 액티브 아이템 게이지가 충전되지 않으며 방 클리어 보상이 소환되지 않습니다.
			{{BossRoom}} 보스방의 경우 아이템이 소환되지 않습니다.
			최종 보스의 경우 해당 페이즈를 건너뛰지만 마지막 페이즈에서의 사용 시 면역입니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SORRY] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Collectible422}} Brings Isaac back to the previous room and reverses all actions done in the room the item was used in
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CARDJITSU_SOCCER] = {
		_descType = "card",
		Name = "축구",
		QuoteDesc = '',
		Description = [[
			사용 시 그 방에서 굴릴 수 있는 축구공을 소환합니다.
			축구공은 접촉 시 적에게 속도에 비례한 피해를 줍니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CARDJITSU_FLOORING_UPGRADE] = {
		_descType = "card",
		Name = "바닥 업그레이드",
		QuoteDesc = '',
		Description = [[
			사용 시 그 방 전체에 랜덤 장판을 깝니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CARDJITSU_AC_3000] = {
		_descType = "card",
		--Name = '',
		QuoteDesc = '',
		Description = [[
			{{Freezing}} 그 방에서 적 처치 시 해당 적을 얼립니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.MISPRINTED_GISH] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			Summons a friendly Gish to land on an enemy and fire a tar shot before leaving
		]],
	},
   [CARD..FiendFolio.ITEM.CARD.SEAL_OF_ORICHALCOS] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			Creates a huge glyph on the floor for the room
			{{Collectible584}} Killing enemies in the glyph gives Isaac an orbital wisp familiar
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.FRIENDLY_FIRE] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Collectible]] ..
				FiendFolio.ITEM.COLLECTIBLE.FRIENDS_FIREBALL_FORMULA ..
					[[}} Grants Friend's Fireball Formula for a room
			{{Burning}} 5% chance to shoot out a purple tear that inflicts Burning on enemies
			Burned enemies burst into purple flame jets when killed
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.NEKO_NYAN_QUIZ_CARD] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Timer}} Transforms Isaac into Goby for 30 seconds
			Goby has Flight, and can spawn Blue Beetles that can shield you whenever you damage enemies
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.REDACTED_TRIANGLE] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			Mimics every active item in the room
			Grants temporary copies of every passive item in the room
			Temporary passive items are removed when moving to the next floor
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.DRACONIC_FERVOR] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			When used:
			{{Card}} Spawns 2 random cards
			{{Heart}} Heals 1 and a half red hearts
			{{Battery}} Charges Isaac's active by 2
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.TRIBUNAL_OF_GOOD_AND_EVIL] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Collectible]] .. FiendFolio.ITEM.COLLECTIBLE.EXECUTIONER ..[[}} Kills a random enemy in the room and marks another enemy to die in 3 seconds
			If targeting a boss, damages 20% of its health instead
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.DANCE_OF_USURPATION] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			Deals moderate damage to all enemies in a room
			Damage scales between floors
			Enemies killed by this effect drop a random pickup
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.HAUNTED_HOUSE] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Charm}} When used, all non-boss enemies killed in an active room spawn a temporary friendly copy
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.DIRE_BOND] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Warning}} Isaac takes 3 non-lethal damage
			{{HalfHeart}} At the end of the next 3 rooms, heals half a heart and grants a random card
			{{HalfSoulHeart}} If red hearts are full, grants half a soul heart instead
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ELF_SONG] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			Spawns 2 medium fairy flies and 2 blue flies
			{{Collectible248}} Blue spiders and flies deal double damage for a room
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.NEIGHBOURS_FROM_HELL] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Trinket}} Adds a random smelted trinket onto Isaac
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CREATIVE_AI] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			Upon use, your main active item is replaced with another random active item for the rest of the floor
			Swapping out your item while its effect is active will still have your active replaced
			Your active will be returned to you at the start of next floor
			!!! Does nothing if you do not have an active item
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CORRUPTION] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Battery}} For the rest of this floor, ALL active items that charge on room clear and are not in your pocket slot have a maximum charge of 1
			!!! These active items will be removed at the start of next floor
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.BLASPHEMY] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Collectible577}} Gain the effect of Damocles for the rest of the current floor
			{{HalfHeart}} Deals half a heart of damage to Isaac
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ABERRANT_LOVERS] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			Drops 2 Morbid Hearts but makes Isaac lose half his red health
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ABERRANT_DEATH] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			Respawns all enemies in the room but with a 50% chance for any to be friendly instead
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ABERRANT_TOWER] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			Spawns 3 reticles on the floor that Isaac can control
			After a short delay, 4 missiles will drop on each one
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ABERRANT_STARS] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			Fills any empty consumable and trinket slots that Isaac has
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ABERRANT_MOON] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			Reveals the secret and super secret rooms and opens any adjacent red rooms
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ABERRANT_SUN] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			Isaac will heal half a red heart every 15 seconds, to a total of 6 hearts
			Soul heart characters will get 2 total soul hearts instead
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.HAPPY_SQUIRREL] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{ArcadeRoom}} Teleports Isaac to a special Arcade room
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.THE_INVISIBLE_MOON] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{ffBerserk}} Inflicts all enemies in a room with Berserk for 15 seconds
			Effect persists between multiple rooms
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ENERGY_GRASS] = {
		_descType = "card",
		Name = "자연 에너지",
		QuoteDesc = '',
		Description = [[
			{{Poison}} 그 방의 모든 적을 4초간 중독시킵니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ENERGY_FIRE] = {
		_descType = "card",
		Name = "화염 에너지",
		QuoteDesc = '',
		Description = [[
			{{Burning}} 그 방의 모든 적에게 4초간 화상을 줍니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ENERGY_WATER] = {
		_descType = "card",
		Name = "물 에너지",
		QuoteDesc = '',
		Description = [[
			방 안의 적이 4초간 8방향으로 파란 눈물을 여러번 쏩니다.
			파란 눈물을 쏠 때마다 미세한 피해를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ENERGY_LIGHTNING] = {
		_descType = "card",
		Name = "전기 에너지",
		QuoteDesc = '',
		Description = [[
			{{ffOverloaded}} 그 방의 모든 적에게 4초간 과부하를 겁니다.
			{{ffOverloaded}} 과부하된 적은 짧은 레이저를 발사하며 미세한 피해를 받습니다.
			짧은 레이저에 피해를 받은 적에게 확률적으로 과부하를 겁니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ENERGY_FIGHTING] = {
		_descType = "card",
		Name = "힘 에너지",
		QuoteDesc = '',
		Description = [[
			{{ffBruise}} 방 안의 모든 적이 멍듦 상태가 됩니다.
			{{ffBruise}} 멍든 적은 해당 상태 중첩 수만큼 추가 피해를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ENERGY_PSYCHIC] = {
		_descType = "card",
		Name = "초능력 에너지",
		QuoteDesc = '',
		Description = [[
			{{Confusion}} 방 안의 모든 적이 4초간 혼란에 걸립니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ENERGY_COLORLESS] = {
		_descType = "card",
		Name = "무채 에너지",
		QuoteDesc = '',
		Description = [[
			{{ffMultieuclidean}} 방 안의 모든 적이 4초간 기하 상태에 걸립니다.
			{{ffMultieuclidean}} 공격이 기하 상태의 적을 통과할 수 있으며 2개로 복제되어 나갑니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ENERGY_DARKNESS] = {
		_descType = "card",
		Name = "어둠 에너지",
		QuoteDesc = '',
		Description = [[
			{{Fear}} 방 안의 모든 적이 4초간 공포에 걸립니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ENERGY_METAL] = {
		_descType = "card",
		Name = "강철 에너지",
		QuoteDesc = '',
		Description = [[
			{{ffHemorrhage}} 방 안의 모든 적이 4초간 대출혈에 걸립니다.
			{{ffHemorrhage}} 대출혈 상태의 적은 주기적으로 피해를 받고 붉은 장판을 깔며 랜덤 방향으로 핏방울을 흩뿌립니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ENERGY_FAIRY] = {
		_descType = "card",
		Name = "페어리 에너지",
		QuoteDesc = '',
		Description = [[
			{{Charm}} 방 안의 모든 적에게 4초간 매혹을 겁니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ENERGY_DRAGON] = {
		_descType = "card",
		Name = "드래곤 에너지",
		QuoteDesc = '',
		Description = [[
			사용 시 2종류의 랜덤 에너지 계열 카드 효과를 발동합니다
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.TRAINER_CARD] = {
		_descType = "card",
		Name = "트레이너 카드",
		QuoteDesc = '',
		Description = [[
			!!! 미구현
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.OJ_BUSINESS] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{ffLilPenny}} Inflicts all enemies in the room with Mugged
		]],
			StatusEffects = { FiendFolio.DescriptionStatuses.MUGGED },
	},
	[CARD..FiendFolio.ITEM.CARD.OJ_STRONGER] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Timer}} Receive for the room:
			↑ +1 Damage
			Gives double the damage if you've taken damage this room
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.OJ_PRESENT] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			Spawns 2 random 100% Orange Juice cards
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.OJ_SEAGULLS] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			Deals damage to a random enemy or player in the room
			{{Collectible486}} Players take fake damage instead
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.OJ_FIRE_SUPPORT] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Collectible47}} Fires 4 low damage rockets at random enemies
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.OJ_SERENE_HUSH] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			Pacifies all enemies in the room
			{{ffPacified}} Pacified enemies are unable to deal damage to Isaac
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.OJ_MIX_PHENOMENON] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Collectible]] .. tostring(FiendFolio.ITEM.COLLECTIBLE.HUNDRED_PERCENT_ORANGE_JUICE) ..
				[[}} If there are less than 3 Orange Juice tiles, spawns up to 3
			Also rerolls any Orange Juice tiles in the room
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.OJ_JONATHAN_RUSH] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			Teleports Isaac to an enemy and explodes while becoming invulnerable for a period
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.OJ_ENCHANTMENT] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			↑ +0.15 Speed for the room
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.OJ_HINDENPEATER] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Collectible108}} All damage is reduced to half a heart
			↑ All stats up for the room
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_D6] = {
		_descType = "card",
		Name = "유리 6면 조각",
		QuoteDesc = '',
		Description = [[
			{{Collectible105}} 사용 시 방 안의 모든 아이템을 다른 아이템으로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_D4] = {
		_descType = "card",
		Name = "유리 4면 조각",
		QuoteDesc = '',
		Description = [[
			{{Collectible284}} 사용 시 소지중인 모든 패시브 아이템을 모두 바꿉니다.
			스테이지 진행에 필요한 아이템은 바뀌지 않습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_D8] = {
		_descType = "card",
		Name = "유리 8면 조각",
		QuoteDesc = '',
		Description = [[
			{{Collectible406}} 사용 시 아래 능력치 배율을 랜덤으로 바꿉니다:
			{{IND}} {{SpeedSmall}} 이동속도
			{{IND}} {{TearsSmall}} 연사
			{{IND}} {{DamageSmall}} 공격력
			{{IND}} {{RangeSmall}} 사거리
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_D100] = {
		_descType = "card",
		Name = "유리 100면 조각",
		QuoteDesc = '',
		Description = [[
			{{Collectible283}} 사용 시 이하의 주사위 아이템을 모두 발동:
			{{Blank}} {{Collectible476}}{{Collectible284}}{{Collectible105}}{{Collectible437}}{{Collectible406}}{{Collectible285}}{{Collectible386}}{{Collectible166}}
			{{IND}} 방 안의 아이템, 픽업 아이템, 장애물, 소지중인 아이템, 능력치를 모두 바꿉니다.
			{{IND}} 그 방을 다시 시작하며, 방 클리어 시 이전과 다른 보상이 드랍됩니다.
			{{IND}} 방 안의 픽업 아이템 중 하나를 복사합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_D10] = {
		_descType = "card",
		Name = "유리 10면 조각",
		QuoteDesc = '',
		Description = [[
			{{Collectible285}} 사용 시 방 안의 모든 적을 한 단계 내립니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_D20] = {
		_descType = "card",
		Name = "유리 20면 조각",
		QuoteDesc = '',
		Description = [[
			{{Collectible166}} 사용 시 방 안의 모든 픽업 아이템을 다른 픽업 아이템으로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_D12] = {
		_descType = "card",
		Name = "유리 12면 조각",
		QuoteDesc = '',
		Description = [[
			{{Collectible386}} 사용 시 방 안의 모든 장애물을 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_SPINDOWN] = {
		_descType = "card",
		Name = "유리 스핀다운 조각",
		QuoteDesc = '',
		Description = [[
			{{Collectible723}} 사용 시 방 안의 모든 아이템을 코드 앞번호의 아이템으로 바꿉니다.
			!!! 해금하지 않은 아이템은 등장하지 않습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_AZURITE_SPINDOWN] = {
		_descType = "card",
		Name = "아주라이트 스핀다운 조각",
		QuoteDesc = '',
		Description = [[
			{{Collectible]] .. tostring(FiendFolio.ITEM.COLLECTIBLE.AZURITE_SPINDOWN) .. [[}} 사용 시 방 안의 모든 장신구를 코드 앞번호의 장신구로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_D2] = {
		_descType = "card",
		Name = "유리 2면 조각",
		QuoteDesc = '',
		Description = [[
			{{Collectible]] .. tostring(FiendFolio.ITEM.COLLECTIBLE.D2) .. [[}} 사용 시 주사위를 들며 공격방향으로 던집니다.
			착지한 주사위에 닿은 적, 픽업 아이템, 눈물이 같은 유형의 다른 항목으로 바뀝니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_D3] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Collectible]] ..
				tostring(FiendFolio.ITEM.COLLECTIBLE.D3) ..
					[[}} Activates the D3 effect for the room, spawning an orbital familiar that rerolls tears
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_D5] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Collectible]] ..
				tostring(FiendFolio.ITEM.COLLECTIBLE.D5) ..
					[[}} Activates the D5 effect for the room, spawning a dice that can be thrown around
			When it lands, it does an effect depending on the side
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.D10_SHARD] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Collectible285}} Activates the D10 and D12 effects, rerolling grids and devolving enemies in the room
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ETERNAL_SHARD] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Collectible609}} Activates the Eternal D6, D10, and D12 effects which rerolls all pedestals, enemies, and grids in the room
			There is a 50% chance to delete the targets instead
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.D8_SHARD] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Collectible284}} Activates the D4 and D8 effects, rerolling Isaac's stats and passive items
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GREEN_HOUSE] = {
		_descType = "card",
		Name = "녹색 모형집",
		QuoteDesc = '',
		Description = [[
			그 방의 모든 적 및 픽업을 보관합니다.
			보관된 적 및 픽업은 다음 방 진입 시 강제로 소환됩니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.BRICK_SEPERATOR] = {
		_descType = "card",
		Name = "브릭 분해기",
		QuoteDesc = '',
		Description = [[
			{{Collectible631}} 사용 시 방 안의 모든 적을 0.4배의 체력을 가진 적 2마리로 나누며;
			그 방에서 공격이 적을 관통합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.PUZZLE_PIECE] = {
		_descType = "card",
		Name = "퍼즐 조각",
		QuoteDesc = '',
		Description = [[
			운세 퍼즐을 1/3만큼 기록합니다.
			운세 퍼즐이 완성되면 해당 운세에 맞는 아이템을 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.COOL_PHOTO] = {
		_descType = "card",
		Name = "멋진 사진",
		QuoteDesc = '',
		Description = [[
			{{Coin}} 동전 1~2개를 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.BLANK_LETTER_TILE] = {
		_descType = "card",
		Name = "빈 키캡",
		QuoteDesc = '',
		Description = [[
			사용 후 키 입력 시 그 스테이지에서 입력한 키를 키캡에 작성합니다.
			작성된 키캡의 키를 누르고 있는 동안:
			>>> {{DamageSmall}} 공격력 +1
			>>> {{TearsSmall}} 연사 +1
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.HORSE_PUSHPOP] = {
		_descType = "card",
		Name = "말 푸시팝",
		QuoteDesc = '',
		Description = [[
			!!! China 전용
			{{BrokenHeart}} 사용 시 부서진하트 -1
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.TOP_HAT] = {
		_descType = "card",
		Name = "탑모자",
		QuoteDesc = '',
		Description = [[
			열린 상점 상자를 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GIFT_CARD] = {
		_descType = "card",
		Name = "선물 카드",
		QuoteDesc = '',
		Description = [[
			{{Collectible515}} 방 안의 모든 아이템을 Mystery Gift로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.STUD] = {
		_descType = "card",
		Name = "레고 뚜껑",
		QuoteDesc = '',
			Description =
			FiendFolio.DescriptionIcons.Stud .. [[ 레고 페니를 하나 소환합니다.
			{{Collectible486}} 레고 페니는 습득 시 1{{Coin}}을 획득하지만 캐릭터에게 가짜 피해를 줍니다.
			레고 페니에 접촉한 적에게 5의 피해를 줍니다.
			최대 6개까지 소지 가능
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CHRISTMAS_CRACKER] = {
		_descType = "card",
		Name = "크리스마스 캔디",
		QuoteDesc = '',
		Description = [[
			{{ffObject}} 캐릭터 주변에 작은 폭발을 일으키며 랜덤 오브젝트를 드랍합니다.
			캐릭터는 이 폭발에 피해를 입지 않습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.PINK_COW] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			One enemy in the next 4 rooms is Pacified for a long duration
			{{ffPacified}} Pacified enemies are unable to deal damage to Isaac
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.YELLOW_CAR] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			↑ +1 Speed
			Speed bonus goes down by 0.15 after clearing a room
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.LUCKY_DUCK] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Timer}} Receive for the room:
			↑ +7.77 Luck
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.COMICAL_ROUND_GLASSES] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Timer}} Receive for the room:
			↓ x0.8 Damage multiplier
			{{Collectible245}} Isaac shoots 2 tears at once
			↑ +2.5 Range
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.EGG_SACK] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			Spawns 3 blue spiders, 3 blue flies, 3 blue skuzzes, 3 blue beetles, and 3 blue baby spiders
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.TREASURE_DISC] = {
		_descType = "card",
		Name = "보믈방 체험판 디스크",
		QuoteDesc = '',
		Description = [[
			{{ItemPoolTreasure}} 1분간 3~5개의 보물방 배열 패시브 아이템의 효과를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SHOP_DISC] = {
		_descType = "card",
		Name = "상점 체험판 디스크",
		QuoteDesc = '',
		Description = [[
			{{ItemPoolShop}} 1분간 3~5개의 상점({{Trinket184}}:{{ItemPoolBabyShop}}) 배열 패시브 아이템의 효과를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.BOSS_DISC] = {
		_descType = "card",
		Name = "보스방 디스크",
		QuoteDesc = '',
		Description = [[
			{{ItemPoolBoss}} 1분간 3~5개의 보스방 배열 패시브 아이템의 효과를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SECRET_DISC] = {
		_descType = "card",
		Name = "비밀방 디스크",
		QuoteDesc = '',
		Description = [[
			{{ItemPoolSecret}} 1분간 3~5개의 비밀방 배열 패시브 아이템의 효과를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.DEVIL_DISC] = {
		_descType = "card",
		Name = "악마방 디스크",
		QuoteDesc = '',
		Description = [[
			{{ItemPoolDevil}} 1분간 3~5개의 악마방 배열 패시브 아이템의 효과를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ANGEL_DISC] = {
		_descType = "card",
		Name = "천사방 디스크",
		QuoteDesc = '',
		Description = [[
			{{ItemPoolAngel}} 1분간 3~5개의 천사방 배열 패시브 아이템의 효과를 받습니다.",
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.PLANETARIUM_DISC] = {
		_descType = "card",
		Name = '',
		QuoteDesc = "천체관 디스크",
		Description = [[
			{{ItemPoolPlanetarium}} 1분간 3~5개의 천체관 배열 패시브 아이템의 효과를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CHAOS_DISC] = {
		_descType = "card",
		Name = "혼돈의 디스크",
		QuoteDesc = '',
		Description = [[
			{{Collectible402}} 1분간 3~5개의 랜덤 배열 패시브 아이템의 효과를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.BROKEN_DISC] = {
		_descType = "card",
		Name = "망가진 디스크",
		QuoteDesc = '',
		Description = [[
			{{Collectible347}} 1분간 3~5개의 동일한 랜덤 패시브 아이템의 효과를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.TAINTED_TREASURE_DISC] = {
		_descType = "card",
		Name = "더럽혀진 보믈방 디스크",
		QuoteDesc = '',
		Description = [[
			{{ffDisc}} 1분간 3~5개의 더럽혀진 보물방 배열 패시브 아이템의 효과를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.MISPRINTED_JACK_OF_CLUBS] = {
		_descType = "card",
		Name = "클로버 J?",
		QuoteDesc = '',
		Description = [[
			{{GoldenBomb}} 황금 트롤폭탄을 소환합니다.
			{{Bomb}} 그 방의 모든 폭탄 픽업을 트롤폭탄으로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.MISPRINTED_TWO_OF_CLUBS] = {
		_descType = "card",
		Name = "클로버 2?",
		QuoteDesc = '',
		Description = [[
			{{Bomb}} 소지 중인 폭탄 x2
			!!! {{ffCopperBomb}} 소지 중인 모든 폭탄을 구리폭탄으로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.MISPRINTED_THREE_OF_DIAMONDS] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Trinket}} Spawns 3 penny trinkets
			Once one is taken, the others despawn
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.THREE_OF_DIAMONDS] = {
		_descType = "card",
		Name = "다이아 3",
		QuoteDesc = '',
		Description = [[
			{{Coin}} 랜덤 동전 픽업을 3개 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.THREE_OF_CLUBS] = {
		_descType = "card",
		Name = "클로버 3",
		QuoteDesc = '',
		Description = [[
			{{Bomb}} 랜덤 폭탄 픽업을 3개 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.THREE_OF_SPADES] = {
		_descType = "card",
		Name = "스페이드 3",
		QuoteDesc = '',
		Description = [[
			{{Key}} 랜덤 열쇠 픽업을 3개 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.THREE_OF_HEARTS] = {
		_descType = "card",
		Name = "하트 3",
		QuoteDesc = '',
		Description = [[
			{{Heart}} 랜덤 하트 픽업을 3개 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.JACK_OF_DIAMONDS] = {
		_descType = "card",
		Name = "다이아 J",
		QuoteDesc = '',
		Description = [[
			{{ffCursedPenny}} 저주받은 동전 2~4개를 소환합니다.
			{{ffCursedPenny}} 그 방의 모든 동전 픽업을 저주받은 동전으로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.JACK_OF_CLUBS] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{ffCopperBomb}} 구리폭탄 2~3개를 소환합니다.
			{{ffCopperBomb}} 그 방의 모든 폭탄 픽업을 구리폭탄으로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.JACK_OF_SPADES] = {
		_descType = "card",
		Name = "스페이드 J",
		QuoteDesc = '',
		Description = [[
			{{ffSpicyKey}} 매운열쇠 2~3개를 소환합니다.
			{{ffSpicyKey}} 그 방의 모든 열쇠 픽업을 매운열쇠로 바꿉니다
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.JACK_OF_HEARTS] = {
		_descType = "card",
		Name = "하트 J",
		QuoteDesc = '',
		Description = [[
			{{ffImmoralHeart}} 소지 중인 모든 소울하트/블랙하트를 이모럴하트로 바꿉니다.
			{{ffImmoralHeart}} 소지 중인 {{SoulHeart}}/{{BlackHeart}}가 없을 경우 이모럴하트 하나를 드랍합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.QUEEN_OF_DIAMONDS] = {
		_descType = "card",
		Name = "다이아 Q",
		QuoteDesc = '',
		Description = [[
			{{Coin}} 방 안의 모든 돌덩이/똥 오브젝트를 동전으로 바꿉니다.
			{{Timer}} 바뀐 동전은 5초 후 사라집니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.QUEEN_OF_CLUBS] = {
		_descType = "card",
		Name = "클로버 Q",
		QuoteDesc = '',
		Description = [[
			{{Collectible52}} 그 방에서 공격이 폭탄 발사 공격으로 변경됩니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.QUEEN_OF_SPADES] = {
		_descType = "card",
		Name = "스페이드 Q",
		QuoteDesc = '',
		Description = [[
			{{Key}} 열쇠를 1~10개 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.KING_OF_DIAMONDS] = {
		_descType = "card",
		Name = "다이아 K",
		QuoteDesc = '',
		Description = [[
			{{Collectible202}} 그 방의 적을 적을 멈추게 만들며 멈춘 적 처치시 {{Coin}}동전을 1~3개 드랍합니다.
			그 방의 돌덩이 오브젝트 25%를 금광으로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.KING_OF_CLUBS] = {
		_descType = "card",
		Name = "클로버 K",
		QuoteDesc = '',
		Description = [[
			{{GigaBomb}} 기가폭탄 픽업을 하나 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.KING_OF_SPADES] = {
		_descType = "card",
		Name = "스페이드 K",
		QuoteDesc = '',
		Description = [[
			{{Key}} 열쇠 +1
			{{Collectible623}} 그 방에서 눈물을 쏠 때마다 열쇠를 소모하여 Sharp Key의 열쇠로 바꿉니다.
			{{Key}} Sharp Key의 눈물이 무언가에 부딪히거나 떨어지면 열쇠를 드랍합니다.
			!!! 열쇠가 없을 경우 변환되지 않습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ACE_OF_WANDS] = {
		_descType = "card",
		Name = "완드 A",
		QuoteDesc = '',
		Description = [[
			{{Battery}} 방 안의 모든 적과 픽업을 배터리로 바꿉니다.
			!!! 바뀐 배터리는 2초 후 사라집니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.TWO_OF_WANDS] = {
		_descType = "card",
		Name = "완드 2",
		QuoteDesc = '',
		Description = [[
			{{Battery}} 소지 중인 액티브 아이템 충전량 x2 (초과 충전 가능)
			충전량이 없을 시 충전량 1칸을 채워줍니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.THREE_OF_WANDS] = {
		_descType = "card",
		Name = "완드 3",
		QuoteDesc = '',
		Description = [[
			{{Battery}} 배터리 픽업을 3개 소환합니다
			!!! 바뀐 배터리는 3초 후 사라집니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.KING_OF_WANDS] = {
		_descType = "card",
		Name = "완드 K",
		QuoteDesc = '',
		Description = [[
			{{Battery}} 방 안의 배터리 픽업을 강화시킵니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ACE_OF_PENTACLES] = {
		_descType = "card",
		Name = "펜타클 A",
		QuoteDesc = '',
		Description = [[
			{{Trinket}} 방 안의 모든 적과 픽업을 장신구로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.TWO_OF_PENTACLES] = {
		_descType = "card",
		Name = "펜타클 2",
		QuoteDesc = '',
		Description = [[
			{{Trinket}} 소지 중인 미흡수 장신구를 복제하여 소환합니다.
			소지 중인 장신구가 없을 시 랜덤 장신구를 드랍합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.THREE_OF_PENTACLES] = {
		_descType = "card",
		Name = "펜타클 3",
		QuoteDesc = '',
		Description = [[
			{{Trinket}} 랜덤 장신구(석기 장신구 포함)를 3개 소환합니다.
		]],
		Conditionals = {
			{
				ModifierText = "",
				Function = function (descObj)
					local data = Isaac.GetPersistentGameData()
					return data:Unlocked(Achievement.GOLDEN_TRINKET)
				end,
				Description = "#각 장신구는 50%의 확률로 황금 형태로 소환됩니다.",
			}
		},
	},
	[CARD..FiendFolio.ITEM.CARD.KING_OF_PENTACLES] = {
		_descType = "card",
		Name = "펜타클 K",
		QuoteDesc = '',
		Description = [[
			{{Trinket}} 그 방의 장신구 및 소지 중인 장신구를 황금 형태로 바꿉니다.
			!!! 흡수한 장신구는 무효과
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.REVERSE_KING_OF_PENTACLES] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Trinket}} Converts all trinkets in the room and held by Isaac into rock trinkets
			!!! Has no effect on gulped trinkets
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.MISPRINTED_KING_OF_PENTACLES] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Trinket}} Converts all trinkets in the room and held by Isaac into Blasphemous trinkets
			{{Damage}} Blasphemous trinkets grant +1 Damage if you hold or smelt them
			!!! Has no effect on gulped trinkets
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ACE_OF_SWORDS] = {
		_descType = "card",
		Name = "소드 A",
		QuoteDesc = '',
		Description = [[
			방 안의 모든 적과 픽업을 아군 일회성 패밀리어로 바꿉니다.
			(예시) 파리, 거미, 벼룩, dip, beetles, minisaacs, fragile bobbies, blue baby spiders, ladybirds, fairy flies, mini Level 0 Flies
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.TWO_OF_SWORDS] = {
		_descType = "card",
		Name = "소드 2",
		QuoteDesc = '',
		Description = [[
			{{Collectible357}} 그 방에서 소지중인 패밀리어를 복사합니다.
			사용 시 방 안의 모든 아군 dip 및 자폭 파리/거미/벼룩을 복제합니다.
		]],
		-- Doubles all blue flies, spiders, skuzzes, friendly dips, and beetles in the room
	},
	[CARD..FiendFolio.ITEM.CARD.THREE_OF_SWORDS] = {
		_descType = "card",
		Name = "소드 3",
		QuoteDesc = '',
		Description = [[
			아군 일회성 패밀리어를 3마리 소환합니다.
			(예시) 파리, 거미, 벼룩, dip, beetles, minisaacs, fragile bobbies, blue baby spiders, ladybirds, fairy flies, mini Level 0 Flies
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.KING_OF_SWORDS] = {
		_descType = "card",
		Name = "소드 K",
		QuoteDesc = '',
		Description = [[
			{{Collectible247}} 그 스테이지에서 패밀리어의 공격력을 2배로 증가시킵니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ACE_OF_CUPS] = {
		_descType = "card",
		Name = "컵 A",
		QuoteDesc = '',
		Description = [[
			{{Pill}} 방 안의 모든 적과 픽업을 알약으로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.TWO_OF_CUPS] = {
		_descType = "card",
		Name = "컵 2",
		QuoteDesc = '',
		Description = [[
			{{Pill}} 소지 중인 알약 및 방 안의 모든 알약을 복제합니다.
			복제할 알약이 없을 경우 랜덤 알약을 2개 드랍합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.THREE_OF_CUPS] = {
		_descType = "card",
		Name = "컵 3",
		QuoteDesc = '',
		Description = [[
			{{Pill}} 랜덤 알약을 3개 소환합니다.
			각 알약은 50%의 확률로 거대 형태로 소환됩니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.KING_OF_CUPS] = {
		_descType = "card",
		Name = "컵 K",
		QuoteDesc = '',
		Description = [[
			{{Pill}} 소지 중인 알약 및 방 안의 모든 알약을 거대 형태로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.MISPRINTED_JOKER] = {
		_descType = "card",
		Name = "조커?",
		QuoteDesc = '',
		Description = [[
			사용 시 방 안의 모든 아이템을 {{DevilRoom}}악마방/{{AngelRoom}}천사방 아이템으로 바꿉니다.
			!!! 낮은 확률로 아이템이 아닌 성스러운/악한 테마의 하트/상자 픽업으로 바뀝니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.THIRTEEN_OF_STARS] = {
		_descType = "card",
		Name = "스타 13",
		QuoteDesc = '',
		Description = [[
			{{Collectible721}} 오류 아이템을 하나 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.REVERSE_KING_OF_CLUBS] = {
		_descType = "card",
		Name = "클로버 K?",
		QuoteDesc = '',
		Description = [[
			!!! {{GigaBomb}} 사용 시 사망하며 캐릭터의 자리에 기가폭탄의 폭발을 일으킵니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.MISPRINTED_JUSTICEJACK] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{ffImmoralHeart}} Spawns an Immoral Heart
			{{ffCopperBomb}} Spawns a Copper Bomb
			{{ffSpicyKey}} Spawns a pair of Spicy Keys
			{{ffCursedPenny}} Spawns a Cursed Penny
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.RUNE_ANSUS] = {
		_descType = "card",
		Name = "안수즈?",
		QuoteDesc = '',
		Description = [[
			{{CurseLostSmall}} 그 스테이지에서 맵에 특수방 위치, 비밀방 위치, 스테이지 구조가 표시됩니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SOUL_OF_FIEND] = {
		_descType = "card",
		Name = "핀드의 영혼",
		QuoteDesc = '',
		Description = [[
			사용 시 Fiend의 부하를 5~8마리(일반형)와 0~2마리(블랙형) 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SOUL_OF_GOLEM] = {
		_descType = "card",
		Name = "골렘의 영혼",
		QuoteDesc = '',
		Description = [[
			{{Trinket}} 석기 장신구를 3개 드랍합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SOUL_OF_RANDOM] = {
		_descType = "card",
		Name = "미지의 영혼석",
		QuoteDesc = '',
		Description = [[
			사용 시 랜덤 영혼석 효과를 발동합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SOUL_OF_CRAIG] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Battery}} Overcharges Isaac's active item up to two full charges
			{{Collectible]] ..
				tostring(FiendFolio.ITEM.COLLECTIBLE.EXCELSIOR) ..
					[[}} Using your active item will shoot fireworks based on the amount of item charge
			{{Collectible584}} Using your active item activates Book of Virtues

		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SOUL_OF_INABA] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			Activates Migraine Mode, granting Isaac two Inaba satellites
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.STORAGE_BATTERY_0] = {
		_descType = "card",
		Name = "보조 배터리",
		QuoteDesc = '',
		Description = [[
			{{Battery}} 사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.
			충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다. (초과 충전 가능)
			!!! {{Card]] .. tostring(FiendFolio.ITEM.CARD.CORRODED_BATTERY_0) .. [[}} 스테이지 진입 시 부식되며 부식된 상태에서 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.STORAGE_BATTERY_1] = {
		_descType = "card",
		Name = "보조 배터리",
		QuoteDesc = '',
		Description = [[
			{{Battery}} 사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.
			충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다. (초과 충전 가능)
			!!! {{Card]] .. tostring(FiendFolio.ITEM.CARD.CORRODED_BATTERY_1) .. [[}} 스테이지 진입 시 부식되며 부식된 상태에서 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.STORAGE_BATTERY_2] = {
		_descType = "card",
		Name = "보조 배터리",
		QuoteDesc = '',
		Description = [[
			{{Battery}} 사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.
			충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다. (초과 충전 가능)
			!!! {{Card]] .. tostring(FiendFolio.ITEM.CARD.CORRODED_BATTERY_2) .. [[}} 스테이지 진입 시 부식되며 부식된 상태에서 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.STORAGE_BATTERY_3] = {
		_descType = "card",
		Name = "보조 배터리",
		QuoteDesc = '',
		Description = [[
			{{Battery}} 사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.
			충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다. (초과 충전 가능)
			!!! {{Card]] .. tostring(FiendFolio.ITEM.CARD.CORRODED_BATTERY_3) .. [[}} 스테이지 진입 시 부식되며 부식된 상태에서 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CORRODED_BATTERY_0] = {
		_descType = "card",
		Name = "부식된 배터리",
		QuoteDesc = '',
		Description = [[
			{{Battery}} 사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.
			충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다. (초과 충전 가능)
			!!! 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CORRODED_BATTERY_1] = {
		_descType = "card",
		Name = "부식된 배터리",
		QuoteDesc = '',
		Description = [[
			{{Battery}} 사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.
			충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다. (초과 충전 가능)
			!!! 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CORRODED_BATTERY_2] = {
		_descType = "card",
		Name = "부식된 배터리",
		QuoteDesc = '',
		Description = [[
			{{Battery}} 사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.
			충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다. (초과 충전 가능)
			!!! 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CORRODED_BATTERY_3] = {
		_descType = "card",
		Name = "부식된 배터리",
		QuoteDesc = '',
		Description = [[
			{{Battery}} 사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.
			충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다. (초과 충전 가능)
			!!! 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SOUL_OF_FRIEND] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			Grants Isaac a random gun with limited ammo
			Gun fires along with Isaac's tears
			Disappears after running out of ammo
		]],
	},
	[PILL..FiendFolio.ITEM.PILL.CYANIDE] = {
		_descType = "pill",
		Name = "나트륨",
		QuoteDesc = "모든 능럭치 증가, 1분 안에 다른 알약을 먹어야 한다!",
		Description = [[
			{{Timer}} 발동 중일 때 모든 능력치 증가:
			{{IND}} {{SpeedSmall}} 이동속도 +0.05
			{{IND}} {{TearsSmall}} 연사 배율 x1.3
			{{IND}} {{DamageSmall}} 공격력 배율 x1.5
			{{IND}} {{RangeSmall}} 사거리 +0.62
			방 클리어 시 알약이 등장할 확률이 대폭 증가합니다.
			!!! 다른 알약을 사용하지 않았을 경우 60초 후 캐릭터가 즉사합니다."
		]],
	},
	[PILL..FiendFolio.ITEM.PILL.MELATONIN] = {
		_descType = "pill",
		Name = "멜라토닌",
		QuoteDesc = "적이 서서히 잠듦",
		Description = [[
			{{ffSleeping}} 방 안의 적을 나른한 상태로 만듭니다.
		]],
		AppendEntries = {
			"FF_APPEND_DROWSY"
		},
	},
	[PILL..FiendFolio.ITEM.PILL.HOLY_SHIT] = {
		_descType = "pill",
		Name = "이런 젠장",
		QuoteDesc = "신성한 똥을 쌌다!",
		Description = [[
			신성한 똥을 쌉니다.
		]],
	},
	[PILL..FiendFolio.ITEM.PILL.HAEMORRHOIDS] = {
		_descType = "pill",
		Name = "치질",
		QuoteDesc = "빨간 똥을 쌌다!",
		Description = [[
			빨간 똥을 쌉니다.
		]],
	},
	[PILL..FiendFolio.ITEM.PILL.FISH_OIL] = {
		_descType = "pill",
		Name = "생선 기름",
		QuoteDesc = "눈물 크기 증가",
		Description = [[
			눈물크기가 커집니다.
		]],
	},
	[PILL..FiendFolio.ITEM.PILL.LEMON_JUICE] = {
		_descType = "pill",
		Name = "레몬 주스",
		QuoteDesc = "눈물 크기 감소",
		Description = [[
			눈물크기가 작아집니다.
		]],
	},
	[PILL..FiendFolio.ITEM.PILL.EPIDERMOLYSIS] = {
		_descType = "pill",
		Name = "표피분해",
		QuoteDesc = "피격 무적시간 감소",
		Description = [[
			↓ 그 방에서 피격 무적시간 감소
		]],
	},
	[PILL..FiendFolio.ITEM.PILL.CLAIRVOYANCE] = {
		_descType = "pill",
		Name = "투시",
		QuoteDesc = "저주 해제 + 지도 표시",
		Description = [[
			{{CurseCursedSmall}} Labyrinth 및 특수 시드를 제외한 현재 스테이지의 저주를 제거합니다.
			{{Collectible287}} Book of Secrets 추가 발동
		]],
	},
	[PILL..FiendFolio.ITEM.PILL.SPIDER_UNBOXING] = {
		_descType = "pill",
		Name = "거미 대개봉",
		QuoteDesc = "",
		Description = [[
			아군 거미 2마리와 미니 거미 10마리를 소환합니다."
		]],
	},
	[PILL..FiendFolio.ITEM.PILL.MORNING_AFTER_PILL] = {
		_descType = "pill",
		Name = '',
		QuoteDesc = '',
		Description = [[
			Spawns 1 Fragile Bobby
			{{Collectible8}} Fragile bobbies are similar to Brother Bobby but can die
		]],
	},
	[PILL..FiendFolio.ITEM.PILL.BRIMSTONE] = {
		_descType = "pill",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Collectible118}} Gives you Brimstone forever!!!! XD"
		]],
	},
	[PILL..FiendFolio.ITEM.PILL.SERTRALINE] = {
		_descType = "pill",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Collectible]] .. FiendFolio.ITEM.COLLECTIBLE.SERTRALINE .. [[}} Destroys all enemy tears and briefly prevents new ones from spawning"
		]],
	},
	--#endregion

	--#region PILLS
	--#endregion

	--#region ENTITIES
	--#region SLOTS
	--#endregion
	--#region GOLEM
	--#endregion
	--#endregion

	--#region CURSES
	--#endregion
}

-- 중복 엔트리
entries[CARD..FiendFolio.ITEM.CARD.STUD_2] = entries[CARD..FiendFolio.ITEM.CARD.STUD]
entries[CARD..FiendFolio.ITEM.CARD.STUD_3] = entries[CARD..FiendFolio.ITEM.CARD.STUD]
entries[CARD..FiendFolio.ITEM.CARD.STUD_4] = entries[CARD..FiendFolio.ITEM.CARD.STUD]
entries[CARD..FiendFolio.ITEM.CARD.STUD_5] = entries[CARD..FiendFolio.ITEM.CARD.STUD]
entries[CARD..FiendFolio.ITEM.CARD.STUD_6] = entries[CARD..FiendFolio.ITEM.CARD.STUD]

local diceTable = {
  [881] = {"881", "12번", "{{Collectible386}} 스테이지 안의 모든 장애물 변경"},
  [882] = {"882", "12번", "{{Collectible386}} 스테이지 안의 모든 장애물 변경"}
}
EID:updateDescriptionsViaTable(diceTable, EID.descriptions["ko_kr"].dice)

return entries