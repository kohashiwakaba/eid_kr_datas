if not (Sheriff and SheriffRepentogon) then return end

local CHAR = "-997.-1."
local ITEM = "5.100."
local TRINKET = "5.350."
local CARD = "5.300."
local PILL = "5.70."
local CURSE ="-998.-1."

EID._currentMod = "The Sheriff"
EID:setModIndicatorName("The Sheriff")
EID:setModIndicatorIcon("Player"..Sheriff.Characters.TheSheriff.CHARACTER_ID)

local Items = Sheriff.Items
local Trinkets = Sheriff.Items
local Cards = Sheriff.PocketItems

local TSICON = "{{Player"..Sheriff.Characters.TaintedSheriff.CHARACTER_ID.."}}"

---@type table<string, WakabaDescriptionEntry>
local entries = {
	--#region APPENDS
	--#region MISC
	--#endregion
	--#endregion
	
	--#region PLAYERS
	[CHAR .. Sheriff.Characters.TheSheriff.CHARACTER_ID] = {
		_descType = "player",
		Name = "셰리프",
		ReminderName = "The Sheriff",
		Short = [[
		]],
		Description = [[
			서부의 보안관이 지하실로 내려왔습니다.
			공격이 특수 리볼버 공격으로 바뀌며 공격하지 않는 동안 총탄이 자동으로 충전됩니다.
			멀리 날아간 총탄은 피해량과 탄속이 절반으로 감소합니다.
			{{Collectible]]..Items.QuickDraw.ITEM_ID..[[}} 고유 능력 : 퀵 드로우
		]],
		Birthright = [[
			{{sfBullet}} 적 처치 시 확률적으로 탄창 픽업을 드랍합니다.
			{{sfBullet}} 탄창을 주우면 탄환 +3 (초과 보유 가능)
		]],
		BirthrightQuote = "빼앗고 다시 쓰기",
	},
	[CHAR .. Sheriff.Characters.TaintedSheriff.CHARACTER_ID] = {
		_descType = "player",
		Name = "셰리프-알트",
		ReminderName = "Tainted Sheriff",
		Short = [[
		]],
		Description = [[
			공격이 4발의 특수 리볼버 공격으로 바뀌며 {{ColorOrange}}총탄이 자동으로 충전되지 않습니다.
			{{Collectible]]..Items.Holster.ID..[[}} 고유 능력 : 홀스터
			{{Blank}} 홀스터로 공격 방식을 바꿀 수 있으며 채찍 공격 명중 시 저격 표식이 생깁니다.
			{{Blank}} 저격 상태의 적 명중 시 탄창을 드랍하며 탄창은 캐릭터에게 자동으로 끌려옵니다.
		]],
		Birthright = [[
			저격되지 않은 적을 채찍으로 명중 시 특수 저격 표식이 생깁니다.
			특수 저격 상태의 적이 1초마다 특수 탄창을 드랍합니다. (초과 보유 가능)
		]],
		BirthrightQuote = "쥐어짜내기",
	},
	--#endregion
	
	--#region COLLECTIBLES
	[ITEM..Items.ArmedBombs.ID] = {
		_descType = "collectible",
		Name = "조준 폭탄",
		QuoteDesc = "총알 폭발 폭탄 +5개",
		Description = [[
			↑ {{Bomb}}폭탄 +5
			적이 있는 방에서 폭탄이 더 느리게 터집니다.
			{{sfBullet}} 폭탄이 적을 향해 총탄을 발사하며, 폭탄이 터지면 5방향으로 총탄을 발사합니다.
		]],
	},
	[ITEM..Items.BanditsBandana.ID] = {
		_descType = "collectible",
		Name = "도적의 손수건",
		QuoteDesc = "소매치기다! 지갑을 지켜!",
		Description = [[
			{{sfDazed}} 방 입장 시 25%의 확률로 적이 최소 6.5초간 표적 상태가 됩니다.
			{{sfDazed}} {{ColorOrange}}표적: {{ColorGray}}처치 시 50%의 확률로 동전을 드랍합니다.
		]],
	},
	[ITEM..Items.OilLamp.ID] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[

		]],
	},
	[ITEM..Items.BluntForce.ID] = {
		_descType = "collectible",
		Name = "둔기외상",
		QuoteDesc = "공격성 권위",
		Description = [[
			{{Slow}} 적의 최대 체력이 낮을수록 그 적의 이동속도가 감소합니다.
		]],
	},
	[ITEM..Items.ChewingTobacco.ID] = {
		_descType = "collectible",
		Name = "씹은 담배",
		QuoteDesc = "구내암을 일으킬 수 있음",
		Description = [[
			{{Slow}} 눈물을 21번 발사할 때마다 적을 느리게 하는 눈물을 발사합니다.
			{{Collectible531}} 눈물이 무언가에 부딪히면 작은 눈물 여러개로 나뉘며, 적을 느려지게 하는 장판을 생성합니다.
		]],
	},
	[ITEM..Items.DeaderEye.ITEM_ID] = {
		_descType = "collectible",
		Name = "천리안의 눈",
		QuoteDesc = "집중하고, 호흡하고, 발사하세요",
		Description = [[
			사용 시 조준점으로 목표를 설정하며 (최대 5마리, {{Timer}}조준 중 느려짐);
			{{sfBullet}} 조준을 향해 총탄을 발사, 적에게 최대 체력 비례 피해를 줍니다.
		]],
	},
	[ITEM..Items.LittleRam.ID] = {
		_descType = "collectible",
		Name = "리틀 램",
		QuoteDesc = "웬지 빨간걸 본 것보다 더 화가 난 것 같은데?",
		Description = [[
			{{Throwable}} 공격하는 방향으로 날아갑니다.
			{{Confusion}} 날아가는 도중 적에게 접촉 시 2.5의 혼란 피해를 줍니다.
		]],
	},
	[ITEM..Items.MOAB.ID] = {
		_descType = "collectible",
		Name = "",
		QuoteDesc = "",
		Description = [[
			사용 시 일정 시간 후 거대 폭탄이 떨어집니다. (자해 없음)
			{{sfBullet}} 폭발 시 그 방의 적에게 1000의 방어 무시 피해를 주며 무언가에 반사되는 추가 총탄을 여러 발 발사합니다.
		]],
	},
	[ITEM..Items.QuickDraw.ITEM_ID] = {
		_descType = "collectible",
		Name = "퀵 드로우",
		QuoteDesc = "망설임은 곧 죽음",
		Description = [[
			사용 시 공격하는 방향으로 공격력 x1.36의 총탄을 발사합니다.
			!!! 총탄의 발사 각도는 랜덤
		]],
	},
	[ITEM..Items.TenGallonHat.ID] = {
		_descType = "collectible",
		Name = "10갤런 모자",
		QuoteDesc = "",
		Description = [[
			방 클리어 시 양동이에 물이 찹니다. (최대 8회)
			패널티 피격 시 양동이에 있는 물을 위로 흩뿌립니다.
			{{Blank}} (캐릭터의 눈물효과 적용)
		]],
	},
	[ITEM..Items.Tumbleweed.ITEM_ID] = {
		_descType = "collectible",
		Name = "회전초",
		QuoteDesc = "어디서 오는 거야?!",
		Description = [[
			방 안에 적에게 공격력 x0.4의 피해를 주는 회전초가 굴러다닙니다.
		]],
	},
	[ITEM..Items.Holster.ID] = {
		_descType = "collectible",
		Name = "홀스터",
		QuoteDesc = "맞추고 정복해라",
		Description = [[
			사용 시 공격이 휘두를 수 있는 채찍으로 변경됩니다.
			{{Slow}} 채찍은 적에게 공격력 x0.5의 둔화 피해를 줍니다.
		]],
		Modifiers = {
			{
				ModifierText = "Holster Alternate Description",
				ModifierCond = function (descObj)
					return descObj.ObjType == 5
					and descObj.ObjVariant == 100
					and (descObj.ObjSubType == Sheriff.Items.Holster.ID)
					and PlayerManager.AnyoneIsPlayerType(Sheriff.Characters.TaintedSheriff.CHARACTER_ID)
				end,
				ModifierCallback = function (descObj)
					local onlyTainted = true
					local descToAdd =  [[
						]]..TSICON..[[ {{ColorLime}}사용 시 공격이 휘두를 수 있는 채찍으로 변경됩니다.
						{{ColorLime}}채찍은 적에게 공격력 x0.5의 저격 피해를 줍니다.
						{{ColorLime}}저격된 적 명중 시 탄창을 드랍합니다.
					]]
					for _, player in ipairs(PlayerManager.GetPlayers()) do
						if player:GetPlayerType() ~= Sheriff.Characters.TaintedSheriff.CHARACTER_ID then
							onlyTainted = false
							break
						end
					end
					if onlyTainted then
						descObj.Description = descToAdd
					else
						EID:appendToDescription(descObj.Description, descToAdd)
					end
					return descObj
				end,
			}
		},
	},
	[ITEM..Items.GlassBullets.ID] = {
		_descType = "collectible",
		Name = "유리 총알",
		QuoteDesc = "무모함의 보상, 잃지 마!",
		Description = [[
			적 탄환을 가까스로 피하면 캐릭터의 텐션pt가 증가합니다.
			{{Blank}} (캐릭터 아웃라인 및 효과음으로 확인)
			{{sfBullet}} 텐션pt가 5 이상일 때 공격 시 (공격력 x8 + 10)의 커다란 총알을 발사합니다.
			!!! 피격 시 텐션 pt가 사라짐
		]],
	},
	[ITEM..Items.SpiritOfTheWest.ID] = {
		_descType = "collectible",
		Name = "서부의 정령",
		QuoteDesc = "승리는 당신을 향해 미소를 지어",
		Description = [[
			주기적으로 나왔다가 사라집니다.
			{{Fear}} 랜덤 적 근처에 나오며 적에게 1.66의 공포 피해를 주는 관통 총알을 5발 발사합니다.
		]],
	},
	[ITEM..Items.LightningRod.ID] = {
		_descType = "collectible",
		Name = "피뢰침",
		QuoteDesc = "장족의 기술 발전",
		Description = [[
			소지 중일 때 비가 내리며 주기적으로 랜덤 위치에 100의 피해를 주는 번개가 내리칩니다.
			사용 시 그 자리에 피뢰침을 설치하여 주기적으로 그 위치에 200의 피해를 주는 번개를 내리칩니다. (최대 3회)
			{{Blank}} (번개는 캐릭터에게 피해를 주지 않음)
		]],
	},
	[ITEM..Items.CarriageWheel.ID] = {
		_descType = "collectible",
		Name = "마차 바퀴",
		QuoteDesc = "이동식 상점",
		Description = [[
			스테이지 진입 시 이동식 상점을 소환합니다.
			이동식 상점에서 아이템과 픽업을 각각 하나씩 판매합니다.
		]],
	},
	[ITEM..Items.Pitchfork.ID] = {
		_descType = "collectible",
		Name = "피치포크",
		QuoteDesc = "두번 눌러 찌르기",
		Description = [[
			공격 키를 두번 눌러 공격방향으로 포크를 날립니다.
			{{BleedingOut}} 포크는 날아갈 때 적에게 (공격력 x1 + 5)의 출혈 + 넉백 피해를 줍니다.
		]],
	},
	[ITEM..Items.Lasso.ID] = {
		_descType = "collectible",
		Name = "올가미 밧줄",
		QuoteDesc = "이리 와!",
		Description = [[
			사용 시 공격방향으로 적을 잡을 수 있는 밧줄을 던집니다.
			{{Confusion}} 밧줄 명중 시 그 적을 휘두를 수 있으며 부딪힌 적에게 혼란 피해를 줍니다.
			!!! 밧줄은 폭탄, 픽업, 상자도 집을 수 있음
		]],
	},
	[ITEM..Items.StrangeSprout.ID] = {
		_descType = "collectible",
		Name = "이상한 새싹",
		QuoteDesc = "가시기둥",
		Description = [[
			클리어하지 않은 방 진입 시 거대한 콩나물 줄기가 등장합니다.
			콩나물 줄기는 적의 탄환을 막아주며 접촉한 적에게 피해를 줍니다.
			20초 혹은 일정 수의 피해를 받으면 그 방의 다른 곳에서 다시 등장합니다.
		]],
	},
	--#endregion

	
	--#region TRINKETS
	[TRINKET..Items.OilLamp.ID] = {
		_descType = "trinket",
		Name = "오일램프",
		QuoteDesc = "암흑 속의 빛",
		Description = [[
			{{BossRoom}} 보스방으로 향하는 위치로 날아갑니다.
		]],
	},
	[TRINKET..Items.GoldDust.ID] = {
		_descType = "trinket",
		Name = "금빛 먼지",
		QuoteDesc = "탐욕은 쉬지를 않지",
		Description = [[
			{{Shop}} 상점 주인이 서서히 황금화 되며;
			{{MiniBoss}} 완전 황금화 되면 Greed 미니보스로 변신합니다.
			!!! 방을 나가면 무효화
		]],
	},
	[TRINKET..Items.SeedPouch.ID] = {
		_descType = "trinket",
		Name = "씨앗 주머니",
		QuoteDesc = "GMO는 우리의 M.O.!",
		Description = [[
			적이 있는 방에서 주기적으로 무 줄기가 생깁니다.
			캐릭터가 무를 들고 던질 수 있으며 던진 무는 적에게 (공격력 x2 + 5)의 관통 피해를 줍니다.
		]],
	},
	[TRINKET..Items.ShinyEmerald.ID] = {
		_descType = "trinket",
		Name = "빛나는 에메랄드",
		QuoteDesc = "행운의 보석",
		Description = [[
			방 입장 시 장애물 하나가 오라를 발산하는 에메랄드 결정으로 바뀝니다.
			캐릭터가 오라 안에 있을 시:
			>>> {{LuckSmall}}행운 +7
		]],
	},
	--#endregion
	
	--#region CARDS
	[CARD..Cards.CasinoChip.ID] = {
		_descType = "card",
		Name = "카지노 칩",
		QuoteDesc = "돈 2배?",
		Description = [[
			{{Coin}} 사용 시 그 방의 동전을 50%의 확률로 업그레이드하거나 다운그레이드 시킵니다.
		]],
	},
	[CARD..Cards.SoulOfSheriff.ID] = {
		_descType = "card",
		Name = "셰리프의 영혼",
		QuoteDesc = "정의는 승리하리라",
		Description = [[
			{{sfBullet}} 10초동안 적을 향해 리볼버를 난사합니다.
		]],
	},
	[CARD..Cards.CancerPack.ID] = {
		_descType = "card",
		Name = "암 패키지",
		QuoteDesc = "흡연구역",
		Description = [[
			{{Timer}} 사용 시 1분동안 캐릭터의 자리에 담배 연기를 피웁니다.
			{{Confusion}} 담배 연기는 초당 캐릭터의 공격력 x2의 혼란 피해를 줍니다.
		]],
	},
	--#endregion

	--#region ENTITIES
	["6."..Sheriff.Entities.Rancher.ID..".0"] = {
		_descType = "entity",
		Name = "목동",
		Description = [[
			{{sfBullet}} 3{{Coin}}을 사용하여 특수 사격장으로 이동합니다. (아이템 비활성화)
			{{sfBullet}} {{Timer}} 일정 시간 혹은 {{sfBullet}} 일정 탄수 안에 모든 과녁 명중 시 성공
			{{Blank}} (둘 중 하나의 조건만 랜덤으로 적용)
			{{ArrowUp}} 성공 수에 비례하여 보상을 드랍합니다.
			!!! 3회 성공 혹은 2회 실패 시 떠남
		]],
	},
	--#endregion
}

for _, entry in pairs(entries) do
	entry.Mod = "The Sheriff"
end

return entries