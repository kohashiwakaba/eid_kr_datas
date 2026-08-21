if not FiendFolio then return end

local versionRequ = "3.1"
local versionNext = "3.1"

if (FiendFolio and not FiendFolio.CheckFiendFolioModVersion) or FiendFolio:CheckFiendFolioModVersion(versionRequ, true) then
	table.insert(wakaba_krdesc.ERRORS, {
		err_mod = "Fiend Folio",
		current = FiendFolio.modVersionNumber,
		required = versionRequ,
	})
	return
end

--[[  
	메모 : 이나바 해금 선행 조건
	1. 핀드, 골렘, 프렌드 노멀 캐릭터 전부 해금 (이건 올해금 커맨드로 스킵 가능)
	2. 핀드, 골렘, 프렌드 세 캐릭터로 각각 아래 중 하나 격파 (체크리스트 올클 안해도 되나 보라색이 찍혀 있어야 됨, 노멀 알트 상관없이 한 쪽만 깨도 OK)
	  - ???, 램, 메가사탄, 그리디어, 델리리움, 마더, 비스트
	3. 델리리움 1회 이상 격파 (Delirious 아이템이 해금되어 있어야 됨. 목표가 델리라서 그럼)
	메모 : 이나바 해금 방법
	1. 위 조건 만족 시 1스테이지 일급비밀방은 이나바 해금 전까지 특정 구조로 고정됨
	2. 일급비밀방에서 토끼를 터치하면 특수 챌린지 시작 (시스템 상 목표는 델리인데 6층 엄마발 직후 바로 보이드로 직행)
	3. 토끼는 이리저리 돌아다니면서 플레이를 방해함 (유도가 토끼한테 가는 건 예삿일이고 지 맘대로 돈 써서 상점 템도 삼)
	4. 이와중에 토끼를 지키면서 델리 깨야 됨. 중간에 토끼가 죽으면 실패. 토끼 피격 판정이 너그러운 게 다행
	5. 델리 깨면 토끼가 트로피 꿀꺽하는데 그 이후 나온 알약 먹으면 이나바 캐릭터 해금, 이후 재도전은 모드 챌린지 메뉴를 통해 가능함
	  - [FFBonus!] Follow the Rabbit
]]

local mod = FiendFolio

local CHAR = "-997.-1."
local ITEM = "5.100."
local TRINKET = "5.350."
local CARD = "5.300."
local PILL = "5.70."
local CURSE ="-998.-1."

if not FiendFolio.ITEM.ROCK.FOSSILIZED_EYE then
	FiendFolio.ITEM.ROCK.FOSSILIZED_EYE = FiendFolio.ITEM.TRINKET.FOSSILIZED_EYE
end

EID._currentMod = "Fiend Folio"

---@type table<string, WakabaDescriptionEntry>
local entries = {
	--#region APPENDS
	--#region MISC
	["FF_APPEND_IMMORAL_HEART"] = {
		_descType = "append",
		Description = [[
			{{ffImmoralHeart}} {{ColorOrange}}이모럴하트: {{ColorGray}}피격 시 소지 중 {{ffImmoralHeart}}가 Fiend의 부하로 바뀌며;
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
			{{ffCopperBomb}} {{ColorOrange}}구리폭탄: {{ColorGray}}폭탄이 불발하거나 범위가 큰 폭발을 일으킴
		]],
	},
	["FF_APPEND_SPICY_KEY"] = {
		_descType = "append",
		Description = [[
			{{ffSpicyKey}} {{ColorOrange}}매운열쇠: {{ColorGray}}등장 시 열쇠가 하나 추가되나, 체력 반칸의 피해
		]],
	},
	["FF_APPEND_SKUZZES"] = {
		_descType = "append",
		Description = [[
			{{ColorOrange}}벼룩: {{ColorGray}}적을 향해 점프하며, 착지 상태에서 공격력 x3의 피해를 줍니다.
		]],
	},
	["FF_APPEND_BEETLES"] = {
		_descType = "append",
		Description = [[
			{{ColorOrange}}무당벌레: {{ColorGray}}적과 탄환으로부터 캐릭터를 보호하려 하며 일정 수 막으면 사라집니다.
		]],
	},
	["FF_APPEND_MORBID_HEART"] = {
		_descType = "append",
		Description = [[
			{{ffMorbidHeart}} {{ColorOrange}}종양하트: {{ColorGray}}3회 피격 시 사라짐, 빨간하트로 회복 가능
			>>> {{ColorGray}}종양하트가 사라지면 임시 공전형 패밀리어 소환
		]],
	},
	["FF_APPEND_STEVEN_HEART"] = {
		_descType = "append",
		Description = [[
			{{ffStevenHeart}} {{ColorOrange}}스티븐하트: {{ColorGray}}해당 하트칸에 있는 하트 소진 시 사라짐, 동일 종류 하트로 회복 가능
			>>> {{ColorGray}}UI의 하트에서 주기적으로 유도 + 지형 관통 눈물을 발사합니다.
		]],
	},
	["FF_APPEND_SHIELD_HEART"] = {
		_descType = "append",
		Description = [[
			{{ffShieldHeart}} {{ColorOrange}}쉴드하트: {{ColorGray}}3회 피격 시 사라짐, 소울하트로 회복 가능
		]],
	},
	["FF_APPEND_TOKENS"] = {
		_descType = "append",
		Description = [[
			{{ffToken}} {{ColorOrange}}토큰: {{ColorGray}}가장 최근에 획득한 픽업을 다시 획득
		]],
	},
	["FF_APPEND_DIRE_CHEST"] = {
		_descType = "append",
		Description = [[
			{{ffDireChest}} {{ColorOrange}}트롤상자: {{ColorGray}}저주받은 픽업을 드랍하나 일정 확률로 폭발합니다.
		]],
	},
	--#endregion
	--#region STATUS EFFECTS
	["FF_APPEND_BERSERK"] = {
		_descType = "append",
		Description = [[
			{{ffBerserk}} {{ColorOrange}}폭주: {{ColorGray}}공격 목표를 수시로 바꾸고 추가 피해를 받으나 더 빠르게 행동
		]],
	},
	["FF_APPEND_BRUISE"] = {
		_descType = "append",
		Description = [[
			{{ffBruise}} {{ColorOrange}}멍듦: {{ColorGray}}해당 상태 중첩 수만큼 추가 피해
		]],
	},
	["FF_APPEND_DOOM"] = {
		_descType = "append",
		Description = [[
			{{ffDoom}} {{ColorOrange}}둠: {{ColorGray}}명중 시마다 카운트가 감소
			{{Blank}} {{ColorGray}}카운트가 0이 될 때 추가 피해 + 상태 제거
		]],
	},
	["FF_APPEND_DROWSY"] = {
		_descType = "append",
		Description = [[
			{{ffSleeping}} {{ColorOrange}}나른함: {{ColorGray}}서서히 둔화되며 잠듦
			{{Blank}} {{ColorGray}}잠든 적 명중 시 추가 피해 + 상태 제거
		]],
	},
	["FF_APPEND_HEMORRHAGE"] = {
		_descType = "append",
		Description = [[
			{{ffHemorrhage}} {{ColorOrange}}대출혈: {{ColorGray}}주기적으로 피해를 받고 붉은 장판을 깔며 랜덤 방향으로 핏방울을 흩뿌림
		]],
	},
	["FF_APPEND_MARTYR"] = {
		_descType = "append",
		Description = [[
			{{ffMartyr}} {{ColorOrange}}순교: {{ColorGray}}처치 시 오라와 함께 5초간 행동불능
			{{Blank}} {{ColorGray}}오라 안에 있는 캐릭터는 {{DamageSmall}}/{{TearsSmall}} 증가 + 유도공격 + 50%의 확률로 피해 무시
		]],
	},
	["FF_APPEND_SEW"] = {
		_descType = "append",
		Description = [[
			{{ffSew}} {{ColorOrange}}귀속: {{ColorGray}}피해를 받으면 다른 귀속된 적도 같이 피해
		]],
	},
	["FF_APPEND_MULTIEUCLIDEAN"] = {
		_descType = "append",
		Description = [[
			{{ffMultieuclidean}} {{ColorOrange}}기하: {{ColorGray}}공격이 해당 적을 관통
			{{Blank}} {{ColorGray}}관통 시 공격이 2개로 복제 + 유도공격
		]],
	},
	["FF_APPEND_EXCOMMUNICATED"] = {
		_descType = "append",
		Description = [[
			{{ffExCommunicated}} {{ColorOrange}}전이: {{ColorGray}}잠시동안 방에서 사라지며 일정 시간 후 사라진 위치에 돌아옴
			{{Blank}} {{ColorGray}}돌아올 때 추가 피해
		]],
	},
	["FF_APPEND_OVERLOADED"] = {
		_descType = "append",
		Description = [[
			{{ffOverloaded}} {{ColorOrange}}과부하: {{ColorGray}}주기적으로 피해를 받으며 전류 레이저를 방출
			{{Blank}} {{ColorGray}}과부하 전류에 맞은 적도 과부하에 걸릴 수 있음
		]],
	},
	["FF_APPEND_MUGGED"] = {
		_descType = "append",
		Description = [[
			{{ffMugged}} {{ColorOrange}}약탈: {{ColorGray}}공격 명중 및 처치 시 리틀 페니 드랍
			{{Blank}} {{ColorGray}}리틀 페니 10개 획득 시 1{{Coin}}
		]],
	},
	["FF_APPEND_PACIFIED"] = {
		_descType = "append",
		Description = [[
			{{ffPacified}} {{ColorOrange}}진정: {{ColorGray}}캐릭터에게 피해를 줄 수 없음
		]],
	},
	["FF_APPEND_NURSING"] = {
		_descType = "append",
		Description = [[
			{{ffNursing}} {{ColorOrange}}치유: {{ColorGray}}캐릭터에게 주는 피해가 반전됨 (반칸 피해 -> 반칸 회복)
		]],
	},
	["FF_APPEND_GLEAMING"] = {
		_descType = "append",
		Description = [[
			{{ffGleaming}} {{ColorOrange}}광택: {{ColorGray}}주변의 다른 적에게 다른 상태이상 전이
		]],
	},
	--#endregion
	--#region GOLEM INFOS
	["FF_APPEND_GOLEM_NORMAL"] = {
		_descType = "append",
		Description = [[
			{{ffRock}} {{ColorTransform}}석기류: {{ColorGray}}일반적으로 등장하지 않는 Golem 전용 장신구
		]],
	},
	["FF_APPEND_GOLEM_FOSSIL"] = {
		_descType = "append",
		Description = [[
			{{ffFossil}} {{ColorRed}}화석류: {{ColorGray}}분해 시 추가 효과
		]],
	},
	["FF_APPEND_GOLEM_GEODE"] = {
		_descType = "append",
		Description = [[
			{{ffGeode}} {{ColorTeal}}정동류: {{ColorGray}}소지 중인 석기 2개가 모두 정동류일 때 공명 효과
		]],
	},
	--#endregion
	--#endregion

	--#region TRANSFORMATIONS
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
	[CHAR .. FiendFolio.PLAYER.SKELETAL_FIEND] = {
		_descType = "player",
		Name = "핀드-타니쉬드",
		ReminderName = "Skeletal Fiend",
		Short = [[
		]],
		Description = [[
			{{EmptyBoneHeart}} 최대 체력 = 뼈하트의 보정을 받습니다. (빨간하트를 채울 수 없음)
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.PYROMANCY..[[}} 고유 능력 : 방화술사
			{{Blank}} (파이어볼이 자동 생성되지 않으며 50 + (스테이지 수 * 10)의 피해를 줄 때마다 생성됨)
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.PYROMANCY..[[}} 파이어볼로 적 처치 시 이모럴하트가 아닌 뼛조각 배리어가 등장함
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.BONE_HURTING_JUICE..[[}} 고유 능력 : 뼈갈이
		]],
		Birthright = [[
			티배깅 시 주변의 적에게 공격력 x1의 폭발 피해를 줍니다.
			{{Blank}} (티배깅 키 : + 혹은 -)
		]],
		BirthrightQuote = "뼈아픈 티배깅",
	},
	[CHAR .. FiendFolio.PLAYER.GOLEM] = {
		_descType = "player",
		Name = "골렘",
		ReminderName = "Golem",
		Short = [[
		]],
		Description = [[
			골렘은 오래 전 The Devil's Harvest 모드와 색돌에서 유래하였습니다.
			{{Trinket}} 장신구 등장 시 확률적으로 석기류나 룬으로 바뀝니다.
			{{Collectible139}} 장신구를 처음부터 2개를 동시에 들고 다닐 수 있습니다.
			{{Trinket}} 비밀방 진입 및 보스방 클리어 시 석기류를 추가로 드랍합니다.
			주요 특수방에서 서브웨이라는 특수방으로 이동할 수 있으며 서브웨이에서는 각 특수방별 숏컷 및 여러 보조 동료가 있습니다.
		]],
		Birthright = [[
			{{LuckSmall}} 행운 +2
			색돌 파괴 시 소울하트 대신 석기류를 드랍합니다.
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
			{{Trinket}} 비밀방 진입 시 석기류를 추가로 드랍합니다.
			{{Collectible}} {{TreasureRoom}}/{{BossRoom}} 아이템 등장 시 석기류로 바뀝니다.
			주요 특수방에서 서브웨이라는 특수방으로 이동할 수 있으며 서브웨이에서는 각 특수방별 숏컷 및 여러 보조 동료가 있습니다.
			!!! 패널티 피격 시 {{{ColorRed}}50%의 확률{{CR}}로 흡수 및 소지 중인 석기 혹은 아이템 중 하나가 강제로 버려지거나 파괴됩니다. (방 당 1회, 석기가 버려질 때 33%의 확률로 파괴)
			>>> 파괴 확률은 패널티 피격 시마다 증가하며 비역행 스테이지 진입 시 초기화됩니다.
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.OVERCLOCK..[[}} 고유 능력 : 오버클럭
		]],
		Birthright = [[
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.OVERCLOCK..[[}} Overclock 사용 시 그 방에서 근접 공격을 추가로 합니다.
			근접 공격으로 장애물을 부술 수 있으며 이 공격으로 부순 장애물은 확률적으로 석기류를 드랍합니다.
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
			{{Heart}} {{ColorYellow}}불릿하트{{CR}}: 눈물 대신 탄환을 발사하며 탄환의 수량은 현재 소지 중인 체력에 비례합니다.
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
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.GUNSLINGERS_GRIT..[[}} 고유 능력 : 총잡이의 끈기
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.GUNSLINGERS_GRIT..[[}} Gunslinger's Grit 사용 시 총을 교체하며 {{HalfHeart}} {{HalfSoulHeart}} 화염으로 적 처치 시 확률적으로 하트류 반칸을 드랍합니다.
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
			이나바는 알 수 없는 곳에서 온 교활한 토끼입니다.
			캐릭터 주변의 눈알 모양의 새틀라이트가 같이 공격합니다.
			>>> 새틀라이트의 공격력: 공격력 x0.25~x0.5 (연사 비례)
			{{ColorYellow}}불안 오브{{CR}}: 적 처치 시 드랍되며 일정 수 이상 모으면 새틀라이트의 레벨이 상승합니다.
			새틀라이트 레벨에 따라 공격하는 새틀라이트 수가 늘어납니다. (최대 4, 연사 비례 최대 8)
			!!! 피격 시 불안 오브가 일정량 차감되며 새틀라이트 레벨이 하락할 수 있음
			{{ColorYellow}}민감도{{CR}}: 적 명중 시 혹은 처치 시 게이지가 채워지며 완충 시 Migraine 모드를 자동으로 발동합니다.
			{{ColorYellow}}Migraine{{CR}}: 발동 시 공격력이 증가하나 연사가 소폭 감소하며 새틀라이트의 공격이 적을 관통합니다.
			Migraine 모드 중에는 민감도가 지속적으로 감소합니다.
		]],
		Birthright = [[
			민감도 상승량 증가
			Migraine 모드 발동 중에도 적 처치 시 민감도를 회복할 수 있습니다.
			{{HolyMantleSmall}} Migraine 모드 진입 시 피격을 1회 막아주는 보호막을 생성하나;
			>>> 보호막 파괴 시 민감도의 50%가 차감됩니다.
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
			공격할 수 없으며 캐릭터 주변의 눈알 모양의 새틀라이트가 대신 공격합니다.
			{{ButtonRT}} Ctrl 키를 누르는 동안 새틀라이트의 위치가 고정됩니다.
			{{Chargeable}} 고정 중 충전되며 완충 후 해제 시 캐릭터에게 돌아오면서 회전 공격을 합니다.
			>>> 새틀라이트의 공격력: 공격력 x1 + 유도 공격
			{{ColorYellow}}불안 오브{{CR}}: 적 처치 시 드랍되며 일정 수 이상 모으면 새틀라이트의 레벨이 상승합니다.
			{{DamageSmall}} 새틀라이트 레벨마다 공격력 +0.5
			!!! 피격 시 불안 오브가 일정량 차감되며 새틀라이트 레벨이 하락할 수 있음
			{{ColorYellow}}불안도{{CR}}:피격 시 게이지가 채워지며 완충 시 Migraine 모드를 자동으로 발동합니다.
			{{ColorYellow}}Migraine{{CR}}: 발동 시 공격력이 소폭 감소하나 연사 및 사거리가가 증가하며 새틀라이트의 공격이 적을 관통합니다.
			Migraine 모드 중에는 민감도가 지속적으로 감소합니다.
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.OCULAR_SPECTRUM..[[}} 고유 능력 : 오큘러 스펙트럼
			>>> 새틀라이트의 회전 공격으로 피해를 준 만큼 추가 충전을 하며 추가 충전량에 비례하여 Ocular Spectrum 사용 시 추가 눈물을 발사합니다.
		]],
		Birthright = [[
			새틀라이트 회전 공격 시 그 위치에 그림자 눈알을 소환합니다.
			그림자 눈알은 캐릭터 공격 시 같이 공격하며 가장 가까운 적을 향해 공격합니다.
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
			제발 나 좀 구해줘
		]],
		Birthright = [[
			방해요소 증가
		]],
		BirthrightQuote = "Sensory overload",
	},
	--#endregion
	--#region JOKE PLAYERS
	[CHAR .. FiendFolio.PLAYER.FEND] = {
		_descType = "player",
		Name = "펜드",
		ReminderName = "Fend",
		Short = [[
		]],
		Description = [[
		]],
		Birthright = [[
			효과 없음
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
			클리어하지 않은 방에서 주기적으로 녹색 장판을 생성하는 눈물을 흩뿌립니다.
		]],
		Birthright = [[
			장판 눈물 생성 증가
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
			약봉지 드랍 증가
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
			명중하지 않은 눈물이 Fiend의 부하로 바뀝니다.
			바뀐 부하는 시간이 지나거나 방 클리어 시 사라집니다.
		]],
		Birthright = [[
			바뀐 부하가 
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
			{{Chargeable}} 충전 공격 시 그 방의 적, 픽업, 장애물을 지웁니다.
		]],
		Birthright = [[
			충전 공격이 게임을 추가로 지웁니다.
		]],
		BirthrightQuote = "메타 포텐셜",
	},
	[CHAR .. FiendFolio.PLAYER.PEAT] = {
		_descType = "player",
		Name = "Peat",
		ReminderName = "Peat",
		Short = [[
		]],
		Description = [[
			???
		]],
		Birthright = [[
			???
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
			발사한 파이어볼은 지나간 자리에 작은 불을 남기며 무언가에 부딪힐 시 폭발합니다,
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
			{{ffRock}} 획득 시 석기류를 소환합니다.
			{{ffRock}} 사용 시 현재 소지 중인 장신구를 빻아 석기류를 소환합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
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
			{{ffCursesBlackLantern}} 항상 저주에 걸리며 기존의 저주가 아닌 새로운 형태의 저주가 걸립니다.
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
			{{ffMartyr}} 적 처치 시 순교자로 만듭니다.
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
		AppendEntries = {
			"FF_APPEND_MORBID_HEART",
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
			{{Timer}} 사용 시 10초 동안 아군 Golden Baby Plum 보스를 소환합니다.
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
			"FF_APPEND_MORBID_HEART",
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
		Name = "옥수수 철판구이",
		QuoteDesc = "공격력 증가 + 구워진 옥수수",
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
		Name = "이터널 클리커",
		QuoteDesc = "???",
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
			{{ffOverloaded}} 콘센트에 꽃힌 적은 과부하 상태에 걸리며 오랫동안 꽂고 있으면 적이 폭발합니다.
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
			!!! ]]..FiendFolio.DescriptionIcons.China..[[China 전용
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
		Name = "크레이지 잭팟",
		QuoteDesc = "화풀이 도박",
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
		Name = "엄마의 스타킹",
		QuoteDesc = "사거리 증가",
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
			사용 시 달빛을 소환합니다.
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
			>>> {{DamageSmall}}x1.5/{{TearsSmall}}x0.85/{{LuckSmall}}+3
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
		BFFS = {10, 8},
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
			모든 능력치가 소량 증가합니다.
			랜덤 능력치 하나가 추가로 증가합니다.
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
			↑ {{SpeedSmall}}이동속도 +0.2
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
			사용 시 공격방향으로 병을 휘둘러 접촉한 적을 하나 담습니다.
			적이 병에 있는 상태에서 재사용 시 공격방향으로 그 적을 던져;
			명중한 적에게 던진 적의 체력만큼의 피해를 줍니다.
			!!! 충전량은 적을 던질 때에만 소모, 보스의 경우 무효과
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
			{{ffExCommunicated}} 7번째 눈물마다 적을 전이시키는 공격이 나갑니다.
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
			{{Heart}} 적 처치 시 높은 확률로 빨간하트를 드랍합니다.
			!!! 패널티 피격 시 1~3칸의 추가 피해를 받으며 추가 피해로 받은 하트는 사라지는 픽업으로 드랍됩니다.
			하트가 사라지면 빨간 장판을 생성하며 주변의 적에게 공격력 x1.5의 피해를 줍니다.
		]],
		Tests = {
			"{{Heart}} High chance for enemies to drop red hearts",
			"{{Warning}} Taking damage causes 1-3 additional red hearts to fly out",
			"These can be recollected, but disappear if left alone",
			"When expiring, hearts release a highly damaging blood explosion"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.MTN_DEW] = { -- TODO
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Chargeable}} 공격 중 충전, 공격키를 떼면 눈물을 여러 발 발사합니다.
			{{ffRadiation}} 이후 방사성 구름을 생성하는 눈물을 3발 발사합니다.
			!!! 방사선에 많이 노출되면 하트류가 픽업으로 드랍됩니다.
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
			{{ffBerserk}} 사용 시 그 방의 적을 폭주시킵니다.
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
			{{ffDoom}} 사용 시 그 방의 적을 둠에 걸리게 합니다.
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
			{{ffOverloaded}} 16%의 확률로 적을 과부하 시키는 공격이 나갑니다.
			{{LuckSmall}} 행운 12+일 때 33%
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
			{{ffSew}} 캐릭터 주변의 적을 귀속시킵니다.
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
			!!! 획득 시 아래의 아이템을 전부 사용합니다.
			>>> {{Collectible476}}{{Collectible105}}{{Collectible386}}{{Collectible166}}
			>>> {{Collectible]].. FiendFolio.ITEM.COLLECTIBLE.MARIAS_IPAD ..[[}}(20% 확률)
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
			{{Collectible317}} 3%의 확률로 적을 즉사시키며 녹색 장판을 생성하는 공격이 나갑니다.
			{{LuckSmall}} 행운 13+일 때 25%
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
			캐릭터의 반대편에서 움직이며 캐릭터의 공격 반대방향으로 공격력 3.5의 지형 관통 눈물을 발사합니다.
			눈물이 캐릭터의 눈물과 닿으면 주변의 적에게 캐릭터 x10의 폭발 피해를 줍니다. (캐릭터 피해 없음)
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
			{{Trinket}} 20초간 그 방에서 소지 중인 석기류를 강화시키며 흡수 패널티를 제거합니다.
		]],
		CarBattery = {20, 40},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GOLEMS_SUB] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{SoulHeart}} 소울하트 +1
			{{ffRock}} 획득 시 랜덤 조약돌을 드랍합니다.
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
			적이 있는 방에서 주기적으로 검을 3개 소환합니다.
			검 소환 후 일정 시간 뒤에 적을 향해 날아가며;
			>>> {{ffHemorrhage}} 검에 닿은 적에게 대출혈 피해를 줍니다.
			캐릭터가 검에 닿은 경우 검이 소멸하는 대신 그 방향으로 핏방울 여러 개를 대신 발사합니다.
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
			방 클리어 시 혹은 적에게 일정 피해를 줄 때마다 캐릭터 주변을 도는 운석 배리어를 하나 소환합니다.
			운석 배리어는 적의 탄환을 막아주며 일정 회수 막으면 사라집니다.
			{{Confusion}} 공격키를 두번 눌러 운석 배리어를 투척하여 적에게 혼란 피해를 줄 수 있습니다.
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
			적 처치 시 확률적으로 열매를 드랍합니다.
			{{Chargeable}} 열매 획득 시 일회성 구토제 눈물을 발사합니다.
			방 클리어 시 구토제 눈물에 추가 효과를 주는 열매 더미를 소환합니다.
			{{IND}} 5개 : 독구름
			{{IND}} 10개 : 추가 눈물더미 (독성)
			{{IND}} 15개 : 추가 눈물더미 (빨간 장판)
			{{IND}} 20개 : 추가 줄기 공격
			{{IND}} 이후 5개마다 추가 피해
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
			{{Charm}} 사용 시 주변의 적 하나를 아군으로 만들며 줄기로 묶습니다.
			{{Heart}} 체력 회복 시 줄기에 묶인 아군도 같이 회복합니다.
			!!! 줄기에 묶인 아군이 없을 때 재사용 가능
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
			!!! 캐릭터가 왼쪽/오른쪽으로 공격할 때:
			>>> {{TearsSmall}} 연사 +1.2
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
			랜덤 간격으로 방귀를 뀝니다.
			스테이지 진입 시 방귀를 53번 뀝니다.
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
			{{ffImmoralHeart}} 이모럴하트 +2
			Fiend의 부하 소환 및 적 처치 시 아군 버섯 포자를 생성합니다.
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
			↑ {{Heart}}최대 체력 +1
			↑ {{HealingRed}}빨간하트 +1
			↑ {{Planetarium}}천체관 확률 +10%
			획득 후 3분간 50%의 확률로 상태이상에 걸리지 않습니다.
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
			공격 시 적에게 랜덤 상태이상을 걸리게 하는 장판을 생성하는 눈물을 발사합니다.
			{{Timer}} (쿨타임 2초)
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
			{{ffSleeping}} 15%의 확률로 적을 나른하게 하는 공격을 합니다.
			{{LuckSmall}} 행운 25+일 때 50%
			{{ffSleeping}} 잠든 적에게 카운터가 생기며 0이 되면 공격력 x1의 추가 피해를 주며 깨어납니다.
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
			{{HalfHeart}} 방 진입 시 25%의 확률로 Fiend의 부하를 5마리 소환하는 대신 하트 -0.5 ({{Heart}} 우선)
			{{ffHalfImmoralHeart}} 낮은 확률로 부하 중 하나가 이모럴 타입으로 바뀝니다.
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
			확률적으로 적이 커지거나 작아집니다.
			커진 적은 체력이 50% 증가합니다.
			작아진 적은 체력이 50% 감소합니다.
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
			캐릭터의 체력이 6칸 이하일 때 모든 적이 추가 피해를 받습니다.
			{{Blank}} (체력이 적을수록 받는 피해 증가)
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
			{{Chargeable}} 공격 중 충전하며 충전 상태에 따라 오라를 발산하는 석상을 설치합니다.
			>>> {{1}}: 매혹, 폭주, 혼란 중 하나
			>>> {{2}}: 석화
			>>> {{3}}: 석화 + 해제 시 추가 피해 (스테이지 당 1회)
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
			{{Chargeable}} 이동 중일 때 충전, 멈추면 마지막으로 이동한 방향으로 돌진합니다.
			돌진 중에는 미끄러지나 무적이며 빨간 장판을 생성합니다.
			초과 충전량에 따라 돌진 거리 및 장판의 피해량이 증가합니다.
			{{Blank}} (돌진 중 다른 방향키로 취소 가능)
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
			↑ {{Heart}}최대 체력 +1
			↑ {{TearsSmall}}연사 +0.35
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
			{{ffLilPenny}} 4초당 동전 +0.1
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
			{{ffMugged}} 25%의 확률로 적에게 약탈을 거는 공격을 합니다.
			{{LuckSmall}} 행운 25+일 때 100%
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
			↓ {{SpeedSmall}}이동속도 -0.4
			↑ {{TearsSmall}}연사 +0.4
			↑ {{DamageSmall}}공격력 +2
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
			↑ {{TearsSmall}}연사 +1.4
			↑ {{DamageSmall}}공격력 +0.4
			↓ {{ShotspeedSmall}}탄속 -0.4
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
			↑ {{SpeedSmall}}이동속도 +0.4
			↑ {{TearsSmall}}연사 +0.4
			↑ {{DamageSmall}}공격력 +0.4
			↑ {{ShotspeedSmall}}탄속 +0.4
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
			사용 시 구릅니다.
			구르기 중 무적
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
			↑ {{SpeedSmall}}이동속도 +0.1
			↑ {{TearsSmall}}연사 +0.1
			↑ {{DamageSmall}}공격력 +0.1
			↑ {{LuckSmall}}행운 +0.1
			{{Coin}} 동전을 5개 드랍합니다.
			운세를 하나 보여줍니다.
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
		Name = "뼈갈이",
		QuoteDesc = "뼈를 갈아 빌드업",
		Description = [[
			사용 시 캐릭터 주변을 도는 뼛조각을 없애며;
			{{LuckSmall}} 없앤 뼛조각 수에 비례하여 증발성 공격력 으로 바꿉니다.
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
			↑ {{TearsSmall}}연사 +1
			!!! 눈물의 정확도가 감소합니다.
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
			↑ {{Heart}}최대 체력 +3
			{{HealingRed}} 체력을 전부 회복합니다.
			!!! 모든 하트 픽업이 빨간하트로 등장합니다.
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
			{{Poison}} 사용 시 공격방향으로 독가스를 생겅하는 불꽃을 날립니다.
			불꽃은 2초동안 지속되며 탄환을 막아주나, 적에게 피해를 주면 사라집니다.
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
			↑ {{DamageSmall}}공격력 배율 x2
			캐릭터 크기 대폭 증가
			캐릭터 연두빛 대폭 증가
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
			{{BlackHeart}} 블랙하트 +1
			!!! 블랙하트 픽업이 더 이상 등장하지 않습니다.
		]],
		Tests = {
			"{{BlackHeart}} +1 Black Heart",
			"{{Warning}} Turns all Black Heart drops in the run into other hearts"
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.HUNDRED_PERCENT_ORANGE_JUICE] = {
		_descType = "collectible",
		Name = "100% 오렌지 주스",
		QuoteDesc = "",
		Description = [[
			클리어하지 않은 방 진입 시 방 안의 랜덤 위치에 패널이 여러 개 생깁니다.
			{{LuckSmall}} 기본 3개, 행운 16+일 때 7개
			패널 색상에 따라 다른 효과를 발동합니다.
			{{IND}} {{ColorYellow}}보너스{{CR}}: {{Coin}} 동전 증가
			{{IND}} {{ColorBlue}}드롭{{CR}}: {{Coin}} 동전 감소
			{{IND}} {{ColorLime}}드로우{{CR}}: 랜덤 카드 발동
			{{IND}} {{ColorPurple}}워프{{CR}}: 그 방의 랜덤 위치로 순간이동
			{{IND}} {{ColorOrange}}엔카운터{{CR}}: 랜덤 적 소환
			{{IND}} {{ColorRed}}보스{{CR}}: 랜덤 챔피언 적 소환
			{{IND}} {{ColorPink}}힐{{CR}}: {{Heart}} 증발성 하트 소환
			{{IND}} {{BlinkYellowRed}}데미지{{CR}}: 슈퍼트롤폭탄 소환
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
			{{TearsSmall}} 체력이 적을수록 연사 증가 (2{{Heart}}일 때 +1.5)
			!!! 체력 2칸 이하인 상태에서 피격 시 사망합니다.
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
			{{Burning}} 공격방향으로 적에게 공격력 x2의 화상 피해를 주는 보라색 화염을 던집니다.
			!!! 화염 명중 시 폭발합니다.
			{{HalfHeart}} 화염 폭발로 적 처치 시 30%의 확률로 빨간하트 반칸을 드랍합니다.
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
			50걸음마다 아군 자폭 벼룩을 소환합니다.
		]],
		Tests = {
			"Spawns a Blue Skuzz after walking 50 steps",
			"Blue Skuzzes are friendly creatures that hop towards nearby enemies and do 3x Isaac's damage"
		},
		AppendEntries = {
			"FF_APPEND_SKUZZES",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.INFESTATION_4] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
			50의 피해를 줄 때마다 아군 자폭 무당벌레를 소환합니다.
		]],
		Tests = {
			"Spawns a Blue Beetle after dealing 50 damage",
			"Blue Beetles are friendly creatures that shield Isaac from oncoming attacks and projectiles"
		},
		AppendEntries = {
			"FF_APPEND_BEETLES",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.UTILITY_POLE] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
			짝수 스테이지 시작 시 까마귀가 선물상자를 준비합니다.
			선물상자에는 카드/알약 등이 2~4개 들어 있습니다.
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
			공격방향으로 공격력 4.6의 유도성 탄환을 발사합니다. (탄창 6개)
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
			모든 잠긴 컬러 블럭을 유령 열쇠 없이 열 수 있습니다.
			장애물이 확률적으로 잠긴 컬러 블럭으로 바뀝니다.
			!!! 컬러 블럭은 비행으로 지나갈 수 없음
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
			공격 시 공격방향으로 주사위를 던집니다.
			주사위의 손가락 수에 따른 효과:
			>>> {{1}}: 적에게 피해를 주는 장판 생성
			>>> {{2}}: 다음에 나온 효과 2배
			>>> {{3}}: 360도 방향으로 확률 치명타 눈물 3발 발사
			>>> {{4}}: 4방향으로 불꽃 발사
			>>> {{5}}: {{ffBruise}} 가까운 적을 향해 5방향으로 멍들게 하는 탄환 발사
			발동 후 주우면 다시 던질 수 있습니다.
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
			사용 시 그 방의 랜덤 위치로 순간이동하며;
			>>> 그 위치에 적에게 50의 피해를 줍니다.
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
			15%의 확률로 지나간 자리에 장판을 생성하는 공격을 합니다.
			{{LuckSmall}} 행운 20+일 때 45%
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
			{{Coin}} 동전 7개를 드랍합니다.
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
			적 처치 시 예술 조각을 생성합니다.
			예술 조각 파괴 시 적을 향해 알록달록한 눈물 여러 발을 발사합니다.
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
			↑ {{Heart}}최대 체력 +1
			↑ {{HealingRed}}빨간하트 +1
			!!! 여자만 획득 가능
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
			↑ {{DamageSmall}}공격력 +0.3
			적 처치 시 뼛조각 눈물이 튀어나오며 주변의 적을 밀쳐냅니다.
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
			!!! ]]..FiendFolio.DescriptionIcons.Craig..[[Craig 전용, 랜턴으로 충전 가능
			적이 있는 방에서 랜턴이 등장하며 랜턴의 크기 및 주는 충전량은 시간이 지나면 커집니다.
			사용 시 공격방향으로 혈사포를 발사합니다.
			충전량 33% 이상일 때 사용 가능하며 혈사포 크기가 충전량에 비례합니다.
			!!! 충전량 200%일 때 폭발, 충전량 전부 소진
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
			{{Battery}} 액티브 아이템 사용 시 충전량의 0~50%를 보존합니다.
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
			{{ffMorbidHeart}} 종양하트 +1
			↑ {{TearsSmall}}연사 +0.7
		]],
		Tests = {
			"↑ +0.7 Tears",
			"{{ffMorbidHeart}} +1 Morbid Heart"
		},
		AppendEntries = {
			"FF_APPEND_MORBID_HEART",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BABY_FORMULA] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ {{Heart}}최대 체력 +1
			↑ {{HealingRed}}빨간하트 +1
			↑ {{SpeedSmall}}이동속도 +0.05
			캐릭터의 크기가 작아집니다.
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
			사용 시 공격방향으로 휴대전화를 던집니다.
			휴대전화의 방향은 공격키로 변경할 수 있으나 점점 빨라집니다.
			휴대전화 주변에 적에게 1.8의 피해를 주는 전류를 발산합니다.
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
			↑ {{DamageSmall}}공격력 +0.5
			↑ {{RangeSmall}}사거리 +3
			↑ {{ShotspeedSmall}}탄속 +0.2
			다음 획득하는 아이템이 강아지류 패밀리어로 바뀝니다.
			획득한 강아지류 패밀리어는 방 종류에 따라 달라집니다.
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
			공격방향으로 공격력 3.5의 눈물을 발사합니다.
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.DOUBLE_DOG..[[}} {{TreasureRoom}} {{BossRoom}} 보물방/보스방에서 획득한 아이템이 Double Dog에 의해 교체됨
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
			{{ffDoom}} 공격방향으로 공격력 6.66의 둠 눈물을 발사합니다.
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.DOUBLE_DOG..[[}} {{DevilRoom}} 악마방에서 획득한 아이템이 Double Dog에 의해 교체됨
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
			↑ {{TearsSmall}}연사 +0.7
			{{ffMartyr}} 공격방향으로 공격력 6.66의 순교성 눈물을 발사합니다.
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.DOUBLE_DOG..[[}} {{AngelRoom}} 천사방에서 획득한 아이템이 Double Dog에 의해 교체됨
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
			↑ {{TearsSmall}}목숨 +1
			{{Collectible453}} 공격방향으로 공격력 4의 뼈 눈물을 발사합니다.
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.DOUBLE_DOG..[[}} {{SecretRoom}} {{SuperSecretRoom}} 비밀방/일급비밀방에서 획득한 아이템이 Double Dog에 의해 교체됨
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
			획득 시 랜덤 픽업을 여러 개 드랍합니다.
			{{ffMartyr}} 공격방향으로 공격력 3.5의 순교성 눈물을 발사합니다.
			{{Shop}} 상점 품목의 가격이 25% 감소합니다.
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.DOUBLE_DOG..[[}} {{Shop}} 상점에서 획득한 아이템이 Double Dog에 의해 교체됨
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
			{{Petrify}} 공격방향으로 공격력 7의 석화 눈물을 발사합니다.
			{{Petrify}} 석화 상태의 적 처치 시 눈물 여러 개로 나뉩니다.
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.DOUBLE_DOG..[[}} {{CurseRoom}} 저주방에서 획득한 아이템이 Double Dog에 의해 교체됨
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
			랜덤 강아지 패밀리어 x5
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.DOUBLE_DOG..[[}} {{ErrorRoom}} 오류방에서 획득한 아이템이 Double Dog에 의해 교체됨
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
			{{Coin}} 동전 +6
			{{Coin}} 폭탄이 없어도 동전 3개를 소모하여 추가로 설치할 수 있습니다.
			{{ffLilPenny}} 폭탄이 터지면 리틀 페니를 여러 개 흩뿌립니다.
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
			↓ {{TearsSmall}}연사 배율 x0.5
			↓ {{ShotspeedSmall}}탄속 -0.2
			일부 눈물이 캐릭터 주변에서 등장하며 가까운 적을 향해 날아갑니다.
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
			{{Burning}} 5%의 확률로 적에게 화상을 입히는 공격을 합니다.
			{{LuckSmall}} 행운 20+일 때 100%
			화상에 걸린 적 처치 시 십자 모양으로 보라색 불길을 발사합니다. (캐릭터 피해 없음)
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
			클리어하지 않은 방에서 10~30초마다 말풍선이 나옵니다.
			말풍선에서 위/아래 키로 꿈을 선택할 수 있으며;
			일정 시간 후 그 꿈에 대응되는 효과를 발동합니다.
			{{ButtonRT}} Ctrl 키로 즉시 발동 가능
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
			{{Timer}} 사용 시:
			{{IND}} {{SpeedSmall}}이동속도 +0.25
			{{IND}} 패밀리어 공격력 x3 (패밀리어가 없는 경우 {{Collectible8}} 지급)
			{{IND}} {{Battery}} 재사용 시 해제 가능하며, 15초 후 재사용 가능
			!!! 패널티 피격 시 강제로 해제 + 패밀리어 제거 + 캐릭터에게 2배의 피해
			방 클리어 시 제거되었던 패밀리어 하나가 부활합니다.
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
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.ZIP_43] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Bomb}} 폭탄 +5
			폭탄이 터지면 주변의 적을 오류에 걸리게 합니다. (미끄러짐 + 일부 행동 불가)
			{{ffOverloaded}} 5%의 확률로 과부하가 대신 걸림
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
			{{Heart}} 캐릭터의 체력을 탄창으로 바꿉니다.
			공격 시 탄환을 소모하며 소모하며 탄환 발사에 사용된 하트 종류에 따라 추가 효과를 발동합니다.
			{{Blank}} (실제 체력을 소모하지 않음)
			!!! 탄창에 탄약이 있는 경우:
			>>> {{DamageSmall}} 공격력 +0.8
			>>> {{ShotspeedSmall}} 탄속 +0.3
			!!! 탄창에 탄약이 없는 경우:
			>>> {{TearsSmall}} 연사 -0.3
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
			{{Timer}} 클리어하지 않은 방에서 20초마다:
			>>> 3초간 캐릭터가 확정 치명 공격을 합니다.
			치명타는 적에게 공격력 x5의 피해를 줍니다.
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
			피격되지 않은 상태에서 방 2회 이상 클리어 시 63%의 확률로:
			>>> {{DamageSmall}} 공격력 +0.15
			>>> {{UnknownHeart}} 랜덤하트 +1
			>>> {{Coin}} 동전 +1~5
			>>> {{Battery}} 액티브 1~3칸 충전
			>>> {{Collectible123}} 랜덤 패밀리어 or 일회성 패밀리어
			>>> {{Card}} 랜덤 타로 카드 소환
			>>> !!! {{ffCursedPenny}} 랜덤 저주받은 픽업
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
			클리어하지 않은 방에서 주기적으로 캐릭터가 똥을 쌉니다.
			캐릭터가 싼 똥 파괴 시 50%의 확률로 약물을 드랍합니다.
			!!! {{Collectible582}} 약물 획득 시 증발성 Wave Cap 효과 발동
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
			사용 시 액티브 자판기를 소환합니다.
			{{Coin}} 액티브 자판기는 동전 0~10개를 소모하여 그 아이템을 즉시 사용합니다.
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
			5%의 확률로 유도성 와드 공격이 나갑니다.
			{{LuckSmall}} 행운 7+일 때 20%
			와드 공격 명중 시 10초간 주변의 적을 가둡니다.
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
			{{Bomb}} 사용 시 투척성 폭탄 3개를 소환합니다.
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
			!!! 획득 시 지정 8개 배열의 아이템이 하나씩 존재하는 방으로 이동합니다.
			!!! 아이템은 모두 획득할 수 있으나 하나라도 획득 시:
			>>> 현재 게임에서 이하의 방이 더 이상 등장하지 않음: {{TreasureRoom}} {{Shop}} {{Library}} {{Planetarium}} {{UltraSecretRoom}} {{DevilRoom}} {{AngelRoom}}
			>>> {{AngelDevilChanceSmall}}} 현재 게임에서 악마방/천사방 {{ColorRed}}최종 확률{{CR}}이 0%로 고정 + 해당 방으로 이동 불가
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
			{{ColorOrange}}모든 수치{{CR}} 배율 x1.09
			>>> {{SpeedSmall}} {{TearsSmall}} {{DamageSmall}} {{RangeSmall}} {{ShotspeedSmall}} {{LuckSmall}} {{Tearsize}} 모든 능력치
			>>> {{AngelDevilChanceSmall}} {{PlanetariumChanceSmall}} 악마방, 천사방, 천체관 확률
			>>> {{Heart}} 체력 상한
			>>> {{Coin}} {{Bomb}} {{Key}} 픽업 수, 픽업 상한
			>>> {{Collectible58}} {{Trinket81}} 무적시간
			>>> {{Collectible308}} 캐릭터 장판 지속시간
			>>> {{Battery}} 시간제 액티브 충전량
			>>> {{Collectible300}} 캐릭터 관성, 접촉 피해량, 피격 범위
			>>> {{Bomb}} 폭탄 피해량, 범위
			>>> 기타 등등
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
			!!! 일회용 !!! 
			]]..FiendFolio.DescriptionIcons.Golem..[[사용 시 Golem의 모든 석기가 있는 방으로 이동합니다.
			>>> 석기 3개 획득 시 원래 있던 장소로 돌아갑니다. (자동 흡수)
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
		Name = "엄마의 ♡",
		QuoteDesc = "체력 증가",
		Description = [[
			↑ {{Heart}}최대 체력 +125
			↑ 체력 상한 +250
			{{HealingRed}} 체력을 모두 회복합니다.
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
			{{Timer}} 사용 시 공격이 미니건으로 변경됩니다.
			>>> 미니건 탄환은 속사가 가능하며 장애물을 파괴하는 공격력 x2의 피해를 줍니다.
			>>> 일정 수 발사 시 비활성화되며 스테이지 진입 시 다시 사용할 수 있습니다.
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
			소지 중일 때 캐릭터가 주기적으로 보라색 장판을 생성합니다. (적 피해 없음)
			사용 시 캐릭터 주변에 보라색 장판을 원형으로 생성하며;
			>>> 보라색 장판에서 적에게 초당 공격력 x0.6 + 5의 피해를 주는 가시를 생성합니다.
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
			{{Bomb}} 폭탄 +6
			캐릭터가 설치한 폭탄에 랜덤 효과를 3가지 추가합니다.
			랜덤 효과는 스테이지별로 고정
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
			클리어하지 않은 방에서 주기적으로 타겟을 2개 소환합니다.
			타겟 접촉 시 랜덤 탄막 게임 계열의 눈물세례를 발사합니다.
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
			{{ffMorbidHeart}} !!! 모든 소울/블랙하트를 종양하트로 바뀝니다.
			{{SoulHeart}} 최대 체력 = 소울/블랙하트 보정을 받는 캐릭터는 무효과
		]],
		Tests = {
			"{{ffMorbidHeart}} Replaces all Soul and Black Heart pickups with Morbid Hearts",
			"Morbid chunks spawn 1-3 blue flies when destroyed",
			"{{SoulHeart}} Heart replacement doesn't happen for soul heart only characters"
		},
		AppendEntries = {
			"FF_APPEND_MORBID_HEART",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.RAILDRIVER] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
			방마다 처음 공격은 방을 관통하며 캐릭터 공격력에 비례한 피해를 주는 레일건 탄환을 발사합니다.
			관통한 방 입장 시 경로를 따라 레일건 탄환이 계속 발사됩니다.
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
			{{Petrify}} 공격방향으로 공격력 4의 랜덤 붉은 효과 눈물을 발사합니다.
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.DOUBLE_DOG..[[}} {{UltraSecretRoom}} 특급비밀방에서 획득한 아이템이 Double Dog에 의해 교체됨
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
			Alt 키를 통해 감정표현을 사용합니다.
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
			적 처치 시 확률적으로 붉은 오라를 소환합니다.
			{{Damage}} 붉은 오라 안에 있는 경우 증발성 공격력이 증가
			{{HalfHeart}} 오라가 꺼질때 있는 경우 빨간하트 반칸 회복 (방 당 1회)
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
			적 처치 수에 비례하여:
			>>> {{Damage}} 공격력 증가
			>>> {{Collectible]] .. FiendFolio.ITEM.COLLECTIBLE.IMP_SODA .. [[}} 치명타 확률 증가
			!!! 이 아이템의 적 처치 수는 새 게임 시작 시에도 초기화되지 않음
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
			{{Heart}} {{Coin}} {{Bomb}} {{Key}} 주변의 픽업을 집어 저장합니다. (상한 있음)
			집어간 픽업을 적에게 던집니다.
			{{Heart}} 체력의 경우 회복이 필요할 때 캐릭터에게 던집니다.
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
			↑ {{DamageSmall}}공격력 +0.7
			{{ffMorbidHeart}} 종양하트 +1
		]],
		Tests = {
			"↑ +0.7 Damage",
			"{{ffMorbidHeart}} +1 Morbid Heart"
		},
		AppendEntries = {
			"FF_APPEND_MORBID_HEART",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.EXECUTIONER] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
			체력이 일정 비율 이하로 내려간 적을 4초 후 즉사시킵니다.
			>>> 보스 : 35%
			>>> 일반 적 : 75%
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
			↑ {{SpeedSmall}}이동속도 +0.3
			클리어한 방에서 비행 능력을 얻습니다.
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
			{{Battery}} 액티브 아이템 사용 시 66%의 확률로 2~3배의 효과를 발동합니다.
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
			{{Battery}} 액티브 아이템을 x번째 사용할 때마다 3배의 효과를 발동합니다.
			>>> (x : 액티브 아이템 충전량)
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
			{{Battery}} 완충 5초 이전에 액티브 아이템 사용 시 충전량의 50%를 보존합니다.
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
			캐릭터가 접촉할 시 직선으로 미끄러지며 이동합니다.
			접촉할 때마다, 혹은 주변의 적이 있을 때 주변의 적에게 공격력 x1의 피해를 주는 전류를 발산합니다.
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
			방 입장 시 장애물 하나가 오라를 발산하는 천사 석상으로 바뀝니다.
			캐릭터가 오라 안에 있을 시:
			>>> {{DamageSmall}}공격력 배율 x1.2
			>>> {{TearsSmall}}연사 배율 x2.5
			>>> 피해를 확률적으로 무시하고 공격에 유도 효과가 생깁니다.
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
			!!! 카드 압축으로만 충전 가능
			카드를 들고 있는 동안 사용 시 그 카드를 소모하여 압축합니다.
			{{Card}} 사용 시 압축된 카드의 효과를 모두 발동합니다.
			적 처치 시 15%의 확률로 잠시 후 사라지는 공격성 카드를 드랍합니다.
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
			{{Battery}} 액티브 아이템 2번 사용 시마다 그 아이템의 충전량을 감소시킵니다. (최소 1칸/1초)
			>>> 스테이지 진입 시 액티브 충전량 초기화
			>>> 방 진입 시 시간제 액티브 충전량 초기화
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
			공격이 1~6발로 나갑니다.
			!!! ↓ {{Tears}} 발사한 공격 수에 따라 공격 딜레이 증가
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
			{{SacrificeRoom}} 희생방 진입 시 1~4회차의 희생 효과를 발동하며 희생 가시가 5번째부터 시작합니다.
			{{SacrificeRoom}} 스테이지 진입 시 희생방 생성 확률 +33%p
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
			공격 명중 시 캐릭터를 향해 공격력 x0.25의 유도성 레이저를 생성합니다.
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
			{{Charm}} 사용 시 그 방에서 이하의 아군을 소환합니다:
			>>> Goat x2
			>>> Bonie x2
			>>> Fishface
			>>> Charmed Bloomer
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
			↓ {{DamageSmall}}공격력 배율 x0.85
			공격 명중 시 눈물을 그 위치 및 방향으로 다시 발사합니다.
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
			공격 명중 시 캐릭터 주변을 도는 눈물을 생성합니다.
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
			공격이 지형을 관통합니다.
			눈물을 5번 발사할 때마다 4개의 유도성 후광 눈물을 소환합니다.
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
			{{Collectible118}} 적 처치 시 13%의 확률로 사망하지 않으나 그 위치에서 4방향으로 혈사포가 나갑니다.
			{{LuckSmall}} 행운 10+일 때 33%
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
			공격방향으로 돌진하며 이후 십자모양이 나오도록 다른 방향으로 돌진합니다.
			돌진 중 초당 52.5의 피해를 줍니다.
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
			공격 중일 때 캐릭터의 주변을 돌며 적에게 초당 75의 피해를 줍니다.
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
			↑ {{DamageSmall}}공격력 +1
			{{Coin}} 동전을 4개 드랍합니다.
			!!! 스테이지 진입 시 이 아이템이 소환되며 강제로 거래됩니다.
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
			{{SoulHeart}} 소울하트 +2
			{{SoulHeart}} {{BlackHeart}} {{ffImmoralHeart}} 소울하트 계열 체력 1칸 당 캐릭터 주변을 도는 빛의 하트를 소환합니다.
			빛의 하트는 적의 탄환을 막아주며 초당 30의 피해를 줍니다.
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
			!!! 일회용 !!!
			{{Trinket}} 사용 시 랜덤 장신구 4개를 흡수합니다.
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
			{{AngelChanceSmall}} 획득 후 다음 악마방/천사방 문 소환 시 천사방으로 고정됩니다.
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
			{{Burning}} 방 상단의 태양이 적과 픽업을 끌어들이며 주변의 적에게 화상 피해를 줍니다.
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
			↑ {{TearsSmall}}연사 +0.7
			{{BlackHeart}} 블랙하트 +1
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
			공격 시 25%의 확률로 유성 공격이 나갑니다.
			{{LuckSmall}} 행운 16+일 때 40%
			유성 공격은 공격방향으로 공격력 x0.33의 눈물 7개로 나뉩니다.
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
			↑ {{Heart}}최대 체력 +1
			↑ {{HealingRed}}빨간하트 +1
			↑ {{SpeedSmall}}이동속도 +0.3
			↑ {{TearsSmall}}연사 배율 +0.2
			↑ {{DamageSmall}}공격력 +0.4
			↑ {{LuckSmall}}행운 +1
			!!! 스테이지마다 {{BossRoom}} {{TreasureRoom}} 를 제외한 랜덤 특수방 하나에 진입할 수 없습니다.
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
			{{Card78}} 획득 시 Cracked Key를 1~3개 드랍합니다.
			{{UltraSecretRoom}} 스테이지 진입 시 특급비밀방이 하나 더 생깁니다.
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
			!!! 방 클리어로 충전 불가
			소지 중일 때 감자도스 자루 등장 확률 증가
			{{DamageSmall}} 사용 시 공격력 +5%p
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
			{{Beggar}} 거지에게 이 아이템을 소모하여 보상을 즉시 획득 가능
			{{Shop}} 거지에게 지급 후 상점에서 다시 나올 수 있으며 판매 가격이 증가합니다.
			{{DamageSmall}} 획득 시 구매에 사용된 가격에 비례하여 공격력 배율 증가
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
			아이템 획득 시 랜덤 아이템 하나가 고유능력으로 추가됩니다.
			패널티 피격 시 고유능력 하나가 제거됩니다.
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
			{{Timer}} {{ItemPoolDevil}} 적 처치 시 확률적으로 90초간 악마방 아이템의 효과를 얻습니다.
			{{Blank}} (확률은 적 체력에 비례)
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
			{{Collectible149}} 사용 시 그 방에서 공격이 구토제로 바뀝니다.
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
			클리어하지 않은 방에서 주기적으로 그 방의 랜덤 위치에 공격력 13의 유도성 눈물을 생성합니다.
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
			캐릭터 주변을 도는 커다란 눈물이 하나 생깁니다.
			커다란 눈물은 공격력 x1.5의 피해를 줍니다.
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
			{{Chargeable}} 공격 중 충전, 공격키를 떼면 공격방향으로 구름을 생성합니다.
			구름은 주기적으로 눈물을 떨어뜨립니다.
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
			캐릭터가 넨도로이드로 변신합니다.
			구매방법: https://s.goodsmile.link/jU8
			Goodsmile
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
			주기적으로 오류 장애물을 생성합니다.
			오류 장애물은 적 탄환 방어, 적에게 60의 피해, 나온 위치의 원래 장애물을 파괴하나 잠시 후 사라집니다.
			!!! 소지 중일 때 90초마다 소지 중인 아이템 중 하나가 GLITCHCITY로 바뀝니다.
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
			가시돌이 9%의 확률로 금가시돌이 됩니다.
			{{ColorOrange}}금가시돌{{CR}}: 가시돌 + 파괴 시 동전 드랍
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
			↑ {{SpeedSmall}}이동속도 +0.1
			↑ {{LuckSmall}}행운 +1
			!!! {{DiceRoom}} 획득 시 주사위방 4번 효과를 발동합니다. (스테이지 내의 액티브/패시브 변경)
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
			{{Collectible58}} 획득 시 90초간 무적 상태가 됩니다.
			{{Collectible58}} 스테이지 진입 시 36초간 무적 상태가 됩니다.
			{{Blank}} (방 이동 시에도 지속)
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
			사용 시 이 스테이지에서 소모된 일회성 패밀리어를 소환합니다. (재소환 불가)
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
			{{ffMugged}} 공격방향으로 공격력 3.5의 약탈 눈물을 발사합니다.
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
			{{ffExCommunicated}} 공격방향으로 공격력 3.5의 전이 눈물을 발사합니다.
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
			{{ffOverloaded}} 공격방향으로 공격력 3.5의 과부하 눈물을 발사합니다.
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
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.WNIC..[[}} 공격방향으로 공격력 3.5의 반복성 눈물을 발사합니다. (명중 시 그 궤도로 다시 발사)
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
			{{Burning}} 이동 중일 때 주기적으로 캐릭터 위치에 불을 생성합니다.
			{{Burning}} 적과 접촉 시 공격력 x2의 화염 피해를 줍니다.
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
			10%의 확률로 폭발성 눈물을 발사합니다.
			{{LuckSmall}} 행운 8+일 때 50%
			!!! 캐릭터도 폭발 피해를 받습니다.
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
			{{BossRoom}} 보스방 진입 시 특수 꼬마 아이작을 소환합니다.
			꼬마 아이작이 있는 경우 캐릭터 피격이 꼬마 아이작에게 옮겨집니다.
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
			↑ {{Heart}}최대 체력 +1
			↑ {{HealingRed}}빨간하트 +1
			{{ffNursing}} 방 입장 시 7.5%의 확률로 적에게 치유 상태를 겁니다.
			{{LuckSmall}} 행운 20+일 때 15%
			{{ffNursing}} 1%의 확률로 적에게 치유 상태를 거는 공격이 나갑니다.
			{{LuckSmall}} 행운 20+일 때 5%
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
			{{EternalHeart}} 이터널하트 +1
			{{EternalHeart}} 스테이지 진입 시 이터널하트 +1
			{{ffShieldHeart}} 이터널하트 완성 시 쉴드하트 +1
		]],
		Tests = {
			"{{EternalHeart}} +1 Eternal Heart",
			"Gives an Eternal Heart at the start of each floor",
			"{{ffShieldHeart}} Eternal Hearts also give a 3 hit shield heart when completed",
		},
		AppendEntries = {
			"FF_APPEND_SHIELD_HEART",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.BABY_BELL] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
			캐릭터의 주변을 돕니다.
			적에게 맞으면 종이 울리며;
			>>> {{Fear}} 주변의 적과 탄환에 공포 넉백을 줍니다.
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
			{{DamageSmall}} 공격력 +1.6
			스테이지 진입 시 저주에 걸리지 않습니다.
			그 스테이지의 방 수의 일정 비율을 클리어할 때마다 증가한 공격력이 33%만큼 감소하며:
			>>> {{BossRoom}} 25%: 첫번째 양초 불이 꺼지며 보스방 위치 표시
			>>> {{TreasureRoom}} 50%: 두번째 양초 불이 꺼지며 보물방 위치 표시
			>>> {{CurseCursedSmall}} 75%: !!! 랜덤 저주 2개
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
			↓ {{DamageSmall}}공격력 배율 x0.66
			눈물 착지 예상 위치의 양옆으로 레이저를 생성합니다.
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
			↓ {{DamageSmall}}공격력 배율 x0.2
			눈물을 발사할 때마다 3개의 랜덤 눈물의 효과가 추가됩니다.
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
			캐릭터의 앞뒤로 돌며 적의 탄환을 막아줍니다.
			적과 접촉 시 초당 225의 피해를 줍니다.
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
			사용 시 랜덤 투척성 아이템을 발동합니다.
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
			3번째 공격마다 공격력 x0.6의 눈물 6개로 나뉩니다.
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
			{{Timer}} 그 방에서:
			>>> {{Burning}} 방 상단의 태양이 적과 픽업을 끌어들이며 주변의 적에게 화상 피해를 줍니다.
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
			{{ffGleaming}} 10%의 확률로 적에게 광택을 거는 공격이 나갑니다.
			{{LuckSmall}} 행운 20+일 때 50%
			광택 오라가 적에게 랜덤 상태이상을 추가로 겁니다.
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
			{{ffGleaming}} 10%의 확률로 적에게 광택을 거는 공격이 나갑니다.
			{{LuckSmall}} 행운 20+일 때 50%
			{{Burning}} 광택 오라가 적에게 화상을 추가로 겁니다.
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
			↑ {{DamageSmall}}공격력 +0.3
			↑ {{ShotspeedSmall}}탄속 +0.1
			공격 중일 때 공격이 적에게 피해를 줄 수 없으나 (1 + 스테이지 x0.3)의 지속 피해를 받습니다.
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
			{{ffCursedPenny}} 사용 시 저주페니를 하나 소환합니다.
		]],
		Tests = {
			"{{ffCursedPenny}} Spawns a Cursed Penny on use"
		},
		AppendEntries = {
			"FF_APPEND_CURSED_PENNY",
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
			{{Battery}} 카드/알약 슬롯이 아닌 액티브 아이템 사용 시 그 스테이지에 액티브 아이템이 바뀝니다.
			스테이지 진입 시 바뀐 액티브 아이템이 원래대로 돌아옵니다.
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
			↑ {{LuckSmall}}행운 +1
			최대 체력이 (6.5 + 스테이지 x0.5) 이하 체력의 적을 즉사시킵니다.
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
			{{Timer}} 클리어하지 않은 방에서 초당:
			>>> {{SpeedSmall}} 이동속도 -0.04 (최소 0.6)
			>>> {{DamageSmall}} 공격력 +0.1
			!!! 방 클리어 시 초기화
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
			{{CurseBlind}} !!! 저주가 걸리지 않은 방에서 충전 불가
			{{BlackHeart}} 사용 시 블랙하트 +1
			!!! 그 스테이지에서 사용하지 않은 경우:
			>>> {{SpeedSmall}} 이동속도 -0.2
			>>> {{TearsSmall}} 연사 배율 x0.8
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
			↑ {{DamageSmall}}공격력 +0.1
			{{DamageSmall}} 획득 시 현재 스테이지에서 발건한 비밀방 수만큼 공격력 +0.3
			{{SecretRoom}} 획득 시 비밀방과 일급비밀방을 표시합니다.
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
			{{BlackHeart}} 블랙하트 +1
			↑ {{DamageSmall}}공격력 +1
			!!! 다음 스테이지에서 반드시 저주에 걸립니다.
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
			적 처치 시 확률적으로 아군 Embryo를 소환합니다.
			{{DamageSmall}} 그 방의 아군 Embryo 당 공격력 +0.1
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
			{{ffExCommunicated}} 사용 시 체력이 가장 많지 않은 그 방의 적을 전이시킵니다.
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
			{{ffExCommunicated}} 사용 시 전이 방귀를 뀝니다.
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
			{{Heart}} 증발성 하트 +2
			{{AngelDevilChanceSmall}} 사라지는 체력을 잃어도 악마방/천사방 확률에 영향이 없습니다.
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
			↑ {{DamageSmall}}공격력 +1
			↑ {{DamageSmall}}공격력 배율 x1.35
			↓ {{TearsSmall}}연사 배율 x0.5
			↓ {{RangeSmall}}사거리 배율 x0.8
			방귀 눈물을 곡선형으로 발사합니다.
			소지 중인 콩에 따라 눈물에서 나오는 방귀가 달라집니다.
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
			{{ffBruise}} 사용 시 멍 스택 3개를 쌓는 방귀를 뀝니다.
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
			{{ffPacified}} 사용 시 그 방의 랜덤 타입 중 하나를 6초간 진정시킵니다.
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
			{{Bomb}} 폭탄 +5

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
			사용 시 그 방의 적, 장애물, 픽업을 지웁니다.
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
			↑ {{Heart}}최대 체력 +1
			↑ {{HealingRed}}빨간하트 +1
			↑ {{SpeedSmall}}이동속도 +0.1
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
			!!! 일회용 !!!
			사용 시 소지 중인 패밀리어 중 하나를 2개 복사합니다.
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
			사용 시 공격방향으로 목표 지점을 조준합니다.
			목표 지점과 캐릭터 사이에 레이저가 생겨 적에게 (0.5 + 공격력 x0.1)의 피해를 줍니다.
			조준 중일 때 목표 지점 주변의 적은 해당 위치를 향해 공격합니다.
			레이저는 조준 중이 아닐 때도 유지되나 방을 나가면 사라집니다.
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
			{{SoulHeart}} 소울하트 +1 (화요일인 경우 +3)
			↕ 주기적으로 {{DamageSmall}} +0.3 / {{RangeSmall}} -0.5 중 하나로 교체
			{{Bomb}} 소지 중인 폭탄 중 하나를 흡수합니다.
			!!! {{ColorRed}}루트 진행 아이템 획득 불가{{CR}}, 획득 시도 시 {{DamageSmall}} +7로 대체
			{{TearsSmall}} Filter 옵션이 켜져 있는 상태에서 연사 +0.66
			{{DamageSmall}} Corpse I, Ashpit II, Knife Piece 2 구역에서 공격력 +3
			{{PlanetariumChance}} G 키를 누르면 천체관 확률 +20%
			{{Pill}} Scarred Womb II에서 알약 10개 사용 시에만 그 스테이지의 보스 처치 가능
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
			{{DamageSmall}} 방 클리어 시마다 공격력 +0.025
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
			사용 시 그 방의 랜덤 위치에 트롤폭탄을 하나 소환합니다.
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
			15%의 확률로 클렌징 공격이 나갑니다.
			{{LuckSmall}} 행운 7+일 때 100%
			클렌징 공격 명중 시 그 적의 챔피언 상태를 제거, 보상을 드랍합니다.
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
			캐릭터를 따라다니며 적의 탄환을 막아줍니다.
			{{ffPacified}} 탄환을 10회 막을 시 5초간 주변의 탄환을 반사하며, 주변의 적을 진정시킵니다.
			{{Timer}} (쿨타임 4초)
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
			{{Collectible638}} 눈물이 지우개로 바뀝니다.
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
			20%의 확률로 망상 공격을 합니다.
			{{LuckSmall}} 행운 8+일 때 100%
			망상 공격 명중 시 8방향으로 공격력 x0.5의 적 관통 눈물이 나갑니다.
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
			↑ 목숨 +1
			↑ {{EmptyHeart}}빈 최대 체력 +1
			{{Collectible289}} 사망 시 그 자리에서 부활합니다.
			>>> {{HealingRed}} 전체 체력이 2칸 미만인 경우 방마다 1번씩 체력을 반칸 회복합니다.
			>>> {{Collectible257}} 빨간하트가 1칸 이하인 경우 화상 공격, 공격력 +1
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
			일정 효과를 가진 눈물이 순서대로 나옵니다.
			적 명중 시 29%의 확률로 랜덤 상태이상에 걸립니다.
			{{LuckSmall}} 행운 7+일 때 100%
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
			사용 시 그 방의 탄환을 지웁니다.
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
			4방향 중 랜덤 위치에 캐릭터의 주변에 있으며 적의 탄환을 막아줍니다. (공격 중 위치 변경)
			{{Freezing}} 랜덤 방향으로 공격력 3.5의 빙결 눈물을 발사합니다.
			!!! 공전형 패밀리어의 거리가 멀어집니다.
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
			33%의 확률로 공격력 x0.65의 공격이 3발로 나갑니다.
			{{LuckSmall}} 행운 10+일 때 100%
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
			가능한 경우 방 클리어 시 1칸 너머의 방으로 향하는 홀로그램 문을 생성합니다. (생성 시 맵에 위치 표시)
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
			주기적으로 랜덤 적에게 응시 표식이 걸립니다.
			응시 표식이 걸린 적 명중 시 그 방의 캐릭터 눈물 및 적 탄환이 그 적을 향해 발사됩니다.
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
			공격 시 주변의 적에게 공격력 0.66의 눈물을 빠르게 발사합니다.
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
			캐릭터의 주변을 돌며 적의 탄환을 막아줍니다.
			공격력 3.5의 레이저를 발사합니다.
			적 탄환 방어 시 33%의 확률로 다음 공격이 강해집니다.
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
			캐릭터를 따라다니며 이동 반대방향으로 공격력 2의 눈물을 발사합니다.
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
			↑ {{LuckSmall}}행운 +1
			{{LuckSmall}} 최초 획득 시 행운을 4 이상이 되도록 증가
			{{LuckSmall}} 행운이 0 이상일 때 피격 시 체력이 없는 경우 행운을 -4 감소시키며 그 피해를 무효화 + 그 방의 탄환을 지웁니다.
			{{LuckSmall}} 방 클리어 시 감소한 행운을 1씩 복원시킵니다.
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
			{{Bomb}} 폭탄 +5
			캐릭터가 설치한 폭탄이 더 빨리 터지며 캐릭터에게 피해를 주지 않습니다.
			폭탄이 터질 때 그 방의 탄환을 지웁니다.
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
			공격 시 10%의 확률로 공격방향에 있는 적의 위치로 돌덩이를 투척합니다.
			돌덩이 투척 시 주변의 적에게 (공격력 x2.5 + 5)의 피해를 줍니다.
		]],
		Tests = {
			"10% chance on fire to drop a boulder on the closest enemy aligned with the shooting direction",
			"Deals damage that scales with Isaac's damage in a radius upon impact",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.OCULAR_SPECTRUM] = {
		_descType = "collectible",
		Name = "오큘러 스펙트럼",
		QuoteDesc = "",
		Description = [[
			소지 중일 때 공격방향으로 공격력 x0.25의 공격을 하는 새틀라이트를 소환합니다.
			사용 시 새틀라이트가 회전하여 눈물을 빠르게 발사합니다.
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
			↑ {{SpeedSmall}}이동속도 +0.2
			{{Key}} 열쇠를 하나 드랍합니다.
		]],
		Tests = {
			"↑ +0.2 Speed",
			"{{Key}} Spawns a key",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.SHADOW_RABBITS] = {
		_descType = "collectible",
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.EXTENSION] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
			사용 시 랜덤 100% 오렌지 주스 출신 카드의 효과를 발동합니다.
		]],
		Tests = {
			"Gives Isaac the effect of a random 100% Orange Juice card",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.TECH_ULTIMA] = {
		_descType = "collectible",
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.DAUNTING_DOG] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ {{DamageSmall}}공격력 +1
			{{ffBruise}} 공격방향으로 공격력 5의 멍들게 하는 눈물을 발사합니다.
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.DOUBLE_DOG..[[}} {{BossRoom}} {{MiniBoss}} 보스방/미니보스방에서 획득한 아이템이 Double Dog에 의해 교체됨
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
			↑ {{TearsSmall}}연사 +0.5
			{{Trinket144}} 공격방향으로 공격력 3.5의 직각 유도성 눈물을 발사합니다.
			25%의 확률로 눈물이 두발로 나갑니다.
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.DOUBLE_DOG..[[}} {{Library}} 책방에서 획득한 아이템이 Double Dog에 의해 교체됨
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
			↑ {{LuckSmall}}행운 +1
			강아지 주변을 도는 공격력 3의 눈물을 2발씩 발사합니다.
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.DOUBLE_DOG..[[}} {{Planetarium}} 천체관에서 획득한 아이템이 Double Dog에 의해 교체됨
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
			↑ {{TearsSmall}}연사 +0.1
			{{Collectible1}} 적 처치 시 10%의 확률로 30초간 랜덤 양파 계열 아이템의 효과를 얻습니다.
			{{LuckSmall}} 행운 45+일 때 100%
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
			↑ {{SpeedSmall}}이동속도 +0.15
			↑ {{ShotspeedSmall}}탄속 +0.15
			↑ {{LuckSmall}}행운 +1
			{{Collectible1}} 방 입장 시 아이템이 3%의 확률로 랜덤 양파 계열의 아이템으로 바뀝니다.
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
			매 7번째 공격마다 폭발성 완전 관통 탄환이 왼쪽/오른쪽을 향해 발사됩니다. 
			탄환은 적에게 공격력 x2.1의 피해를 주며 주변의 적에게 40의 피해를 줍니다.
			발사 위치는 매 2번째 공격 시 공개되며 캐릭터의 반대편에서 지정됩니다.
			!!! 탄환 폭발이 캐릭터에게도 피해를 줍니다.
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
			방 주변을 돌아다니며 순간이동합니다.
			접촉한 적에게 랜덤 상태이상 피해를 줍니다.
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
			새틀라이트에서 공격방향으로 공격력 1.25의 눈물을 발사합니다.
			{{ColorYellow}}불안 오브{{CR}}: 적 처치 시 드랍되며 일정 수 이상 모으면 새틀라이트의 레벨이 상승합니다.
			새틀라이트 레벨에 따라 공격하는 새틀라이트 수가 늘어납니다. (최대 4)
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
			↑ {{DamageSmall}}최종 공격력 +40
			↓ {{TearsSmall}}연사 배율 x0.33
			↓ {{RangeSmall}}사거리 배율 x0.8
			↓ {{ShotspeedSmall}}탄속 -0.2
			{{Poison}} 폭발하는 독눈물을 {{ColorOrange}}반대{{CR}} 곡선형으로 발사합니다.
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
			???
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
			{{Timer}} 사용 시 45초, 혹은 방 4개 클리어 시까지:
			>>> 공격 불가, 캐릭터가 지형을 무시
			>>> 적을 향해 자동으로 공격하는 그림자 토끼를 6마리 소환합니다. (소형:{{DamageSmall}}x0.4/대형:{{DamageSmall}}x0.66)
			>>> 캐릭터가 그림자 토끼 중 하나에 접촉하여 그 토끼를 조종 + 피해량 증가
		]],
		-- 소지 중일 때 방 입장 시 그 방에서 33%의 확률로 랜덤 그림자 토끼를 하나 소환합니다.
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
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.GUNSLINGERS_GRIT] = { -- TODO
		_descType = "collectible",
		Name = "총잡이의 끈기",
		QuoteDesc = "",
		Description = [[
			{{Timer}} 사용 시:
			>>> {{TearsSmall}} 증발성 연사 +7
			>>> {{Burning}} 주변의 탄환을 없애며 주변의 적에게 (공격력 x2.5 + 5)의 화상 피해를 줍니다.
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
			↑ {{Heart}}최대 체력 +1
			↑ {{HealingRed}}빨간하트 +1
			{{ffStevenHeart}} 스티븐하트 +3
		]],
		Tests = {
			"{{Heart}} +1 Health",
			"{{HealingRed}} Heals 1 heart",
			"{{ffStevenHeart}} +3 Steven Hearts",
			"Steven hearts go over other hearts and shoot at enemies from the HUD",
		},
		AppendEntries = {
			"FF_APPEND_STEVEN_HEART",
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
			{{ffStevenHeart}} 사용 시 스티븐하트 +1
		]],
		Tests = {
			"{{ffStevenHeart}} +1 Steven Heart",
			"Steven hearts go over other hearts and shoot at enemies from the HUD",
		},
		AppendEntries = {
			"FF_APPEND_STEVEN_HEART",
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
			↑ {{DamageSmall}}공격력 +0.5
			↑ {{ShotspeedSmall}}탄속 +1.5
			공격이 적에게 유도됩니다.
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
			방 안을 돌아다니며 주변의 적 하나에서 영혼을 뽑아갑니다.
			{{Slow}} 영혼이 뽑인 적은 느려집니다.
			영혼 3~5개를 먹으면 아래 중 하나 발동:
			>>> {{Collectible634}} [60%] 연옥의 유령
			>>> {{Card}} [20%] 랜덤 공격형 카드
			>>> {{ffCursedPenny}} [8%] 저주페니
			>>> {{ffCursedPenny}} [6%] 유령페니
			>>> {{Collectible584}} [3.49%] 위습
			>>> {{Collectible712}} [2.5%] 아이템 위습
			>>> {{ffDireChest}} [0.01%] 트롤상자 배열 아이템 (최대 3회)
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
			방 입장 시 20%의 확률로 수상한 거너가 등장합니다.
			수상한 거너는 랜덤 적에게 공격력 20의 탄환을 발사합니다.
			탄환 6회 발사 후 사라지며 {{Coin}}{{Bomb}}{{Key}} 중 캐릭터가 가장 적게 소지한 픽업을 하나 드랍합니다.
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
			{{Coin}} 사용 시 동전 5개를 소모하여 랜덤 우유를 마십니다.
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
			캐릭터를 따라다니며 적의 탄환을 막아줍니다.
			{{Collectible291}} 탄환을 막을 시 10% 확률로 그 방의 일반 적을 똥으로 바꿉니다.
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
			↑ {{SpeedSmall}}이동속도 +0.2
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
			!!! 일회용 !!!
			{{Heart}} 산타에게 편지를 쓰면 랜덤 석기류 3개를 드랍합니다.
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
			↑ {{DamageSmall}}공격력 +0.3
			!!! 획득 시 모든 모드가 망가집니다.
		]],
		Tests = {
			"{{Warning}} Prevents all modded code from running {{Warning}}",
			"Requires a full game restart to fix",
			"↑ +0.3 Damage",
		},
	},
	[ITEM..FiendFolio.ITEM.COLLECTIBLE.LANKY_MUSHROOM] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↓ {{TearsSmall}}연서 -0.4
			↑ {{DamageSmall}}공격력 +0.7
			↑ {{RangeSmall}}사거리 +0.75
			캐릭터가 길쭉해집니다.
		]],
		Tests = {
        "↑ +0.7 Damage",
				"↓ -0.4 Tears",
				"↑ +0.75 Range ",
				"Makes Isaac 50% taller and 25% thinner",
		},
	},
	--#endregion
	--#endregion

	--#region TRINKETS
	--#region REHEATED TRINKETS
	[TRINKET..FiendFolio.ITEM.TRINKET.SHARD_OF_CHINA] = {
		_descType = "trinket",
		Name = "차이나의 조각",
		QuoteDesc = "나를 재조립",
		Description = [[
			체력이 없거나 꽉 찬 상태에서 빨간하트 습득 시 특수 체력 게이지가 채워집니다.
			{{DamageSmall}} 채워진 게이지 1칸 당 공격력 +1.5
			게이지 완충 시 자동으로 흡수됩니다.
			특수 체력 게이지는 {{ButtonRT}}버튼을 꾹 누르거나 빨간하트 근처에 있을 때 캐릭터 위에 표시됩니다.
		]],
		Tests = {
			"Overhealing charges a secondary health bar",
			"{{Damage}} Filling this health bar accumulates a damage boost up to +1.5 Damage for each heart filled",
			"Auto-smelts once the bar is completely filled",
			"This health bar can be viewed by viewing the map"
		},
		Golden = {
			TargetMultipliers = {
				1.5,
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.BIFURCATED_STARS] = {
		_descType = "trinket",
		Name = "찢어진 별",
		QuoteDesc = "보스에게 찾아가라, 그리고 보상을 받아가라",
		Description = [[
			{{BossRoom}} 맵에 보스방의 위치가 표시됩니다.
			{{TreasureRoom}} 보스방 클리어 시 보스방 출구가 보물방으로 향하게 바뀝니다.
		]],
		Tests = {
			"Reveals the {{BossRoom}} Boss Room on the map",
			"The Boss Room exit door is replaced with a door to the {{TreasureRoom}} Treasure Room after the room is cleared"
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FORTUNE_WORM] = {
		_descType = "trinket",
		Name = "운세 지렁이",
		QuoteDesc = "어쩌구 저쩌구",
		Description = [[
			↑ {{ShotspeedSmall}}탄속 +0.2
			↑ {{LuckSmall}}행운 +2
			1%의 확률로 적에게 명중 시 운세를 보여주는 공격력 x1.05의 포춘쿠키를 발사합니다.
			{{LuckSmall}} 행운 18+일 때 33%
		]],
		Tests = {
			"↑ +0.2 Shot speed",
			"↑ +2 Luck",
			"1% chance to fire a fortune worm tear that does x1.05 damage",
			"{{Luck}} 33% chance at 18 luck"
		},
		Golden = {
			TargetMultipliers = {
				0.2,
				2,
				1,
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FOOLS_GOLD] = {
		_descType = "trinket",
		Name = "바보를 위한 금덩이",
		QuoteDesc = "돈을 더 원해?",
		Description = [[
			{{ffCursedPenny}} 방 클리어 보상이 7%의 확률로 저주페니로 바뀝니다.
			{{LuckSmall}} 행운 14+일 때 100%
		]],
		Tests = {
			"{{ffCursedPenny}} 7% chance for Cursed Pennies to drop on room clear",
			"{{Luck}} 100% chance at 14 luck"
		},
		AppendEntries = {
			"FF_APPEND_CURSED_PENNY",
		},
		Golden = {
			TargetMultipliers = {
				7
			},
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.EXTRA_VESSEL] = {
		_descType = "trinket",
		Name = "추가 그릇",
		QuoteDesc = "체력 증가",
		Description = [[
			소지 시 임시 체력의 역할을 합니다.
			{{DevilChanceSmall}} 악마방 확률에 영향 없음
			{{EmptyHeart}} 현재 비어 있음
		]],
		Tests = {
			"{{EmptyHeart}} Stores an extra heart",
			"{{DevilChance}} Does not count against Devil Deal chance"
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.HALF_VESSEL] = {
		_descType = "trinket",
		Name = "추가 그릇",
		QuoteDesc = "체력 증가",
		Description = [[
			소지 시 임시 체력의 역할을 합니다.
			{{DevilChanceSmall}} 악마방 확률에 영향 없음
			{{HalfHeart}} 현재 반칸 채워짐
		]],
		Tests = {
			"{{HalfHeart}} Stores an extra heart",
			"{{DevilChance}} Does not count against Devil Deal chance"
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FULL_VESSEL] = {
		_descType = "trinket",
		Name = "추가 그릇",
		QuoteDesc = "체력 증가",
		Description = [[
			소지 시 임시 체력의 역할을 합니다.
			{{DevilChanceSmall}} 악마방 확률에 영향 없음
			{{Heart}} 현재 한칸 채워짐
		]],
		Tests = {
			"{{Heart}} Stores an extra heart",
			"{{DevilChance}} Does not count against Devil Deal chance"
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.CHILI_POWDER] = {
		_descType = "trinket",
		Name = "칠리 파우더",
		QuoteDesc = "그 시절의 뜨거운 열쇠고리",
		Description = [[
			{{ffSpicyKey}} 모든 열쇠를 매운열쇠로 바꿉니다.
		]],
		Tests = {
			"{{ffSpicyKey}} Key pickups are turned into spicy keys"
		},
		AppendEntries = {
			"FF_APPEND_SPICY_KEY",
		},
		Golden = {
			FullReplace = {
				"{{ffSpicyKey}} Key pickups are turned into spicy keys#{{ColorGold}}{{Warning}} Spicy Keys transform into Super Spicy Keys which give three keys, but damage Isaac for a full heart#{{ColorGold}}{{ffSpicyKey}} Super Spicy Keys transform into Quadruple Super Spicy Keys",
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.GMO_PENNY] = {
		_descType = "trinket",
		Name = "GMO 페니",
		QuoteDesc = "알약 부자",
		Description = [[
			동전을 주울 시 5%의 확률로 랜덤 알약을 강제로 사용합니다.
			{{LuckSmall}} 행운 95+일 때 100%
		]],
		Tests = {
			"Picking up a coin has a 5% chance to consume a pill",
			"{{Luck}} 100% chance at 95 luck"
		},
		Golden = {
			TargetMultipliers = {
				5,
			},
			TargetStrings = {
				"a pill",
				"2 pills",
				"3 pills",
				"4 pills",
			},
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.MOLTEN_PENNY] = {
		_descType = "trinket",
		Name = "녹아내리는 페니",
		QuoteDesc = "일한 만큼의 대가",
		Description = [[
			동전을 주울 시 2%의 확률로 소지 중인 장신구를 흡수합니다.
			{{LuckSmall}} 행운 196+일 때 100%
		]],
		Tests = {
			"Picking up a coin has a 2% chance to smelt a trinket",
			"{{Luck}} 100% chance at 196 luck"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.BLOODY_SANDPAPER] = {
		_descType = "trinket",
		Name = "피 묻은 사포",
		QuoteDesc = "멈춰!",
		Description = [[
			캐릭터의 이동 관성을 제거하여 이동키를 떼면 즉시 멈춥니다.
		]],
		Tests = {
			"Isaac no longer has movement momentum",
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.RIGHT_HAND] = {
		_descType = "trinket",
		Name = "오른손목",
		QuoteDesc = "빛의 보상을 거두어들이다",
		Description = [[
			{{EternalChest}} 상자가 33%의 확률로 이터널 상자로 교체됩니다.
		]],
		Tests = {
			"{{HolyChestRoomIcon}} Chests have a 33% chance of becoming Eternal Chests"
		},
		Golden = {
			TargetStrings = {
				"33",
				"50",
				"50",
				"50",
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.RED_RIBBON] = {
		_descType = "trinket",
		Name = "빨간 리본",
		QuoteDesc = "영원 2배",
		Description = [[
			{{ffFullEternalHeart}} 이터널하트 반칸 픽업을 한칸 픽업으로 바꿉니다.
			{{Heart}} 한칸짜리 이터널하트 획득 즉시 최대 체력 +1
		]],
		Tests = {
			"{{ffFullEternalHeart}} Half Eternal Hearts become Full Eternal Hearts"
		},
		Golden = {
			FullReplace = {
				"{{ffFullEternalHeart}} {{ColorGold}} All Eternal Hearts become Double Full Eternal Hearts"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FLEA_MELTDOWN] = {
		_descType = "trinket",
		Name = "붕괴의 벼룩",
		QuoteDesc = "붕괴를 초래",
		Description = [[
			{{Burning}} 방 입장 시 적에게 공격력 x3의 화상 피해를 주는 주황색 아군 벼룩을 소환합니다.
		]],
		Tests = {
			"Entering a hostile room spawns an Orange Skuzz",
			"{{Burning}} This skuzz does 3x Isaac's damage and will ignite enemies"
		},
		Golden = {
			TargetStrings = {
				"an Orange Skuzz",
				"2 Orange Skuzzes",
				"3 Orange Skuzzes",
				"4 Orange Skuzzes",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FLEA_DELUGE] = {
		_descType = "trinket",
		Name = "홍수의 벼룩",
		QuoteDesc = "홍수를 초래",
		Description = [[
			방 입장 시 적에게 공격력 x3의 피해 + 8방향으로 눈물을 흩뿌리는 푸른색 아군 벼룩을 소환합니다.
		]],
		Tests = {
			"Entering a hostile room spawns an Cyan Skuzz",
			"This skuzz does 3x Isaac's damage and will leave damaging creep"
		},
		Golden = {
			TargetStrings = {
				"an Cyan Skuzz",
				"2 Cyan Skuzzes",
				"3 Cyan Skuzzes",
				"4 Cyan Skuzzes",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FLEA_POLLUTION] = {
		_descType = "trinket",
		Name = "오염의 벼룩",
		QuoteDesc = "오염을 초래",
		Description = [[
			{{Slow}} 방 입장 시 적에게 공격력 x3의 둔화 피해를 주는 보라색 아군 벼룩을 소환합니다.
		]],
		Tests = {
			"Entering a hostile room spawns an Purple Skuzz",
			"{{Slow}} This skuzz does 3x Isaac's damage and will slow enemies"
		},
		Golden = {
			TargetStrings = {
				"an Purple Skuzz",
				"2 Purple Skuzzes",
				"3 Purple Skuzzes",
				"4 Purple Skuzzes",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FLEA_PROPAGANDA] = {
		_descType = "trinket",
		Name = "선전의 벼룩",
		QuoteDesc = "선전을 초래",
		Description = [[
			{{Charm}} 방 입장 시 적에게 공격력 x3의 매혹 피해를 주는 보라색 아군 벼룩을 소환합니다.
		]],
		Tests = {
			"Entering a hostile room spawns an Beige Skuzz",
			"{{Charm}} This skuzz does 3x Isaac's damage and will charm enemies"
		},
		Golden = {
			TargetStrings = {
				"an Beige Skuzz",
				"2 Beige Skuzzes",
				"3 Beige Skuzzes",
				"4 Beige Skuzzes",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FUZZY_PENNY] = {
		_descType = "trinket",
		Name = "털 많은 페니",
		QuoteDesc = "벼룩 부자",
		Description = [[
			동전을 주울 시 아군 자폭 벼룩을 소환합니다.
		]],
		Tests = {
			"Picking up a coin spawns a Blue Skuzz"
		},
		Golden = {
			TargetStrings = {
				"a Blue Skuzz",
				"2 Blue Skuzzes",
				"3 Blue Skuzzes",
				"4 Blue Skuzzes"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.CHUNK_OF_TAR] = {
		_descType = "trinket",
		Name = "타르 덩이",
		QuoteDesc = "진흙 친구",
		Description = [[
			방 진입 시 아군 blot을 1~3마리 소환합니다.
		]],
		Tests = {
			"Spawns 3 friendly Blots when entering a room with enemies"
		},
		Golden = {
			TargetStrings = {
				"3",
				"5",
				"7",
				"9",
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FORTUNE_GRUB] = {
		_descType = "trinket",
		Name = "운세 애벌레",
		QuoteDesc = "점술기계의 속삭임",
		Description = [[
			↑ {{LuckSmall}}행운 +1
			거지 및 슬롯머신이 보답을 내놓을 시 운세를 같이 표시합니다.
		]],
		Tests = {
			"↑ +1 Luck",
			"All beggars and slot machines will display a fortune alongside their possible payouts"
		},
		Golden = {
			TargetStrings = {
				"1",
				"2",
				"3",
				"4",
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.JIGSAW_PUZZLE_BOX] = {
		_descType = "trinket",
		Name = "직소 퍼즐 상자",
		QuoteDesc = "조각은 잃어버리기 마련",
		Description = [[
			]]..FiendFolio.DescriptionIcons.PuzzlePiece..[[ 스테이지 진입 시 Puzzle Piece를 소환합니다. (일회용)
			]]..FiendFolio.DescriptionIcons.PuzzlePiece..[[ 20%의 확률로 카드를 Puzzle Piece로 바꿉니다.
			!!! 퍼즐 완성 시 제거됨
		]],
		Tests = {
			FiendFolio.DescriptionIcons.PuzzlePiece .. "Only once, drops a Puzzle Piece at the start of the next floor",
			"20% chance to replace card spawns with a Puzzle Piece if one is used",
			"{{Warning}} This trinket is removed whenever a puzzle is completed"
		},
		Golden = {
			TargetMultipliers = {
				"20",
			},
			TargetStrings = {
				"a Puzzle Piece",
				"2 Puzzle Pieces",
				"3 Puzzle Pieces",
				"4 Puzzle Pieces",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.YIN_YANG_ORB] = {
		_descType = "trinket",
		Name = "음양 오브",
		QuoteDesc = "유도성 부적",
		Description = [[
			17%의 확률로 공격력 x1.25의 강한 유도 공격이 나갑니다.
			{{LuckSmall}} 행운 7+일 때 64%
		]],
		Tests = {
			"17% chance to fire a homing tear that deals x1.25 your damage",
			"{{Luck}} 64% chance at 7 luck"
		},
		Golden = {
			TargetStrings = {
				"x1.25",
				"x1.75",
				"x2.25",
				"x2.75",
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SWALLOWED_M90] = {
		_descType = "trinket",
		Name = "삼킨 M90",
		QuoteDesc = "푸슉!",
		Description = [[
			피격 시 M90을 꺼내;
			다음 공격 시 공격력 x3.5의 적을 관통하는 탄속이 빠른 눈물을 발사합니다.
			!!! 눈물 발사 시 캐릭터가 뒤로 밀려납니다.
		]],
		Tests = {
			"On hit, Isaac pulls out an M90, causing his next shot to be a fast, piercing bullet that does x3.50 damage with self-knockback"
		},
		Golden = {
			TargetStrings = {
				"x3.50",
				"x4.50",
				"x5.50",
				"x6.50",
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.TRINITY_WORM] = {
		_descType = "trinket",
		Name = "트리니티 벌레",
		QuoteDesc = "워 워 워!",
		Description = [[
			↑ {{TearsSmall}}연사 +0.4
			↑ {{RangeSmall}}사거리 +12.5
			눈물이 트리케트라 모양으로({{Collectible333}}) 날아갑니다.
			공격이 장애물을 관통합니다.
		]],
		Tests = {
			"↑ +0.4 Tears",
			"↑ +12.5 Range",
			"Spectral tears",
			"Tears move in a holy trinity-style pattern",
		},
		Golden = {
			TargetMultipliers = {
				12.5
			},
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.IOU] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "언젠간 돌려줄게",
		Description = [[
			방 클리어 시 15%의 확률로 장신구를 추가로 드랍합니다.
			{{LuckSmall}} 행운 30+일 때 90%
			{{Trinket}} 게임 종료(게임오버/엔딩) 시점에서 이 장신구 소지 시 다음 게임 시작 시 랜덤 장신구를 하나 소환합니다.
		]],
		Tests = {
			"15% chance for a trinket to be dropped on room clear",
			"{{Luck}} 90% chance at 30 luck",
			"{{Trinket}} If held at the end of your run, spawns a random trinket at the start of your next run"
		},
		Golden = {
			TargetMultipliers = {
				15,
			},
		},
		Conditional = function(descObj)
			if descObj.ObjSubType == mod.ITEM.TRINKET.IOU + TrinketType.TRINKET_GOLDEN_FLAG then
				local description = descObj.Description
				descObj.Description = string.gsub(description, "random trinket", "random {{ColorGold}}golden trinket{{ColorText}}")
				descObj.Description = description .. "#{{ColorGold}}10% chance for trinkets to spawn golden"
			end
		end,
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.AUTOPSY_KIT] = {
		_descType = "trinket",
		Name = "포렌식 키트",
		QuoteDesc = "장기 수확",
		Description = [[
			{{Heart}}상점 주인 처치 시 동전 대신 빨간하트를 드랍합니다.
			{{EmptyBoneHeart}} 낮은 확률로 뼈하트를 대신 드랍
			원래 동전의 등급이 높을수록 뼈하트의 드랍률이 증가합니다.
		]],
		Tests = {
			"{{Heart}} Bombed Shopkeepers will drop Red Hearts and rarely Bone Hearts instead of coins",
			"The chance of getting higher-quality hearts increases with the quality of coins replaced"
		},
		Golden = {
			Tests = {
				"Bone hearts have a higher chance of dropping"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SPIRE_GROWTH] = {
		_descType = "trinket",
		Name = "스파이어 성장",
		QuoteDesc = "카드의 힘",
		Description = [[
			{{DamageSmall}} 타로 타입 카드 사용 시 사용한 카드 번호의 숫자에 비례하여 공격력이 증가합니다.
		]],
		Tests = {
			"{{Timer}} Using a card grants a damage up that scales with the number of the card, if applicable"
		},
		Golden = {
			Tests = {
				"{{Damage}} Increased damage when using cards with numbers"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FLEA_CIRCUS] = {
		_descType = "trinket",
		Name = "벼룩 서커스",
		QuoteDesc = "감염",
		Description = [[
			적 처치 시 20%의 확률로 랜덤 벼룩을 소환합니다.
		]],
		Tests = {
			"20% chance to spawn a random friendly Flea when an enemy is killed"
		},
		Golden = {
			TargetMultipliers = {
				20,
			},
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SHARP_PENNY] = {
		_descType = "trinket",
		Name = "뾰족한 페니",
		QuoteDesc = "고통 부자",
		Description = [[
			동전을 주울 시 27%의 확률로 피격 효과를 발동합니다.
		]],
		Tests = {
			"Picking up a coin has a 17% chance to hurt Isaac without removing health"
		},
		Golden = {
			Tests = {
				"Higher chance to hurt Isaac without removing health"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.ANGRY_FAIC] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "풍부한 보스",
		Description = [[
			{{BossRoom}} 보스방의 보스 및 미니보스의 체력이 10% 증가합니다.
			{{Heart}} 보스 처치 시 하트류 픽업을 추가로 드랍합니다.
		]],
		Tests = {
			"Bosses and Minibosses fought in the {{BossRoom}} Boss Room will start with 10% more health",
			"{{Heart}} Bosses and Minibosses in the {{BossRoom}} will also drop additional hearts when defeated"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {5, 10, 15, 20},
				TargetNumbers = {10},
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.ETERNAL_CAR_BATTERY] = {
		_descType = "trinket",
		Name = "이터널 자동차 건전지",
		QuoteDesc = "???",
		Description = [[
			{{Battery}} 액티브 아이템 사용 시 효과가 4~6번 발동되지만 50%의 확률로 액티브 아이템이 사라집니다.
		]],
		Tests = {
			"{{Battery}} Active items are triggered 4-6 times, but have a 1/2 chance to disappear on use"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.POCKET_DICE] = {
		_descType = "trinket",
		Name = "주사위 주머니",
		QuoteDesc = "층마다 새로운 운명",
		Description = [[
			스테이지 진입 시 랜덤 유리 주사위 조각 2개와 동전을 하나 드랍합니다.
		]],
		Tests = {
			"Drops 2 random Glass Die and a coin at the start of each floor"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.LOCKED_SHACKLE] = {
		_descType = "trinket",
		Name = "잠겨있는 족쇄",
		QuoteDesc = "모든 능력치 증가 + 열쇠가 없어",
		Description = [[
			!!! 제거 및 교체불가
			↑ {{TearsSmall}}연사 +0.35
			↑ {{DamageSmall}}공격력 +1
			↑ {{RangeSmall}}사거리 +1
			↑ {{ShotspeedSmall}}탄속 +0.16
			↑ {{LuckSmall}}행운 +1
			열쇠를 주울 시 25%의 확률로 열쇠를 강제로 소모하고 장신구를 파괴합니다.
		]],
		Tests = {
			"↑ +0.35 Tears",
			"↑ +0.35 Damage",
			"↑ +1 Range",
			"↑ +0.16 Shot speed",
			"↑ +1 Luck",
			"Picking up keys has a 25% chance to destroy the trinket and use a key",
			"{{Warning}} Can't be dropped"
		},
		Golden = {
			Tests = {
				"Removeable!"
			},
			TargetMultipliers = {
				"0.35",
				"1",
				"0.16",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SOLEMN_VOW] = {
		_descType = "trinket",
		Name = "굳건한 맹세",
		QuoteDesc = "해롭지 않음",
		Description = [[
			{{Collectible403}} 적의 체력과 적에게 주는 피해량이 수치로 표시됩니다.
		]],
		Tests = {
			"Displays tear damage and health bars of all enemies"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.DEALMAKERS] = {
		_descType = "trinket",
		Name = "딜메이커",
		QuoteDesc = "특별 거래",
		Description = [[
			{{Shop}}{{DevilChance}} 방 입장시마다 모든 판매 아이템의 가격이 바뀝니다.
			일부 품목은 20%의 확률로 빠른 속도로 가격이 계속 바뀝니다.
		]],
		Tests = {
			"{{Shop}}{{DevilChance}} Randomizes Shop and Devil Deal prices",
			"20% chance for Shop and Devil Deal items to have constantly shifting prices"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {12, 12, 12, 12},
				TargetNumbers = {20},
			},
			Tests = {
				"Shifting prices are faster"
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.JEVILSTAIL] = {
		_descType = "trinket",
		Name = "제빌의 꼬리",
		QuoteDesc = "뭐든지 할 수 있어!",
		Description = [[
			방 입장시마다 정해진 순서대로 특정 효과를 발동합니다.
		]],
		Tests = {
			"Entering a room gives Isaac a random effect in a rotating list that can either be harmful or helpful"
		},
		Golden = {
			TargetStrings = {
				"a random effect",
				"2 random effects",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.PETRIFIED_GEL] = {
		_descType = "trinket",
		Name = "굳은 젤",
		QuoteDesc = "운이 좋은 건가?",
		Description = [[
			일반 똥이 20%의 확률로 샴푸로 대체됩니다.
			샴푸 파괴 시 랜덤 픽업을 드랍합니다.
		]],
		Tests = {
			"20% chance for Poops to be replaced with Shampoo",
			"You get better drops from destroying Shampoos"
		},
		Golden = {
			TargetMultipliers = {
				20,
			},
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.HATRED] = {
		_descType = "trinket",
		Name = "혐오",
		QuoteDesc = "더블탭 악의",
		Description = [[
			캐릭터와 같이 이동하며 공격하는 방향으로 캐릭터의 공격과 같은 공격을 발사합니다. ({{DamageSmall}}x0.4)
			공격키를 두번 누르면 장애물에 부딪힐 때까지 돌진하며;
			{{Slow}} 접촉한 적에게 피해를 주고 돌진한 자리에 적을 느려지게 하는 장판을 생성합니다.
			{{Timer}}돌진 후 장애물에 부딪히면 사라지며 일정 시간 이후 다시 생성됩니다.
		]],
		Tests = {
			"Slime familiar that mimics Isaac's movement",
			"Copies Isaac's tear effects and fire-rate at 40% damage",
			"{{Slow}} Fired tears also inflict Slowness",
			"Can be fired as a piercing projectile by double tapping, also applying tear effects",
			"{{Timer}} Respawns after a second"
		},
		Golden = {
			Tests = {
				"Spawns additional familiars",
			},
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FROG_PUPPET] = {
		_descType = "trinket",
		Name = "개구리 인형",
		QuoteDesc = "이세계의 초록빛",
		Description = [[
			↑ 목숨 +1 (소진 시 장신구 제거)
			{{Player]]..FiendFolio.PLAYER.SLIPPY..[[}} 사망 시 즉시 Slippy로 부활합니다.
		]],
		Tests = {
			"↑ +1 Life",
			"{{Player" .. FiendFolio.PLAYER.SLIPPY .. "}} On death, Isaac revives as Slippy"
		},
		Golden = {
			TargetStrings = {
				"1 Life",
				"2 Lives",
				"3 Lives",
				"4 Lives",
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.TATTERED_FROG_PUPPET] = {
		_descType = "trinket",
		Name = "찢어진 개구리 인형",
		QuoteDesc = "이젠 네가 초록빛이야",
		Description = [[
			↑ 목숨 +1 (소진 시 장신구 제거)
			{{Player]]..FiendFolio.PLAYER.SLIPPY..[[}} 사망 시 즉시 Slippy로 부활합니다.
		]],
		Tests = {
			"↑ +1 Life",
			"{{Player" .. FiendFolio.PLAYER.SLIPPY .. "}} On death, Isaac revives as Slippy"
		},
		Golden = {
			TargetStrings = {
				"1 Life",
				"2 Lives",
				"3 Lives",
				"4 Lives",
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.CURSED_URN] = {
		_descType = "trinket",
		Name = "저주받은 항아리",
		QuoteDesc = "영원한 생명?",
		Description = [[
			!!! {{ColorOrange}}교체 및 버리기 시 깨짐{{CR}}
			!!! {{ColorOrange}}폭발 피해를 받으면 깨짐{{CR}}
			↑ 목숨 +1 (소진 시 장신구 제거)
			↑ {{TearsSmall}}공격 딜레이 x0.75
			{{Player]]..FiendFolio.PLAYER.CHINA..[[}} 사망 시 즉시 China로 부활합니다.
		]],
		Tests = {
			"↑ x0.75 Fire rate multiplier",
			"↑ +1 Life",
			"{{Player" .. FiendFolio.PLAYER.CHINA .. "}} On death, Isaac revives as China",
			"{{Warning}} Dropping or exploding the trinket breaks it"
		},
		Golden = {
			TargetMultipliers = {
				"0.75", "1",
			},
		},
		Conditional = function(descObj) -- This suuucks... but it's the best I could do
			local split = mod:SplitString(descObj.Description, "#")
			local lastValidLine = #split + 1

			for i, line in ipairs(split) do
				if i == 1 then
					split[i] = string.gsub(line, "%d*%.?%d+", function(s)
						local values = {-0.19, -0.33, -0.43, -0.51}
						local multiplier = (tonumber(s) / 0.75) - 1

						if multiplier > 0 then
							return tostring(0.75 + values[multiplier])
						end
					end)
				end

				for _, blacklistedPrefix in ipairs(mod.EIDBlacklistedPrefix) do
					if line:sub(1, blacklistedPrefix:len()) == blacklistedPrefix then
						lastValidLine = i
						break
					end
				end
			end

			if descObj.ObjSubType == mod.ITEM.TRINKET.CURSED_URN + TrinketType.TRINKET_GOLDEN_FLAG then
				table.insert(split, lastValidLine, "{{ColorGold}}Can be dropped once without shattering, no longer being gilded")
			end
			descObj.Description = table.concat(split, "#")
		end,
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SHATTERED_CURSED_URN] = {
		_descType = "trinket",
		Name = "깨진 항아리",
		QuoteDesc = "이미 깨졌어",
		Description = [[
			↑ {{TearsSmall}}공격 딜레이 x0.9
		]],
		Tests = {
			"↑ x0.9 Fire rate multiplier",
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {-0.09, -0.17, -0.24, -0.30},
				TargetNumbers = {0.9},
			},
			Tests = {
				"↑ +1 Life",
				"{{Player" .. FiendFolio.PLAYER.CHINA .. "}} {{ColorGold}}On death, Isaac revives as China"
			},
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.CRAIGS_PIPE] = { -- TODO
		_descType = "trinket",
		Name = "크레이그의 파이프",
		QuoteDesc = "",
		Description = [[
			↑ 목숨 +1 (소진 시 장신구 제거)
			{{Player]]..FiendFolio.PLAYER.CRAIG..[[}} 사망 시 즉시 Craig로 부활합니다.
		]],
		Tests = {
			"↑ +1 Life",
			"{{Player" .. FiendFolio.PLAYER.CRAIG .. "}} On death, Isaac revives as Craig"
		},
		Golden = {
			TargetStrings = {
				"1 Life",
				"2 Lives",
				"3 Lives",
				"4 Lives",
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.CONJOINED_CARD] = {
		_descType = "trinket",
		Name = "쌍둥이 카드",
		QuoteDesc = "작은 황제",
		Description = [[
			{{MiniBoss}} 스테이지 진입 시 미니보스방을 추가로 생성합니다.
			!!! Blue Womb, The Void, Home 스테이지는 무효과
		]],
		Tests = {
			"{{MiniBoss}} 1 additional Miniboss Room will generate on every floor"
		},
		Golden = {
			TargetStrings = {
				"1 additional Miniboss Room",
				"2 additional Miniboss Rooms",
				"3 additional Miniboss Rooms",
				"4 additional Miniboss Rooms",
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.LOST_FLOWER_CROWN] = {
		_descType = "trinket",
		Name = "잊혀진 꽃 왕관",
		QuoteDesc = "잊혀진 기억",
		Description = [[
			{{Collectible638}} 스테이지 당 1회 한정으로 랜덤 적 하나가 해당 게임에서 제거되어 다시 등장하지 않습니다.
		]],
		Tests = {
			"{{Collectible638}} Once a floor, a random enemy will get erased"
		},
		Golden = {
			TargetStrings = {
				"a random enemy",
				"2 random enemies",
				"3 random enemies",
				"4 random enemies",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.WACKEY] = {
		_descType = "trinket",
		Name = "왜키",
		QuoteDesc = "엉뚱한 열쇠",
		Description = [[
			{{Key}} 열쇠류 픽업의 드랍률이 동일하게 변경됩니다.
		]],
		Tests = {
			"{{Key}} All key drops have an equal chance to become any of the possible key types",
		},
		Golden = {
			Tests = {
				"Keys cannot be replaced with low value keys", -- Could elaborate more if the system allowed it
			}
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.MASSIVE_AMETHYST] = {
		_descType = "trinket",
		Name = "거대 아메시스트",
		QuoteDesc = "수정화된 주인",
		Description = [[
			{{SecretRoom}} 비밀방 상점 주인이 룬이 박힌 돌덩이로 바뀝니다.
			룬이 박힌 돌덩이 파괴 시 {{Card55}}Rune Shard 0~3개, {{Rune}}룬 0~2개를 드랍합니다.
		]],
		Tests = {
			"Shopkeepers in secret rooms are replaced by rune clusters",
			"{{Rune}} Blowing up a rune cluster causes it to drop:",
			"1-3 Rune Shards",
			"One to two random Runes"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {1, 2, 3, 4},
				TargetNumbers = {1, 3},
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.HEARTACHE] = {
		_descType = "trinket",
		Name = "심장통",
		QuoteDesc = "마음이 아파",
		Description = [[
			{{BrokenHeart}} 피격 시 그 피격을 무효화하고 부서진하트 +1
		]],
		Tests = {
			"{{BrokenHeart}} +1 Broken Heart when taking damage"
		},
		Golden = {
			TargetStrings = {
				"1 Broken Heart",
				"2 Broken Hearts",
				"3 Broken Hearts",
				"4 Broken Hearts"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.REDHAND] = {
		_descType = "trinket",
		Name = "붉은 손",
		QuoteDesc = "잡았다!",
		Description = [[
			캐릭터/픽업/적을 잡아 강제로 이동시키는 빨간 손 2개가 방을 돌아다닙니다.
		]],
		Tests = {
			"Spawns 2 Red Hand familiars that fly from off-screen",
			"These familiars drag Isaac, pickups, and enemies around"
		},
		Golden = {
			TargetStrings = {
				"2",
				"3",
				"4",
				"5"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.MIDDLE_HAND] = {
		_descType = "trinket",
		Name = "가운데손목",
		QuoteDesc = "부덕한 보상을 거두어들이다",
		Description = [[
			{{ffDireChest}} 일반상자/황금상자가 50%의 확률로 확률로 트롤상자로 교체됩니다.
		]],
		Tests = {
			"50% chance for any {{Chest}} Chest or {{GoldenChest}} Golden Chest to be replaced by a {{ffDireChest}} Dire Chest"
		},
		AppendEntries = {
			"FF_APPEND_DIRE_CHEST",
		},
		Golden = {
			TargetStrings = {
				"50",
				"100",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.RAINBOW_BEAN] = {
		_descType = "trinket",
		Name = "무지개 콩",
		QuoteDesc = "친숙한 방귀",
		Description = [[
			적에게 가까이 다가갈 시 5%의 확률로 랜덤 방귀를 뀝니다.
			{{LuckSmall}} 행운 48+일 때 100%
		]],
		Tests = {
			"5% chance to expell a random fart when near enemies",
			"{{Luck}} 100% chance at 48 luck"
		},
		Golden = {
			Tests = {
				"Increased radius at which farts expell",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FAULTY_FUSE] = {
		_descType = "trinket",
		Name = "끊어진 퓨즈",
		QuoteDesc = "탄 구리 맛",
		Description = [[
			{{Bomb}} 폭탄이 40%의 확률로 구리폭탄으로 바뀝니다.
			{{ffCopperBomb}} 방 클리어 시 5%의 확률로 구리폭탄으로 바뀝니다.
		]],
		Tests = {
			"{{Bomb}} 40% for random Bomb drops to be replaced by Copper Bombs",
			"{{ffCopperBomb}} 5% chance for a Copper Bomb to be dropped on room clear"
		},
		AppendEntries = {
			"FF_APPEND_COPPER_BOMB",
		},
		Golden = {
			TargetMultipliers = {
				"40",
				"5",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.ENERGY_SEARCHER] = {
		_descType = "trinket",
		Name = "에너지 탐지기",
		QuoteDesc = "에너지 드로우",
		Description = [[
			방 클리어 시 5%의 확률로 에너지 카드를 추가로 드랍합니다.
			에너지 카드 사용 시 33%의 확률로 다른 에너지 카드를 소환합니다.
		]],
		Tests = {
			"5% chance for an Energy Card to be dropped on room clear",
			"Using an Energy Card has a 33% chance to spawn another random Energy Card"
		},
		Golden = {
			TargetMultipliers = {
				"5",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.BROKEN_RECORD] = {
		_descType = "trinket",
		Name = "부서진 레코드",
		QuoteDesc = "반복된 채로 멈춰있어",
		Description = [[
			아이템이 등장할 때 30%의 확률로 소지 중인 아이템으로 등장합니다.
			중첩 가능한 아이템만 등장합니다.
		]],
		Tests = {
			"30% chance for newly-spawned item pedestals to be replaced with an passive item you already have",
			"Will not provide you with useless duplicates"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {21, 36, 46, 53},
				TargetNumbers = {30},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FUSHIGI] = {
		_descType = "trinket",
		Name = "불가사의",
		QuoteDesc = "떠다니게 해!",
		Description = [[
			{{Collectible572}} 공격 시 5%의 확률로 공격력 x2의 오컬트 눈물을 발사합니다.
			{{LuckSmall}} 행운 9+일 때 50%
		]],
		Tests = {
			"{{Collectible572}} 5% chance to fire a metal Eye of the Occult tear with increased range and double damage",
			"{{Luck}} 50% chance at 9 luck"
		},
		Golden = {
			TargetMultipliers = {
				"5",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.NESTING_DOLL] = {
		_descType = "trinket",
		Name = "인형 안의 인형",
		QuoteDesc = "안에서의 서프라이즈",
		Description = [[
			{{Beggar}} 거지 폭파 시 80%의 확률로 그 자리에서 다른 거지가 생깁니다.
		]],
		Tests = {
			"{{Beggar}} 80% chance for another, smaller beggar to appear when blowing up a beggar"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.EGG_PENNY] = {
		_descType = "trinket",
		Name = "알 페니",
		QuoteDesc = "아기 부자",
		Description = [[
			{{Collectible8}} {{Coin}}동전을 주울 때 17%의 확률로 Fragile Bobby를 소환합니다.
			{{Collectible8}} Fragile bobby는 Brother Bobby와 동일하나 5회 피격 시 사라집니다.
		]],
		Tests = {
			"Picking up a coin has a 17% chance to spawn a Fragile Bobby",
			"{{Collectible8}} Fragile bobbies are similar to Brother Bobby but can die"
		},
		Golden = {
			Tests = {
				"Higher chance to spawn a Fragile Bobby"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.LEFTOVERS] = {
		_descType = "trinket",
		Name = "먹다 남은 음식",
		QuoteDesc = "나중을 위해 아껴",
		Description = [[
			{{Heart}} 초과회복된 하트류 픽업을 남깁니다.
		]],
		Tests = {
			"{{HalfHeart}} Overhealed health gained from heart pickups will be left on the ground for later use"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FUZZY_PICKLE] = {
		_descType = "trinket",
		Name = "퍼지 피클",
		QuoteDesc = "패러디 증가",
		Description = [[
			↑ {{DamageSmall}}공격력 +0.25
			{{DamageSmall}} 패러디 아이템 당 공격력 +0.1
			{{Blank}} (패러디가 약한 경우 +0.05)
			액티브 아이템인 경우 +0.5, 장신구의 경우 +0.25
		]],
		Tests = {
			"↑ +0.25 Damage",
			"{{Damage}} +0.1 Damage up for each reference item Isaac has",
			"{{Damage}} Trinkets grant +0.25 Damage",
			"{{Damage}} Active items grant +0.5 Damage",
			"Loose references only grant half of the corresponding damage"
		},
		Golden = {
			TargetMultipliers = {
				"0.25",
				"0.1",
				"0.5",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.DUDS_FLOWER] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{ffCopperBomb}} 캐릭터가 설치한 폭탄이 전부 구리폭탄으로 설치됩니다.
		]],
		Tests = {
			"{{ffCopperBomb}} All bombs placed by Isaac will become Copper Bombs"
		},
		AppendEntries = {
			"FF_APPEND_COPPER_BOMB",
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.BOMB_TOKEN] = {
		_descType = "trinket",
		Name = "폭탄 토큰",
		QuoteDesc = "폭발력 증가",
		Description = [[
			{{Bomb}} 플레이어의 폭탄의 피해량 +50
			{{Collectible52}} 페투스 폭탄의 경우 피해량 x1.25
		]],
		Tests = {
			"{{Bomb}} Increases the flat damage dealt by bombs spawned by Isaac by 50",
			"{{Collectible52}} Grants a 1.25x damage multiplier to Dr. Fetus bombs"
		},
		Golden = {
			TargetMultipliers = {
				"50",
				"1.25",
			}
		}
	},
	--#endregion
	--#region RELOADED TRINKETS
	[TRINKET..FiendFolio.ITEM.TRINKET.QUALITY_ASSURANCE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Card]] .. FiendFolio.ITEM.CARD.DOWNLOAD_FAILURE .. [[}} 방 입장 시 10%의 확률로 적이 오류에 걸립니다.
			오류 걸린 적 처치 시 아군 자폭 벌레 3마리를 소환합니다.
		]],
		Tests = {
			"10% chance for enemies to spawn in with the Glitched status effect",
			"{{Card" .. FiendFolio.ITEM.CARD.DOWNLOAD_FAILURE .. "}} Glitched enemies slide around the room",
			"Glitched enemies spawn 3 blue bugs on death"
		},
		Golden = {
			TargetMultipliers = {
				"10",
				"3",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.CERBERUS_ORB] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			2.5초간 공격하지 않으면:
			>>> 다음 공격 시 2배의 피해를 주며 탄속이 빠릅니다.
			>>> 명중 시 주변의 적에게 공격력 x1의 추가 피해를 줍니다.
		]],
		Tests = {
			"After not firing for 2.5 seconds, the next shot will deal double damage and have increased velocity",
			"This shot will deal base damage in a small radius around itself on impact"
		},
		Golden = {
			TargetStrings = {
				"double damage",
				"triple damage",
				"quadruple damage",
				"quintuple damage",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.BONE_LORDS_TABLET] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			카드 사용 시 뼛조각 배리어 를 4~5개 소환합니다.
		]],
		Tests = {
			"Using a card will grant 4-5 bone orbitals"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {4, 5, 6, 4},
				TargetNumbers = {4, 5},
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SCARAB_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			코인을 집으면 무당벌레를 1마리 소환합니다.
		]],
		Tests = {
			"Picking up a coin spawns a Blue Beetle",
			"Blue Beetles are friendly creatures that shield Isaac from oncoming attacks and projectiles"
		},
		AppendEntries = {
			"FF_APPEND_BEETLES",
		},
		Golden = {
			TargetStrings = {
				"a Blue Beetle",
				"2 Blue Beetles",
				"3 Blue Beetles",
				"4 Blue Beetles",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.STACK_OF_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{ffLilPenny}} 동전 획득 시 리틀 페니를 1~4개 소환합니다.
		]],
		Tests = {
			"{{ffLilPenny}} Picking up a coin spawns 1-4 Lil' Pennies"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {1, 2, 3, 4},
				TargetNumbers = {1, 4},
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.PINCUSHION] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{ffSew}} 25%의 확률로 적을 귀속시키는 재봉틀 눈물을 발사합니다.
			{{LuckSmall}} 행운 6+일 때 100%
		]],
		Tests = {
			"25% chance to shoot sewing needle tears that pierce and inflict enemies with Sewn",
			"{{Luck}} 100% chance at 6 luck",
			"{{ffSew}} Sewn enemies reflect damage taken onto all other enemies inflicted with Sewn"
		},
		AppendEntries = {
			"FF_APPEND_SEW",
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {13, 25, 38, 50},
				TargetNumbers = {25},
			},
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.WAVEBREAKER] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Room}} 방 클리어 후 등장하는 적이 나오지 않습니다.
			!!! ({{BossRushRoom}} 보스러시 및 {{ChallengeRoom}} 도전방류의 웨이브가 아님)
		]],
		Tests = {
			"Wave 2 enemies no longer appear",
			"Does not affect multi-wave room types like {{BossRushRoom}} Boss Rush or {{ChallengeRoom}} Challenge Rooms"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.CHARRED_CARD] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Bomb}} 폭탄 설치 시 그 방의 랜덤 위치에 트롤폭탄이 같이 설치됩니다.
		]],
		Tests = {
			"{{Bomb}} Placing a bomb will also place a Troll Bomb in the room",
			"Troll bombs avoid Isaac and prioritize enemies"
		},
		Golden = {
			TargetStrings = {
				"a Troll Bomb",
				"2 Troll Bombs",
				"3 Troll Bombs",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.GLUTTONOUS_JOKER] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Bomb}} 가능한 경우 모든 플레잉 카드 문양이 클로버로 등장합니다.
		]],
		Tests = {
			"{{Bomb}} Converts all suit cards to Club cards, if possible"
		},
		Golden = {
			Tests = {
				"2 of Clubs cards are converted into 3 of Clubs"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.WRATHFUL_JOKER] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Key}} 가능한 경우 모든 플레잉 카드 문양이 스페이드로 등장합니다.
		]],
		Tests = {
			"{{Key}} Converts all suit cards to Spade cards, if possible"
		},
		Golden = {
			Tests = {
				"2 of Spades cards are converted into 3 of Spades"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.GREEDY_JOKER] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Coin}} 가능한 경우 모든 플레잉 카드 문양이 다이아로 등장합니다.
		]],
		Tests = {
			"{{Coin}} Converts all suit cards to Diamond cards, if possible"
		},
		Golden = {
			Tests = {
				"2 of Diamonds cards are converted into 3 of Diamonds"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.LUSTY_JOKER] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Heart}} 가능한 경우 모든 플레잉 카드 문양이 하트로 등장합니다.
		]],
		Tests = {
			"{{Heart}} Converts all suit cards to Heart cards, if possible"
		},
		Golden = {
			Tests = {
				"2 of Hearts cards are converted into 3 of Hearts"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.EVIOLITE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ 모든 능력치 대폭 증가
			↓ 소지 아이템 수만큼 감소 (10개에서 무효화)
		]],
		Tests = {
			"↑ Large all stats up",
			"↓ Stat increase reduces with each owned item, degrading to 0 at 10 items"
		},
		Golden = {
			TargetMultipliers = {
				"10"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SLEEPY_DUST] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{ffSleeping}} 15%의 확률로 적을 나른하게 만드는 공격이 나갑니다.
			{{LuckSmall}} 행운 25+일 때 30%
		]],
		Tests = {
			"15% chance to fire tears that inflict enemies with Drowsy",
			"{{Luck}} 30% chance at 25 luck",
		},
		AppendEntries = {
			"FF_APPEND_DROWSY",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.DROWSY_AND_SLEEP },
		Golden = {
			TargetMultipliers = {
				"15"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.EARTH_IMPALE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Chargeable}} 충전형 가시 공격을 추가로 합니다.
			가시 공격은 캐릭터 주변의 십자가 범위의 적에게 공격력 비례 피해를 줍니다.
		]],
		Tests = {
			"{{Chargeable}} Gain a charged attack to make a rock spike in the cardinal directions",
			"The rock spike attack scales with Isaac's damage",
		},
		Golden = {
			Tests = {
				"Rock spike attack does more damage"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.COMFORT_FOOD] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{HealingRed}} 방 클리어 보상이 등장하지 않았을 경우 50%의 확률로 체력을 반칸 회복합니다.
		]],
		Tests = {
			"{{HalfHeart}} 50% chance to heal half a heart if a room clear reward does not spawn"
		},
		Golden = {
			TargetStrings = {
				"half a heart",
				"a heart",
				"a heart and a half",
				"two hearts",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SPROUTING_SEED] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			클리어하지 않은 방에서 교체/버리기 시 줄기가 자라며 주변의 적을 멀리 이동시키지 못하게 합니다.
			일정 시간 후 장신구 형태로 돌아옵니다.
			!!! 피격 시 강제로 버려짐
		]],
		Tests = {
			"Dropping this trinket in an uncleared room will grow a vine that snares nearby enemies",
			"Taking damage will drop the trinket automatically"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.JOY_BUZZER] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Battery}} 모든 배터리가 특수 형태로 바뀝니다.
			{{Shop}} 상점에서 판매 중인 카드가 50%의 확률로 배터리로 바뀝니다.
		]],
		Tests = {
			"{{Battery}} All batteries are replaced by virtuous, cursed, or firework batteries",
			"{{Coin}} 50% chance to replace cards in shops with batteries"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {25, 50, 50, 50},
				TargetNumbers = {50},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.INTERNALIZED_HATRED] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{BlackHeart}} 블랙하트가 사라지면 {{ColorOrange}}기존의 효과 대신{{CR}} 공격력이 증가합니다.
		]],
		Tests = {
			"{{BlackHeart}} ↑ Grants a Damage Up whenever a Black Heart is depleted",
			"Black Hearts no longer deal damage to enemies"
		},
		Golden = {
			Tests = {
				"Greater damage up when a Black Heart is depleted"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.DELIGHTFUL_DRUMSTICK] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			공격 시 25%의 확률로 4방향으로 눈물을 추가로 발사합니다.
			{{LuckSmall}} 행운 15+일 때 45%
			{{Charm}} 내려놓은 경우에는 패밀리어로서 활동
		]],
		Tests = {
			"25% chance to fire in a cross shape whenever shooting",
			"{{Luck}} 45% chance at 15 luck",
			"{{Charm}} Acts like a friendly Drumstick when dropped on the ground"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {10, 20, 30, 40},
				TargetNumbers = {25},
			},
			Tests = {
				"Drumstick tears deal increased damage"
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.PROJECTILE_TRINKET] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			적 탄환입니다.
		]],
		Tests = {
			"Is a projectile",
			"You shouldn't have this"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.IMP_FINGER] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Collectible]] ..FiendFolio.ITEM.COLLECTIBLE.PYROMANCY ..[[}} 주기적으로 캐릭터의 주변을 도는 Fiend의 파이어볼이 최대 1마리까지 생성됩니다.
			공격키를 두번 누르면 파이어볼을 발사합니다.
			발사한 파이어볼은 지나간 자리에 작은 불을 남기며 무언가에 부딪힐 시 폭발합니다,
		]],
		Tests = {
			"One orbital fireball can frequently spawn around Isaac",
			"{{Collectible" ..FiendFolio.ITEM.COLLECTIBLE.PYROMANCY .."}} Spawns fireballs at 3x slower rate compared to Pyromancy"
		},
		Golden = {
			TargetStrings = {
				"One orbital fireball",
				"Two orbital fireballs",
				"Three orbital fireballs",
				"Four orbital fireballs",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.GODHEADJR] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Collectible331}} 10%의 확률로 후광이 달린 눈물이 나갑니다.
			{{LuckSmall}} 행운 8+일 때 40%
		]],
		Tests = {
			"{{Collectible331}} 10% chance to shoot a godhead tear",
			"{{Luck}} 40% chance at 8 luck"
		},
		Golden = {
			TargetMultipliers = {
				"10"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FLAMING_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Collectible]] ..FiendFolio.ITEM.COLLECTIBLE.PYROMANCY ..[[}} 동전 획득 시 Fiend의 파이어볼을 하나 생성합니다.
		]],
		Tests = {
			"Picking up a coin spawns an orbital fireball"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.TAN_WORM] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ 연사 +0.4
			↑ 사거리 +18
			눈물이 장애물을 관통하며 탄젠트 파형 형태로 이동합니다.
		]],
		Tests = {
			"↑ +0.4 Tears",
			"↑ +18 Range",
			"Spectral tears",
			"Isaac's tears move in a tangent wave"
		},
		Golden = {
			TargetMultipliers = {
				"18"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.ADBLOCKER] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			모든 운세 팝업을 제거합니다.
		]],
		Tests = {
			"Removes all fortune popups",
			"Will notify Isaac when a popup is blocked"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.THE_SHAMPOO_BOTTLE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ 공격력 +0.1
			색돌이 있는 방을 지나칠 경우 알려줍니다.
		]],
		Tests = {
			"↑ +0.1 Damage",
			"Provides insightful commentary on many things",
			"Points out missed tinted rocks"
		},
		Golden = {
			TargetMultipliers = {
				"0.1"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.BUTTON_MASHER] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			액티브 아이템이 자동으로 사용됩니다.
			{{Blank}} (일부 아이템은 방 진입 시에만 사용)
			{{Blank}} (일부 아이템은 무효과)
			{{Blank}} (충전량이 없는 경우 3프레임마다 사용)
		]],
		Tests = {
			"Automatically uses your active item",
			"Starts automatically using your active item on room entry",
			"Chargeless items are automatically used"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.PENNY_PACK] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			동전 획득 시 8%의 확률로 페니류 장신구를 드랍합니다.
		]],
		Tests = {
			"Picking up a coin has a 8% chance to spawn a penny trinket"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.ORIGINAL_EGGPLANT] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			패러디 아이템이 등장하지 않습니다.
		]],
		Tests = {
			"Prevents reference items from spawning"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.CHEMISTRY_KIT] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			모든 모닥불이 챔피언으로 바뀝니다.
			장애물이 7%의 확률로 챔피언으로 바뀝니다.
		]],
		Tests = {
			"All fires are replaced by Champion Fires",
			"7% chance for grids to turn into Champion Fires",
			"Champion Fires have effects similar to enemy champions when destroyed"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {6, 13, 20, 26},
				TargetNumbers = {7},
			},
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FADED_CARD] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{BossRoom}} 메이저가 아닌 모든 보스를 스킵하며 보상이 드랍되지 않습니다.
		]],
		Tests = {
			"All non-story {{BossRoom}} Boss Rooms will be skipped, granting no rewards and deleting the boss instantly"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.STITCHED_CARD] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			스테이지 진입 시 시작 방이 아닌 랜덤 특수방에서 시작합니다.
		]],
		Tests = {
			"Isaac starts each floor in a random special room"
		},
		Golden = {
			Tests = {
				"The random special room Isaac spawns in is better"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.STAINED_CARD] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ 공격력 +2.5
			패널티 피격 시 증가된 공격력 x0.5
		]],
		Tests = {
			"↑ +2.5 Damage",
			"Taking damage will steadily lower this damage bonus"
		},
		Golden = {
			Tests = {
				"The amount of damage bonus lost is lowered"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.CROWDED_CARD] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Heart}} 하트를 주우면 10%의 확률로 하트 픽업을 소환합니다.
		]],
		Tests = {
			"{{Heart}} 10% chance to spawn a heart of a random type when picking up a heart"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {5, 10, 15, 20},
				TargetNumbers = {10},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.HOLLOW_CARD] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{SuperSecretRoom}} 모든 비밀방이 일급비밀방으로 대체됩니다.
		]],
		Tests = {
			"All {{SecretRoom}} Secret Rooms are replaced by {{SuperSecretRoom}} Super Secret Rooms instead"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SPADE_OF_CLUBS] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			폭탄과 열쇠 픽업이 주기적으로 바뀝니다.
		]],
		Tests = {
			"Bomb and key pickups will periodically swap between each other while on the ground"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.MINIATURE_CARD] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			스테이지 진입 시:
			>>> {{Room}} 5x5 범위의 방을 지도에 표시합니다.
			>>> {{HealingRed}} 빨간하트를 1칸 회복합니다.
			>>> 처음 1개째까지 들어간 방에서 적에게 40의 피해를 줍니다.
		]],
		Tests = {
			"Reveals rooms in a 5x5 radius upon starting a new floor",
			"{{Heart}} Heals 1 hearts on the start of a new floor",
			"Isaac will deal 40 damage to all enemies in the first 1 rooms he enters each floor"
		},
		Golden = {
			TargetMultipliers = {
				"1",
			}
		},
		Conditional = function(descObj) -- This suuucks... but it's the best I could do
			descObj.Description = string.gsub(descObj.Description, "1 hearts", "1 heart")
			descObj.Description = string.gsub(descObj.Description, "1 rooms", "room")
		end,
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.HONEYED_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			]]..FiendFolio.DescriptionIcons.Honey..[[동전 획득 시 50%의 확률로 적을 느려지게 하는 공격 및 장판을 생성합니다.
		]],
		Tests = {
			FiendFolio.DescriptionIcons.Honey ..  "Picking up a coin has a 50% chance to grant a slowing trail and slowing tears for a period"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {25, 50, 50, 50},
				TargetNumbers = {50},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.LINK_CABLE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Collectible478}} 방 입장 시 20%의 확률로 적을 멈춥니다.
			30초 후 혹은 공격 시 효과가 풀립니다.
		]],
		Tests = {
			"20% chance to pause all enemies in the room until Isaac attacks or enough time passes"
		},
		Golden = {
			TargetMultipliers = {
				"20"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.TOKEN_ON_A_STRING] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			!!! 일회용 
			]]..FiendFolio.DescriptionIcons.Token .. [[스테이지 진입 시 토큰을 소환합니다.
		]],
		Tests = {
			FiendFolio.DescriptionIcons.Token .. "Spawns a Token on the next floor",
			"Tokens mimic the effect of the previous pickup collected",
			"Trinket destroys itself on the next floor"
		},
		AppendEntries = {
			"FF_APPEND_TOKENS"
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.INFESTATION_ONE_POINT_FIVE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			적 처치 시 아군 미니 자폭 거미를 1마리 소환합니다.
		]],
		Tests = {
			"Killing an enemy spawns a Blue Baby Spider"
		},
		Golden = {
			TargetStrings = {
				"a Blue Baby Spider",
				"2 Blue Baby Spiders",
				"3 Blue Baby Spiders",
				"4 Blue Baby Spiders",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SHOOTING_STAR] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{DamageSmall}} {{TreasureRoom}} 보물방 스킵 시 다음 스테이지에서 공격력 +1
		]],
		Tests = {
			"{{TreasureRoom}} When skipping a Treasure Room on a floor:",
			"↑ +1 Damage"
		},
		Golden = {
			TargetMultipliers = {1},
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.LONGTIME_FIEND] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{DamageSmall}} 공격력 +0.1
			{{DamageSmall}} 스테이지 진입 시 공격력 +0.33
		]],
		Tests = {
			"↑ +0.1 Damage on first pickup",
			"↑ +0.33 Damage when entering a new floor"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.VANILLA_EXTRACT] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			WoTL, Afterbirth 출신 스테이지가 등장하지 않습니다.
			(9스테이지부터 무효과)
		]],
		Tests = {
			"Only classic floors can appear (Basement, Caves, Depths, Womb)",
			"Does nothing beyond Womb",
			"Does nothing on the alternate path (Downpour, Dross, Mines, Ashpit, Mausoleum, Gehenna, Corpse)"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.OLD_SHELL] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			10%의 확률로 공격력 x0.7의 공격 4발로 발사합니다.
		]],
		Tests = {
			"{{Luck}} 10% chance to fire 1 quadruple-shot",
			"{{Damage}} Quadruple shot tears deal x0.7 damage each"
		},
		Golden = {
			TargetMultipliers = {
				1,
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.BREAKPOINT] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Collectible478}} 피격 시 그 방의 적을 멈춥니다.
			5초 후 혹은 공격 시 효과가 풀립니다.
		]],
		Tests = {
			"{{Collectible" .. CollectibleType.COLLECTIBLE_PAUSE .. "}} Taking damage pauses every enemy in the room for up to 5 seconds",
			" Attacking will break the pause early"
		},
		Golden = {
			TargetMultipliers = {
				5
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.CONTRA_BAND] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			거지가 50%의 확률로 수상한 행동을 하는 거지로 바뀝니다.
		]],
		Tests = {
			"50% chance for Beggars to be replaced with Fake Beggars"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {25, 50, 50, 50},
				TargetNumbers = {50},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.PLUSH_LAMB] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			!!! 일회용
			아이템 제거 시 이 아이템이 대신 제거됩니다.
		]],
		Tests = {
			"Whenever you would next lose an item for any reason, Plush Lamb will be removed instead"
		},
		Golden = {
			Tests = {
				"Plush Lamb will de-gild instead of being lost and can be used a second time"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.LIMITED_TIME_OFFER] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Collectible64}} 스테이지 진입 시 2분간 할인 아이템의 개수가 증가합니다.
		]],
		Tests = {
			"{{Collectible" .. CollectibleType.COLLECTIBLE_STEAM_SALE .. "}} For up to 2 minutes after entering a floor, some items in the shop will be half price"
		},
		Golden = {
			TargetMultipliers = {
				2
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FIENDISH_LADYBUG] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			클리어하지 않은 방 진입 시 보라색 아군 무당벌레를 1마리 소환합니다.
			보라색 무당벌레는 적의 탄환을 반사하며 반사탄은 50%의 확률로 적에게 x5의 피해를 줍니다.
		]],
		Tests = {
			"Entering a hostile room spawns a Purple Beetle",
			"This beetle reflects projectiles with a 50% chance for them to deal 5x damage"
		},
		Golden = {
			TargetStrings = {
				"a Purple Beetle",
				"2 Purple Beetles",
				"3 Purple Beetles",
				"4 Purple Beetles",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.BASTARDLY_LADYBUG] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			클리어하지 않은 방 진입 시 검은색 아군 무당벌레를 1마리 소환합니다.
			{{Slow}} 검은색 무당벌레는 적의 탄환을 반사하며 반사탄은 적에게 둔화 피해 + 둔화 장판을 생성합니다.
		]],
		Tests = {
			"Entering a hostile room spawns a Black Beetle",
			"{{Slow}} This beetle reflects projectiles that slow enemies and leave a slowing puddle on impact"
		},
		Golden = {
			TargetStrings = {
				"a Black Beetle",
				"2 Black Beetles",
				"3 Black Beetles",
				"4 Black Beetles",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FRIENDLY_LADYBUG] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			클리어하지 않은 방 진입 시 빨간색 아군 무당벌레를 1마리 소환합니다.
			빨간색 무당벌레는 적의 탄환을 반사하며 반사탄은 적에게 x1.5배의 피해 + 처치 시 사라지는 빨간하트 드랍
		]],
		Tests = {
			"Entering a hostile room spawns a Red Beetle",
			"This beetle reflects projectiles that deal 1.5x damage and cause enemies to drop temporary hearts on kill"
		},
		Golden = {
			TargetStrings = {
				"a Red Beetle",
				"2 Red Beetles",
				"3 Red Beetles",
				"4 Red Beetles",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SKELETAL_LADYBUG] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			클리어하지 않은 방 진입 시 회색 아군 무당벌레를 1마리 소환합니다.
			회색 무당벌레는 적의 탄환을 반사하며 반사탄은 무언가에 부딪힐 때 2갈래로 나뉩니다.
		]],
		Tests = {
			"Entering a hostile room spawns a Grey Beetle",
			"This beetle reflects projectiles that split into two bone tears on impact"
		},
		Golden = {
			TargetStrings = {
				"a Grey Beetle",
				"2 Grey Beetles",
				"3 Grey Beetles",
				"4 Grey Beetles",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.CLUMP_OF_LADYBUGS] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			적 처치 시 20%의 확률로 랜덤 무당벌레를 소환합니다.
		]],
		Tests = {
			"20% chance to spawn a random Ladybug when an enemy is killed"
		},
		Golden = {
			TargetMultipliers = {
				20,
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.STRANGE_COCOON] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			아래 일회성 패밀리어가 소환될 때 다른 종류로 소환될 수 있습니다.
			>>> 자폭 파리
			>>> 자폭 거미
			>>> 자폭 벼룩
			>>> 자폭 무당벌레
		]],
		Tests = {
			"Blue flies, spiders, skuzzes, and beetles are converted to another type when spawned"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.INK_POT] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{BlackHeart}} 블랙하트 획득 시 일부 소울하트가 블랙하트로 바뀝니다. (최대 2개)
		]],
		Tests = {
			"Gaining black hearts will also convert up to 2 souls hearts to black hearts"
		},
		Golden = {
			TargetMultipliers = {
				"2"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.LOOSE_FILAMENT] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			액티브 아이템 사용 시 Bulb 패밀리어를 소환합니다.
			Bulb 패밀리어는 적에게 2.75의 접촉 피해를 주며 액티브 충전량에 따라 지속시간이 달라집니다.
		]],
		Tests = {
			"Grants a bulb familiar that attacks enemies after Isaac uses an active item",
			"Bulb familiar does 2.75 damage",
			"Active period scales with active charge"
		},
		Golden = {
			TargetMultipliers = {
				"2.75"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SMALL_BANDAID] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			방 클리어 시 25%의 확률로 잃은 하트를 최대 1칸까지 회복합니다.
		]],
		Tests = {
			"25% chance to heal 1 damaged heart after clearing a room"
		},
		Golden = {
			TargetMultipliers = {
				"25"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SPECTRAL_KEYCHAIN] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Key}} 열쇠 픽업을 주우면 열쇠 획득 대신 유령이 나옵니다. (25%의 확률로 2마리)
			열쇠가 필요한 곳에 가까이 가면 유령을 자동으로 소모합니다.
		]],
		Tests = {
			"{{Key}} Picking up keys does not give you a key, but instead gives you a grey key wisp",
			"Key wisps will automatically spend themselves to unlock whatever is closest to Isaac",
			"Picking up a key has a 25% chance to spawn two grey key wisps"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {25, 50, 75, 75},
				TargetNumbers = {25},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SISYPHEAN_BOULDER] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↓ {{SpeedSmall}}이동속도 -0.1
			캐릭터의 이동방향으로 적에게 초당 60의 피해를 주는 둥근 바위를 굴립니다.
			{{SpeedSmall}} 바위로 적 처치 시마다 피해량이 증가하나 이동속도가 추가로 감소합니다.
		]],
		Tests = {
			"↓ -0.1 Speed",
			"Gives Isaac a boulder he can push",
			"The boulder deals 60 damage per second and can block shots",
			"{{Damage}} The boulder becomes more powerful the more kills you get with it",
			"{{Speed}} The more kills Isaac gets with the boulder, the slower he moves"
		},
		Golden = {
			TargetMultipliers = {
				"60"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.TIMES_ARROW] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			스테이지 진입 시 홀수 스테이지를 건너뜁니다. (8스테이지까지 적용)
		]],
		Tests = {
			"Automatically skips the first floor in the first 4 chapters"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.CORRUPTED_LARVA] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			클리어하지 않은 방 진입 시 버그 자폭 파리 1마리 소환합니다.
			{{Collectible285}} 버그 자폭 파리 접촉 시 그 적을 약화시킵니다.
		]],
		Tests = {
			"Spawns 1 mini Level 0 Fly upon entering an uncleared room",
			"{{Collectible285}} The mini Level 0 Fly devolves enemies it touches"
		},
		Golden = {
			TargetStrings = {
				"1 mini Level 0 Fly",
				"2 mini Level 0 Flies",
				"3 mini Level 0 Flies",
				"4 mini Level 0 Flies",
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.HINGE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			방 입장 시마다 {{Collectible]] .. FiendFolio.ITEM.COLLECTIBLE.LIL_FIEND .. [[}} Lil Fiend와 {{Collectible]] .. FiendFolio.ITEM.COLLECTIBLE.LIL_FRIEND .. [[}} Lil Friend가 교대로 등장합니다.
		]],
		Tests = {
			"{{Collectible" .. FiendFolio.ITEM.COLLECTIBLE.LIL_FIEND .. "}} Grants Lil Fiend or Lil Friend",
			"{{Collectible" .. FiendFolio.ITEM.COLLECTIBLE.LIL_FRIEND .. "}} Swaps every room"
		},
		Golden = {
			TargetStrings = {
				"Lil Fiend or Lil Friend",
				"2 Lil Fiends or 2 Lil Friends",
				"3 Lil Fiends or 3 Lil Friends",
				"4 Lil Fiends or 4 Lil Friends"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.WANTED_POSTER] = { -- TODO
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{ffMarked}} 스테이지 중 랜덤 적 하나에 특수 표식이 걸립니다.
			특수 표식이 걸린 적은 핏방울을 흩뿌리며 체력이 더 많습니다.
			{{Coin}} 특수 표식이 걸린 적 처치 시 니켈을 1개 드랍합니다.
		]],
		Tests = {
			"Once per floor, an enemy will be marked",
			"{{ffMarked}} Marked enemies are bigger, have more health, and spew tears out",
			"{{Coin}} Killing a marked enemy drops 1 nickel"
		},
		Golden = {
			TargetMultipliers = {
				1
			}
		},
		Conditional = function (descObj)
			local save = mod.getFieldInit(FiendFolio.savedata, 'run', {})

			if save.SpecialWantedPosterSpawned then
				local prefix = "#{{Player" .. mod.PLAYER.FRIEND .. "}} "
				local SPECIAL_LINE = "It states that the fugitive was last seen in a Secret room..."
				descObj.Description = descObj.Description .. prefix .. SPECIAL_LINE
			end

			return descObj
		end
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FIENDS_LOST_FRIEND] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			새로운 방 입장 시 Fiend의 부하를 1마리 소환합니다.
			소환된 부하는 방을 나가도 유지됩니다.
		]],
		Tests = {
			"Spawns a permanent Fiend Minion that helps you in the next room Isaac goes to"
		},
		Golden = {
			TargetStrings = {
				"a permanent Fiend Minion",
				"two permanent Fiend Minions",
				"three permanent Fiend Minions",
				"four permanent Fiend Minions",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.PSYCHOLOGICAL_TORTURE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			1개부터 시작하며 숫자의 개수만큼 눈물을 발사한 수만큼 발사 후 공격키를 떼면 {{DamageSmall}}공격력과 {{TearsSmall}}연사가 증가합니다.
			단계가 증가할 때마다 발사해야 되는 눈물의 수가 하나씩 증가합니다.
			공격키를 뗄 때 눈물의 개수가 맞지 않으면 증가량이 초기화됩니다.
		]],
		Tests = {
			"{{Damage}} Count with your tears for an increasing damage and tears up",
			"{{Tears}} Counting counts as firing a certain amount of tears and stopping",
			"Damage and tears increase stops if you fail to count properly"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.NOTABLE_ALBUM] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			방마다 첫 공격은 4발로 나갑니다.
		]],
		Tests = {
			"Isaac can fire a quadruple-shot once per room"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FIVE_LEAF_CLOVER] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{DamageSmall}} 행운 1당 공격력 +0.1
		]],
		Tests = {
			"{{Damage}} Damage increased by 0.1x Isaac's luck"
		},
		Golden = {
			TargetMultipliers = {
				0.1
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.CIRCADIAN_RHYTHM] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Timer}} 실 플레이 시간이 낮일 때:
			{{Blank}} (6:00 ~ 18:00)
			>>> {{SpeedSmall}} 이동속도 +0.2
			>>> {{TearsSmall}} 연사 +0.6
			{{Timer}} 실 플레이 시간이 밤일 때:
			{{Blank}} (18:00 ~ 6:00)
			>>> {{DamageSmall}} 공격력 +0.6
			>>> {{LuckSmall}} 행운 +1
		]],
		Tests = {
			"During the day (6:00 to 18:00):",
			"↑ +0.6 Tears",
			"↑ +0.2 Speed",
			"During the night (18:00 to 6:00):",
			"↑ +0.6 Damage",
			"↑ +1 Luck"
		},
		Golden = {
			TargetMultipliers = {
				0.6, 0.2, 1
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SHAMROCK_SHOE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ {{SpeedSmall}}이동속도 +0.2
			↑ {{LuckSmall}}행운 +1
		]],
		Tests = {
			"↑ +1 Luck",
			"↑ +0.1 Speed",
		},
		Golden = {
			TargetMultipliers = {
				1, 0.1
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.WET_WELLY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ {{SpeedSmall}}이동속도 +0.1
			↑ {{TearsSmall}}연사 +0.4
		]],
		Tests = {
			"↑ +0.4 Tears",
			"↑ +0.1 Speed",
		},
		Golden = {
			TargetMultipliers = {
				0.4, 0.1
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.CLOVERED_EPEE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ {{DamageSmall}}공격력 +0.3
			↑ {{LuckSmall}}행운 +1
		]],
		Tests = {
			"↑ +0.3 Damage",
			"↑ +1 Luck",
		},
		Golden = {
			TargetMultipliers = {
				0.3, 1
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.TOY_SPEAR] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ {{DamageSmall}}공격력 +0.3
			↑ {{RangeSmall}}사거리 +1.25
		]],
		Tests = {
			"↑ +0.3 Damage",
			"↑ +1.25 Range",
		},
		Golden = {
			TargetMultipliers = {
				0.3, 1.25
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.BLOODY_BLADE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ {{TearsSmall}}연사 +0.4
			↑ {{DamageSmall}}공격력 +0.3
		]],
		Tests = {
			"↑ +0.4 Tears",
			"↑ +0.3 Damage",
		},
		Golden = {
			TargetMultipliers = {
				0.4, 0.3
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.TATTY_CLEAT] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ {{SpeedSmall}}이동속도 +0.1
			↑ {{DamageSmall}}공격력 +0.3
		]],
		Tests = {
			"↑ +0.1 Speed",
			"↑ +0.3 Damage",
		},
		Golden = {
			TargetMultipliers = {
				0.1, 0.3
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.LIFE_INSURANCE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{DonationMachine}} 다음 게임 시작 시 이전 게임에 소지한 금액만큼 기부기계에 추가됩니다.
		]],
		Tests = {
			"All leftover money at the end of the run is added to the donation machine"
		},
		Golden = {
			TargetStrings = {
				"added",
				"doubled and added",
				"tripled and added",
				"quadrupled and added",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.GOLD_LEAF] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			황금 픽업의 효과가 발동되지 않습니다.
			{{Coin}} 황금 픽업 획득 시 동전 +9
		]],
		Tests = {
			"Gold pickups no longer have special effects and give you the normal pickup",
			"{{Coin}} Gold pickups also give +9 Coins"
		},
		Golden = {
			TargetMultipliers = {
				"9"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.BEATEN_CROSS] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Collectible108}} 전체 체력이 3칸 이하인 경우 받는 피해가 절반으로 감소합니다.
		]],
		Tests = {
			"{{Collectible108}} Reduces most damage taken to half a heart when Isaac has 3 hearts or less"
		},
		Golden = {
			TargetMultipliers = {
				"3"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.VICODIN] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Pill}} 알약 사용 시 그 방에서 받는 피해가 절반으로 감소합니다.
		]],
		Tests = {
			"{{Pill}} Reduces most damage taken to half a heart when taking a pill"
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.RUNIC_CUBE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Rune}} 피격 시 20%의 확률로 룬을 드랍합니다.
		]],
		Tests = {
			"{{Rune}} 15=8% chance to spawn a random rune upon taking damage"
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.ZZZZZZ_MAGNET] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			!!! {{AngelDevilChance}} 악마방/천사방으로 가는 문이 오류방을 향하도록 바꿉니다.
			{{Blank}} (맵에 생성된 방은 영향 없음)
		]],
		Tests = {
			"{{AngelDevilChance}} Turns all doors to Devil Rooms and Angel Rooms into doors to the Error Room"
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.OWL_FEATHER] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Trinket113}} 파란 자폭 파리가 20%의 확률로 폭발성 빨간 파리로 바뀝니다.
		]],
		Tests = {
			"{{Trinket113}} Blue Flies have a 20% chance to turn into Locusts of War on spawn"
		},
		Golden = {
			TargetMultipliers = {
				"20"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.POPPET] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Collectible462}} 공격 시 20%의 확률로 벨리알의 눈물이 나갑니다.
		]],
		Tests = {
			"{{Collectible462}} 20% chance to shoot a piercing Eye of Belial tear",
			"Hitting an enemy makes the tear homing and double its damage"
		},
		Golden = {
			TargetMultipliers = {
				"20"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.POWER_INVERTER] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			액티브 아이템 상태와 무관하게 배터리 픽업을 획득할 수 있습니다.
			{{Battery}} 배터리 획득 시 그 스테이지에서 {{DamageSmall}} 공격력 +0.9
		]],
		Tests = {
			"{{Battery}} Batteries give +0.9 Damage for the current floor",
			"Batteries can be picked up at full item charge or with no active item"
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.BABY_BOTTLE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{ffPacified}} 피격 시 주변의 적을 4초간 진정시킵니다.
			{{HalfSoulHeart}} 진정 상태의 적 처치 시 20%의 확률로 소울하트 반칸을 드랍합니다.
		]],
		AppendEntries = {
			"FF_APPEND_PACIFIED",
		},
		StatusEffects = { mod.DescriptionStatuses.PACIFIED },
		Tests = {
			"On hit, nearby enemies are Pacified for 4 seconds",
			"{{HalfSoulHeart}} Pacified enemies have a 20% chance to drop a half soul heart"
		},
		Golden = {
			TargetMultipliers = {
				4
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.ONE_OF_YOUR_BOMBS] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Bomb}} 삼켜진 폭탄입니다.
		]],
		Tests = {
			"{{Warning}} {{Bomb}} It's An Item Now! {{Bomb}} {{Warning}}",
		},
		Golden = {
			Tests = {
				"{{Warning}} {{Bomb}} It's Golden Now! {{Bomb}} {{Warning}}"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.TWEEZERS] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Collectible]] .. FiendFolio.ITEM.COLLECTIBLE.PARANOIA .. [[}} 30%의 확률로 망상 공격을 합니다.
			망상 공격 명중 시 명중한 적에게 되돌아오는 관통 눈물이 나갑니다.
			{{LuckSmall}} 행운 6+일 때 75%
		]],
		Tests = {
			"30% chance to fire tears that release a piercing, homing tear on hit",
			"{{Luck}} 75% chance at 6 luck",
		},
		Golden = {
			Tests = {
				"Piercing, homing tears split into more tears on hit"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SEWING_MANUAL_3_USE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			아이템 획득 시 눈물효과를 바꾸는 아이템인 경우 해당 아이템 제거 후 그 효과를 가진 패밀리어로 바꿉니다.
			!!! 3회 남음
		]],
		Tests = {
			"Turns the next 3 tear effect items collected into familiars that shoot that item's effect",
		},
		Golden = {
			TargetStrings = {
				"into familiars",
				"into 2 familiars",
				"into 3 familiars",
				"into 4 familiars",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SEWING_MANUAL_2_USE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			아이템 획득 시 눈물효과를 바꾸는 아이템인 경우 해당 아이템 제거 후 그 효과를 가진 패밀리어로 바꿉니다.
			!!! 2회 남음
		]],
		Tests = {
			"Turns the next 2 tear effect items collected into familiars that shoot that item's effect",
		},
		Golden = {
			TargetStrings = {
				"into familiars",
				"into 2 familiars",
				"into 3 familiars",
				"into 4 familiars",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SEWING_MANUAL_1_USE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			아이템 획득 시 눈물효과를 바꾸는 아이템인 경우 해당 아이템 제거 후 그 효과를 가진 패밀리어로 바꿉니다.
			!!! 1회 남음
		]],
		Tests = {
			"Turns the next tear effect item collected into a familiar that shoots that item's effect",
		},
		Golden = {
			TargetStrings = {
				"into familiars",
				"into 2 familiars",
				"into 3 familiars",
				"into 4 familiars",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SANGUINE_SALIVATION] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{BossRoom}} 보스의 체력이 30% 이하인 경우 30% 추가 피해를 받습니다.
			{{Heart}} {{BossRoom}} 보스방 클리어 시 체력을 1칸 회복합니다.
		]],
		Tests = {
			"Bosses below 30% health take 30% extra damage",
			"{{Heart}} On clearing a boss room, heals 1 heart",
		},
		Golden = {
			TargetStrings = {
				"heals 1 heart",
				"heals 2 hearts",
				"heals 3 hearts",
				"heals 4 hearts",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.LUNATIC_EYE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{ffBerserk}} 7%의 확률로 적을 폭주시키는 공격이 나갑니다.
			{{LuckSmall}} 행운 16+일 때 20%
		]],
		Tests = {
			"7% chance to shoot tears that inflict enemies with Berserk",
			"{{Luck}} 20% chance at 16 luck",
		},
		AppendEntries = {
			"FF_APPEND_BERSERK",
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.BERSERK },
		Golden = {
			TargetAdditives = {
				AdditiveValues = {3, 6, 9, 12},
				TargetNumbers = {7},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.CHARACTER_SELECT] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			방 클리어 보상이 5%의 확률로 영혼석으로 바뀝니다.
			영혼석 사용 후 영혼석의 캐릭터를 지정합니다.
			!!! 지정 시 장신구 소멸
			사망 시 전 방에서 체력 1칸의 지정된 캐릭터로 부활합니다.
		]],
		Tests = {
			"5% chance for the room clear reward to be a soulstone",
			"Consumed upon using a soulstone, granting Isaac a revive as the corresponding character"
		},
		Golden = {
			Tests = {
				"Isaac revives with full health on death"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SHADOW_MANTLE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Collectible313}} 피격을 6회 막아줍니다.
			!!! 소진 시 장신구 소멸
		]],
		Tests = {
			"{{Collectible313}} Negates 6 hits of damage before breaking",
		},
		Golden = {
			TargetMultipliers = {
				6
			},
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.DADS_USB] = { -- TODO
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			!!! 방 입장 시 25%의 확률로 아래 중 랜덤 기계장치 아이템 효과를 얻습니다:
		]],
		Tests = {
			"25% chance for a random Technlogy item effect each room",
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {25, 75, 75, 75},
				TargetNumbers = {25},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.GOOGLY_EYES] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			공격하지 않는 패밀리어가 공격력 3.5의 눈물을 발사합니다.
		]],
		Tests = {
			"Grants most non-shooting familiars googly eyes which let them fire tears",
			"The tears deal 3.5 damage"
		},
		Golden = {
			TargetMultipliers = {
				"3.5"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.AMMO_CLIP] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			17%의 확률로 총 탄환을 발사합니다.
			{{DamageSmall}} 행운 20+일 때 100%
		]],
		Tests = {
			"17% chance to fire an Ammo Heart bullet",
			"Ammo Hearts correspond to the type of health Isaac has",
			"{{Luck}} 100% chance to fire at 20 luck"
		},
		Golden = {
			TargetMultipliers = {
				"17"
			}
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.JUSTICE_AXE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			공격 시 망치를 같이 던집니다.
			망치 착지 시 명중한 적에게 35, 주변의 적에게 15, 접촉한 적에게 2의 피해를 줍니다.
			공격 후 9초 후 다시 던질 수 있습니다.
		]],
		Tests = {
			"When Isaac shoots, he throws a curved hammer projectile that deals 15 in a radius and 35 damage on a direct hit",
			"When the hammer grazes enemies, it does 2 damage",
			"Can be fired every 9 seconds"
		},
		Golden = {
			TargetStrings = {
				"9 seconds",
				"4.5 seconds",
				"3 seconds",
				"2.25 seconds",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.DADS_HOME] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			방 입장 시 20%의 확률로 그 방의 적 및 픽업을 지우며;
			>>> 다음 방 입장 시 지워진 것들을 같이 소환합니다.
		]],
		Tests = {
			"20% chance to clear all enemies and pickups from a room, causing them to spawn in the next room",
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {5, 13, 30, 30},
				TargetNumbers = {20},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.STEVENS_BOX] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{ffStevenHeart}} 방 클리어 보상이 10%의 확률로 스티븐하트로 바뀝니다.
			{{ffStevenHeart}} 하트 픽업이 낮은 확률로 스티븐하트로 바뀝니다.
			{{ffStevenHeart}} 스티븐하트의 피해량 x2
		]],
		Tests = {
			"{{Damage}} Steven heart bullets do 2x as much damage",
			"{{ffStevenHeart}} 10% chance for the room clear award to be a Steven Heart",
			"Hearts have a rare chance to be replaced by Steven Hearts",
			"Steven hearts go over other hearts and shoot at enemies from the HUD",
		},
		AppendEntries = {
			"FF_APPEND_STEVEN_HEART",
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {1, 2, 3, 4},
				TargetNumbers = {2, 10},
			},
			TargetMultipliers = {
				"10",
			}
		}
	},
	--#endregion
	--#region BONUS PENNIES
	[TRINKET..FiendFolio.ITEM.TRINKET.BENT_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			동전 획득 시 50%의 확률로 가치가 2배 혹은 0배로 바뀝니다.
		]],
		Tests = {
			"Picking up a coin has a 50% chance to either double its value or grant zero cents"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {25, 50, 50, 50},
				TargetNumbers = {50},
			},
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.TROLL_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			동전 획득 시 50%의 확률로 적 주변에 트롤폭탄을 소환합니다.
		]],
		Tests = {
			"Picking up a coin has a 50% chance to spawn a troll bomb nearby enemies"
		},
		Golden = {
			TargetStrings = {
				"a troll bomb",
				"2 troll bombs",
				"3 troll bombs",
				"4 troll bombs",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.AIRBAG_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			동전 획득 시 캐릭터를 밀쳐냅니다.
		]],
		Tests = {
			"Picking up a coin knocks Isaac backwards"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.MICRO_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			동전 획득 시 15%의 확률로 캐릭터의 크기가 작아집니다.
		]],
		Tests = {
			"Picking up a coin has a 15% chance to decrease Isaac's size"
		},
		Golden = {
			TargetMultipliers = {
				"15"
			},
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.MAP_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Room}} 동전 획득 시 33%의 확률로 그 스테이지의 랜덤 방의 위치를 표시합니다.
			동전 가치가 높을수록 확률 증가
		]],
		Tests = {
			"Picking up a coin has a 33% chance to reveal a random room on the map",
			"Higher value coins will reveal more rooms"
		},
		Golden = {
			TargetStrings = {
				"a random room",
				"2 random rooms",
				"3 random rooms",
				"4 random rooms",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.PRETTY_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			동전 획득 시 33%의 확률로 적을 추적하는 파리 패밀리어가 생깁니다.
		]],
		Tests = {
			"Picking up a coin has a 33% chance to spawn a Fairy Fly"
		},
		Golden = {
			TargetMultipliers = {
				"33"
			},
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.FACEBOOK_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Collectible123}} 동전 획득 시 15%의 확률로 그 스테이지에서 랜덤 패밀리어를 소환합니다.
		]],
		Tests = {
			"Picking up a coin has a 15% chance to grant a random familiar for the floor"
		},
		Golden = {
			TargetMultipliers = {
				"15"
			},
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.CHARITABLE_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{DonationMachine}} 동전 획득 시 50%의 확률로 기부기계 카운트를 증가시킵니다.
		]],
		Tests = {
			"Picking up a coin has a 50% chance to add its value to the donation machine"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {25, 50, 50, 50},
				TargetNumbers = {50},
			},
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.DEVIOUS_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			동전 획득 시 50%의 확률로 랜덤 저주픽업을 드랍합니다.
		]],
		Tests = {
			"Picking up a coin has a 50% chance to spawn an Immoral Heart, a Spicy Key, a Copper bomb, or a Cursed Penny"
		},
		AppendEntries = {
			"FF_APPEND_IMMORAL_HEART",
			"FF_APPEND_CURSED_PENNY",
			"FF_APPEND_COPPER_BOMB",
			"FF_APPEND_SPICY_KEY",
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {25, 50, 50, 50},
				TargetNumbers = {50},
			},
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SWITCH_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Collectible]] .. FiendFolio.ITEM.COLLECTIBLE.AVGM .. [[}} 동전 획득 시 딸깍이를 1번 사용합니다.
		]],
		Tests = {
			"{{Collectible" .. FiendFolio.ITEM.COLLECTIBLE.AVGM .. "}} Picking up a coin uses A.V.G.M"
		},
		Golden = {
			TargetStrings = {
				"A.V.G.M",
				"A.V.G.M two times",
				"A.V.G.M three times",
				"A.V.G.M four times",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.POOP_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Collectible576}} 동전 획득 시 50%의 확률로 아군 Dip을 소환합니다.
		]],
		Tests = {
			"Picking up a coin has a 50% chance to spawn a random Dip Familiar"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {25, 50, 50, 50},
				TargetNumbers = {50},
			},
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SLIPPERY_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			동전 획득 시 소지 중인 {{Bomb}} 혹은 {{Key}} 중 하나를 버립니다.
		]],
		Tests = {
			"Picking up a coin causes Isaac to drop a key or bomb if owned"
		},
		Golden = {
			TargetStrings = {
				"drop a key or bomb",
				"drop a key or bomb twice",
				"drop a key or bomb three times",
				"drop a key or bomb four times",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.CANADIAN_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			동전 획득 시 50%의 확률로 가치가 일정 배율로 상승합니다.
		]],
		Tests = {
			"Picking up a coin will increase its value by the Canadian exchange rate",
		},
		Conditional = function (descObj)
			local split = mod:SplitString(descObj.Description, "#")
			local lastValidLine = #split + 1

			for i, line in ipairs(split) do
				for _, blacklistedPrefix in ipairs(mod.EIDBlacklistedPrefix) do
					if line:sub(1, blacklistedPrefix:len()) == blacklistedPrefix then
						lastValidLine = i
						break
					end
				end
			end

			table.insert(split, lastValidLine, "Current rate is x" .. FiendFolio.CanadianExchangeRate)
			descObj.Description = table.concat(split, "#")
		end
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.ALPHA_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Collectible]] .. FiendFolio.ITEM.COLLECTIBLE.ALPHA_COIN .. [[}} 동전 획득 시 20%의 확률로 Alpha Coin을 사용합니다.
		]],
		Tests = {
			"{{Collectible" .. FiendFolio.ITEM.COLLECTIBLE.ALPHA_COIN .. "}} Picking up a coin has a 20% chance to use Alpha Coin"
		},
		Golden = {
			TargetMultipliers = {
				"20"
			},
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.STONE_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			동전 획득 시 그 방의 랜덤 장애물을 1개 파괴합니다.
			동전 가치가 높을수록 파괴 개수 증가
		]],
		Tests = {
			"Picking up a coin destroys a random obstacle in the room",
			"Higher value coins will break more obstacles"
		},
		Golden = {
			TargetStrings = {
				"a random obstacle",
				"2 random obstacles",
				"3 random obstacles",
				"4 random obstacles",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.RED_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{RedRoom}} 동전 획득 시 20%의 확률로 근처에 빨간 문을 엽니다.
		]],
		Tests = {
			"Picking up a coin has a 20% chance to open a random adjacent red room"
		},
		Golden = {
			TargetStrings = {
				"a random adjacent red room",
				"2 random adjacent red rooms",
				"3 random adjacent red rooms",
				"4 random adjacent red rooms",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.PUCK_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			동전 픽업 접촉 시 미끄러집니다.
			미끄러지는 동전은 적에게 공격력 x1의 피해를 줍니다.
		]],
		Tests = {
			"Touching coins in active rooms will slide them around and cause them to do Isaac's damage to enemies"
		},
		Golden = {
			TargetStrings = {
			"to do Isaac's damage",
			"to do double Isaac's damage",
			"to do triple Isaac's damage",
			"to do quadruple Isaac's damage",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.PRISM_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			동전 획득 시 50%의 확률로 랜덤 능력치를 10초동안 증가시켜주는 프리즘 조각을 드랍합니다.
		]],
		Tests = {
			"Picking up a coin has a 50% chance to spawn a Prism Shard that temporarily boosts a stat"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {25, 50, 50, 50},
				TargetNumbers = {50},
			},
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.BERRY_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			동전 획득 시 50%의 확률로 다음 공격을 구토제 공격으로 바꾸는 열매를 드랍합니다.
		]],
		Tests = {
			"Picking up a coin has a 50% chance to spawn a Berry pickup that grants a single use Ipecac shot"
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.CALCIUM_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			동전 획득 시 그 자리에 적의 탄환을 막아주는 일회용 뼛조각과 40%의 확률로 뼛조각 배리어를 소환합니다.
		]],
		Tests = {
			"Picking up a coin spawns bone shards and has a 40% chance to grant a bone orbital"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {20, 40, 80, 100},
				TargetNumbers = {40},
			},
			Tests = {
				"Spawns more bone shards"
			}
		},
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.DOG_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			동전 획득 시 15%의 확률로 다음 색돌을 밝힙니다.
		]],
		Tests = {
			"Picking up a coin has a 15% chance to reveal the next tinted rock encountered",
			"There is another 50% chance to spawn a cosmetic dog"
		},
		Golden = {
			TargetStrings = {
			"the next tinted rock",
			"the next 2 tinted rocks",
			"the next 3 tinted rocks",
			"the next 4 tinted rocks",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.DADS_LOST_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Collectible455}} 동전 획득 시 그 방에서:
			>>> {{RangeSmall}} 사거리 +2.5
			>>> {{LuckSmall}} 행운 +1
		]],
		Tests = {
			"{{Collectible" .. CollectibleType.COLLECTIBLE_DADS_LOST_COIN .. "}} Picking up a coin grants +1 Luck and +2.5 Range for the room"
		},
		Golden = {
			TargetMultipliers = {
				"1",
				"2.5"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.LOADED_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Collectible]] .. FiendFolio.ITEM.COLLECTIBLE.IMP_SODA .. [[}} 동전 획득 시 다음 공격이 적에게 3배의 피해를 줍니다.
		]],
		Tests = {
			"{{Collectible" .. FiendFolio.ITEM.COLLECTIBLE.IMP_SODA .. "}} Picking up a coin makes the next tear fired deal x3 damage"
		},
		Golden = {
			TargetStrings = {
				"next tear",
				"next two tears",
				"next three tears",
				"next four tears",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SUNDIAL_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Timer}} 동전 획득 시 타이머를 2초 차감합니다.
			동전 가치가 높을수록 차감되는 시간 증가
		]],
		Tests = {
			"Picking up a coin decreases the score timer by 2 seconds",
			"The amount of seconds subtracted scales with the value of the coin"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {1, 2, 3, 4},
				TargetNumbers = {2},
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.SUICIDAL_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			!!! {{GigaBomb}} 동전 획득 시 사망합니다.
		]],
		Tests = {
			"Picking up a coin explodes Isaac"
		},
		Golden = {
			Tests = {
				"Picking up a coin removes Isaac"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.TRINKET.BRAZILIAN_PENNY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			동전 획득 시 75%의 확률로 일정 시간 지속되는 축구공 3개를 소환합니다.
		]],
		Tests = {
			"Picking up a coin explodes Isaac"
		},
		Golden = {
			Tests = {
				"Picking up a coin removes Isaac"
			}
		}
	},
	--#endregion
	--#region CURSED TRINKETS
	[TRINKET..FiendFolio.ITEM.TRINKET.WIFE_HAT] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{ffCursesBlackLantern}} 획득 시 및 스테이지 진입 시 Veil 저주에 걸립니다.
		]],
		Tests = {
			"\2 Grants the Curse of the Veil"
		}
	},
	--#endregion
	--#region REHEATED ROCKS
	[TRINKET..FiendFolio.ITEM.ROCK.DIRT_CLUMP] = {
		_descType = "trinket",
		Name = "흙덩이",
		QuoteDesc = "공짜 채굴",
		Description = [[
			{{ffGrind}} {{ColorYellow}}채굴:{{CR}} 동전을 소모하지 않음
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{ffGrind}} {{ColorTransform}}Grind effect",
			"Can be grinded in the Mining Machine for free"
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ROLLING_ROCK] = {
		_descType = "trinket",
		Name = "굴러가는 돌멩이",
		QuoteDesc = "이동속도 증가 + 그 페이스를 유지해줘",
		Description = [[
			{{SpeedSmall}} 방 클리어 시 이동속도가 +0.05씩 최대 3번 증가합니다.
			패널티 피격 시 이동속도 증가치가 초기화됩니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +0.05 Speed after clearing a room without taking damage",
			"Taking damage resets this bonus"
		},
		Golden = {
			TargetMultipliers = {
				0.05
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.POCKET_SAND] = {
		_descType = "trinket",
		Name = "가루 한 줌",
		QuoteDesc = "아무것도 없어",
		Description = [[
			무효과
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Does nothing"
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ROUGH_ROCK] = {
		_descType = "trinket",
		Name = "거친 돌",
		QuoteDesc = "갈아버려!",
		Description = [[
			{{ffGrind}} {{ColorYellow}}채굴:{{CR}} 등장 확률이 낮은 석기류를 채굴합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{ffGrind}} {{ColorTransform}}Grind effect",
			"Grinding this rock in the Mining Machine gives a rarer rock trinket"
		},
		Golden = {
			Description = {
				"Given rock trinket is Golden"
			},
			GoldOnly = true
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.BLOODY_ROCK] = {
		_descType = "trinket",
		Name = "피묻은 돌",
		QuoteDesc = "아픈 눈물",
		Description = [[
			눈물을 4번 발사할 때마다 공격력 x2의 눈물을 발사합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Every 4th tear fired becomes a double damage blood tear"
		},
		Golden = {
			TargetStrings = {
				"4th", -- String to replace
				-- Below are the strings for each multiplier
				"2nd",
				"2nd",
				"1st",
				"1st"
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SPIKED_ROCK] = {
		_descType = "trinket",
		Name = "가시돌",
		QuoteDesc = "고통은 한순간 + 가시 면역",
		Description = [[
			최초 획득 시 캐릭터가 체력 반칸의 피해를 받습니다. (사망하지 않음)
			가시나 가시상자에 피해를 받지 않습니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Deals damage to Isaac upon first pickup",
			"{{Warning}} This damage will not kill Isaac",
			"Blocks damage from spikes and spiked chests"
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SLIPPY_ROCK] = {
		_descType = "trinket",
		Name = "미끄러운 돌",
		QuoteDesc = "이동속도 증가 + 마찰력 감소",
		Description = [[
			↑ {{SpeedSmall}}이동속도 +0.15
			캐릭터의 이동이 더 미끄러집니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +0.15 Speed",
			"Friction down"
		},
		Golden = {
			TargetMultipliers = {
				0.15
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ARCANE_ROCK] = {
		_descType = "trinket",
		Name = "마법의 돌",
		QuoteDesc = "확률 유도 공격 + 유도 공격력 증가",
		Description = [[
			5%의 확률로 공격력 +2의 유도 눈물을 발사합니다.
			{{LuckSmall}} 행운 8+일 때 20%
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"5% chance for tears to turn into high damaging homing shots",
			"{{Luck}} 20% chance at 8 luck"
		},
		Golden = {
			TargetMultipliers = {
				20
			},
			Description = {
				"Tears deal even more damage"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.MINERAL_ROCK] = {
		_descType = "trinket",
		Name = "광물 암석",
		QuoteDesc = "돌에 비비면 모든 능력치 증가",
		Description = [[
			장애물에 접촉하는 동안:
			>>> {{SpeedSmall}} 이동속도 +0.2
			>>> {{TearsSmall}} 연사 +0.72
			>>> {{DamageSmall}} 공격력 +1.5
			>>> {{RangeSmall}} 사거리 +1
			>>> {{ShotspeedSmall}} 탄속 +0.2
			>>> {{LuckSmall}} 행운 +4
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"When pressing against a rock:",
			"↑ +0.2 Speed",
			"↑ +1.5 Damage",
			"↑ +0.72 Tears",
			"↑ +1 Range",
			"↑ +0.2 Shot speed",
			"↑ +4 Luck"
		},
		Golden = {
			TargetMultipliers = {
				0.2,
				1.5,
				0.72,
				1,
				0.2,
				4,
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.THORNY_ROCK] = {
		_descType = "trinket",
		Name = "가시넝쿨에 묶인 돌",
		QuoteDesc = "맞으면 지진파",
		Description = [[
			피격 시 캐릭터 주위에 충격파를 일으킵니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Spawns a radial shockwave when Isaac is damaged"
		},
		Golden = {
			Description = {
				"Shockwave radius is increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.TIME_LOST_DIAMOND] = {
		_descType = "trinket",
		Name = "시간이 멈춘 돌",
		QuoteDesc = "맞으면 시간 되돌리기",
		Description = [[
			{{Collectible422}} 피격 시 방당 1회 한정으로 이전 방의 시점으로 시간을 되돌립니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Collectible422}} Brings Isaac back to the previous room and reverses all actions done in the room when they are hit",
			"If hit in the same room again, the rock trinket will not activate"
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.OBSIDIAN_GRINDSTONE] = {
		_descType = "trinket",
		Name = "흑요석 숫돌",
		QuoteDesc = "공격력, 연사 증가 + 석기 교체",
		Description = [[
			↑ {{TearsSmall}}연사 +0.36
			↑ {{DamageSmall}}공격력 +2.5
			다른 석기류를 같이 들고 있을 경우 추가 증가
			눈물을 10번 발사할 때마다 소지 중인 석기류를 바꿉니다.
			{{Blank}} (15%의 확률로 {{Trinket]]..FiendFolio.ITEM.ROCK.POCKET_SAND..[[}}Pocket Sand)
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +2.5 Damage",
			"↑ +0.36 Tears",
			"Stats double when holding another rock trinket",
			"Every 10 tears shot will reroll the other held rock trinket, if applicable",
			"{{Trinket" ..
				FiendFolio.ITEM.ROCK.POCKET_SAND ..
					"}} 15% chance for the other held trinket to turn into Pocket Sand"
		},
		Golden = {
			TargetMultipliers = {
				2.5,
				0.36,
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GODS_MARBLE] = {
		_descType = "trinket",
		Name = "신의 구슬",
		QuoteDesc = "성지",
		Description = [[
			3%의 확률로 적에게 명중 시 9개의 빛줄기가 떨어지는 공격이 나갑니다.
			{{LuckSmall}} 행운 37+일 때 40%
			빛줄기 피해량 : 틱 당 2.5
			!!! 캐릭터도 빛줄기에 피해를 받습니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"3% chance to shoot a yellow spectral tear that leaves a holy aura on the ground",
			"When an enemy touches the aura, 9 light beams damage them",
			"{{Damage}} The beams deals 2.5 damage per tick",
			"{{Luck}} 40% chance at 37 luck"
		},
		Golden = {
			TargetMultipliers = {
				40,
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.TWENTY_SIDED_EMERALD] = {
		_descType = "trinket",
		Name = "12각 에메랄드",
		QuoteDesc = "근접 바꾸기",
		Description = [[
			{{Timer}} 픽업 주위에 3초동안 가까이 있으면 다른 픽업으로 바꿉니다. (픽업 당 최대 3회)
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Timer}} Standing still near a pickup rerolls it every 3 seconds",
			"Any individual pickup can only be rerolled up to 3 times"
		},
		Golden = {
			TargetStrings = {
				"3 times", -- String to replace
				-- Below are the strings for each multiplier
				"4 times",
				"5 times",
				"6 times",
				"7 times",
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.TECHNOLOGICAL_RUBY_2] = {
		_descType = "trinket",
		Name = "기계 루비 2.0",
		QuoteDesc = "강력한 보안에는 대가가 필요하다",
		Description = [[
			소지 시 캐릭터 주변에 2개의 원형 레이저를 발산합니다.
			내부 레이저는 공격력 x0.25의 피해를, 외부 레이저는 공격력 x0.1의 피해를 줍니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Grants 2 laser rings at Isaac's position",
			"The inner ring deals 0.1x Isaac's damage",
			"The outer ring deals 0.25x Isaac's damage"
		},
		Golden = {
			-- Using TargetStrings here because TargetNumbers just can't work with how EID sets up Golden trinkets.
			TargetStrings = {
				"2", -- String to replace
				-- Below are the strings for each multiplier
				"3", -- 2x
				"3", -- 3x
				"3", -- 4x
				"3", -- 5x (max, only visible with Mom's Box held + Golden trinket + Overclock held)
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.LEAKY_ROCK] = {
		_descType = "trinket",
		Name = "눈물나는 돌",
		QuoteDesc = "흘리고 있어",
		Description = [[
			캐릭터가 움직일 때마다 캐릭터의 공격력의 눈물을 제자리에 흘립니다.
			연사가 빠를수록 흘리는 주기가 짧아집니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Isaac leaves a trail of stationary tears while they move"
		},
		Golden = {
			Description = {
				"Stationary tears appear more often"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.TWIN_TUFFS] = {
		_descType = "trinket",
		Name = "터프한 쌍둥이",
		QuoteDesc = "쌍둥이 보상",
		Description = [[
			25%의 확률로 픽업이 1+1로 드랍됩니다.
			{{LuckSmall}} 행운 30+일 때 100%
			15%의 확률로 방 클리어 보상이 하나 더 등장합니다.
			{{LuckSmall}} 행운 57+일 때 100%
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"25% chance to turn pickups into their doubled equivalent",
			"{{Luck}} 100% chance at 30 luck",
			"15% chance to double room rewards",
			"{{Luck}} 100% chance at 57 luck"
		},
		Golden = {
			TargetMultipliers = {25}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.WETSTONE] = {
		_descType = "trinket",
		Name = "습한 돌",
		QuoteDesc = "방울방울",
		Description = [[
			클리어하지 않은 방 입장 시 방울을 7개 소환합니다.
			피격 시 방울을 10개 소환합니다.
			이 석기로 소환된 방울은 캐릭터에게 피해를 주지 않으며 적의 탄환을 막아줍니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Spawns 7 bubbles when entering a room",
			"Taking damage spawns 10 more bubbles"
		},
		Golden = {
			TargetAdditives = {
				TargetNumbers = {7, 10},
				AdditiveValues = {1, 2, 3, 4},
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.STROMATOLITE] = {
		_descType = "trinket",
		Name = "스트로마톨라이트",
		QuoteDesc = "돌의 활력",
		Description = [[
			{{HalfHeart}} 장애물 파괴 시 2.5%의 확률로 빨간하트 반칸을 추가로 드랍합니다.
			{{HalfSoulHeart}} 색돌 파괴 시 25%의 확률로 소울하트 반칸를 추가로 드랍합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{HalfHeart}} Rocks have a 2.5% chance to drop a half heart when broken",
			"{{HalfSoulHeart}} Tinted rocks have a 25% chance to drop an additional half soul heart"
		},
		Golden = {
			TargetMultipliers = {
				2.5,
				25
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.RIBBED_ROCK] = {
		_descType = "trinket",
		Name = "늑골석",
		QuoteDesc = "그녀에게 기쁨을",
		Description = [[
			↑ {{EmptyBoneHeart}}뼈하트 +1
			{{BoneHeart}} 최대 체력 증가 아이템 획득 시 최대 체력 대신 뼈하트가 증가합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{EmptyBoneHeart}} Grants a bone heart on first pickup",
			"{{BoneHeart}} Health upgrades grant bone hearts instead of heart containers"
		},
		Golden = {
			Description = {
				"Health upgrades grant an additional bone heart"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.FIENDISH_AMETHYST] = {
		_descType = "trinket",
		Name = "악한 아메시스트",
		QuoteDesc = "핀드 투성이!",
		Description = [[
			클리어하지 않은 방 입장 시 Fiend의 부하를 4마리 소환합니다. (Amethyst 타입)
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Spawns 4 Amethyst Fiend Minions when entering an uncleared room"
		},
		Golden = {
			TargetAdditives = {
				TargetNumbers = {4},
				AdditiveValues = {2, 4, 6, 8},
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.STURDY_ROCK] = {
		_descType = "trinket",
		Name = "견고한 돌",
		QuoteDesc = "체력적인 시작",
		Description = [[
			{{SoulHeart}} 스테이지 입장 시 소울하트 +1
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{SoulHeart}} +1 Soul Heart when entering a new floor"
		},
		Golden = {
			TargetStrings = {
				"+1 Soul Heart",
				"+2 Soul Hearts",
				"+2 Soul Hearts",
				"+2 Soul Hearts",
				"+2 Soul Hearts",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.BRICK_ROCK] = {
		_descType = "trinket",
		Name = "벽돌",
		QuoteDesc = "던져!",
		Description = [[
			공격키를 누르면 장신구를 소모하여 공격력 15의 피해를 주는 벽돌을 발사합니다.
			발사한 벽돌은 다시 주울 수 있습니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Lets Isaac fire a 15 damage brick tear when picked up",
			"Isaac can pick it up after firing and throw it again"
		},
		Golden = {
			TargetMultipliers = {
				"15"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SAPPHIC_SAPPHIRE] = {
		_descType = "trinket",
		Name = "사픽 사파이어",
		QuoteDesc = "푸른색을 못쓰게 하는 돌",
		Description = [[
			{{Charm}} 모든 암컷의 적을 매혹시킵니다.
			{{Freezing}} 8%의 확률로 적 처치시 얼어붙는 공격이 나갑니다.
			{{LuckSmall}} 행운 8+일 때 33%
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Charm}} Charms female enemies",
			"{{Freezing}} 8% chance to fire slowing and freezing tears",
			"{{Luck}} 33% chance at 8 luck"
		},
		Golden = {
			TargetMultipliers = {8}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.BLOOD_DIAMOND] = {
		_descType = "trinket",
		Name = "핏빛 다이아몬드",
		QuoteDesc = "출혈 공격",
		Description = [[
			피격 시 캐릭터의 위치에 적에게 피해를 주는 빨간 장판을 생성합니다.
			{{BleedingOut}} 10%의 확률로 적을 출혈시키는 공격이 나갑니다.
			{{LuckSmall}} 행운 8+일 때 40%
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Spawns blood creep when Isaac takes damage",
			"{{BleedingOut}} 10% chance to fire tears that inflict bleed",
			"{{Luck}} 40% chance at 8 luck",
		},
		Golden = {
			TargetStrings = {
				"10",
				"20",
				"30",
				"40",
				"50"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SCENTED_ROCK] = {
		_descType = "trinket",
		Name = "향기로운 돌",
		QuoteDesc = "매혹 오라",
		Description = [[
			{{Charm}} 캐릭터와 가까이 있는 적을 매혹시킵니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Charm}} Charms enemies in a short radius around Isaac"
		},
		Golden = {
			Description = {
				"Charm radius and duration increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ARCADE_ROCK] = {
		_descType = "trinket",
		Name = "오락석",
		QuoteDesc = "버그 걸린 오락기계",
		Description = [[
			25%의 확률로 동전 슬롯머신 사용 시 동전을 소모하지 않습니다.
			{{LuckSmall}} 행운 17+일 때 66%
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Slotmachine}} 25% chance for slot machines to be free",
			"{{Luck}} 66% chance at 17 luck"
		},
		Golden = {
			TargetStrings = {
				"25",
				"50",
				"75",
				"100",
				"100"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.TINTED_HEART] = {
		_descType = "trinket",
		Name = "하트 모양 색돌",
		QuoteDesc = "영혼이 담겨있어",
		Description = [[
			{{Heart}} 피격 시 20%의 확률로 빨간하트를 하나 드랍합니다.
			폭발 피해를 받으면 각각 35%의 확률로 드랍: 
			>>> {{SoulHeart}} 소울하트 
			>>> {{Key}} 열쇠
			>>> {{Bomb}}폭탄
			>>> {{Chest}}상자
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Heart}} 20% chance to drop a red heart when taking damage",
			"When taking explosive damage, 35% chance to drop a:",
			"{{SoulHeart}} Soul heart",
			"{{Bomb}} Bomb",
			"{{Key}} Key",
			"{{Chest}} Chest"
		},
		Golden = {
			TargetStrings = {
				"20",
				"40",
				"60",
				"80",
				"100"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ROSE_QUARTZ] = {
		_descType = "trinket",
		Name = "장미색 쿼츠",
		QuoteDesc = "탄환 방어막",
		Description = [[
			피격 시 6초간 {{ColorOrange}}적의 탄환을 막아주는{{CR}} 보호막을 생성합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Taking damage grants a temporary shield for 6 seconds that can block one projectile",
			"Taking contact damage refreshes the duration"
		},
		Golden = {
			TargetMultipliers = {
				"6"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.HAILSTONE] = {
		_descType = "trinket",
		Name = "우박",
		QuoteDesc = "냉기 오라",
		Description = [[
			{{Slow}} 캐릭터와 가까이 있는 적을 둔화 시킵니다.
			{{Freezing}} 둔화된 적 처치 시 얼어붙습니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Slow}} Enemies near Isaac are slowed",
			"{{Freezing}} Enemies within a short radius of Isaac freeze when killed"
		},
		Golden = {
			Description = {
				"Slowness radius and strength increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.RAMBLIN_OPAL] = {
		_descType = "trinket",
		Name = "걸어가는 오팔",
		QuoteDesc = "보석 포자",
		Description = [[
			{{Charm}} 적이 있는 방에서 주기적으로 아군 Shiitake Spore를 최대 3마리까지 소환합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Charm}} Spawns friendly Shiitake Spores in uncleared rooms, with a maximum of 3 out at a time"
		},
		Golden = {
			TargetAdditives = {
				TargetNumbers = {3},
				AdditiveValues = {1,2,3,4},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SAND_DOLLAR] = {
		_descType = "trinket",
		Name = "모래 지폐",
		QuoteDesc = "상점에 팔 수 있어",
		Description = [[
			{{Shop}} 상점에서 장신구를 버리면 10~20{{Coin}} 상당의 동전으로 바꿉니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Coin}} Dropping the trinket in a {{Shop}} Shop exchanges it for 10-20 coins"
		},
		Golden = {
			Description = {
				"Drops extra coins"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.HENGE_ROCK] = {
		_descType = "trinket",
		Name = "스톤헨지",
		QuoteDesc = "석기 강화",
		Description = [[
			소지한 석기류의 효과를 30% 강화시킵니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Trinket}} Increases the power of held Rock Trinkets by 30%"
		},
		Golden = {
			TargetStrings = {
				"30",
				"60",
				"90",
				"120",
				"150"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SALT_LAMP] = {
		_descType = "trinket",
		Name = "소금 램프",
		QuoteDesc = "충전식 오라",
		Description = [[
			2분간 적과 탄환을 강하게 밀쳐냅니다.
			{{Battery}} 2분이 지나면 전구가 꺼지며 배터리 픽업을 주울 시 배터리 크기에 비례한 만큼 재사용할 수 있습니다.
			{{Battery}} 스테이지 진입 시에도 재사용할 수 있습니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Repels nearby enemies and projectiles, but slowly drains in power over time",
			"{{Battery}} Can be recharged with batteries",
			"Recharges on new floors"
		},
		Golden = {
			Description = {
				"Repelling aura duration increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.MOLTEN_SLAG] = {
		_descType = "trinket",
		Name = "녹아내리는 화산암재",
		QuoteDesc = "흡수성 채굴",
		Description = [[
			{{Burning}} 프레임 당 2%의 확률로 캐릭터와 가까이 있는 적에게 화상을 줍니다.
			{{ffGrind}} {{ColorYellow}}채굴:{{CR}} 소지 중인 다른 석기류를 흡수합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Burning}} 2% chance to burn nearby enemies every frame",
			"{{ffGrind}} {{ColorTransform}}Grind effect",
			"When grinded in the Mining Machine, smelts other held trinket"
		},
		Golden = {
			Description = {
				"Increased burn chance, radius, damage, and duration"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.THUNDER_EGG] = {
		_descType = "trinket",
		Name = "계룡 알",
		QuoteDesc = "희귀한 걸 품은 것",
		Description = [[
			↓ {{SpeedSmall}}이동속도 -0.1
			방 클리어 시 6%의 확률로 희귀한 석기류로 바꿉니다.
			{{Blank}} (바뀌지 않으면 확률 증가, 최대 50%)
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↓ -0.1 Speed",
			"Each room has a 6% chance for the Thunder Egg to crack open into another a higher quality rock",
			"The chance increases each room, up to 50%",
		},
		Golden = {
			Description = {
				"Increased chance and quality"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.UNOBTAINIUM] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			!!! 획득 불가
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Completely unobtainable, don't even try!"
		},
		Golden = {
			Description = {
				"Even more unobtainable!"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SANDSTONE] = {
		_descType = "trinket",
		Name = "사암",
		QuoteDesc = "쉽게 부서지지...",
		Description = [[
			{{Confusion}} 20%의 확률로 캐릭터와 가까울수록 공격력이 4배 증가하며 멀어질수록 0배로 감소, 적에게 혼란을 거는 거대한 돌덩이를 발사합니다.
			{{LuckSmall}} 행운 27+일 때 100%
			!!! 폭발 피해를 받으면 {{Trinket]]..FiendFolio.ITEM.ROCK.POCKET_SAND..[[}}Pocket Sand로 바뀝니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Confusion}} 20% chance to fire a rock that inflicts confusion and does x4 damage, but shrinks over time",
			"{{Luck}} 100% chance at 27 luck",
			"{{Trinket" ..
				FiendFolio.ITEM.ROCK.POCKET_SAND .. "}} Turns into Pocket Sand when taking explosive damage"
		},
		Golden = {
			TargetStrings = {
				"20",
				"30",
				"40",
				"50",
				"60"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.FAKE_ROCK] = {
		_descType = "trinket",
		Name = "가짜 돌",
		QuoteDesc = "자물쇠에서 멀어지지 마",
		Description = [[
			{{Key}} 획득 시 열쇠를 하나 드랍합니다.
			{{Key}} 방 안에 잠긴 문이 있으면 장애물 파괴 시 방당 1회 한정으로 열쇠를 드랍합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Key}} Spawns a key on pickup",
			"If there is a locked door in the room, the first broken rock drops a key"
		},
		Golden = {
			TargetStrings = {
				"drops a key",
				"drops a keyring",
				"drops a keyring",
				"drops a keyring",
				"drops a keyring",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.CITRINE_PULP] = {
		_descType = "trinket",
		Name = "황수정 펄프",
		QuoteDesc = "짧은 사거리의 음료수",
		Description = [[
			공격 시 20%의 확률로 여러 개의 눈물을 흩뿌립니다.
			{{LuckSmall}} 행운 15+일 때 50%
			적과 가까이 있으면 적에게 피해를 주는 노란 장판을 깝니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"20% chance to fire a short ranged splash of tears",
			"{{Luck}} 50% chance at 15 luck",
			"When enemies are close, small chance to create a puddle of creep"
		},
		Golden = {
			Description = {
				"Increased chance and amount for splashes of tears"
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.BLOODSTONE] = {
		_descType = "trinket",
		Name = "혈석",
		QuoteDesc = "고통받을수록 강해지다",
		Description = [[
			{{DamageSmall}} 적 처치 시 증발성 공격력 +0.1
			{{DamageSmall}} 피격 시 증발성 공격력 +1
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +0.2 Damage for each enemy killed in the room",
			"↑ +1 Damage when taking damage",
			"Damage bonuses decay over time"
		},
		Golden = {
			TargetMultipliers = {0.2, 1}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.EMETIC_ANTIMONY] = {
		_descType = "trinket",
		Name = "메스꺼운 안티몬",
		QuoteDesc = "틈만 나면 구토",
		Description = [[
			{{Collectible149}} 15초마다 구토제 눈물을 발사합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Collectible149}} Isaac can fire an Ipecac shot every 15 seconds"
		},
		Golden = {
			TargetAdditives = {
				TargetNumbers = {15},
				AdditiveValues = {-2, -4, -6, -8},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.DOUBLE_RUBBLE] = {
		_descType = "trinket",
		Name = "더블 재갈",
		QuoteDesc = "채굴 2배",
		Description = [[
			{{ffGrind}} {{ColorYellow}}채굴:{{CR}} 등급이 낮은 석기류 2개를 채굴합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{ffGrind}} {{ColorTransform}}Grind effect",
			"Grinding this rock in the Mining Machine gives two common or rare rocks"
		},
		Golden = {
			Description = {
				"Rocks are golden"
			},
			GoldOnly = true,
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ROCK_FROM_AN_ABYSS] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{ffDoom}} 방 입장 시 20%의 확률로 적 3마리에게 둠을 겁니다.
			{{LuckSmall}} 행운 27+일 때 100%
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
			"FF_APPEND_DOOM",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"20% chance to apply Doom to 3 enemies at the start of the room",
			"{{Luck}} 100% chance at 27 luck",
		},
		StatusEffects = {mod.DescriptionStatuses.DOOM},
		Golden = {
			TargetStrings = {
				"20",
				"40",
				"60",
				"80",
				"100"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.HECTOR] = {
		_descType = "trinket",
		Name = "헥토르",
		QuoteDesc = "변화",
		Description = [[
			↓ {{SpeedSmall}}이동속도 -0.1
			↑ {{TearsSmall}}연사 +0.27
			↑ {{DamageSmall}}공격력 +1
			!!! 피격 시 강제로 내려놓습니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +1 Damage",
			"↑ +0.27 Tears",
			"↓ -0.1 Speed",
			"Forcibly dropped when taking damage"
		},
		Golden = {
			TargetMultipliers = {1, 0.27, 0.1}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.VESSEL_ROCK] = {
		_descType = "trinket",
		Name = "돌 그릇",
		QuoteDesc = "체력 증가",
		Description = [[
			소지 시 임시 체력의 역할을 합니다.
			{{DevilChanceSmall}} 악마방 확률에 영향 없음
			{{EmptyHeart}} 현재 비어 있음, {{ColorOrange}}피격 시 파괴{{CR}}
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{EmptyHeart}} Stores an extra heart",
			"{{DevilChance}} Does not count against Devil Deal chance",
			"Breaks when taking damage while empty"
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.HALF_VESSEL_ROCK] = {
		_descType = "trinket",
		Name = "돌 그릇",
		QuoteDesc = "체력 증가",
		Description = [[
			소지 시 임시 체력의 역할을 합니다.
			{{DevilChanceSmall}} 악마방 확률에 영향 없음
			{{HalfHeart}} 현재 반칸 채워짐
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{HalfHeart}} Stores an extra heart",
			"{{DevilChance}} Does not count against Devil Deal chance",
			"Breaks when taking damage while empty"
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.FULL_VESSEL_ROCK] = {
		_descType = "trinket",
		Name = "돌 그릇",
		QuoteDesc = "체력 증가",
		Description = [[
			소지 시 임시 체력의 역할을 합니다.
			{{DevilChanceSmall}} 악마방 확률에 영향 없음
			{{Heart}} 현재 한칸 채워짐
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Heart}} Stores an extra heart",
			"{{DevilChance}} Does not count against Devil Deal chance",
			"Breaks when taking damage while empty"
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.CONSTANT_ROCK_SHOOTER] = {
		_descType = "trinket",
		Name = "무한 돌멩이 발사기",
		QuoteDesc = "계속 발사해!",
		Description = [[
			↑ {{TearsSmall}}연사 +0.8
			캐릭터가 자동으로 공격합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +0.8 Tears",
			"Isaac never stops firing"
		},
		Golden = {
			Description = {
				"Tears increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ROBOT_ROCK] = {
		_descType = "trinket",
		Name = "로봇 돌덩이",
		QuoteDesc = "부와부와부와부와부와",
		Description = [[
			적에게 랜덤 상태이상을 거는 짧은 레이저 2개를 시계방향으로 발사합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Grants Isaac 2 short ranged spinning lasers that inflict random status effects"
		},
		Golden = {
			TargetAdditives = {
				TargetNumbers = {2},
				AdditiveValues = {0, 1, 2, 3},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ROCK_CANDY] = {
		_descType = "trinket",
		Name = "돌사탕",
		QuoteDesc = "달콤한 크리스탈",
		Description = [[
			{{Charm}} 15%의 확률로 적에게 매혹을 거는 공격력 x1.5의 공격을 발사합니다.
			{{LuckSmall}} 행운 27+일 때 100%
			{{HalfHeart}} 적 처치 시 15%의 확률로 2초 후 사라지는 설탕 크리스탈을 드랍합니다.
			{{LuckSmall}} 행운 25+일 때 40%
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"15% chance to fire a crystal tear that charms and deal x1.5 damage",
			"{{Luck}} 100% chance at 27 luck",
			"{{HalfHeart}} Enemies have a 15% chance to drop a pink half red heart on death that disappears after 2 seconds",
			"{{Luck}} 40% chance at 25 luck"
		},
		Golden = {
			Description = {
				"Increased chance for crystal tears and pink half red hearts",
				"Pink half red hearts last longer"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.KEYSTONE] = {
		_descType = "trinket",
		Name = "쐐기돌",
		QuoteDesc = "보너스 잠금해제",
		Description = [[
			{{Key}} 열쇠 소모 시 그 층에서:
			>>> {{SpeedSmall}} 이동속도 +0.1
			>>> {{TearsSmall}} 연사 +0.1
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Key}} Whenever Isaac uses a key:",
			"↑ +0.1 Speed",
			"↑ +0.1 Tears",
			"Stats disappears upon entering a new floor"
		},
		Golden = {
			TargetMultipliers = {0.1}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SILVER_TONGUE] = {
		_descType = "trinket",
		Name = "은색 혓바닥",
		QuoteDesc = "저렴한 채굴",
		Description = [[
			{{ffGrind}} 채굴기의 가격이 1{{Coin}} 감소합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{ffGrind}} The Mining Machine costs 1 less cent"
		},
		Golden = {
			TargetMultipliers = {1}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.MEAT_SLAB] = {
		_descType = "trinket",
		Name = "고기덩이",
		QuoteDesc = "땀나!",
		Description = [[
			주기적으로 캐릭터가 눈물을 하나씩 흩뿌립니다.
			눈물을 흩뿌리는 속도는 캐릭터의 전체 체력이 적을수록 빨라집니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Isaac constantly sweats out arced tears",
			"{{Heart}} Sweating rate increases based on how low Isaac's HP is"
		},
		Golden = {
			Description = {
				"Sweat damage is increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SHEEP_ROCK] = {
		_descType = "trinket",
		Name = "염소모양 돌",
		QuoteDesc = "느릿느릿한 눈물",
		Description = [[
			7%의 확률로 눈물이 체공하며 다른 눈물과 부딪힐 시 서로 튕겨나가며 움직입니다.
			{{LuckSmall}} 행운 47+일 때 100%
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"7% chance to fire a tear that decelerates and inflicts Drowsy",
			"{{Luck}} 100% chance at 47 luck",
		},
		Golden = {
			TargetMultipliers = {7}
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.DROWSY_AND_SLEEP },
	},
	[TRINKET..FiendFolio.ITEM.ROCK.REBELLION_ROCK] = {
		_descType = "trinket",
		Name = "혁명석",
		QuoteDesc = "적들에게서 극복하라",
		Description = [[
			{{ffBruise}} 피격 시 주변의 적을 밀쳐내며 공격력 x2의 멍듦 피해를 줍니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
			"FF_APPEND_BRUISE",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Taking damage knocks away nearby enemies and deals 2x Isaac's damage",
			"Enemies knocked away also become Bruised",
		},
		StatusEffects = {
			mod.DescriptionStatuses.BRUISE
		},
		Golden = {
			TargetMultipliers = {2}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.DADS_LEGENDARY_GOLDEN_ROCK] = {
		_descType = "trinket",
		Name = "아빠의 전설적인 황금",
		QuoteDesc = "드디어 황금 채굴",
		Description = [[
			{{ffGrind}} {{ColorYellow}}채굴:{{CR}} 등급이 높거나 황금 석기류를 채굴합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{ffGrind}} {{ColorTransform}}Grind effect",
			"Always spawns a rare or better golden trinket when grinded in the Mining Machine"
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.BEDROCK] = {
		_descType = "trinket",
		Name = "배게",
		QuoteDesc = "쿨쿨...",
		Description = [[
			스테이지 진입 시 33%의 확률로 침대를 소환합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"33% chance for a bed to spawn at the start of every floor"
		},
		Golden = {
			TargetMultipliers = {"33"}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SHEETROCK] = {
		_descType = "trinket",
		Name = "이불",
		QuoteDesc = "편안한 잠자리",
		Description = [[
			{{HealingRed}} 스테이지 진입 시 체력을 2칸 회복합니다.
			{{SoulHeart}} 침대에서 자면 소울하트 2개를 추가로 획득합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Heart}} Heals 2 hearts at the start of each floor",
			"{{SoulHeart}} Sleeping in a bed grants 2 extra Soul Hearts"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {2, 4, 6, 8},
				TargetNumbers = {2},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.FETAL_STONE] = {
		_descType = "trinket",
		Name = "돌멩이 아기",
		QuoteDesc = "고대의 친구",
		Description = [[
			{{Familiar}} {{Confusion}} 공격하는 방향으로 20%의 확률로 적에게 혼란을 거는 공격력 5의 돌덩이를 발사합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Spawns a Golem baby familiar",
			"Deals 5 damage per tear",
			"{{Confusion}} These tears have increased knockback and a 20% chance to confuse enemies"
		},
		Golden = {
			TargetMultipliers = {5},
			Description = {
				"Familiar shoots faster"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GRIMACE_ROCK1] = {
		_descType = "trinket",
		Name = "꼬마 돌머리",
		QuoteDesc = "돌덩이 친구",
		Description = [[
			주변의 적에게 공격력 x1의 눈물을 발사합니다.
			내려놓은 상태에서도 동작합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Fires tears at nearby enemies",
			"Tears deal Isaac's damage",
			"Still fires tears when dropped on the ground"
		},
		Golden = {
			Description = {
				"Tears damage is increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GRIMACE_ROCK2] = {
		_descType = "trinket",
		Name = "꼬마 구토머리",
		QuoteDesc = "폭발하는 친구",
		Description = [[
			주변의 적에게 공격력 +10의 폭발성 구토제를 발사합니다.
			내려놓은 상태에서도 동작합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Fires powerful explosive shots at nearby enemies that deal 10 + Isaac's damage",
			"Still fires tears when dropped on the ground",
			"Explosive shots don't hurt Isaac"
		},
		Golden = {
			Description = {
				"Tears damage is increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GRIMACE_ROCK3] = {
		_descType = "trinket",
		Name = "꼬마 젖은머리",
		QuoteDesc = "방울방울 친구",
		Description = [[
			적이 있는 방에서 주기적으로 적에게 2.62의 피해를 주거나 탄환을 막아주는 방울을 소환합니다.
			내려놓은 상태에서도 동작합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Passively spawns small bubbles that block projectiles",
			"Bubbles do 2.62 damage",
			"Still fires bubbles when dropped on the ground"
		},
		Golden = {
			Description = {
				"Bubble rate is increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GRIMACE_ROCK4] = {
		_descType = "trinket",
		Name = "꼬마 우직머리",
		QuoteDesc = "올곧은 친구",
		Description = [[
			한 방향으로 캐릭터의 공격력의 눈물을 계속 발사합니다.
			내려놓거나 다시 주울 때마다 방향을 바꿀 수 있습니다.
			내려놓은 상태에서도 동작합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Constantly fires tears in a random cardinal direction that deal Isaac's damage",
			"Still fires tears when dropped on the ground"
		},
		Golden = {
			Description = {
				"Tears damage is increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GRIMACE_ROCK5] = {
		_descType = "trinket",
		Name = "깨진 꼬마 구멍머리",
		QuoteDesc = "빨아들이는 친구",
		Description = [[
			근처의 적을 주기적으로 빨아들였다가 멈춥니다.
			내려놓은 상태에서도 동작합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Sucks in all enemies towards Isaac every 2 seconds",
			"Still sucks when dropped on the ground"
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GRIMACE_ROCK6] = {
		_descType = "trinket",
		Name = "꼬마 뿔머리",
		QuoteDesc = "혈사 친구",
		Description = [[
			한 방향으로 캐릭터의 최대 공격력 x6.6의 피해를 주는 얇은 혈사포를 발사합니다
			내려놓거나 다시 주울 때마다 방향을 바꿀 수 있습니다.
			내려놓은 상태에서도 동작합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Periodically fires brimstone beams in a random cardinal direction that deal 0.66x Isaac's damage",
			"Still fires beams when dropped on the ground"
		},
		Golden = {
			TargetMultipliers = {66}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GRIMACE_ROCK7] = {
		_descType = "trinket",
		Name = "꼬마 십자머리",
		QuoteDesc = "십자 친구",
		Description = [[
			공격력 x1의 눈물을 십자/X자 모양을 번갈아가면서 발사합니다.
			내려놓은 상태에서도 동작합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Constantly fires tears in + and x shaped pattern that deal Isaac's damage",
			"Still fires tears when dropped on the ground"
		},
		Golden = {
			Description = {
				"Tears damage is increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GRIMACE_ROCK8] = {
		_descType = "trinket",
		Name = "꼬마 눈알",
		QuoteDesc = "레이저 친구",
		Description = [[
			적이 있는 방에서 캐릭터의 공격력 x0.66의 레이저를 회전하면서 계속 발사합니다.
			내려놓은 상태에서도 동작합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Constantly fires a rotating laser that deals 0.66x Isaac's damage",
			"Still fires lasers when dropped on the ground"
		},
		Golden = {
			TargetMultipliers = {66}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GRIMACE_ROCK9] = {
		_descType = "trinket",
		Name = "꼬마 가마솥",
		QuoteDesc = "마술 친구",
		Description = [[
			{{Charm}} 주기적으로 방 안의 적 하나를 아군으로 복사합니다.
			복사한 아군은 방을 이동하면 사라집니다.
			내려놓은 상태에서도 동작합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Charm}} Spawns a friendly copy of an enemy in the room",
			"Copied enemies disappear upon leaving the room",
			"Still spawns copies when dropped on the ground"
		},
		Golden = {
			Description = {
				"Copied enemy health is increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GRIMACE_ROCK10] = {
		_descType = "trinket",
		Name = "꼬마 구멍머리",
		QuoteDesc = "빨아들이는 친구",
		Description = [[
			픽업 아이템이 끌려옵니다.
			내려놓은 상태에서도 동작합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Constantly sucks in pickups",
			"Still sucks in pickups when dropped on the ground"
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GRIMACE_ROCK11] = {
		_descType = "trinket",
		Name = "꼬마 삼눈머리",
		QuoteDesc = "삼눈 친구",
		Description = [[
			주변의 적에게 공격력 x1의 눈물을 세갈래로 발사합니다.
			내려놓은 상태에서도 동작합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Fires a triple shot at nearby enemies that deals Isaac's damage",
			"Still fires tears when dropped on the ground"
		},
		Golden = {
			Description = {
				"Tears damage is increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GRIMACE_ROCK12] = {
		_descType = "trinket",
		Name = "꼬마 센서머리",
		QuoteDesc = "느낌가는 친구",
		Description = [[
			특정 이동키를 입력하는 동안 그 방향으로 공격력 x1의 눈물을 계속 발사합니다.
			내려놓거나 다시 주울 때마다 방향을 바꿀 수 있습니다.
			내려놓은 상태에서도 동작합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Walking in a set direction causes the grimace to fire in that direction",
			"Tears scale with Isaac's damage",
			"Still fires tears when dropped on the ground"
		},
		Golden = {
			Description = {
				"Tears damage is increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.FOCUS_CRYSTAL] = {
		_descType = "trinket",
		Name = "집중의 돌",
		QuoteDesc = "가까운 적에게 추가 피해",
		Description = [[
			캐릭터와 {{ColorYellow}}2.5 타일{{CR}} 내에 있는 적은{{ColorYellow}}20%{{CR}}의 추가 피해를 받습니다. {{ColorGray}}(중첩 당 +20% 복리 증가).{{CR}}
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Enemies that are within {{ColorYellow}} 2.5 tiles {{ColorWhite}}take{{ColorYellow}} 20%{{ColorWhite}} extra damage {{ColorGray}}(+20% per stack)"
		},
		Golden = {
			TargetMultipliers = {20}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ODDLY_SMOOTH_STONE] = {
		_descType = "trinket",
		Name = "부드러운 돌",
		QuoteDesc = "더 나은 체력",
		Description = [[
			{{BlendedHeart}} 하트류 픽업의 획득량이 반칸만큼 추가로 증가합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Start each combat with {{ColorCyan}}1{{CR}} {{ColorYellow}}Dexterity{{CR}}",
			"{{Heart}} All Red Hearts heal an additional half a heart"
		},
		Golden = {
			Description = {
				"Healing is increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.MOONSTONE] = {
		_descType = "trinket",
		Name = "달의 돌",
		QuoteDesc = "달님을 쳐다보라",
		Description = [[
			소지한 상태에서 {{SecretRoom}}{{SuperSecretRoom}}비밀방 진입 시 아래 능력치 중 하나 증가:
			>>> {{TearsSmall}} 연사 +0.3
			>>> {{RangeSmall}} 사거리 +0.38
			>>> {{ShotspeedSmall}} 탄속 +0.3
			>>> {{LuckSmall}} 행운 +1
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"When entering any type of {{SecretRoom}} Secret Room, Isaac gains one of the following chosen at random:",
			"↑ +0.3 Tears",
			"↑ +0.38 Range",
			"↑ +0.3 Shot speed",
			"↑ +1 Luck"
		},
		Golden = {
			TargetMultipliers = {0.3, 0.38, 0.3, 1}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.LIMESTONE] = {
		_descType = "trinket",
		Name = "라임석",
		QuoteDesc = "신 맛",
		Description = [[
			캐릭터가 지나간 자리에 초록 장판이 생기며 닿은 적은 초당 캐릭터의 공격력 x0.5의 피해를 입습니다.
			감귤 타입의 적을 아군으로 만듭니다.
			일부 몬스터가 특수하게 변경됩니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Leaves a trail of lime creep that deals 0.5x Isaac's damage",
			"Permanently charms citrus related enemies",
			"33% chance for Sourpatch enemies to be replaced with Limepatches"
		},
		Golden = {
			TargetMultipliers = {33, 50}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.CARNAL_CARNELIAN] = {
		_descType = "trinket",
		Name = "카넬리안",
		QuoteDesc = "적과 가까울수록 강해진다",
		Description = [[
			적과 가까울수록 {{DamageSmall}}공격력/{{SpeedSmall}}이동속도가 증가합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ Gain damage and speed that scales with how close Isaac is to enemies"
		},
		Golden = {
			Description = {
				"Increased damage, speed, and area of effect"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.REBAR_ROCK] = {
		_descType = "trinket",
		Name = "철근석",
		QuoteDesc = "단단해진 빨간 하트",
		Description = [[
			{{Heart}} {{ColorYellow}}빨간하트{{CR}} 피해를 25%의 확률로 무시하며 항상 반칸으로 줄여줍니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Heart}} 25% chance to block Red Heart damage",
			"{{HalfHeart}} Red Heart damage is always half a heart"
		},
		Golden = {
			TargetStrings = {
				"25",
				"50",
				"50",
				"50",
				"50"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.DOGROCK_ROCK] = {
		_descType = "trinket",
		Name = "강아지",
		QuoteDesc = "너를 좋아하나 봐!",
		Description = [[
			↓ {{LuckSmall}}행운 -100
			{{Slow}} 캐릭터 주변을 느려지게 합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↓ -100 Luck",
			"Distorts the screen and music",
			"{{Slow}} Slows enemies in a small radius around Golem"
		},
		Golden = {
			TargetMultipliers = {
				"100"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.STALACTITE] = {
		_descType = "trinket",
		Name = "종유석",
		QuoteDesc = "천장이 무너져",
		Description = [[
			폭발 피해를 받으면 공격력 x2의 피해를 주는 돌덩이 여러개가 랜덤 위치에 떨어집니다.
			떨어지는 돌덩이에 피해를 입지 않습니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Explosions will cause rocks to fall from the ceiling",
			"Ceiling rocks deal 2x Isaac's damage",
			"Prevents damage from falling projectiles"
		},
		Golden = {
			Description = {
				"Amount of falling rocks increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.CAST_GEM] = {
		_descType = "trinket",
		Name = "주문 보석",
		QuoteDesc = "보석 친구",
		Description = [[
			공격 시 적을 향해 날아가는 유도 보석을 3개 획득합니다.
			{{ffBruise}} 유도 보석이 적과 접촉 시 멍듦 피해를 줍니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
			"FF_APPEND_BRUISE",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Grants a homing gem that can be cast while attacking that sticks to enemies, inflicting damage and bruising",
		},
		StatusEffects = {
			mod.DescriptionStatuses.BRUISE
		},
		Golden = {
			TargetStrings = {
				"a homing gem",
				"2 homing gems",
				"3 homing gems",
				"4 homing gems",
				"5 homing gems"
			},
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SHARD_OF_GOLGOTHA] = {
		_descType = "trinket",
		Name = "골고타 조각",
		QuoteDesc = "적 묶기",
		Description = [[
			{{Collectible722}} 방 입장 시 최대 체력이 가장 많은 적을 7초간 움직이지 못하게 만듭니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Collectible722}} Chains the enemy with the highest health at the start of every room for 7 seconds",
			"Chained enemies cannot move or attack"
		},
		Golden = {
			TargetMultipliers = {7}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SMOKY_QUARTZ] = {
		_descType = "trinket",
		Name = "연기나는 쿼츠",
		QuoteDesc = "맞으면 연기를 뿜다",
		Description = [[
			{{Confusion}} 피격 시 이동속도가 잠시동안 크게 증가하며 7초간 주변의 적에게 혼란을 겁니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Timer}} Taking damage grants a temporary speed boost and confuses nearby enemies for 7 seconds"
		},
		Golden = {
			Description = {
				"Area of effect increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.TWINKLING_ROCK] = {
		_descType = "trinket",
		Name = "빛나는 돌",
		QuoteDesc = "정동석 채굴",
		Description = [[
			{{ffGrind}} {{ColorYellow}}채굴:{{CR}} 정동류를 채굴합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{ffGrind}} {{ColorTransform}}Grind effect",
			"Grinding this rock in the Mining Machine gives a common or rare geode"
		},
		Golden = {
			Description = {
				"Given rock trinket is Golden"
			},
			GoldOnly = true
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ROCK_CAKE] = {
		_descType = "trinket",
		Name = "돌 케이크",
		QuoteDesc = "채굴 회복",
		Description = [[
			{{ffGrind}} {{HealingRed}} 소지 중일 때 다른 석기류 채굴 시 빨간하트를 반칸 회복합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{ffGrind}} {{ColorTransform}}Grind effect",
			"Grinding other rocks in the Mining Machine heals a half Red Heart"
		},
		Golden = {
			TargetStrings = {
				"a half Red Heart",
				"one Red Heart",
				"one and a half Red Hearts",
				"2 Red Hearts",
				"2 and a half Red Hearts"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.CHARCOAL] = {
		_descType = "trinket",
		Name = "숯덩이",
		QuoteDesc = "크람푸스의 석탄을 베낀 것",
		Description = [[
			{{Collectible132}} 15%의 확률로 탄속이 느리지만 공격이 멀리 나갈수록 공격력이 증가하는 눈물을 발사합니다.
			{{LuckSmall}} 행운 43+일 때 50%
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"15% chance to fire a very slow tear that deals more damage the further it travels",
			"{{Luck}} 50% chance at 43 luck"
		},
		Golden = {
			TargetAdditives = {
				TargetNumbers = {15},
				AdditiveValues = {5, 10, 15, 20}
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.KNIFE_PEBBLE] = {
		_descType = "trinket",
		Name = "칼모양 조약돌",
		QuoteDesc = "공격력 증가",
		Description = [[
			↑ {{DamageSmall}}공격력 +1
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +1 Damage"
		},
		Golden = {
			TargetMultipliers = {1}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.TEARDROP_PEBBLE] = {
		_descType = "trinket",
		Name = "칼모양 조약돌",
		QuoteDesc = "공격력 증가",
		Description = [[
			↑ {{TearsSmall}}연사 +0.4
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +0.4 Tears"
		},
		Golden = {
			TargetMultipliers = {0.4}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ARROW_PEBBLE] = {
		_descType = "trinket",
		Name = "활 조약돌",
		QuoteDesc = "사거리, 탄속 증가",
		Description = [[
			↑ {{RangeSmall}}사거리 +1.25
			↑ {{ShotspeedSmall}}탄속 +0.2
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +1.25 Range",
			"↑ +0.2 Shot speed"
		},
		Golden = {
			TargetMultipliers = {1.25, 0.2}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.CLOVER_PEBBLE] = {
		_descType = "trinket",
		Name = "클로버 조약돌",
		QuoteDesc = "행운 증가",
		Description = [[
			↑ {{LuckSmall}}행운 +2
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +2 Luck"
		},
		Golden = {
			TargetMultipliers = {2}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SHOE_PEBBLE] = {
		_descType = "trinket",
		Name = "신발 조약돌",
		QuoteDesc = "이동속도 증가",
		Description = [[
			↑ {{SpeedSmall}}이동속도 +0.3
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +0.3 Speed"
		},
		Golden = {
			TargetMultipliers = {0.3}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.FRUITY_PEBBLE] = {
		_descType = "trinket",
		Name = "과일 조약돌",
		QuoteDesc = "모든 능력치 증가",
		Description = [[
			↑ {{SpeedSmall}}이동속도 +0.15
			↑ {{DamageSmall}}공격력 +0.3
			↑ {{TearsSmall}}연사 +0.15
			↑ {{RangeSmall}}사거리 +0.75
			↑ {{ShotspeedSmall}}탄속 +0.18
			↑ {{LuckSmall}}행운 +1
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +0.15 Speed",
			"↑ +0.15 Tears",
			"↑ +0.3 Damage",
			"↑ +0.75 Range",
			"↑ +0.18 Shot speed",
			"↑ +1 Luck"
		},
		Golden = {
			TargetMultipliers = {0.15, 0.3, 0.75, 0.18, 1}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.MIXED_PEBBLE_1] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ {{SpeedSmall}}이동속도 +0.15
			↑ {{DamageSmall}}공격력 +0.5
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +0.15 Speed",
			"↑ +0.5 Damage"
		},
		Golden = {
			TargetMultipliers = {0.15, 0.5}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.MIXED_PEBBLE_2] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ {{SpeedSmall}}이동속도 +0.15
			↑ {{LuckSmall}}행운 +1
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +0.15 Speed",
			"↑ +1 Luck"
		},
		Golden = {
			TargetMultipliers = {0.15, 1}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.MIXED_PEBBLE_3] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ {{TearsSmall}}연사 +0.15
			↑ {{LuckSmall}}행운 +1
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +0.15 Tears",
			"↑ +1 Luck"
		},
		Golden = {
			TargetMultipliers = {0.15, 1}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.MIXED_PEBBLE_4] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ {{DamageSmall}}공격력 +0.5
			↑ {{RangeSmall}}사거리 +0.75
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +0.75 Range",
			"↑ +0.5 Damage"
		},
		Golden = {
			TargetMultipliers = {0.75, 0.5}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.MIXED_PEBBLE_5] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ {{RangeSmall}}사거리 +0.75
			↑ {{LuckSmall}}행운 +1
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +0.75 Range",
			"↑ +1 Luck"
		},
		Golden = {
			TargetMultipliers = {0.75, 1}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.MIXED_PEBBLE_6] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			↑ {{SpeedSmall}}이동속도 +0.15
			↑ {{RangeSmall}}사거리 +0.75
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +0.15 Speed",
			"↑ +0.75 Range"
		},
		Golden = {
			TargetMultipliers = {0.15, 0.75}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ACHILLES_ROCK] = {
		_descType = "trinket",
		Name = "아킬레스석",
		QuoteDesc = "약점 찾기",
		Description = [[
			적에게 랜덤 방향으로 급소가 생깁니다.
			급소 명중 시 1.5배의 피해를 받습니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Enemies gain a random weak point aligned with a random direction",
			"When damaged from that direction, they take x1.5 damage"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {0.5, 1, 1.5, 2},
				TargetNumbers = {1.5},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ELECTRUM] = {
		_descType = "trinket",
		Name = "엘렉트륨",
		QuoteDesc = "액티브 전류 발산",
		Description = [[
			액티브 아이템 사용 시 전류를 발산하여 주변의 적에게 캐릭터의 공격력 및 액티브 아이템 충전량에 비례한 피해를 줍니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Using an active item shocks nearby enemies",
			"Damage scales with charge amount and Isaac's damage",
			"Effects vary on Isaac's active item"
		},
		Golden = {
			Description = {
				"Shock damage increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.PURE_QUARTZ] = {
		_descType = "trinket",
		Name = "순수한 쿼츠",
		QuoteDesc = "영혼을 바친 보호막",
		Description = [[
			피격 시 소울하트가 없으면:
			>>> 10초간 무적 상태가 되며 
			>>> {{HolyMantleSmall}} 피격 시 피해를 1회 무시하는 보호막을 제공합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{SoulHeart}} If Isaac loses all of his Soul Hearts:",
			"{{Collectible313}} Gain a Holy Mantle shield",
			"{{Timer}} Become invincible for 10 seconds"
		},
		Golden = {
			TargetMultipliers = {10}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.AMAZONITE] = {
		_descType = "trinket",
		Name = "천하석",
		QuoteDesc = "배송기간이 있어",
		Description = [[
			스테이지에서 가장 먼저 줍는 픽업은 1{{Coin}}으로 구매해야 되며 구매 시 사라집니다.
			사라진 픽업은 다음 스테이지 진입 시 소환됩니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"The first purchase in a {{Shop}} Shop is heavily discounted",
			"After purchasing an item, it will disappear and spawn on the next floor"
		},
		Golden = {
			TargetStrings = {
				"first purchase",
				"first and second purchase",
				"first, second, and third purchase",
				"first, second, third, and fourth purchase",
			}
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.STAR_SAPPHIRE] = {
		_descType = "trinket",
		Name = "별모양 사파이어",
		QuoteDesc = "이동 탐지기",
		Description = [[
			{{Familiar}} 가장 가까운 적 및 탄환을 바라보는 방향에서 앞뒤로 움직입니다.
			탄환을 막으면서 접촉하는 적에게 초당 공격력 x1.5의 피해를 줍니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Spawns a wobbly orbital familiar that points towards the nearest enemy or projectile",
			"Blocks shots and deals 0.5x Isaac's damage"
		},
		Golden = {
			TargetMultipliers = {0.5}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GRAVESTONE] = {
		_descType = "trinket",
		Name = "묘비",
		QuoteDesc = "무서운 신성 모독",
		Description = [[
			피격 시 100%의 확률, 혹은 장애물을 부술 시 15%의 확률로:
			>>> {{Collectible634}}연옥의 유령 혹은 {{Collectible684}}굶주린 유령을 소환합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Taking damage spawns either:",
			"{{Collectible634}} A homing exploding ghost",
			"{{Collectible684}} A ghost which chases enemies, dealing contact damage and exploding after 3 seconds",
			"15% chance for either ghost to appear when destroying rocks"
		},
		Golden = {
			-- A long description like this is not ideal, but you can't replace strings and do additive values and multipliers with EID :(
			Description = {
				"More homing ghosts are spawned at once",
				"Chasing ghosts last longer",
				"Higher chance for either ghost to appear when breaking rocks"
			},
			TargetMultipliers = {3},
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SAND_CASTLE] = {
		_descType = "trinket",
		Name = "모래성",
		QuoteDesc = "약한 방패",
		Description = [[
			피격을 3회 무효화하며 3회 피격 시 {{Trinket]]..FiendFolio.ITEM.ROCK.POCKET_SAND..[[}}Pocket Sand로 바뀝니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Trinket" ..
				FiendFolio.ITEM.ROCK.POCKET_SAND .. "}} Negates 3 hits of damage before turning into Pocket Sand"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {1, 1, 1, 1},
				TargetNumbers = {3}
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.DAMAGED_SAND_CASTLE] = {
		_descType = "trinket",
		Name = "모래성",
		QuoteDesc = "약한 방패",
		Description = [[
			피격을 2회 무효화하며 2회 피격 시 {{Trinket]]..FiendFolio.ITEM.ROCK.POCKET_SAND..[[}}Pocket Sand로 바뀝니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Trinket" ..FiendFolio.ITEM.ROCK.POCKET_SAND .. "}} Negates 2 hits of damage before turning into Pocket Sand"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {1, 1, 1, 1},
				TargetNumbers = {2}
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.BROKEN_SAND_CASTLE] = {
		_descType = "trinket",
		Name = "모래성",
		QuoteDesc = "약한 방패",
		Description = [[
			피격을 1회 무효화하며 1회 피격 시 {{Trinket]]..FiendFolio.ITEM.ROCK.POCKET_SAND..[[}}Pocket Sand로 바뀝니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Trinket" ..FiendFolio.ITEM.ROCK.POCKET_SAND .. "}} Negates 1 hit of damage before turning into Pocket Sand",
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {1, 1, 1, 1},
				TargetNumbers = {1}
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GUARDED_GARNET] = {
		_descType = "trinket",
		Name = "보호의 가넷",
		QuoteDesc = "맞으면 보호막",
		Description = [[
			피격 시 그 방에서 30%의 확률로 피해를 1회 막아주는 붉은 보호막을 생성합니다.
			{{LuckSmall}} 행운 35+일 때 100%
			붉은 보호막 파괴 시 주변의 적을 밀쳐냅니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"30% chance to gain a shield on damage that lasts for a room and blocks one hit",
			"{{Luck}} 100% chance at 35 luck",
			"Enemies are knocked back when the shield is broken"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {10, 20, 30, 40},
				TargetNumbers = {30}
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SHAMROCK] = {
		_descType = "trinket",
		Name = "행운석",
		QuoteDesc = "연약한 행운 증가",
		Description = [[
			↑ {{LuckSmall}}행운 +5
			{{LuckSmall}} 피격 시 그 스테이지에서 행운 -1
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +5 Luck",
			"↓ When taking damage, the Isaac loses 1 luck for the floor"
		},
		Golden = {
			Description = {
				"Damage required to lose luck is increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GAS_POCKET] = {
		_descType = "trinket",
		Name = "가스 주머니",
		QuoteDesc = "유독성 돌덩이",
		Description = [[
			{{Poison}} 장애물마다 10%의 확률로 독성 장애물로 바뀝니다.
			독성 장애물은 4초마다 작은 독가스를 생성합니다.
			{{Poison}} 해당 장애물 파괴 시 35%의 확률로 커다란 독가스가 생깁니다.
			{{LuckSmall}} 행운 65+일 때 100%
			(캐릭터 피해 없음)
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Poison}} Rocks have a 10% chance to spawn poisonous gas every 4 seconds",
			"35% chance for rocks to spawn large poison gas clouds when broken",
			"{{Luck}} 100% chance at 65 luck",
			"The poison gas can't hurt Isaac"
		},
		Golden = {
			Description = {
				"Poison gas lasts longer"
			},
			TargetAdditives = {
				AdditiveValues = {10, 20, 30, 40},
				TargetNumbers = {35}
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SOAP_STONE] = {
		_descType = "trinket",
		Name = "굳은 비누",
		QuoteDesc = "방 클리어 마무리",
		Description = [[
			피격 시 그 방의 탄환을 모두 지우며 적의 탄환을 막아주는 방울을 3개 소환합니다.
			방 클리어 시 그 방의 탄환을 모두 지웁니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Clears all projectiles on room clear and when taking damage",
			"Spawns 3 bubbles upon taking damage"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {1, 2, 3, 4},
				TargetNumbers = {3},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SPIRIT_URN] = {
		_descType = "trinket",
		Name = "영혼 항아리",
		QuoteDesc = "위험할 때 영혼 소환",
		Description = [[
			{{Collectible584}} {{BossRoom}}보스방/미니보스방/{{ChallengeRoom}}도전방 시작 시 일반 위습을 3개 소환합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Spawns 3 wisps when entering a {{BossRoom}} Boss or {{MiniBoss}} Miniboss room",
			"Spawns 3 wisps when starting a {{ChallengeRoom}} Challenge Room"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {1, 2, 3, 4},
				TargetNumbers = {3}
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SUN_SHARD] = {
		_descType = "trinket",
		Name = "태양 조각",
		QuoteDesc = "당신만의 태양계",
		Description = [[
			{{Familiar}} x1: 캐릭터의 주위를 돌며 적의 탄환을 막아줍니다.
			적의 탄환을 막으면 잠시동안 회전 속도가 빨라지며 그 자리에 주기적으로 핏방울과 빨간 장판을 남깁니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Spawns a random organ orbital each room that deals 0.5x Isaac's damage and blocks shots",
			"Organs have special effects when hit by projectiles"
		},
		Golden = {
			TargetStrings = {
				"a random organ orbital",
				"2 random organ orbitals",
				"3 random organ orbitals",
				"4 random organ orbitals",
				"5 random organ orbitals",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.STEADFAST_STONE] = {
		_descType = "trinket",
		Name = "확고한 돌",
		QuoteDesc = "최후의 수단",
		Description = [[
			!!! 일회용
			피격 시 남은 체력이 없을 경우 피격을 무효화하고 소지 중인 장신구를 전부 파괴합니다.
			{{SoulHeart}} 소울하트도 추가 드랍
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"When taking fatal damage, Isaac crushes another rock trinket they are holding to prevent death",
			"Also spawns a Soul heart"
		},
		Golden = {
			TargetStrings = {
				"a Soul heart",
				"2 Soul hearts",
				"3 Soul hearts",
				"4 Soul hearts",
				"5 Soul hearts"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.RAI_STONE] = {
		_descType = "trinket",
		Name = "라이 석화",
		QuoteDesc = "마몬의 선물",
		Description = [[
			{{Coin}} 적 처치 시 15%의 확률로 2.5초 후 사라지는 동전을 드랍합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Coin}} 15% chance for enemies to drop a stone penny on death",
			"The stone pennies disappear after 2.5 seconds"
		},
		Golden = {
			TargetMultipliers = {15}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ORE_PENNY] = {
		_descType = "trinket",
		Name = "금광 페니",
		QuoteDesc = "금광 부자",
		Description = [[
			{{Trinket52}} 동전 획득 시 50% 확률로 {{Coin}}동전을 하나 더 얻습니다.
			3%의 확률로 장애물을 금광석으로 바꿉니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Coin}} Picking up a coin has a 50% chance to add another coin to the counter",
			"3% chance to convert normal rocks into Fool's Gold rocks"
		},
		Golden = {
			TargetMultipliers = {3},
			TargetStrings = {
				"another coin",
				"another 2 coins",
				"another 3 coins",
				"another 4 coins",
				"another 5 coins"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.HEAVY_METAL] = {
		_descType = "trinket",
		Name = "무거운 메탈",
		QuoteDesc = "이동속도 감소, 공격력 증가",
		Description = [[
			↓ {{SpeedSmall}}이동속도 -0.15
			{{DamageSmall}} 이동속도에 반비례하여 공격력이 증가합니다.
			확률적으로 피격을 무효화하며 이동속도가 느릴수록 확률이 증가합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↓ -0.15 Speed",
			"Grants damage and a chance to prevent damage depending on how slow Isaac is"
		},
		Golden = {
			Description = {
				"More damage",
				"Higher chance to prevent damage"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GROSSULAR] = {
		_descType = "trinket",
		Name = "그로설라",
		QuoteDesc = "역겨운 걸 발산",
		Description = [[
			클리어하지 않은 방에서 주기적으로 주변의 적에게 {{Fear}} 공포, {{Confusion}} 혼란, {{Poison}} 독 중 하나를 거는 파동을 발산합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Periodically fire a pulse that either {{Fear}} Fears, {{Poison}} Poisons, or {{Confusion}} Confuses nearby enemies"
		},
		Golden = {
			Description = {
				"Enemies are inflicted with more status effects at once"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SULFUR_CRYSTAL] = {
		_descType = "trinket",
		Name = "황산 보석",
		QuoteDesc = "일시적 강력함",
		Description = [[
			{{Collectible118}} 4번째 방마다 그 방에서 혈사포를 발사합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Timer}} {{Collectible118}} Grants Brimstone at the start of every 4th room"
		},
		Golden = {
			TargetStrings = {
				"4th room",
				"3rd room",
				"other room",
				"single room",
				"single room"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.TROLLITE] = {
		_descType = "trinket",
		Name = "트롤라이트",
		QuoteDesc = "딱 한번만이야...",
		Description = [[
			{{ffGrind}} {{ColorYellow}}채굴:{{CR}} !!! 채굴기와 캐릭터가 폭발합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"We do a little trolling"
		},
		Golden = {
			Description = {
				"It's called we do a little bit of trolling"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.THROWLOMITE] = {
		_descType = "trinket",
		Name = "쓰로마이트",
		QuoteDesc = "돌멩이 던지기",
		Description = [[
			1.67초마다 가장 가까운 적에게 돌덩이를 던집니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Every 1.67 seconds, throws a stone at a nearby enemy that scales with Isaac's damage"
		},
		Golden = {
			Description = {
				"Throws more often for more damage"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.HEARTHSTONE] = {
		_descType = "trinket",
		Name = "하스스톤",
		QuoteDesc = "무작위 카드 효과",
		Description = [[
			{{Card}} 카드 사용 시 랜덤 긍정 효과를 발동합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Triggers a random beneficial effect whenever a card is used"
		},
		Golden = {
			TargetStrings = {
				"a random beneficial effect",
				"2 random beneficial effects",
				"3 random beneficial effects",
				"4 random beneficial effects",
				"5 random beneficial effects"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.MAGNETIC_SAND] = {
		_descType = "trinket",
		Name = "자기 모래",
		QuoteDesc = "연사 증가 + 자석 눈물",
		Description = [[
			↑ {{TearsSmall}}연사 +0.45
			↓ {{DamageSmall}}공격력 -0.35
			{{Magnetize}} 10%의 확률로 맞은 적에게 자성 피해를 주는 공격이 나갑니다.
			{{LuckSmall}} 행운 20+일 때 100%
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +0.45 Tears",
			"↓ -0.35 Damage",
			"{{Magnetize}} 10% chance to shoot magnetizing tears",
			"{{Luck}} 50% chance at 20 luck"
		},
		Golden = {
			TargetAdditives = {
				TargetNumbers = {10},
				AdditiveValues = {10, 20, 30, 40}
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.INSATIABLE_APATITE] = {
		_descType = "trinket",
		Name = "배고픈 인회석",
		QuoteDesc = "하트를 먹여주면 공격력 증가",
		Description = [[
			{{DamageSmall}} 하트류 픽업 획득 시 증발성 공격력이 증가합니다.
			{{DamageSmall}} 체력이 꽉 찼을 경우 공격력 추가 증가
			하트 종류에 따른 추가 효과
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ Gain a temporary damage up when picking up hearts",
			"{{Heart}} Hearts can be consumed while at full health to increase the damage",
			"Certain types of hearts have additional effects when consumed"
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.POWER_ROCK] = {
		_descType = "trinket",
		Name = "충전된 돌",
		QuoteDesc = "굳은 충전",
		Description = [[
			{{Battery}}장애물 파괴 시 5%의 확률로 액티브 아이템의 충전량을 1칸 충전합니다.
			{{LuckSmall}} 행운 20+일 때 25%
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Battery}} Breaking rocks has a 5% chance to add 1 charge to the active item",
			"{{Luck}} 25% chance at 20 luck"
		},
		Golden = {
			TargetAdditives = {
				TargetNumbers = {5},
				AdditiveValues = {2.5, 5, 7.5, 10},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.TIGERS_EYE] = {
		_descType = "trinket",
		Name = "호랑이의 눈",
		QuoteDesc = "수호자의 시선",
		Description = [[
			{{Familiar}} 대각선으로 이동하며 벽과 부딪힐 시 적을 향해 반사됩니다.
			탄환을 막으며 접촉하는 적에게 캐릭터 공격력 x0.66의 피해를 줍니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Spawns an eye familiar that bounces across the room, dealing contact damage and blocking shots",
			"The eye bounces towards enemies that are closest to it",
			"Deals 0.66x Isaac's Damage"
		},
		Golden = {
			TargetMultipliers = {0.66},
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SMALLER_ROCK] = {
		_descType = "trinket",
		Name = "더 작은 돌",
		QuoteDesc = "색돌을 찾아라",
		Description = [[
			색돌 파괴 시:
			>>> {{SpeedSmall}} 이동속도 -0.06
			>>> {{DamageSmall}} 공격력 +0.33
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Whenever a Tinted Rock is destroyed:",
			"↑ +0.33 Damage",
			"↓ -0.06 Speed"
		},
		Golden = {
			TargetMultipliers = {0.33, 0.06},
		},
	},
	[TRINKET..FiendFolio.ITEM.ROCK.NITRO_CRYSTAL] = {
		_descType = "trinket",
		Name = "니트로 보석",
		QuoteDesc = "돈을 써서 보너스 획득",
		Description = [[
			{{Coin}} 동전을 주울 시 니트로를 잠시동안 활성화합니다.
			니트로가 활성화되어 있는 동안 {{SpeedSmall}}이동속도/{{TearsSmall}}연사가 증가합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Coin}} Picking up coins gives Isaac a boost to Tears and speed"
		},
		Golden = {
			Description = {
				"Grants a greater boost to Tears and speed"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SHARD_OF_GOLEM] = {
		_descType = "trinket",
		Name = "골렘의 조각",
		QuoteDesc = "골렘의 선물",
		Description = [[
			초과 회복 시 특수 게이지를 채웁니다.
			특수 게이지 완충 시 소지 중인 장신구를 전부 흡수합니다.
			특수 게이지 1칸 당 {{DamageSmall}}공격력 +0.45
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Overhealing charges a secondary health bar",
			"{{Damage}} Filling this health bar accumulates a damage boost up to +1.8 Damage for each heart filled",
			"Once all hearts are filled all held trinkets are smelted",
			"This health bar can be viewed by viewing the map"
		},
		Golden = {
			TargetMultipliers = {1.8}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ROCK_WORM] = {
		_descType = "trinket",
		Name = "돌멩이 벌레",
		QuoteDesc = "웅가붕가",
		Description = [[
			↑ {{TearsSmall}}연사 +0.4
			↑ {{DamageSmall}}공격력 +0.4
			스테이지 진입 시 그 스테이지에서 랜덤 벌레 장신구 효과를 얻습니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +0.4 Tears",
			"↑ +0.4 Damage",
			"Grants a random worm trinket effect at the start of the floor for the duration of the floor"
		},
		Golden = {
			TargetMultipliers = {0.4},
			TargetStrings = {
				"a random worm trinket effect",
				"2 random worm trinket effects",
				"3 random worm trinket effects",
				"4 random worm trinket effects",
				"5 random worm trinket effects",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.FOOLS_UNOBTAINIUM] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			!!! 획득불가?
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Supposedly unobtainable, but it's not hard to actually get"
		},
		Golden = {
			Description = {
				"Slightly harder to obtain"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.MINICHIBISIDIAN] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "뼈다귀 교체술",
		Description = [[
			3초마다 그 방의 적 하나가 10%의 확률로 Bony로 바뀝니다.
			바뀐 Bony는 바뀌기 전의 체력을 따릅니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"10% chance to randomly transform a enemy in a room into a Bony every 3 seconds"
		},
		Golden = {
			TargetMultipliers = {10}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.FRIENDLY_RAPID_FIRE_OPAL] = {
		_descType = "trinket",
		Name = "난사 장난감 오팔",
		QuoteDesc = "완전 자동, 장전 완료!",
		Description = [[
			방 입장 시 12발의 총알이 제공되며 총알이 남아있는 동안 라이플을 난사할 수 있습니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Gain a limited ammo assault rifle when entering a room that has:",
			"↑ 0.5x Fire rate multiplier",
			"↑ +6.25 Range",
			"↑ +1.0 Shot speed",
			"Piercing tears"
		},
		Golden = {
			Description = {
				"Rifle has increased ammo"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.HIDDENITE] = {
		_descType = "trinket",
		Name = "히드나이트",
		QuoteDesc = "전장의 안개",
		Description = [[
			{{Confusion}} 처음으로 시야에 벗어난 적을 2.67초간 혼란시킵니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Confusion}} Entering then breaking the line of sight from an enemy for the first time confuses them for 2.67 seconds"
		},
		Golden = {
			TargetMultipliers = {2.67}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.POCKET_ROCKIT] = {
		_descType = "trinket",
		Name = "포켓 로켓",
		QuoteDesc = "로켓 사이언스",
		Description = [[
			공격 시 10%의 확률로 로켓을 발사합니다.
			{{LuckSmall}} 행운 10+일 때 25%
			로켓이 무언가에 부딪힌 위치에 8방향으로 특정 패턴의 눈물을 발사합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"10% chance to fire a rocket tear that homes in on enemies",
			"{{Luck}} 25% chance at 10 luck",
			"Rockets shoot low damage tears when close to enemies",
			"Rockets pop into a tear pattern on impact, depending on its color"
		},
		Golden = {
			TargetMultipliers = {10}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.WORMHOLE_ROCK] = {
		_descType = "trinket",
		Name = "웜홀석",
		QuoteDesc = "오, 웜홀?",
		Description = [[
			방 입장 시 특수 포탈을 2개 소환합니다.
			포탈 공격 시 다른 포탈에서 적을 향해 공격력 x1.5의 랜덤 효과의 공격으로 나갑니다.
			주기적으로 포탈의 위치가 바뀝니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Spawns two wormholes",
			"Tears and projectiles that enter a portal will emerge from the other",
			"Tears shot through portals will aim towards enemies and have additional effects",
			"The wormholes will occasionally burst into tears and change positions"
		},
		Golden = {
			Description = {
				"Shot tears deal extra damage"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ATLAS_BURDEN] = {
		_descType = "trinket",
		Name = "아틀라스의 부담",
		QuoteDesc = "다른 놈들한테 넘겨",
		Description = [[
			↓ {{SpeedSmall}}이동속도 -0.15
			적 명중 시 최대 25%의 확률로 적에게 하늘을 떠받치게 하며 즉사, 보스의 경우 {{Slow}}둔화 + 주기적으로 공격력 x4의 피해를 줍니다.
			{{LuckSmall}} 행운 3+일 때 50%, 하늘을 떠받친 적 수에 반비례
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↓ -0.15 Speed",
			"25% chance for a boulder to drop on enemies",
			"{{Luck}} 50% chance at 3 luck",
			"{{Slow}} The boulder slows enemies down and can instantly kill non-boss enemies over time"
		},
		Golden = {
			TargetAdditives = {
				TargetNumbers = {25},
				AdditiveValues = {5, 10, 15, 20},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ARACHNITE] = {
		_descType = "trinket",
		Name = "아라크나이트",
		QuoteDesc = "돌 속에서의 몸부림",
		Description = [[
			모든 아군 자폭 파리가 아군 Rock Spider로 바뀝니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Blue spiders are replaced with friendly rock spiders",
			"Chance to replace with tinted or coal rock spiders"
		},
		Golden = {
			Description = {
				"Friendly rock spiders deal extra chance",
				"Chance to replace is increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.HOMOEROTIC_RUBY] = {
		_descType = "trinket",
		Name = "호모 루비",
		QuoteDesc = "열정적이야, 베이베!",
		Description = [[
			{{Burning}} 공격 시 15%의 확률로 적에게 화상을 입히는 공격이 나갑니다.
			{{LuckSmall}} 행운 35+일 때 50%
			{{ffBerserk}} 암컷 적의 경우 10%의 확률로 폭주 상태가 됩니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
			"FF_APPEND_BERSERK",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"15% chance to fire flaming tears that inflict Burn",
			"{{Luck}} 50% chance at 35 luck",
			"Female enemies have a 10% chance to randomly go Berserk",
		},
		StatusEffects = {mod.DescriptionStatuses.BERSERK},
		Golden = {
			TargetAdditives = {
				TargetNumbers = {10, 15},
				AdditiveValues = {5, 10, 15, 20},
			}
		},
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GAY_GARNET] = {
		_descType = "trinket",
		Name = "게이 가넷",
		QuoteDesc = "교미",
		Description = [[
			{{Collectible]] .. FiendFolio.ITEM.COLLECTIBLE.PEPPERMINT .. [[}} 20%의 확률로 처치시 적을 얼리는 불꽃을 날립니다.
			{{LuckSmall}} 행운 30+일 때 50%
			{{ffBerserk}} 암컷 적의 경우 등장 시 10초동안 {{Charm}}매혹에 걸리며 확률적으로 폭주 상태가 됩니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
			"FF_APPEND_BERSERK",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Charm}} Charms female enemies",
			"{{Collectible" .. mod.ITEM.COLLECTIBLE.PEPPERMINT .. "}} "
				.. "20% chance to shoot a fire that damages and freezes enemies",
			"{{Luck}} 50% chance at 30 luck",
			"Female enemies have a 15% chance to randomly go Berserk",
		},
		StatusEffects = {mod.DescriptionStatuses.BERSERK},
		Golden = {
			TargetAdditives = {
				TargetNumbers = {20, 15},
				AdditiveValues = {5, 10, 15, 20},
			}
		},
	},
	[TRINKET..FiendFolio.ITEM.ROCK.LITHOPEDIAN] = {
		_descType = "trinket",
		Name = "리소페디안",
		QuoteDesc = "당신만의 스토니",
		Description = [[
			{{Familiar}} 적을 추적 후 밀쳐내며 적의 탄환을 막아줍니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Spawns a Stoney Gaper familiar that pushes enemies around and blocks shots"
		},
		Golden = {
			Description = {
				"Stoney Gaper familiar now deals contact damage that scales with Isaac's damage"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.JESUS_ROCK] = {
		_descType = "trinket",
		Name = "예수석",
		QuoteDesc = "죽음으로부터의 부활",
		Description = [[
			!!! 일회용
			사망 시 그 방에서 체력 6칸으로 부활합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +1 Life",
			"{{Heart}} On death, Isaac respawns in the current room with 6 hearts added to the health bar"
		},
		Golden = {
			Description = {
				"When revived:",
				"Health bar is fully filled with hearts and soul hearts",
				"Grants a shield for 10 seconds"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.LOST_ARTIFACT] = {
		_descType = "trinket",
		Name = "잊혀진 유물",
		QuoteDesc = "냥냥 요정",
		Description = [[
			방 클리어 시 적과 접촉 시 피해를 주는 요정 파리가 옵니다.
			소형 : 주기적으로 캐릭터의 눈물을 발사합니다.
			중형 : 터질 때 8방향으로 캐릭터의 눈물을 발사합니다.
			대형 : 터질 때 기가 폭발을 일으키며 8방향으로 캐릭터의 눈물을 발사합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"1-3 Fairy flies spawn upon room clear",
			"Fairy flies deal contact damage to enemies, and die after some time",
			"Fairy flies come in three different sizes, and all have different effects",
			"Fairy fly names can be shown by viewing the map"
		},
		Golden = {
			Description = {
				"Higher chance for large fairy flies to appear",
				"More fairy flies are able to appear upon room clear"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.RIDICULOUS_METAL] = {
		_descType = "trinket",
		Name = "익살스러운 메탈",
		QuoteDesc = "리듬의 보상",
		Description = [[
			방 입장 시 적이 있는 경우 미니 리듬게임을 시작합니다.
			정확한 타이밍에 공격 시 적 전체에게 피해를 줍니다.
			연속 성공 시 피해량이 증가합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Isaac is prompted with a rhythm minigame upon entering a room with enemies",
			"Firing tears with the correct timing will deal damage to all enemies in the room",
			"{{Damage}} The more successful notes hit, the more damage it will do"
		},
		Golden = {
			Description = {
				"Damage is increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.TOP_ROCK] = {
		_descType = "trinket",
		Name = "꼭대기 돌덩이",
		QuoteDesc = "이제 내려갈 일만 남았어",
		Description = [[
			↑ {{SpeedSmall}}이동속도 +0.2
			↑ {{TearsSmall}}연사 +0.14
			↑ {{DamageSmall}}공격력 +0.5
			↑ {{RangeSmall}}사거리 +1.25
			↑ {{ShotspeedSmall}}탄속 +0.5
			↑ {{LuckSmall}}행운 +2
			!!! 소지 중일 때 능력치가 상승하지 않습니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +0.2 Speed",
			"↑ +0.14 Tears",
			"↑ +0.5 Damage",
			"↑ +1.25 Range",
			"↑ +0.5 Shot speed",
			"↑ +2 Luck",
			"↓ Prevents stats from being increased while held"
		},
		NoOverclockEffect = true,
	},
	--#endregion
	--#region RELOADED ROCKS
	[TRINKET..FiendFolio.ITEM.ROCK.CHUNK_OF_GALLIUM] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Slow}} 15%의 확률로 눈물이 적을 느려지게 하는 장판을 생성합니다.
			{{LuckSmall}} 행운 20+일 때 45%
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"15% chance to fire a grey tear that leaves behind a trail of slowing creep",
			"{{Luck}} 45% chance at 20 luck"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {15, 30, 45, 60},
				TargetNumbers = {15},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ONION_ROCK] = { -- TODO
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			공격키로 던질 수 있는 Brickmin 패밀리어를 소환합니다.
			{{Blank}} 
			방 4개 클리어 시마다 Brickmin 패밀리어가 추가로 등장합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Spawns Brickmin familiars that can be aimed and launched while nearby",
			"There are 3 different Brickmin which have different effects and behaviors",
			"Brickmin will be gained every 4 rooms cleared"
		},
		Golden = {
			Description = {
				"Maximum number of Brickmin per floor increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.PAPERWEIGHT] = {
		_descType = "trinket",
		Name = "종이 클립",
		QuoteDesc = "",
		Description = [[
			열쇠가 필요한 모든 상자를 열쇠 소모 없이 열 수 있습니다.
			{{Trinket]]..FiendFolio.ITEM.ROCK.POCKET_SAND..[[}} 5회 사용 후 10%의 확률로 Pocket Sand로 바뀝니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Grants the ability to bash open chests without paying any costs",
			"{{Trinket" ..
				FiendFolio.ITEM.ROCK.POCKET_SAND .. "}} 10% chance to break into Pocket Sand after using 5 times"
		},
		Golden = {
			Description = {
				"Never breaks"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SHROOMITE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			주기적으로 적이 있는 방향으로 음파형 방향으로 눈물을 발사합니다.
			{{Confusion}} 음파형 방향 눈물은 20%의 확률로 적에게 혼란을 겁니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Periodically fires wavy tears at random enemies",
			"{{Confusion}} 20% chance for these tears to inflict Confusion"
		},
		Golden = {
			TargetMultipliers = {20}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.AZERITE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{ffGrind}} 다른 석기류 채굴 시 능력치 소량 증가 (최대 20회)
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{ffGrind}} {{ColorTransform}}Grind effect",
			"Grinding other held rocks in the Mining Machine grants a minor stat up",
			"Isaac can be granted stats up to 20 times",
		},
		Golden = {
			TargetMultipliers = {20}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GRAVEL] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{ffGrind}} {{ffCrush}} 다른 석기류 채굴 혹은 분해 시 그 스테이지에서:
			공격방향으로 작은 자갈을 발사합니다.
			발사하는 자갈의 수는 그 스테이지에서 채굴/분해한 석기류 수에 비례합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{ffGrind}} {{ColorTransform}}Grind effect",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"Grinding or Crushing other held rocks grants a rock spray attack",
			"The rock spray attack stacks the more rocks Crushed or Grinded",
			"Rock spray resets each floor"
		},
		Golden = {
			Description = {
				"Rock spray deals more damage"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.PIG_IRON] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Coin}} 동전으로 아이템 구매 시 구매 금액의 25%만큼 지급합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Coin}} Buying an item from the shop will refund back 25% of its cost"
		},
		Golden = {
			-- Do this instead of a mult so that we can set a cap
			TargetAdditives = {
				AdditiveValues = {25, 50, 50, 50},
				TargetNumbers = {25}
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ROCKY] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			프레임 당 0.3%의 확률로 적이 빛납니다.
			캐릭터가 빛나는 적을 바라보는 동안:
			>>> {{TearsSmall}} 연사 증가
			>>> {{DamageSmall}} 공격력 배율 x1.5
			>>> {{LuckSmall}} 행운 +3
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"0.3% chance every tick in an uncleared room for a random enemy to glow",
			"{{Damage}} While looking at a glowing enemy:",
			"↑ x1.5 Damage",
			"↑ x0.85 Fire rate",
			"↑ +3 Luck"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {0.1, 0.2, 0.3, 0.4},
				TargetNumbers = {0.3},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.FULGURITE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Collectible494}} 20%의 확률로 전류 공격이 나갑니다.
			{{LuckSmall}} 행운 25+일 때 50%
			{{ffGrind}} {{ColorYellow}}채굴:{{CR}} 소지 중인 액티브를 강제로 완충시킵니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Collectible494}} 20% chance to fire electric tears that spawn a spark of electricity on impact",
			"{{Luck}} 50% chance at 25 luck",
			"{{ffGrind}} {{ColorTransform}}Grind effect",
			"Grinding this rock in the Mining Machine will overcharge all held actives"
		},
		Golden = {
			TargetMultipliers = {20}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.FURNACE_ROCK] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Collectible289}} 공격 시 6%의 확률로 불꽃을 날립니다.
			{{LuckSmall}} 행운 16+일 때 50%
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Collectible289}} 6% chance to shoot a red fire that blocks enemy shots and deals contact damage",
			"{{Luck}} 50% chance at 16 luck"
		},
		Golden = {
			Description = {
				"Fire damage is increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.MALACHITE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			챔피언 몬스터가 1.5배의 피해를 받습니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Champion enemies take 1.5x damage"
		},
		Golden = {
			TargetAdditives = {
				TargetNumbers = {1.5},
				AdditiveValues = {0.5, 1, 1.5, 2}
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ONYX] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Heart}} 빨간하트 픽업 등장 시:
			>>> {{BlackHeart}} [60%] 블랙하트로 변경
			>>> {{SoulHeart}} [20%] 소울하트로 변경
			>>> {{EmptyHeart}} [20%] 등장하지 않음
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{BlackHeart}} 60% chance for Soul Hearts to become Black Hearts",
			"{{SoulHeart}} 20% chance for Red Hearts to become Soul Hearts",
			"!!! Red Hearts disappear if not converted"
		},
		Golden = {
			Description = {
				"Chances are increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.FISH_ROCK] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			장애물 파괴 시 35%의 확률로 아군 자폭 파리를 소환합니다.
			아군 자폭 파리가 35%의 확률로 2배로 소환됩니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"35% chance to spawn a blue fly upon breaking a rock",
			"35% chance to double any blue flies spawned"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {15, 30, 45, 60},
				TargetNumbers = {35},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.HELLVITE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{DamageSmall}} 적 처치 시 공격력 +0.02
			!!! 패널티 피격 시 사라집니다.
			흡수 시 장신구가 사라지지 않으나 공격력이 더 이상 증가하지 않습니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +0.02 Damage whenever Isaac kills an enemy",
			"Taking damage will cause the rock to disappear",
			"Smelting the rock will prevent the rock from disappearing, but also prevent gaining further damage"
		},
		Golden = {
			TargetMultipliers = {0.02}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.BOOSTER_ROCK] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			방 입장 시 그 방에서 아래 중 하나 증가:
			>>> {{SpeedSmall}} 이동속도 +0.22
			>>> {{TearsSmall}} 연사 +0.5
			>>> {{DamageSmall}} 공격력 +0.7
			>>> {{RangeSmall}} 사거리 +2
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ Grants a randomly chosen stat buff each room"
		},
		Golden = {
			Description = {
				"Stat buffs are increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ROCKETTE_DRAGOON] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Chargeable}} 충전 공격 시 가장 가까운 적에게 탄환을 2발 발사합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Chargeable}} Gain a charge attack that fires 2 bullets at the nearest enemy"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {1, 2, 3, 4},
				TargetNumbers = {2}
			},
			Description = {
				"Bullet damage increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.ETERNAL_CRYSTAL] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{EternalHeart}} 이터널하트 소지 중일 때:
			>>> {{TearsSmall}} 연사 +0.5
			>>> {{DamageSmall}} 공격력 +1
			{{EternalHeart}} 짝수 스테이지 진입 시 이터널하트를 소환합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"While Isaac has an Eternal Heart:",
			"↑ +1 Damage",
			"↑ +0.5 Tears",
			"{{EternalHeart}} Spawns an Eternal Heart at the start of every second floor"
		},
		Golden = {
			TargetMultipliers = {1, 0.5}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.TRIANGULAR_GEM] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			적 3회째 명중 시마다 33%의 확률로 적 주변을 도는 공격력 x1.33의 눈물 3개를 소환합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Every 3rd hit on an enemy, 33% chance to spawn 3 rotating tears around it that deal 1.33x Isaac's damage"
		},
		Golden = {
			TargetMultipliers = {33}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.QUICKSILVER] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Timer}} 방 입장 시 4초간:
			>>> {{SpeedSmall}} 이동속도 +2
			>>> {{TearsSmall}} 연사 +0.55
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{Timer}} When entering a room, for the first 4 seconds, Isaac has:",
			"↑ +0.55 Tears",
			"↑ +2 Speed"
		},
		Golden = {
			TargetMultipliers = {4}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.NON_EUCLIDEAN_ROCK] = { -- TODO
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{CurseMazeSmall}} 스테이지 진입 시 Maze 저주에 걸립니다.
			{{CurseMazeSmall}} 저주에 의해 다른 방으로 이동할 시:
			>>> {{DamageSmall}} 그 스테이지에서 공격력 +0.4
			>>> {{TearsSmall}} 그 방에서 연사 +0.4
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"{{CurseMazeSmall}} Guarantees Curse of the Maze on the next floor",
			"When Isaac is moved by Curse of the Maze, he gains:",
			"↑ +0.4 Damage for the floor",
			"↑ +0.4 Tears for the room",
			"{{Damage}} Damage bonus is multiplied by 2 for the room",
			"Either a penny, bomb, key, or half a red heart if Isaac can be healed"
		},
		Golden = {
			TargetMultipliers = {0.4}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.MIRROR_SLATE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			버리거나 교체할 시 그 방의 적에게 40의 피해를 줍니다.
			>>> {{BlackHeart}} 66%의 확률로 장신구가 깨지며 블랙하트를 드랍합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Deals 40 damage to all enemies when dropped",
			"Has a 66% chance to break when dropped and spawn a black heart"
		},
		Golden = {
			Description = {
				"Damage is increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.HAMMER_HEAD] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{DamageSmall}} 장애물 파괴 시 그 방에서 공격력 +0.3
			장애물 파괴 시 적에게 피해를 주는 돌덩이 눈물이 떨어집니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"↑ +0.3 Damage for the room when a rock is destroyed",
			"Rocks will break into low ranged rock tears when destroyed"
		},
		Golden = {
			Description = {
				"Damage bonus is increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.URANIUM] = { -- TODO
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			피격 시 25%의 확률로 사라지는 하트를 드랍합니다.
			{{ffRadiation}} 방사능 저항 증가
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Taking damage has a 25% chance to drop a temporary heart",
			"{{ffRadiation}} Increased resistance to radiation"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {15, 30, 45, 60},
				TargetNumbers = {25}
			},
			Description = {
				"Resistance to radiation is increased further"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SACRED_SOIL] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			내려놓은 상태에서 오라를 발산합니다.
			오라 안에 있는 동안:
			>>> {{TearsSmall}} 연사 배율 x2.5
			>>> {{DamageSmall}} 공격력 배율 x1.2
			>>> 공격이 적에게 유도되며 확률적으로 피해를 막아줍니다.
			{{ffGrind}} {{ColorYellow}}채굴:{{CR}} 등장 확률이 낮은 석기류가 등장합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
		Tests = {
			"{{ffRock}} {{ColorTransform}}Rock Trinket (Rock)",
			"Dropping the trinket creates a white aura",
			"While inside the aura:",
			"↑ x2.5 Fire rate multiplier",
			"↑ x1.2 Damage multiplier",
			"Homing tears",
			"Chance to block damage",
			"{{ffGrind}} {{ColorTransform}}Grind effect",
			"Always spawns a rare trinket when grinded in the Mining Machine"
		},
	},
	--#endregion
	--#region REHEATED FOSSIL
	[TRINKET..FiendFolio.ITEM.ROCK.BREAKFAST_FOSSIL] = {
		_descType = "trinket",
		Name = "아침밥 화석",
		QuoteDesc = "체력 증가 + 분해 보너스",
		Description = [[
			{{ffCrush}} {{ColorRed}}분해:{{CR}} {{Heart}} 최대 체력 +1
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"↑ +1 Health when crushed by the Bismuth Beggar"
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SACK_FOSSIL] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{GrabBag}} 픽업 아이템을 10%의 확률로 픽업 자루로 바꿉니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} {{GrabBag}} 픽업 자루 드랍
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"{{GrabBag}} 10% chance for random pickups to become sacks",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"{{GrabBag}} Spawns a sack when crushed by the Bismuth Beggar",
		},
		Golden = {
			TargetMultipliers = {10}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.COPROLITE_FOSSIL] = {
		_descType = "trinket",
		Name = "코프롤라이트",
		QuoteDesc = "똥 아티팩트 + 분해 보너스",
		Description = [[
			방 최초 입장 시 파란 아군 자폭 파리를 하나 소환합니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 파란 아군 자폭 파리 12마리 소환
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"Spawns a 1 blue fly for each new room entered",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"Spawns 12 blue flies when crushed by the Bismuth Beggar",
		},
		Golden = {
			TargetMultipliers = {1}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.BEETER_FOSSIL] = {
		_descType = "trinket",
		Name = "벌꿀 화석",
		QuoteDesc = "벌꿀맛 호박 + 분해 보너스",
		Description = [[
			눈물을 발사할 때마다 다른 방향으로 공격력 x0.3의 눈물을 발사합니다.
			눈물은 시계방향으로 서서히 돌아가면서 발사됩니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 아군 Beeter 소환
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"Every tear fired fires an additional weaker tear that spreads evenly around Isaac",
			"This tear deals 0.3x Isaac's damage",
			"Extra tears fire in a clockwise angle everytime Isaac shoots",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"{{Charm}} Spawns a friendly Beeter enemy when crushed by the Bismuth Beggar",
		},
		Golden = {
			TargetStrings = {
				"an additional weaker tear",
				"2 additional weaker tears",
				"3 additional weaker tears",
				"4 additional weaker tears",
				"5 additional weaker tears",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.FLY_FOSSIL] = {
		_descType = "trinket",
		Name = "파리 화석",
		QuoteDesc = "영원한 친구 + 분해 보너스",
		Description = [[
			방 최초 입장 시 랜덤 색상의 아군 자폭 파리를 하나 소환합니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 파리 배리어 +1
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"Spawns a Famine Locust for each new room entered",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"Gives a Pretty Fly when crushed by the Bismuth Beggar"
		},
		Golden = {
			TargetStrings = {
				"a Famine Locust",
				"2 Famine Locusts",
				"3 Famine Locusts",
				"4 Famine Locusts",
				"5 Famine Locusts",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GMO_FOSSIL] = {
		_descType = "trinket",
		Name = "GMO 화석",
		QuoteDesc = "보스의 알약 + 분해 보너스",
		Description = [[
			{{Pill}} 보스 처치 시 랜덤 알약 2개를 강제로 사용합니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} {{Pill}} 랜덤 알약 3개 강제 사용
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"{{Pill}} Isaac is forced to consume 2 random pills after beating a boss",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"{{Pill}} Consume 3 random pills when crushed by the Bismuth Beggar"
		},
		Golden = {
			TargetMultipliers = {2}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SWORD_FOSSIL] = {
		_descType = "trinket",
		Name = "검의 화석",
		QuoteDesc = "모든 능력치 증가 + 분해 보너스",
		Description = [[
			↑ {{TearsSmall}}연사 +0.27
			↑ {{DamageSmall}}공격력 +1
			↑ {{RangeSmall}}사거리 +0.75
			↑ {{ShotspeedSmall}}탄속 +0.2
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 위의 상승량 50%만큼 영구 적용
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"↑ +1 Damage",
			"↑ +0.27 Tears",
			"↑ +0.75 Range",
			"↑ +0.20 Shot speed",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"When crushed by the Bismuth Beggar, you gain 50% of the stats from Sword Fossil permanently"
		},
		Golden = {
			TargetMultipliers = {1, 0.27, 0.75},
			TargetStrings = { -- Shot speed is capped
				"0.20",
				"0.40",
				"0.40",
				"0.40",
				"0.40",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.FORTUNE_WORM_FOSSIL] = {
		_descType = "trinket",
		Name = "운세 화석",
		QuoteDesc = "과거에서의 미래 + 분해 보너스",
		Description = [[
			↑ {{ShotspeedSmall}}탄속 +0.2
			↑ {{LuckSmall}}행운 +2
			{{Trinket]]..FiendFolio.ITEM.TRINKET.FORTUNE_WORM..[[}} 1%의 확률로 적에게 명중 시 운세를 보여주는 공격력 x1.05의 포춘쿠키를 발사합니다.
			{{LuckSmall}} 행운 18+일 때 33%
			{{ffCrush}} {{ColorRed}}분해:{{CR}} {{SoulHeart}} 소울하트 드랍 + 랜덤 운세 3개
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"↑ +0.2 Shot speed",
			"↑ +2 Luck",
			"1% chance to fire a fortune worm tear that does x1.05 damage",
			"{{Luck}} 33% chance at 18 luck",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"{{SoulHeart}} Spawns an extra soul heart and displays 3 random fortunes when crushed by the Bismuth Beggar"
		},
		Golden = {
			-- Stat changes are too complicated for EID since you cant do additive + multiplicative + appended descriptions :(
			Description = {
				"Increased chances and stats"
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.PRIMORDIAL_FOSSIL] = {
		_descType = "trinket",
		Name = "원시 화석",
		QuoteDesc = "초보자 키트 + 분해 보너스",
		Description = [[
			{{Collectible317}} 6.66%의 확률로 여러 개의 독성 눈물을 흩뿌리면서 발사합니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} Golem 캐릭터의 시작 장신구 드랍 ({{Trinket]]..FiendFolio.ITEM.ROCK.DIRT_CLUMP..[[}} + {{Trinket]]..FiendFolio.ITEM.ROCK.ROLLING_ROCK..[[}})
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"{{Collectible317}} 7% chance to fire a small barrage of Mysterious Liquid tears",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"Grants Golem's starting rocks when crushed ({{Trinket" ..
				FiendFolio.ITEM.ROCK.DIRT_CLUMP ..
					"}} + {{Trinket" .. FiendFolio.ITEM.ROCK.ROLLING_ROCK .. "}}) by the Bismuth Beggar"
		},
		Golden = {
			TargetMultipliers = {7}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.REROLLIGAN_FOSSIL] = {
		_descType = "trinket",
		Name = "주사위 화석",
		QuoteDesc = "적을 바꾸는 공격 + 분해 보너스",
		Description = [[
			{{Collectible285}} 적 명중 시 10%의 확률로 다른 적으로 바꿉니다.
			{{LuckSmall}} 행운 8+일 때 40%
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 랜덤 유리 주사위 조각 3개 드랍
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"10% chance to shoot a dice tear that rerolls enemies",
			"{{Luck}} 40% chance at 8 luck",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"Spawns 3 random Glass Die when crushed by the Bismuth Beggar"
		},
		Golden = {
			TargetMultipliers = {10}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.FOSSILIZED_FOSSIL] = {
		_descType = "trinket",
		Name = "비옥한 화석",
		QuoteDesc = "화석 복제 + 분해 보너스",
		Description = [[
			소지한 상태에서 다른 화석 타입 장신구 분해시 효과 2배
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 소지 중인 다른 화석류의 분해 효과 발동
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"Fossil crushing effects activate twice",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"Activates the effect of another held fossil when crushed by the Bismuth Beggar"
		},
		Golden = {
			TargetStrings = {
				"twice",
				"3 times",
				"4 times",
				"5 times",
				"6 times",
			},
			OverclockOnly = true,
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.FISH_FOSSIL] = {
		_descType = "trinket",
		Name = "생선 화석",
		QuoteDesc = "쓰레기의 왕 + 분해 보너스",
		Description = [[
			피격 시 파란 아군 자폭 파리를 1~4마리 소환합니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 아군 Portal 몬스터 소환
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"Taking damage spawns 1 to 4 blue flies",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"{{Charm}} Spawns a friendly Portal when crushed by the Bismuth Beggar"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {1, 2, 3, 4},
				TargetNumbers = {4}
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.RUNIC_FOSSIL] = {
		_descType = "trinket",
		Name = "룬 화석",
		QuoteDesc = "연약한 룬 + 분해 보너스",
		Description = [[
			{{Rune}} 룬의 등장 확률이 증가합니다.
			{{Card55}} 룬 사용 시 Rune Shard를 드랍합니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} {{Card55}} Rune Shard 4개 드랍
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"{{Rune}} Runes are more common",
			"Using runes or soul stones drops a rune shard",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"Drops 4 rune shards when crushed by the Bismuth Beggar"
		},
		Golden = {
			TargetStrings = {
				"a rune shard",
				"2 rune shards",
				"3 rune shards",
				"4 rune shards",
				"5 rune shards",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.CANNED_FOSSIL] = {
		_descType = "trinket",
		Name = "취한 화석",
		QuoteDesc = "콩의 위력 + 분해 보너스",
		Description = [[
			피격 시 적을 밀쳐내는 랜덤 방귀를 뀝니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 아군 Litter Bug 소환
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"Isaac farts a random fart when taking damage",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"{{Charm}} Spawns a friendly Charmed Litter bug when crushed by the Bismuth Beggar"
		},
		Golden = {
			Description = {
				"Fart radius of effect increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.BALANCED_FOSSIL] = {
		_descType = "trinket",
		Name = "균형의 화석",
		QuoteDesc = "균형의 방 보상 + 분해 보너스",
		Description = [[
			방 클리어 보상을 50%의 확률로 {{Heart}}/{{Coin}}/{{Key}}/{{Bomb}} 중 0개인 종류로 바꿉니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 가장 적게 소지 중인 픽업 3개 드랍
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"50% chance for the room clear reward to be a pickup Isaac has none of",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"Grants 3 of the lowest owned pickups when crushed by the Bismuth Beggar"
		},
		Golden = {
			TargetStrings = {
				"none of",
				"a small amount of",
				"a small amount of",
				"a small amount of",
				"a small amount of",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.BURIED_FOSSIL] = {
		_descType = "trinket",
		Name = "묻혀있는 화석",
		QuoteDesc = "땅을 파 봐 + 분해 보너스",
		Description = [[
			{{Bomb}} 스테이지 당 하나씩 바닥에 틈새가 생기고 그 틈새를 폭탄으로 터트릴 시 화석류를 드랍합니다.
			Dark Room 스테이지의 무덤을 {{Bomb}}폭탄으로 열 수 있습니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 랜덤 화석류 드랍
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"Each floor has a marked spot that can be bombed to spawn a fossil",
			"Dirt patches can be bombed open",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"Gives a random fossil when crushed by the Bismuth Beggar"
		},
		Golden = {
			TargetStrings = {
				"a marked spots",
				"2 marked spots",
				"3 marked spots",
				"4 marked spots",
				"5 marked spots"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.TRIPPY_FOSSIL] = {
		_descType = "trinket",
		Name = "환각 화석",
		QuoteDesc = "허 우워... + 분해 보너스",
		Description = [[
			{{Collectible398}} 13%의 확률로 적을 작아지게 만드는 공격이 나갑니다.
			{{LuckSmall}} 행운 44+일 때 100%
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 캐릭터 크기 축소
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"{{Collectible398}} 13% chance to fire tears that can shrink enemies",
			"{{Luck}} 100% chance at 44 luck",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"Shrinks Isaac when crushed by the Bismuth Beggar"
		},
		Golden = {
			TargetAdditives = {
				TargetNumbers = {13},
				AdditiveValues = {18, 23, 28, 33}
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.MAXS_FOSSIL] = {
		_descType = "trinket",
		Name = "맥스의 화석",
		QuoteDesc = "개 울음소리 + 분해 보너스",
		Description = [[
			{{Collectible445}} {{SecretRoom}}{{SuperSecretRoom}}비밀방이 연결되어 있을 경우 개 울음소리가 납니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 이후 등장하는 색독이 밝혀짐
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"{{Collectible445}} A wolf howls in rooms adjacent to a Secret/Super Secret Room",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"When crushed by the Bismuth Beggar, the next tinted rock Isaac encounters is revealed"
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.BOMB_SACK_FOSSIL] = {
		_descType = "trinket",
		Name = "폭탄자루 화석",
		QuoteDesc = "지진파 폭발 + 분해 보너스",
		Description = [[
			{{Bomb}} 폭탄이 터지면 폭탄 주위에 충격파를 일으킵니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} {{Bomb}} 폭탄 3개 드랍
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"{{Bomb}} Bombs create a ring of rock waves",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"{{Bomb}} Spawns 3 bombs when crushed by the Bismuth Beggar"
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.DEATH_CAP_FOSSIL] = {
		_descType = "trinket",
		Name = "똥모자 화석",
		QuoteDesc = "아직 효력이 있어 + 분해 보너스",
		Description = [[
			↓ 방 클리어 시마다 모든 능력치가 감소합니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 감소량에 비례하여 능력치가 영구적으로 증가
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"↓ Minor stats down on each room cleared",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"↑ All stats up when crushed by the Bismuth Beggar",
			"↑ Stats ups are proportional to how many rooms cleared"
		},
		Golden = {
			Description = {
				"Stats are increased or decreased more"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.EXPLOSIVE_FOSSIL] = {
		_descType = "trinket",
		Name = "폭발성 화석",
		QuoteDesc = "더 많은 폭탄 + 분해 보너스",
		Description = [[
			{{Bomb}} 방 클리어 시 13%의 확률로 폭탄을 추가로 드랍합니다.
			장애물이 20%의 확률로 폭탄 돌덩이로 바뀝니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} {{Collectible483}} 이후 클리어하지 않은 3개의 방에 Mama Mega 폭발
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"{{Bomb}} 13% chance for an extra bomb to drop on room clear",
			"20% chance for rocks to be replaced with bomb rocks",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"{{Collectible483}} When crushed by the Bismuth Beggar, the next 3 uncleared rooms will be affected by a Mama Mega explosion"
		},
		Golden = {
			TargetAdditives = {
				TargetNumbers = {13},
				AdditiveValues = {5, 10, 15, 20}
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.COLOSSAL_FOSSIL] = {
		_descType = "trinket",
		Name = "거대 화석",
		QuoteDesc = "여러 개의 분해 보너스",
		Description = [[
			{{TearsizeSmall}} 눈물 크기 x2
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 랜덤 화석류 3개의 효과 발동
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"↑ Doubles tear size",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"Activates 3 random fossil effects when crushed by the Bismuth Beggar"
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SKUZZ_FOSSIL] = {
		_descType = "trinket",
		Name = "벼룩 화석",
		QuoteDesc = "영원한 친구 + 분해 보너스",
		Description = [[
			{{Slow}} 방 입장 시 적을 느려지게 하는 보라색 아군 벼룩을 2~3마리 소환합니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 아군 자폭 벼룩 5~7마리 소환
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"Spawn 2 to 3 purple skuzzes each time an active room is entered",
			"{{Slow}} This skuzz deals 3x Isaac's damage and slows enemies",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"Spawns 5 to 7 blue skuzzes when crushed by the Bismuth Beggar"
		},
		Golden = {
			TargetAdditives = {
				TargetNumbers = {2, 3},
				AdditiveValues = {1}
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.FOSSILIZED_BLESSING] = {
		_descType = "trinket",
		Name = "골렘의 축복",
		QuoteDesc = "에덴의 축복 + 분해 보너스",
		Description = [[
			↑ {{TearsSmall}}연사 +0.4
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 다음 게임 시작 시 랜덤 석기류 추가
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"↑ +0.4 Tears",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"Grants a random rock trinket at the start of the next run when crushed by the Bismuth Beggar"
		},
		Golden = {
			TargetMultipliers = {0.4}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.PETRIFIED_SOCK] = {
		_descType = "trinket",
		Name = "굳은 양말",
		QuoteDesc = "딱딱한 눈물 + 분해 보너스",
		Description = [[
			{{Petrify}} 10%의 확률로 적을 석화시키는 공격이 나갑니다.
			{{LuckSmall}} 행운 45+일 때 100%
			{{ffCrush}} {{ColorRed}}분해:{{CR}} {{Card92}} 랜덤 패밀리어 획득
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"10% chance to shoot petrifying tears",
			"{{Luck}} 100% chance at 45 luck",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"Grants a random baby familiar when crushed by the Bismuth Beggar"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {5, 10, 15, 20},
				TargetNumbers = {10}
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.MOLTEN_FOSSIL] = {
		_descType = "trinket",
		Name = "녹아내리는 화석",
		QuoteDesc = "녹아내린 분해 보너스",
		Description = [[
			흡수한 정동류의 효과를 15% 강화시킵니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 랜덤 석기류 획득 + 흡수
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"↑ Improves the effectiveness of smelted rock trinkets by 15%",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"Grants and smelts a random common rock when crushed by the Bismuth Beggar"
		},
		Golden = {
			Description = {
				"Improves effectiveness of smelted rock trinkets even more"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.VALUE_FOSSIL] = {
		_descType = "trinket",
		Name = "가치있는 화석",
		QuoteDesc = "상점 할인 + 분해 보너스",
		Description = [[
			{{Shop}} 상점의 판매 가격을 1{{Coin}} 할인합니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} {{Coin}} 동전 3개 드랍
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"{{Coin}} Shop items are one cent cheaper",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"{{Coin}} Spawns 3 pennies when crushed by the Bismuth Beggar"
		},
		Golden = {
			TargetStrings = {
				"one cent",
				"2 cents",
				"3 cents",
				"4 cents",
				"5 cents"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.CORAL_FOSSIL] = {
		_descType = "trinket",
		Name = "코랄 화석",
		QuoteDesc = "뭔가 물에 찬 느낌 + 분해 보너스",
		Description = [[
			↑ {{HealingRed}}빨간하트 +1
			공격 시 25%의 확률로 X자 방향의 눈물을 추가로 발사합니다.
			{{LuckSmall}} 행운 75+일 때 100%
			{{ffCrush}} {{ColorRed}}분해:{{CR}} {{HealingRed}}+1, 아군 Drowned Charger 3마리 소환
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"25% chance to fire 4 tears in an X shape",
			"{{Luck}} 100% chance at 75 luck",
			"{{Heart}} Heals 1 Red Heart on pickup",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"{{Charm}} Spawns 3 friendly drowned chargers and heals a heart when crushed by the Bismuth Beggar"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {10, 20, 30, 40},
				TargetNumbers = {25}
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.NECROMANTIC_FOSSIL] = {
		_descType = "trinket",
		Name = "네크로 화석",
		QuoteDesc = "죽음으로부터 되돌려라 + 분해 보너스",
		Description = [[
			적 처치 시 20%의 확률로 캐릭터의 주위를 도는 뼛조각을 소환합니다.
			{{LuckSmall}} 행운 20+일 때 40%
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 현재 게임에서 분해한 석기류 하나 드랍
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"20% to spawn a bone orbital when killing an enemy",
			"{{Luck}} 40% chance at 20 luck",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"Grants a fossil that has been crushed this run when crushed by the Bismuth Beggar"
		},
		TargetMultipliers = {20}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.BRAIN_FOSSIL] = {
		_descType = "trinket",
		Name = "두뇌 화석",
		QuoteDesc = "잠깐동안의 유도 + 분해 보너스",
		Description = [[
			공격이 잠시동안 적에게 유도됩니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} {{Card1}} The Magician 카드 드랍
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"Tears fired briefly have homing",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"{{Card}} Spawns a Magician card when crushed by the Bismuth Beggar"
		},
		Golden = {
			Description = {
				"Homing lasts longer"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.REFUND_FOSSIL] = {
		_descType = "trinket",
		Name = "흥정 화석",
		QuoteDesc = "모래 채굴 무료 + 분해 보너스",
		Description = [[
			{{Trinket]]..FiendFolio.ITEM.ROCK.POCKET_SAND..[[}} 다른 화석류 분해 시 Pocket Sand 추가 드랍
			{{ffCrush}} {{ColorRed}}분해:{{CR}} {{Trinket]]..FiendFolio.ITEM.ROCK.POCKET_SAND..[[}} Pocket Sand 2개 드랍
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"{{Trinket" ..FiendFolio.ITEM.ROCK.POCKET_SAND .."}} Crushing other fossils in the Mining Machine grants Pocket Sand",
			"{{ffGrind}} {{ColorTransform}}Grind effect",
			"Pocket Sand can be grinded for free in the Mining Machine when holding this fossil",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"Spawns 2 Pocket Sands when crushed by the Bismuth Beggar"
		},
		Golden = {
			TargetMultipliers = {2},
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.LEFT_FOSSIL] = {
		_descType = "trinket",
		Name = "왼손목",
		QuoteDesc = "어둠의 보상을 거두어들이다 + 분해 보너스",
		Description = [[
			{{Trinket61}} {{RedChest}}모든 상자가 빨간상자로 교체됩니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} {{RedChest}} 빨간상자 소환
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"{{RedChest}} Turns all chests into Red Chests",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"{{RedChest}} Spawns a Red Chest when crushed by the Bismuth Beggar"
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.THANK_YOU_FOSSIL] = {
		_descType = "trinket",
		Name = "감사의 화석",
		QuoteDesc = "풍성한 거지 + 분해 보너스",
		Description = [[
			거지가 픽업을 2배로 보답합니다.
			!!! (패시브/액티브 보상은 미적용)
			{{ffCrush}} {{ColorRed}}분해:{{CR}} {{Card9}} Judgement 카드 드랍
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"{{Beggar}} Beggars pay out their rewards twice",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"{{Card}} Spawns a Judgement card when crushed by the Bismuth Beggar"
		},
		Golden = {
			TargetStrings = {
				"twice",
				"3 times",
				"4 times",
				"5 times",
				"6 times",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.HOLLOW_FOSSIL] = {
		_descType = "trinket",
		Name = "공허의 화석",
		QuoteDesc = "암흑의 기운이 담겨 있어 + 분해 보너스",
		Description = [[
			↑ {{DamageSmall}}공격력 +1.35
			{{ffCrush}} {{ColorRed}}분해:{{CR}} {{BlackHeart}}블랙하트를 대신 드랍, 그 스테이지의 악마방 확률 100%
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"↑ +1.35 Damage",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"Guarantees a Devil/Angel Room and spawns a Black Heart when crushed by the Bismuth Beggar"
		},
		Golden = {
			TargetMultipliers = {1.35}
		}
	},
	--#endregion
	--#region RELOADED FOSSIL
	[TRINKET..FiendFolio.ITEM.ROCK.ELEPHANT_FOSSIL] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{EmptyBoneHeart}} 빈 뼈하트가 2번 피격 시에 부서집니다.
			1번 피격 후 상태는 해당 하트 회복 시 복원됩니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 거대한 아군 Bony를 하나 소환합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"{{EmptyBoneHeart}} Bone hearts take one extra hit before breaking",
			"This hit is restored whenever the bone heart is filled",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"{{Charm}} Spawns a giant friendly bony when crushed by the Bismuth Beggar"
		},
		Golden = {
			TargetStrings = {
				"one extra hit",
				"2 extra hits",
				"3 extra hits",
				"4 extra hits",
				"5 extra hits"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GOLDEN_FOSSIL] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{GoldenChest}} 낡은상자, 메가상자를 제외한 모든 상자가 황금상자로 교체됩니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} {{GoldenChest}} 황금상자를 하나 드랍합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"{{GoldenChest}} Replaces all chests with golden chests",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"{{GoldenChest}} Spawns a golden chest when crushed by the Bismuth Beggar"
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.FOSSILIZED_COIN] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Coin}} 페니가 15%의 확률로 니켈로, 7%의 확률로 다임으로 바뀝니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 상점 상자를 소환합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"{{ffFossil}} {{ColorTransform}}Rock Trinket (Fossil)",
			"{{Coin}} 15% chance to upgrade pennies to nickels",
			"7% chance to upgrade to dimes",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
			"Spawns a shop chest when crushed by the Bismuth Beggar"
		},
		Golden = {
			Description = {
				"Increased chances"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.FOSSILIZED_EYE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Card}} 카드 픽업이 앞면 상태로 보여집니다.
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 아군 Bloodshoy eye를 소환합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
		},
		Tests = {
			"Card fronts will be visible even when dropped",
			"{{ColorTransform}}{{ffCrush}} Crush effect",
							"Spawns a friendly bloodshot eye",
		},
	},
	--#endregion
	--#region REHEADED GEODE
	[TRINKET..FiendFolio.ITEM.ROCK.CURVED_GEODE] = {
		_descType = "trinket",
		Name = "굽은 정동",
		QuoteDesc = "공격력 증가 + 정동 보너스",
		Description = [[
			↑ {{DamageSmall}}공격력 +1
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} {{DamageSmall}} 추가 공격력 +0.5
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"↑ +1 Damage",
			"↑ Bonus +0.5 Damage if holding another Geode"
		},
		Golden = {
			TargetMultipliers = {1}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.HAUNTED_GEODE] = {
		_descType = "trinket",
		Name = "유령의 정동",
		QuoteDesc = "유령 공격 + 정동 보너스",
		Description = [[
			20%의 확률로 적과 장애물을 관통하는 공격이 나갑니다.
			{{LuckSmall}} 행운 40+일 때 100%
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 확률 증가
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"20% chance to fire a spectral and piercing tear",
			"{{Luck}} 100% chance at 40 luck",
			"↑ Increased chance if holding another Geode"
		},
		Golden = {
			TargetMultipliers = {20}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.HEALTH_GEODE] = {
		_descType = "trinket",
		Name = "체력의 정동",
		QuoteDesc = "두번째 기회 + 정동 보너스",
		Description = [[
			!!! 일회용
			전체 체력이 빨간하트 1칸 이하일 때 {{Heart}}체력을 전부 회복합니다.
			!!! 최대 체력이 1칸일 경우 빨간하트 반칸일 때 발동
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} {{SoulHeart}} 회복 시 추가 소울하트 +1
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"{{Heart}} When Isaacs drops to 1 red heart or less, heals red hearts and breaks",
			"{{SoulHeart}} +1 Soul Heart when the rock breaks if holding another Geode"
		},
		Golden = {
			TargetStrings = {
				"+1 Soul Heart",
				"+2 Soul Hearts",
				"+3 Soul Hearts",
				"+4 Soul Hearts",
				"+5 Soul Hearts",
			},
			GoldOnly = true
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.LITTLE_GEODE] = {
		_descType = "trinket",
		Name = "작은 정동",
		QuoteDesc = "크기 감소 + 정동 보너스",
		Description = [[
			캐릭터의 크기가 작아집니다.
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 캐릭터 크기 추가 감소
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"Decreases Isaac's size",
			"↑ Bonus size down if holding another Geode"
		},
		Golden = {
			Description = {
				"Size decreased further"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.QUICK_GEODE] = {
		_descType = "trinket",
		Name = "신속의 정동",
		QuoteDesc = "재빠른 탐색 + 정동 보너스",
		Description = [[
			{{SpeedSmall}} 클리어한 방에서 이동속도가 최소 1.75 이상으로 고정됩니다.
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} {{SpeedSmall}} 이동속도 +0.1
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"↑ Boosts Speed to 1.75 in cleared rooms",
			"↑ Bonus +0.10 Speed if holding another Geode"
		},
		Golden = {
			TargetStrings = {
				"1.75",
				"1.85",
				"1.85",
				"1.85",
				"1.85",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.WEBBY_GEODE] = {
		_descType = "trinket",
		Name = "거미 정동",
		QuoteDesc = "둔화 공격 + 정동 보너스",
		Description = [[
			{{Slow}} 20%의 확률로 적을 둔화시키는 공격이 나갑니다.
			{{LuckSmall}} 행운 40+일 때 100%
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 둔화된 적이 흰색 장판을 남김
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"{{Slow}} 20% chance to shoot slowing tears",
			"{{Luck}} 100% chance at 40 luck",
			"↑ Enemies hit by slowing tears leave white slowing creep if holding another Geode"
		},
		Golden = {
			TargetMultipliers = {20}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.LUCKY_GEODE] = {
		_descType = "trinket",
		Name = "행운의 정동",
		QuoteDesc = "행운 증가 + 정동 보너스",
		Description = [[
			↑ {{LuckSmall}}행운 +1
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} {{LuckSmall}} 추가 행운 +2
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"↑ +1 Luck",
			"↑ Bonus +2 Luck if holding another Geode"
		},
		Golden = {
			TargetMultipliers = {2}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.PHLEGMY_GEODE] = {
		_descType = "trinket",
		Name = "가래 정동",
		QuoteDesc = "접착 공격 + 정동 보너스",
		Description = [[
			10%의 확률로 접착 눈물이 나갑니다.
			{{LuckSmall}} 행운 90+일 때 100%
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} {{Slow}} 접착 눈물이 적을 둔화시킵니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"10% chance to shoot a sticky booger tear",
			"{{Luck}} 100% chance at 90 luck",
			"{{Slow}} Booger tears slow down enemies if holding another Geode"
		},
		Golden = {
			TargetMultipliers = {10}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.LOB_GEODE] = {
		_descType = "trinket",
		Name = "로브 정동",
		QuoteDesc = "공성 공격 + 정동 보너스",
		Description = [[
			↑ {{RangeSmall}}사거리 +1
			눈물을 곡선형으로 발사합니다.
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} {{RangeSmall}} 추가 사거리 +0.5
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"↑ +1 Range",
			"Tears are now shot in an arc",
			"↑ Bonus +0.5 Range if holding another Geode"
		},
		Golden = {
			TargetMultipliers = {1}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SODALITE_GEODE] = {
		_descType = "trinket",
		Name = "소달라이트",
		QuoteDesc = "치명타 공격 + 정동 보너스",
		Description = [[
			4%의 확률로 공격력 x5의 피해를 주는 치명타 공격이 나갑니다.
			{{LuckSmall}} 행운 11+일 때 33%
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 치명타 확률 증가
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"4% chance to shoot purple critical tears that deal x5 damage",
			"{{Luck}} 33% chance at 11 luck",
			"↑ Increased chance if holding another Geode"
		},
		Golden = {
			TargetMultipliers = {4}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.PLACEBEODE] = {
		_descType = "trinket",
		Name = "위약 정동",
		QuoteDesc = "흡수 시 정동 보너스",
		Description = [[
			무효과
			{{ffGeode}} 흡수 시 다른 정동류에 추가 공명 효과를 줍니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"Removes the requirement for Geodes to be held in both trinket slots if smelted"
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.WARM_GEODE] = {
		_descType = "trinket",
		Name = "따뜻한 정동",
		QuoteDesc = "불의 힘 + 정동 보너스",
		Description = [[
			캐릭터가 불 주변에 있을 때:
			>>> {{DamageSmall}} 공격력 +4
			>>> {{ShotspeedSmall}} 탄속 +0.2
			따뜻한 스테이지일 때:
			>>> {{DamageSmall}} 공격력 +2
			>>> {{ShotspeedSmall}} 탄속 +0.2
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} {{DamageSmall}} 불 주변에 있을 때 추가 공격력 +5
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"When near a fireplace:",
			"↑ +4 Damage",
			"↑ +0.2 Shot speed",
			"Warm floors give:",
			"↑ +2 Damage",
			"↑ +0.2 Shot speed",
			"↑ Bonus +5 Damage and fire tears when standing next to a fireplace if holding another Geode"
		},
		Golden = {
			TargetMultipliers = {
				"4",
				"0.2",
				"2",
				"5"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.CHAIN_GEODE] = {
		_descType = "trinket",
		Name = "연쇄 정동",
		QuoteDesc = "연쇄적 장애물 파괴 + 정동 보너스",
		Description = [[
			장애물 파괴 시 40%의 확률로 인접한 장애물을 파괴합니다.
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 추가 장애물 파괴 확률 +30%p
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 20%의 확률로 인접한 구덩이를 메움
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"Rocks that are destroyed have a 40% chance to break adjacent rocks",
			"↑ Increased chance to 70% when holding another Geode",
			"↑ Pits adjacent to other rocks also have a 20% chance to be filled in if holding another Geode"
		},
		Golden = {
			Description = {
				"Chances increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.RUSTY_GEODE] = {
		_descType = "trinket",
		Name = "녹슨 정동",
		QuoteDesc = "식어가는 욕망 + 정동 보너스",
		Description = [[
			{{DamageSmall}} 증발성 공격력 +8
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 공격력 증발 속도 감소
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"↑ +8 Damage",
			"The damage wears off over 2 minutes and 13 seconds",
			"↑ The damage decays at a slower rate if holding another Geode"
		},
		Golden = {
			TargetMultipliers={8}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.FRAGMENTED_ONYX_GEODE] = {
		_descType = "trinket",
		Name = "오닉스 조각",
		QuoteDesc = "공포 공격 + 정동 보너스",
		Description = [[
			{{Fear}} 10%의 확률로 적을 도망가게 하는 공격이 나갑니다.
			{{LuckSmall}} 행운 26+일 때 100%
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 공포 공격 확률 증가
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 공포 상태의 적에게 악마방 확률에 따른 추가 피해
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"{{Fear}} 10% chance to shoot fear tears",
			"{{Luck}} 100% chance at 26 luck",
			"↑ Increased chance if holding another Geode",
			"{{DevilRoom}} Enemies inflicted with fear take extra damage based on the Devil Deal chance if holding another Geode"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues={5, 10, 15, 20},
				TargetNumbers={10},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.QUANTUM_GEODE] = {
		_descType = "trinket",
		Name = "양자 정동",
		QuoteDesc = "혼란스러운 공격 + 정동 보너스",
		Description = [[
			눈물이 3갈래로 나가며 하나를 명중시키면 나머지는 사라집니다.
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 명중 가능 눈물 +1
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"Isaac shoots 3 tears at once",
			"Once a tear hits an enemy, the other 2 tears will vanish",
			"↑ Two tears can land on an enemy if holding another Geode"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {1, 2, 3, 5},
				TargetNumbers = {3, 2}
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.TECHNOLOGICAL_GEODE] = {
		_descType = "trinket",
		Name = "기계 정동",
		QuoteDesc = "주변 레이저 + 정동 보너스",
		Description = [[
			공격방향으로 캐릭터의 공격력 x0.3의 매우 짧은 레이저를 발사합니다.
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 추가 레이저 발사
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"Fires a short ranged laser that deals 30% damage while firing",
			"↑ Fires 2 beams if holding another Geode"
		},
		Golden = {
			Description = {
				"Laser has increased range"
			},
			TargetMultipliers = {30},
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.RUBBER_GEODE] = {
		_descType = "trinket",
		Name = "고무 정동",
		QuoteDesc = "통통 튀는 눈물 + 정동 보너스",
		Description = [[
			{{ffBruise}} 15%의 확률로 적을 멍들게 하는 고무 공격이 나갑니다.
			{{LuckSmall}} 행운 18+일 때 50%
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 확률 및 넉백 강도 증가
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
			"FF_APPEND_BRUISE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"15% chance to fire a bouncing tennis ball tear that inflicts Bruise",
			"{{Luck}} 50% chance at 18 luck",
			"↑ Increased chance and knockback if holding another Geode"
		},
		StatusEffects = {
			mod.DescriptionStatuses.BRUISE
		},
		Golden = {
			TargetAdditives = {
				TargetNumbers = {15},
				AdditiveValues = {5, 10, 15, 20}
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.CALZONE_GEODE] = {
		_descType = "trinket",
		Name = "칼초네 정동",
		QuoteDesc = "처비 발사 + 정동 보너스",
		Description = [[
			{{Bait}} 5%의 확률로 적에게 표식을 걸며 캐릭터에게 다시 돌아오는 처비를 발사합니다.
			{{LuckSmall}} 행운 9+일 때 50%
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 발사 확률 증가
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"5% chance to fire a piercing maggot that charges forward",
			"{{Luck}} 50% chance at 9 luck",
			"{{Bait}} The maggot marks enemies",
			"Marked enemies are targeted by other enemies",
			"↑ Increased chance to fire if holding another Geode"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {5, 10, 15, 20},
				TargetNumbers = {5}
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.TOUGH_GEODE] = {
		_descType = "trinket",
		Name = "딱딱한 정동",
		QuoteDesc = "보존력이 강함 + 정동 보너스",
		Description = [[
			{{ffCrush}} 분해 시 20%의 확률로 소모되지 않고 보존됩니다.
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 보존 확률 증가
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"{{ffCrush}} 20% chance to not destroy a geode when crushed by the Bismuth Beggar",
			"↑ Increased chance if holding another Geode"
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.TIPSY_GEODE] = {
		_descType = "trinket",
		Name = "술취한 정동",
		QuoteDesc = "불안정한 이동 + 정동 보너스",
		Description = [[
			↑ {{DamageSmall}}공격력 +2
			움직임이 불안정해집니다.
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} {{DamageSmall}} 추가 공격력 +1.5, 불안정성 증가
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"↑ +2 Damage",
			"Isaac's movement shifts around erratically",
			"↑ Bonus +1.5 Damage and more intense movements if holding another Geode"
		},
		Golden = {
			TargetMultipliers = {2}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.VINYL_GEODE_A] = {
		_descType = "trinket",
		Name = "비닐 정동 - 앞면",
		QuoteDesc = "양면 능력치 증가 + 정동 보너스",
		Description = [[
			↑ {{DamageSmall}}공격력 +1
			↑ {{ShotspeedSmall}}탄속 +0.24
			짝수 스테이지 진입 시 뒷면으로 뒤집습니다.({{SpeedSmall}}/{{TearsSmall}} 증가)
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} {{SpeedSmall}}+0.07/{{TearsSmall}}+0.2
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"↑ +1 Damage",
			"↑ +0.24 Shot speed",
			"Flips to the B Side on the first floor of a chapter",
			"↑ Bonus +0.07 Speed and +0.2 Tears if holding another Geode"
		},
		Golden = {
			TargetMultipliers = {1, 0.24, 0.07, 0.2}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.VINYL_GEODE_B] = {
		_descType = "trinket",
		Name = "비닐 정동 - 뒷면",
		QuoteDesc = "양면 능력치 증가 + 정동 보너스",
		Description = [[
			↑ {{SpeedSmall}}이동속도 +0.2
			↑ {{TearsSmall}}연사 +0.66
			홀수 스테이지 진입 시 앞면으로 뒤집습니다.({{DamageSmall}}/{{ShotspeedSmall}} 증가)
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} {{DamageSmall}}+0.3/{{ShotspeedSmall}}+0.08
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"↑ +0.2 Speed",
			"↑ +0.66 Tears",
			"Flips to the A Side on the second floor of a chapter",
			"↑ Bonus +0.3 Damage and +0.08 Shot speed if holding another Geode"
		},
		Golden = {
			TargetMultipliers = {0.2, 0.66, 0.3, 0.08}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.PRISMATIC_GEODE] = {
		_descType = "trinket",
		Name = "프리즘 정동",
		QuoteDesc = "무지개빛의 힘 + 정동 보너스",
		Description = [[
			적 처치 시 12%의 확률로 랜덤 능력치를 10초동안 증가시켜주는 프리즘 조각을 드랍합니다.
			방 클리어 시 25%의 확률로 프리즘 조각을 추가로 드랍합니다.
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 능력치 증가량 2배, 지속시간 증가
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"12% chance for enemies to drop Prism Shards on death",
			"↑ Prism Shards boost a random stat for 10 seconds",
			"25% chance for a Prism Shard to appear on room clear",
			"↑ Stat boosts are doubled and duration is increased if holding another geode"
		},
		Golden = {
			TargetMultipliers = {12, 25}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.FRACTAL_GEODE] = {
		_descType = "trinket",
		Name = "프랙탈 정동",
		QuoteDesc = "깊이 보려고 하지 마 + 정동 보너스",
		Description = [[
			{{ffSleeping}} 15%의 확률로 적을 나른하게 만드는 눈물을 회오리 모양으로 발사합니다.
			{{LuckSmall}} 행운 20+일 때 45%
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 33%의 확률로 즉시 잠들게 함
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
			"FF_APPEND_DROWSY",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"15% chance to shoot a spiraling shot that inflicts Drowsy",
			"{{Luck}} 45% chance at 20 luck",
			"↑ Increased chance and enemies have a 33% chance to instantly fall asleep if holding another Geode"
		},
		StatusEffects = { FiendFolio.DescriptionStatuses.DROWSY_AND_SLEEP },
		Golden = {
			TargetAdditives = {
				AdditiveValues = {15, 30, 45, 60},
				TargetNumbers = {15},
			},
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.GMO_GEODE] = {
		_descType = "trinket",
		Name = "GMO 정동",
		QuoteDesc = "잠재성 알약 + 정동 보너스",
		Description = [[
			{{Pill}} 알약 사용 시 랜덤 효과의 알약을 강제로 사용합니다.
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 추가 긍정 알약 효과 발동
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"{{Pill}} Taking a pill will force Isaac to take another pill",
			"↑ Isaac takes an additional positive pill if holding another Geode"
		},
		Golden = {
			TargetStrings = {
				"another pill",
				"2 more pills",
				"3 more pills",
				"4 more pills",
				"5 more pills",
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.SWALLOWED_GEODE] = {
		_descType = "trinket",
		Name = "삼켜진 페니",
		QuoteDesc = "꿀꺽! + 정동 보너스",
		Description = [[
			{{Coin}} 피격 시 동전을 하나 드랍합니다.
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 33%의 확률로 1+1 페니가 드랍됨
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"{{Coin}} Taking damage spawns 1 coin",
			"↑ 33% chance to spawn a double penny instead if holding another Geode"
		},
		Golden = {
			Description = {
				"Chance to spawn a double penny instead even if not holding another Geode"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.VOODOO_GEODE] = {
		_descType = "trinket",
		Name = "부두 정동",
		QuoteDesc = "저주가 곧 힘 + 정동 보너스",
		Description = [[
			{{DamageSmall}} {{CurseCursedSmall}} 저주가 걸려 있는 동안 공격력 +1.5
			{{DamageSmall}} {{CurseRoom}} 저주방 최초 진입 시 그 스테이지에서 공격력 +0.35
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 위의 효과 +50%
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"↑ +1.5 Damage when a curse is present on the floor",
			"↑ +0.35 Damage for the floor when entering a curse room for the first time",
			"{{Damage}} Increases damage bonus by 1.5x if holding another Geode"
		},
		Golden = {
			Description = {
				"Damage bonus is increased"
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.UMBILICAL_GEODE] = {
		_descType = "trinket",
		Name = "탯줄",
		QuoteDesc = "태아 보호 + 정동 보너스",
		Description = [[
			{{Collectible100}} {{HalfHeart}} 방 입장 시 빨간하트가 반칸 이하일 때 Little Steven을 소환합니다.
			{{Collectible318}} 피격 시 30%의 확률로 그 방에서 Gemini 패밀리어를 소환합니다.
			{{LuckSmall}} 행운 35+일 때 100%
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} {{Collectible318}} 확률 증가
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} {{Collectible100}} 빨간하트 1칸일 때에도 등장
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"{{HalfHeart}} Having half a Red Heart or less grants {{Collectible100}} Little Steven",
			"{{Collectible318}} Taking damage has a 30% chance to spawn a Gemini familiar for the room",
			"{{Luck}} 100% chance at 35 luck",
			"↑ Base Gemini spawn chances are improved if holding another Geode",
			"↑ Little Steven can spawn at one heart or less if holding another Geode"
		},
		Golden = {
			TargetAdditives = {
				TargetNumbers = {30},
				AdditiveValues = {15, 30, 45, 60}
			}
		}
	},
	--#endregion
	--#region RELOADED GEODE
	[TRINKET..FiendFolio.ITEM.ROCK.AAA_GEODE] = {
		_descType = "trinket",
		Name = "AAA 건전지",
		QuoteDesc = "",
		Description = [[
			{{Trinket3}} 방 클리어 시 액티브 아이템의 충전량이 1칸 남았을 경우 액티브를 자동으로 충전합니다.
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 2칸 남았을 경우 자동 충전
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"{{Battery}} -1 charge needed for active items",
			"↑ -2 charge needed for active items if holding another Geode"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {1, 2, 3, 4},
				TargetNumbers = {1, 2}
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.LIBERTY_GEODE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Trinket32}} 방 입장 시 25%의 확률로 그 방에서 아래 중 랜덤 버섯 아이템 효과를 얻습니다:
			>>> {{Collectible12}}{{Collectible71}}{{Collectible121}}{{Collectible120}}{{Collectible342}}{{Collectible398}}
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 확률 증가, 2개 이상의 효과가 나올 수 있음
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"25% chance for a random mushroom effect per room",
			"↑ Increased chance to grant a mushroom effect if holding another Geode",
			"↑ Can gain an additional mushroom effect if holding another Geode"
		},
		Golden = {
			TargetMultipliers = {25}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.NONAGON_GEODE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Battery}} 액티브 아이템 사용 시 25%의 확률로 배터리를 드랍합니다.
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 배터리 드랍 확률 증가
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"{{Battery}} 25% chance to spawn a random battery when using an active item",
			"↑ Increased chance if holding another Geode"
		},
		Golden = {
			TargetAdditives = {
				AdditiveValues = {10, 20, 30, 40},
				TargetNumbers = {25},
			}
		}
	},
	[TRINKET..FiendFolio.ITEM.ROCK.DEVOURING_GEODE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			!!! 일회용
			체력 거래 시 체력 대신 소모합니다.
			!!! {{DevilRoom}}악마방/{{Collectible292}}Satanic Bible 거래 시 여전히 악마 거래로 취급됩니다.
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} 이 석기가 아닌 소지 중인 다른 석기를 대신 소모합니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"{{DevilRoom}} Allows Isaac to take a free devil deal",
			"!!! Destroys itself when one is taken",
			"↑ If another geode is held, it will be taken instead"
		},
		NoOverclockEffect = true,
	},
	[TRINKET..FiendFolio.ITEM.ROCK.THE_STRONGEST_GEODE] = {
		_descType = "trinket",
		Name = "",
		QuoteDesc = "",
		Description = [[
			!!! 석기류 획득 시 레어도가 {{Quality1}}레어 이상인 경우 그 석기를 파괴하며;
			>>> {{Quality0}} 레어도가 낮은 석기와 {{HalfSoulHeart}} 소울하트 반칸으로 바꿉니다.
			{{ffGeode}} 파괴된 석기가 정동류인 경우 {{SoulHeart}} 소울하트 1칸으로 바뀜
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeode}} {{ColorTransform}}Rock Trinket (Geode)",
			"Picking up Rare or Fiendish rocks crushes it and turns them into a Common rock",
			"{{HalfSoulHeart}} Crushing rocks spawns a Half Soul Heart"
		},
		NoOverclockEffect = true,
	},
	--#endregion
	--#region GEODE FOSSIL
	[TRINKET..FiendFolio.ITEM.ROCK.GEODE_FOSSIL] = {
		_descType = "trinket",
		Name = "정동화석",
		QuoteDesc = "궁극의 보석 + 정동, 분해 보너스",
		Description = [[
			↑ {{RangeSmall}}사거리 +1.5
			{{ffGeode}} {{ColorTeal}}공명:{{CR}} {{RangeSmall}} 추가 사거리 +1.5
			{{ffCrush}} {{ColorRed}}분해:{{CR}} 랜덤 정동류 드랍
			{{ffGeodeFossil}} {{ColorTransform}}공명+분해:{{CR}} 랜덤 정동류 추가 드랍
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_FOSSIL",
			"FF_APPEND_GOLEM_GEODE",
		},
		Tests = {
			"{{ffGeodeFossil}} {{ColorTransform}}Rock Trinket (Geode x Fossil)",
			"↑ +1.5 Range",
			"↑ Bonus +0.75 Range if holding another Geode",
			"{{ffCrush}} Gives a common or rare Geode trinket when crushed",
			"{{ffCrush}} Gives an additional common or rare Geode trinket when crushed if holding another Geode"
		},
		Golden = {
			TargetMultipliers = {1.5}
		}
	},
	--#endregion
	--#endregion

	--#region CARDS
	--#region FIEND CARDS
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
	[CARD..FiendFolio.ITEM.CARD.DOWNLOAD_FAILURE] = {
		_descType = "card",
		Name = "다운로드 실패",
		QuoteDesc = "왜 다들 미끄러져 있어?",
		Description = [[
			사용 시 그 방에 오류가 생깁니다.
			{{Card]] .. FiendFolio.ITEM.CARD.DOWNLOAD_FAILURE .. [[}} 오류가 생긴 적은 미끄러집니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SMALL_CONTRABAND] = {
		_descType = "card",
		Name = "작은 밀매품",
		QuoteDesc = "들키지 말고 건네줘",
		Description = [[
			!!! 사용 효과 없음
			!!! 소지하지 않은 상태에서는 특정 몬스터가 해당 카드를 훔칠 수 있습니다!
			해당 카드를 다음 스테이지에 있는 검은 모자의 거지에게 배달 시 특수 배열의 아이템을 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SKIP_CARD] = {
		_descType = "card",
		Name = "스킵 카드",
		QuoteDesc = "응 아냐",
		Description = [[
			사용 시 모든 오브젝트 및 엔티티(적/아이템 등)을 지웁니다.
			스킵 카드로 방 클리어 시 액티브 아이템 게이지가 충전되지 않으며 방 클리어 보상이 소환되지 않습니다.
			{{BossRoom}} 보스방의 경우 아이템이 소환되지 않습니다.
			최종 보스의 경우 해당 페이즈를 건너뛰지만 마지막 페이즈에서의 사용 시 면역입니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GIFT_CARD] = {
		_descType = "card",
		Name = "선물 카드",
		QuoteDesc = "어서 마무리 하자",
		Description = [[
			{{Collectible515}} 방 안의 모든 아이템을 Mystery Gift로 바꿉니다.
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
			{{Blank}} (비행/공격 명중 시 확률적으로 아군 무당벌레 소환/아군 무당벌레는 적 탄환을 막아줌)
		]],
	},
	--#endregion
	--#region CLUB PENGUIN CARDS
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
	--#endregion
	--#region FOUR SOULS CARDS
	[CARD..FiendFolio.ITEM.CARD.MISPRINTED_GISH] = {
		_descType = "card",
		Name = "기쉬?",
		QuoteDesc = "기쉬 소환?",
		Description = [[
			아군 Gish를 소환합니다.
			가까운 적에게 착지, 폭발 타르를 발사 후 떠납니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.REDACTED_TRIANGLE] = {
		_descType = "card",
		Name = "램넌트 삼각형",
		QuoteDesc = "",
		Description = [[
			{{Timer}} 사용 시 그 방에서:
			{{IND}} 그 방의 액티브 아이템을 전부 발동합니다.
			{{Timer}} 사용 시 그 스테이지에서:
			{{IND}} 그 방의 패시브 아이템 효과를 전부 발동합니다.
		]],
	},
	--#endregion
	--#region YUGIOH CARDS
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
  [CARD..FiendFolio.ITEM.CARD.SEAL_OF_ORICHALCOS] = {
		_descType = "card",
		Name = "오리컬코스의 결계",
		QuoteDesc = "나의 힘을 갈구하라, 그리하면 커다란 힘 그대에게 깃들지어다",
		Description = [[
			사용 시 거대한 결계를 소환합니다.
			{{Collectible584}} 결계 안의 적 처치 시 위습을 소환합니다.
		]],
	},
	--#endregion
	--#region SHADOWVERSE
	[CARD..FiendFolio.ITEM.CARD.DRACONIC_FERVOR] = {
		_descType = "card",
		Name = "용의 투기",
		QuoteDesc = "회복, 충전, 드로우",
		Description = [[
			사용 시:
			{{IND}} {{Card}} 카드 2장을 드랍합니다.
			{{IND}} {{Heart}} 체력을 1.5칸 회복합니다.
			{{IND}} {{Battery}} 소지 중인 액티브 아이템을 2칸 충전합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.TRIBUNAL_OF_GOOD_AND_EVIL] = {
		_descType = "card",
		Name = "신마재판소",
		QuoteDesc = "처형",
		Description = [[
			{{Collectible]] .. FiendFolio.ITEM.COLLECTIBLE.EXECUTIONER ..[[}} 사용 시 그 방의 적을 즉사시키며 다른 적을 3초 후 즉사시킵니다.
			{{Blank}} (보스의 경우 최대 체력의 20% 피해)
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.DANCE_OF_USURPATION] = {
		_descType = "card",
		Name = "약탈의 춤",
		QuoteDesc = "칼춤",
		Description = [[
			사용 시 그 방의 적에게 스테이지 비례 피해를 줍니다.
			이 효과로 적 처치 시 랜덤 픽업을 드랍합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.HAUNTED_HOUSE] = {
		_descType = "card",
		Name = "유령 저택",
		QuoteDesc = "영혼 달래기",
		Description = [[
			{{Charm}} 사용 시 그 방에서 적 처치 시 아군으로 부활시킵니다. (보스 제외)
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.DIRE_BOND] = {
		_descType = "card",
		Name = "칠흑의 계약",
		QuoteDesc = "득을 위한 피",
		Description = [[
			!!! 사용 시 캐릭터에게 3칸의 피해를 주며; (사망하지 않음)
			{{BlendedHeart}} 이후 방 클리어 시 체력 반칸 회복 (초과회복 = 소울하트) + 카드 획득 (3회)
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ELF_SONG] = {
		_descType = "card",
		Name = "요정을 부르는 선율",
		QuoteDesc = "무리의 강함",
		Description = [[
			사용 시 중형, 자폭 아군 파리를 2마리씩 소환합니다.
			{{Collectible248}} 사용 시 그 방에서 파리/거미류 패밀리어의 피해량 2배
		]],
	},
	--#endregion
	--#region SLAY THE SPIRE
	[CARD..FiendFolio.ITEM.CARD.NEIGHBOURS_FROM_HELL] = {
		_descType = "card",
		Name = "지옥에서 온 이웃",
		QuoteDesc = "보너스 장신구?",
		Description = [[
			{{Trinket}} 사용 시 랜덤 장신구 하나를 흡수합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CREATIVE_AI] = {
		_descType = "card",
		Name = "창의적인 인공지능",
		QuoteDesc = "랜덤 파워",
		Description = [[
			사용 시 그 스테이지에서 소지 중인 액티브 아이템이 다른 랜덤 액티브 아이템으로 바뀝니다.
			{{Blank}} (교체 시에도 바뀐 상태 유지)
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CORRUPTION] = {
		_descType = "card",
		Name = "타락",
		QuoteDesc = "액티브 소진",
		Description = [[
			{{Battery}} 사용 시 그 스테이지에 카드/알약 슬롯이 아닌 소지 액티브 아이템의 충전량을 1칸으로 설정합니다.
			!!! 스테이지 진입 시 충전량이 바뀐 액티브 아이템이 사라집니다.
			{{Blank}} (특수, 시간제 충전의 경우 무효과)
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.BLASPHEMY] = {
		_descType = "card",
		Name = "신성 모독",
		QuoteDesc = "다음 턴에 사망",
		Description = [[
			{{Collectible577}} 사용 시 그 스테이지에서 Damocles 효과를 발동합니다.
			!!! 직후 캐릭터가 체력 반칸의 패널티 피해를 받습니다.
		]],
	},
	--#endregion
	--#region SIGNALIS
	[CARD..FiendFolio.ITEM.CARD.ABERRANT_LOVERS] = {
		_descType = "card",
		Name = "이상한 연인",
		QuoteDesc = "아픈 약속",
		Description = [[
			사용 시 캐릭터의 체력의 절반을 소모하며;
			{{ffMorbidHeart}} 종양하트를 2개 드랍합니다.
		]],
		AppendEntries = {
			"FF_APPEND_MORBID_HEART",
		},
	},
	[CARD..FiendFolio.ITEM.CARD.ABERRANT_DEATH] = {
		_descType = "card",
		Name = "이상한 죽음",
		QuoteDesc = "불완전한 부활",
		Description = [[
			그 방의 모든 적을 다시 소환합니다.
			소환된 적은 50%의 확률로 아군이 됩니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ABERRANT_TOWER] = {
		_descType = "card",
		Name = "이상한 탑",
		QuoteDesc = "폭격",
		Description = [[
			{{Collectible168}} 조준점을 3개 소환합니다.
			일정 시간 이후 각 조준점마다 랜덤 간격으로 미사일을 4발씩 발사합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ABERRANT_STARS] = {
		_descType = "card",
		Name = "이상한 별",
		QuoteDesc = "꽉 찬 인벤토리",
		Description = [[
			비어있는 장신구 및 카드/알약 슬롯을 채웁니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ABERRANT_MOON] = {
		_descType = "card",
		Name = "이상한 달",
		QuoteDesc = "붉은 달",
		Description = [[
			{{SecretRoom}} 비밀방/일급비밀방의 위치를 맵에 표시하며;
			{{RedRoom}} 가능한 경우, 각 방의 면마다 빨간방을 생성합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ABERRANT_SUN] = {
		_descType = "card",
		Name = "이상한 태양",
		QuoteDesc = "슬로우 회복",
		Description = [[
			{{HealingRed}} 15초마다 체력을 반칸씩 회복합니다. (최대 6칸 회복)
			{{SoulHeart}} (최대체력 = 소울하트의 보정을 받는 경우 최대 2칸 회복)
		]],
	},
	--#endregion
	--#region ALLEGEDLY TAROT CARDS
	[CARD..FiendFolio.ITEM.CARD.HAPPY_SQUIRREL] = {
		_descType = "card",
		Name = "XXIII - 행복한 다람뷔",
		QuoteDesc = "놀이시간!",
		Description = [[
			{{ArcadeRoom}} 사용 시 특수한 오락실로 이동합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.THE_INVISIBLE_MOON] = {
		_descType = "card",
		Name = "보이지 않는 달",
		QuoteDesc = "모두 사라져",
		Description = [[
			{{ffBerserk}} 사용 시 15초간 적을 폭주 상태로 만듭니다.
		]],
		AppendEntries = {
			"FF_APPEND_BERSERK",
		},
	},
	--#endregion
	--#region ENERGY CARDS
	[CARD..FiendFolio.ITEM.CARD.ENERGY_GRASS] = {
		_descType = "card",
		Name = "자연 에너지",
		QuoteDesc = "중독",
		Description = [[
			{{Poison}} 그 방의 모든 적을 4초간 중독시킵니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ENERGY_FIRE] = {
		_descType = "card",
		Name = "화염 에너지",
		QuoteDesc = "화상",
		Description = [[
			{{Burning}} 그 방의 모든 적에게 4초간 화상을 줍니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ENERGY_WATER] = {
		_descType = "card",
		Name = "물 에너지",
		QuoteDesc = "흐름",
		Description = [[
			방 안의 적이 4초간 8방향으로 파란 눈물을 여러번 쏩니다.
			파란 눈물을 쏠 때마다 미세한 피해를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ENERGY_LIGHTNING] = {
		_descType = "card",
		Name = "전기 에너지",
		QuoteDesc = "과부하",
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
		QuoteDesc = "멍",
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
		QuoteDesc = "에스퍼",
		Description = [[
			{{Confusion}} 방 안의 모든 적이 4초간 혼란에 걸립니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ENERGY_COLORLESS] = {
		_descType = "card",
		Name = "무채 에너지",
		QuoteDesc = "유클리드",
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
		QuoteDesc = "공포",
		Description = [[
			{{Fear}} 방 안의 모든 적이 4초간 공포에 걸립니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ENERGY_METAL] = {
		_descType = "card",
		Name = "강철 에너지",
		QuoteDesc = "대출혈",
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
		QuoteDesc = "매혹",
		Description = [[
			{{Charm}} 방 안의 모든 적에게 4초간 매혹을 겁니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ENERGY_DRAGON] = {
		_descType = "card",
		Name = "드래곤 에너지",
		QuoteDesc = "에너지",
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
	--#endregion
	--#region 100% ORANGE JUICE CARDS
	[CARD..FiendFolio.ITEM.CARD.OJ_BUSINESS] = {
		_descType = "card",
		Name = "어둠의 자금 조달",
		QuoteDesc = "적의 돈 스틸",
		Description = [[
			{{ffLilPenny}} 사용 시 그 방의 적에게 약탈을 겁니다.
		]],
		AppendEntries = {
			"FF_APPEND_MUGGED",
		},
			StatusEffects = { FiendFolio.DescriptionStatuses.MUGGED },
	},
	[CARD..FiendFolio.ITEM.CARD.OJ_STRONGER] = {
		_descType = "card",
		Name = "강해져서 돌아왔다",
		QuoteDesc = "공격력 증가, 맞았으면 더",
		Description = [[
			{{Timer}} 사용 시 그 방에서:
			>>> {{DamageSmall}} 공격력 +1
			{{Timer}} 피해를 받은 방에서 사용 시:
			>>> {{DamageSmall}} 공격력 +2
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.OJ_PRESENT] = {
		_descType = "card",
		Name = "근사한 선물",
		QuoteDesc = "오렌지 카드 2장 드로우",
		Description = [[
			사용 시 {{ColorOrange}}100% 오렌지 주스{{CR}} 출신 카드를 2장 드랍합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.OJ_SEAGULLS] = {
		_descType = "card",
		Name = "갈매기 떼",
		QuoteDesc = "랜덤 대미지",
		Description = [[
			사용 시 그 방의 적 혹은 캐릭터 중 하나에게 스테이지 비례 피해를 줍니다.
			{{Collectible486}} (캐릭터의 경우 피격 효과만 발동)
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.OJ_FIRE_SUPPORT] = {
		_descType = "card",
		Name = "무차별 화력 지원",
		QuoteDesc = "하늘에서 로켓이",
		Description = [[
			{{Collectible47}} 그 방의 적 하나에게 스테이지 비례 피해를 주는 미사일을 발사합니다. (4회 발동)
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.OJ_SERENE_HUSH] = {
		_descType = "card",
		Name = "고요와 적막",
		QuoteDesc = "평화주의",
		Description = [[
			{{ffPacified}} 사용 시 그 방의 적을 진정시킵니다.
		]],
		AppendEntries = {
			"FF_APPEND_PACIFIED",
		},
	},
	[CARD..FiendFolio.ITEM.CARD.OJ_MIX_PHENOMENON] = {
		_descType = "card",
		Name = "믹스화 현상",
		QuoteDesc = "랜덤 타일",
		Description = [[
			{{Collectible]] .. tostring(FiendFolio.ITEM.COLLECTIBLE.HUNDRED_PERCENT_ORANGE_JUICE) .. [[}} 100% Orange Juice 타일을 최대 3개까지 소환하며;
			이미 소환된 타일의 색상을 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.OJ_JONATHAN_RUSH] = {
		_descType = "card",
		Name = "조나단 러시",
		QuoteDesc = "적을 향해 워프",
		Description = [[
			사용 시 피격 무적 시간을 얻으며 랜덤 적의 위치로 순간이동 + 폭발합니다.
			!!! (적이 없는 경우 무효과)
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.OJ_ENCHANTMENT] = {
		_descType = "card",
		Name = "질풍의 인챈트",
		QuoteDesc = "스피드 부스트",
		Description = [[
			{{Timer}} 그 방에서:
			{{IND}} {{SpeedSmall}} 이동속도 +0.15
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.OJ_HINDENPEATER] = {
		_descType = "card",
		Name = "",
		QuoteDesc = "",
		Description = [[
			{{Timer}} 사용 시 그 방에서:
				{{Collectible108}} 모든 피해를 절반으로 받습니다.
				↑ 모든 능력치 증가
		]],
	},
	--#endregion
	--#region GLASS DICE
	[CARD..FiendFolio.ITEM.CARD.GLASS_D6] = {
		_descType = "card",
		Name = "유리 6면 조각",
		QuoteDesc = "운명을 굴려라",
		Description = [[
			{{Collectible105}} 사용 시 방 안의 모든 아이템을 다른 아이템으로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_D4] = {
		_descType = "card",
		Name = "유리 4면 조각",
		QuoteDesc = "다른 것으로 바꿔라",
		Description = [[
			{{Collectible284}} 사용 시 소지중인 모든 패시브 아이템을 모두 바꿉니다.
			스테이지 진행에 필요한 아이템은 바뀌지 않습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_D8] = {
		_descType = "card",
		Name = "유리 8면 조각",
		QuoteDesc = "능력치를 바꿔라",
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
		QuoteDesc = "주사위를 굴려어어어!",
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
		QuoteDesc = "적들을 바꿔라",
		Description = [[
			{{Collectible285}} 사용 시 방 안의 모든 적을 한 단계 내립니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_D20] = {
		_descType = "card",
		Name = "유리 20면 조각",
		QuoteDesc = "기본품을 바꿔라",
		Description = [[
			{{Collectible166}} 사용 시 방 안의 모든 픽업 아이템을 다른 픽업 아이템으로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_D12] = {
		_descType = "card",
		Name = "유리 12면 조각",
		QuoteDesc = "장애물을 바꿔라",
		Description = [[
			{{Collectible386}} 사용 시 방 안의 모든 장애물을 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_SPINDOWN] = {
		_descType = "card",
		Name = "유리 스핀다운 조각",
		QuoteDesc = "",
		Description = [[
			{{Collectible723}} 사용 시 방 안의 모든 아이템을 코드 앞번호의 아이템으로 바꿉니다.
			!!! 해금하지 않은 아이템은 등장하지 않습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_AZURITE_SPINDOWN] = {
		_descType = "card",
		Name = "아주라이트 스핀다운 조각",
		QuoteDesc = "",
		Description = [[
			{{Collectible]] .. tostring(FiendFolio.ITEM.COLLECTIBLE.AZURITE_SPINDOWN) .. [[}} 사용 시 방 안의 모든 장신구를 코드 앞번호의 장신구로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_D2] = {
		_descType = "card",
		Name = "유리 2면 조각",
		QuoteDesc = "던질 수 있는 주사위",
		Description = [[
			{{Collectible]] .. tostring(FiendFolio.ITEM.COLLECTIBLE.D2) .. [[}} 사용 시 주사위를 들며 공격방향으로 던집니다.
			착지한 주사위에 닿은 적, 픽업 아이템, 눈물이 같은 유형의 다른 항목으로 바뀝니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_D3] = {
		_descType = "card",
		Name = "유리 3면 조각",
		QuoteDesc = "눈물을 바꾸다",
		Description = [[
			{{Collectible]] .. tostring(FiendFolio.ITEM.COLLECTIBLE.D3) .. [[}} 사용 시 그 방에서 눈물을 바꾸는 기둥을 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.GLASS_D5] = {
		_descType = "card",
		Name = "유리 5면 조각",
		QuoteDesc = "던질 수 있는 주사위",
		Description = [[
			{{Collectible]] .. tostring(FiendFolio.ITEM.COLLECTIBLE.D5) .. [[}} 사용 시 그 방에서 손 모양 주사위를 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.D10_SHARD] = {
		_descType = "card",
		Name = "주사위 파편",
		QuoteDesc = "",
		Description = [[
			{{Collectible285}} 사용 시 그 방의 장애물을 바꾸며 그 방의 적을 한 단계 낮춥니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ETERNAL_SHARD] = {
		_descType = "card",
		Name = "주사위 파편",
		QuoteDesc = "",
		Description = [[
			{{Collectible609}} 사용 시 그 방의 아이템, 장애물을 바꾸며 그 방의 적을 한 단계 낮춥니다.
			50%의 확률로 대상이 사라집니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.D8_SHARD] = {
		_descType = "card",
		Name = "주사위 파편",
		QuoteDesc = "",
		Description = [[
			{{Collectible284}} 사용 시 캐릭터의 소지 아이템과 능력치 배율을 바꿉니다.
		]],
	},
	--#endregion
	--#region MODEL OBJECTS
	[CARD..FiendFolio.ITEM.CARD.GREEN_HOUSE] = {
		_descType = "card",
		Name = "녹색 모형집",
		QuoteDesc = "쫒겨났어",
		Description = [[
			그 방의 모든 적 및 픽업을 보관합니다.
			보관된 적 및 픽업은 다음 방 진입 시 강제로 소환됩니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.BRICK_SEPERATOR] = {
		_descType = "card",
		Name = "브릭 분해기",
		QuoteDesc = "적 나누기",
		Description = [[
			{{Collectible631}} 사용 시 방 안의 모든 적을 0.4배의 체력을 가진 적 2마리로 나누며;
			그 방에서 공격이 적을 관통합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.PUZZLE_PIECE] = {
		_descType = "card",
		Name = "퍼즐 조각",
		QuoteDesc = "맞춰봐!",
		Description = [[
			운세 퍼즐을 1/3만큼 기록합니다.
			운세 퍼즐이 완성되면 해당 운세에 맞는 아이템을 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.COOL_PHOTO] = {
		_descType = "card",
		Name = "멋진 사진",
		QuoteDesc = "값진 순간",
		Description = [[
			{{Coin}} 동전 1~2개를 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.BLANK_LETTER_TILE] = {
		_descType = "card",
		Name = "빈 키캡",
		QuoteDesc = "글자를 선택해 봐",
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
		QuoteDesc = "다시 붙이기",
		Description = [[
			!!! ]]..FiendFolio.DescriptionIcons.China..[[China 전용
			{{BrokenHeart}} 사용 시 부서진하트 -1
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.TOP_HAT] = {
		_descType = "card",
		Name = "탑모자",
		QuoteDesc = "즉석 자본",
		Description = [[
			열린 상점 상자를 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.STUD] = {
		_descType = "card",
		Name = "레고 뚜껑",
		QuoteDesc = "발조심",
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
		QuoteDesc = "당겨!",
		Description = [[
			{{ffObject}} 캐릭터 주변에 작은 폭발을 일으키며 랜덤 오브젝트를 드랍합니다.
			캐릭터는 이 폭발에 피해를 입지 않습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.PINK_COW] = {
		_descType = "card",
		Name = "핑크빛 송아지",
		QuoteDesc = "적 승리 차단",
		Description = [[
			{{ffPacified}} 사용 후 방 4개동안 랜덤 적 하나에 진정 상태를 겁니다.
		]],
		AppendEntries = {
			"FF_APPEND_PACIFIED",
		},
	},
	[CARD..FiendFolio.ITEM.CARD.YELLOW_CAR] = {
		_descType = "card",
		Name = "노란 차",
		QuoteDesc = "뜨거운 바퀴",
		Description = [[
			{{SpeedSmall}} 사용 시 이동속도 +1
			{{SpeedSmall}} 방 클리어 시 증가한 이동속도 -0.15
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.LUCKY_DUCK] = {
		_descType = "card",
		Name = "행운의 오리",
		QuoteDesc = "냠",
		Description = [[
			{{Timer}} 그 방에서:
			{{IND}} {{LuckSmall}} 행운 +7.77
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.COMICAL_ROUND_GLASSES] = {
		_descType = "card",
		Name = "코믹 안경",
		QuoteDesc = "",
		Description = [[
			{{Timer}} 그 방에서:
			{{IND}} {{Collectible245}} 20/20 효과 발동
			{{IND}} {{RangeSmall}} 사거리 +2.5
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.EGG_SACK] = {
		_descType = "card",
		Name = "알주머니",
		QuoteDesc = "영원한 친구",
		Description = [[
			사용 시 아래의 아군 패밀리어 혹은 몬스터를 3마리씩 소환:
			{{IND}} 파란 자폭 파리
			{{IND}} 파란 자폭 거미
			{{IND}} 파란 자폭 벼룩
			{{IND}} 작은 거미
			{{IND}} 무당벌레
		]],
	},
	--#endregion
	--#region DISCS
	[CARD..FiendFolio.ITEM.CARD.TREASURE_DISC] = {
		_descType = "card",
		Name = "보믈방 디스크",
		QuoteDesc = "1분 동안 무료",
		Description = [[
			{{ItemPoolTreasure}} 1분간 3~5개의 보물방 배열 패시브 아이템의 효과를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SHOP_DISC] = {
		_descType = "card",
		Name = "상점 디스크",
		QuoteDesc = "1분 동안 무료",
		Description = [[
			{{ItemPoolShop}} 1분간 3~5개의 상점({{Trinket184}}:{{ItemPoolBabyShop}}) 배열 패시브 아이템의 효과를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.BOSS_DISC] = {
		_descType = "card",
		Name = "보스방 디스크",
		QuoteDesc = "1분 동안 무료",
		Description = [[
			{{ItemPoolBoss}} 1분간 3~5개의 보스방 배열 패시브 아이템의 효과를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SECRET_DISC] = {
		_descType = "card",
		Name = "비밀방 디스크",
		QuoteDesc = "1분 동안 무료",
		Description = [[
			{{ItemPoolSecret}} 1분간 3~5개의 비밀방 배열 패시브 아이템의 효과를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.DEVIL_DISC] = {
		_descType = "card",
		Name = "악마방 디스크",
		QuoteDesc = "1분 동안 무료",
		Description = [[
			{{ItemPoolDevil}} 1분간 3~5개의 악마방 배열 패시브 아이템의 효과를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ANGEL_DISC] = {
		_descType = "card",
		Name = "천사방 디스크",
		QuoteDesc = "1분 동안 무료",
		Description = [[
			{{ItemPoolAngel}} 1분간 3~5개의 천사방 배열 패시브 아이템의 효과를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.PLANETARIUM_DISC] = {
		_descType = "card",
		Name = "천체관 디스크",
		QuoteDesc = "1분 동안 무료",
		Description = [[
			{{ItemPoolPlanetarium}} 1분간 3~5개의 천체관 배열 패시브 아이템의 효과를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.CHAOS_DISC] = {
		_descType = "card",
		Name = "혼돈의 디스크",
		QuoteDesc = "1분 동안 무료",
		Description = [[
			{{Collectible402}} 1분간 3~5개의 랜덤 배열 패시브 아이템의 효과를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.BROKEN_DISC] = {
		_descType = "card",
		Name = "망가진 디스크",
		QuoteDesc = "1분 동안 무료",
		Description = [[
			{{Collectible347}} 1분간 3~5개의 동일한 랜덤 패시브 아이템의 효과를 받습니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.TAINTED_TREASURE_DISC] = {
		_descType = "card",
		Name = "더럽혀진 보믈방 디스크",
		QuoteDesc = "1분 동안 무료",
		Description = [[
			{{ffDisc}} 1분간 3~5개의 더럽혀진 보물방 배열 패시브 아이템의 효과를 받습니다.
		]],
	},
	--#endregion
	--#region SUIT CARDS
	[CARD..FiendFolio.ITEM.CARD.MISPRINTED_JACK_OF_CLUBS] = {
		_descType = "card",
		Name = "클로버 J?",
		QuoteDesc = "파괴, 하지만 대가는?",
		Description = [[
			{{GoldenBomb}} 황금 트롤폭탄을 소환합니다.
			{{Bomb}} 그 방의 모든 폭탄 픽업을 트롤폭탄으로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.MISPRINTED_TWO_OF_CLUBS] = {
		_descType = "card",
		Name = "클로버 2?",
		QuoteDesc = "= [$]아이템 두",
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
		Name = "다이아 3?",
		QuoteDesc = "배 아이템 세",
		Description = [[
			{{Trinket}} 페니류 장신구를 3개 소환합니다.
			하나를 선택하면 나머지는 사라집니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.THREE_OF_DIAMONDS] = {
		_descType = "card",
		Name = "다이아 3",
		QuoteDesc = "아이템 세배",
		Description = [[
			{{Coin}} 랜덤 동전 픽업을 3개 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.THREE_OF_CLUBS] = {
		_descType = "card",
		Name = "클로버 3",
		QuoteDesc = "아이템 세배",
		Description = [[
			{{Bomb}} 랜덤 폭탄 픽업을 3개 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.THREE_OF_SPADES] = {
		_descType = "card",
		Name = "스페이드 3",
		QuoteDesc = "아이템 세배",
		Description = [[
			{{Key}} 랜덤 열쇠 픽업을 3개 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.THREE_OF_HEARTS] = {
		_descType = "card",
		Name = "하트 3",
		QuoteDesc = "아이템 세배",
		Description = [[
			{{Heart}} 랜덤 하트 픽업을 3개 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.JACK_OF_DIAMONDS] = {
		_descType = "card",
		Name = "다이아 J",
		QuoteDesc = "풍요, 하지만 대가는?",
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
		QuoteDesc = "파괴, 하지만 대가는?",
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
		QuoteDesc = "해결, 하지만 대가는?",
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
		QuoteDesc = "체력, 하지만 대가는?",
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
		QuoteDesc = "장애물 = [$]",
		Description = [[
			{{Coin}} 방 안의 모든 돌덩이/똥 오브젝트를 동전으로 바꿉니다.
			{{Timer}} 바뀐 동전은 5초 후 사라집니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.QUEEN_OF_CLUBS] = {
		_descType = "card",
		Name = "클로버 Q",
		QuoteDesc = "",
		Description = [[
			{{Collectible52}} 그 방에서 공격이 폭탄 발사 공격으로 변경됩니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.QUEEN_OF_SPADES] = {
		_descType = "card",
		Name = "스페이드 Q",
		QuoteDesc = "",
		Description = [[
			{{Key}} 열쇠를 1~10개 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.KING_OF_DIAMONDS] = {
		_descType = "card",
		Name = "다이아 K",
		QuoteDesc = "도금",
		Description = [[
			{{Collectible202}} 그 방의 적을 적을 멈추게 만들며 멈춘 적 처치시 {{Coin}}동전을 1~3개 드랍합니다.
			그 방의 돌덩이 오브젝트 25%를 금광으로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.KING_OF_CLUBS] = {
		_descType = "card",
		Name = "클로버 K",
		QuoteDesc = "붐 베이베!",
		Description = [[
			{{GigaBomb}} 기가폭탄 픽업을 하나 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.KING_OF_SPADES] = {
		_descType = "card",
		Name = "스페이드 K",
		QuoteDesc = "분노를 해금하라",
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
		QuoteDesc = "전부 변환",
		Description = [[
			{{Battery}} 방 안의 모든 적과 픽업을 배터리로 바꿉니다.
			!!! 바뀐 배터리는 2초 후 사라집니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.TWO_OF_WANDS] = {
		_descType = "card",
		Name = "완드 2",
		QuoteDesc = "아이템 두배",
		Description = [[
			{{Battery}} 소지 중인 액티브 아이템 충전량 x2 (초과 충전 가능)
			충전량이 없을 시 충전량 1칸을 채워줍니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.THREE_OF_WANDS] = {
		_descType = "card",
		Name = "완드 3",
		QuoteDesc = "아이템 세배",
		Description = [[
			{{Battery}} 배터리 픽업을 3개 소환합니다
			!!! 바뀐 배터리는 3초 후 사라집니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.KING_OF_WANDS] = {
		_descType = "card",
		Name = "완드 K",
		QuoteDesc = "배터리 업그레이드",
		Description = [[
			{{Battery}} 방 안의 배터리 픽업을 강화시킵니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ACE_OF_PENTACLES] = {
		_descType = "card",
		Name = "펜타클 A",
		QuoteDesc = "전부 변환",
		Description = [[
			{{Trinket}} 방 안의 모든 적과 픽업을 장신구로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.TWO_OF_PENTACLES] = {
		_descType = "card",
		Name = "펜타클 2",
		QuoteDesc = "아이템 두배",
		Description = [[
			{{Trinket}} 소지 중인 미흡수 장신구를 복제하여 소환합니다.
			소지 중인 장신구가 없을 시 랜덤 장신구를 드랍합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.THREE_OF_PENTACLES] = {
		_descType = "card",
		Name = "펜타클 3",
		QuoteDesc = "아이템 세배",
		Description = [[
			{{Trinket}} 랜덤 장신구(석기류 포함)를 3개 소환합니다.
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
		QuoteDesc = "장신구 업그레이드",
		Description = [[
			{{Trinket}} 그 방의 장신구 및 소지 중인 장신구를 황금 형태로 바꿉니다.
			!!! 흡수한 장신구는 무효과
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.REVERSE_KING_OF_PENTACLES] = {
		_descType = "card",
		Name = "펜타클 K?",
		QuoteDesc = "장신구 업그레이드",
		Description = [[
			{{Trinket}} 소지 중인 장신구 및 그 방의 장신구를 석기류로 바꿉니다.
		]],
		AppendEntries = {
			"FF_APPEND_GOLEM_NORMAL",
		},
	},
	[CARD..FiendFolio.ITEM.CARD.MISPRINTED_KING_OF_PENTACLES] = {
		_descType = "card",
		Name = "펜타클 K??",
		QuoteDesc = "이드장신구 업그레",
		Description = [[
			{{Trinket}} 소지 중인 장신구 및 그 방의 장신구를 불경의 장신구로 바꿉니다.
			{{DamageSmall}} 불경의 장신구 하나 당 공격력 +1
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ACE_OF_SWORDS] = {
		_descType = "card",
		Name = "소드 A",
		QuoteDesc = "전부 변환",
		Description = [[
			방 안의 모든 적과 픽업을 아군 일회성 패밀리어로 바꿉니다.
			(예시) 파리, 거미, 벼룩, dip, beetles, minisaacs, fragile bobbies, blue baby spiders, ladybirds, fairy flies, mini Level 0 Flies
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.TWO_OF_SWORDS] = {
		_descType = "card",
		Name = "소드 2",
		QuoteDesc = "아이템 두배",
		Description = [[
			{{Collectible357}} 그 방에서 소지중인 패밀리어를 복사합니다.
			사용 시 방 안의 모든 아군 dip 및 자폭 파리/거미/벼룩을 복제합니다.
		]],
		-- Doubles all blue flies, spiders, skuzzes, friendly dips, and beetles in the room
	},
	[CARD..FiendFolio.ITEM.CARD.THREE_OF_SWORDS] = {
		_descType = "card",
		Name = "소드 3",
		QuoteDesc = "아이템 세배",
		Description = [[
			아군 일회성 패밀리어를 3마리 소환합니다.
			(예시) 파리, 거미, 벼룩, dip, beetles, minisaacs, fragile bobbies, blue baby spiders, ladybirds, fairy flies, mini Level 0 Flies
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.KING_OF_SWORDS] = {
		_descType = "card",
		Name = "소드 K",
		QuoteDesc = "패밀리어 업그레이드",
		Description = [[
			{{Collectible247}} 그 스테이지에서 패밀리어의 공격력을 2배로 증가시킵니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.ACE_OF_CUPS] = {
		_descType = "card",
		Name = "컵 A",
		QuoteDesc = "전부 변환",
		Description = [[
			{{Pill}} 방 안의 모든 적과 픽업을 알약으로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.TWO_OF_CUPS] = {
		_descType = "card",
		Name = "컵 2",
		QuoteDesc = "아이템 두배",
		Description = [[
			{{Pill}} 소지 중인 알약 및 방 안의 모든 알약을 복제합니다.
			복제할 알약이 없을 경우 랜덤 알약을 2개 드랍합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.THREE_OF_CUPS] = {
		_descType = "card",
		Name = "컵 3",
		QuoteDesc = "아이템 세배",
		Description = [[
			{{Pill}} 랜덤 알약을 3개 소환합니다.
			각 알약은 50%의 확률로 거대 형태로 소환됩니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.KING_OF_CUPS] = {
		_descType = "card",
		Name = "컵 K",
		QuoteDesc = "알약 업그레이드",
		Description = [[
			{{Pill}} 소지 중인 알약 및 방 안의 모든 알약을 거대 형태로 바꿉니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.MISPRINTED_JOKER] = {
		_descType = "card",
		Name = "조커?",
		QuoteDesc = "선악으로 비틀기",
		Description = [[
			사용 시 방 안의 모든 아이템을 {{DevilRoom}}악마방/{{AngelRoom}}천사방 아이템으로 바꿉니다.
			!!! 낮은 확률로 아이템이 아닌 성스러운/악한 테마의 하트/상자 픽업으로 바뀝니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.THIRTEEN_OF_STARS] = {
		_descType = "card",
		Name = "스타 13",
		QuoteDesc = "바보같아!",
		Description = [[
			{{Collectible721}} 오류 아이템을 하나 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.REVERSE_KING_OF_CLUBS] = {
		_descType = "card",
		Name = "클로버 K?",
		QuoteDesc = "맙소사 우린 모두 죽었어!",
		Description = [[
			!!! {{GigaBomb}} 사용 시 사망하며 캐릭터의 자리에 기가폭탄의 폭발을 일으킵니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.MISPRINTED_JUSTICEJACK] = {
		_descType = "card",
		Name = "정의?",
		QuoteDesc = "안하리라너의 앞날이 평",
		Description = [[
			사용 시 아래를 각각 하나씩 소환합니다:
			>>> {{ffImmoralHeart}} 이모럴하트
			>>> {{ffCopperBomb}} 구리폭탄
			>>> {{ffSpicyKey}} 매운열쇠
			>>> {{ffCursedPenny}} 저주페니
		]],
	},
	--#endregion
	--#region SUS
	[CARD..FiendFolio.ITEM.CARD.RUNE_ANSUS] = {
		_descType = "card",
		Name = "안수즈?",
		QuoteDesc = "임포스터",
		Description = [[
			{{CurseLostSmall}} 그 스테이지에서 맵에 특수방 위치, 비밀방 위치, 스테이지 구조가 표시됩니다 (?)
		]],
	},
	--#endregion
	--#region SOULS
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
			{{Trinket}} 석기류를 3개 드랍합니다.
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
	[CARD..FiendFolio.ITEM.CARD.SOUL_OF_FRIEND] = {
		_descType = "card",
		Name = "프렌드의 영혼",
		QuoteDesc = "일시적 건슬링거",
		Description = [[
			사용 시 랜덤 총을 얻습니다.
			획득한 총은 남은 탄약이 없으면 사라집니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SOUL_OF_CRAIG] = {
		_descType = "card",
		Name = "크레이그의 영혼",
		QuoteDesc = "슈퍼차지!",
		Description = [[
			{{Battery}} 소지 중인 액티브 아이템을 강제로 최대충전 시킵니다.
			{{Collectible]] .. tostring(FiendFolio.ITEM.COLLECTIBLE.EXCELSIOR) .. [[}} 다음 액티브 사용 시 유도성 로켓을 여러 발 발사합니다.
			{{Collectible584}} 다음 액티브 사용 시 위습을 하나 소환합니다.
		]],
	},
	[CARD..FiendFolio.ITEM.CARD.SOUL_OF_INABA] = {
		_descType = "card",
		Name = "이나바의 영혼",
		QuoteDesc = "편두통",
		Description = [[
			Migraine 모드를 발동시키며;
			Migraine 모드 중 새틀라이트를 2개 소환합니다.
		]],
	},
	--#endregion
	--#region BATTERIES
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
	--#endregion
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
	[PILL..FiendFolio.ITEM.PILL.RABBIT_PILL] = {
		_descType = "pill",
		Name = "",
		QuoteDesc = "",
		Description = [[ 
			토끼가 트로피를 먹고 싼 똥입니다.
			]]..FiendFolio.DescriptionIcons.Inaba..[[사용 시 토끼로 변신합니다.
		]],
	},
	--#endregion

	--#region ENTITIES
	--#region PENNIES
	["5.20."..FiendFolio.PICKUP.COIN.CURSED] = {
		_descType = "entity",
		Name = "저주페니",
		Description = [[
			획득 시 -2 ~ +2개의 동전을 획득하며;
			!!! 낮은 확률로 모든 능력치가 증가하거나 {{ColorOrange}}폭발합니다{{CR}}
		]],
	},
	["5.20."..FiendFolio.PICKUP.COIN.HAUNTED] = {
		_descType = "entity",
		Name = "유령페니",
		Description = [[
			{{Collectible584}} 획득 시 일반 위습이 같이 소환됩니다.
		]],
	},
	["5.20."..FiendFolio.PICKUP.COIN.HONEY] = {
		_descType = "entity",
		Name = "허니페니",
		Description = [[
			{{Slow}} 획득 시 일정 시간동안 적을 느려지게 하는 장판을 깝니다.
		]],
	},
	["5.20."..FiendFolio.PICKUP.COIN.GOLDENCURSED] = {
		_descType = "entity",
		Name = "황금 저주페니",
		Description = [[
			획득 시 -2 ~ +2개의 동전을 획득하며;
			!!! 낮은 확률로 모든 능력치가 증가하거나 {{ColorOrange}}폭발합니다{{CR}}
			{{ColorGold}}확률적으로 방 안에 다시 등장합니다.{{CR}}
		]],
	},
	["5.20."..FiendFolio.PICKUP.COIN.LEGOSTUD] = {
		_descType = "entity",
		Name = "레고페니",
		Description = [[
			{{Collectible486}} 획득 시 추가로 피격 효과를 발동합니다.
			레고 페니에 접촉한 적에게 5의 피해를 줍니다.
		]],
	},
	--#endregion
	--#region SPICY KEYS
	["5.30."..FiendFolio.PICKUP.KEY.SPICY] = {
		_descType = "entity",
		Name = "매운열쇠",
		Description = [[
			등장 시 열쇠 개수가 1개 증가하나 획득 시 체력 반칸의 피해를 받습니다.
		]],
	},
	--#endregion
	--#region COPPER BOMBS
	["5.40."..FiendFolio.PICKUP.BOMB.COPPER] = {
		_descType = "entity",
		Name = "구리폭탄",
		Description = [[
			{{Collectible106}} 설치 시 확률적으로 불발되거나 거대한 폭발을 일으킵니다.
			불발된 폭탄은 다른 폭발에 휘말려 같이 폭발합니다.
		]],
	},
	--#endregion
	--#region BATTERIES
	["5."..FiendFolio.PICKUP.VARIANT.FIREWORK_BATTERY..".0"] = {
		_descType = "entity",
		Name = "폭죽 배터리",
		Description = [[
			{{Collectible]]..FiendFolio.ITEM.COLLECTIBLE.EXCELSIOR..[[}}다음 액티브 사용 시 유도성 로켓을 여러 발 발사합니다.
		]],
	},
	["5."..FiendFolio.PICKUP.VARIANT.VIRTUOUS_BATTERY..".0"] = {
		_descType = "entity",
		Name = "미덕의 배터리",
		Description = [[
			{{Collectible584}} 다음 액티브 사용 시 해당 액티브의 위습을 같이 소환합니다.
		]],
	},
	["5."..FiendFolio.PICKUP.VARIANT.POTATO_BATTERY..".0"] = {
		_descType = "entity",
		Name = "감자도스",
		Description = [[
			1칸을 충전합니다.
		]],
	},
	["5."..FiendFolio.PICKUP.VARIANT.CURSED_BATTERY..".0"] = {
		_descType = "entity",
		Name = "저주배터리",
		Description = [[
			-2~4칸을 충전합니다. (초과 충전 가능)
		]],
	},
	--#endregion
	--#region MISC PICKUPS
	["5."..FiendFolio.PICKUP.VARIANT.TOKEN..".0"] = {
		_descType = "entity",
		Name = "토큰",
		Description = [[
			가장 최근에 집은 픽업을 다시 집습니다.
		]],
	},
	--#endregion
	--#region SLOTS
	["6."..FiendFolio.FF.HugBeggar.Var..".0"] = {
		_descType = "entity",
		Name = "허그 거지",
		Description = [[
			꼬옥 안아주세요
			{{Heart}} 안아주면 랜덤 하트를 드랍하고 떠납니다.
		]],
	},
	["6."..FiendFolio.FF.VendingMachine.Var..".0"] = {
		_descType = "entity",
	},
	["6."..FiendFolio.FF.VendingMachineFF.Var..".0"] = {
		_descType = "entity",
	},
	["6."..FiendFolio.FF.GridRestock.Var..".0"] = {
		_descType = "entity",
		Name = "장애물 리스톡",
		Description = [[
			1{{Bomb}} 필요
			{{Collectible386}} 확률적으로 그 방의 장애물을 바꿉니다.
		]],
	},
	["6."..FiendFolio.FF.PokerTable.Var..".0"] = {
		_descType = "entity",
		Name = "포커 테이블",
		Description = [[
			베팅할 픽업의 수를 선택하고 터치 시 확률적으로 돌려받거나 전부 잃습니다.
			3번 승리 시 투자한 픽업의 수에 비례하여 픽업 및 아이템을 드랍합니다.
		]],
	},
	["6."..FiendFolio.FF.Blacksmith.Var..".0"] = {
		_descType = "entity",
		Name = "대장장이",
		Description = [[
			{{Trinket}} 장신구 2개를 소모하여 새로운 장신구로 바꿉니다.
		]],
	},
	["6."..FiendFolio.FF.Dealer.Var..".0"] = {
		_descType = "entity",
		Name = "???",
		Description = [[
			필요한 건 가져오셨나?
		]],
	},
	["6."..FiendFolio.FF.ZodiacBeggar.Var..".0"] = {
		_descType = "entity",
		Name = "천체 거지",
		Description = [[
			1{{Coin}} 필요
			확률적으로 아래 중 하나 소환:
			>>> {{Planetarium}} 천체관/별자리 아이템 위습
			>>> {{Collectible584}} 일반 위습
		]],
	},
	["6."..FiendFolio.FF.RobotTeller.Var..".0"] = {
		_descType = "entity",
		Name = "점술로봇",
		Description = [[
			1{{Coin}} 필요
			작동 시 확률적으로 아래 중 하나 발동:
			>>> {{Collectible287}} 일부 위치를 보여줌
			>>> 포탈 소환
			>>> 카드를 제시
			>>> 제시한 카드를 사용
			카드를 제시한 상태에서 폭파 시 해당 카드가 드랍됩니다.
		]],
	},
	["6."..FiendFolio.FF.EvilBeggar.Var..".0"] = {
		_descType = "entity",
		Name = "짐승 거지",
		Description = [[
			1{{Heart}}(최대 체력)/2{{SoulHeart}} 필요
			{{ItemPoolDevil}} 1~3회 기부 시 악마방 아이템을 주고 떠납니다.
		]],
	},
	["6."..FiendFolio.FF.CellGame.Var..".0"] = {
		_descType = "entity",
		Name = "셀 게임",
		Description = [[
			1{{Key}} 필요
			확률적으로 제시한 아이템을 받을 수 있습니다.
		]],
	},
	["6."..FiendFolio.FF.GoldenSlotMachine.Var..".0"] = {
		_descType = "entity",
		Name = "황금 슬롯머신",
		Description = [[
			1{{Coin}} 필요
			작동 시 랜덤 보상을 획득하며;
			슬롯머신은 그 스테이지의 랜덤 방으로 이동합니다.
		]],
	},
	["6."..FiendFolio.FF.DiceDispenser.Var..".0"] = {
		_descType = "entity",
		Name = "주사위 자판기",
		Description = [[
			4{{Coin}} 필요
			작동 시 랜덤 주사위 조각을 드랍합니다.
		]],
	},
	["6."..FiendFolio.FF.PennyPress.Var..".0"] = {
		_descType = "entity",
		Name = "페니 프레스기",
		Description = [[
			11{{Coin}} 필요, 일회용
			작동 시 랜덤 페니류 장신구를 생성합니다.
		]],
	},
	["6."..FiendFolio.FF.MilkMachine.Var..".0"] = {
		_descType = "entity",
		Name = "밀크 제조기",
		Description = [[
			밀크 자판기 : 5{{Coin}} 필요
			양쪽의 품질, 플레이버에 따라 능력치가 증가 및 감소합니다.
		]],
	},
	["6."..FiendFolio.FF.MilkFlavorContainer.Var..".0"] = {
		_descType = "entity",
		Name = "밀크 제조기",
		Description = [[
			플레이버 뽑기 : 1{{Coin}} 필요
			증가시킬 능력치와 감소시킬 능력치가 하나씩 랜덤으로 지정됩니다.
		]],
	},
	["6."..FiendFolio.FF.MilkQualityModulator.Var..".0"] = {
		_descType = "entity",
		Name = "밀크 제조기",
		Description = [[
			품질 관리기 : 1{{Coin}} 필요
			확률적으로 우유의 품질을 강화시킵니다.
			!!! 강화 실패 시 하락
		]],
	},
	--#endregion
	--#region GOLEM
	["6."..FiendFolio.FF.MiningMachine.Var..".0"] = {
		_descType = "entity",
		Name = "채굴기",
		Description = [[
			{{ffRock}} 현재 들고 석기와 {{Coin}}동전 3개를 소모하여 다른 석기류로 교체합니다.
		]],
	},
	["6."..FiendFolio.FF.BismuthBeggar.Var..".0"] = {
		_descType = "entity",
		Name = "분해기",
		Description = [[
			{{SoulHeart}} 현재 들고 있는 장신구를 소울하트 1~1.5개로 분해합니다.
		]],
	},
	["6."..FiendFolio.FF.UnfinishedGolem.Var..".0"] = {
		_descType = "entity",
		Name = "미완성 골렘",
		Description = [[
			!!! 홀수 스테이지에만 등장
			폭파 시 랜덤 석기류를 드랍합니다.
		]],
	},
	["6."..FiendFolio.FF.Sourpuss.Var..".0"] = {
		_descType = "entity",
		Name = "은둔자",
		Description = [[
			!!! 짝수 스테이지에서만 등장
			{{SoulHeart}} 소울하트 1.5칸을 소모하여 현재 소지 중인 석기류를 흡수합니다.
			!!! 가능한 경우 흡수된 석기의 효과는 원래 효과의 66%로 줄어듭니다.
		]],
	},
	["6."..FiendFolio.FF.GeodeGolem.Var..".0"] = {
		_descType = "entity",
		Name = "정동 골렘",
		Description = [[
			!!! 스테이지 당 일회용
			현재 들고 있는 석기를 {{ColorTeal}}정동류{{CR}} 2개로 바꿉니다.
			정동류의 경우 해당 석기를 복제합니다.
		]],
	},
	["6."..FiendFolio.FF.GeodeGolem.Var..".1"] = {
		_descType = "entity",
		Name = "정동 골렘",
		Description = [[
			!!! 이미 사용됨. 다음 스테이지부터 등장 시 다시 사용할 수 있습니다.
		]],
	},
	["6."..FiendFolio.FF.Babi.Var..".0"] = {
		_descType = "entity",
	},
	["6."..FiendFolio.FF.Midarizer.Var..".0"] = {
		_descType = "entity",
		Name = "미다라이저",
		Description = [[
			현재 들고 석기와 {{Coin}}동전 10개를 소모하여 황금 형태로 바꿉니다.
			사용 후 50%의 확률로 비활성화되어 더 이상 사용할 수 없게 됩니다.
		]],
	},
	["6."..FiendFolio.FF.Midarizer.Var..".10"] = {
		_descType = "entity",
		Name = "미다라이저",
		Description = [[
			!!! 비활성화됨. 다음 스테이지부터 등장 시 다시 사용할 수 있습니다.
		]],
	},
	["6."..FiendFolio.FF.Sweetpuss.Var..".0"] = {
		_descType = "entity",
		Name = "스윗퍼스",
		Description = [[
			!!! 일회용
			현재 들고 있는 장신구를 {{ColorRed}}화석류{{CR}}로 바꿉니다.
			화석류의 경우 해당 석기를 파괴합니다.
		]],
	},
	--#endregion
	--#endregion

	--#region CURSES
	[CURSE..(1 << (FiendFolio.curses.impCurse - 1))] = {
		_descType = "curse",
		Name = "임프의 저주",
		Icon = "ffCurseImpSmall",
		Description = [[
			{{Heart}} 하트 픽업이 50%의 확률로 Fiend의 부하로 바뀝니다.
			바뀐 Fiend의 부하는 방 3개 클리어 시 사라집니다.
			{{Collectible260}} Black Candle: Fiend의 부하 적용 확률에서 하트 픽업 보존
		]],
	},
	[CURSE..(1 << (FiendFolio.curses.stoneCurse - 1))] = {
		_descType = "curse",
		Name = "무게의 저주",
		Icon = "ffCurseStoneSmall",
		Description = [[
			{{SpeedSmall}} 이동속도 +0.3
			{{SpeedSmall}} 소지 중인 장신구/카드/알약 수만큼 이동속도 -0.3
			{{SpeedSmall}} 수량이 0개인 경우 추가 이동속도 +0.15
			{{Collectible260}} Black Candle: 추가 이동속도만 적용
		]],
	},
	[CURSE..(1 << (FiendFolio.curses.sunCurse - 1))] = {
		_descType = "curse",
		Name = "태양의 저주",
		Icon = "ffCurseSunSmall",
		Description = [[
			{{SpeedSmall}}/{{TearsSmall}}/{{DamageSmall}}/{{ShotspeedSmall}} 능력치 배율 x1.1
			패널티 피격 시 x0.85로 감소
			능력치 패널티는 방 3개 클리어 시 복구됩니다.
			{{Collectible260}} Black Candle: 저주 효과 제거
		]],
	},
	[CURSE..(1 << (FiendFolio.curses.swineCurse - 1))] = {
		_descType = "curse",
		Name = "꿀꿀이의 저주",
		Icon = "ffCurseSwineSmall",
		Description = [[
			{{Coin}} 적 처치 시 50%의 확률로 동전을 드랍합니다.
			{{Coin}} {{ColorOrange}}모든{{CR}} 동전 픽업이 빠르게 사라집니다.
			{{Collectible260}} Black Candle: 적 처치 시 나오는 동전만 적용
		]],
	},
	[CURSE..(1 << (FiendFolio.curses.ghostCurse - 1))] = {
		_descType = "curse",
		Name = "유령의 저주",
		Icon = "ffCurseGhostSmall",
		Description = [[
			조준점이 표시되며 적과 캐릭터에게 피해를 주는 유령비가 떨어집니다.
			{{Fear}} 유령비는 적에게 6.66의 공포 피해를 줍니다.
			{{Collectible260}} Black Candle: 유령비가 캐릭터에게 피해를 주지 않음
		]],
	},
	[CURSE..(1 << (FiendFolio.curses.scytheCurse - 1))] = {
		_descType = "curse",
		Name = "낫의 저주",
		Icon = "ffCurseScytheSmall",
		Description = [[
			적에게 피해를 줄 때마다 캐릭터가 붉어집니다.
			{{TearsSmall}} 완전히 붉어지면 멍듦 상태가 되나 연사가 대폭 증가합니다.
			{{ffBruise}} 캐릭터가 멍듦 상태일 때 피격 무적 시간 감소
			{{Collectible260}} Black Candle: 캐릭터가 멍듦 상태가 되지 않음
		]],
	},
	[CURSE..(1 << (FiendFolio.curses.masterCurse - 1))] = {
		_descType = "curse",
		Name = "마스터의 저주",
		Icon = "ffCurseMasterSmall",
		Description = [[
			{{ColorOrange}}스타일{{CR}}: 캐릭터의 실력을 나타내는 척도가 추가됩니다.
			방을 빨리 클리어할 때마다 스타일 수치 증가
			패널티 피격 시 스타일 수치 감소
			스타일 수치에 따라 픽업과 아이템의 등급이 결정됩니다.
			{{Collectible260}} Black Candle: 스타일 수치가 낮아도 픽업 및 아이템의 등급이 하락하지 않음
		]],
	},
	[CURSE..(1 << (FiendFolio.curses.dynamoCurse - 1))] = {
		_descType = "curse",
		Name = "폭약의 저주",
		Icon = "ffCurseDynamoSmall",
		Description = [[
			{{Burning}} 주기적으로 적이 랜덤 방향으로 보라색 화염을 던집니다.
			!!! 화염 명중 시 폭발합니다.
			{{Collectible260}} Black Candle: 화염이 파란색으로 바뀌며 3회 명중 시 사라짐
		]],
	},
	[CURSE..(1 << (FiendFolio.curses.lunacyCurse - 1))] = {
		_descType = "curse",
		Name = "광기의 저주",
		Icon = "ffCurseLunacySmall",
		Description = [[
			{{ffBerserk}} 주기적으로 적이 폭주에 걸립니다.
			{{Collectible260}} Black Candle: 확률적으로 폭주 대신 매혹에 걸림
		]],
	},
	[CURSE..(1 << (FiendFolio.curses.veilCurse - 1))] = {
		_descType = "curse",
		Name = "베일의 저주",
		Icon = "ffCurseVeilSmall",
		Description = [[
			픽업과 상자 종류를 알 수 없습니다.
		]],
	},
	[CURSE..(1 << (FiendFolio.curses.gateCurse - 1))] = {
		_descType = "curse",
		Name = "게이트의 저주",
		Icon = "ffCurseGateSmall",
		Description = [[
			일부 특수방이 사슬로 잠겨 입장할 수 없습니다.
			열쇠가 새겨진 타일이 있는 방 클리어 시 유령 열쇠를 드랍합니다.
			사슬로 잠긴 문은 유령 열쇠로 열 수 있습니다.
		]],
	},
	--#endregion
}

--#region 중복 엔트리
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

entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.THE_WAR_HORN_CHARGING] = entries[ITEM..FiendFolio.ITEM.COLLECTIBLE.THE_WAR_HORN]

entries[CARD..FiendFolio.ITEM.CARD.STUD_2] = entries[CARD..FiendFolio.ITEM.CARD.STUD]
entries[CARD..FiendFolio.ITEM.CARD.STUD_3] = entries[CARD..FiendFolio.ITEM.CARD.STUD]
entries[CARD..FiendFolio.ITEM.CARD.STUD_4] = entries[CARD..FiendFolio.ITEM.CARD.STUD]
entries[CARD..FiendFolio.ITEM.CARD.STUD_5] = entries[CARD..FiendFolio.ITEM.CARD.STUD]
entries[CARD..FiendFolio.ITEM.CARD.STUD_6] = entries[CARD..FiendFolio.ITEM.CARD.STUD]

-- TODO 매운열쇠 설명 분리
entries["5.30."..FiendFolio.PICKUP.KEY.SUPERSPICY] = entries["5.30."..FiendFolio.PICKUP.KEY.SPICY]
entries["5.30."..FiendFolio.PICKUP.KEY.CHARGEDSPICY] = entries["5.30."..FiendFolio.PICKUP.KEY.SPICY]
entries["5.30."..FiendFolio.PICKUP.KEY.SPICY_BOX] = entries["5.30."..FiendFolio.PICKUP.KEY.SPICY]
entries["5.30."..FiendFolio.PICKUP.KEY.SUPERSPICY_BOX] = entries["5.30."..FiendFolio.PICKUP.KEY.SPICY]
entries["5.30."..FiendFolio.PICKUP.KEY.CHARGEDSPICY_BOX] = entries["5.30."..FiendFolio.PICKUP.KEY.SPICY]
entries["5.30."..FiendFolio.PICKUP.KEY.SPICY_PERM] = entries["5.30."..FiendFolio.PICKUP.KEY.SPICY]
entries["5.30."..FiendFolio.PICKUP.KEY.SUPERSPICY_PERM] = entries["5.30."..FiendFolio.PICKUP.KEY.SPICY]
entries["5.30."..FiendFolio.PICKUP.KEY.CHARGEDSPICY_PERM] = entries["5.30."..FiendFolio.PICKUP.KEY.SPICY]

entries["5.40."..FiendFolio.PICKUP.BOMB.DOUBLE_COPPER] = entries["5.40."..FiendFolio.PICKUP.BOMB.COPPER]
entries["5.40."..FiendFolio.PICKUP.BOMB.MIXED_DOUBLE] = entries["5.40."..FiendFolio.PICKUP.BOMB.COPPER]
--#endregion

-- 주사위방
local diceTable = {
  [881] = {"881", "12번", "{{Collectible386}} 스테이지 안의 모든 장애물 변경"},
  [882] = {"882", "12번", "{{Collectible386}} 스테이지 안의 모든 장애물 변경"}
}
EID:updateDescriptionsViaTable(diceTable, EID.descriptions["ko_kr"].dice)

--#region Golem Rarity
local function FF_EIDKR_GolemRarityCondition(descObj)
	if EID:getLanguage() ~= "ko_kr" and EID:getLanguage() ~= "ko" then return false end
	if descObj.ObjType == 5 and descObj.ObjVariant == 350 then
		return FiendFolio.RockTrinkets[descObj.ObjSubType] or FiendFolio.GolemTrinketWhitelist[descObj.ObjSubType]
	end
	return false
end

local function FF_EIDKR_GolemRarityCallback(descObj)
	local rarity = FiendFolio.RockTrinkets[descObj.ObjSubType] or FiendFolio.GolemTrinketWhitelist[descObj.ObjSubType]
	local appendDesc = ""
	if rarity == -2 then
		--appendDesc = "#{{Player" .. mod.PLAYER.GOLEM .. "}} 석기 레어도 : {{Quality0}}"
	elseif rarity == 0 then
		appendDesc = "#{{Player" .. mod.PLAYER.GOLEM .. "}} 석기 레어도: {{Quality0}} {{ColorSilver}}커먼"
		descObj.Quality = 0
	elseif rarity == 1 then
		appendDesc = "#{{Player" .. mod.PLAYER.GOLEM .. "}} 석기 레어도: {{Quality1}} {{ColorLime}}레어"
		descObj.Quality = 1
	elseif rarity == 2 then
		appendDesc = "#{{Player" .. mod.PLAYER.GOLEM .. "}} 석기 레어도: {{Quality2}} {{ColorCyan}}핀디쉬"
		descObj.Quality = 2
	elseif rarity == 3 then
		appendDesc = "#{{Player" .. mod.PLAYER.GOLEM .. "}} 석기 레어도: {{Quality3}} {{ColorPurple}}슈퍼레어"
		descObj.Quality = 3
	elseif rarity == -1 then
		appendDesc = "#{{Player" .. mod.PLAYER.GOLEM .. "}} 석기 레어도: {{Quality4}} {{ColorYellow}}울트라레어"
		descObj.Quality = 4
	end
	descObj.Description = descObj.Description .. appendDesc
	return descObj
end

EID:addDescriptionModifier("FF_EIDKR_GolemRarity", FF_EIDKR_GolemRarityCondition, FF_EIDKR_GolemRarityCallback)
--#endregion

--#region Golem Slot
local function FF_EIDKR_RockSlotCondition(descObj)
	if EID:getLanguage() ~= "ko_kr" and EID:getLanguage() ~= "ko" then return false end
	if not descObj.ObjType == EntityType.ENTITY_SLOT then return false end
	if not descObj.Entity then return end
	if descObj.ObjVariant == FiendFolio.FF.MiningMachine.Var
	or descObj.ObjVariant == FiendFolio.FF.BismuthBeggar.Var
	or descObj.ObjVariant == FiendFolio.FF.Sourpuss.Var
	or (descObj.ObjVariant == FiendFolio.FF.GeodeGolem.Var and descObj.ObjSubType == 0)
	or (descObj.ObjVariant == FiendFolio.FF.Midarizer.Var and descObj.ObjSubType ~= 10)
	or descObj.ObjVariant == FiendFolio.FF.Sweetpuss.Var
	then
		local holdUpRockRange = 100

		local game = Game()
		local slot = descObj.Entity
		local anim = slot:GetSprite():GetAnimation()
		for i=0, game:GetNumPlayers()-1 do
			local player = game:GetPlayer(i)
			local data = player:GetData()

			if player and player:Exists() then
				local trinket
				if slot.Variant == FiendFolio.FF.Midarizer.Var then
					trinket = FiendFolio.GetMostRecentRockTrinket(player, nil, true)
				else
					trinket = FiendFolio.GetMostRecentRockTrinket(player)
				end
				local price = FiendFolio.GetGrindPriceForTrinket(trinket, player)

				local shouldHoldUpRockTrinket = trinket > 0
					and (data.holdingUpRockTouchingPickup or 0) == 0
					and not player:IsHoldingItem()
					and (anim == 'Idle' or anim == 'IdleRandom')
					and player.Position:Distance(slot.Position) < holdUpRockRange
					and player:GetShootingInput():Length() < 0.1
					and not (slot.Variant == FiendFolio.FF.MiningMachine.Var and player:GetNumCoins() < price)
					and not (slot.Variant == FiendFolio.FF.Sourpuss.Var and player:GetSoulHearts() < 3)

				return shouldHoldUpRockTrinket
			end

		end
	end
end

local function FF_EIDKR_RockSlotCallback(descObj)
	for i = 0, Game():GetNumPlayers() -1 do
		local player = Isaac.GetPlayer()
		local data = player:GetData()
		local trinket = FiendFolio.GetMostRecentRockTrinket(player)
		if data.isHoldingUpRockTrinket and trinket > 0 then
			trinket = trinket % TrinketType.TRINKET_GOLDEN_FLAG
			local demoDescObj = EID:getDescriptionObj(5, 350, trinket)

			local appendDesc = "#{{ArrowGrayDown}} 소모할 석기:#"
			if descObj.ObjVariant == FiendFolio.FF.MiningMachine.Var then
				appendDesc = "#{{ArrowGrayDown}} {{ColorLightOrange}}소모할 석기{{CR}}: #"
			elseif descObj.ObjVariant == FiendFolio.FF.BismuthBeggar.Var then
				appendDesc = "#{{ArrowGrayDown}} {{ColorPastelBlue}}분해할 석기{{CR}}: #"
			elseif descObj.ObjVariant == FiendFolio.FF.Sourpuss.Var then
				appendDesc = "#{{ArrowGrayDown}} {{ColorSilver}}흡수할 석기{{CR}}: #"
			elseif descObj.ObjVariant == FiendFolio.FF.Midarizer.Var then
				appendDesc = "#{{ArrowGrayDown}} {{ColorGold}}강화할 석기{{CR}}: #"
			elseif descObj.ObjVariant == FiendFolio.FF.Sweetpuss.Var then
				appendDesc = "#{{ArrowGrayDown}} {{ColorEIDError}}소모할 석기{{CR}} : #"
			end
			appendDesc = appendDesc .. "{{Trinket"..trinket.."}} {{ColorEIDObjName}}" .. demoDescObj.Name .. "#" .. demoDescObj.Description .. "#"
			EID:appendToDescription(descObj, appendDesc)
			break
		end
	end

	return descObj
end
EID:addDescriptionModifier("FF_EIDKR_GolemMachines", FF_EIDKR_RockSlotCondition, FF_EIDKR_RockSlotCallback)
--#endregion

--#region Vending Machine
local function FF_EIDKR_VendingCondition(descObj)
	if EID:getLanguage() ~= "ko_kr" and EID:getLanguage() ~= "ko" then return false end
	if not descObj.ObjType == EntityType.ENTITY_SLOT then return false end
	if not descObj.Entity then return end
	if EID:hasCurseBlind() then return end


	if descObj.ObjVariant == FiendFolio.FF.VendingMachine.Var
	or descObj.ObjVariant == FiendFolio.FF.VendingMachineFF.Var
	then
		local slot = descObj.Entity:ToSlot()
    local sprite, d = slot:GetSprite(), mod:GetEntityData(slot)
		return d.state ~= "dead"
	end
end

local function FF_EIDKR_VendingCallback(descObj)

	local prepend = "" 
	local slot = descObj.Entity:ToSlot()
	local sprite, d = slot:GetSprite(), mod:GetEntityData(slot)

	prepend = prepend .. "!!! "..d.price.."{{Coin}} 소모, 발동 시 아래 아이템 즉시 사용#"
	descObj.Description = prepend .. descObj.Description

	return descObj
end
--EID:addDescriptionModifier("FF_EIDKR_VendingMachines", FF_EIDKR_VendingCondition, FF_EIDKR_VendingCallback)
--#endregion

--#region Milk Machine
--[[  
	밀크 머신 eid 표시
	- 우측 품질 관리기 : 배율 증가, 일반 증가, 일반 감소, 배율 감소
]]

local function getSlotSave(slot)
  return FiendFolio.getFieldInit(FiendFolio.savedata, 'run', 'level', 'SlotData', tostring(slot.InitSeed), {})
end

local function slotIsDead(slot)
  return slot:GetSprite():IsPlaying("Destroyed")
end

local function calcMilkColor(pos,neg,quality)
	local col1 = mod.MILK.COLORS[pos].UP.Color
	local col2 = mod.MILK.COLORS[neg].DOWN.Color
	quality = quality or 1
	return Color.Lerp(col2,col1,quality * 1/6)
end

local function getMilkColor(slot, d)
	local flavorModule = d.FlavorContainer
	if flavorModule and flavorModule:Exists() and not slotIsDead(flavorModule) then
		local flavaSave = getSlotSave(flavorModule)
		return flavaSave.containedPosMilk, flavaSave.containedNegMilk
	else
		local milk1, milk2 = mod:selectMilk(slot:GetDropRNG())
		return milk1, milk2
	end
end

local function getMilkQuality(slot, d)
	local qualityModule = d.QualityModulator
	if qualityModule and qualityModule:Exists() and not slotIsDead(qualityModule) then
		local qualitySave = getSlotSave(qualityModule)
		return qualitySave.QualityLevel
	else
		return 0
	end
end

local function FF_EIDKR_MilkMachineCondition(descObj)
	if EID:getLanguage() ~= "ko_kr" and EID:getLanguage() ~= "ko" then return false end
	if descObj.ObjType ~= EntityType.ENTITY_SLOT then return false end
	if not (descObj.Entity and descObj.Entity:Exists() and descObj.Entity:ToSlot()) then return end

	if descObj.ObjVariant == FiendFolio.FF.MilkMachine.Var then
		local slot = descObj.Entity:ToSlot()
		local sprite, d = slot:GetSprite(), mod:GetEntityData(slot)
		local saveData = FiendFolio.getFieldInit(FiendFolio.savedata, 'run', 'level', 'SlotData', tostring(slot.InitSeed), {})
		local milkColorPos, milkColorNeg = getMilkColor(slot, d)
		local milkQuality = getMilkQuality(slot, d)
		return not slotIsDead(descObj.Entity:ToSlot()) and (d.state == "idleMilk" or (milkColorPos and milkColorNeg))
	elseif descObj.ObjVariant == FiendFolio.FF.MilkQualityModulator.Var then
		local slot = descObj.Entity:ToSlot()
		return not (slotIsDead(slot) or slotIsDead(slot.Parent))
	elseif descObj.ObjVariant == FiendFolio.FF.MilkFlavorContainer.Var then
		local slot = descObj.Entity:ToSlot()
		return not( slotIsDead(slot) or slotIsDead(slot.Parent))
	end
end

local milkStatKeyToDesc = {
	["TEARS"] = "{{TearsSmall}} 연사",
	["DAMAGE"] = "{{DamageSmall}} 공격력",
	["SPEED"] = "{{SpeedSmall}} 이동속도",
	["RANGE"] = "{{RangeSmall}} 사거리",
	["SHOTSPEED"] = "{{ShotspeedSmall}} 탄속",
	["LUCK"] = "{{LuckSmall}} 행운",
}

local milkStat = {
	["TEARS"] = { 0.15, -0.15, 1.25, 0.75, true},
	["DAMAGE"] = { 0.2, -0.2, 1.1, 0.9, true},
	["SPEED"] = { 0.1, -0.1, 0.15, -0.15},
	["RANGE"] = { 0.5, -0.5, 1.5, -1.5},
	["SHOTSPEED"] = { 0.1, -0.1, 0.15, -0.15},
	["LUCK"] = { 1, -1, 5, -5},
}

local function FF_EIDKR_MilkMachineCallback(descObj)
	local slot = descObj.Entity:ToSlot()
	local sprite, d = slot:GetSprite(), mod:GetEntityData(slot)
	if descObj.ObjVariant == FiendFolio.FF.MilkMachine.Var then
		local pos, neg, quality
		local appendDesc = ""

		if d.state == "idleMilk" then
			local saveData = FiendFolio.getFieldInit(FiendFolio.savedata, 'run', 'level', 'SlotData', tostring(slot.InitSeed), {})

			quality = saveData.MilkDeets.Quality

			pos = saveData.MilkDeets.ColorPos
			neg = saveData.MilkDeets.ColorNeg
			appendDesc = appendDesc .. "# 최종 우유 품질 : "
		else
			pos, neg = getMilkColor(slot, d)
			quality = getMilkQuality(slot, d)
			appendDesc = appendDesc .. "# 예상 우유 품질 : "
		end
		appendDesc = appendDesc .. "{{Quality"..quality.."}}"

		local balanceTable = mod.MILK.BALANCE[quality]

		local posStat = milkStat[pos]
		local negStat = milkStat[neg]

		local isPosMult = posStat[5]
		local isNegMult = negStat[5]

		if isPosMult then
			appendDesc = appendDesc .. "#{{IND}}↑ " .. milkStatKeyToDesc[pos] .. " +".. (posStat[1] * balanceTable.UP)
			if balanceTable.UPMULT ~= 0 then
				appendDesc = appendDesc .. "#{{IND}}↑ " .. milkStatKeyToDesc[pos] .. " 배율 x".. (posStat[3] * balanceTable.UPMULT)
			end
		else
			appendDesc = appendDesc .. "#{{IND}}↑ " .. milkStatKeyToDesc[pos] .. " +".. ((posStat[1] * balanceTable.UP) + (posStat[3] * balanceTable.UPMULT))
		end

		if isNegMult then
			appendDesc = appendDesc .. "#{{IND}}↓ " .. milkStatKeyToDesc[neg] .. " ".. (posStat[2] * balanceTable.DOWN)
			if balanceTable.DOWNMULT ~= 0 then
				appendDesc = appendDesc .. "#{{IND}}↓ " .. milkStatKeyToDesc[neg] .. " 배율 x".. (posStat[4] * balanceTable.DOWNMULT)
			end
		else
			appendDesc = appendDesc .. "#{{IND}}↓ " .. milkStatKeyToDesc[neg] .. " ".. ((posStat[2] * balanceTable.DOWN) + (posStat[4] * balanceTable.DOWNMULT))
		end

		EID:appendToDescription(descObj, appendDesc)
	elseif descObj.ObjVariant == FiendFolio.FF.MilkQualityModulator.Var then
		local saveData = FiendFolio.getFieldInit(FiendFolio.savedata, 'run', 'level', 'SlotData', tostring(slot.InitSeed), {})
		local quality = saveData.QualityLevel
		local appendDesc = ""
		appendDesc = appendDesc .. "#우유 품질 : {{Quality"..quality.."}}"

		local balanceTable = mod.MILK.BALANCE[quality]
		local posCount = balanceTable.UP + (balanceTable.UPMULT * 2)
		local negCount = balanceTable.DOWN + (balanceTable.DOWNMULT * 2)

		appendDesc = appendDesc .. "#↑ 능력치 증가 비중치 : ".. posCount
		appendDesc = appendDesc .. "#↓ 능력치 감소 비중치 : ".. negCount

		EID:appendToDescription(descObj, appendDesc)
	elseif descObj.ObjVariant == FiendFolio.FF.MilkFlavorContainer.Var then
		local saveData = FiendFolio.getFieldInit(FiendFolio.savedata, 'run', 'level', 'SlotData', tostring(slot.InitSeed), {})
		local milkColorPos, milkColorNeg = saveData.containedPosMilk, saveData.containedNegMilk
		if milkColorPos and milkColorNeg then
			local appendDesc = ""
			appendDesc = appendDesc .. "#↑ 능력치 증가 : " .. milkStatKeyToDesc[milkColorPos]
			appendDesc = appendDesc .. "#↓ 능력치 감소 : " .. milkStatKeyToDesc[milkColorNeg]
			EID:appendToDescription(descObj, appendDesc)
		end
	end
	return descObj
end
EID:addDescriptionModifier("FF_EIDKR_MilkMachine", FF_EIDKR_MilkMachineCondition, FF_EIDKR_MilkMachineCallback)

--#endregion

--#region Empty Book
local function FF_EIDKR_EmptyBookCondition(descObj)
	if EID:getLanguage() ~= "ko_kr" and EID:getLanguage() ~= "ko" then return false end
	if not FiendFolio.savedata.run.emptybookeffects then return false end
	if not (descObj.ObjType == EntityType.ENTITY_PICKUP and descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE) then return false end
	return (descObj.ObjSubType == FiendFolio.ITEM.COLLECTIBLE.MY_STORY_2 or descObj.ObjSubType == FiendFolio.ITEM.COLLECTIBLE.MY_STORY_4 or descObj.ObjSubType == FiendFolio.ITEM.COLLECTIBLE.MY_STORY_6)
end
local checkNames = {
	[FiendFolio.ITEM.COLLECTIBLE.MY_STORY_2] = "short story",
	[FiendFolio.ITEM.COLLECTIBLE.MY_STORY_4] = "average story",
	[FiendFolio.ITEM.COLLECTIBLE.MY_STORY_6] = "long story",
}
local function FF_EIDKR_EmptyBookCallback(descObj)
	local effects
	local multiplier
	local existingEffects = FiendFolio.savedata.run.emptybookeffects
	local appendDesc = "!!! 사용 시:"
	local shouldAppend = true
	if existingEffects then
		if existingEffects and existingEffects[checkNames[descObj.ObjSubType]] then
			effects = existingEffects[checkNames[descObj.ObjSubType]]
			multiplier = Isaac.GetItemConfig():GetCollectible(descObj.ObjSubType).MaxCharges
			multiplier = multiplier and multiplier / 2
		else
			shouldAppend = false
			appendDesc = "!!! 랜덤 효과를 2번 발동합니다."
			effects = {"wild", "wild"}
			multiplier = 2
		end

		if effects and multiplier and shouldAppend then
			for _, effect in ipairs(effects) do
				while effect == "wild" do
					appendDesc = appendDesc .. "#랜덤 효과를 발동합니다."
				end
				if effect == "sad" then
					appendDesc = appendDesc .. "#그 방에서 {{TearsSmall}}연사 +" .. (0.25 * multiplier)
				elseif effect == "frightning" then
					local rangeStr = multiplier == 1 and "주변의 " or "그 방의 "
					local durations = {
						[1] = "7", [2] = "5", [3] = "8"
					}
					appendDesc = appendDesc .. "#{{Fear}} " .. rangeStr .. "적에게 " .. durations[multiplier] .. "초동안 공포를 겁니다."
				elseif effect == "shocking" then
					local rangeStr = multiplier == 1 and "주변의 " or "그 방의 "
					local durations = {
						[1] = 7, [2] = 5, [3] = 8
					}
					appendDesc = appendDesc .. "#{{ffBruise}} " .. rangeStr .. "적을 " .. tostring(math.ceil(durations[multiplier] * 1.5)) .. "초동안 멍들게 합니다."
				elseif effect == "violent" then
					local rangeStr = multiplier == 1 and "주변의 " or "그 방의 "
					local dmgStrings = {
						[1] = "15 + (3 * 현재 스테이지)",
						[2] = "20 + (3 * 현재 스테이지)",
						[3] = "30 + (4 * 현재 스테이지)"
					}
					appendDesc = appendDesc .. "#" .. rangeStr .. "적에게 " .. dmgStrings[multiplier] .. "만큼의 피해를 줍니다."
				elseif effect == "profitable" then
					local coinStrings = {
						[1] = "페니 2개를 드랍합니다.",
						[2] = "페니 1개와 랜덤 동전을 드랍합니다.",
						[3] = "페니 1개, 랜덤 동전 1개, 랜덤 픽업 1개를 드랍합니다."
					}
					appendDesc = appendDesc .. "#{{Coin}} " .. coinStrings[multiplier]
				elseif effect == "religious" then
					appendDesc = appendDesc .. "#{{Collectible584}} Book of Virtues의 불꽃을 " ..tostring(math.ceil(multiplier)) .. "개 소환합니다."
				elseif effect == "love" then
					local heartStrings = {
						[1] = "#{{HalfHeart}} 빨간하트 반칸을 드랍합니다.",
						[2] = "#{{Heart}} 빨간하트 한칸을 드랍합니다.",
						[3] = "#{{SoulHeart}} 소울하트 한칸을 드랍합니다."
					}
					appendDesc = appendDesc .. heartStrings[multiplier]

				elseif effect == "funny" then
					local funnyStrings = {
						[1] = "적을 밀쳐내는 ",
						[2] = "적을 밀쳐내는 독",
						[3] = "주변의 적을 {{Poison}}중독시키는 거대한 독"
					}
					appendDesc = appendDesc .. "#{{Collectible294}} " .. funnyStrings[multiplier] .. "방귀를 뀝니다."

				elseif effect == "mischievous" then
					appendDesc = appendDesc .. "#{{Collectible"..FiendFolio.ITEM.COLLECTIBLE.FIENDS_HORN.."}} Fiend의 부하를 " ..tostring(math.ceil(multiplier)) .. "마리 소환합니다."
				elseif effect == "festering" then
					appendDesc = appendDesc .. "#파란 아군 자폭 벼룩을 " .. tostring(math.ceil(multiplier * 2)) .. "마리 소환합니다."
				end
			end
		end
		descObj.Description = appendDesc .. descObj.Description
		--EID:appendToDescription(descObj, appendDesc)
	end
	return descObj
end
EID:addDescriptionModifier("FF_EIDKR_EmptyBook", FF_EIDKR_EmptyBookCondition, FF_EIDKR_EmptyBookCallback)
--#endregion

--#region Perfect Generic Object modifier override
EID:addDescriptionModifier("FF Perfectly Generic Object", function (descObj)
	local anyoneHas = false
	for _, player in ipairs(PlayerManager.GetPlayers()) do
		for _, id in ipairs({
			FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_1,
			FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_2,
			FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_3,
			FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_4,
			FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_5,
			FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_6,
			FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_8,
			FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_12
		}) do
			if player:HasCollectible(id) then
				anyoneHas = true
				break
			end
		end

		if anyoneHas then
			break
		end
	end
	if anyoneHas and descObj.Entity and descObj.Entity.Type == EntityType.ENTITY_PICKUP and descObj.Entity.Variant == PickupVariant.PICKUP_TAROTCARD then
		local config = Isaac.GetItemConfig():GetCard(descObj.Entity.SubType)

		if config and config.CardType == ItemConfig.CARDTYPE_SPECIAL_OBJECT then
			local collectible = "#{{Collectible" .. mod.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_1 .. "}} "
			local prefix = "{{ColorYellow}}Perfectly Generic Object{{CR}} 충전량: "
			local charge = "{{"..FiendFolio.PocketObjectMimicCharges[descObj.Entity.SubType].."}}{{Battery}}"
			descObj.Description = descObj.Description ..  collectible .. prefix .. charge
		end
	end

	return descObj
end)
--#endregion

--#region Blasphemous modifier override
EID:addDescriptionModifier("FF Blasphemous Trinket", function (descObj)
	if descObj.Entity and descObj.Entity.Type == EntityType.ENTITY_PICKUP and descObj.Entity.Variant == PickupVariant.PICKUP_TRINKET then
		if mod:IsPickupTrinketBlasphemous(descObj.Entity) then
			descObj.Description = descObj.Description .. "#{{DamageSmall}} {{ColorBlasphemous}}공격력 +1"
		end
	end

	return descObj
end)
--#endregion

--#region Crazy Slots
local checkCrazySlot = false

---@param player EntityPlayer
local function renderCrazyError(player)
	local data = mod:GetEntityData(player)
	local sdata = data.ffsavedata

	local ic = Isaac.GetItemConfig()
	local str = ""

	if mod:IsNormalRender(true) then
		if sdata.CrazyErrorSlot then
			local startNum
			local endNum
			local currentNum = sdata.CrazyErrorNum
			if not sdata.CrazyErrorData[1] then
				startNum = currentNum * 100
				endNum = startNum + 99
				for i = startNum, endNum do
					if i % 10 == 0 then
						str = str .. "#{{NoLB}} "
					end
					if ic:GetCollectible(i) and not ic:GetCollectible(i).Hidden then
						str = str .. "{{Collectible"..i.."}}"
					else
						str = str .. "{{Collectible721}}"
					end
				end
			elseif not sdata.CrazyErrorData[2] then
				startNum = sdata.CrazyErrorData[1] * 100
				endNum = startNum + 99
				for i = startNum, endNum do
					if i % 10 == 0 then
						str = str .. "#{{NoLB}}"
						if (i // 10) % 10 == currentNum then
							str = str .. ">>> "
						else
							str = str .. " "
						end
					end
					if ic:GetCollectible(i) and not ic:GetCollectible(i).Hidden then
						str = str .. "{{Collectible"..i.."}}"
					else
						str = str .. "{{Collectible721}}"
					end
				end
			elseif not sdata.CrazyErrorData[3] then
				startNum = (sdata.CrazyErrorData[1] * 100) + (sdata.CrazyErrorData[2] * 10)
				endNum = startNum + 9
				for i = startNum, endNum do
					str = str .. "#{{NoLB}}"
					if (i % 10) == currentNum then
						str = str .. ">>> {{ColorLime}}"
					else
						str = str .. " "
					end
					if ic:GetCollectible(i) and not ic:GetCollectible(i).Hidden then
						str = str .. "{{Collectible"..i.."}} ["..i.."] {{NameOnlyC"..i.."}}{{CR}}"
					else
						str = str .. "{{Collectible721}} ["..i.."] {{ErrorRoom}} 오류방으로 이동{{CR}}"
					end
				end
			end
		end
	end

	if str ~= "" then
		local desc = EID:getDescriptionObj(5, 100, FiendFolio.ITEM.COLLECTIBLE.ERRORS_CRAZY_SLOTS, nil, false)
		desc.Description = str
		EID:displayPermanentText(desc)
	end
end

---@param player EntityPlayer
wakaba_krdesc:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, function (_, player)
	if not player:Exists() then return end
	local data = mod:GetEntityData(player)
	local sdata = data.ffsavedata
	if sdata.CrazyErrorDuration then
		renderCrazyError(player)
		checkCrazySlot = true
	elseif checkCrazySlot then
		EID:hidePermanentText()
		checkCrazySlot = false
	end
end)
--#endregion

--#region Remove English leftover
EID:addDescriptionModifier("EID FF Golden Watch", function (descObj)
	if descObj.Entity and descObj.Entity.Type == 5 and descObj.Entity.Variant == 100 and descObj.Entity.SubType == mod.ITEM.COLLECTIBLE.GOLDEN_WATCH then
			local dmg = 0.0
			if descObj.Entity:ToPickup():IsShopItem() and descObj.Entity:ToPickup().Price >= 0 then 
					local price = descObj.Entity:ToPickup().Price
					dmg = 1.0+(price*mod.ff_goldenWatchMult)
					descObj.Description = "↑ "..price.."{{Coin}} -> 공격력 배율 x"..dmg.."#" .. descObj.Description
			else
					for i = 1, Game():GetNumPlayers() do
							local player = Game():GetPlayer(i-1)
							local sd = mod:GetEntityData(player).ffsavedata.RunEffects
							if sd and descObj.Entity:ToPickup():IsShopItem() and descObj.Entity:ToPickup().Price < 0 then
									local value = sd.goldenWatchValue or 0
									dmg = 1.0+((value+devilValueIncrease)*mod.ff_goldenWatchMult)
									descObj.Description = "↑ 공격력 배율 x"..dmg.."#" .. descObj.Description
							elseif sd and sd.goldenWatchValue and sd.goldenWatchValue > 0 then
									dmg = 1.0+(sd.goldenWatchValue*mod.ff_goldenWatchMult)
									descObj.Description = "↑ 공격력 배율 x"..dmg.."#" .. descObj.Description
							end
					end
			end
	end
	return descObj
end)
--#endregion

--#region Remove English leftover
local collectibleToRemove = {
	[FiendFolio.ITEM.COLLECTIBLE.BACON_GREASE] = "(#{{Trinket122}} Drops Butter)",
	[FiendFolio.ITEM.COLLECTIBLE.DADS_WALLET] = "(#{{Card43}} Drops a credit card on pickup)",
	[FiendFolio.ITEM.COLLECTIBLE.COMMUNITY_ACHIEVEMENT] = "↑(.*) Damage+",
}

local function FF_EIDKR_EtcCondition(descObj)
	if EID:getLanguage() ~= "ko_kr" and EID:getLanguage() ~= "ko" then return false end
	if descObj.ObjType == 5 and descObj.ObjVariant == 100 then
		return collectibleToRemove[descObj.ObjSubType] ~= nil
	end
	return false
end

local function FF_EIDKR_EtcCallback(descObj)
	if descObj.ObjType == 5 and descObj.ObjVariant == 100 and collectibleToRemove[descObj.ObjSubType] then
		local remove = collectibleToRemove[descObj.ObjSubType]
		descObj.Description =  string.gsub(descObj.Description, remove, "")
	end
	return descObj
end

EID:addDescriptionModifier("FF_EIDKR_Etc", FF_EIDKR_EtcCondition, FF_EIDKR_EtcCallback)

EID:removeDescriptionModifier("FiendFolio-Trinkets" .. tostring(FiendFolio.ITEM.TRINKET.CURSED_URN))
--#endregion

for _, entry in pairs(entries) do
	entry.Mod = "Fiend Folio"
end

return entries