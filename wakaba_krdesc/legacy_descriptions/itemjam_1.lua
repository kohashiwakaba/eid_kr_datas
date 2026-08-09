
if B95Mix1 then -- no global, so this is temporary
	if not REPENTOGON then
		table.insert(wakaba_krdesc.ERRORS, {
			NO_RGON = true,
			err_mod = "ItemJam Vol.1",
		})
		return
	end

	EID._currentMod = "ItemJam Vol.1"

	local V_REPLACE = 0
	local V_APPEND = 1

	local CollectibleDesc = {
		[HolyHamsaMod.CollectibleTypeCustom.HOLY_HAMSA] = {
			Name = "신성한 함사",
			-- Charge based passive, shoots a Hamsa at max charge.#When a Hamsa hits an enemy it spawns a bunch of Nazar familiars orbit the enemy hit and fire bullets#When an enemy dies, the Nazar decouples and flies slowly, bursting into lasers when you shoot afain
			Description = ""
			.."#{{Chargeable}} 공격키를 2.5초 이상 누르면 충전되며 공격키를 떼면 일직선 방향으로 손을 발사합니다."
			.."#손이 적에 명중 시 그 적 주변을 도는 나자르 부적을 엮습니다."
			.."#부적에 엮인 적은 캐릭터의 공격을 발사합니다."
			.."#부적에 엮인 적 처치 시 부적이 빛줄기와 레이저를 여러 발 발사하며 사라집니다."
			.."{{CR}}",
			QuoteDesc = "다가오는 손길",
		},
		[GLITCHED_MINER.ItemId] = {
			Name = "글리치 광부",
			--"{{Bomb}} +{{Quality1}}{{Quality0}}{{ColorCyan}}10{{CR}} {{Bomb}}{{ColorBlack}}Bombs{{CR}}#{{ArrowUp}} Adds a {{ColorGreen}}{{Luck}}Luck{{CR}}-based {{ColorRed}}{{DiceRoom}}chance{{CR}} to turn {{ColorGray}}rocks{{CR}} into {{ColorRainbow}}{{ERROR}}Glitched Rocks{{CR}}#{{Warning}} {{ColorRainbow}}{{ERROR}}Glitched Rocks{{CR}} trigger {{ColorRed}}{{DiceRoom}}random{{CR}} {{ColorLime}}effects{{CR}} when {{BossRoom}}{{ColorBlack}}destroyed{{CR}}"
			Description = ""
			.."#{{Bomb}} 폭탄 +10"
			.."#{{Collectible258}} 방 입장 시 확률적으로 장애물을 '오류 장애물'로 바꿉니다."
			.."#{{Collectible721}} 오류 장애물 파괴 시 랜덤 효과 발동"
			.."{{CR}}",
			QuoteDesc = "오류투성이 보물",
		},
		[Isaac.GetItemIdByName("Mega Dice")] = {
			Name = "거대한 주사위",
			--"Drops a dice that jumps at near enemies or players#Triggers a random effect and vanishes:#{{PoopPickup}} Poops everywhere#{{Collectible" .. CollectibleType.COLLECTIBLE_TREASURE_MAP .. "}} Removes curses and reveals map#{{Collectible" .. CollectibleType.COLLECTIBLE_D20 .. "}} Rerolls floor pickups#{{Collectible" .. CollectibleType.COLLECTIBLE_D6 .. "}} Rerolls floor pedestals#{{Bomb}} Mama Mega explosion#{{Battery}} Fully recharges actives"
			Description = ""
			.."#사용 시 거대한 주사위가 랜덤 위치에 떨어지며;"
			.."#!!! 주변의 적에게 200, ㅋ릭터에게 {{HalfHeart}}의 피해를 주며 이하 효과 중 하나 발동:"
			.."#>>> {{PoopPickup}} 그 방을 똥으로 채움"
			.."#>>> {{Collectible" .. CollectibleType.COLLECTIBLE_SOL .. "}} 저주 제거 + 모든 방 위치 표시"
			.."#>>> {{Collectible" .. CollectibleType.COLLECTIBLE_D20 .. "}} 그 방의 픽업 변경"
			.."#>>> {{Collectible" .. CollectibleType.COLLECTIBLE_D6 .. "}} 그 방의 아이템 변경"
			.."#>>> {{Collectible" .. CollectibleType.COLLECTIBLE_MAMA_MEGA .. "}} 그 방에 Mama Mega 폭발"
			.."#>>> {{Battery}} 액티브 완충"
			.."{{CR}}",
			QuoteDesc = "크게 굴려!",
		},
		[Isaac.GetItemIdByName("Floast Hat")] = {
			Name = "플로스트 햇",
			--"Grants immunity to explosions and falling projectiles#25% chance to reflect enemy shots#Flight"
			Description = ""
			.."#비행 능력을 얻습니다."
			.."#폭발 공격에 피해를 입지 않습니다."
			.."#적 탄환에 맞았을 때 25% 확률로 피해를 무시하며 캐릭터의 눈물과 같은 눈물을 3발 발사합니다."
			.."{{CR}}",
			QuoteDesc = "떠다니는 폭발 면역",
		},
		[Isaac.GetItemIdByName("Bucket of Boots")] = {
			Name = "부츠 바구니",
			--"Using the item and firing in a direction throws the bucket that deals 3x the player's damage#The bucket breaks where it lands and fires out boot tears#Boot tears turn enemies into Boot Enemies#Boot Enemies only attack by moving in chess figure patterns"
			Description = ""
			.."#{{Throwable}} 사용 시 공격방향으로 공격력 x3의 바구니를 투척합니다."
			.."#투척한 바구니에서 부츠 공격이 나가며;"
			.."#>>> 부츠 공격에 닿은 적을 부츠 몬스터로 바꿉니다."
			.."#부츠 몬스터는 체스 기물 형식의 이동을 합니다."
			.."{{CR}}",
			QuoteDesc = "이 멋진 걸 해 봐!",
		},
		[Isaac.GetItemIdByName("Strange Mask")] = {
			Name = "수상한 마스크",
			--"\2 x0.8 Damage#{{Poison}} Poison tears#Delay between poison damage ticks is equal to " .. POISON_TICK_DELAY_TEARS_MULT .. "x your firedelay (max of 0.67s)"
			Description = ""
			.."#↓ {{DamageSmall}}공격력 배율 x0.8"
			.."#{{Poison}} 적을 중독시키는 공격이 나갑니다."
			.."#중독 피해 간격이 연사에 따라 빨라집니다. (최대 0.67초)"
			.."{{CR}}",
			QuoteDesc = "공격력 감소 + 독성 눈물",
		},
		[Isaac.GetItemIdByName("Hexagonal Core")] = {
			Name = "헥사곤 코어",
			--"Periodically spawns 5 lasers in a hexagon pattern which move from outside the room towards the center #Each laser deals half the {{Damage}} player's damage + 3"
			Description = ""
			.."#주기적으로 방 중앙을 향해 공격력 x0.5 +3의 육각형 레이저 공격이 나옵니다."
			.."#육각형 중 5개의 변에만 레이저가 있습니다."
			.."{{CR}}",
			QuoteDesc = "6의 힘",
		},
		[Isaac.GetItemIdByName("Hornpipe")] = {
			Name = "혼파이프",
			-- "Wormwood stabs through the floor 5 times over the span of " .. 30 // 30 * 5 .. " seconds#Each stab creates a pit and damages anything overhead#Prioritizes enemies by health, then obstacles by worth, then players"
			Description = ""
			.."#사용 시 적, 장애물, 혹은 캐릭터를 향해 웜우드가 바닥을 5번 찌릅니다."
			.."#{{Blank}} (적의 경우 25, 캐릭터의 경우 {{HalfHeart}}의 피해)"
			.."#>>> 찔린 바닥에 구덩이가 생깁니다."
			.."{{CR}}",
			QuoteDesc = "외로움의 비탄",
		},
		[Isaac.GetItemIdByName("Dad's Savings")] = {
			Name = "아빠의 비상금",
			--"50% chance to replace coins with chips#pennies -> red chips#nickles -> green chips#dimes -> black chips#when interacting with a beggar, a red chip will make it payout once for free, a green chip 3 times for free, and a black chip makes it instantly spawn an item and leave#when using a slot, a red chip makes it payout one time, green 3 times, and black 5 times and it explodes"
			Description = ""
			.."#{{Coin}} 동전이 50%의 확률로 칩으로 바뀝니다."
			.."#>>> {{NoLB}}페니->빨간칩/니켈->초록칩/다임->검은칩"
			.."#{{ArcadeRoom}} 거지/슬롯 이용 시 칩을 우선 소모하여 즉시 보상을 드랍합니다:"
			.."#>>> 검은칩 -> {{Beggar}}아이템/{{Slotmachine}}픽업 보상 x5"
			.."#>>> 초록칩 -> {{Beggar}}{{Slotmachine}}픽업 보상 x3"
			.."#>>> 빨간칩 -> {{Beggar}}{{Slotmachine}}픽업 보상 x1"
			.."{{CR}}",
			QuoteDesc = "그냥 죽는게 더 싸게 먹힐 수도..?",
		},
	}

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

	return {
		targetMod = "ItemJamV1",
		collectibles = CollectibleDesc,
	}

end