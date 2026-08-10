if not FiendFolio then return end

local versionRequ = "3.1.0"
local versionNext = "3.1.0"

if (FiendFolio and FiendFolio.REHEATED) or FiendFolio:CheckFiendFolioModVersion(versionRequ, true) then
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
		Name = "핀드",
		ReminderName = "Fiend",
		Short = [[
			{{ffImmoralHeart}} 최대 체력 = 이모럴하트의 보정을 받습니다.
		]],
		Description = [[
			핀드는 오래 전 The Devil's Harvest 모드와 웃는 악마 이모지에서 유래하였습니다.
			{{ffImmoralHeart}} 최대 체력 = 이모럴하트의 보정을 받습니다.
			{{Heart}} 빨간하트 등장 시 확률적으로 {{ffImmoralHeart}}이모럴하트나 {{BlackHeart}}블랙하트로 바뀝니다.
			{{ffImmoralHeart}} 패널티 피격 시 가장 오른쪽과 붙어있는 모든 같은 종류의 체력이 제거되며 핀드의 부하로 바뀝니다.
			핀드의 부하는 적을 따라 공격하며 초당 캐릭터의 {{DamageSmall}}/{{TearsSmall}} 비례의 피해를 줍니다.
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.PYROMANCY..[[}} 고유 능력 : 방화술사
			{{Blank}} (파이어볼이 자동 생성되지 않으며 50 + (스테이지 수 * 10)의 피해를 줄 때마다 생성됨)
		]],
		Birthright = [[
			파이어볼의 유도 성능 강화
			폭파 시 적 처치 여부와 관계없이 33%의 확률로 Fiend의 부하를 추가로 소환합니다. (방 클리어 시 소멸)
		]],
		BirthrightQuote = "악동 파이어볼",
	},
	[CHAR .. FiendFolio.PLAYER.BIEND] = {
		_descType = "player",
		Name = "핀드-알트",
		ReminderName = "Tainted Fiend",
		Short = [[
			{{BlackHeart}} 최대 체력 = 블랙하트의 보정을 받습니다.
		]],
		Description = [[
			The Bastard: 핀드의 지나친 타락은 그의 몸은 녹여버리고 말았습니다.
			{{ffImmoralHeart}} 최대 체력 = 블랙하트의 보정을 받습니다. (체력 상한 6)
			{{BlackHeart}} 하트 등장 시 확률적으로 블랙하트로 바뀝니다.
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.MALICE..[[}} 고유 능력 : 악의
			악의 사용 시 소지 중인 {{BlackHeart}}의 수에 비례하여 부하로 분해됩니다. (최소 2, 재사용 시 합체)
			분해된 부하는 캐릭터와 같은 공격을 하며 피격 시 사라집니다.
			!!! {{ColorRed}}모든 부하가 사라지면 체력에 관계없이 사망합니다.
		]],
		Birthright = [[
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.MALICE..[[}} Malice로 적 처치 시 블랙하트를 드랍할 확률이 증가합니다.
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.MALICE..[[}} Malice로 폼 전환 시마다 Fiend의 부하가 각각 랜덤 모자를 쓰며 모자에 따라 {{DamageSmall}}/{{TearsSmall}}/{{LuckSmall}}/{{TearsizeSmall}}이 달라집니다.
		]],
		BirthrightQuote = "악의 회복 + 개성 증가",
	},
	[CHAR .. FiendFolio.PLAYER.GOLEM] = {
		_descType = "player",
		Name = "골렘",
		ReminderName = "Golem",
		Short = [[
		]],
		Description = [[
			골렘은 오래 전 The Devil's Harvest 모드와 색돌에서 유래하였습니다.
			{{Trinket}} 장신구 등장 시 확률적으로 석기 장신구나 룬으로 바뀝니다.
			{{Collectible139}} 장신구를 처음부터 2개를 동시에 들고 다닐 수 있습니다.
			{{Trinket}} 비밀방 진입 및 보스방 클리어 시 석기 장신구를 추가로 드랍합니다.
			주요 특수방에서 서브웨이라는 특수방으로 이동할 수 있으며 서브웨이에서는 각 특수방별 숏컷 및 여러 보조 동료가 있습니다.
		]],
		Birthright = [[
			{{LuckSmall}} 행운 +2
			색돌 파괴 시 소울하트 대신 석기 장신구를 드랍합니다.
		]],
		BirthrightQuote = "단단해진 색돌 + 행운 증가",
	},
	[CHAR .. FiendFolio.PLAYER.BOLEM] = {
		_descType = "player",
		Name = "골렘-알트",
		ReminderName = "Tainted Golem",
		Short = [[
			{{SoulHeart}} 최대 체력 = 소울하트의 보정을 받습니다.
		]],
		Description = [[
			The Artisan: 
			{{SoulHeart}} 최대 체력 = 소울하트의 보정을 받습니다.
			{{Collectible139}} 장신구를 처음부터 2개를 동시에 들고 다닐 수 있습니다.
			{{Trinket}} 비밀방 진입 시 석기 장신구를 추가로 드랍합니다.
			{{Collectible}} {{TreasureRoom}}/{{BossRoom}} 아이템 등장 시 석기 장신구로 바뀝니다.
			주요 특수방에서 서브웨이라는 특수방으로 이동할 수 있으며 서브웨이에서는 각 특수방별 숏컷 및 여러 보조 동료가 있습니다.
			!!! 패널티 피격 시 확률적으로 소지 중인 장신구가 강제로 버려지거나 파괴됩니다.
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.OVERCLOCK..[[}} 고유 능력 : 오버클럭
		]],
		Birthright = [[
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.OVERCLOCK..[[}} Overclock 사용 시 그 방에서 근접 공격을 추가로 합니다.
			근접 공격으로 장애물을 부술 수 있으며 이 공격으로 부순 장애물은 확률적으로 석기 장신구를 드랍합니다.
		]],
		BirthrightQuote = "되찾아라",
	},
	[CHAR .. FiendFolio.PLAYER.FRIEND] = {
		_descType = "player",
		Name = "프렌드",
		ReminderName = "Friend",
		Short = [[
		]],
		Description = [[
			{{Heart}} 최대 6칸의 체력을 가질 수 있습니다.
			{{Heart}} 눈물 대신 탄환을 발사하며 탄환의 수량은 현재 소지 중인 체력에 비례합니다.
			탄환 발사에 사용된 하트 종류에 따라 추가 효과를 발동합니다.
			{{Blank}} (탄환 발사는 실제 체력을 소모하지 않음)
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.HOT_SHOT..[[}} 고유 능력 : 핫 샷
		]],
		Birthright = [[
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.HOT_SHOT..[[}} Hot Shot의 불덩이가 3발 명중해야 소멸되며 장애물에 닿아도 폭발하지 않습니다.
			Hot Shot의 폭발에 면역
		]],
		BirthrightQuote = "방화 마스터",
	},
	[CHAR .. FiendFolio.PLAYER.BRIEND] = {
		_descType = "player",
		Name = "프렌드-알트",
		ReminderName = "Tainted Friend",
		Short = [[
		]],
		Description = [[
			{{Heart}} 눈물 대신 탄환을 발사하며 탄환의 수량은 현재 소지 중인 체력에 비례합니다.
			총을 2자루 사용하며 각 총은 체력과 아이템을 별개로 가집니다.
			{{Heart}} 각 총 당 최대 6칸의 체력을 가질 수 있습니다.
			아이템 획득 시 어느 총에 할당되는지 표시되며 {{ColorOrange}}할당시킬 총은 임의로 변경할 수 없습니다.{{CR}} (아이템 획득 시마다 변경)
			클리어하지 않은 방에서 총을 든 전용 몬스터가 추가로 등장합니다.
		]],
		Birthright = [[
			{{ffBerserk}} 총을 든 몬스터가 폭주 상태에 빠지며 캐릭터가 아닌 다른 적을 공격합니다.
			총을 들지 않은 몬스터 처치 시 상태 해제
		]],
		BirthrightQuote = "불안한 휴전",
	},
	[CHAR .. FiendFolio.PLAYER.INABA] = {
		_descType = "player",
		Name = "이나바",
		ReminderName = "Inaba",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "머리 아파!",
	},
	[CHAR .. FiendFolio.PLAYER.BINABA] = {
		_descType = "player",
		Name = "이나바-알트",
		ReminderName = "Tainted Inaba",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "그림자 눈빛",
	},
	--#endregion
	--#region CHALLENGE PLAYERS
	[CHAR .. FiendFolio.PLAYER.SLIPPY] = {
		_descType = "player",
		Name = "슬리피",
		ReminderName = "Slippy",
		Short = [[
		]],
		Description = [[
			슬리피는 Nuclear Throne의 히든 캐릭터로 멈추지 못합니다.
			공격이 3발로 나갑니다.
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.FROG_HEAD..[[}} 고유 능력 : 황금 개구리 머리
		]],
		Birthright = [[
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.FROG_HEAD..[[}} Golden Frog Head의 방귀의 크기에 따른 독가스를 추가로 남깁니다.
		]],
		BirthrightQuote = "더욱 지독해진 냄새",
	},
	[CHAR .. FiendFolio.PLAYER.CHINA] = {
		_descType = "player",
		Name = "차이나",
		ReminderName = "China",
		Short = [[
		]],
		Description = [[
			차이나는 핀드의 여자친구이지만 몸이 몹시나 허약합니다.
			{{BrokenHeart}} 체력이 없으며 피격, 장애물 충돌, 혹은 구덩이에 빠질 때 부서진하트가 추가됩니다.
			{{BrokenHeart}} 부서진하트가 12개가 되면 사망합니다.
			{{Card]]..FiendFolio.ITEM.CARD.HORSE_PUSHPOP..[[}} 방 클리어 시 15%의 확률로 Push Pop을 추가로 드랍합니다.
			모든 체력 거래는 무료이나 단 하나만 획득할 수 있습니다.
		]],
		Birthright = [[
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.HORSE_PASTE..[[}} 카드/알약 슬롯에 Horse Paste 아이템이 배정됩니다.
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.HORSE_PASTE..[[}} 사용 시 {{BrokenHeart}}부서진하트 -1
		]],
		BirthrightQuote = "초강력 접착제",
	},
	[CHAR .. FiendFolio.PLAYER.CRAIG] = {
		_descType = "player",
		Name = "크레이그",
		ReminderName = "Craig",
		Short = [[
		]],
		Description = [[
			{{Collectible68}} 사거리가 짧은 레이저를 발사합니다.
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.CRAIGS_BATTERY..[[}} 고유 능력 : 크레이그의 배터리
		]],
		Birthright = [[
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.CRAIGS_BATTERY..[[}} 적이 있는 방에서 랜턴 등장 확률 증가
		]],
		BirthrightQuote = "The harvest is plentiful",
	},
	[CHAR .. FiendFolio.PLAYER.CLASSIC_FIEND] = {
		_descType = "player",
		Name = "핀드-클래식",
		ReminderName = "Classic Fiend",
		Short = [[
			{{BlackHeart}} 최대 체력 = 블랙하트의 보정을 받습니다.
		]],
		Description = [[
			{{BlackHeart}} 최대 체력 = 블랙하트의 보정을 받습니다.
			{{BlackHeart}} 패널티 피격 시 가장 오른쪽과 붙어있는 모든 같은 종류의 체력이 제거되며 핀드의 부하로 바뀝니다.
			핀드의 부하는 적을 따라 공격하며 초당 캐릭터의 {{DamageSmall}}/{{TearsSmall}} 비례의 피해를 줍니다.
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.DEAL_OF_THE_DEMONS..[[}} 고유 능력 : 악마의 거래
		]],
		Birthright = [[
			피격 시 부하 +1
		]],
		BirthrightQuote = "셰퍼드의 희생",
	},
	[CHAR .. FiendFolio.PLAYER.IMAGE] = {
		_descType = "player",
		Name = "이미지",
		ReminderName = "Image",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "Sensory overload",
	},
	--#endregion
	--#region JOKE PLAYERS
	[CHAR .. FiendFolio.PLAYER.SKELETAL_FIEND] = {
		_descType = "player",
		Name = "핀드-스켈레톤",
		ReminderName = "Skeletal Fiend",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "Hurtful taunts",
	},
	[CHAR .. FiendFolio.PLAYER.FEND] = {
		_descType = "player",
		Name = "펜드",
		ReminderName = "Fend",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "리비도 증가",
	},
	[CHAR .. FiendFolio.PLAYER.FROND] = {
		_descType = "player",
		Name = "프론드",
		ReminderName = "Frond",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "Acid reflux",
	},
	[CHAR .. FiendFolio.PLAYER.FIENT] = {
		_descType = "player",
		Name = "핀트",
		ReminderName = "Fient",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "Reefer madness",
	},
	[CHAR .. FiendFolio.PLAYER.MI] = {
		_descType = "player",
		Name = "Mi",
		ReminderName = "Mi",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "Ultimate chimerism!",
	},
	[CHAR .. FiendFolio.PLAYER.FREEZERJR] = {
		_descType = "player",
		Name = "프리저 Jr.",
		ReminderName = "Freezer Jr.",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "메타 포텐셜",
	},
	[CHAR .. FiendFolio.PLAYER.PEAT] = {
		_descType = "player",
		Name = "피트",
		ReminderName = "Peat",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
		]],
		BirthrightQuote = "The horse is here",
	},
	--#endregion
	--#endregion

	--#region COLLECTIBLES
	--#region REHEATED COLLECTIBLES
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PYROMANCY] = {
		_descType = "collectible",
		Name = "방화술사",
		QuoteDesc = "더블탭 파이어볼",
		Description = [[
			주기적으로 캐릭터의 주변을 도는 Fiend의 파이어볼이 최대 3마리까지 생성됩니다.
			공격키를 두번 누르면 파이어볼을 발사합니다.
			발사한 파이어볼은 지나간 자리에 작은 불을 남기며 무언가에 부딪힐 시 폭발합니다
		]],
		AbyssTests = {
			"Inflicts Burn"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.FIEND_FOLIO] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "악마의 친구들 소환",
		Description = [[
			사용 시 그 방에서 Fiend Folio 출신 아군 보스를 소환합니다.
			소환된 아군 보스는 일부 패턴 사용 후 떠납니다.
		]],
		Virtues = {
			"Spawns rare " .. mod.DescriptionIconsCards.GrottoBeast .. "Grotto Beast charmed monster when destroyed"
		},
		CarBattery = {"소환합니다", "2마리{{CR}} 소환합니다"},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.D2] = {
		_descType = "collectible",
		Name = "2면 주사위",
		QuoteDesc = "던질 수 있는 주사위",
		Description = [[
			사용 시 주사위를 들며 공격방향으로 던집니다.
			착지한 주사위에 닿은 적, 픽업 아이템, 눈물이 같은 유형의 다른 항목으로 바뀝니다.
		]],
		Tests = {
			"Throws a spinning purple coin on the floor temporarily",
			"Any pickups, enemies and tears that touch it will be rerolled"
		},
		CarBattery = {"주사위", "주사위 2개"},
		AbyssTests = {
			"20% chance to devolve enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.STORE_WHISTLE] = {
		_descType = "collectible",
		Name = "상점 호루라기",
		QuoteDesc = "이동식 상점",
		Description = [[
			사용 시 미니 상점 상자를 소환합니다.
			미니 상점은 열 때 {{Key}}열쇠를 하나 소모하며 열 때 1~3개의 상점 품목을 판매합니다.
		]],
		CarBattery = {"소환합니다.", "2개 소환합니다."},
		AbyssTests = {
			"10% chance to drop a penny on kill"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DICE_BAG] = {
		_descType = "collectible",
		Name = "주사위 가방",
		QuoteDesc = "주사위가 한가득",
		Description = [[
			방 8개 클리어 시 유리 주사위 조각을 드랍합니다.
			유리 주사위 조각은 각 주사위를 일회성으로 사용할 수 있습니다.
		]],
		BFFS = {8, 4},
		AbyssTests = {
			"20% chance to devolve enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.LIL_FIEND] = {
		_descType = "collectible",
		Name = "리틀 핀드",
		QuoteDesc = "너만의 악마",
		Description = [[
			대각선으로 이동하며 적 및 탄환과 접촉 시 일정 확률로 Fiend의 부하를 소환합니다.
			Lil Fiend로 소환된 Fiend의 부하는 방 클리어 시 사라지며 블랙하트를 드랍하지 않습니다.
		]],
		BFFS = "접촉 판정 크기 및 부하 소환 확률 증가",
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BABY_CRATER] = {
		_descType = "collectible",
		Name = "크레이터 아기",
		QuoteDesc = "소용돌이 친구",
		Description = [[
			{{Chargeable}} 공격하는 동안 공격력 3.5의 크레이터 주변을 도는 눈물을 최대 8개까지 모읍니다.
			공격키를 떼면 모은 눈물을 발사합니다.
		]],
		BFFS = { 3.5, 7 },
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.MAMA_SPOOTER] = {
		_descType = "collectible",
		Name = "미스 스푸터",
		QuoteDesc = "추격 터렛",
		Description = [[
			적을 추적하며 주기적으로 적을 향해 공격력 3.5의 눈물을 발사합니다.
		]],
		BFFS = { 3.5, 7 },
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.RANDY_THE_SNAIL] = {
		_descType = "collectible",
		Name = "달팽이 랜디",
		QuoteDesc = "도탄 친구",
		Description = [[
			방 안을 느리게 돌아다니며 캐릭터 및 캐릭터의 눈물과 접촉 시 껍질에 숨으면서 굴러갑니다.
			굴러가는 도중 캐릭터/눈물 및 적과 계속 접촉하여 연속적으로 굴릴 수 있습니다.
		]],
		Tests = {
			"Snail familiar that retracts into its shell when hit by a projectile",
			"Randy can be bounced around the room through repeated projectile collisions",
		},
		BFFS = "접촉 판정 크기 및 피해량 증가",
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CORN_KERNEL] = {
		_descType = "collectible",
		Name = "옥수수 알갱이",
		QuoteDesc = "넌 내 옥수수야!",
		Description = [[
			획득할 때마다 성장합니다.
			1/2단계: 캐릭터의 주위를 돌며 적의 탄환을 막아줍니다.
			2/4단계: 공격하는 방향으로 공격력 3.5의 {{ColorOrange}}폭발성{{CR}} 눈물을 발사합니다.
			3/4단계: 방 안을 돌아다니며 주기적으로 랜덤 위치로 순간이동합니다.
			4단계: 적을 따라다니며 접촉한 적에게 3.5의 피해를 줍니다.
		]],
		Tests = {
			"Lv1: Wavy orbital",
			"Lv2: Orbital that shoots weak explosions",
			"Lv3: Familiar that teleports and chases enemies",
			"Lv4: Familiar that teleports and shoots explosive corn"
		},
		BFFS = "피해량 2배",
		AbyssTests = {
			"Blocks enemy shots",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GMO_CORN] = {
		_descType = "collectible",
		Name = "유전자 변형 옥수수",
		QuoteDesc = "악마의 채소",
		Description = [[
			↑ {{Heart}}최대 체력 +1
			↑ {{DamageSmall}}공격력 +1
			{{Pill}} 획득 시 강제로 랜덤 알약을 7개({{Collectible252}}:10개) 사용합니다.
		]],
		Tests = {
			"{{Warning}} Isaac is immobilized and forced to consume 7 random pills",
			"{{Heart}} +1 Health",
			"↑ +1 Damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.COOL_SUNGLASSES] = {
		_descType = "collectible",
		Name = "멋진 선글라스",
		QuoteDesc = "황금 러쉬",
		Description = [[
			{{Coin}} 동전 +6
			{{SpeedSmall}} 동전과 가까울수록 이동속도가 빨라집니다.
			{{Coin}} 동전 획득 시 방 전체에게 피해를 줍니다.
			!!! 방 진입 시 소지 중인 동전 3개를 강제로 랜덤 위치에 뿌립니다.
		]],
		Tests = {
			"{{Coin}} +6 Coins",
			"{{Speed}} Walking near coins grants a Speed up",
			"Collecting coins damages all enemies in the room",
			"{{Warning}} Upon entering an occupied room, 3 cents are taken from you and strewn across the room"
		},
		AbyssTests = {
			"10% chance to drop a penny on kill"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.FIENDS_HORN] = {
		_descType = "collectible",
		Name = "핀드의 뿔",
		QuoteDesc = "우리 모두의 마음 속엔 악이 자리잡고 있지",
		Description = [[
			적 처치 시 5%의 확률로 Fiend의 부하를 소환합니다.
			{{LuckSmall}} 행운 14+일 때 20%
			{{ffImmoralHeart}} 소지한 이모럴하트에 비례하여 소환 확률이 추가로 증가합니다.
			Fiend의 부하는 방 클리어 시 소멸합니다.
		]],
		Tests = {
			"Enemies have a 5% chance to drop a Fiend Minion on death",
			"{{Luck}} 20% chance at 14 luck",
			"Minions attack enemies and disappear on room clear",
			"{{ffImmoralHeart}} A bonus chance is applied for any Immoral Hearts you have"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.RISKS_REWARD] = {
		_descType = "collectible",
		Name = "위험에 따른 보상",
		QuoteDesc = "초능력으로 바꾸기 + 더 나은 아이템",
		Description = [[
			!!! {{TreasureRoom}} 스테이지 당 보물방에서만 1회 사용 가능:
			{{ItemPoolTreasure}} 사용 시 방 안의 아이템을 특수한 이공간으로 빨아들이며 더 높은 등급의 아이템으로 바꿉니다.
			검은 포탈을 통해 특수한 이공간으로 이동할 수 있으며 이공간에서 Hermit 처치 시 바뀐 아이템을 획득할 수 있습니다.
		]],
		Tests = {
			"Can be used to reroll an item in a {{TreasureRoom}} Treasure Room into one of a higher quality",
			"This is achieved by traversing a unique Psionic Zone and fighting Hermit, a mini boss",
			"{{Warning}} Can only be used in {{TreasureRoom}} Treasure Rooms",
		},
		Belial = "{{ItemPoolDevil}} 보물방이 아닌 악마방 배열의 아이템으로 등장합니다.",
		Virtues = {
			"High HP, high damage wisp"
		},
		CarBattery = false,
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SPARE_RIBS] = {
		_descType = "collectible",
		Name = "여분의 뼛조각",
		QuoteDesc = "주인에게로 돌아가거라",
		Description = [[
			↑ {{EmptyBoneHeart}}뼈하트 +1
			피격 시 일정 확률로 뼛조각 여러개를 발사합니다.
			뼛조각은 발사 후 캐릭터에게 되돌아오며 적 및 탄환을 막아줍니다.
		]],
		Tests = {
			"{{EmptyBoneHeart}} +1 Bone Heart",
			"Taking damage has a chance to fire out rib projectiles in a circle around you",
			"Rib projectiles return to their sender and are destroyed only on contact with what fired them",
			"Rib projectiles can destroy enemy projectiles"
		},
		AbyssTests = {
			"When the locust hits an enemy, rib projectiles fire in a circle"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BACON_GREASE] = {
		_descType = "collectible",
		Name = "베이컨 지방",
		QuoteDesc = "저칼로리",
		Description = [[
			↑ {{EmptyHeart}}빈 최대 체력 +1
			↓ {{Heart}}빨간하트 -1
			↑ {{ShotspeedSmall}}탄속 +0.15
			{{Trinket122}} Butter 장신구를 드랍합니다.
		]],
		Tests = {
			"{{EmptyHeart}} +1 Empty heart container",
			"↑ +0.15 Shot speed",
			"!!! Removes a Red Heart from your health, but will not kill you"
		},
		AbyssSpecial = {
			"1 big slightly faster locust (0.5x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DEVILS_UMBRELLA] = {
		_descType = "collectible",
		Name = "악마의 우산",
		QuoteDesc = "청소하기 너무 힘든 것",
		Description = [[
			↑ {{HalfSoulHeart}}소울하트 +0.5
			때때로 적에게 피해를 주는 노란 장판을 까는 작은 눈물을 여러 개 흩뿌립니다.
			{{LuckSmall}}행운이 높을수록 노란 눈물의 주기가 짧아집니다.
		]],
		Tests = {
			"{{HalfSoulHeart}} +1 Half Soul Heart",
			"20% chance to fire a flurry of weak tears that spawn yellow creep"
		},
		AbyssTests = {
			"Creates a small trail of yellow creep that does 10% of Isaac's damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.NUGGET_BOMBS] = {
		_descType = "collectible",
		Name = "너겟 폭탄",
		QuoteDesc = "친구가 담긴 폭탄 + 폭탄 5개",
		Description = [[
			{{Bomb}} 폭탄 +5
			{{Collectible504}} 폭탄이 터진 자리에 주위의 적에게 공격력 3.5의 눈물을 발사하는 파란 파리를 설치합니다.
		]],
		Tests = {
			"{{Bomb}} +5 Bombs",
			"Bombs spawn a Pooter familiar when they explode"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BEE_SKIN] = {
		_descType = "collectible",
		Name = "꿀벌의 몸통",
		QuoteDesc = "위이이잉",
		Description = [[
			눈물을 발사할 때마다 3방향으로 공격력 x0.3의 눈물을 발사합니다.
			3방향 눈물은 시계방향으로 서서히 돌아가면서 발사됩니다.
			!!! 비행 능력 없음
		]],
		Tests = {
			"Every tear fired triggers 3 weaker tears spread evenly around Isaac",
			"These tears do 30% of your damage",
			"Each time this effect triggers, the angle of all tears is incremented clockwise",
			"{{Warning}} Does not give you flight"
		},
		AbyssTests = {
			"Fires tears while charging that deal 10% Isaac's damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ALPHA_COIN] = {
		_descType = "collectible",
		Name = "알파 코인",
		QuoteDesc = "사용법을 배우거라",
		Description = [[
			사용 시 각각 발동:
			{{IND}} {{Coin}} 25% 의 확률로 동전을 드랍합니다.
			{{IND}} {{Card}} {{Pill}} 25%의 확률로 카드/알약을 드랍합니다.
			{{IND}} 현재 방 및 스테이지 진행 상태에 따라 다른 효과를 발동합니다.
		]],
		Tests = {
			"{{Coin}} 25% chance to spawn a coin",
			"{{Card}} {{Pill}}25% to spawn a card/pill",
			"A variety of effects based on the current room and exploration"
		},
		CarBattery = {"발동", "2번씩{{CR}} 발동"},
		AbyssTests = {
			"A variety of effects based on the current room and exploration"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PLANET_BADGE] = {
		_descType = "collectible",
		Name = "행성 배지",
		QuoteDesc = "스페이스 캠프에 온 걸 환영해!",
		Description = [[
			↑ {{DamageSmall}}공격력 +0.1
		]],
		Tests = {
			"↑ +0.1 Damage",
			"{{Warning}} Collect all 6 for a surprise!"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.MARIAS_IPAD] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "제발...",
		Description = [[
			사용 시 캐릭터를 제외한 모든 것을 방의 아래쪽으로 밀어넣습니다.
		]],
		Tests = {
			"Moves all entities to the bottom of the room"
		},
		Virtues = {
			"Can only shoot tears downwards"
		},
		AbyssTests = {
			"Can only shoot downwards"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.HAUNTED_BADGE] = {
		_descType = "collectible",
		Name = "유령 배지",
		QuoteDesc = "강력한 탄알을 얻었다!",
		Description = [[
			↑ {{DamageSmall}}공격력 +0.1
		]],
		Tests = {
			"↑ +0.1 Damage",
			"{{Warning}} Collect all 6 for a surprise!"
		},
		AbyssSpecial = {
			"1 locust (0.2x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BABY_BADGE] = {
		_descType = "collectible",
		Name = "아기 배지",
		QuoteDesc = "잘 갖고 있어!",
		Description = [[
			↑ {{DamageSmall}}공격력 +0.1
		]],
		Tests = {
			"↑ +0.1 Damage",
			"{{Warning}} Collect all 6 for a surprise!"
		},
		AbyssSpecial = {
			"1 locust (0.2x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.COMMISSIONED_BADGE] = {
		_descType = "collectible",
		Name = "분해된 배지",
		QuoteDesc = "이거 50달러나 한다구!",
		Description = [[
			↑ {{DamageSmall}}공격력 +0.1
		]],
		Tests = {
			"↑ +0.1 Damage",
			"{{Warning}} Collect all 6 for a surprise!"
		},
		AbyssSpecial = {
			"1 locust (0.2x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DRIPPING_BADGE] = {
		_descType = "collectible",
		Name = "드립 배지",
		QuoteDesc = "하긴, 여긴 많이 습하지",
		Description = [[
			↑ {{DamageSmall}}공격력 +0.1
		]],
		Tests = {
			"↑ +0.1 Damage",
			"{{Warning}} Collect all 6 for a surprise!"
		},
		AbyssSpecial = {
			"1 locust (0.2x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.MYSTERY_BADGE] = {
		_descType = "collectible",
		Name = "미스터리 배지",
		QuoteDesc = "뭐가 들었을까?",
		Description = [[
			↑ {{DamageSmall}}공격력 +0.1
		]],
		Tests = {
			"↑ +0.1 Damage",
			"{{Warning}} Collect all 6 for a surprise!"
		},
		AbyssSpecial = {
			"1 locust (0.2x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SPATULA_BADGE] = {
		_descType = "collectible",
		Name = "주걱 배지",
		QuoteDesc = "철판에다 던져버려!",
		Description = [[
			↑ {{DamageSmall}}공격력 +0.1
		]],
		Tests = {
			"↑ +0.1 Damage",
			"{{Warning}} Collect all 6 for a surprise!"
		},
		AbyssSpecial = {
			"1 locust (0.2x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.YOUR_ETERNAL_REWARD] = {
		_descType = "collectible",
		Name = "배지 완성 보상",
		QuoteDesc = "배지를 모두 모았다!",
		Description = [[
			↑ {{DamageSmall}}공격력 +0.1
		]],
		Tests = {
			"↑ +0.1 Damage"
		},
		AbyssSpecial = {
			"1 locust (0.2x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GOLEMS_ROCK] = {
		_descType = "collectible",
		Name = "골렘의 맷돌",
		QuoteDesc = "장신구 분해기",
		Description = [[
			획득 시 석기 장신구를 소환합니다.
			사용 시 현재 소지 중인 장신구를 빻아 석기 장신구를 소환합니다.
			석기 장신구는 일반적으로 등장하지 않으며 Golem 캐릭터 플레이 시에만 등장하는 특수 장신구입니다.
		]],
		Tests = {
			"Spawns a Golem trinket on pickup",
			"{{Trinket}} On use, grinds your current trinket into a rock trinket",
			"{{Trinket}} Can reroll rock trinkets when used whilst carrying one"
		},
		Virtues = {
			"Rock wisp with tears that destroys obstacles"
		},
		CarBattery = false,
		AbyssSpecial = {
			"Bigger slower locust (1.5x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PINHEAD] = {
		_descType = "collectible",
		Name = "묶인 단추",
		QuoteDesc = "재봉틀 발사",
		Description = [[
			{{ffSew}} 확률적으로({{LuckSmall}}) 적을 귀속시키는 재봉틀 눈물을 발사합니다.
		]],
		Tests = {
			"Grants sewing needle tears that pierce and inflict enemies with {{ffSew}} Sewn"
		},
		AbyssSpecial = {
			"2 locusts (0.75x Isaac's damage)"
		},
		AbyssTests = {
			"20% chance to inflict enemies with Sewn",
		},
		AppendEntries = {
			"FF_APPEND_SEW"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.LIL_LAMB] = {
		_descType = "collectible",
		Name = "리틀 램",
		QuoteDesc = "좋아하는 척 하는 친구",
		Description = [[
			{{Chargeable}} 공격키를 1초 이상 누르면 충전되며 공격키를 떼면 {{Collectible149}}공격력 25의 폭발성 구토제를 발사합니다.
			캐릭터가 이 폭발로 피해를 받을 시 몸통과 머리가 분리되며 분리된 몸통 근처의 적을 향해 자동으로 공격합니다.
		]],
		Tests = {
			"{{Chargeable}} Familiar that charges to shoot explosive shots",
			"When Isaac is damaged, has a chance to drop on the floor and target enemies automatically",
			"{{Warning}} Ipecac shots can do damage to Isaac"
		},
		BFFS = "피해량 2배",
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GRAPPLING_HOOK] = {
		_descType = "collectible",
		Name = "그래플링 후크",
		QuoteDesc = "위기탈출",
		Description = [[
			사용 시 공격방향으로 후크를 던지며 공격키를 떼면 후크의 위치로 이동합니다.
			구덩이와 장애물을 넘어갈 수 있으며 후크에서 떼도 장애물 위에 착지할 수 있습니다.
			!!! 후크 해제 시 구덩이에 떨어지면 체력 반칸의 피해를 받습니다.
		]],
		Tests = {
			"Throwable hook that can be used to quickly travel",
			"Can be used to climb onto rocks",
			"{{Warning}} Isaac can take damage by falling into pits"
		},
		CarBattery = false,
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GRABBER] = {
		_descType = "collectible",
		Name = "욕심쟁이",
		QuoteDesc = "손을 던지는 친구",
		Description = [[
			캐릭터의 반대로 움직이며 캐릭터가 있는 방향으로 손을 움직입니다.
			잡는 손에 닿은 적에게 5의 피해를 줍니다.
		]],
		Tests = {
			"Familiar based on Grabber from hit video game Grabber",
			"Mirrors your movements and grabs things in front of him",
			"Deals 5 damage a second"
		},
		BFFS = { 5, 10 },
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.IMP_SODA] = {
		_descType = "collectible",
		Name = "도깨비 소다",
		QuoteDesc = "치명타 공격",
		Description = [[
			4%의 확률로 치명타 피해를 주는 공격을 발사합니다.
			{{LuckSmall}} 행운 11+일 때 33%
			치명타는 적에게 공격력 x5의 피해를 줍니다.
		]],
		Tests = {
			"4% chance to shoot purple critical tears that deal x5 damage",
			"{{Luck}} 33% chance at 11 luck"
		},
		AbyssTests = {
			"4% chance to deal x5 damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DADS_WALLET] = {
		_descType = "collectible",
		Name = "아빠의 지갑",
		QuoteDesc = "공격력 빚지기",
		Description = [[
			{{Card43}} 획득 시 Credit Card를 드랍합니다.
			소지 중인 동전이 부족해도 상점 아이템을 구매할 수 있습니다.
			{{DamageSmall}} 부족한 금액 당 {{ColorOrange}}공격력 배율{{CR}}이 감소합니다.
			!!! 부족한 예상 금액이 99{{Coin}}인 경우 더 이상 구매할 수 없습니다.
		]],
		Tests = {
			"{{Coin}} Items and pickups for sale can be purchased even if unaffordable",
			"↓ If Isaac buys an item that he cannot afford, he gets a temporary multiplicative damage down",
			"Damage returns to normal when Isaac pays back his debt",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BEGINNERS_LUCK] = {
		_descType = "collectible",
		Name = "초심자의 행운",
		QuoteDesc = "시간이 지날수록 줄어드는 행운",
		Description = [[
			↑ {{LuckSmall}}행운 +5
			↓ 스테이지 진행 상태 당 {{LuckSmall}}행운 -0.5(최소 1)
		]],
		Tests = {
			"↑ +5 Luck up",
			"↓ -0.5 Luck based on how many floors Isaac has progressed down to, to a minimum of 0.5 Luck"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DICHROMATIC_BUTTERFLY] = {
		_descType = "collectible",
		Name = "색이 다른 나비",
		QuoteDesc = "피격 판정 감소, 유도성 부적",
		Description = [[
			{{ffHitbox}} 피격 판정 크기가 줄어들며 피격 판정의 범위가 표시됩니다.
			{{DamageSmall}} 탄환을 가까스로 피할 시 그 방에서 공격력 +0.2(최대 +3)
			17%의 확률로 공격력 x1.25의 강한 유도 공격이 나갑니다.
			{{LuckSmall}} 행운 7+일 때 64%
		]],
		Tests = {
			"{{ffHitbox}} Hitbox size is reduced and indicated by a marker",
			"{{Damage}} Grants +0.2 Damage for the current room for narrowly avoiding a projectile, capping at +3 Damage",
			"17% chance to fire a homing tear that deals x1.25 your damage",
			"{{Luck}} 64% chance at 7 luck"
		},
		AbyssTests = {
			"Homing"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SLIPPYS_GUTS] = {
		_descType = "collectible",
		Name = "슬리피의 내장",
		QuoteDesc = "음정",
		Description = [[
			{{Poison}} 적 처치 시 최대 체력에 비례한 확률로 작은 구름을 생성합니다.
			{{Bomb}} 폭탄이 터지면 그 자리에 작은 구름을 생성합니다.
			{{Poison}} 작은 구름은 닿은 적을 중독시킵니다.
		]],
		Tests = {
			"{{Poison}} Enemies have a chance to spawn a lingering poison cloud on death",
			"{{Luck}} Chance scales with Luck, and is proportionate to enemy's Max HP",
			"{{Bomb}} Bombs spawn a lingering poison cloud on explosion"
		},
		AbyssTests = {
			"20% chance to spawn a knockback or poisonous fart when dealing damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SLIPPYS_HEART] = {
		_descType = "collectible",
		Name = "슬리피의 심장",
		QuoteDesc = "정교",
		Description = [[
			적에게 가까이 있으면 확률적으로 적을 밀쳐내는 랜덤 방귀를 뀝니다.
			>>> 20%: 작은 방귀
			>>> {{Confusion}} 40%: 혼란성 방귀 
			>>> {{Poison}} 38%: 독방귀
			>>> {{Poison}} 2%: 여러 개의 독방귀
		]],
		Tests = {
			"{{Luck}} Isaac will pulse red and have a Luck based chance to fart while near enemies",
			"20% chance to do a little fart",
			"{{Confusion}} 40% chance to do a normal fart that confuses enemies",
			"{{Poison}} 38% chance to fart a poisonous fart cloud",
			"{{Poison}} 2% chance to fart multiple poisonous farts"
		},
		AbyssTests = {
			"20% chance to spawn a knockback or poisonous fart when dealing damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.COMMUNITY_ACHIEVEMENT] = {
		_descType = "collectible",
		Name = "커뮤니티 업적",
		QuoteDesc = "숫자세기에 정통",
		Description = [[
			↑ {{DamageSmall}}공격력 +]]..string.format("%.2f", FiendFolio:GetCommunityAchievementDamage())..[[
			{{DamageSmall}} 공격력 증가량은 Fiend Folio 디스코드 Counting 계열 채널의 기록에 비례합니다.
			!!! 현재 모드에 기록된 최고기록:
			{{Blank}} 일반:]]..FiendFolio.CountingChannelWorldRecords.Canon.Regular..[[
			{{Blank}} 하드:]]..FiendFolio.CountingChannelWorldRecords.Canon.Hardcore..[[
		]],
		Tests = {
			"{{Damage}} Damage up scales with the current records in the Fiend Folio Community Discord counting channels"
		},
		AbyssSpecial = {
			"1 locust (4.41x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CHIRUMIRU] = {
		_descType = "collectible",
		Name = "치르밀",
		QuoteDesc = "체력, 공격력 증가 + [퍼펙트 프리즈]",
		Description = [[
			↑ {{SoulHeart}}소울하트 +1
			↑ {{DamageSmall}}공격력 +0.9
			{{Petrify}} 방 입장 시 모든 적을 0.9초간 석화시킵니다.
		]],
		Tests = {
			"{{SoulHeart}} +1 Soul Heart",
			"↑ +0.9 Damage",
			"Upon entering a room, all enemies are frozen for 0.9 seconds"
		},
		AbyssTests = {
			"18% chance to petrify enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GOLEMS_ORB] = {
		_descType = "collectible",
		Name = "골렘의 오브",
		QuoteDesc = "분실품",
		Description = [[
			↑ {{SoulHeart}}소울하트 +2
			↑ {{SpeedSmall}}이동속도 +0.2
			↑ {{ShotspeedSmall}}탄속 +0.23
			↑ {{LuckSmall}}행운 +1
		]],
		Tests = {
			"↑ +0.23 Shot speed",
			"↑ +0.2 Speed",
			"↑ +1 Luck",
			"{{SoulHeart}} +2 Soul Hearts"
		},
		AbyssSpecial = {
			"1 big and fast locust (1.5x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.LEFTOVER_TAKEOUT] = {
		_descType = "collectible",
		Name = "먹다 남은 배달 음식",
		QuoteDesc = "모든 능력치 증가 + 운세 증가",
		Description = [[
			↑ {{Heart}}최대 체력 +1
			↑ {{Heart}}빨간하트 +1
			↑ {{DamageSmall}}공격력 배율 x1.5
			↑ {{TearsSmall}}연사 배율 x1.1
			↑ {{RangeSmall}}사거리 +1.5
			↑ {{SpeedSmall}}이동속도 +0.3
			↑ {{LuckSmall}}행운 +1
			20%의 확률로 적에게 명중 시 운세를 보여주는 공격력 x1.05의 포춘쿠키를 발사합니다.
			{{LuckSmall}} 행운 2+일 때 33%
		]],
		Tests = {
			"↑ +1 Health",
			"{{HealingRed}} Heals 1 heart",
			"↑ +0.3 Speed",
			"↑ x1.5 Damage multiplier",
			"↑ x1.1 Fire rate multiplier",
			"↑ +1.5 Range",
			"↑ +1 Luck",
			"20% chance to fire a fortune worm tear that does x1.05 damage",
			"{{Luck}} 33% chance at 2 luck"
		},
		AbyssSpecial = {
			"1 big locust (2x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.MODERN_OUROBOROS] = {
		_descType = "collectible",
		Name = "모던 우로보로스",
		QuoteDesc = "악마를 닮은 목소리",
		Description = [[
			{{Slow}} 공격이 무언가에 부딪힐 때 기름 장판이 생기며 
			캐릭터/불이 기름 장판에 닿으면 불이 붙습니다.
			캐릭터는 이 불에 피해를 받지 않습니다.
		]],
		Tests = {
			"{{Slow}} Tears leave slowing oil creep upon impact",
			"Walking over oil creep will ignite it",
			"Flames can ignite other oil puddles close by"
		},
		AbyssTests = {
			"20% chance to leave igniting slowing oil creep"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.FROG_HEAD] = {
		_descType = "collectible",
		Name = "황금 개구리 머리",
		QuoteDesc = "방귀는 좋아",
		Description = [[
			사용({{ButtonLT}}) 버튼을 누르고 있는 동안 캐릭터를 멈추게 합니다.
			멈춘 시간에 비례하여 적을 밀어내는 방귀를 뀝니다.
		]],
		Tests = {
			"Holding down the USE ({{ButtonLT}}) button forces you to stand still",
			"Letting go of the USE ({{ButtonLT}}) button makes Isaac fart, the fart getting more powerful the longer you hold it down"
		},
		CarBattery = "적을 밀어내는 강도 2배",
		AbyssTests = {
			"20% chance to spawn a knockback or poisonous fart when dealing damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SANGUINE_HOOK] = {
		_descType = "collectible",
		Name = "핏빛 후크",
		QuoteDesc = "너의 것이 아니야",
		Description = [[
			사용 시 공격하는 방향으로 적 및 픽업을 끌고 오는 후크를 던집니다.
			{{ffBruise}} 후크에 묶인 적은 멍들며;
			{{ffHemorrhage}} 묶인 적이 있는 상태에서 재사용 시 해당 적을 놓으며 대출혈시킵니다.
		]],
		Tests = {
			"Throwable hook that pulls in enemies/pickups",
			"Enemies are bruised while hooked and hemorrhaged upon release"
		},
		AppendEntries = {
			"FF_APPEND_BRUISE",
			"FF_APPEND_HEMORRHAGE",
		},
		Virtues = {
			"4 Temporary wisps whenever an enemy is hooked",
		},
		Belial = "후크에 묶인 적이 있는 동안 공격력 +2",
		AbyssTests = {
			"10% chance to inflict enemies with Bruised",
			"10% chance to inflict enemies with Hemorrhage",
		},
		CarBattery = false,
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PEACH_CREEP] = {
		_descType = "collectible",
		Name = "피치 크리프",
		QuoteDesc = "무서운 친구",
		Description = [[
			벽을 따라 움직이며 적과 일렬로 맞추고 공격력 2의 눈물을 4발 연속으로 발사합니다.
		]],
		Tests = {
			"Wall Creep familiar that tries to line up with enemies and shoots bursts of tears",
			"Shoots a barrage of 4 tears that do 2 damage per tear"
		},
		BFFS = { 2, 4 },
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GORGON] = {
		_descType = "collectible",
		Name = "고르곤",
		QuoteDesc = "수줍은 석상",
		Description = [[
			방 중앙에 가만히 있으며 랜덤 적을 향해 주시합니다.
			{{Petrify}} 고르곤의 시야에 닿은 적을 석화시킵니다.
		]],
		Tests = {
			"Stationary familiar that spawns in the center of the room",
			"If there are enemies in the room, Gorgoneion will stare at them and petrify them"
		},
		BFFS = false,
		AbyssTests = {
			"25% chance to petrify enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.FIDDLE_CUBE] = {
		_descType = "collectible",
		Name = "바이올린 큐브",
		QuoteDesc = "놀고 있는 악마의 장난감",
		Description = [[
			리듬에 맞춰 반복적으로 사용 시:
			>>> {{DamageSmall}} 공격력 배율 x1.5
			>>> {{TearsSmall}} 연사 +1
			잠시 동안 사용하지 않을 시 증가한 {{DamageSmall}}공격력 및 {{TearsSmall}}연사가 서서히 감소합니다.
		]],
		Tests = {
			"{{Damage}} Grants an increasing amount of Damage and Tears when used multiple times",
			"{{Tears}} Damage and Tears gradually go away if the item is not being used"
		},
		Virtues = {
			"Gain wisps the more you use Fiddle Cube",
			"Wisps gradually go away if the item is not being used"
		},
		Belial = "공격력 증가량 2배",
		CarBattery = "공격력 및 연사 증가량 2배",
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.AVGM] = {
		_descType = "collectible",
		Name = "딸깍이",
		QuoteDesc = "중독성",
		Description = [[
			{{Coin}} 여러 번 사용 시 동전을 하나 드랍합니다.
			동전을 드랍할 때마다 다음 동전 드랍에 필요한 사용 회수가 증가합니다.
		]],
		Tests = {
			"{{Coin}} Pays out with coins after using an increasing amount of times",
			"After enough uses, you will prestige, causing A.V.G.M to spawn an item pedestal"
		},
		Virtues = {
			"When a coin pays out, you also get a wisp"
		},
		AbyssTests = {
			"When the locust flies into a wall, it changes color",
			"{{Coin}} When changing color, the locust pays out with coins after enough time",
		},
		Belial = "{{DamageSmall}} 동전을 드랍한 방에서 공격력 +2",
		CarBattery = "다음 동전 드랍에 필요한 사용 회수 x0.5",
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.OPHIUCHUS] = {
		_descType = "collectible",
		Name = "뱀주인자리",
		QuoteDesc = "뱀의 주인이 되다",
		Description = [[
			방 안을 돌아다니며 적을 향해 이동합니다.
			{{Poison}} 적과 접촉 시 캐릭터의 공격력 x0.2의 피해를 주며 1초간 공격력 x4({{BossRoom}}:x2)의 피해를 줍니다.
			중독되지 않은 적을 우선적으로 추적합니다.
		]],
		Tests = {
			"Wiggly snake familiar that chases after enemies, inflicting poison and dealing damage on contact",
			"{{Poison}} Prioritizes chasing after enemies that are not currently inflicted with poison",
		},
		BFFS = "중독 피해량 2배",
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CETUS] = {
		_descType = "collectible",
		Name = "고래자리",
		QuoteDesc = "고래의 보복",
		Description = [[
			피격 시 2초간 푸른 장판을 까는 눈물을 흩뿌립니다.
		]],
		Tests = {
			"Spews out a large number of tears that leave creep when Isaac takes damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DEIMOS] = {
		_descType = "collectible",
		Name = "데이모스",
		QuoteDesc = "인생 파트너",
		Description = [[
			공격하는 방향으로 적 및 픽업을 끌고 오는 후크를 던집니다.
			{{ffBruise}} 후크에 묶인 적은 멍든 상태가 되며ㅣ
			{{ffHemorrhage}} 묶인 적이 있는 상태에서 공격키를 떼면 해당 적을 놓으며 대출혈 시킵니다.
		]],
		Tests = {
			"Familiar that hooks in enemies/pickups",
			"Enemies are bruised while hooked and hemorrhaged upon release"
		},
		AppendEntries = {
			"FF_APPEND_BRUISE",
			"FF_APPEND_HEMORRHAGE",
		},
		StatusEffects = {
			FiendFolio.DescriptionStatuses.BRUISE,
			FiendFolio.DescriptionStatuses.HEMORRHAGE
		},
		BFFS = false,
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.MALICE] = {
		_descType = "collectible",
		Name = "악의",
		QuoteDesc = "집중성 악의",
		Description = [[
			사용 시 캐릭터의 공격방향으로 벽에 부딪힐 때까지 돌진합니다.
			{{HalfBlackHeart}} 돌진 상태에서 적 처치 시 35%의 확률로 블랙하트 반칸을 드랍합니다.
		]],
		Tests = {
			"Use to turn into a malicious fireball that charges across the room",
			"{{HalfBlackHeart}} Enemies killed in this state have a 35% chance to drop Half Black Hearts if you are Tainted Fiend"
		},
		CarBattery = false,
		AbyssSpecial = {
			"1 fast locust (1x Isaac's damage)"
		},
		AbyssTests = {
			"Creates a small trail of slowing black creep"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PET_ROCK] = {
		_descType = "collectible",
		Name = "돌멩이 펫",
		QuoteDesc = "움직일 수 있는 커버",
		Description = [[
			가만히 있으며 탄환을 막아줍니다.
			캐릭터가 밀쳐낼 수 있으며 구덩이에 떨어트리면 해당 구덩이를 메울 수 있습니다 (방 당 1회)
		]],
		Tests = {
			"Pet rock familiar that can be pushed around and blocks shots",
			"Fills pits when pushed into them",
		},
		BFFS = "크기 증가",
		AbyssSpecial = {
			"1 very slow locust (0.5x Isaac's damage)",
		},
		AbyssTests = {
			"Blocks enemy shots"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BIRTHDAY_GIFT] = {
		_descType = "collectible",
		Name = "생일 선물",
		QuoteDesc = "뭘 원할 건지 생각해",
		Description = [[
			{{Collectible515}} 모든 아이템이 Mystery Gift로 등장합니다.
			바뀐 아이템 및 고정 드랍은 Mystery Gift로 변경되지 않습니다.
		]],
		Tests = {
			"{{Collectible515}} Replaces all found items with Mystery Gift",
			"Does not affect story mode items, special drops, or items spawned by Mystery Gift"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CONTRABAND] = {
		_descType = "collectible",
		Name = "밀매품",
		QuoteDesc = "검은 모자가 배달료를 줄거야",
		Description = [[
			!!! 소지하지 않은 상태에서는 특정 몬스터가 해당 아이템을 훔칠 수 있습니다!
			해당 아이템을 다음 스테이지의 검은 모자의 거지에게 배달 시 특수 배열의 아이템을 소환합니다.
		]],
		Tests = {
			"Better hold onto this!",
			"{{Warning}} I heard a shady guy next floor is looking for it..."
		},
		Belial = "{{DamageSmall}} 사용 회수에 따라 공격력 증가",
		AbyssSpecial = {
			"1 slow locust (0.5x Isaac's damage)"
		},
		AbyssTests = {
			"Attacks very fast"
		},
		CarBattery = false,
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BLACK_LANTERN] = {
		_descType = "collectible",
		Name = "검은 랜턴",
		QuoteDesc = "낙관스런 저주",
		Description = [[
			↑ {{BlackHeart}}블랙하트 +1
			{{CurseCursedSmall}} 항상 저주에 걸리며 기존의 저주가 아닌 새로운 형태의 저주가 걸립니다.
		]],
		Tests = {
			"{{BlackHeart}} +1 Black Heart",
			"Guarantees a curse on every floor",
			"{{ffCursesBlackLantern}} Replaces curses with special new kinds of potentially beneficial curses"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CLEAR_CASE] = {
		_descType = "collectible",
		Name = "투명 케이스",
		QuoteDesc = "간편한 액티브 아이템 수납공간",
		Description = [[
			!!! 획득과 동시에 카드/알약 슬롯에 배치됨
			소지한 상태에서 다음 액티브 아이템 획득 시 해당 액티브 아이템이 카드/알약 슬롯에 배치됩니다.
		]],
		Tests = {
			"The next active item you pick up will be assigned to your pocket active slot"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CLEAR_CASE_PASSIVE] = {
		_descType = "collectible",
		Name = "투명 케이스",
		QuoteDesc = "간편한 액티브 아이템 수납공간",
		Description = [[
			!!! 획득과 동시에 카드/알약 슬롯에 배치됨
			소지한 상태에서 다음 액티브 아이템 획득 시 해당 액티브 아이템이 카드/알약 슬롯에 배치됩니다.
		]],
		Tests = { "" },
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CRUCIFIX] = {
		_descType = "collectible",
		Name = "십자가",
		QuoteDesc = "우리의 죄를 사하소서",
		Description = [[
			{{ffMartyr}}적 처치 시 순교자로 만듭니다.
		]],
		Tests = {
			"Enemies killed by tears will turn into Martyrs"
		},
		AppendEntries = {
			"FF_APPEND_MARTYR",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.MARTYR },
		AbyssTests = {
			"Turn enemies into Martyrs upon kill"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BEDTIME_STORY] = {
		_descType = "collectible",
		Name = "자장가",
		QuoteDesc = "이제 눈을 감을 시간",
		Description = [[
			{{ffSleeping}} 사용 시 방 안의 적을 6초간 나른한 상태로 만듭니다.
		]],
		Tests = {
			"Inflicts all enemies with Drowsy for 6 seconds"
		},
		Virtues = {
			"{{ffSleeping}} Drowsy for the whole room when destroyed",
		},
		CarBattery = { 6, 12 },
		AbyssTests = {
			"20% chance to inflict Drowsy when dealing damage"
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.DROWSY_AND_SLEEP },
		AppendEntries = {
			"FF_APPEND_DROWSY",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PRANK_COOKIE] = {
		_descType = "collectible",
		Name = "장난꾸러기 쿠키",
		QuoteDesc = "옥수수 맛이 나",
		Description = [[
			공격할 때마다 확률적으로 랜덤한 상태이상 효과 공격이 나갑니다.
			{{Blank}} ({{ffBerserk}}/{{ffBruise}}/{{ffDoom}}/{{ffSleeping}}/{{ffHemorrhage}}/{{ffMartyr}}/{{ffSew}}/{{ffMultieuclidean}})
		]],
		Tests = {
			"Grants multi-coloured tears that have different Fiend Folio effects"
		},
		AbyssTests = {
			"Chance to apply random status effects on enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DEVILS_HARVEST] = {
		_descType = "collectible",
		Name = "악마의 수확",
		QuoteDesc = "개조된 생명",
		Description = [[
			↑ 목숨 +1
			{{Player]] .. FiendFolio.PLAYER.FIEND .. [[}} 사망 시 전 방에서 Fiend 캐릭터로 부활합니다.
		]],
		Tests = {
			"↑ +1 Life ",
			"{{Player" .. FiendFolio.PLAYER.FIEND .. "}} On death, Isaac respawns as Fiend in the previous room"
		},
		AbyssTests = {
			"No effects"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ETERNAL_D12] = {
		_descType = "collectible",
		Name = "이터널 D12",
		QuoteDesc = "???",
		Description = [[
			!!! 사용할 때마다 형태를 바꿉니다:
			사용 시 방 안의 모든 장애물을 바꿉니다.
			현재 형태의 충전량이 높을수록 장애물이 사라질 확률이 감소합니다.
		]],
		Tests = {
			"Switches between two modes",
			"Has a high chance to reroll grids and a low chance to wipe away grids"
		},
		Virtues = {
			"10% chance for tears to reroll rocks, urns, skulls or mushrooms"
		},
		CarBattery = false,
		AbyssTests = {
			"20% chance to devolve enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.RUBBER_BULLETS] = {
		_descType = "collectible",
		Name = "고무 총알",
		QuoteDesc = "멍들게 하는 총알",
		Description = [[
			{{ffBruise}} 20%의 확률로 적을 멍들게 하는 공격이 나갑니다.
			{{LuckSmall}} 행운 10+일 때 50%
		]],
		Tests = {
			"{{ffBruise}} 20% chance to fire bullet tears that inflict enemies with Bruised",
			"{{Luck}} 50% chance at 10 luck"
		},
		AppendEntries = {
			"FF_APPEND_BRUISE",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.BRUISE
		},
		AbyssTests = {
			"20% chance to inflict enemies with Bruised"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.THE_DELUXE] = {
		_descType = "collectible",
		Name = "디럭스 세트",
		QuoteDesc = "각종 조미료",
		Description = [[
			↑ {{EmptyBoneHeart}}뼈하트 +1
			↑ {{ffMorbidHeart}}종양하트 +1
			↑ {{GoldenHeart}}황금하트 +1
			↑ {{EternalHeart}}이터널하트 +1
		]],
		Tests = {
			"{{EmptyBoneHeart}} +1 Bone Heart",
			"{{ffMorbidHeart}} +1 Morbid Heart",
			"{{GoldenHeart}} +1 Golden Heart",
			"{{EternalHeart}} +1 Eternal Heart"
		},
		AbyssSpecial = {
			"1 big and slow locust (1.5x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.LIL_MINX] = {
		_descType = "collectible",
		Name = "리틀 밍스",
		QuoteDesc = "더블탭 빙의",
		Description = [[
			적에게 돌진하여 접촉한 적에게 3.5의 피해를 줍니다.
			{{ffBerserk}} 공격키를 두번 누르면 가장 가까운 적에게 빙의하여 폭주 상태로 만듭니다.
			빙의 중인 적이 있을 때 다시 공격키를 두번 누르면 여러 개의 눈물을 흩뿌리며 빠져나옵니다.
		]],
		Tests = {
			"Familiar that charges at enemies",
			"{{ffBerserk}} Double-tapping the fire button possesses the nearest enemy and inflicts them with Berserk",
			"Double-tapping again makes the familiar exit the enemy, shooting tears out"
		},
		BFFS = "피해량 2배",
		AppendEntries = {
			"FF_APPEND_BERSERK",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.BERSERK },
		AbyssTests = {
			"20% chance to inflict Berserk when dealing damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PURPLE_PUTTY] = {
		_descType = "collectible",
		Name = "보라색 퍼티",
		QuoteDesc = "충전식 인체개조",
		Description = [[
			{{ffImmoralHeart}} 사용 시 이모럴하트 +1
		]],
		Tests = {
			"{{ffImmoralHeart}} +1 Immoral Heart"
		},
		AppendEntries = {
			"FF_APPEND_IMMORAL_HEART",
		},
		Virtues = {
			"Spawns a Fiend Minion when destroyed",
			"4% chance for Critical tears"
		},
		CarBattery = { 1, 2 },
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.FETAL_FIEND] = {
		_descType = "collectible",
		Name = "핀드의 꽃잎",
		QuoteDesc = "아낌없이 주는 몸",
		Description = [[
			↑ {{DamageSmall}}공격력 +1.4
			{{ffImmoralHeart}} 모든 빨간/소울/블랙하트를 이모럴하트로 바꿉니다.
		]],
		Tests = {
			"↑ +1.4 Damage",
			"{{ffImmoralHeart}} Converts all Soul and Black Hearts into Immoral Hearts",
			"{{Heart}} Replaces all Red Hearts with Immoral Hearts"
		},
		AppendEntries = {
			"FF_APPEND_IMMORAL_HEART",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.FIEND_MIX] = {
		_descType = "collectible",
		Name = "핀드 믹스",
		QuoteDesc = "핀드의 부하 제조기",
		Description = [[
			{{EmptyHeart}} 사용 시 현재 체력의 50%를 Fiend의 부하로 바꿉니다.
		]],
		Tests = {
			"{{EmptyHeart}} On use, transforms half your health into Fiend Minions"
		},
		Virtues = {
			"Spawns a Fiend Minion when destroyed"
		},
		CarBattery = {50, 75},
		AbyssSpecial = {
			"1 small locust (0.75x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SECRET_STASH] = {
		_descType = "collectible",
		Name = "숨겨진 보관함",
		QuoteDesc = "...그래요, 아직 사라지지 않았어요!",
		Description = [[
			획득 시 {{Coin}}동전, {{Key}}열쇠, {{Bomb}}폭탄, {{Card}}카드/{{Pill}}알약/{{Rune}}룬을 하나씩 드랍합니다.
			다음 게임에서 이전 게임에 소지했던 {{Coin}}동전, {{Key}}열쇠, {{Bomb}}폭탄의 10%(반내림, 최대 5) 및 {{Card}}카드/{{Pill}}알약/{{Rune}}룬을 소환합니다.
		]],
		Tests = {
			"Spawns a random set of pickups",
			"At the start of your next run, spawns your held item and 10% of your pickups at the end of this run"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GLIZZY] = {
		_descType = "collectible",
		Name = "글리지 소시지",
		QuoteDesc = "허기는 채워야지",
		Description = [[
			{{Coin}} 동전 +0.1
			↑ {{HalfHeart}}절반 채워진 최대 체력 +1
			↑ {{SpeedSmall}}이동속도 +0.1
			↑ {{TearsSmall}}연사 +0.1
			↑ {{DamageSmall}}공격력 +0.1
			↑ {{RangeSmall}}사거리 +0.1
			↑ {{ShotspeedSmall}}탄속 +0.1
			↑ {{LuckSmall}}행운 +0.1
		]],
		Tests = {
			"{{HalfHeart}} +1 Half-filled heart container",
			"↑ +0.1 Speed",
			"↑ +0.1 Tears",
			"↑ +0.1 Damage",
			"↑ +0.1 Range",
			"↑ +0.1 Shot speed",
			"↑ +0.1 Luck",
			"{{Coin}} +0.1 Coins"
		},
		AbyssSpecial = {
			"1 slightly fast locust (1.1x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.FIEND_HEART] = {
		_descType = "collectible",
		Name = "핀드의 심장",
		QuoteDesc = "체력 증가?",
		Description = [[
			↑ {{ffImmoralHeart}}이모럴하트 +3
		]],
		Tests = {
			"{{ffImmoralHeart}} +3 Immoral Hearts"
		},
		AppendEntries = {
			"FF_APPEND_IMMORAL_HEART",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DEVILLED_EGG] = {
		_descType = "collectible",
		Name = "악마화된 알",
		QuoteDesc = "연사, 부도덕함 증가",
		Description = [[
			↑ {{ffImmoralHeart}}이모럴하트 +2
			↑ {{TearsSmall}}연사 +0.3
		]],
		Tests = {
			"{{ffImmoralHeart}} +2 Immoral Hearts",
			"↑ +0.3 Tears"
		},
		AppendEntries = {
			"FF_APPEND_IMMORAL_HEART",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.TEA] = {
		_descType = "collectible",
		Name = "녹차",
		QuoteDesc = "체력 증가",
		Description = [[
			↑ {{Heart}}최대 체력 +1
			↑ {{Heart}}빨간하트 +1
		]],
		Tests = {
			"↑ +1 Health",
			"{{HealingRed}} Heals 1 heart"
		},
		Binge = [[
			↑ {{RangeSmall}}사거리 +2.5
			↑ {{LuckSmall}}행운 +1
			↓ {{SpeedSmall}}이동속도 -0.03
		]],
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.FRAUDULENT_FUNGUS] = {
		_descType = "collectible",
		Name = "썩은 버섯",
		QuoteDesc = "일부 능력치 증가",
		Description = [[
			↑ {{RottenHeart}}썩은 최대 체력 +1
			↑ {{SpeedSmall}}이동속도 +0.2
			↑ {{DamageSmall}}공격력 +0.3
			↑ {{RangeSmall}}사거리 +2.5
		]],
		Tests = {
			"{{RottenHeart}} +1 Rotten Heart",
			"↑ +0.2 Speed",
			"↑ +0.3 Damage",
			"↑ +2.5 Range"
		},
		AbyssTests = {
			"5% chance to poison enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SMALL_PIPE] = {
		_descType = "collectible",
		Name = "작은 파이프",
		QuoteDesc = "파이프 깨뜨린걸 축하해!",
		Description = [[
			↑ {{DamageSmall}}공격력 +0.2
			↑ {{TearsSmall}}연사 +0.2
			↑ {{ShotspeedSmall}}탄속 +0.2
			↑ {{SpeedSmall}}이동속도 +0.2
		]],
		Tests = {
			"↑ +0.2 Damage",
			"↑ +0.2 Tears",
			"↑ +0.2 Shot speed",
			"↑ +0.2 Speed"
		},
		AbyssSpecial = {
			"1 slightly faster locust (1x Isaac' damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SMALL_WOOD] = {
		_descType = "collectible",
		Name = "작은 나무판",
		QuoteDesc = "연사 증가",
		Description = [[
			↑ {{TearsSmall}}연사 +0.7
			↑ {{DamageSmall}}공격력 +0.2
			↓ {{ShotspeedSmall}}탄속 -0.2
		]],
		Tests = {
			"↑ +0.7 Tears",
			"↑ +0.2 Damage",
			"↓ -0.2 Shot speed"
		},
		AbyssSpecial = {
			"1 slightly slower locust (1.5x Isaac' damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.WHITE_PEPPER] = {
		_descType = "collectible",
		Name = "하얀 페퍼",
		QuoteDesc = "퍼지는 유령 불꽃",
		Description = [[
			사용 시 5방향으로 캐릭터의 공격력 x1의 푸른 지속 불꽃을 날립니다.
		]],
		Tests = {
			"On use, shoots 5 flames in a ring around you"
		},
		VirtuesSingleRoom = true,
		CarBattery = { 5, 10 },
		AbyssSpecial = {
			"5 locusts (0.27x Isaac's damage)"
		},
		AbyssTests = {
			"5% chance to Burn enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PEPPERMINT] = {
		_descType = "collectible",
		Name = "페퍼민트",
		QuoteDesc = "뜨거워! ...가 아니잖아",
		Description = [[
			{{Freezing}} 공격 시 8%의 확률로 처치 시 적을 얼리는 불꽃을 날립니다.
			{{LuckSmall}} 행운 10+일 때 50%
			불꽃은 탄환 4회, 적에게 4회 피해, 혹은 10초 후 사라집니다.
		]],
		Tests = {
			"{{Freezing}} 8% chance to shoot a freezing fire that blocks enemy shots and deals contact damage",
			"{{Luck}} 50% chance at 10 luck",
			"Fires disappear after blocking 4 shots, dealing damage 4 times or after 10 seconds"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BLACK_MOON] = {
		_descType = "collectible",
		Name = "검은 달",
		QuoteDesc = "모든것은 무로 돌아간다",
		Description = [[
			적 처치 시 주변의 적에게 피해를 주는 십자가를 소환합니다.
			십자가의 크기는 캐릭터의 공격력, 연사에 비례
			십자가로 처치된 적은 또 다른 십자가를 소환하지 않습니다.
		]],
		Tests = {
			"On death, enemies spawn a cross that damages enemies in an area of effect",
			"The aura scales with Isaac's damage and fire rate",
			"Enemies killed by the cross don't spawn another cross"
		},
		AbyssTests = {
			"Enemies spawn a cross that damages enemies on kill"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_1] = {
		_descType = "collectible",
		Name = "기초 오브젝트",
		QuoteDesc = "유사 오브젝트",
		Description = [[
			{{ffObject}} 획득 시 랜덤 오브젝트를 하나 드랍합니다.
			{{ffObject}} 사용 시 소지중인 오브젝트의 효과를 발동합니다.
			오브젝트에 따라서 충전량이 달라집니다.
		]],
		Tests = {
			"{{ffObject}} Spawns 1 object on pickup",
			"{{ffObject}} Triggers the effect of the object Isaac holds without using it"
		},
		Virtues = {
			"15% chance for enemies to drop an {{ffObject}} object on kill",
			"Drops an {{ffObject}} object when destroyed"
		},
		CarBattery = {"발동합니다", "2번{{CR}} 발동합니다"},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_2] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{ffObject}} Spawns 1 object on pickup",
			"{{ffObject}} Triggers the effect of the object Isaac holds without using it"
		},
		Virtues = {
			"15% chance for enemies to drop an {{ffObject}} object on kill",
			"Drops an {{ffObject}} object when destroyed"
		},
		CarBattery = false,
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_3] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{ffObject}} Spawns 1 object on pickup",
			"{{ffObject}} Triggers the effect of the object Isaac holds without using it"
		},
		Virtues = {
			"15% chance for enemies to drop an {{ffObject}} object on kill",
			"Drops an {{ffObject}} object when destroyed"
		},
		CarBattery = false,
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_4] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{ffObject}} Spawns 1 object on pickup",
			"{{ffObject}} Triggers the effect of the object Isaac holds without using it"
		},
		Virtues = {
			"15% chance for enemies to drop an {{ffObject}} object on kill",
			"Drops an {{ffObject}} object when destroyed"
		},
		CarBattery = false,
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_5] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{ffObject}} Spawns 1 object on pickup",
			"{{ffObject}} Triggers the effect of the object Isaac holds without using it"
		},
		Virtues = {
			"15% chance for enemies to drop an {{ffObject}} object on kill",
			"Drops an {{ffObject}} object when destroyed"
		},
		CarBattery = false,
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_6] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{ffObject}} Spawns 1 object on pickup",
			"{{ffObject}} Triggers the effect of the object Isaac holds without using it"
		},
		Virtues = {
			"15% chance for enemies to drop an {{ffObject}} object on kill",
			"Drops an {{ffObject}} object when destroyed"
		},
		CarBattery = false,
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_8] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{ffObject}} Spawns 1 object on pickup",
			"{{ffObject}} Triggers the effect of the object Isaac holds without using it"
		},
		Virtues = {
			"15% chance for enemies to drop an {{ffObject}} object on kill",
			"Drops an {{ffObject}} object when destroyed"
		},
		CarBattery = false,
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_12] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{ffObject}} Spawns 1 object on pickup",
			"{{ffObject}} Triggers the effect of the object Isaac holds without using it"
		},
		Virtues = {
			"15% chance for enemies to drop an {{ffObject}} object on kill",
			"Drops an {{ffObject}} object when destroyed"
		},
		CarBattery = false,
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PAGE_OF_VIRTUES] = {
		_descType = "collectible",
		Name = "미덕의 페이지",
		QuoteDesc = "진실은 너의 운명 속에",
		Description = [[
			획득 시 랜덤 불꽃을 소환합니다.
			이 불꽃이 꺼지면 새로운 랜덤 불꽃을 소환합니다.
		]],
		Tests = {
			"Gives two random wisps",
			"Whenever one of these wisps is destroyed, grants you a new random wisp"
		},
		AbyssSpecial = {
			"2 locusts (0.5x Isaac's damage)"
		},
		AbyssTests = {
			"25% chance to Burn enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BRIDGE_BOMBS] = {
		_descType = "collectible",
		Name = "징검다리 폭탄",
		QuoteDesc = "구덩이를 채우는 폭발 + 폭탄 5개",
		Description = [[
			{{Bomb}} 폭탄 +5
			폭탄이 터질 때 주변의 구덩이를 메웁니다.
		]],
		Tests = {
			"{{Bomb}} +5 Bombs",
			"Bombs fill pits when they explode"
		},
		AbyssTests = {
			"20% chance to explode"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.LAWN_DARTS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{ffHemorrhage}} 25%의 확률로 적에게 대출혈을 거는 공격이 나갑니다.
			{{LuckSmall}} 행운 15+일 때 100%
		]],
		Tests = {
			"25% chance to fire tears that inflict enemies with Hemorrhage",
			"{{Luck}} 100% chance at 15 luck"
		},
		AppendEntries = {
			"FF_APPEND_HEMORRHAGE",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.HEMORRHAGE },
		AbyssTests = {
			"20% chance to inflict enemies with Hemorrhage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.TOY_PIANO] = {
		_descType = "collectible",
		Name = "장난감 피아노",
		QuoteDesc = "악마의 노래",
		Description = [[
			{{ffDoom}} 20%의 확률로 적에게 둠을 거는 공격이 나갑니다.
			{{LuckSmall}} 행운 34+일 때 100%
		]],
		Tests = {
			"20% chance to fire tears that inflict enemies with Doom",
			"{{Luck}} 100% chance at 34 luck"
		},
		AppendEntries = {
			"FF_APPEND_DOOM",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.DOOM },
		AbyssTests = {
			"20% chance to inflict enemies Doom"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.HYPNO_RING] = {
		_descType = "collectible",
		Name = "최면 링",
		QuoteDesc = "나른한 공격",
		Description = [[
			{{ffSleeping}} 20%의 확률로 적을 나른하게 하는 공격이 나갑니다.
			{{LuckSmall}} 행운 10+일 때 33%
		]],
		Tests = {
			"20% chance to fire tears that inflict enemies with Drowsy",
			"{{Luck}} 33% chance at 10 luck"
		},
		AppendEntries = {
			"FF_APPEND_DROWSY",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.DROWSY_AND_SLEEP
	 	},
		AbyssTests = {
			"20% chance to inflict enemies with Drowsy"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.MUSCA] = {
		_descType = "collectible",
		Name = "파리자리",
		QuoteDesc = "파리가 담긴 폭발 + 폭탄 3개",
		Description = [[
			{{Bomb}} 폭탄 +3
			폭탄이 터질 때 랜덤 자폭 파리 3마리가 나옵니다.
			적 처치 시 확률적으로 랜덤 자폭 파리가 나옵니다.
			{{LuckSmall}} 행운 113+일 때 100%
		]],
		Tests = {
			"{{Bomb}} +3 Bombs",
			"Bombs spawn three random locusts when they explode",
			"Enemies not killed by locusts have a luck-based chance to spawn a random locust on death",
			"{{Luck}} 100% chance at 113 luck"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.MODEL_ROCKET] = {
		_descType = "collectible",
		Name = "로켓 모형",
		QuoteDesc = "추진 공격",
		Description = [[
			↑ {{RangeSmall}}사거리 +1.5
			↑ {{ShotspeedSmall}}탄속 배율 x2
			눈물이 멈춘 상태에서 발사되며 탄속이 서서히 증가합니다.
			눈물의 탄속에 비례하여 적에게 추가 피해를 줍니다.
		]],
		Tests = {
			"↑ x2 Shot speed",
			"↑ +1.5 Range",
			"Tears accelerate up from zero movement speed to normal movement speed on firing",
			"{{Damage}} Tears deal bonus damage based on their movement speed upon impact"
		},
		AbyssTests = {
			"Locust accelerates up from zero movement speed to very fast"
		},
		AbyssSpecial = {
			"1 locust (1.5x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SIBLING_SYL] = {
		_descType = "collectible",
		Name = "실",
		QuoteDesc = "영원한 친구",
		Description = [[
			공격하는 방향으로 공격력 4.75의 눈물을 발사합니다.
		]],
		Tests = {
			"Shoots normal tears",
			"Deals 4.75 damage per tear"
		},
		BFFS = { 4.75, 9.50 },
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.WRONG_WARP] = {
		_descType = "collectible",
		Name = "엉뚱한 워프",
		QuoteDesc = "시퀀스 브레이크",
		Description = [[
			!!! 일회용 !!!
			!!! 사용 시 랜덤 스테이지로 순간이동합니다.
		]],
		Tests = {
			"{{Warning}} SINGLE USE {{Warning}}",
			"On use, teleports you to a random floor"
		},
		CarBattery = false,
		AbyssSpecial = {
			"1 erratic moving locust (1.5x Isaac's damage)"
		},
		Virtues = {
			"Wisp that regenerates when extinguished"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GREG_THE_EGG] = {
		_descType = "collectible",
		Name = "달걀 그레그",
		QuoteDesc = "서프라이즈로 가득찬 알",
		Description = [[
			방 안을 돌아다니며 적의 탄환을 막아줍니다.
			방 클리어 시 35%의 확률로 픽업을 소환합니다.
			!!! 적의 탄환을 막으면 일정 확률로 달걀이 깨져 사라지며 랜덤 패밀리어를 드랍합니다.
		]],
		Tests = {
			"Familiar that has a 35% chance to drop a pickup after clearing a room",
			"After being shot by enough projectiles, Greg has a chance to crack and spawn another familiar",
			"{{Warning}} Greg gets removed from your inventory when cracked"
		},
		BFFS = false,
		AbyssSpecial = {
			"1 slow locust (1x Isaac's damage)"
		},
		AbyssTests = {
			"Blocks enemy shots"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.FAMILIAR_FLY] = {
		_descType = "collectible",
		Name = "뭔가 익숙한 그 파리",
		QuoteDesc = "많은 이들에게 사랑받았지",
		Description = [[
			캐릭터의 주변을 돌며 적과 접촉 시 초당 30의 피해를 줍니다.
			{{Charm}} 주변의 파리류 적에 매혹을 겁니다.
			적과 오랫동안 접촉 시 폭발, 8방향으로 눈물을 발사하며 적에게 3.5의 매혹 피해를 줍니다.
		]],
		Tests = {
			"Orbiting boom fly familiar that does 30 damage a second",
			"Will explode and later respawn when close to enemies for long enough",
			"{{Charm}} Explosion releases 10 charming tears that do 3.5 damage",
			"{{Charm}} Can charm flies",
		},
		BFFS = {30, 60, 3.5, 7},
		AbyssTests = {
			"10% chance to charm enemies"
		},
		AbyssSpecial = {
			"1 big locust (1x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.MONAS_HIEROGLYPHICA] = {
		_descType = "collectible",
		Name = "모나스 상형 문자",
		QuoteDesc = "하나가 된 우주",
		Description = [[
			{{Planetarium}} 스테이지마다 랜덤한 천체관 아이템의 효과를 가집니다.
		]],
		Tests = {
			"{{Planetarium}} Gives you a random Planetarium item effect every floor"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CYANIDE_DEADLY_DOSE] = {
		_descType = "collectible",
		Name = "과다투약",
		QuoteDesc = "치사성 초강력 알약",
		Description = [[
			{{Pill}} 획득 시 Cyanide 알약을 드랍합니다.
			{{Pill}} 해당 게임에서 Cyanide 알약이 등장할 수 있습니다.
			!!! Cyanide 알약은 발동되는 동안 모든 능력치가 증가하나 사용 후 다른 알약을 사용하지 않으면 1분 후 사망합니다.
		]],
		Tests = {
			"Cyanide pills can now frequently spawn alongside pickups",
			"{{Warning}} Cyanide pills give Isaac a big stat boost, but can kill him after 60 seconds",
			"{{Pill}} Spawns a Cyanide pill"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GOLDEN_PLUM_FLUTE] = {
		_descType = "collectible",
		Name = "황금 플럼 피리",
		QuoteDesc = "플레이 타임!",
		Description = [[
			{{Timer}}사용 시 10초 동안 아군 Golden Baby Plum 보스를 소환합니다.
		]],
		Tests = {
			"{{Timer}} Summons a friendly Golden Baby Plum in the room for 10 seconds"
		},
		CarBattery = {"소환합니다", "2마리{{CR}} 소환합니다"},
		Virtues = {
			"When Golden Baby Plum bounces diagonally, all Golden Plum Flute wisps are invincible and do so as well"
		},
	},
	--[[ [ITEM..FiendFolio.ITEM.COLLECTIBLE.DOGBOARD] = {
	}, ]]
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DADS_POSTICHE] = {
		_descType = "collectible",
		Name = "아빠의 가발",
		QuoteDesc = "머리가 가려워...",
		Description = [[
			↑ {{ffMorbidHeart}}종양하트 +1
			공격 시 5%의 확률로 아군 자폭 벼룩을 소환합니다.
			{{LuckSmall}} 행운 10+일 때 100%, {{ffMorbidHeart}} 소지 시 소환 확률 증가
		]],
		Tests = {
			"{{ffMorbidHeart}} +1 Morbid Heart",
			"5% chance to spawn blue skuzzes when shooting tears",
			"{{Luck}} 100% chance at 10 luck",
			"Blue Skuzzes are friendly creatures that hop towards nearby enemies and do 3x Isaac's damage",
			"{{ffMorbidHeart}} Morbid hearts have a slightly higher chance to appear"
		},
		AppendEntries = {
			"FF_APPEND_SKUZZES",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.EXCELSIOR] = {
		_descType = "collectible",
		Name = "더 높이!",
		QuoteDesc = "폭발성 액티브 아이템",
		Description = [[
			액티브 아이템 사용 시 유도성 로켓을 여러 발 발사합니다.
			유도성 로켓의 발사 수량과 공격력은 사용한 액티브 아이템의 최대 충전량에 비례합니다.
		]],
		Tests = {
			"{{Battery}} Active items when used will shoot fireworks, based on the amount of item charge"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GRIDDLED_CORN] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ {{BlackHeart}}블랙하트 +1
			↑ {{DamageSmall}}공격력 +0.3
			{{ffSpicyKey}} 매운열쇠를 드랍합니다.
		]],
		Tests = {
			"↑ +0.3 Damage",
			"{{HalfBlackHeart}} +1 Half Black Heart",
			"{{ffSpicyKey}} Drops a Spicy Key",
			"{{Charm}} Spawns 3 friendly Coal Spiders on pickup"
		},
		AppendEntries = {
			"FF_APPEND_SPICY_KEY",
		},
		AbyssTests = {
			"25% chance to Burn enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ETERNAL_D10] = {
		_descType = "collectible",
		Name = "이터널 D10",
		QuoteDesc = "???",
		Description = [[
			사용 시 방 안의 모든 적을 바꾸며 33%의 확률로 적이 사라집니다.
		]],
		Tests = {
			"Rerolls enemies in the current room",
			"Enemies have a 33% chance to disappear",
		},
		CarBattery = false,
		AbyssTests = {
			"20% chance to devolve enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.TOY_CAMERA] = {
		_descType = "collectible",
		Name = "장난감 카메라",
		QuoteDesc = "사진작가 전문",
		Description = [[
			사용 후 공격방향으로 사진을 촬영합니다.
			{{TearsSmall}} 캐릭터 촬영 시 증발성 연사가 대폭 증가합니다.
			촬영 범위에 있는 적에게 혼란을 걸며 탄환을 없앱니다.
			한번에 적을 4마리 이상 촬영 시 {{Card]]..FiendFolio.ITEM.CARD.COOL_PHOTO..[[}}Cool Photo를 드랍합니다. (방당 1회)
		]],
		Tests = {
			"Create a camera flash that destroys projectiles and stuns enemies",
			"{{Tears}} Grants a temporary tears up when you flash yourself",
			"If enough enemies are caught, spawns a Cool Photo",
		},
		Belial = "촬영한 적에게 캐릭터의 공격력만큼 추가 피해를 줍니다.",
		CarBattery = "가까운 위치에 촬영을 한 번 더 합니다.",
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.HAPPYHEAD_AXE] = {
		_descType = "collectible",
		Name = "칼데아 도끼",
		QuoteDesc = "쓸어버려!",
		Description = [[
			주기적으로 가장 가까운 적을 향해 사거리가 짧은 도끼를 던집니다.
			도끼는 던진 방향의 반대방향으로 되돌아갑니다.
		]],
		Tests = {
			"Periodically fires a piercing axe towards the closest enemy",
			"The axe boomerangs back shortly after launch"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.THE_BROWN_HORN] = { -- TODO
		_descType = "collectible",
		Name = "똥을 부르는 나팔",
		QuoteDesc = "하나의 우주",
		Description = [[
			사용 시 방 안의 적 및 dip 패밀리어가 설사하게 만듭니다.
			설사하는 동안 설사포를 발사해 캐릭터의 반대방향으로 밀어내고 아군 dip 패밀리어를 소환합니다.
		]],
		Tests = {
			"Causes all enemies to defecate violently, confusing them while pushing them away from Isaac",
			"{{Collectible576}} When used, spawns friendly Dip familiars",
			"Certain enemies have unique interactions when using Brown Horn"
		},
		--[[ CarBattery = {
			Tests = {
				"Doubles duration of defecation",
				"Enemies spawn 1 more friendly dip",
			},
		}, ]]
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PENNY_ROLL] = {
		_descType = "collectible",
		Name = "페니 롤",
		QuoteDesc = "용돈",
		Description = [[
			{{Coin}} 획득 시 페니류 장신구, 황금동전, 랜덤 동전 4개를 드랍합니다.
		]],
		Tests = {
			"{{Coin}} Spawns a penny trinket, a Golden Penny and 4 random pennies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.EVIL_STICKER] = {
		_descType = "collectible",
		Name = "악마 스티커",
		QuoteDesc = "위험한 픽업",
		Description = [[
			{{ffCursedPenny}} 획득 시 저주페니 6개를 드랍합니다.
			!!! 저주받은 픽업의 등장 확률이 증가합니다.
		]],
		Tests = {
			"Increases the chance for cursed pickups to spawn",
			"{{ffCursedPenny}} Spawns 6 Cursed Pennies",
		},
		AppendEntries = {
			"FF_APPEND_CURSED_PENNY",
			"FF_APPEND_COPPER_BOMB",
			"FF_APPEND_SPICY_KEY",
			"FF_APPEND_IMMORAL_HEART",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.WIMPY_BRO] = {
		_descType = "collectible",
		Name = "겁쟁이 동생",
		QuoteDesc = "하핫 위이이이!",
		Description = [[
			적을 향해 짧은 거리를 도약하며 착지한 위치의 적에게 5의 피해를 줍니다.
		]],
		Tests = {
			"Slammer familiar that jumps on and crushes enemies",
		},
		BFFS = {5, 10},
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ETERNAL_CLICKER] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
			사용 시 가장 최근에 획득한 패시브 아이템을 제거하고 캐릭터를 랜덤하게 바꾸며;
			!!! {{ColorRed}}50%의 확률로 캐릭터가 사라집니다.
		]],
		Tests = {
			"50% chance to change your character to another character",
			"Removes the most recent item collected"
		},
		Virtues = {
			"Spawns a random wisp",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ROBOBABY3] = {
		_descType = "collectible",
		Name = "로보 아기 3.0",
		QuoteDesc = "이젠 하나의 예술작품",
		Description = [[
			캐릭터 이동방향의 사선으로 움직이며 적의 탄환을 막아줍니다.
			적과 접촉 시 8방향으로 공격력 3.5의 레이저를 발사합니다.
		]],
		Tests = {
			"Familiar that moves diagonally in the direction you move",
			"Can block projectiles, and fires 8 lasers doing 3.5 damage around itself when colliding with an enemy",
		},
		BFFS = { 3.5, 7 },
		AbyssTests = {
			"Electricity on hit"
		},
		AbyssSpecial = {
			"1 erratic moving locust (0.5x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SNOW_GLOBE] = {
		_descType = "collectible",
		Name = "스노 글로브",
		QuoteDesc = "돌덩이 흔들기",
		Description = [[
			사용 시 모든 장애물의 위치를 가까운 위치로 날립니다.
		]],
		Tests = {
			"Causes an earthquake that flings most grids and obstacles to a random spot nearby",
		},
		Virtues = {
			"Spawns a stationary wisp whenever a rock is broken",
		},
		Belial = "날린 장애물의 수만큼 증발성 공격력 증가",
		CarBattery = false,
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.NYX] = {
		_descType = "collectible",
		Name = "닉스",
		QuoteDesc = "투척",
		Description = [[
			공격 시 적을 향해 날아가는 유도 보석을 3개 획득합니다.
			{{ffBruise}} 유도 보석이 적과 접촉 시 멍듦 피해를 줍니다.
		]],
		Tests = {
			"Grants 3 homing gems that can be cast while attacking that sticks to enemies, inflicting damage and bruising"
		},
		AppendEntries = {
			"FF_APPEND_BRUISE",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.BRUISE },
		AbyssSpecial = {
			"3 large locusts (0.5x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.TELEBOMBS] = {
		_descType = "collectible",
		Name = "텔레폭탄",
		QuoteDesc = "폭탄이랑 자리 맞바꾸기 + 폭탄 5개",
		Description = [[
			{{Bomb}} 폭탄 +5
			타겟이 캐릭터가 지나간 길을 0.66초 후 따라갑니다.
			타겟 위치 밖에서 폭탄 설치 시 캐릭터를 타겟의 위치로 순간이동하며 설치한 폭탄은 즉시 폭발합니다.
			!!! 캐릭터가 설치한 폭탄에 면역을 갖지 않습니다.
		]],
		Tests = {
			"{{Bomb}} +5 Bombs",
			"A target follows behind you at a delay",
			"When placing a bomb, Isaac teleports back to the marker, and the bomb instantly explodes"
		},
		AbyssTests = {
			"20% chance to explode"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DICE_GOBLIN] = {
		_descType = "collectible",
		Name = "주사위 고블린",
		QuoteDesc = "오브젝트 수집가",
		Description = [[
			{{ffObject}} 획득 시 랜덤 오브젝트 픽업을 3개 드랍합니다.
			{{ffObject}} 스테이지 진입 시 랜덤 오브젝트 픽업을 하나 드랍합니다.
		]],
		Tests = {
			"Spawns 3 random objects on pickup",
			"Spawns 1 object at the start of every floor",
			"{{ffObject}} Objects are consumable pickups that don't fall into the same category as pills, cards, and runes"
		},
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CHERRY_BOMB] = {
		_descType = "collectible",
		Name = "체리 폭탄",
		QuoteDesc = "작은 폭발",
		Description = [[
			사용 시 잠시 후 폭발하는 작은 폭탄을 듭니다.
			작은 폭탄은 장애물을 부술 수 없고 폭발 크기가 작으나 캐릭터에게 피해를 주지 않습니다.
		]],
		Tests = {
			"On use, Isaac picks up a cherry bomb that can be thrown to hurt enemies",
			"The bombs can't break rocks or hurt Isaac"
		},
		Virtues = {
			"Wisp blows up when a cherry bomb blows up"
		},
		Belial = "{{Collectible684}} 작은 폭탄이 유령 폭발을 일으킵니다.",
		CarBattery = "작은 폭탄이 캐릭터의 위치에 추가로 설치됩니다.",
		AbyssTests = {
			"10% chance to explode"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ASTROPULVIS] = {
		_descType = "collectible",
		Name = "아스트로풀비스",
		QuoteDesc = "초신성",
		Description = [[
			사용 시 가장 가까운 장애물을 파괴하여 거대한 붉은 귀신으로 만듭니다.
			붉은 귀신이 있는 상태에서 재사용 시 붉은 귀신이 폭파되며 주변의 적에게 피해를 줍니다.
		]],
		Tests = {
			"On use, destroys the closest rock and turns it into a large ghost",
			"Using the active again will detonate all large ghosts in the room"
		},
		Virtues = {
			"Only one wisp can be spawned",
			"Wisp detonates when an active item is used to blow up a ghost"
		},
		Belial = { -- TODO
			"Detonated ghosts create a ring of 3 smaller explosions that scale with Judas's damage"
		},
		CarBattery = false,
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SPINDLE] = {
		_descType = "collectible",
		Name = "스핀들",
		QuoteDesc = "더 많은 디스크!",
		Description = [[
			{{ffDisc}} 획득 시 디스크를 3장 드랍합니다.
			{{Timer}} 디스크류 픽업은 사용 시 랜덤 아이템의 효과를 1분간 부여합니다.
			{{BossRoom}} 보스방 진입 시 디스크류 아이템 하나를 드랍합니다.
		]],
		Tests = {
			"{{ffDisc}} Spawns 3 Discs",
			"{{Timer}} Discs grant the effects of a few random passive items for 1 minute",
			"{{BossRoom}} Spawns a Disc when entering a Boss Room"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.AZURITE_SPINDOWN] = {
		_descType = "collectible",
		Name = "아주라이트 스핀다운",
		QuoteDesc = "-1",
		Description = [[
			{{Trinket}} 사용 시 방 안의 모든 장신구를 코드 앞번호의 장신구로 바꿉니다.
		]],
		Tests = {
			"{{Trinket}} Rerolls all trinkets in the room by decreasing their internal ID number by one"
		},
		CarBattery = {"앞번호", "앞 2개 번호"},
		AbyssTests = {
			"20% chance to devolve enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.KING_WORM] = {
		_descType = "collectible",
		Name = "벌레 왕",
		QuoteDesc = "일시적 벌레의 힘",
		Description = [[
			사용 시 그 방에서 랜덤 벌레 장신구 효과를 얻습니다.
		]],
		Tests = {
			"Grants the effect of 1 random worm trinket for the current room"
		},
		Virtues = {
			"Wisps inherit your worm trinket effect"
		},
		VirtuesSingleRoom = true,
		CarBattery = {"랜덤", "2개의{{CR}} 랜덤"},
		AbyssTests = {
			"Wiggles while charging"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DEVILS_DAGGER] = {
		_descType = "collectible",
		Name = "악마의 단검",
		QuoteDesc = "서두름이 곧 힘",
		Description = [[
			공격방향으로 단검을 추가로 발사합니다.
			적 처치 시 단검을 강화시킬 수 있는 보석을 드랍합니다.
			단검의 강화 단계는 스테이지 진입 시 초기화됩니다.
		]],
		Tests = {
			"Isaac fires daggers alongside his tears",
			"Enemies drop gems when killed that can power up Isaac's daggers",
			"The power of Isaac's daggers reset when entering a new floor"
		},
		AbyssTests = {
			"33% chance to Burn enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.STRANGE_RED_OBJECT] = {
		_descType = "collectible",
		Name = "수상한 빨간 물체",
		QuoteDesc = "자연스럽게 빛나고 있어",
		Description = [[
			↑ {{Heart}}최대 체력 +1
			↑ {{SpeedSmall}}이동속도 +0.05
			↑ {{DamageSmall}}공격력 +0.3
			↑ {{LuckSmall}}행운 +2
		]],
		Tests = {
			"↑ +1 Health",
			"↑ +0.3 Damage",
			"↑ +0.05 Speed",
			"↑ +2 Luck"
		},
		AbyssSpecial = {
			"1 slightly faster locust (1x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.D3] = {
		_descType = "collectible",
		Name = "3면 주사위",
		QuoteDesc = "눈물을 바꾸다",
		Description = [[
			캐릭터 주위를 돌며 통과한 눈물을 다른 눈물로 바꿉니다.
		]],
		Tests = {
			"Orbital familiar that rerolls tears",
			"{{Warning}} Wacky"
		},
		BFFS = false,
		AbyssTests = {
			"30% chance to devolve enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.EMOJI_GLASSES] = {
		_descType = "collectible",
		Name = "이모지 안경",
		QuoteDesc = "이거, 켜져 있어",
		Description = [[
			3개의 이모지 모양의 눈물을 번갈아 발사합니다.
			이모지에 따라 다른 눈물 효과가 적용됩니다.
		]],
		Tests = {
			"Isaac's tears turn into Emojis that each have a unique effect"
		},
		AbyssTests = {
			"Fires tears while charging that deal 10% Isaac's damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SACK_OF_SPICY] = {
		_descType = "collectible",
		Name = "매운 자루",
		QuoteDesc = "주머니가 뜨거워",
		Description = [[
			{{ffSpicyKey}} 방 7개 클리어 시 매운열쇠를 드랍합니다.
		]],
		Tests = {
			"{{ffSpicyKey}} Spawns a set of Spicy Keys every 7 rooms"
		},
		AppendEntries = {
			"FF_APPEND_SPICY_KEY",
		},
		BFFS = {"매운열쇠", "+1 매운열쇠"},
		AbyssTests = {
			"Inflicts Burns"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.HEART_OF_CHINA] = { -- TODO
		_descType = "collectible",
		Name = "차이나의 심장",
		QuoteDesc = "취급주의",
		Description = [[
			체력이 없거나 꽉 찬 상태에서 빨간하트 습득 시 특수 체력 게이지가 채워집니다.
			특수 체력 게이지 완충 시 {{EmptyHeart}}빈 최대 체력 +1 증가
			특수 체력 게이지의 총량은 현재 소지 중인 최대 체력에 비례하며;
			{{ButtonRT}}버튼을 꾹 누르거나 빨간하트 근처에 있을 때 캐릭터 위에 표시됩니다.
		]],
		Tests = {
			"↑ +1 Health",
			"{{Heart}} Overhealing charges a secondary health bar",
			"{{EmptyHeart}} Filling this bar grants an empty heart container",
			"The number of slots in the secondary bar scales with how many heart containers you have",
			"This health bar can be viewed by viewing the map"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DEVILS_ABACUS] = {
		_descType = "collectible",
		Name = "악마의 주판",
		QuoteDesc = "숫자 세는 법을 배우자",
		Description = [[
			1개부터 시작하며 숫자의 개수만큼 눈물을 발사한 수만큼 발사 후 공격키를 떼면 {{DamageSmall}}공격력과 {{TearsSmall}}연사가 증가합니다.
			단계가 증가할 때마다 발사해야 되는 눈물의 수가 하나씩 증가합니다.
			공격키를 뗄 때 눈물의 개수가 맞지 않으면 증가량이 초기화됩니다.
		]],
		Tests = {
			"{{Damage}} Count with your tears for an increasing damage and tears up for the room",
			"{{Tears}} Counting counts as firing a certain amount of tears and stopping",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DAZZLING_SLOT] = {
		_descType = "collectible",
		Name = "빛나는 슬롯머신",
		QuoteDesc = "탐욕에 솔직해지자",
		Description = [[
			{{Coin}} 동전 5개를 소모하여 랜덤 적 하나를 황금 슬롯머신으로 바꿉니다.
			바뀐 슬롯머신은 확률적으로 보상을 드랍하고 사라집니다.
		]],
		Tests = {
			"{{Coin}} Spend 5 coins to turn an enemy into a one use Golden Slot Machine"
		},
		CarBattery = false,
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.KALUS_HEAD] = {
		_descType = "collectible",
		Name = "칼루의 머리",
		QuoteDesc = "무서운 가면",
		Description = [[
			사용 시 머리를 들며 공격하는 방향으로 보라빛 손전등을 비춥니다.
			{{Petrify}} 보라빛에 닿은 적은 1.1의 석화 피해를 받습니다.
			{{Petrify}} 멈춘 적 처치 시 여러 갈래의 눈물을 발사합니다.
		]],
		Tests = {
			"A dark cone of vision appears when held above Isaac's head",
			"{{Petrify}} Enemies in the cone are petrified and take a minor amount of damage",
			"{{Petrify}} Enemies killed while petrified burst into tears"
		},
		CarBattery = "석화 피해 및 지속시간 증가",
		AbyssTests = {
			"Petrifies enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.X10KACHING] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "동전 10개",
		Description = [[
			{{Coin}} 동전 +10
		]],
		Tests = {
			"{{Coin}} +10 Coins"
		},
		AbyssSpecial = {
			"10 locusts (x0.05 Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.X10BATOOMKLING] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "열쇠 10개",
		Description = [[
			{{Key}} 열쇠 +10
		]],
		Tests = {
			"{{Key}} +10 Keys"
		},
		AbyssSpecial = {
			"10 locusts (x0.075 Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.X10BADUMP] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "하트 10개",
		Description = [[
			{{Heart}} 빨간하트 +10(최대 체력 없음)
		]],
		Tests = {
			"{{Heart}} +10 Hearts"
		},
		AbyssSpecial = {
			"10 locusts (x0.05 Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.X10BZZT] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "배터리 10개",
		Description = [[
			{{Battery}} 액티브 아이템 충전량 +10
		]],
		Tests = {
			"{{Battery}} +10 Pips of charge"
		},
		AbyssSpecial = {
			"10 locusts (x0.05 Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.X10CHOMPCHOMP] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "그리즐 소시지 10개",
		Description = [[
			{{Coin}} 동전 +1
			↑ {{Heart}}최대 체력 +5
			↑ {{EmptyHeart}}빈 최대 체력 +5
			↑ {{SpeedSmall}}이동속도 +1
			↑ {{TearsSmall}}연사 +1
			↑ {{DamageSmall}}공격력 +1
			↑ {{RangeSmall}}사거리 +1
			↑ {{ShotspeedSmall}}탄속 +1
			↑ {{LuckSmall}}행운 +1
		]],
		Tests = {
			"{{Collectible" .. FiendFolio.ITEM.COLLECTIBLE.GLIZZY .. "}} +10 Glizzies"
		},
		AbyssSpecial = {
			"10 slightly fast and bigger locusts (x0.2 Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.INFINITY_VOLT] = {
		_descType = "collectible",
		Name = "무한 볼트",
		QuoteDesc = "더블탭 콘센트",
		Description = [[
			공격키를 두번 눌러 적에게 콘센트를 꼽습니다.
			콘센트에 꽃힌 적은 과부하 상태에 걸리며 오랫동안 꽂고 있으면 적이 폭발합니다.
		]],
		Tests = {
			"Double tap to link to an enemy",
			"Linked enemies are overloaded and explode"
		},
		AppendEntries = {
			"FF_APPEND_OVERLOADED",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.OVERLOADED },
		AbyssTests = {
			"Fires a continuous laser when charging"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.RAT_POISON] = {
		_descType = "collectible",
		Name = "쥐약",
		QuoteDesc = "전부 건너뛰기",
		Description = [[
			특정 방 제작자가 명시되어 있는 방에서 사용 시 해당 게임에서 그 방 제작자가 제작한 모든 방에 있는 존재를 지웁니다.
			방 제작자는 UI 하단에서 확인할 수 있습니다.
		]],
		Tests = {
			"{{Warning}} When used in a room with a visible creator, all future rooms by that person will be removed from the run, including rewards",
			"Room names and the creator are shown at the bottom of the screen if the option in the Dead Sea Scrolls menu is enabled"
		},
		CarBattery = false,
		AbyssTests = {
			"1% chance to erase an enemy for the rest of the run"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ANGELIC_LYRE_B] = {
		_descType = "collectible",
		Name = "천국의 리라",
		QuoteDesc = "색다른 음색 연주",
		Description = [[
			소지 시 리라의 색상에 따라 다른 효과의 눈물을 발사합니다.
			사용 시 리라의 현재 색상을 바꿉니다.
			{{ColorBlue}}파랑{{CR}}: 
			{{Blank}} {{SpeedSmall}}+0.2/{{TearsSmall}}x1.3/{{LuckSmall}}+3
			{{Blank}} {{ShotspeedSmall}}-0.2
			눈물을 1발 > 3발 > 0발을 번갈아가며 발사합니다.
		]],
		Tests = {
			"{{Tears}} Can be used to change into a unique tear mode with upsides and downsides",
			"Resets tear delay on use",
			"↑ x1.3 Fire rate multiplier",
			"↑ +0.2 Speed",
			"↑ +3 Luck",
			"↓ -0.2 Shot speed",
			"Isaac's tears are fired in a 3-step cycling sequence"
		},
		CarBattery = false,
		AbyssSpecial = {
			"1 fast locust (0.75x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ANGELIC_LYRE_R] = {
		_descType = "collectible",
		Name = "천국의 리라",
		QuoteDesc = "색다른 음색 연주",
		Description = [[
			소지 시 리라의 색상에 따라 다른 효과의 눈물을 발사합니다.
			사용 시 리라의 현재 색상을 바꿉니다.
			{{ColorRed}}빨강{{CR}}: 
			{{Blank}} {{DamageSmall}}x2
			{{Blank}} {{TearsSmall}}x0.18
			공격이 4발로 나가며 지형을 관통합니다.
		]],
		Tests = {
			"{{Tears}} Can be used to change into a unique tear mode with upsides and downsides",
			"Resets tear delay on use",
			"↑ x2 Damage multiplier",
			"↓ x0.18 Fire rate multiplier",
			"Lets Isaac fire 4 spectral tears"
		},
		CarBattery = false,
		AbyssSpecial = {
			"1 slow locust (1.5x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ANGELIC_LYRE_Y] = {
		_descType = "collectible",
		Name = "천국의 리라",
		QuoteDesc = "색다른 음색 연주",
		Description = [[
			소지 시 리라의 색상에 따라 다른 효과의 눈물을 발사합니다.
			사용 시 리라의 현재 색상을 바꿉니다.
			{{ColorYellow}}노랑{{CR}}: 
			{{Blank}} {{TearsSmall}}x4.4/{{RangeSmall}}+2.5
			{{Blank}} {{DamageSmall}}x0.2 
			유도 눈물을 10발 연속 발사하며 이후 잠시동안 공격을 멈춥니다.
			연사가 높을수록 공격을 멈추는 시간이 짧아집니다.
		]],
		Tests = {
			"{{Tears}} Can be used to change into a unique tear mode with upsides and downsides",
			"Resets tear delay on use",
			"↓ x0.2 Damage multiplier",
			"↑ x4.4 Fire rate multiplier",
			"↑ +2.5 Range",
			"Homing tears",
			"Isaac fires a barrage of 10 tears, stops, and then continues"
		},
		CarBattery = false,
		AbyssSpecial = {
			"1 very fast locust (0.5x Isaac's damage)"
		},
		AbyssTests = {
			"Homing"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.HORSE_PASTE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
			!!! ]]..FiendFolio.DescriptionIcons.China..[[ China 전용
			{{BrokenHeart}} 사용 시 부서진하트 -1
		]],
		Tests = {
			"{{BrokenHeart}} Heals 1 Broken Heart",
			FiendFolio.DescriptionIcons.China .. "Granted only by China's birthright"
		},
		CarBattery = { 1, 2 },
		Virtues = {
			"{{Slow}} Wisp tears inflict Slowness"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.LEMON_MISHUH] = {
		_descType = "collectible",
		Name = "레몬빛 실수?",
		QuoteDesc = "사고 나기 전에 던지기",
		Description = [[
			{{Collectible56}} 공격방향으로 레몬을 던집니다.
			투척한 자리에 노란 장판이 생성되며 장판에 닿은 적은 초당 24의 피해를 입습니다.
		]],
		Tests = {
			"{{Collectible56}} A throwable Lemon Mishap",
			"Spills a pool of creep",
			"The creep deals 24 contact damage per second",
			"Creep persists until you exit the room"
		},
		Virtues = {
			"Rapid, low range tears",
			"Wisp drips yellow creep",
		},
		CarBattery = {"던집니다", "2개{{CR}} 던집니다"},
		AbyssTests = {
			"50% chance to spawn yellow creep when dealing damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.MIME_DEGREE] = {
		_descType = "collectible",
		Name = "익살스러운 학위",
		QuoteDesc = "...",
		Description = [[
			적 및 탄환이 지나갈 수 없는 흰색 블럭을 소환합니다.
			캐릭터가 흰색 블럭 접촉 시 해당 블럭을 랜덤 위치에 재배치합니다.
		]],
		Tests = {
			"Summons 3-5 mime blocks in the room that enemies cannot pass through",
			"Touch the block to relocate it"
		},
		AbyssTests = {
			"Invisible"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CRAZY_JACKPOT] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
			피격 시 확률적으로 아래 효과 중 하나를 발동합니다:
			{{IND}} {{Coin}} 동전 1~2개
			{{IND}} {{Heart}} 잠시 후 사라지는 하트
			{{IND}} 그 방에서 {{DamageSmall}}공격력/{{TearsSmall}}연사/{{LuckSmall}}행운 증가
			{{IND}} 주변의 적에게 캐릭터의 공격력 x5만큼 피해
			{{IND}} {{Collectible56}} 노란 장판 생성
			{{LuckSmall}} 행운 10+일 때 100%
		]],
		Tests = {
			"On hit, Isaac rolls for a unique effect",
			"{{Luck}} 100% chance to get three matching symbols at 10 luck"
		},
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.NIL_PASTA] = {
		_descType = "collectible",
		Name = "nil 파스타",
		QuoteDesc = "스파게티 코드",
		Description = [[
			사용 시 랜덤 방향으로 짧은 스파게티 줄을 여러개 발사합니다.
			스파게티 줄에 닿은 적은 일부 행동이 불가능해집니다.
		]],
		Tests = {
			"Captures nearby enemies with spaghetti ropes to hold them in place",
			"Pulling out the spaghetti causes enemies to become glitched, periodically disabling their AI"
		},
		CarBattery = "스파게티 줄 발사 수 2배",
		Virtues = {
			"{{Petrify}} 20% chance to petrify enemies",
			"Lags behind" --idk
		},
		AbyssTests = {
			"3% chance to make enemies become glitched"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CLUTCHS_CURSE] = {
		_descType = "collectible",
		Name = "클러치의 저주",
		QuoteDesc = "만약 보라빛이였다면?",
		Description = [[
			주기적으로 캐릭터에게 빙의합니다.
			{{Collectible149}} 캐릭터에게 빙의했을 때 다음 공격이 유도성 폭발 공격으로 바꿉니다.
			방 입장 시 일부 돌덩이가 보라빛으로 빛나며 보랏빛 돌 파괴 시 십자 모양으로 불길을 내뿜습니다.
			!!! 불길은 캐릭터에게도 피해를 줍니다.
		]],
		Tests = {
			"Familiar that possesses Isaac occasionally",
			"When possessed, Isaac can fire a homing explosive tear that scales with his damage",
			"{{Warning}} Rocks occasionally glow purple and shoot fire on destruction that hurt Isaac",
		},
		BFFS = "구토제 피해량 2배",
		AbyssTests = {
			"Homing locust"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PET_PEEVE] = {
		_descType = "collectible",
		Name = "짜증나는 펫",
		QuoteDesc = "더블탭 가시돌이",
		Description = [[
			방을 느리게 돌아다니며 접촉한 적에게 피해를 줍니다.
			공격키를 두번 누르면 즉시 공격방향으로 돌진합니다.
		]],
		Tests = {
			"Grudge familiar that moves around like a Poky",
			"Charges on double tap",
		},
		BFFS = "피해량 2배",
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.MOMS_STOCKINGS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ {{RangeSmall}}사거리 +2.5
			아군 자폭 벼룩을 3~9마리 소환합니다.
		]],
		Tests = {
			"↑ +2.5 Range",
			"Spawns 3-9 blue skuzzes",
			"Blue Skuzzes are friendly creatures that hop towards nearby enemies and do 3x Isaac's damage"
		},
		AppendEntries = {
			"FF_APPEND_SKUZZES"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GOLDEN_POPSICLE] = {
		_descType = "collectible",
		Name = "황금 아이스크림",
		QuoteDesc = "행운 증가",
		Description = [[
			↑ {{SoulHeart}}소울하트 +1
			↑ {{LuckSmall}}행운 +1
			황금 픽업 아이템 하나를 드랍합니다.
		]],
		Tests = {
			"{{SoulHeart}} +1 Soul Heart",
			"{{Luck}} +1 Luck",
			"Spawns a random golden pickup"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.TIME_ITSELF] = {
		_descType = "collectible",
		Name = "시간 그 자체",
		QuoteDesc = "다중 유클리드 눈물",
		Description = [[
			{{ffMultieuclidean}} 25%의 확률로 적에게 기하 상태를 거는 공격이 나갑니다.
			{{LuckSmall}} 행운 15+일 때 100%
		]],
		Tests = {
			"25% chance to fire multi-euclidean tears",
			"{{Luck}} 100% chance at 15 luck"
		},
		AppendEntries = {
			"FF_APPEND_MULTIEUCLIDEAN",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.MULTIEUCLIDEAN
		},
		AbyssTests = {
			"20% to inflict an enemy with multi-euclidean",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.HORNCOB] = {
		_descType = "collectible",
		Name = "뿔 달린 옥수수",
		QuoteDesc = "뿌린 대로 거두는 법",
		Description = [[
			{{Pill}} 적 처치 시 25% 확률로 랜덤 알약을 강제로 사용합니다.
			{{LuckSmall}} 행운 15+일 때 100%
		]],
		Tests = {
			"25% chance to take a random pill when you kill an enemy",
			"{{Luck}} 100% chance at 15 luck"
		},
		AbyssTests = {
			"10% chance to use a pill when killing an enemy"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.EMPTY_BOOK] = {
		_descType = "collectible",
		Name = "빈 공책",
		QuoteDesc = "나만의 이야기를 쓰자!",
		Description = [[
			사용 시 이야기를 작성합니다.
			작성한 이야기에 따라 쿨타임 및 효과가 달라집니다.
		]],
		Tests = {
			"Customizable active item",
			"Does a variety of effects depending on what you choose"
		},
		CarBattery = "작성한 이야기의 효과 2배",
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.HOST_ON_TOAST] = {
		_descType = "collectible",
		Name = "호스트 토스트",
		QuoteDesc = "공격력, 사거리 증가",
		Description = [[
			↑ {{DamageSmall}}공격력 +0.5
			↑ {{RangeSmall}}사거리 +1.5
		]],
		Tests = {
			"↑ +0.5 Damage",
			"↑ +1.5 Range"
		},
		AbyssSpecial = {
			"1 fast locust (1x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BAG_OF_BOBBIES] = {
		_descType = "collectible",
		Name = "보비 가방",
		QuoteDesc = "보비가 가득!",
		Description = [[
			{{Collectible8}} 방 클리어 시 일정 확률로 Fragile Bobby를 소환합니다.
			{{Collectible8}} Fragile bobby는 Brother Bobby와 동일하나 5회 피격 시 사라집니다.
		]],
		Tests = {
			"Has a chance to spawn a Fragile Bobby on room clear",
			"{{Collectible8}} Fragile bobbies are similar to Brother Bobby but can die"
		},
		BFFS = "피해량 2배",
		AbyssSpecial = {
			"3 locusts (0.5x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BOX_TOP] = {
		_descType = "collectible",
		Name = "박스 탑",
		QuoteDesc = "행운 증가 + 적립성 상품",
		Description = [[
			↑ {{SoulHeart}}소울하트 +1
			↑ {{LuckSmall}}행운 +2
			{{Card]]..FiendFolio.ITEM.CARD.PUZZLE_PIECE..[[}} 획득 시 Puzzle Piece을 드랍합니다.
		]],
		Tests = {
			"{{SoulHeart}} +1 Soul Heart",
			"↑ +2 Luck",
			FiendFolio.DescriptionIcons.PuzzlePiece .. "Spawns a Puzzle Piece"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.KINDA_EGG] = {
		_descType = "collectible",
		Name = "이래뵈도 알",
		QuoteDesc = "체력 증가 + 삼키면 안돼!",
		Description = [[
			↑ {{Heart}}최대 체력 +1
			↑ {{Heart}}빨간하트 +1
			{{ffObject}} 획득 시 특수 오브젝트를 하나 드랍합니다.
		]],
		Tests = {
			"↑ +1 Health",
			"{{HealingRed}} Heals 1 heart",
			"{{ffObject}} Spawns a random object"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DADS_DIP] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ {{ffMorbidHeart}}종양 최대 체력 +1
		]],
		Tests = {
			"↑ +1 Health",
			"{{ffMorbidHeart}} +1 Morbid Heart",
			"Morbid Hearts take 3 hits of damage to be depleted",
			"When depleted, Morbid Hearts spawn a temporary orbital familiar"
		},
		AppendEntries = {
			"FF_APPEND_MORBID_HEART",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.YICK_HEART] = {
		_descType = "collectible",
		Name = "조용한 하트",
		QuoteDesc = "충전식 종양",
		Description = [[
			{{ffMorbidHeart}} 사용 시 종양하트 +1
		]],
		Tests = {
			"{{ffMorbidHeart}} +1 Morbid Heart",
			"Morbid Hearts take 3 hits of damage to be depleted",
			"When depleted, Morbid Hearts spawn a temporary orbital familiar"
		},
		AppendEntries = {
			"FF_APPEND_MORBID_HEART",
		},
		CarBattery = { 1, 2 },
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SMASH_TROPHY] = {
		_descType = "collectible",
		Name = "스매시 트로피",
		QuoteDesc = "승자 마리아",
		Description = [[
			↑ {{Heart}}최대 체력 +1
			↑ {{Heart}}빨간하트 +1
			↑ {{DamageSmall}}공격력 +1 
			적의 체력이 적을수록 공격이 적을 더 크게 밀쳐냅니다.
		]],
		Tests = {
			"↑ +1 Health",
			"{{HealingRed}} Heals 1 heart",
			"↑ +1 Damage",
			"Enemies receive more knockback the less health they have"
		},
		AbyssTests = {
			"Enemies receive more knockback the less health they have"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BOTTLE_OF_WATER] = {
		_descType = "collectible",
		Name = "물 한 병",
		QuoteDesc = "삼켜!",
		Description = [[
			↑ {{SoulHeart}}소울하트 +2
			{{Trinket}} 현재 소지 중인 장신구를 흡수합니다.
			{{Pill}} 알약을 하나 드랍합니다.
		]],
		Tests = {
			"{{SoulHeart}} +2 Soul Hearts",
			"{{Trinket}} Consumes Isaac's trinket and grants its effects permanently",
			"{{Pill}} Spawns a pill"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GAMMA_GLOVES] = {
		_descType = "collectible",
		Name = "감마 글러브",
		QuoteDesc = "밀쳐!",
		Description = [[
			사용 시 가까이에 있는 적을 밀쳐냅니다.
		]],
		Tests = {
			"Creates a small shockwave around Isaac, pushing nearby enemies away",
			"{{Warning}} Does not push away enemy projectiles"
		},
		Virtues = {
			"Cannot shoot tears",
			"Wisps dissipate after a second"
		},
		Belial = "넉백된 적이 벽에 피해를 받습니다",
		CarBattery = "넉백 강도 증가",
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SHREDDER] = {
		_descType = "collectible",
		Name = "파쇄기",
		QuoteDesc = "아이템 재활용",
		Description = [[
			사용 시 그 방의 아이템을 여러 개의 픽업 아이템으로 분해합니다.
			분해되는 픽업의 구성은 방 종류에 따라 달라집니다.
			{{Blank}} (드는 도중의 아이템 및 장신구도 분해)
		]],
		Tests = {
			"Destroys all item pedestals in the room and turns them into random pickups",
			"Pickups spawned from converted items varies based on the current room",
			"Items held up above Isaac's head will also be destroyed",
			"{{Trinket}} Trinkets held up above Isaac's head can be destroyed"
		},
		Virtues = {
			"Wisp only spawns whenever an item is shredded"
		},
		CarBattery = "분해되어 나오는 픽업 수 2배",
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.FISTFUL_OF_ASH] = {
		_descType = "collectible",
		Name = "잿더미 한 줌",
		QuoteDesc = "인간보다 못한 존재",
		Description = [[
			{{Bomb}} 폭탄 +3
			!!! {{BrokenHeart}} 스테이지 진입 시 부서진하트 +1
			색돌의 등장 빈도 수가 증가합니다.
			{{BrokenHeart}} 색돌 파괴 시 증발성 공격력이 증가하며 50%의 확률로 부서진하트 -1
		]],
		Tests = {
			"{{Bomb}} +3 Bombs",
			"Tinted rocks have out of place visuals and spawn more often",
			"Breaking tinted rocks spawns half a heart and grants a fading damage up",
			"{{BrokenHeart}} Breaking tinted rocks also has a 50% chance to remove a broken heart",
			"{{Warning}} Gain a broken heart each floor"
		},
	},
	--#endregion
	--#region SPITSHINE COLLECTIBLES
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.FIENDS_THIRD_LEG] = {
		_descType = "collectible",
		Name = "핀드의 세번째 다리",
		QuoteDesc = "많다...",
		Description = [[
			↑ {{DamageSmall}}공격력 배율 x3.33
			↑ {{TearsSmall}}연사 배율 x1.5
			공격에 유도 효과가 생기며 적에게 피해를 주는 보라색 장판을 생성합니다.
			공격이 무언가에 부딪힐 시 Fiend의 부하를 소환합니다.
		]],
		Tests = {
			"↑ x3.33 Damage",
			"↑ x1.5 Fire rate multiplier",
			"Homing tears",
			"Tears leave a trail of damaging creep and leave a Fiend Minion on impact"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.LOADED_D6] = {
		_descType = "collectible",
		Name = "취한 주사위",
		QuoteDesc = "운명을 반복하는 능력",
		Description = [[
			사용 시 그 방의 아이템을 캐릭터가 소지 중인 아이템으로 바꿉니다.
			중첩 가능한 아이템이 우선적으로 등장합니다.
		]],
		Tests = {
			"Rerolls pedestal items in the current room into copies of items you're already holding",
			"Will prioritize items that aren't useless when stacked"
		},
		CarBattery = false,
		AbyssTests = {
			"Turns into other copies of locusts, if available"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ISAAC_DOT_CHR] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "캐릭터 백업 파일 생성 중...",
		Description = [[
			↑ 목숨 +1
			{{Collectible721}} 사망 시 그 방에서 일부 아이템이 오류 아이템으로 바뀐 채 부활합니다.
		]],
		Tests = {
			"↑ +1 Life ",
			"{{Collectible721}} On death, Isaac respawns with some of his items replaced with glitched items"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.WORM_INSIGNIA] = {
		_descType = "collectible",
		Name = "벌레 휘장",
		QuoteDesc = "일찍 일어나는 벌레가... 응?",
		Description = [[
			↑ {{SpeedSmall}}이동속도 +0.02
		]],
		Tests = {
			"↑ +0.02 Speed"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DADS_BATTERY] = {
		_descType = "collectible",
		Name = "아빠의 배터리",
		QuoteDesc = "충전 빚지기",
		Description = [[
			{{Battery}} 액티브 아이템의 충전량이 모두 채워지지 않았을 때에도 사용할 수 있습니다.
			!!! 부족한 충전량 한칸 당 {{SpeedSmall}}/{{ShotspeedSmall}}(배율)을 깎고 사용합니다. (최대 12칸)
		]],
		Tests = {
			"{{Battery}} Allows you to use your active item without having enough charge, resulting in negative charge",
			"↓ Having negative charge reduces your Speed and Shot speed, and persists even if you switch active items"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.TORTURE_COOKIE] = {
		_descType = "collectible",
		Name = "고문 쿠키",
		QuoteDesc = "재사용 가능한 고문",
		Description = [[
			!!! {{HalfHeart}} 사용 시 체력 반칸을 깎고 확률적으로 아래 중 하나를 드랍: 
			>>> [16%] {{BlackHeart}} 블랙하트
			>>> [14%] {{Card}} 역타로카드
			>>> [3%] {{Trinket}} 악마 관련 장신구
			빨간하트를 우선적으로 깎습니다.
		]],
		Tests = {
			"{{HalfHeart}} Deals half a red heart of damage to Isaac",
			"Grants one of the following rewards:",
			"An evil fortune",
			"{{BlackHeart}} A Black Heart",
			"{{Card}} A Reverse Tarot Card",
			"{{Trinket}} An evil-themed trinket"
		},
		Virtues = {
			"↑ +0.1 Damage per Torture Cookie wisp"
		},
		CarBattery = false,
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ISAACD_EULOGY] = {
		_descType = "collectible",
		Name = "주사위 찬사",
		QuoteDesc = "죽음으로 굴리기",
		Description = [[
			적 처치 시 10%의 확률로 랜덤 주사위 효과를 발동합니다.
			{{LuckSmall}} 행운 36+일 때 100%
			!!! {{Collectible]]..CollectibleType.COLLECTIBLE_D4..[[}}/{{Collectible]]..CollectibleType.COLLECTIBLE_D100..[[}} : 0.01%
		]],
		Tests = {
			"10% chance to activate a Dice item (D6, D20, etc) upon killing an enemy",
			"{{Luck}} 100% chance at 36 luck"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BRICK_FIGURE] = {
		_descType = "collectible",
		Name = "벽돌 모형",
		QuoteDesc = "벽돌 집기",
		Description = [[
			]]..FiendFolio.DescriptionIcons.Stud..[[ 획득 시 Brick Separator와 4개의 레고 페니를 드랍합니다.
			{{Coin}} 동전이 20%의 확률로 레고 페니로 바뀝니다.
		]],
		Tests = {
			FiendFolio.DescriptionIcons.Stud .. "Spawns a Brick Separator and 4 Studs",
			"{{Coin}} Pennies have a 20% chance to be converted into Studs"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.MOONBEAM] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			""
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GOLDSHI_LUNCH] = {
		_descType = "collectible",
		Name = "금시 점심",
		QuoteDesc = "체력 증가, 말처럼 빨리",
		Description = [[
			↑ {{Heart}}최대 체력 +1
			↑ {{Heart}}빨간하트 +1
			↑ {{SpeedSmall}}이동속도 +0.1
			{{Blank}} (클리어한 방의 경우 +0.85)
			↑ {{ShotspeedSmall}}탄속 +0.2
			{{Blank}} (클리어한 방의 경우 +0.4)
		]],
		Tests = {
			"↑ +1 Health",
			"{{HealingRed}} Heals 1 heart",
			"↑ +0.1 Speed",
			"↑ +0.2 Shot speed",
			"{{Speed}} In cleared rooms, this increases to +0.85 Speed and +0.4 Shot speed"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.TWINKLE_OF_CONTAGION] = {
		_descType = "collectible",
		Name = "빛나는 전염",
		QuoteDesc = "도전해보기",
		Description = [[
			방 입장 시 50%의 확률로 적 하나에 후광이 생깁니다.
			캐릭터가 후광을 보면 그 후광이 캐릭터에게 옮겨지며 잠시동안:
			>> {{DamageSmall}}x1.5/{{TearsSmall}}x0.85/{{LuckSmall}}+3
			일정 시간 이후 다른 적에게 오라가 옮겨집니다.
		]],
		Tests = {
			"50% chance for an enemy in a room to glow",
			"{{Damage}} Looking at a glowing enemy gives you x1.5 Damage, x0.85 Fire Rate, and +3 Luck",
			"The glowing effect will jump from Isaac to a random enemy after awhile"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DUSTY_D10] = {
		_descType = "collectible",
		Name = "낡은 10면 주사위",
		QuoteDesc = "예전의 믿지 못할 물건",
		Description = [[
			사용 시 그 방의 적을 다른 적으로 바꿉니다.
		]],
		Tests = {
			"Rerolls all enemies in the room into different enemies from anywhere in the game",
			"Attempts to reroll enemies into those with similar max HP"
		},
		Virtues = {
			"10% chance for tears to reroll enemies into enemies with similar max HP"
		},
		CarBattery = false,
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.TOKEN_BAG] = {
		_descType = "collectible",
		Name = "토큰 가방",
		QuoteDesc = "토큰 한가득",
		Description = [[
			]]..mod.DescriptionIcons.Token..[[ 방 10개 클리어 시 토큰을 하나 드랍합니다.
		]],
		Tests = {
			mod.DescriptionIcons.Token .. "Spawns 1 Token every 10 rooms",
			"Tokens mimic the pickup Isaac has last collected"
		},
		AppendEntries = {
			"FF_APPEND_TOKENS",
		},
		BFFS = 10, 8,
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GREEN_ORANGE] = {
		_descType = "collectible",
		Name = "녹색 오렌지",
		QuoteDesc = "부디 깨달아주길...",
		Description = [[
			↑ {{TearsSmall}}연사 +0.5
			↑ {{DamageSmall}}공격력 +0.7
			{{SoulHeart}} 소울하트를 하나 드랍합니다.
		]],
		Tests = {
			"↑ +0.7 Damage",
			"↑ +0.5 Tears",
			"{{SoulHeart}} Spawns a Soul Heart"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.REHEATED_PIZZA] = {
		_descType = "collectible",
		Name = "뜨거운 피자",
		QuoteDesc = "일일 식사",
		Description = [[
			↑ {{Heart}}최대 체력 +1
			↑ {{Heart}}빨간하트 +1
			{{UnknownHeart}} 스테이지 입장 시 랜덤 하트를 하나 드랍합니다.
		]],
		Tests = {
			"↑ +1 Health",
			"{{HealingRed}} Heals 1 heart",
			"At the start of each floor a pizza box will open and spawn a random heart"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.HEDONISTS_COOKBOOK] = {
		_descType = "collectible",
		Name = "쾌락주의자의 요리책",
		QuoteDesc = "자연 수확",
		Description = [[
			사용 시 그 방에서 최대 체력이 가장 낮은 적 한 종류를 즉사시키며 그 자리에서 여러 개의 눈물을 흩뿌립니다.
		]],
		Tests = {
			"On use, causes the enemy type with the lowest max HP in the room to explode in a shower of projectiles"
		},
		CarBattery = {"한", "두"},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ERRORS_CRAZY_SLOTS] = {
		_descType = "collectible",
		Name = "오류난 슬롯머신",
		QuoteDesc = "운명을 돌리는 능력",
		Description = [[
			!!! 일회용
			사용 시 슬롯머신을 시작하며 아이템 사용 버튼을 누르면 왼쪽부터 하나씩 숫자를 멈춥니다.
			3개의 숫자를 멈추면 해당 번호에 해당되는 아이템을 획득하며;
			!!! {{ErrorRoom}} 유효하지 않은 아이템의 경우 오류방으로 이동합니다.
		]],
		Tests = {
			"{{Warning}} SINGLE USE {{Warning}}",
			"When used, slots appear above Isaac's head",
			"Using the item locks in a number and speeds up",
			"Gives Isaac an item based on the internal item-ID of the number they rolled",
			"Invalid IDs teleport Isaac to the Error Room"
		},
		Virtues = {
			"4 wisps that shoot {{Collectible369}} Continuum tears that travel between sides of the screen"
		},
		Belial = "{{DamageSmall}} 결과에 따라 공격력 증가",
		CarBattery = {"획득하며", "2개{{CR}} 획득하며"},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SPELLING_BEE] = {
		_descType = "collectible",
		Name = "스펠링 비",
		QuoteDesc = "글자의 효율",
		Description = [[
			현재 게임의 시드를 기반으로 각 글자가 능력치 및 픽업의 기반이 되는 경우 해당 능력치 및 픽업을 증가, 숫자의 경우 모든 능력치가 감소합니다.
			!!! (예시 :D,A,M,A,G,E 중 한 글자 포함 시 {{DamageSmall}}공격력 증가)
		]],
		Tests = {
			"↑ Gives stat boosts depending on the letters of the current run's seed",
			"{{Damage}} If a letter is from a stat word like DAMAGE, it grants those stats",
			"The same is true for pickups",
			"↓ Numbers will grant a minor all stats down"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SCULPTED_PEPPER] = { -- TODO
		_descType = "collectible",
		Name = "조각 고추",
		QuoteDesc = "오만의 힘",
		Description = [[
			사용 시 그 방에 석상을 투하합니다.
			석상 공격 시 조각상이 만들어지며 완성 시 주변의 적에게 상태이상을, 캐릭터에게 버프를 주는 오라를 생성합니다.
		]],
		Tests = {
			"Spawns a stone block that Isaac can break",
			"Fully chiseled stone blocks produce an aura that gives status effects to enemies and buffs to Isaac"
		},
		CarBattery = false,
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.TOO_MANY_OPTIONS] = {
		_descType = "collectible",
		Name = "너무 많은 선택",
		QuoteDesc = "너무 많아!",
		Description = [[
			모든 특수방이 3종류의 랜덤 특수방으로 전환되며 3개 중 하나를 선택할 수 있습니다.
			!!! {{CurseRoom}}저주방 선택 시 방 문에 가시가 생깁니다.
		]],
		Tests = {
			"Special room doors cycle between 3 random special room types until unlocked or entered"
		},
	},
	--#endregion
	--#region RELOADED COLLECTIBLES
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.LARGE_DOSE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[

		]],
		Tests = {
			"↑ Grants a very minor all stats up and a moderate increase to one random stat"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CROWN_INSIGNIA] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +0.02 Speed"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GAPER_IN_A_JAR] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"If empty, Isaac can swing the jar to place an enemy into the jar",
			"If an enemy is in the jar, Isaac can throw the enemy as a projectile that deals damage equal to the enemy's HP",
			"Can also trigger enemy on-death effects",
			"Bosses cannot be put into the jar"
		},
		CarBattery = false,
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ANATHEMA] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Every 7th tear fired inflicts enemies with excommunication"
		},
		AppendEntries = {
			"FF_APPEND_EXCOMMUNICATED",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.EXCOMMUNICATED
	 	},
		AbyssTests = {
			"20% chance to inflict enemies with excommunication"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.WARFARIN] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Heart}} High chance for enemies to drop red hearts",
			"{{Warning}} Taking damage causes 1-3 additional red hearts to fly out",
			"These can be recollected, but disappear if left alone",
			"When expiring, hearts release a highly damaging blood explosion"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.MTN_DEW] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Chargeable}} Firing charges up an extended volley of tears",
			"{{ffRadiation}} At the end of the volley, Isaac launches 3 large radiation shots that leave an aura that harms both you and enemies",
			"{{Warning}} Radiation will cause Isaac to drop hearts if stayed in for too long"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DOG_WHISTLE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			mod.DescriptionIcons.Berserk .. "Inflicts all enemies with Berserk"
		},
		AppendEntries = {
			"FF_APPEND_BERSERK",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.BERSERK },
		CarBattery = false,
		AbyssTests = {
			"20% chance to inflict Berserk when dealing damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DOOMSDAY_CLOCK] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Inflicts all enemies with Doom"
		},
		AppendEntries = {
			"FF_APPEND_DOOM",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.DOOM },
		CarBattery = false,
		AbyssTests = {
			"20% chance to inflict Doom when dealing damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SHOCK_IMAGE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"16% chance to fire tears that inflict enemies with Overloaded",
			"{{Luck}} 33% chance at 12 luck"
		},
		AppendEntries = {
			"FF_APPEND_OVERLOADED",
		},
		AbyssTests = {
			"20% chance to inflict enemies with Overloaded"
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.OVERLOADED },
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.STRING_THEORY] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Applies Sewn to enemies in a small radius around Isaac"
		},
		AppendEntries = {
			"FF_APPEND_SEW",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.SEW },
		AbyssTests = {
			"20% chance to inflict enemies with Sewn"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.LEVEL_2_BREAKFAST] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Placeholder description"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.STRANGE_MATTER] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"3% chance to fire an insta-kill tear that leaves behind mysterious liquid creep on kill",
			"{{Luck}} 25% chance at 13 luck"
		},
		AbyssTests = {
			"3% chance to to instantly kill enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ANTISAAC] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Familiar that sits horizontally aligned with Isaac on the opposite side of the room",
			"Fires piercing spectral tears that deal 3.5 damage",
			"When antisaac's tears collide with Isaac's they explode",
			"Explosion damage scales with Isaac's damage",
			"{{Warning}} Exploding tears do not harm Isaac",
		},
		BFFS = {
			TargetNumbers = {
				{ 3.5, 7}
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.OVERCLOCK] = {
		_descType = "collectible",
		Name = "오버클럭",
		QuoteDesc = "",
		Description = [[
			{{Trinket}} 20초간 그 방에서 소지 중인 석기 장신구를 강화시키며 흡수 패널티를 제거합니다.
		]],
		CarBattery = {20, 40},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GOLEMS_SUB] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{SoulHeart}} +2 Soul Hearts",
			"{{Trinket}} Drops a random pebble or mixed pebble on pickup"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BLOODTHIRSTY_BLADE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Periodically fires 3 piercing blades that fire towards random enemies, dealing damage and inflicting Hemorrhaging",
			"If Isaac is hit by a blade, it instead bursts into blood tears in the same direction"
		},
		AppendEntries = {
			"FF_APPEND_HEMORRHAGE",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.HEMORRHAGE },
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ASTEROID_BELT] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Grants rock orbitals that block shots upon dealing damage and clearing rooms",
			"Rock orbitals will break after taking enough damage",
			"Rock orbitals can be launched by double tapping a direction to clear projectiles in its path, deal damage, and confuse enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SWEET_RED] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Chargeable}} Enemies drop berries that give Isaac a chargeable ipecac tear",
			"Rooms can drop berry bunches that upgrade the ipecac tear with extra effects once enough are gained"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.HUMAN_DOMESTICATION_GUIDE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Charm}} Makes the nearest enemy permanently friendly and snared to Isaac",
			"Item recharges once the snared enemy is killed",
			"{{Heart}} Restoring health also heals snared enemies to full health"
		},
		Virtues = {
			"Wisp surrounds friendly ensnared enemy",
		},
		Belial = {
			"When your charmed enemy dies, they explode into a {{Collectible684}} Hungry Soul explosion",
		},
		CarBattery = {
			Tests = {
				"Can ensare two enemies"
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SIDEWAYS_ONION] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +1.2 Tears when firing to the left or right"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.INFESTED_PIPELINE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Chance to pheromone fart periodically",
			"At the start of every floor, Isaac will fart 53 times and spawn 100 decoration worms"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.HUITLACOCHE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{ffImmoralHeart}} +2 Immoral Hearts",
			"Whenever a Fiend Minion spawns or kills an enemy, it spawns a friendly Shiitake spore with increased health and damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SPACE_FOOD] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +1 Health",
			"{{HealingRed}} Heals 1 heart",
			"{{Planetarium}} +10% Planetarium chance",
			"50% chance to gain status immunity for 3 minutes"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CHEMICAL_COOKIE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Every 2 seconds, the next tear Isaac shoots is colored and spawns a puddle of creep on impact",
			"The color of the creep determines its effects"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SPIRIT_OF_NIGHTMARE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"15% chance to fire tears that inflict enemies with Drowsy",
			"Sleeping enemies gain a counter that counts down over time",
                "Upon reaching zero, the enemy takes a large amount of damage",
			"{{Luck}} 50% chance at 25 luck",
		},
		AppendEntries = {
			"FF_APPEND_DROWSY",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.DROWSY_AND_SLEEP },
		AbyssTests = {
			"20% chance to inflict enemies with Drowsy"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.IMP_CURSE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{HalfHeart}} 25% chance to spawn 5 Fiend Minions and lose half a heart when entering a combat room",
			"{{ffHalfImmoralHeart}} Chance for one of these minions to drop half an Immoral heart",
			"This prioritizes Red Hearts before Soul Hearts"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.COPPER_CHUNK] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Chance for enemies to either gain 1.5x health or halve their health",
			"Enemies will become larger or smaller when the effect activates"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BAD_BLOOD] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"When Isaac is at 6 hearts or lower, enemies will take extra damage from all sources",
			"{{Damage}} The damage multiplier will increase as Isaac's health decreases"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CHAOTIC_CARVING] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Chargeable}} Grants a 3 stage charge bar that will place down a statue that inflicts debuffs in an aura",
			"Stage 1 applies Charm, Berserk, or Confuse",
			"Stage 2 Petrifies",
			"Stage 3 Petrifies and deals heavy damage in a radius upon expiring",
			"{{Warning}} Stage 3 can only be used once per room"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CLOWN_MEAT] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Chargeable}} Moving charges up an invincible dash that activates upon stopping",
			"Overcharging the bar increases the charge's damage and duration",
			"The dash can be canceled by holding a movement direction while using it"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.FUN_PIZZA] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +1 Health",
			"↑ +0.35 Tears",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.TIME_IS_MONEY] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{ffLilPenny}} Gives Isaac a lil' penny every 4 seconds"
		},
		BFFS = false,
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.LOADSAMONEY] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"25% chance to fire tears that inflict Mugged",
			"{{Luck}} 100% chance at 25 luck"
		},
		AppendEntries = {
			"FF_APPEND_MUGGED",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.MUGGED
	 	},
		AbyssTests = {
			"20% chance to inflict enemies with Mugged"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BIG_ROCK] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +0.4 Tears",
			"↑ +2 Damage",
			"↓ -0.4 Speed"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BIG_WOOD] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +1.4 Tears",
			"↑ +0.4 Damage",
			"↓ -0.4 Shot speed"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BIG_PIPE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +0.4 Damage",
			"↑ +0.4 Tears ",
			"↑ +0.4 Shot speed",
			"↑ +0.4 Speed"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.HOW_TO_ROLL] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Allows Isaac to dodge roll, allowing him to move quickly"
		},
		CarBattery = false,
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.LE_CAT] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +0.1 Damage",
			"↑ +0.1 Tears",
			"↑ +0.1 Speed",
			"↑ +1 Luck",
			"{{Coin}} Spawns 5 random coins",
			"Spawns a fortune paper"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BONE_HURTING_JUICE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Damage}} Turns bone orbitals into Damage",
			"The more bone orbitals you have, the more Damage you will receive",
			"{{Timer}} Damage from bone orbitals wears off over time"
		},
		CarBattery = false,
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GRANDPAS_WHISKEY] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +1 Tears",
			"↓ Tear accuracy down"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ORGAN_DONOR] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +3 Health",
			"{{HealingRed}} Full health",
			"{{Warning}} Turns all heart drops in the run into Red Hearts"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GREEN_CANDLE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Poison}} Throws a green poisonous flame",
			"The flame leaves a trail of poison gas, blocks projectiles, and despawns after 2 seconds or after damaging an enemy"
		},
		CarBattery = false,
		Virtues = {
			"Leaves behind a poisonous gas trail"
		},
		VirtuesSingleRoom = true,
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.JUMBO_JOSH] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ x2 Damage",
			"Size up",
			"Green up",
			"{{Warning}} Real item"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.THE_LAST_BLACK_HEART] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{BlackHeart}} +1 Black Heart",
			"{{Warning}} Turns all Black Heart drops in the run into other hearts"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.HUNDRED_PERCENT_ORANGE_JUICE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Causes colorful floor tiles that Isaac can step on to appear in rooms",
			"These tiles do different things depending on their color"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BOMB_COLLAR] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Tears}} Tears up that gets stronger based on how low your health is",
			"{{Warning}} Isaac explodes and dies if he takes damage with 2 Hearts or less"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.HOT_SHOT] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Friend throws a purple fire which can be shot to explode enemies",
			"{{Burning}} The flame inflicts Burning on enemies and deals twice your damage",
			"{{HalfHeart}} 30% chance for enemies to drop half red hearts when killed by Hot Shot's explosion",
			"{{Warning}} The explosion from the purple flame can hurt you"
		},
		CarBattery = false,
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.INFESTATION_3] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Spawns a Blue Skuzz after walking 50 steps",
			"Blue Skuzzes are friendly creatures that hop towards nearby enemies and do 3x Isaac's damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.INFESTATION_4] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Spawns a Blue Beetle after dealing 50 damage",
			"Blue Beetles are friendly creatures that shield Isaac from oncoming attacks and projectiles"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.UTILITY_POLE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Spawns a crow with a gift at the start of every second floor",
			"Walking into the gift will open it, spawning 2-4 random consumables"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.LIL_FRIEND] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Shoots bullets from her gun that deal 4.9 Damage",
			"Can only shoot 6 bullets before reloading",
			"Homes in on enemies",
		},
		BFFS = {
			TargetNumbers = {
				{4.90, 9.8}
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.TRICOLOR_KEY] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Key}} All colored locks are free to open",
			"Has a chance to randomly replace rocks with a colored lock in a room"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.D5] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Dice that can be picked up and thrown around",
			"When it lands, it does an effect depending on the side"
		},
		BFFS = {
			Tests = {
				"Damage doubled"
			}
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.TELEPORT_ALPHA] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Teleports Isaac to a random position in a room",
			"Teleporting directly on an enemy does 50 Damage"
		},
		CarBattery = {
			Tests = {
				"Teleports Isaac twice"
			},
		},
		Virtues = {
			"Leaves a stationary wisp where Isaac teleports from"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SPINACH_PIE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"15% chance to fire tears that leave a trail of green damaging creep",
			"{{Luck}} 45% chance at 20 luck"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PAGEANT_BOY_2] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Coin}} Spawns 7 random coins"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DRIED_PAINT] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Killing an enemy spawns an abstract art piece which does not deal contact damage",
			"Killing the art piece spawns a barrage of colorful tears that scale with your damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GIRL_DINNER] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +1 Health",
			"{{HealingRed}} Heals 1 heart",
			"{{Warning}} Girls only"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.EMPTY_GAZE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +0.3 Damage",
			"When an enemy dies, they shoot out bones and more gore particles",
			"Killing enemies pushes other enemies away"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CRAIGS_BATTERY] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Bulb lanterns spawn in rooms with enemies",
			"{{Battery}} Picking up lanterns and hurting enemies fills up the charge bar",
			"When used, Craig can shoot out a big laser",
			"Laser size depends on how much charge this item has",
			"Needs 1/3 charge at minimum to use",
			"{{Warning}} Explodes if overcharged fully"
		},
		CarBattery = false,
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.EFFICIENCY_MODULE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Battery}} After using an active item, Isaac will gain back 0-50% of its charge"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.RED_NO_3] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +0.7 Tears",
			"{{ffMorbidHeart}} +1 Morbid Heart"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BABY_FORMULA] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +1 Health",
			"{{HealingRed}} Heals 1 heart",
			"↑ Size down",
			"↑ +0.05 Speed"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.FLIP_PHONE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Using the item and firing in a direction fires a giant piercing electric tear",
			"The shocks from the electric tear do 1.8 Damage",
			"Isaac can control this tear",
			"The more you change the direction of the tear, the faster it becomes"
		},
		CarBattery = false,
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DOUBLE_DOG] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +0.5 Damage",
			"↑ +3 Range",
			"↑ +0.2 Shot speed",
			"The next item Isaac picks up will be replaced by a dog familiar",
			"This dog familiar is based on the current room type you pick up the item in"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DEFAULT_DOG] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Shoots normal tears",
			"Does 3.5 damage per tear",
			"{{TreasureRoom}} Gained by picking up an item in the Treasure Rooms and {{BossRoom}} Boss Rooms"
		},
		BFFS = {
			TargetNumbers = {
				{ 3.5, 7 }
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DEVIL_DOG] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +1 Damage",
			"Does 6.66 damage per tear",
			"{{DevilRoom}} Gained by picking up an item in Devil Rooms",
			"{{ffDoom}} Tears inflict enemies with Doom",
		},
		BFFS = {
			TargetNumbers = {
				{ 6.66, 13.32 }
			},
		},
		AppendEntries = {
			"FF_APPEND_DOOM",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.DOOM},
		AbyssTests = {
			"20% chance to inflict enemies with Doom"
		}
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DIVINE_DOG] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +0.7 Tears",
			"Does 5 damage per tear",
			"{{AngelRoom}} Gained by picking up an item in Angel Rooms",
			"Enemies killed by tears will turn into Martyrs",
		},
		BFFS = {
			TargetNumbers = {
				{ 5, 10 }
			},
		},
		AppendEntries = {
			"FF_APPEND_MARTYR",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.MARTYR},
		AbyssTests = {
			"20% chance to turn enemies into Martyrs upon kill"
		}
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DEAD_DOG] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +1 Life",
			"Does 4 damage per tear",
			"{{Collectible453}} Tears shatter into 1-3 bone shards upon hitting everything",
			"{{SecretRoom}} {{SuperSecretRoom}} Gained by picking up an item in Secret Rooms",
		},
		BFFS = {
			TargetNumbers = {
				{ 4, 8 }
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DISCOUNT_DOG] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Does 3.5 damage per tear",
			"A random assortment of bombs, coins, and keys spawn",
			"{{Shop}} Shop items cost 25% less",
			"{{Shop}} Gained by picking up an item in Shops",
		},
		BFFS = {
			TargetNumbers = {
				{ 3.5, 7 }
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.KALU] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Does 7 damage per tear",
			"{{Petrify}} 30% chance to petrify enemies",
			"{{Petrify}} Enemies killed while petrified burst into tears",
			"{{CursedRoom}} Gained by picking up an item in Curse Rooms",
		},
		BFFS = {
			TargetNumbers = {
				{ 7, 14 }
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DOG_DOG_DOG_DOG] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Spawns 5 dogs from the dog folder",
			"The tears shot by the dogs have different effects",
			"{{ErrorRoom}} Gained by picking up an item in Error Rooms",
		},
		BFFS = {
			Tests = {
				"Double damage"
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.FABERGE_BOMBS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Coin}} +6 Coins",
			"{{Coin}} If Isaac has no bombs, he can still place one at the cost of 3 Coins",
			"{{ffLilPenny}} Bombs explode into a radial scattershot of damaging lil' pennies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.HYDROKINESIS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↓ x0.5 Fire rate multiplier",
			"↓ -0.2 Shot speed",
			"Many tears spawn around Isaac when he shoots that fire towards enemies",
		},
		AbyssTests = {
			"Tears occasionally spawn around the locust while charging that fire towards enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.FRIENDS_FIREBALL_FORMULA] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Burning}} 5% chance to shoot out a purple tear that inflicts Burning on enemies",
			"Burned enemies burst into purple flame jets when killed",
			"{{Luck}} 100% chance at 20 luck"
		},
		AbyssTests = {
			"Inflicts Burn"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DAYDREAM] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"When in an active room, a thought bubble appears beside Isaac every 15-30 seconds",
			"Thought bubbles have two timed prompts that you can choose from using the up and down keys",
			"Pressing the drop button ({{ButtonRT}}) ends the prompt early, granting you the reward"
		},
		AbyssTests = {
			"Random effect when hitting an enemy"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.THE_WAR_HORN] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			'When used:',
			"↑ +0.25 Speed",
			"{{Damage}} Combat familiars deal 3x Damage",
			"{{Battery}} Deactivating incurrs a 15 second recharge time",
			"↓ Taking damage while in the frenzy state forcibly cancels it, doubles the amount of damage taken, and kills all frenzied familiars",
			"{{Collectible11}} One killed familiar is revived each room",
			"{{Collectible8}} Summons a Brother Bobby style familiar if Isaac owns no permanent combat familiars"
		},
		Belial = {
			"{{Damage}} Familiar damage mult increased to x3.33",
			"{{Burning}} 26.66% chance for familiars tears to light enemies on fire",
		},
		Virtues = {
			"{{Slow}} Wisp tears inflict Slowness"
		},
		CarBattery = false,
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.THE_WAR_HORN_CHARGING] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			'Toggles a "familiar frenzy" state on use:',
			"{{Damage}} Combat-familiars deal x3 Damage, except blue bugs",
			"↑ +0.25 Speed",
			"{{Battery}} Deactivating incurrs a 15 second recharge time",
			"↓ Taking damage while in the frenzy state forcibly cancels it, doubles the amount of damage taken, and kills all frenzied familiars",
			"{{Collectible11}} One killed familiar is revived each room",
			"{{Collectible8}} Summons a Brother Bobby style familiar if Isaac owns no permanent combat familiars"
		},
		Belial = {
			"{{Damage}} Familiar damage mult increased to x3.33",
			"{{Burning}} 26.66% chance for familiars tears to light enemies on fire",
		},
		CarBattery = false,
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ZIP_43] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Bomb}} +5 Bombs",
			" Bombs apply Download Faliure to every enemy in the room when they explode",
			"{{ffOverloaded}} 5% chance to apply Overloaded instead"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.FETAL_FRIEND] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Heart}} Converts Isaac's health into Ammo Hearts, which decrement when shooting and reload when not",
			"Ammo Hearts correspond to the type of health Isaac has",
			"↑ +0.8 Damage",
			"{{Damage}} +0.8 Damage while above zero ammo",
			"↑ +0.3 Shot speed while above zero ammo",
			"↓ -0.3 Tears while at zero ammo"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.IMP_SODA_TRICKY_CHERRY] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Timer}} Every 20 seconds in an uncleared room:",
			"Isaac gets a 100% chance to shoot out red critical tears that do x5 damage for 3 seconds"
		},
		AbyssTests = {
			"4% chance to deal x5 damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SHUFFLE_TIME] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"63% chance to grant a reward upon completing rooms without taking damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.EIGHTEEN_FOOT_LEASH] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Periodically in active rooms, Isaac will poop 3-7 times in a row",
			"These poops have a 50% chance to have Drug Baggies",
			"Drug baggies grant:",
			"↑ +2 Tears",
			"↑ +0.8 Speed",
			"↓ {{Collectible582}} A wavy cap screen distortion",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.VOYAGER_VENDOR] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Spawns a vending machine in the room",
			"{{Coin}} This vending machine always contains an active item, and the cost ranges from 0-10 coins"
		},
		CarBattery = {
			PartialReplace = {
				["a vending machine"] = "2 vending machines",
			}
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.WARDENS_CROWN] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"5% chance to fire a homing Warding tear",
			"{{Luck}} 20% chance at 7 luck",
			"Warding tears trap enemies in a ring of stars for 10 seconds",
			"Any other enemies that enter the ring are also trapped"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DYNAMITE_PACK] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Bomb}} On use, spawns 3 throwable red bombs"
		},
		CarBattery = {
			TargetNumbers = {
				{ 3, 6 }
			},
		},
		Virtues = {
			"Red wisp"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.THE_FINAL_OPTION] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Teleport to a special room containing 8 items from curated item pools",
			"{{Warning}} Taking any items causes certain special rooms to no longer generate in this run:",
			"{{TreasureRoom}} Treasure Rooms",
			"{{Shop}} Shops",
			"{{Library}} Libraries",
			"{{DevilRoom}} Devil Deals",
			"{{AngelRoom}} Angel Deals",
			"{{Planetarium}} Planetariums",
			"{{UltraSecretRoom}} Ultra Secret Rooms"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PAK_CHOI] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ 1.09x multipliers for:",
			"{{Tears}} Tears",
			"{{Damage}} Damage",
			"{{Speed}} Speed",
			"{{Luck}} Luck",
			"{{Shotspeed}} Shot speed",
			"{{Range}} Range",
			"{{Range}} Tear Height",
			"{{DevilChance}} Devil/Angel deal chance",
			"{{PlanetariumChance}} Planetarium chance",
			"{{Collectible11}} Extra lives",
			"{{Heart}} Heart Container limit",
			"{{Coin}} Current coin count",
			"{{Coin}} Coin capacity",
			"{{Bomb}} Current bomb count",
			"{{Bomb}} Bomb capacity ",
			"{{Key}} Current key count",
			"{{Key}} Key capacity",
			"{{Trinket81}} Invulnerability duration",
			"{{Collectible58}} Shield duration",
			"{{Collectible308}} Player creep lifespan",
			"{{Battery}} Timed active charge rate ",
			"{{Speed}} Player friction",

			-- Beyond this point the description extends off of the screen at default Description scale, start describing the mildly niche stuff now
			"{{ffHitbox}} Player hitbox size",
			"{{Trinket" .. mod.ITEM.ROCK.HEAVY_METAL .. "}} Player collision mass",
			"{{Collectible300}} Player collision damage",
			"{{Bomb}} Bomb placement rate",
			"{{Bomb}} Bomb damage",
			"{{Tearsize}} Tear size",
			"{{Trinket45}} Poker Table odds",
			"{{BlackHeart}} Black Heart damage",

			-- Beyond this point the description extends off of the screen at x0.75 Description scale, start describing the really niche stuff now
			"{{Player18}} Soul Gauge charge",
			"{{Player36}} Blood Gauge charge",
			"{{Player25}} Current mana count",
			"{{Player" .. mod.PLAYER.GOLEM .. "}} Rock power",
			"{{Collectible" .. mod.ITEM.COLLECTIBLE.PYROMANCY .. "}} Fireball generation rate",
			"{{Collectible412}} Cambion gestation rate",
			"{{Collectible413}} Immaculate gestation rate",
			"{{Collectible206}} Head orbit speed",
			"{{Collectible206}} Head orbit distance",
			"{{Collectible725}} IBS charge rate",
			"{{Collectible441}} Mega Blast duration",
			"{{Collectible621}} Damage boost duration",
			"{{Collectible625}} Mega Mush duration",
			"{{Collectible674}} Slo-mo duration",
			"{{Collectible77}} Invincibility duration",
			"{{Collectible497}} Stat boost duration",
			"{{Collectible295}} Magic Fingers damage",
			"{{Collectible507}} Sharp Straw damage",
			"{{Collectible136}} Best Friend damage",
			"{{Collectible37}} Mr. Boom damage",

			-- I'm just taking the piss here, it buffs every chance based tear effect's chance
			"{{Collectible103}} Common Cold poison chance",
			"{{Collectible257}} Fire Mind burn chance",
			"{{Collectible496}} Euthanasia needle chance",
			"{{Collectible398}} God's Flesh shrink chance",
			"{{Collectible150}} Tough Love tooth chance",
			"{{Collectible443}} Apple! razor chance",
			"{{Collectible553}} Mucormycosis tear chance",
			"{{Collectible459}} Sinus Infection chance",
			"{{Trinket98}} Nose Goblin chance",
			"{{Collectible637}} Knockout Drops fist chance",
			"{{Collectible618}} Rotten Tomato bait chance",
			"{{Collectible617}} Lodestone magnetic chance",
			"{{Collectible461}} Parasitoid egg tear chance",
			"{{Collectible200}} Mom's Eyeshadow chance",
			"{{Collectible460}} Glaucoma confusion chance",
			"{{Collectible259}} Dark Matter fear chance",
			"{{Collectible228}} Mom's Perfume fear chance",
			"{{Collectible393}} Serpent's Kiss chance",
			"{{Trinket30}} Pinky Eye poison chance",
			"{{Collectible231}} Ball of Tar slow chance",
			"{{Collectible89}} Spider Bite slow chance",
			"{{Trinket130}} Chewed Pen slow chance",
			"{{Collectible" .. FiendFolio.ITEM.COLLECTIBLE.STRANGE_MATTER .. "}} Strange Matter chance",
			"{{Collectible" .. FiendFolio.ITEM.COLLECTIBLE.IMP_SODA .. "}} Imp Soda crit rate",

			-- This shit sucks hide it as far as possible
			"{{Guppy}} Guppy fly chance",
			"{{Collectible640}} Current souls (floored)",
			"{{Collectible434}} Current flies (floored)",
			"{{Heart}} Heart containers (floored)",
			"{{Heart}} Health (floored)",
			"{{SoulHeart}} Soul health (floored)",
			"{{GoldenHeart}} Golden health (floored)",
			-- Beyond this point who cares man
			"{{ffWitherSkull}} Wither Skull drop rate"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.MAMMONITE_CODEX] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Warning}} SINGLE USE {{Warning}}",
			"{{Player" .. mod.PLAYER.GOLEM .. "}} Teleports Isaac to a crawlspace that contains every Golem rock in the game",
			"Choosing three rocks smelts them onto Isaac and teleports him back to the room he came from"
		},
		CarBattery = false,
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.MOMS_HEART] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +250 Health",
			"{{HealingRed}} Full Health"
		}
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GRANDPAS_GATLING_GUN] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Timer}} Gives Isaac a giant minigun, allowing him to rapidly fire bullets for up to 9 seconds",
			"Bullets deal 2x Isaac's damage and break rocks and doors",
			"Isaac can stop shooting anytime he wants",
			"Minigun ammo replenishes every floor"
		},
		Belial = {
			"Bullets light enemies on fire and have a 10% chance to explode on enemy impact"
		},
		CarBattery = false,
		AbyssTests = {
			"Breaks grids while charging"
		},
		AbyssSpecial = {
			"1 slow locust (2x Isaac's damage)"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SHADOW_CLUSTER] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Isaac leaves a trail of purple creep that doesn't harm enemies",
			"When Isaac uses the item, he shoots out a ring of purple creep",
			"After using the item, long spikes appear from the purple creep that damage enemies",
		},
		Virtues = {
			"Wisps shoot tears that spawn purple creep",
		},
		Belial = {
			"Increased hitbox and damage",
		},
		AbyssTests = {
			"25% chance to spawn a purple spike when dealing damage"
		},
		CarBattery = {
			Tests = {
				"Doubled duration of purple spikes"
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SHUFFLE_BOMBS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Bomb}} +5 Bombs",
			"Isaac's bombs have three different effects when placed",
			"These effects randomize every floor"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BULLET_HELL] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Two targets periodically spawn in active rooms",
			"Stepping on a target causes Isaac to shoot a radial bullet pattern"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GUPPYS_HEART] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{ffMorbidHeart}} Replaces all Soul and Black Heart pickups with Morbid Hearts",
			"Morbid chunks spawn 1-3 blue flies when destroyed",
			"{{SoulHeart}} Heart replacement doesn't happen for soul heart only characters"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.RAILDRIVER] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Grants a one shot railgun at the start of each room that fires a piercing shot",
			"If the shot hits a wall to an adjacent room, it will continue into that room as well",
			"Shot damage scales with Isaac's damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DESTINED_DOG] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Does 4 damage per tear",
			"{{UltraSecretRoom}} Gained by picking up an item in an Ultra Secret Room",
			"Chance to shoot random red tear effects",
		},
		BFFS = {
			TargetNumbers = {
				{ 4, 8 }
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.REPENTANCE_PLUS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Pressing the ALT key creates a wheel of emotes",
			"Pressing ALT again makes Isaac emote"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.QUEENS_FRUIT] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Damage}} Chance for enemies to spawn a bloody aura that grants damage while Isaac stands inside",
			"{{HalfHeart}} When the aura expires when inside, Isaac heals half a red heart once per room",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.STRANGE_EYE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Stat tracks every single monster Isaac kills",
			"↑ +0.1 Damage for the left eye if you have 0 kills",
			"{{Damage}} Damage increases the more enemies Isaac kills",
			"{{Luck}} Chance to shoot a purple critical tear that deal x5 damage increases the more enemies Isaac kills",
			"{{Warning}} Kill count does not reset on new runs"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SNAGS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Grants a Snagger familiar that picks up nearby coins, keys, and bombs",
			"Pick ups are turned miniature and are thrown at nearby enemies",
			"{{Heart}} Hearts can be collected and thrown at Isaac if he needs healing",
			"Can only hold a certain amount of each pick up at once"
		},
		BFFS = {
			Tests = {
				"Can hold more of each pick up"
			}
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CEILING_POPCORN] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +0.7 Damage",
			"{{ffMorbidHeart}} +1 Morbid Heart"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.EXECUTIONER] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Executes enemies that are damaged enough after 4 seconds in a room",
			"Bosses are executed if under 35% health, normal enemies if under 75%"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GIZMO_BOOTS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +0.3 Speed",
			"Flight only in cleared rooms",
		},
		AbyssSpecial = {
			"1 faster locust (1x Isaac's damage)"
		},
		AbyssTests = {
			"10% chance to burn enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ELECTRIC_DICE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Battery}} 66% chance to use an active item 1-2 more times on use"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PRODUCTIVITY_MODULE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Battery}} Supercharges every Xth use of an active item, where X is the amount of charges the active has",
			"When buffed, causes the active to be used 3 more times"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SPEED_MODULE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Battery}} Actives will refund 50% of their charge if used within 5 seconds of being charged"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PLASMA_BALL] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"",
			"Gives Isaac a plasma ball that he can roll around",
			"Touching the ball zaps nearby enemies for Isaac's damage",
			"Ball will occasionally zap nearby enemies passively"
		},
		BFFS = {
			Tests = {
				"Zaps more often with longer range"
			}
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.LOURDES_WATER] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Every room, a random rock will turn into an angellic statue",
			"This statue emanates an aura",
			"While inside the statue's aura:",
			"↑ {{Tears}} x2.5 Fire rate multiplier",
			"↑ {{Damage}} x1.2 Damage multiplier",
			"Homing tears",
			"Chance to block damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DECK_BOX] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Must be charged by picking up cards",
			"{{Card}} Using the item while Isaac is holding a card over his head will store it",
			"Activates all stored cards on use",
			"{{Luck}} 15% chance for enemies drop cards with offensive effects on death",
			"{{Timer}} Enemy-dropped cards disappear quickly"
		},
		CarBattery = {
			Tests = {
				"Activated cards are doubled"
			},
		},
		Belial = {
			"Stored cards will turn into their reversed counterparts"
		},
		Virtues = {
			"{{Card}} A card is dropped when the wisp kills an enemy"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DEVI] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Battery}} Every 2 times you use your active item, decrease it's maximum charge for the current floor",
			"Cannot go below 1 charge or 1 second",
			"Timed actives have their maximum charge reset on new room"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DOUBLES] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Isaac shoots 1-6 tears at once",
			"↓ {{Tears}} Tears down, depending on how many tears are fired"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DISCIPLINE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{SacrificeRoom}} Entering the Sacrifice Room for the first time triggers the spikes 4 times for free",
			"{{SacrificeRoom}} 33% chance to generate a Sacrifice Room on entering a floor, if there is not already on there"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.EYE_OF_PROVIDENCE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Tears that hit enemies fire a homing beam towards Isaac that deals x0.25 of his damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.STORY_OF_UNDERTALE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Charm}} Spawns 2 friendly Goats, Bonies, a friendly Fishface, and 1 charmed Bloomer for the room"
		},
		CarBattery = {
			TargetNumbers = {
				{ 2, 4 },
				{ 1, 2 }
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.WNIC] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Tears that hit enemies are fired again, starting from where they were initially fired and following the path they took",
			"↓ x0.85 Damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ZERO_POINT_REACTOR] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Tears fire additional orbital spectral tears upon hitting anything"
		},
		AbyssTests = {
			"Spawns orbital spectral tears when hitting an enemy"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GANYMEDE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Isaac fires a burst of 4 stationary tears every 5 shots",
			"If the stationary tears are near other tears, they will orbit those tears and home towards enemies",
			"Spectral tears"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.HELLFIRE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Collectible118}} On death, enemies have a 13% chance to stay alive for a second longer, then fire 4 brimstone lasers in the cardinal directions",
			"{{Luck}} 33% chance at 10 luck"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CHERUB_CHUBBY] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Charges forward and then sideways in the direction Isaac is shooting",
			"Deals 52.5 contact damage per second"
		},
		BFFS = {
			TargetNumbers = {
				{ 52.5, 105 }
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CARELESS_WHISPERS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Spawns three mini Whisper familiars that orbit around Isaac when he shoots",
			"Deals 75 contact damage a second"
		},
		BFFS = {
			TargetNumbers = {
				{ 75, 150 }
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DARK_BARGAIN] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +1 Damage",
			"{{Coin}} Drops 4 pennies",
			"Another Dark Bargain appears at the start of each floor as a devil deal and forces Isaac to take it",
			"{{Warning}} Dark Bargian cannot kill Isaac"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.APOTHEOSIS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{SoulHeart}} +2 Soul Hearts",
			"For every {{SoulHeart}} Soul Heart,{{BlackHeart}} Black Heart, or {{ffImmoralHeart}} Immoral Heart, gain a long range orbital",
			"Blocks enemy shots",
			"The orbitals deal 30 contact damage per second"
		},
		BFFS = {
			TargetNumbers = {
				{ 30, 60 }
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.TOYBOX] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Warning}} SINGLE USE {{Warning}}",
			"{{Trinket}} Smelts 4 random trinkets onto Isaac"
		},
		Virtues = {
			"4 wisps","20% chance to spawn Neighbours from Hell when destroyed"
		},
		CarBattery = false,
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.TEFILLIN] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{AngelRoom}} On pickup, guarantees an Angel Room to spawn after the next valid boss"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SUN_CROSS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Burning}} Spawns a sun familiar at the top of every room which pulls in enemies and pickups, and applies Burning to nearby enemies"
		},
		BFFS = false,
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DADS_HALF] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ 0.7 Tears",
			"{{BlackHeart}} +1 Black Heart"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.STARDUST] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"25% chance to fire a big star that splits into 7 miniature stars",
			"These stars rain down on enemies and deal 33% of Isaac's damage",
			"{{Luck}} 40% chance at 16 luck"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.TOWER_OF_HEAVEN] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"One random special room on the floor gets barred off at floor start, excluding {{BossRoom}} Boss Rooms, {{TreasureRoom}} Treasure Rooms",
			"↑ +0.3 Speed",
			"↑ +0.3 Damage",
			"↑ 1.2x Tears",
			"↑ +1 Luck",
			"↑ +1 Health",
			"{{HealingRed}} Heals 1 heart",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.RED_NIGHTMARE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{UltraSecretRoom}} Adds an extra Ultra Secret Room to each floor",
			"{{Card78}} Spawns 1-3 Cracked Keys",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.HOT_POTATO_BOOK] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +5% Damage permanently on use",
			"!!! Does not charge on room clear, can only be charged through batteries, items or other similar methods",
			"Increases the chance for Potato Sacks to spawn"
		},
		CarBattery = {
			TargetNumbers = {
				{ 5, 10 }
			},
		},
		Virtues = {
			"High HP wisp, that increases Damage by an additional 5% while alive"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GOLDEN_WATCH] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Beggar}} Give this to beggars in exchange for their life savings",
			"{{Shop}} Once given, various shops will try to sell it back at inflated prices",
			"{{Damage}} Becomes a damage multiplier based on how many coins you spent to buy it",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DIS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ Picking up an item grants the effect of a random item",
			"!!! Taking damage removes the oldest item effect granted by Dis"
		},
		BFFS = false,
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ACHERON] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Timer}} Killing enemies has a chance to give the effect of a random {{DevilRoom}} Devil Room item for 90 seconds",
			"Chance scales with enemy health"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ACTIVATED_CHARCOAL] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Timer}} Receive for the current room:",
			"{{Collectible149}} ↑ {{Damage}} +40 Damage",
			"↓ {{Tears}} x0.33 Fire rate multiplier",
			"↓ {{Range}} x0.8 Range multiplier",
			"↓ {{Shotspeed}} x0.8 Shot speed multiplier",
			"Isaac's tears are fired in an arc",
			"{{Poison}} The tears explode and poison enemies where they land",
		},
		CarBattery = {
			Tests = {
				"↑ +1 Damage"
			}
		},
		Virtues = {
			"Slow-firing explosive wisp"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.AIR_FRESHENER] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"While in combat, spawns tears around you which home onto nearby enemies",
			"The tears deal 13 damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PLANET_X] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Orbital familiar that copies tear effects",
			"Deals 1.5x Isaac's damage on contact"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GKUNHOMDIMA] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Chargeable}} Chargeable nimbus cloud that can fire alongside tears",
			"Nimbus clouds scale with tear effects and damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.NENDOROID] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"It's time to repent! Isaac has joined the Nendoroid line, ready to escape the terrifying clutches of his mother's wrath! Preorder now & receive an exclusive GSUS Bonus Background Sheet & The Binding of Isaac: Four Souls playing cards! Shop: https://s.goodsmile.link/jU8 #Goodsmile",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GLITCHCITY] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Periodically spawns \"Glitched Tiles\" while held, which destroy rocks, block projectiles and deal 60 damage to enemies",
        		"!!! While held, every minute and a half, another random held item will turn into GLITCHCITY",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GOLDEN_SPIKES] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"9% chance for rocks to turn into Golden Spiked Rocks upon entering the room for the first time",
                "Golden Spiked Rocks drop 1-3 coins upon being destroyed",
                "!!! Golden Spiked Rocks hurt Isaac when touched"
		},
		AbyssTests = {
			"10% chance to drop a penny on kill"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.FORTUNE_TELLER] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +1 Luck up",
			"↑ +0.1 Speed up",
			"On pickup, rerolls all pedestal items on the floor",
			"{{AngelDevilChanceSmall}} Does not affect the Devil/Angel Room or {{Crawlspace}} crawlspaces"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PLANCHETTE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Grants invulnerability to Isaac for 90 seconds on pickup",
			"This carries between rooms",
			"Grants an additional 36 seconds of invulnerability on entering a new floor"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.RESURRECTION] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"All temporary familiars that died this floor (Blue Flies, Blue Spiders, etc.) are respawned on use", --im not sure if i like the use of the etcetera here but also listing all of the familiars would be very ugly and messy
			"Does not count familiars spawned by this item",
			"Spawns a Blue Beetle if no familiars were spawned",
		},
		CarBattery = {
			Tests = {
				"Spawned temporary familiars are doubled"
			},
		},
		Virtues = {
			 "Low HP, high damage wisp"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BURGLAR_BABY] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Shoots tears that inflict Mugged",
			"Deals 3.5 damage per tear"
		},
		AppendEntries = {
			"FF_APPEND_MUGGED",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.MUGGED },
		BFFS = {
			TargetNumbers = {
				{ 3.5, 7.0 }
			},
		},
		AbyssTests = {
			"20% chance to inflict Mugged when dealing damage"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PAPAL_PAL] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Shoots tears that inflict enemies with Excommunication",
			"Deals 3.5 damage per tear"
		},
		AppendEntries = {
			"FF_APPEND_EXCOMMUNICATED",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.EXCOMMUNICATED },
		BFFS = {
			TargetNumbers = {
				{ 3.5, 7.0 }
			},
		},
		AbyssTests = {
			"20% chance to inflict enemies with Excommunication"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.OUTLET_BABY] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Shoots tears that inflict enemies with Overloaded",
			"Deals 3.5 damage per tear"
		},
		AppendEntries = {
			"FF_APPEND_OVERLOADED",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.OVERLOADED },
		BFFS = {
			TargetNumbers = {
				{ 3.5, 7.0 }
			},
		},
		AbyssTests = {
			"20% chance to inflict enemies with Overloaded"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CYBORG_BABY] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Collectible"..FiendFolio.ITEM.COLLECTIBLE.WNIC.."}} Shoots tears that are fired again following the same path if they hit an enemy",
			"Deals 3.5 damage per tear"
		},
		BFFS = {
			TargetNumbers = {
				{ 3.5, 7.0 }
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.MOTOR_SPIRIT] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Burning}} Isaac spawns fires behind him while moving#{{Burning}} Charging into enemies creates a ring of fire jets"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.NAGA_VIPER] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"10% chance to shoot fires that explode on contact#{{Luck}} 50% chance at 8 luck#{{Warning}} The explosion can hurt Isaac"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CREATION_OF_MAN] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Entering {{BossRoom}} Boss Rooms spawns a unique Minisaac that blocks all incoming damage for Isaac#Damage Isaac takes is transferred to the Minisaac#Minisaacs chase and shoot at nearby enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GREEN_APPLE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +1 Health",
			"{{HealingRed}} Heals 1 heart",
			"7.5% chance to inflict enemies with Nursing upon entering rooms",
			"{{Luck}} 15% chance at 20 luck",
			"1% chance to fire tears that inflict Nursing",
			"{{Luck}} 5% chance at 20 luck",
		},
		AppendEntries = {
			"FF_APPEND_NURSING",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.NURSING },
		AbyssTests = {
			"10% chance to inflict enemies with Nursing"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ETERNAL_PENDANT] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{EternalHeart}} +1 Eternal Heart",
			"Gives an Eternal Heart at the start of each floor",
			"{{ffShieldHeart}} Eternal Hearts also give a 3 hit shield heart when completed",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BABY_BELL] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Orbital that rings for a period when hit by enemies",
			"While ringing, fears nearby enemies and pushes enemies and bullets away"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BLACK_CANDELABRA] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +1.6 Damage",
			"Clears all natural curses",
			"!!! Every quarter of the floor's rooms cleared, one flame goes out, lowering the damage bonus",
			"The first flame reveals the Boss, the second reveals the Treasure Room, and the third adds 2 random curses"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.TECH_MODULO] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↓ 0.66x Damage",
			"Whenever you fire tears, fire a screen-wide laser perpendicular to your tears wherever it would land"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.FRUIT_MILK] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↓ 0.2x Damage multiplier",
			"Each of Isaac's tears have 3 different random effects"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DEVILSKNIFE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Orbital",
			"Blocks enemy shots",
			"!!! Moves back and forth from Isaac",
			"Deals 225 contact damage per second",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.EDENS_HEAD] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Uses a random throwable active item on use"
		},
	Virtues = {
		"Spawns the wisps of the used item"
	},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.YAAI] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Every 3rd tear fired splits into 6 half damage tears upon hitting anything"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SOLAR_TABLET] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Timer}} For the current room:",
			"{{Burning}} Spawns a sun familiar at the top of every room which pulls in enemies and pickups, and applies Burning to nearby enemies"
		},
		Virtues = {
			"Wisp that burns nearby enemies"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BRILLIANCE] = {

		StatusEffects = { FiendFolio.DescriptionStatuses.GLEAMING },
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{ffGleaming}} 10% chance to shoot tears which inflict Gleaming",
			"Gleaming auras can inflict Fear, Charm, Slowness, or Bruised",
			"{{Luck}} 50% chance at 20 luck"
		},
		AppendEntries = {
			"FF_APPEND_GLEAMING",
		},
		AbyssTests = {
			"20% chance to inflict either Fear, Charm, or Slowness"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.RADIANCE] = {

		StatusEffects = { FiendFolio.DescriptionStatuses.GLEAMING },
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{ffGleaming}} 10% chance to shoot tears which inflict Gleaming",
			"Gleaming auras inflict Burning",
			"{{Luck}} 50% chance at 20 luck"
		},
		AbyssTests = {
			"20% chance to inflict Burning"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DARKNESS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"While firing tears, your tears become temporarily intangible, unable to hit any enemies",
			"Enemies take damage over time while you are firing tears",
			"↑ +0.3 Damage",
			"↑ +0.1 Shot speed"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BOTTLE_CAP] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{ffCursedPenny}} Spawns a Cursed Penny on use"
		},
		Virtues = {
			"80% chance to spawn a {{ffCursedPenny}} cursed penny when destroyed",
			"2.5% chance to fire exploding tears"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.OLD_TESTAMENT] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Battery}} Upon use, your held active items are replaced with another random active item for the rest of the floor",
			"Swapping out this item while its effect is active will still have your active replaced",
			"Does not affect pocket active items"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CROSS_NECKLACE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Enemies with a low amount of max health instantly die",
			"Max health threshold scales with the stage Isaac is in",
			"↑ +1 Luck"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.MARK_OF_PAIN] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Every second in combat:",
			"↑ +0.1 Damage",
			"↓ -0.04 Speed",
			"Resets outside of combat",
			"This item will not set your Speed below 0.6",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BOOK_OF_LEVIATHAN] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{CurseBlind}} Cannot be charged on floors without curses",
			"{{BlackHeart}} +1 Black Heart",
			"↓ x0.8 Tears if not used this floor",
			"↓ -0.2 Speed if not used this floor",
		},
		Virtues = {
			"Passively applies bruise to random enemies while alive"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SCOUTS_BADGE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +0.1 Damage, aswell as +0.3 Damage for every {{SecretRoom}} Secret Room found on this floor",
			"{{SecretRoom}} Reveals and opens all Secret Rooms on this floor"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.MOMS_PENDANT] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +1 Damage",
			"{{BlackHeart}} +1 Black Heart",
			"!!! Guarantees a curse on the next floor"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BLASTULATION] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +0.1 Damage for every friendly Embryo",
			"{{Charm}} Chance to spawn a random friendly Embryo variant when killing an enemy",
			"Guaranteed when killing a boss",
			"Chance scales with luck",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.THE_PYX] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Inflicts Excommunicated on all enemies but the one with the highest health",
		},
		AppendEntries = {
			"FF_APPEND_EXCOMMUNICATED",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.EXCOMMUNICATED },
		CarBattery = {
			Tests = {
				"Excommunicated timer is doubled"
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.HOLY_BEAN] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Inflicts Excommunicated to enemies in range",
		},
		AppendEntries = {
			"FF_APPEND_EXCOMMUNICATED",
		},
		Virtues = {
			"Excommunicating fart when destroyed"
		},
		VirtuesSingleRoom = true,
		StatusEffects = { FiendFolio.DescriptionStatuses.EXCOMMUNICATED },
		CarBattery = {
			Tests = {
				"Excommunicated timer is doubled"
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.APPENDIX] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"+2 Leaky Hearts",
			"Leaky hearts slowly drain, leaving red creep on the floor",
			"{{AngelDevilChance}} Damage taken to draining hearts doesn't affect Devil Deal chance",
		}, -- needs different descriptions for soul heart characters, and eid icon
		
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CAN_OF_BEANS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +1 Damage",
			"↑ x1.35 Damage mulitplier",
			"↓ x0.5 Fire rate multiplier",
			"↓ x0.8 Range multiplier",
			"Isaac's tears fly into an arc and explode into a fart",
			"Holding different beans give different fart effects"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BLACK_EYED_PEA] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Inflicts 3 stacks of Bruised to enemies in range",
		},
		AppendEntries = {
			"FF_APPEND_BRUISE",
		},
		Virtues = {
			"Bruising fart when destroyed"
		},
		VirtuesSingleRoom = true,
		StatusEffects = { FiendFolio.DescriptionStatuses.BRUISE },
		CarBattery = {
			PartialReplace = {
				[" 3 "] = " 5 ",
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ECHOLILAC] = {

		StatusEffects = { mod.DescriptionStatuses.PACIFIED },
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Pacifies all enemies of a random type in the room for 6 seconds",
		},
		AppendEntries = {
			"FF_APPEND_PACIFIED",
		},
		AbyssTests = {
			"10% chance to inflict Pacified"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PARALLEL_BOMBS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Bomb}} +5 Bombs",
			"Bombs are placed alongside an intangible copy that mirrors the original's position",
			"The mirrored bombs do 50% the damage of the original bomb",
		},
		AbyssSpecial = {
			"1 white locust (0.5x Isaac's damage)",
			"{{Collectible706}} {{ColorRed}}1 black locust (1x Isaac's damage)",
		},
		AbyssTests = {
			"Spawns two locusts that are mirrored"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SNOOZE_BUTTON] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Clears the room of all obstacles, pick-ups, and enemies",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.STAR_TREAT] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +0.1 Speed",
			"↑ +1 Health",
			"{{HealingRed}} Heals 1 heart",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.EARTH_OF_ADAM] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Warning}} SINGLE USE {{Warning}}",
			"Gives you two copies of a random familiar you own",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.LASER_POINTER] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"When held up, Isaac can aim a laser at a specific point",
			"The laser stays aimed at its last point after putting the item away",
			"The laser's damage scales with Isaac's damage",
			"Nearby enemies target the laser when Isaac is moving it",
		},
		Virtues = {
			"3 wisps surround the laser"
		},
		AbyssTests = {
			"Electricity on hit"
		},
		Belial = {
			"↑ +0.6 Damage per enemy hit with the laser"
		},
		CarBattery = {
			Tests = {
				"The laser's damage is increased"
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BOUNCING_BALL_2] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{SoulHeart}} +1 Soul Heart",
			"{{SoulHeart}} If It's Tuesday, +3 Soul Hearts",
			"↑ +0.3 Damage Or ↓ -0.5 Range At Random",
			"↑ +3 Damage On Corpse I, Ashpit II, And Knife Piece 2 Chase Sequence",
			"↑ +0.66 Tears If The Filter Is On",
			"Balls Will Burst From Enemies Upon Defeat, Which Will Bounce Up And Down",
			"The Balls Have No Effect Towards Anything",
			"+20% Planetarium Chance If You Press G",
			"{{Pill}} Bosses On Scarred Womb II Can Only Die If You Use 10 Pills That Floor, But Pills Will Spawn Very Constantly During That Floor",
			"{{Damage}} Quest Items Cannot Be Picked Up +7 Damage When Trying To Pick One Up",
			"{{Bomb}} Gulps One Of Your Bombs",
			"{{Warning}} Its An Item Now",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PLATINUM_CREST] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +0.025 Damage upon clearing an active room",

		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ANARCHISTS_EASY_BAKE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Spawns a Troll Bomb in a random position of the room",
		},
		CarBattery = {
			PartialReplace = {
				[" a "] = " 2 ",
				["Troll Bomb"] = "{{CR}}Troll Bombs"
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SOAPSUDS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Luck}} 15% chance to fire Soapsud tears",
			"Soapsud tears turn champion enemies into non-champions, dropping their champion loot",
			"{{Luck}} 100% chance at 7 luck"
		},
		AbyssTests = {
			"40% chance to turn champion enemies into non-champions, dropping their champion loot"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CRY_BABY] = {

		StatusEffects = { mod.DescriptionStatuses.PACIFIED },
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Throws a tantrum after absorbing 10 enemy tears",
			"While throwing a tantrum, deflects enemy tears, pushes enemies away, and inflicts Pacified to nearby enemies",
		},
		AppendEntries = {
			"FF_APPEND_PACIFIED",
		},
		AbyssTests = {
			"10% chance to inflict Pacified"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ERASER_TWO] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Isaac's tears turn into erasers that instantly kill enemies",
			"Erased enemies are prevented from spawning during the rest of the run",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PARANOIA] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"20% chance to fire a tear that releases a ring of piercing, reflecting tears on hit",
			"{{Luck}} 100% chance at 8 luck",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.PHOENIX_ELIXIR] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{EmptyHeart}} +1 Empty heart container",
			"{{Collectible289}} On death, Isaac respawns, explodes, burns nearby enemies and releases a ring of fires",
			"{{Heart}} Once revived, heals half a heart once per room if below 2 red hearts",
			"{{Burning}} Once revived, +1 Damage and burning tears when on 1 red heart or less",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BEREAVEMENT] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Tears cycle between multiple tear effects",
			"29% chance for tears to inflict status effects",
			"{{Luck}} 100% chance at 7 luck",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SERTRALINE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"On use, destroys all enemy tears and briefly prevents new ones from spawning",
		},
		CarBattery = {
			Tests = {
				"{{Timer}} Time in which enemy tears are destroyed lasts longer"
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ISOLATED] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Orbital familiar that blocks projectiles",
			"{{Freezing}} Fires ice tears that deal 3.5 damage in cardinal directions away from the player",
			"On fire, aligns itself to cardinal directions in orbit",
			"Increases orbit distance of all orbitals",
		},
		BFFS = {
			TargetNumbers = {
				{ 3.5, 7 }
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ACUPUNCTURE_NEEDLES] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"33% chance to fire 3 tears in a very tight spread",
			"Each tear does 65% of Isaac's damage",
			"{{Luck}} 100% chance at 10 luck",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BOUNDLESS_PARASOL] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Spawns doors in cleared rooms that connect rooms by skipping over gaps in the map",
			"Reveals connected rooms on the map",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.HYPERFIXATION] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Attacking enemies indicated by the mark above them redirects all player and enemy tears in the room towards them",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.HARE_TRIGGER] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Seeks out nearby enemies, and rapidly shoots tears at them",
			"Deals 0.66 damage per tear",
		},
		BFFS = {
			TargetNumbers = {
				{ 0.66, 1.32 }
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.REPRESSION] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Orbital familiar that blocks projectiles",
			"Fires lasers that deal 3.5 damage",
			"33% chance to charge up a thick laser on blocking projectiles",
		},
		BFFS = {
			TargetNumbers = {
				{ 3.5, 7 }
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DUMB_BUNNY] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Shoots spectral tears backwards while moving",
			"Deals 2 damage per tear",
		},
		BFFS = {
			TargetNumbers = {
				{ 2, 4 }
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.RABBITS_FOOT] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +1 Luck",
			"{{Luck}} Increases Luck to 4 on first pickup",
			"If Luck is greater than 0 upon taking fatal damage, lose 4 Luck to destroy all enemy tears, briefly prevent new ones from spawning, and allow Isaac to continue to fight with half a heart",
			"Restore lost Luck by 1 each room",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GREEN_BOMBS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Bomb}} +5 Bombs",
			"Isaac's bombs explode faster",
			"Bombs placed by Isaac no longer damage him",
			"Bombs destroy all enemy tears and briefly prevent new ones from spawning when they explode",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CRUSHING_ANXIETY] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"10% chance on fire to drop a boulder on the closest enemy aligned with the shooting direction",
			"Deals damage that scales with Isaac's damage in a radius upon impact",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.OCULAR_SPECTRUM] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"While held, grants a satellite familiar",
			"Satellites scale with tear effects and damage",
			"On use, spins satellites around Isaac, spraying tears outwards",
		},
		BFFS = {
			Tests = {
				"Tear damage doubled"
			}
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DADS_SHORTS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +0.2 Speed",
			"{{Key}} Spawns a key",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SHADOW_RABBITS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"placeholder",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.EXTENSION] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Gives Isaac the effect of a random 100% Orange Juice card",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.TECH_ULTIMA] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"placeholder",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DAUNTING_DOG] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +1 Damage",
			"Does 5 damage per tear",
			"{{BossRoom}}{{MiniBoss}} Gained by picking up an item in the Boss Room or Mini-Boss Room",
			"{{ffBruise}} Tears inflict enemies with Bruised"
		},
		AppendEntries = {
			"FF_APPEND_BRUISE",
		},
		BFFS = {
			TargetNumbers = {
				{ 5, 10 }
			},
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.BRUISE},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DEWEY_DECIMAL_DOG] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +0.5 Tears",
			"Does 3.5 damage per tear",
			"{{Library}} Gained by picking up an item in a Library",
			"25% chance to fire 2 tears at once",
			"Tears turn 90 degrees to target enemies that they have missed"
		},
		BFFS = {
			TargetNumbers = {
				{ 3.5, 7 }
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DWARF_DOG] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +1 Luck",
			"Does 3 damage per tear",
			"{{Planetarium}} Gained by picking up an item in a Planetarium",
			"The dog's tears orbit around it while shooting"
		},
		BFFS = {
			TargetNumbers = {
				{ 3, 6 }
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ONION_DISC] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +0.1 Tears",
			"{{Timer}} Killing enemies has a 10% chance to give the effect of a random Onion item for 30 seconds",
			"{{Luck}} 100% chance at 45 luck"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.THE_HAPPY_GO_LUCKY_ONION] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +0.15 Speed",
			"↑ +0.15 Shot speed",
			"↑ +1.5 Luck",
			"{{Collectible1}} 3% chance to reroll item pedestals into Onion items when entering a room"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.MAGIC_BULLET] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"After every 7th tear fired, an explosive bullet can fire from either the left or right of the screen",
			"The bullet scales with Isaac's damage, and fires from the side of the screen furthest from Isaac",
			"{{Warning}} The bullet can collide with and damage Isaac",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BAD_DATA] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Familiar that teleports and glitches around the room",
			"When the familiar bumps into enemies, it does a random amount of damage and applies a random status effect"
		},
		BFFS = {
			Tests = {
				"Damage doubled"
			}
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.LIL_INABA] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Shoots tears from eye satellites that deal 1.25 damage",
			"Levels up from Anxiety Residue orbs that appear when killing enemies",
			"Leveling up grants the familiar more eye satellites"
		},
		BFFS = {
			TargetMultipliers = {1.25},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.CACEPI] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +40 Damage",
			"↓ x0.33 Fire rate multiplier",
			"↓ x0.8 Range multiplier",
			"↓ x0.8 Shot speed multiplier",
			"Isaac's tears are fired underground and into a lobbed angle",
			"The tears explode and poison enemies where they land",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GREEN_LEAF] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Image's special little item",
			"Please take good care of it",
			"Good luck in this challenge",
			"{{Heart}} I love you",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SHADOW_RABBITS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Spawns 6 rabbit familiars that seek out enemies and attack, scaling with Isaac's damage",
			"Isaac can possess large rabbits to control them and boost their damage",
			"While the rabbits are active, Isaac cannot shoot and is intangible",
			"Lasts for around 45 seconds or 4 uncleared rooms",
			"33% chance to passively spawn a small rabbit familiar each room"
		},
		CarBattery = {
			Tests = {
				"Doubles the amount of large rabbits"
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GUNSLINGERS_GRIT] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Burning}} Creates a ring of fire that blocks projectiles, deals damage, and inflicts Burning on enemies",
			"↑ Fading +7 Tears up",
		},
		PlayerSpecificTests = {
			mod.PLAYER.BRIEND,
			"Tainted Friend swaps her guns",
			"{{Burning}} Creates a ring of fire that blocks projectiles, deals damage, and inflicts Burning on enemies",
			"↑ Fading +7 Tears up",
			"{{HalfHeart}} {{HalfSoulHeart}} Chance for enemies to drop half red and soul hearts when under the Tears up boost and when killed by the ring of fire",
		},
		CarBattery = false,
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.STEVEN_SANDWICH] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Heart}} +1 Health",
			"{{HealingRed}} Heals 1 heart",
			"{{ffStevenHeart}} +3 Steven Hearts",
			"Steven hearts go over other hearts and shoot at enemies from the HUD",
		},
		AbyssTests = {
			"Locust will travel through one side of the screen and come out the other side"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.YCUK_HEART] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{ffStevenHeart}} +1 Steven Heart",
			"Steven hearts go over other hearts and shoot at enemies from the HUD",
		},
		AbyssTests = {
			"Locust will travel through one side of the screen and come out the other side"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DEAL_OF_THE_DEMONS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +0.5 Damage",
			"↑ +1.5 Shot speed",
			"Homing tears",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SOUL_EXTRACTION_BUM] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"Goes to nearby enemies and extracts their souls",
			"{{Slow}} Enemies that have their soul extracted are affected with Slowness",
			"Summons a variety of effects every 3-5 souls extracted",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.MYSTERIOUS_FEDORA] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"20% chance for a mysterious stranger to appear in a room",
			"The stranger fires 6 shots from a gun that do 20 damage",
			"When they disappear, they leave behind either a bomb, key or coin",
			"The stranger gives you the consumable you have less of"
		},
		BFFS = {
			Tests = {
				"Gun deals double damage"
			},
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BAPHOMETS_EXCHANGE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Coin}} Spend 5 coins to get a random stat milk",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SKIBIDI_BABY] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Collectible291}} 10% chance to use Flush! when it is hit by an enemy tear",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.COOL_SKULL_INSIGNIA] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"↑ +0.02 Speed"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GOLEMS_WISHLIST] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Warning}} SINGLE USE {{Warning}}",
			"{{Heart}} Used to write a letter to Santa",
			"When Isaac finishes writing his letter, three Golem rocks spawn"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SWORD_OF_FRACTURED_MODS] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
		
		]],
		Tests = {
			"{{Warning}} Prevents all modded code from running {{Warning}}",
			"Requires a full game restart to fix",
			"↑ +0.3 Damage",
		},
	},
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
		Name = "파이어볼 +3",
		QuoteDesc = "준비 끝!",
		Description = [[
			파이어볼 불꽃을 3마리 소환합니다.(최대 12)
			공격키를 두번 누르면 불꽃을 소모하여 공격하는 방향으로 파이어볼을 발사합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.REVERSE_3_FIREBALLS] = {
		_descType = "card",
		Name = "파이어볼? +3",
		QuoteDesc = "준비 악?",
		Description = [[
			{{Collectible]] .. FiendFolio.ITEM.COLLECTIBLE.MALICE .. [[}} 캐릭터의 공격방향으로 벽에 여러번 부딪힐 때까지 돌진합니다.
			{{HalfBlackHeart}} 돌진 상태에서 적 처치 시 낮은 확률로 블랙하트를 드랍합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.IMPLOSION] = {
		_descType = "card",
		Name = "내부파열",
		QuoteDesc = "폭발로부터 소환",
		Description = [[
			사용 시 3방향으로 초록색 Fiend의 파이어볼 불꽃을 즉시 발사합니다.
			파이어볼 폭파 시 Fiend의 부하를 소환합니다.
			Fiend의 부하는 방 클리어 시 소멸합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CALLING_CARD] = {
		_descType = "card",
		Name = "사신 호출 카드",
		QuoteDesc = "",
		Description = [[
			{{Charm}} 사용 시 아군 Psi Hunter 몬스터를 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.PLAGUE_OF_DECAY] = {
		_descType = "card",
		Name = "부패 역병",
		QuoteDesc = "전염병 전이자",
		Description = [[
			{{RottenHeart}} 사용 시 썩은하트 +5
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GROTTO_BEAST] = {
		_descType = "card",
		Name = "어두운 곳의 짐승",
		QuoteDesc = "레어 등급 1장 확정!",
		Description = [[
			{{Charm}} 사용 시 Fiend Folio 출신의 아군 몬스터를 하나 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.DEFUSE] = {
		_descType = "card",
		Name = "해체",
		QuoteDesc = "폭발이여 사라져라",
		Description = [[
			{{Bomb}} 사용 시 트롤폭탄 및 폭탄이 박힌 돌을 해체하여 폭탄 픽업으로 바꾸며;
			폭발성 몬스터를 일반형으로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.POT_OF_GREED] = {
		_descType = "card",
		Name = "욕망의 항아리",
		QuoteDesc = "카드 2장 드로우",
		Description = [[
			{{Card}} 카드를 2장 드랍합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.DARK_HOLE] = {
		_descType = "card",
		Name = "블랙홀",
		QuoteDesc = "파괴하라",
		Description = [[
			{{Collectible512}} 블랙홀을 던집니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.EYE_OF_TRUTH] = {
		_descType = "card",
		Name = "진실의 눈",
		QuoteDesc = "뭐가 들었나?",
		Description = [[
			{{Collectible665}} 그 방에서 상자, 자루, 상점 주인 등의 보상이 보입니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.DESTINY_BOARD] = {
		_descType = "card",
		Name = "위저 보드",
		QuoteDesc = "끝낼 시간",
		Description = [[
			{{Warning}} 사용 시 Cyanide 알약 적용:
			{{Timer}} 발동 중일 때 모든 능력치 증가:
			{{IND}} {{SpeedSmall}} 이동속도 +0.05
			{{IND}} {{TearsSmall}} 연사 배율 x1.3
			{{IND}} {{DamageSmall}} 공격력 배율 x1.5
			{{IND}} {{RangeSmall}} 사거리 +0.62
			방 클리어 시 알약이 등장할 확률이 대폭 증가합니다.
			!!! 다른 알약을 사용하지 않았을 경우 60초 후 캐릭터가 즉사합니다."
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
		Name = "미안!",
		QuoteDesc = "데헷~!",
		Description = [[
			{{Collectible422}} 사용 시 상태를 이전 방으로 되돌립니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CARDJITSU_SOCCER] = {
		_descType = "card",
		Name = "축구",
		QuoteDesc = "혹자는 이걸 풋볼이라고 부른다네",
		Description = [[
			사용 시 그 방에서 굴릴 수 있는 축구공을 소환합니다.
			축구공은 접촉 시 적에게 속도에 비례한 피해를 줍니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CARDJITSU_FLOORING_UPGRADE] = {
		_descType = "card",
		Name = "바닥 업그레이드",
		QuoteDesc = "버건디 스타일",
		Description = [[
			사용 시 그 방 전체에 랜덤 장판을 깝니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CARDJITSU_AC_3000] = {
		_descType = "card",
		--Name = '',
		QuoteDesc = "무한 냉기",
		Description = [[
			{{Freezing}} 그 방에서 적 처치 시 해당 적을 얼립니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.MISPRINTED_GISH] = {
		_descType = "card",
		Name = "",
		QuoteDesc = "기쉬 소환?",
		Description = [[
			아군 Gish를 소환합니다.
			가까운 적에게 착지, 폭발 타르를 발사 후 떠납니다.
		]],
	},
  [CARD..FiendFolio.ITEM.CARD.SEAL_OF_ORICHALCOS] = {
		_descType = "card",
		Name = "오리컬코스의 결계",
		QuoteDesc = "나의 힘을 갈구하라, 그리하면 커다란 힘 그대에게 깃들지어다",
		Description = [[
			사용 시 거대한 결계를 소환합니다.
			{{Collectible584}} 결계 안의 적 처치 시 위습을 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.FRIENDLY_FIRE] = {
		_descType = "card",
		Name = "친절한 화염",
		QuoteDesc = "보랏빛 광선",
		Description = [[
			{{Collectible]] .. FiendFolio.ITEM.COLLECTIBLE.FRIENDS_FIREBALL_FORMULA .. [[}} 사용 시 그 방에서 Friend's Fireball Formula 지급:
			{{IND}} {{Burning}} 5%의 확률로 적에게 화상을 입히는 공격이 나갑니다.
			{{IND}} 화상 상태의 적 처치 시 십자 모양으로 불꽃 웨이브가 나갑니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.NEKO_NYAN_QUIZ_CARD] = {
		_descType = "card",
		Name = "네코냥 퀴즈",
		QuoteDesc = "너의 영원한 파트너는?",
		Description = [[
			{{Timer}} 30초간 캐릭터가 Goby로 변신합니다:
			{{Blank}} (비행/공격 명중 시 확률적으로 아군 딱정벌레 소환/아군 딱정벌레는 적 탄환을 막아줌)
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
		AppendEntries = {
			"FF_APPEND_BERSERK",
		},
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
		]],
		AppendEntries = {
			"FF_APPEND_OVERLOADED",
		},
	},
	[CARD..FiendFolio.ITEM.CARD.ENERGY_FIGHTING] = {
		_descType = "card",
		Name = "힘 에너지",
		QuoteDesc = '',
		Description = [[
			{{ffBruise}} 방 안의 모든 적이 멍듦 상태가 됩니다.
		]],
		AppendEntries = {
			"FF_APPEND_BRUISE",
		},
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
		]],
		AppendEntries = {
			"FF_APPEND_MULTIEUCLIDEAN",
		},
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
		]],
		AppendEntries = {
			"FF_APPEND_HEMORRHAGE",
		},
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
		AppendEntries = {
			"FF_APPEND_MUGGED",
		},
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
		AppendEntries = {
			"FF_APPEND_PACIFIED",
		},
	},
	[CARD..FiendFolio.ITEM.CARD.OJ_MIX_PHENOMENON] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Collectible]] .. tostring(FiendFolio.ITEM.COLLECTIBLE.HUNDRED_PERCENT_ORANGE_JUICE) .. [[}} If there are less than 3 Orange Juice tiles, spawns up to 3
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
			{{Collectible]] .. tostring(FiendFolio.ITEM.COLLECTIBLE.D3) .. [[}} Activates the D3 effect for the room, spawning an orbital familiar that rerolls tears
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_D5] = {
		_descType = "card",
		Name = '',
		QuoteDesc = '',
		Description = [[
			{{Collectible]] .. tostring(FiendFolio.ITEM.COLLECTIBLE.D5) .. [[}} Activates the D5 effect for the room, spawning a dice that can be thrown around
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
			!!! ]]..FiendFolio.DescriptionIcons.China..[[ China 전용
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
		AppendEntries = {
			"FF_APPEND_PACIFIED",
		},
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
		AppendEntries = {
			"FF_APPEND_COPPER_BOMB",
		},
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
			{{ffCursedPenny}} 저주페니 2~4개를 소환합니다.
			{{ffCursedPenny}} 그 방의 모든 동전 픽업을 저주페니로 바꿉니다.
		]],
		AppendEntries = {
			"FF_APPEND_CURSED_PENNY",
		},
	},
	[CARD..FiendFolio.ITEM.CARD.JACK_OF_CLUBS] = {
		_descType = "card",
		Name = "클로버 J",
		QuoteDesc = '',
		Description = [[
			{{ffCopperBomb}} 구리폭탄 2~3개를 소환합니다.
			{{ffCopperBomb}} 그 방의 모든 폭탄 픽업을 구리폭탄으로 바꿉니다.
		]],
		AppendEntries = {
			"FF_APPEND_COPPER_BOMB",
		},
	},
	[CARD..FiendFolio.ITEM.CARD.JACK_OF_SPADES] = {
		_descType = "card",
		Name = "스페이드 J",
		QuoteDesc = '',
		Description = [[
			{{ffSpicyKey}} 매운열쇠 2~3개를 소환합니다.
			{{ffSpicyKey}} 그 방의 모든 열쇠 픽업을 매운열쇠로 바꿉니다
		]],
		AppendEntries = {
			"FF_APPEND_SPICY_KEY",
		},
	},
	[CARD..FiendFolio.ITEM.CARD.JACK_OF_HEARTS] = {
		_descType = "card",
		Name = "하트 J",
		QuoteDesc = '',
		Description = [[
			{{ffImmoralHeart}} 소지 중인 모든 소울하트/블랙하트를 이모럴하트로 바꿉니다.
			{{ffImmoralHeart}} 소지 중인 {{SoulHeart}}/{{BlackHeart}}가 없을 경우 이모럴하트 하나를 드랍합니다.
		]],
		AppendEntries = {
			"FF_APPEND_IMMORAL_HEART",
		},
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
		QuoteDesc = "임포스터",
		Description = [[
			{{CurseLostSmall}} 그 스테이지에서 맵에 특수방 위치, 비밀방 위치, 스테이지 구조가 표시됩니다 (?)
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SOUL_OF_FIEND] = {
		_descType = "card",
		Name = "핀드의 영혼",
		QuoteDesc = "물량의 힘",
		Description = [[
			사용 시 Fiend의 부하를 5~8마리(일반형)와 0~2마리(블랙형) 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SOUL_OF_GOLEM] = {
		_descType = "card",
		Name = "골렘의 영혼",
		QuoteDesc = "락 온!",
		Description = [[
			{{Trinket}} 석기 장신구를 3개 드랍합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SOUL_OF_RANDOM] = {
		_descType = "card",
		Name = "미지의 영혼석",
		QuoteDesc = "나는 누굴까?",
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
			{{Collectible]] .. tostring(FiendFolio.ITEM.COLLECTIBLE.EXCELSIOR) .. [[}} Using your active item will shoot fireworks based on the amount of item charge
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
		QuoteDesc = "충전 좀 줘",
		Description = [[
			{{Battery}} 사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.
			충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다. (초과 충전 가능)
			!!! {{Card]] .. tostring(FiendFolio.ITEM.CARD.CORRODED_BATTERY_0) .. [[}} 스테이지 진입 시 부식되며 부식된 상태에서 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.STORAGE_BATTERY_1] = {
		_descType = "card",
		Name = "보조 배터리",
		QuoteDesc = "충전 좀 줘",
		Description = [[
			{{Battery}} 사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.
			충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다. (초과 충전 가능)
			!!! {{Card]] .. tostring(FiendFolio.ITEM.CARD.CORRODED_BATTERY_1) .. [[}} 스테이지 진입 시 부식되며 부식된 상태에서 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.STORAGE_BATTERY_2] = {
		_descType = "card",
		Name = "보조 배터리",
		QuoteDesc = "충전 좀 줘",
		Description = [[
			{{Battery}} 사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.
			충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다. (초과 충전 가능)
			!!! {{Card]] .. tostring(FiendFolio.ITEM.CARD.CORRODED_BATTERY_2) .. [[}} 스테이지 진입 시 부식되며 부식된 상태에서 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.STORAGE_BATTERY_3] = {
		_descType = "card",
		Name = "보조 배터리",
		QuoteDesc = "충전 좀 줘",
		Description = [[
			{{Battery}} 사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.
			충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다. (초과 충전 가능)
			!!! {{Card]] .. tostring(FiendFolio.ITEM.CARD.CORRODED_BATTERY_3) .. [[}} 스테이지 진입 시 부식되며 부식된 상태에서 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CORRODED_BATTERY_0] = {
		_descType = "card",
		Name = "부식된 배터리",
		QuoteDesc = "폭발할라",
		Description = [[
			{{Battery}} 사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.
			충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다. (초과 충전 가능)
			!!! 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CORRODED_BATTERY_1] = {
		_descType = "card",
		Name = "부식된 배터리",
		QuoteDesc = "폭발할라",
		Description = [[
			{{Battery}} 사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.
			충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다. (초과 충전 가능)
			!!! 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CORRODED_BATTERY_2] = {
		_descType = "card",
		Name = "부식된 배터리",
		QuoteDesc = "폭발할라",
		Description = [[
			{{Battery}} 사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.
			충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다. (초과 충전 가능)
			!!! 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CORRODED_BATTERY_3] = {
		_descType = "card",
		Name = "부식된 배터리",
		QuoteDesc = "폭발할라",
		Description = [[
			{{Battery}} 사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.
			충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다. (초과 충전 가능)
			!!! 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SOUL_OF_FRIEND] = {
		_descType = "card",
		Name = "프렌드의 영혼",
		QuoteDesc = '',
		Description = [[
			Grants Isaac a random gun with limited ammo
			Gun fires along with Isaac's tears
			Disappears after running out of ammo
		]],
	},
	--#endregion

	--#region PILLS
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
			"FF_APPEND_DROWSY",
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
		Name = "응급 피임약",
		QuoteDesc = "",
		Description = [[
			{{Collectible8}} Fragile Bobby를 소환합니다.
			{{Collectible8}} Fragile bobby는 Brother Bobby와 동일하나 5회 피격 시 사라집니다.
		]],
	},
	[PILL..FiendFolio.ITEM.PILL.BRIMSTONE] = {
		_descType = "pill",
		Name = "혈사포 XD",
		QuoteDesc = "",
		Description = [[
			{{Collectible118}} 혈사포를 획득합니다.
		]],
	},
	[PILL..FiendFolio.ITEM.PILL.SERTRALINE] = {
		_descType = "pill",
		Name = "세르트탈린",
		QuoteDesc = "적 탄환 제거",
		Description = [[
			{{Collectible]] .. FiendFolio.ITEM.COLLECTIBLE.SERTRALINE .. [[}} 적의 탄환을 모두 지웁니다.
		]],
	},
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
entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_2] = entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_1]
entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_3] = entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_1]
entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_4] = entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_1]
entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_5] = entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_1]
entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_6] = entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_1]
entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_8] = entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_1]
entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_12] = entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_1]
entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.MY_STORY_2] = entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.EMPTY_BOOK]
entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.MY_STORY_4] = entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.EMPTY_BOOK]
entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.MY_STORY_6] = entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.EMPTY_BOOK]
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