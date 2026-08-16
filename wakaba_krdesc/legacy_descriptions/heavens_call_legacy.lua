
if HeavensCall then

	EID._currentMod = "Heaven's call"
	local mod = HeavensCall

	local V_REPLACE = 0
	local V_APPEND = 1

	local Items = mod.Items
	local Trinkets = mod.Trinkets

	local CollectibleDesc = {
		[Items.Mercurius] = {
			Description = "↑ {{SpeedSmall}}이동속도 +0.23#비행 능력을 얻습니다.#7%의 확률로 적 처치 시 꼬마 아이작 패밀리어를 소환하는 {{ColorTransform}}비스무트{{ColorText}} 공격이 나갑니다.#{{LuckSmall}} 행운 14+일 때 50%#{{Collectible77}} 방 입장 시 5%의 확률로 My Little Unicorn 아이템의 효과를 발동합니다.",
			Name = "수성?",
			QuoteDesc = "당신만의 군대",
		},
		[Items.Venus] = {
			Description = "#{{Collectible687}} 적 15마리 처치 시 캐릭터가 움직이는 방향으로 움직이며 공격하는 방향으로 공격하는 아군 적을 소환합니다.#{{Burning}} 아군 몬스터는 Ctrl 버튼을 꾹 누르면 처치되며 최대 체력에 반비례한 확률로 {{Burning}}불타는 하트를 드랍합니다.#{{Trinket186}} 불타는 하트를 집으면 공격하는 방향으로 돌진하는 Willo를 소환합니다.",
			Name = "금성?",
			QuoteDesc = "밀랍 친구들!",
		},
		[Items.Terra] = {
			Description = "방 입장 시 사과를 소환합니다.#사과를 집으면 체력이 가장 많은 적에게 초당 7의 피해를 주는 뱀을 소환합니다.#시간이 지날 수록 사과가 익으며(최대 2회) 사과 단계에 따라 뱀의 피해량이 증가합니다.",
			Name = "지구?",
			QuoteDesc = "선악과",
		},
		[Items.Mars] = {
			Description = "#사용 시 일정 시간동안 캐릭터가 강한 넉백을 받는 폭발성 레이저를 발사합니다.#발동 중일 때 {{ColorLime}}{{DamageSmall}}x2.5/{{TearsSmall}}x15/{{RangeSmall}}+1.75/{{ShotspeedSmall}}x3{{CR}}, {{ColorRed}}{{SpeedSmall}}-1.2{{CR}}#{{Blank}} 적 처치 시 남은 시간 연장 가능 #!!! 가능한 경우, 카드/알약 슬롯에 배정됩니다.",
			Name = "화성?",
			QuoteDesc = "죽이기 위해 태어난 존재",
		},
		[Items.Jupiter] = {
			Description = "#캐릭터의 위치에 전류가 생깁니다.#전류를 원형으로 완성하면 그 전류에서 레이저 공격을 생성합니다.#!!! 특정 오브젝트에 레이저 공격이 닿을 경우:#{{Slotmachine}} 슬롯류: 폭발 or 무료 1회#{{Battery}} 배터리: 폭발 or 픽업 업그레이드#!!! 상점 주인 : 아군 몬스터로 부활",
			Name = "목성?",
			QuoteDesc = "고압 전류",
		},
		[Items.Saturnus] = {
			Description = "#{{TimerSmall}} 사용 시 방 안의 모든 적 및 눈물/레이저/폭탄의 움직임이 5초간 멈춥니다.#{{Blank}} (레이저는 {{Collectible222}} 효과 적용)#{{Blank}} (설치한 폭탄은 효과 종료 즉시 폭발)#{{ArrowUp}} 발동 중일 때 {{SpeedSmall}}=2/{{TearsSmall}}x3#!!! 가능한 경우, 카드/알약 슬롯에 배정됩니다.",
			Name = "토성?",
			QuoteDesc = "간이 슬로우 모션",
		},
		[Items.Uranus] = {
			Description = "{{PoopPickup}} 공격 반대방향으로 똥 방울이 나갑니다.#{{PoopPickup}} 똥 방울에 맞은 적은 5초동안 {{Weakness}}약화되며 캐릭터의 {{TearsSmall}}/{{DamageSmall}}을 증가시키는 장판을 생성합니다.#{{Collectible725}} 약화된 적 처치 시 그 위치에 IBS 똥을 소환하며; #{{Collectible576}} 적 처치 실패 시 아군 Dip 패밀리어를 소환합니다.",
			Name = "천왕성?",
			QuoteDesc = "뿌지직 천국",
		},
		[Items.Neptunus] = {
			Description = "{{Throwable}} 공격하는 방향으로 삼지창을 날릴 수 있습니다.#삼지창으로 적 처치 시 4%의 확률로 블랙홀을 소환합니다.#{{LuckSmall}} 행운 20+일 때 15%",
			Name = "해왕성?",
			QuoteDesc = "심연이 우리를 드려다볼 때",
		},
	}

	local TrinketDesc = {
		[Trinkets.Shard] = {
			Description = "13%의 확률로 피해를 막으나;#!!! 방 안의 랜덤 위치로 순간이동합니다.",
			Name = "퀀텀 조각",
			QuoteDesc = "언제 어디서나",
		},
		[Trinkets.Sputnik] = {
			Description = "캐릭터의 주변을 돌며 접촉하는 적에게 초당 6의 피해를 줍니다",
			Name = "스푸트닉",
			QuoteDesc = "위성 친구",
		},
		[Trinkets.Flag] = {
			Description = "↑ 망원경 발견 확률 증가#↑ 망원경이 위성 패밀리어를 줄 확률 증가#{{DamageSmall}} 위성 패밀리어의 피해량 증가.",
			Name = "흐려진 깃발",
			QuoteDesc = "달을 향해서",
		},
	}

	EID:addEntity(mod.EntityInf[mod.Entity.Telescope].ID, mod.EntityInf[mod.Entity.Telescope].VAR, mod.EntityInf[mod.Entity.Telescope].SUB, "망원경", "1{{Coin}}을 소모하여 아래 중 하나 발동:#{{Blank}} {{Collectible584}}불꽃#{{Blank}} {{ItemPoolPlanetarium}}천체관 아이템 불꽃#{{Blank}} {{SoulHeart}}소울하트/불타는하트#{{Blank}} {{ColorCyan}}위성 패밀리어", "ko_kr")
	EID:addEntity(mod.EntityInf[mod.Entity.Statue].ID, mod.EntityInf[mod.Entity.Statue].VAR, mod.EntityInf[mod.Entity.Statue].SUB, "아스트랄 석상", "#{{ItemPoolPlanetarium}} 아이템 획득 시 보스전을 시작합니다.#{{Bomb}} 석상을 파괴하면 아이템이 분해되며 보스전을 시작합니다.", "ko_kr")
	EID:addEntity(mod.EntityInf[mod.Entity.Statue].ID, mod.EntityInf[mod.Entity.Statue].VAR+1, mod.EntityInf[mod.Entity.Statue].SUB, "[달의 계약]", "#{{UltraSecretRoom}} {{Heart}}최대 체력/{{SoulHeart}}소울하트 소모에 더해 {{BrokenHeart}}부서진하트를 얻는 조건으로 거래합니다.#{{Warning}} 거래 시 획득하는 {{BrokenHeart}}부서진하트만큼 {{Heart}}빨간하트/{{SoulHeart}}소울하트를 추가로 차감합니다.(사망하지 않음)", "ko_kr")

	for itemID, itemdesc in pairs(CollectibleDesc) do
		local desc = itemdesc.Description
		if itemdesc.StatusEffects then
			for _, eff in ipairs(itemdesc.StatusEffects) do
				desc = desc .. eff
			end
		end
		EID:addCollectible(itemID, desc, itemdesc.Name, "ko_kr")
		if itemdesc.Wisps then
			EID.descriptions["ko_kr"].bookOfVirtuesWisps[itemID] = itemdesc.Wisps
		end
		if itemdesc.BingeEater then
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
				desc = desc .. eff
			end
		end
		EID:addTrinket(itemID, desc, itemdesc.Name, "ko_kr")
	end


	local i_queueLastFrame = {}
	local i_queueNow = {}
	wakaba_krdesc:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function (_, player)
		if not (Options.Language == "kr" or REPKOR) then return end
		local descTable = CollectibleDesc
		if not descTable and not descTableBR then return end

		local initSeed = tostring(player.InitSeed)

		i_queueNow[initSeed] = player.QueuedItem.Item
		if (i_queueNow[initSeed] ~= nil) then
			for itemID, itemdesc in pairs(descTable) do
				if (i_queueNow[initSeed].ID == itemID and i_queueNow[initSeed]:IsCollectible() and i_queueLastFrame[initSeed] == nil) then
					local itemName = (itemdesc.Name ~= "" and itemdesc.Name) or i_queueNow[initSeed].Name
					local queueDesc = itemdesc.QuoteDesc or i_queueNow[initSeed].Description
					Game():GetHUD():ShowItemText(itemName, queueDesc)
				end
			end
		end
		i_queueLastFrame[initSeed] = i_queueNow[initSeed]
	end)


	local t_queueLastFrame = {}
	local t_queueNow = {}
	wakaba_krdesc:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function (_, player)
		if not (Options.Language == "kr" or REPKOR) then return end
		local descTable = TrinketDesc
		if not descTable then return end

		local initSeed = tostring(player.InitSeed)

		t_queueNow[initSeed] = player.QueuedItem.Item
		if (t_queueNow[initSeed] ~= nil) then
			for itemID, itemdesc in pairs(descTable) do
				if (t_queueNow[initSeed].ID == itemID and t_queueNow[initSeed]:IsTrinket() and t_queueLastFrame[initSeed] == nil) then
					local itemName = (itemdesc.Name ~= "" and itemdesc.Name) or t_queueNow[initSeed].Name
					local queueDesc = itemdesc.QuoteDesc or t_queueNow[initSeed].Description
					Game():GetHUD():ShowItemText(itemName, queueDesc)
				end
			end
		end
		t_queueLastFrame[initSeed] = t_queueNow[initSeed]
	end)

















	return {
		targetMod = "Heaven's call",
		birthright = BirthrightDesc,
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
		cards = CardDesc,
		pills = PillDesc,
	}

end