
if Sheriff then

	EID._currentMod = "The Sheriff"


	local Items = Sheriff.Items
	local Trinkets = Sheriff.Items

	local BirthrightDesc = {
		[Sheriff.Characters.TheSheriff.CHARACTER_ID] = {
			Name = "The Sheriff",
			Description = "{{SheriffBullet}} 적 처치 시 확률적으로 탄창 픽업을 드랍합니다.#{{SheriffBullet}} 탄창을 주우면 탄환 +3 (초과 보유 가능)",
			QuoteDesc = "빼앗고 다시 쓰기",
		},
	}
	local CollectibleDesc = {
		[Items.ArmedBombs.ID] = {
			Name = "조준 폭탄",
			Description = "↑ {{Bomb}}폭탄 +5#적이 있는 방에서 폭탄이 더 느리게 터집니다.#폭탄이 적을 향해 총탄을 발사하며, 폭탄이 터지면 5방향으로 총탄을 발사합니다.",
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
			Description = "사용 시 일정 시간 후 거대 폭탄이 떨어집니다. (자해 없음)#{{SheriffBullet}} 폭발 시 적에게 1666의 방어 무시 피해를 주며 무언가에 반사되는 추가 총탄을 여러 발 발사합니다.",
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
	}
	local TrinketDesc = {
		[Items.OilLamp.ID] = {
			Name = "오일램프",
			Description = "{{CurseDarknessSmall}} Darkness 저주에 걸리지 않습니다.#보스방으로 향하는 위치로 날아갑니다.",
			QuoteDesc = "암흑 속의 빛",
		},
	}

	EID:addEntity(6, Sheriff.Entities.Rancher.ID, 0, "목동", "{{SheriffBullet}} 3{{Coin}}을 사용하여 특수 사격장으로 이동합니다. (아이템 비활성화)#{{SheriffBullet}} {{Timer}}일정 시간 혹은 {{SheriffBullet}}일정 탄수 안에 모든 과녁 명중 시 성공#{{Blank}} (둘 중 하나의 조건만 랜덤으로 적용)#{{ArrowUp}} 성공 수에 비례하여 보상을 드랍합니다.", "ko_kr")

	for playerType, birthrightdesc in pairs(BirthrightDesc) do
		EID:addBirthright(playerType, birthrightdesc.Description, birthrightdesc.Name, "ko_kr")
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


	return {
		targetMod = "The Sheriff",
		birthright = BirthrightDesc,
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
	}

end