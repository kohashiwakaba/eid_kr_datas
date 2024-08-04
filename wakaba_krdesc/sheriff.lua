
if Sheriff then

	EID._currentMod = "TSC Unlock API (TheSheriff)"

	local Items = Sheriff.Items
	local Trinkets = Sheriff.Items
	local Cards = Sheriff.PocketItems

	local CharacterDesc = {
		[Sheriff.Characters.TheSheriff.CHARACTER_ID] = {
			Name = "The Sheriff",
			Description = "",
			Detailed = ""
				.."#서부의 보안관이 지하실로 내려왔습니다."
				.."#공격이 특수 리볼버 공격으로 바뀌며 공격하지 않는 동안 총탄이 자동으로 충전됩니다."
				.."#멀리 날아간 총탄은 피해량이 절반으로 감소합니다."
				.."#{{Collectible"..Items.QuickDraw.ITEM_ID.."}} 고유 능력 : 퀵 드로우"
				.."",
			Birthright = "{{SheriffBullet}} 적 처치 시 확률적으로 탄창 픽업을 드랍합니다.#{{SheriffBullet}} 탄창을 주우면 탄환 +3 (초과 보유 가능)",
			QuoteDesc = "빼앗고 다시 쓰기",
		},
		[Sheriff.Characters.TaintedSheriff.CHARACTER_ID] = {
			Name = "Tainted Sheriff",
			Description = "",
			Detailed = ""
				.."#공격이 4발의 특수 리볼버 공격으로 바뀌며 {{ColorOrange}}총탄이 자동으로 충전되지 않습니다."
				.."#{{Collectible"..Items.Holster.ID.."}} 고유 능력 : 홀스터"
				.."#{{Blank}} 홀스터로 공격 방식을 바꿀 수 있으며 채찍 공격 명중 시 저격 표식이 생깁니다."
				.."#{{Blank}} 저격 상태의 적 명중 시 탄창을 드랍하며 탄창은 캐릭터에게 자동으로 끌려옵니다."
				.."",
			Birthright = "저격되지 않은 적을 채찍으로 명중 시 특수 저격 표식이 생깁니다.#특수 저격 상태의 적이 1초마다 특수 탄창을 드랍합니다. (초과 보유 가능)",
			QuoteDesc = "쥐어짜내기",
		},
	}
	local CollectibleDesc = {
		[Items.ArmedBombs.ID] = {
			Name = "조준 폭탄",
			Description = "↑ {{Bomb}}폭탄 +5#적이 있는 방에서 폭탄이 더 느리게 터집니다.#{{SheriffBullet}} 폭탄이 적을 향해 총탄을 발사하며, 폭탄이 터지면 5방향으로 총탄을 발사합니다.",
			QuoteDesc = "총알 폭발 폭탄 +5개",
		},
		[Items.BanditsBandana.ID] = {
			Name = "도적의 손수건",
			Description = "{{BanditDazed}} 방 입장 시 확률적으로 적이 5초간 표적 상태가 됩니다.#{{Coin}} 표적 상태 적 처치 시 50%의 확률로 동전을 드랍합니다.",
			QuoteDesc = "소매치기다! 지갑을 지켜!",
		},
		[Items.BluntForce.ID] = {
			Name = "둔기외상",
			Description = "{{Slow}} 적의 최대 체력이 낮을수록 그 적의 이동속도가 감소합니다.",
			QuoteDesc = "공격성 권위",
		},
		[Items.ChewingTobacco.ID] = {
			Name = "씹은 담배",
			Description = "{{Slow}} 눈물을 21번 발사할 때마다 적을 느리게 하는 눈물을 발사합니다.#{{Collectible531}} 눈물이 무언가에 부딪히면 작은 눈물 여러개로 나뉘며, 적을 느려지게 하는 장판을 생성합니다.",
			QuoteDesc = "구내암을 일으킬 수 있음",
		},
		[Items.DeaderEye.ITEM_ID] = {
			Name = "천리안의 눈",
			Description = "사용 시 조준점으로 목표를 설정하며 (최대 5마리, {{Timer}}조준 중 느려짐);#{{SheriffBullet}} 조준을 향해 총탄을 발사, 적에게 최대 체력 비례 피해를 줍니다.",
			QuoteDesc = "집중하고, 호흡하고, 발사하세요",
		},
		[Items.LittleRam.ID] = {
			Name = "리틀 램",
			Description = "{{Throwable}} 공격하는 방향으로 날아갑니다.#{{Confusion}} 날아가는 도중 적에게 접촉 시 2.5의 혼란 피해를 줍니다.",
			QuoteDesc = "웬지 빨간걸 본 것보다 더 화가 난 것 같은데?",
		},
		[Items.MOAB.ID] = {
			Name = "B.U.R.T.",
			Description = "!!! 일회용#사용 시 일정 시간 후 거대 폭탄이 떨어집니다. (자해 없음)#{{SheriffBullet}} 폭발 시 적에게 1666의 방어 무시 피해를 주며 무언가에 반사되는 추가 총탄을 여러 발 발사합니다.",
			QuoteDesc = "Bullet Unleashing Righteous Terror",
		},
		[Items.QuickDraw.ITEM_ID] = {
			Name = "퀵 드로우",
			Description = "사용 시 공격하는 방향으로 공격력 x1.36의 총탄을 발사합니다.#!!! 총탄의 발사 각도는 랜덤",
			QuoteDesc = "망설임은 곧 죽음",
		},
		[Items.TenGallonHat.ID] = {
			Name = "10갤런 모자",
			Description = "방 클리어 시 양동이에 물이 찹니다. (최대 8회)#패널티 피격 시 양동이에 있는 물을 위로 흩뿌립니다.#{{Blank}} (캐릭터의 눈물효과 적용)",
			QuoteDesc = "넘어지지 않도록",
		},
		[Items.Tumbleweed.ITEM_ID] = {
			Name = "회전초",
			Description = "방 안에 적에게 피해를 주는 회전초가 굴러다닙니다.#{{DamageSmall}} 회전초의 피해량은 캐릭터 공격력에 비례",
			QuoteDesc = "어디서 오는 거야?!",
		},
		[Items.Holster.ID] = {
			Name = "홀스터",
			Description = "사용 시 공격이 휘두를 수 있는 채찍으로 변경됩니다."
			.."#채찍은 적에게 공격력 x0.5의 저격 피해를 줍니다."
			.."#저격된 적 명중 시 탄창을 드랍합니다.",
			QuoteDesc = "맞추고 정복해라",
			NonSheriffDescription = "사용 시 공격이 휘두를 수 있는 채찍으로 변경됩니다."
			.."#채찍은 적에게 공격력 x0.7의 둔화 피해를 줍니다.",
		},
		[Items.GlassBullets.ID] = {
			Name = "유리 총알",
			Description = "적 탄환을 가까스로 피하면 캐릭터의 텐션pt가 증가합니다."
			.."#{{Blank}} (캐릭터 아웃라인 및 효과음으로 확인)"
			.."#{{SheriffBullet}} 텐션pt가 5 이상일 때 공격키를 두번 눌러 공격력 x3의 커다란 총알을 발사합니다."
			.."#!!! 피격 시 텐션 pt가 사라짐",
			QuoteDesc = "무모함의 보상, 잃지 마!",
		},
		[Items.SpiritOfTheWest.ID] = {
			Name = "서부의 정령",
			Description = "주기적으로 나왔다가 사라집니다."
			.."#랜덤 적 근처에 나오며 적에게 1.66의 관통 총알을 5발 발사합니다.",
			QuoteDesc = "승리는 당신을 향해 미소를 지어",
		},
		[Items.LightningRod.ID] = {
			Name = "피뢰침",
			Description = "소지 중일 때 비가 내리며 주기적으로 랜덤 위치에 100의 피해를 주는 번개가 내리칩니다."
			.."#사용 시 그 자리에 피뢰침을 설치하여 주기적으로 그 위치에 200의 피해를 주는 번개를 내리칩니다. (최대 3회)"
			.."#{{Blank}} (번개는 캐릭터에게 피해를 주지 않음)",
			QuoteDesc = "장족의 기술 발전",
		},
	}

	CollectibleDesc[Items.Holster.WHIP_VERSION_ID] = CollectibleDesc[Items.Holster.ITEM_ID]

	local TrinketDesc = {
		[Items.OilLamp.ID] = {
			Name = "오일램프",
			Description = "{{BossRoom}} 보스방으로 향하는 위치로 날아갑니다.",
			QuoteDesc = "암흑 속의 빛",
		},
		[Items.GoldDust.ID] = {
			Name = "금빛 먼지",
			Description =
			"{{Shop}} 상점 주인이 서서히 황금화 되며;"
			.."#{{MiniBoss}} 완전 황금화 되면 Greed 미니보스로 변신합니다."
			.."#!!! 방을 나가면 무효화",
			QuoteDesc = "탐욕은 쉬지를 않지",
		},
		[Items.SeedPouch.ID] = {
			Name = "씨앗 주머니",
			Description = "적이 있는 방에서 주기적으로 무 줄기가 생깁니다."
			.."#캐릭터가 무를 들고 던질 수 있으며 던진 무는 적에게 캐릭터의 공격력 x2의 관통 피해를 줍니다.",
			QuoteDesc = "GMO는 우리의 M.O.!",
		},
	}
	local CardDesc = {
		[Cards.CasinoChip.ID] = {
			Name = "카지노 칩",
			Description = "{{Coin}} 사용 시 그 방의 동전을 50%의 확률로 업그레이드하거나 다운그레이드 시킵니다.",
			QuoteDesc = "돈 2배?",
		},
		[Cards.SoulOfSheriff.ID] = {
			Name = "셰리프의 영혼",
			Description = "{{SheriffBullet}} 10초동안 적을 향해 리볼버를 난사합니다.",
			QuoteDesc = "정의는 승리하리라",
		},
		[Cards.CancerPack.ID] = {
			Name = "암 패키지",
			Description = "{{Timer}} 사용 시 1분동안 캐릭터의 자리에 담배 연기를 피웁니다."
			.."#{{Confusion}} 담배 연기는 초당 캐릭터의 공격력 x2의 혼란 피해를 줍니다.",
			QuoteDesc = "흡연구역",
		},
	}

	EID:addEntity(6, Sheriff.Entities.Rancher.ID, 0, "목동", "{{SheriffBullet}} 3{{Coin}}을 사용하여 특수 사격장으로 이동합니다. (아이템 비활성화)#{{SheriffBullet}} {{Timer}}일정 시간 혹은 {{SheriffBullet}}일정 탄수 안에 모든 과녁 명중 시 성공#{{Blank}} (둘 중 하나의 조건만 랜덤으로 적용)#{{ArrowUp}} 성공 수에 비례하여 보상을 드랍합니다.", "ko_kr")

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
		if itemdesc.Wisps then
			EID.descriptions["ko_kr"].bookOfVirtuesWisps[itemID] = itemdesc.Wisps
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

	local function modifyHolsterCondition(descObj)
		if EID:getLanguage() ~= "ko_kr" then return false end
		return descObj.ObjType == 5
		and descObj.ObjVariant == 100
		and (descObj.ObjSubType == Sheriff.Items.Holster.ID or descObj.ObjSubType == Sheriff.Items.Holster.WHIP_VERSION_ID)
	end

	local function modifyHolsterCallback(descObj)
		local anySheriff = false
		for i = 0, Sheriff.Game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(i)
			if player:GetPlayerType() == Sheriff.Characters.TaintedSheriff.CHARACTER_ID then
				anySheriff = true
				break
			end
		end

		if not anySheriff then
			local descriptions = CollectibleDesc[Sheriff.Items.Holster.ID].NonSheriffDescription
			descObj.Description = descriptions
		end

		return descObj
	end

	EID:addDescriptionModifier("FF_EIDKR_Holster Alternate Description", modifyHolsterCondition, modifyHolsterCallback)



	return {
		targetMod = "TSC Unlock API (TheSheriff)",
		characters = CharacterDesc,
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
		cards = CardDesc,
	}

end