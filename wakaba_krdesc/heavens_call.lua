
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
			QuoteDesc = "quote",
		},
		[Items.Venus] = {
			Description = "#{{Burning}} Gives a candle familiar, after 15 enemies killed, it will spawn a wax ally. #{{Burning}} Wax allies can be executed by holding CTRL, executed allies have a chance to drop Blazing Hearts, the less health, the more chances. #{{Burning}} Pickuing up a Blazing Heart will give you a Willo",
			Name = "name",
			QuoteDesc = "quote",
		},
		[Items.Terra] = {
			Description = "방 입장 시 사과를 소환합니다.#사과를 집으면 체력이 가장 많은 적에게 초당 7의 피해를 주는 뱀을 소환합니다.#시간이 지날 수록 사과가 익으며(최대 2회) 사과 단계에 따라 뱀의 피해량이 증가합니다.",
			Name = "지구?",
			QuoteDesc = "quote",
		},
		[Items.Mars] = {
			Description = "#{{Bait}} On use, will give Isaac a laser gun for some seconds. #{{Blank}} #{{Blank}} While the effect is active: #{{ArrowUp}} damage up, tears up, shot speed up, range up. #{{ArrowDown}} Big speed down. #{{Blank}} # The laser gun timer can be increased by killing enemies. # Will go to your pocket active slot if available.",
			Name = "name",
			QuoteDesc = "quote",
		},
		[Items.Jupiter] = {
			Description = "# Isaac will create an electrified laser as he walks. # If it loops in a circle, it will create a short circuit and electrocute enemies within it. # The short circuit will also activate some slots machines for free and upgrade batteries with a chance to make any of them explode and revive shopkeepers as allies.",
			Name = "name",
			QuoteDesc = "quote",
		},
		[Items.Saturnus] = {
			Description = "#{{TimerSmall}} On use it will freeze time. # Tears will start moving when time resumes. # Lasers will have the anti-gravity effect. # Placed bombs will instantly explode after the effect ends. #{{ArrowUp}} speed up and tears up while the effect is active. # Will go to your pocket active slot if available.",
			Name = "name",
			QuoteDesc = "quote",
		},
		[Items.Uranus] = {
			Description = "{{PoopPickup}} Isaac will poop in the opposite direction of his shots. #{{PoopPickup}} Poop tears will apply pooped debuff to enemies. #{{PoopPickup}} Pooped enemies will have weakness and spawn boosting brown creep. #{{PoopPickup}} Killing a pooped enemy will spawn a T??? poop. #{{PoopPickup}} If the enemy does not die and the poop effect wears off, friendly dips will spawn on the enemy.",
			Name = "name",
			QuoteDesc = "quote",
		},
		[Items.Neptunus] = {
			Description = "{{Throwable}} 공격하는 방향으로 삼지창을 날릴 수 있습니다.#삼지창으로 적 처치 시 4%의 확률로 블랙홀을 소환합니다.#{{LuckSmall}} 행운 20+일 때 15%",
			Name = "해왕성?",
			QuoteDesc = "quote",
		},
	}

	local TrinketDesc = {
		[Trinkets.Shard] = {
			Description = "13%의 확률로 피해를 막으나;#!!! 방 안의 랜덤 위치로 순간이동합니다.",
			Name = "name",
			QuoteDesc = "quote",
		},
		[Trinkets.Sputnik] = {
			Description = "# Gives a satellite orbital. #{{Throwable}} Orbitals will move slower but be farther away from you.",
			Name = "name",
			QuoteDesc = "quote",
		},
		[Trinkets.Flag] = {
			Description = "#{{LuckSmall}} Increases chance to find Telescopes.#{{LuckSmall}} Telescopes will have a higher chance to give moons. #{{DamageSmall}} Moon familiars will do more damage and attack more.",
			Name = "name",
			QuoteDesc = "quote",
		},
	}
	
	EID:addEntity(mod.EntityInf[mod.Entity.Telescope].ID, mod.EntityInf[mod.Entity.Telescope].VAR, mod.EntityInf[mod.Entity.Telescope].SUB, "Telescope", "Can give as rewards:#{{Blank}} Wisps, Astral items wisps, Soul Hearts, Blazing Hearts and {{ColorCyan}}Moon {{ColorCyan}}Orbitals", "en_us")
	EID:addEntity(mod.EntityInf[mod.Entity.Statue].ID, mod.EntityInf[mod.Entity.Statue].VAR, mod.EntityInf[mod.Entity.Statue].SUB, "Astral Statue", "#{{Planetarium}} Take the item and fight a boss.#{{Bomb}} Bombing the statue will turn the item into pickups and spawn the boss.", "en_us")
	EID:addEntity(mod.EntityInf[mod.Entity.Statue].ID, mod.EntityInf[mod.Entity.Statue].VAR+1, mod.EntityInf[mod.Entity.Statue].SUB, "[Lunar Pact]", "#{{UltraSecretRoom}} Take an item in exchange for broken, red and soul hearts.#{{Warning}} Broken hearts will also subtract the same red life (not containers), but it can't kill you.#For example: picking up a deal of 3 broken hearts with only 3 full red hearts will leave you with half red heart, 3 red containers and 3 broken hearts.", "en_us")

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

	return {
		birthright = BirthrightDesc,
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
		cards = CardDesc,
		pills = PillDesc,
	}
	
end