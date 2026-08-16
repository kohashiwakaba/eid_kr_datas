
if FirstJoker and LastJoker then

	EID._currentMod = "Balatro Jokers"

	local V_REPLACE = 0
	local V_APPEND = 1

	local CollectibleDesc = {
		[jimbos_collection] = {
			Description = "획득 시 {{randomvouchersingle}}바우처 장신구 2개, {{randompackthree}}부스터 팩 1개와 랜덤 픽업을 드랍합니다.#{{randomvouchersingle}} 챔피언 몬스터 처치 시 6.67%의 확률로 바우처 장신구 혹은 카드팩 하나를 드랍합니다.#{{bjokercard}} 보스 처치 시 랜덤 조커 혹은 부스터 팩을 드랍합니다.#!!! 모든 {{tarotcard}} / {{playingcard}} 판매 중인 상점 카드가 부스터 팩으로 바뀝니다.",
			Name = "짐보의 컬렉션",
			QuoteDesc = "",
		},
	}

	local TrinketDesc = {
		[torn_voucher] = {
			Description = "{{ColorMint}}1 in 10 chance{{CR}} for the room clear reward to be a {{randompackthree}} Booster Pack#{{ColorMint}}1 in 3 chance{{CR}} for a bonus Booster Pack from chests",
			Name = "AAAA",
			QuoteDesc = "",
		},
		[wasteful_voucher] = {
			Description = "{{ColorMint}}1 in 10 chance{{CR}} for the room clear reward to be a {{randompackthree}} Booster Pack#{{ColorMint}}1 in 3 chance{{CR}} for a bonus Booster Pack from chests#{{ColorMint}}1 in 3 chance{{CR}} of despawning cards from Booster Packs to become a {{Coin}} Penny",
			Name = "AAAA",
			QuoteDesc = "",
		},
		[tarot_voucher] = {
			Description = "{{ColorMint}}1 in 10 chance{{CR}} for the room clear reward to be a {{randompackthree}} Booster Pack#{{ColorMint}}1 in 3 chance{{CR}} for a bonus Booster Pack from chests#{{ColorMint}}1 in 10 chance{{CR}} of despawning cards from Booster Packs to become a {{tarotcard}} Tarot Card",
			Name = "AAAA",
			QuoteDesc = "",
		},
		[planet_voucher] = {
			Description = "{{ColorMint}}1 in 10 chance{{CR}} for the room clear reward to be a {{randompackthree}} Booster Pack#{{ColorMint}}1 in 3 chance{{CR}} for a bonus Booster Pack from chests#{{ColorMint}}1 in 10 chance{{CR}} of despawning cards from Booster Packs to become a {{planetcard}} Planet Card",
			Name = "AAAA",
			QuoteDesc = "",
		},
		[seed_voucher] = {
			Description = "{{ColorMint}}1 in 10 chance{{CR}} for the room clear reward to be a {{randompackthree}} Booster Pack#{{ColorMint}}1 in 3 chance{{CR}} for a bonus Booster Pack from chests#Opening a Booster Pack also drops a random {{Coin}} Coin",
			Name = "AAAA",
			QuoteDesc = "",
		},
		[directors_voucher] = {
			Description = "{{ColorMint}}1 in 10 chance{{CR}} for the room clear reward to be a {{randompackthree}} Booster Pack#{{ColorMint}}1 in 3 chance{{CR}} for a Booster Pack pack from chests#{{ColorMint}}1 in 10 chance{{CR}} of despawning cards from Booster Packs to become a {{dshard}} Dice Shard",
			Name = "AAAA",
			QuoteDesc = "",
		},
		[hone_voucher] = {
			Description = "{{ColorMint}}1 in 10 chance{{CR}} for the room clear reward to be a {{randompackthree}} Booster Pack#{{ColorMint}}1 in 3 chance{{CR}} for a bonus Booster Pack from chests#{{ColorMint}}1 in 4 chance{{CR}} to get jumbo or mega Booster Packs from {{BossRoom}} Bosses and {{MiniBoss}} Minibosses",
			Name = "AAAA",
			QuoteDesc = "",
		},
		[overstock_voucher] = {
			Description = "{{ColorMint}}1 in 10 chance{{CR}} for the room clear reward to be a {{randompackthree}} Booster Pack#{{ColorMint}}1 in 3 chance{{CR}} for a bonus Booster Pack from chests#Opening a Booster Pack drops 1-2 random pickups",
			Name = "AAAA",
			QuoteDesc = "",
		},
		[magic_voucher] = {
			Description = "{{ColorMint}}1 in 10 chance{{CR}} for the room clear reward to be a {{randompackthree}} Booster Pack#{{ColorMint}}1 in 3 chance{{CR}} for a bonus Booster Pack from chests#{{ColorMint}}1 in 4 chance{{CR}} buying a shop item spawns a {{deckpackt}} Torn Deck Pack",
			Name = "AAAA",
			QuoteDesc = "",
		},
		[clearance_voucher] = {
			Description = "{{ColorMint}}1 in 10 chance{{CR}} for the room clear reward to be a {{randompackthree}} Booster Pack#{{ColorMint}}1 in 3 chance{{CR}} for a bonus Booster Pack from chests#All Booster Packs are discounted in the shop",
			Name = "AAAA",
			QuoteDesc = "",
		},
		[reroll_voucher] = {
			Description = "{{ColorMint}}1 in 10 chance{{CR}} for the room clear reward to be a {{randompackthree}} Booster Pack#{{ColorMint}}1 in 3 chance{{CR}} for a bonus Booster Pack from chests#Spawns a reroll machine in the shop",
			Name = "AAAA",
			QuoteDesc = "",
		},
		[hieroglyph_voucher] = {
			Description = "{{ColorMint}}1 in 10 chance{{CR}} for the room clear reward to be a {{randompackthree}} Booster Pack#{{ColorMint}}1 in 3 chance{{CR}} for a bonus Booster Pack from chests#!!! Entering a {{BossRoom}} Boss Room with this voucher kills the boss, removes the item reward and destroys itself",
			Name = "AAAA",
			QuoteDesc = "",
		},
		[card_house] = {
			Description = "{{ColorMint}}1 in 4 chance{{CR}} to turn any dropped {{tarotcard}} Tarot Card, {{rune}} Rune or {{soulstone}} Soulstone into a {{bjokercard}} Joker Card",
			Name = "AAAA",
			QuoteDesc = "",
		},
		[cheap_suit] = {
			Description = "Triggers a random {{bjokercard}} Joker Card effect upon moving to a new floor",
			Name = "AAAA",
			QuoteDesc = "",
		},
		[first_edition] = {
			Description = "Entering a secret room will spawn 3x {{bjokercard}} Joker Cards on the ground#!!! Picking up one card removes other spawned cards#!!! 소환한 카드는 방을 나가면 사라집니다.",
			Name = "AAAA",
			QuoteDesc = "",
		},
		[stone_card] = {
			Description = "Destroying tinted rocks have {{ColorMint}}1 in 3 chance{{CR}} to spawn a {{deckpackt}} Torn Deck Pack or a random {{randomvouchersingle}} Voucher#!!! Dropping this trinket will destroy it after it stays on the ground for a short time or when leaving the room",
			Name = "AAAA",
			QuoteDesc = "",
		},
		[double_stakes] = {
			Description = "Each devil and angel deal room will have 2 random cards for sale#!!! Devil rooms require taking damage for the cards, angel rooms require money instead",
			Name = "AAAA",
			QuoteDesc = "",
		},
	}

	local CardDesc = {
		[Pluto] = {
			Description = "{{Collectible598}} Spawns a Pluto wisp familiar#{{ColorMint}}1 in 10 chance{{CR}} to spawn the Pluto pedestal item instead#!!! Item effect is lost if the wisp takes too much damage",
			Name = "명왕성",
			QuoteDesc = "",
		},
		[Mercury] = {
			Description = "{{Collectible590}} Spawns a Mercurius wisp familiar#{{ColorMint}}1 in 10 chance{{CR}} to spawn the Mercurius pedestal item instead#!!! Item effect is lost if the wisp takes too much damage",
			Name = "수성",
			QuoteDesc = "",
		},
		[Uranus] = {
			Description = "{{Collectible596}} Spawns a Uranus wisp familiar#{{ColorMint}}1 in 10 chance{{CR}} to spawn the Uranus pedestal item instead#!!! Item effect is lost if the wisp takes too much damage",
			Name = "천왕성",
			QuoteDesc = "",
		},
		[Venus] = {
			Description = "{{Collectible591}} Spawns a Venus wisp familiar#{{ColorMint}}1 in 10 chance{{CR}} to spawn the Venus pedestal item instead#!!! Item effect is lost if the wisp takes too much damage",
			Name = "금성",
			QuoteDesc = "",
		},
		[Saturn] = {
			Description = "{{Collectible595}} Spawns a Saturnus wisp familiar#{{ColorMint}}1 in 10 chance{{CR}} to spawn the Saturnus pedestal item instead#!!! Item effect is lost if the wisp takes too much damage",
			Name = "토성",
			QuoteDesc = "",
		},
		[Jupiter] = {
			Description = "{{Collectible594}} Spawns a Jupiter wisp familiar#{{ColorMint}}1 in 10 chance{{CR}} to spawn the Jupiter pedestal item instead#!!! Item effect is lost if the wisp takes too much damage",
			Name = "목성",
			QuoteDesc = "",
		},
		[Earth] = {
			Description = "{{Collectible592}} Spawns a Terra wisp familiar#{{ColorMint}}1 in 10 chance{{CR}} to spawn the Terra pedestal item instead#!!! Item effect is lost if the wisp takes too much damage",
			Name = "지구",
			QuoteDesc = "",
		},
		[Mars] = {
			Description = "{{Collectible593}} Spawns a Mars wisp familiar#{{ColorMint}}1 in 10 chance{{CR}} to spawn the Mars pedestal item instead#!!! Item effect is lost if the wisp takes too much damage",
			Name = "화성",
			QuoteDesc = "",
		},
		[Neptune] = {
			Description = "{{Collectible597}} Spawns a Neptunus wisp familiar#{{ColorMint}}1 in 10 chance{{CR}} to spawn the Neptunus pedestal item instead#!!! Item effect is lost if the wisp takes too much damage",
			Name = "해왕성",
			QuoteDesc = "",
		},
		[RedDeck] = {
			Description = "For this floor, last enemy in the room is instantly killed#{{ColorMint}}1 in 2 chance{{CR}} to remove the floor curse#Additional uses increase the enemy kill treshold",
			Name = "레드 덱",
			QuoteDesc = "",
		},
		[BlueDeck] = {
			Description = "{{Collectible245}} Gives the 20/20 item effect for the room#{{ColorMint}}1 in 2 chance{{CR}} to duplicate all pedestal items and pickups in the room",
			Name = "블루 덱",
			QuoteDesc = "",
		},
		[YellowDeck] = {
			Description = "Spawns 10 {{Coin}} Coins#{{ColorMint}}1 in 2 chance{{CR}} to spawn a money related pedestal item",
			Name = "옐로우 덱",
			QuoteDesc = "",
		},
		[GreenDeck] = {
			Description = "For this floor, clearing a room spawns a {{Coin}} Penny#{{ColorMint}}1 in 2 chance{{CR}} to double your coins after clearing the {{BossRoom}} Boss Room",
			Name = "그린 덱",
			QuoteDesc = "",
		},
		[BlackDeck] = {
			Description = "{{ColorMint}}1 in 2 chance{{CR}} to replace any pickup on the ground with a random {{bjokercard}} Joker Card#!!! Destroys the pickup if the conversion fails",
			Name = "블랙 덱",
			QuoteDesc = "",
		},
		[BJoker] = {
			Description = "↑ +0.7 Damage",
			Name = "Balatro 조커",
			QuoteDesc = "",
		},
		[GreedyJoker] = {
			Description = "↑ +0.03 Damage for each picked up {{Coin}} Coin#Additional uses double current bonus",
			Name = "인색한 조커",
			QuoteDesc = "",
		},
		[LustyJoker] = {
			Description = "↑ +0.03 Damage for each picked up {{HalfHeart}} / {{HalfSoulHeart}} Half Heart#Additional uses double current bonus",
			Name = "음욕의 조커",
			QuoteDesc = "",
		},
		[WrathfulJoker] = {
			Description = "↑ +0.05 Damage for each picked up {{Key}} Key#Additional uses double current bonus",
			Name = "분노하는 조커",
			QuoteDesc = "",
		},
		[GluttonousJoker] = {
			Description = "↑ +0.05 Damage for each picked up {{Bomb}} Bomb#Additional uses double current bonus",
			Name = "탐욕스러운 조커",
			QuoteDesc = "",
		},
		[JollyJoker] = {
			Description = "↑ +0.4 Damage for the room per every 2 enemies killed#Additional uses double current bonus",
			Name = "쾌활한 조커",
			QuoteDesc = "",
		},
		[WilyJoker] = {
			Description = "↑ +0.2 Tears for the room per every 3 enemies killed#Additional uses double current bonus",
			Name = "엉뚱한 조커",
			QuoteDesc = "",
		},
		[HalfJoker] = {
			Description = "↑ +1.5 Damage if there are 3 or less enemies in the room.#Additional uses double current bonus",
			Name = "반쪽짜리 조커",
			QuoteDesc = "",
		},
		[JokerStencil] = {
			Description = "↑ +0.4 Damage per charge when held active item is not fully charged.#Additional uses double current bonus",
			Name = "조커 스텐실",
			QuoteDesc = "",
		},
		[Mime] = {
			Description = "Triggers the held active item effect without depleting its charge#{{ColorMint}}1 in 2 chance{{CR}} to spawn another Mime card when used",
			Name = "마임",
			QuoteDesc = "",
		},
		[MarbleJoker] = {
			Description = "Entering a new room petrifies all enemies for a short time#Additional uses apply the effect again for the room",
			Name = "대리석 조커",
			QuoteDesc = "",
		},
		[EightBall] = {
			Description = "{{ColorMint}}1 in 3 chance{{CR}} to spawn 8x {{tarotcard}} Tarot Cards#Additional {{ColorMint}}1 in 3 chance{{CR}} to spawn the {{Collectible451}} Tarot Cloth pedestal item",
			Name = "8번 공",
			QuoteDesc = "",
		},
		[Misprint] = {
			Description = "↑ +0-1.4 Random damage up when moving to a new room",
			Name = "인쇄 오류",
			QuoteDesc = "",
		},
		[RaisedFist] = {
			Description = "↑ +0.1 Damage multiplied by the lowest {{Bomb}} Bomb, {{Key}} Key or {{Coin}} Coin amount on entering a new room",
			Name = "들어올린 주먹",
			QuoteDesc = "",
		},
		[Fibonacci] = {
			Description = "↑ +2 Damage if all of the pickup amounts are either 1,2,3,5 or 8 when entering a new room",
			Name = "피보나치",
			QuoteDesc = "",
		},
		[ScaryFace] = {
			Description = "↑ +0.03 Tears for each killed champion enemy",
			Name = "무서운 얼굴",
			QuoteDesc = "",
		},
		[Hack] = {
			Description = "If there are 2,3,4 or 5 enemies in the room damage is shared between all of them",
			Name = "삼류",
			QuoteDesc = "",
		},
		[GrosMichel] = {
			Description = "↑ +3 Damage as long as the card is held#{{ColorMint}}1 in 10 chance{{CR}} the card is destroyed upon moving to an uncleared room#!!! Effect is lost when the card is used",
			Name = "그로 미셸",
			QuoteDesc = "",
		},
		[Supernova] = {
			Description = "Turns all {{Bomb}} Bombs, {{Key}} Keys, {{Coin}} Coins and {{Heart}} Hearts turn into a random {{planetcard}} Planet Card#Pedestal items have a chance to turn into a planetarium item or a {{randompackthree}} Celestial Pack#+25% conversion chance for each quality level)",
			Name = "초신성",
			QuoteDesc = "",
		},
		[SpaceJoker] = {
			Description = "Turns held trinket and all trinkets on the ground to golden, more effective versions",
			Name = "우주 조커",
			QuoteDesc = "",
		},
		[Egg] = {
			Description = "While held, each visited special room ({{Shop}} Shops, {{TreasureRoom}} Treasure Rooms etc.) drops 3x random {{Coin}} Coins#Using the card drops 3x random {{Coin}} Coins and removes the effect#!!! Visiting a shop will destroy the card",
			Name = "알",
			QuoteDesc = "",
		},
		[Blackboard] = {
			Description = "↑ x1.4 Damage multiplier if amount of held {{Bomb}} Bombs, {{Key}} Keys and {{Coin}} Coins are equal",
			Name = "칠판",
			QuoteDesc = "",
		},
		[BlueJoker] = {
			Description = "↑ +0.15 Tears for each card in the room#!!! On use, cards on the ground will be destroyed",
			Name = "블루 조커",
			QuoteDesc = "",
		},
		[SquareJoker] = {
			Description = "↑ +4 Tears when there are exactly 4 enemies in the room#If the enemy amount is no longer 4, the stat disappears over time",
			Name = "정사각형 조커",
			QuoteDesc = "",
		},
		[RiffRaff] = {
			Description = "Spawns 2x {{bjokercard}} Joker Cards if the current room is a {{BossRoom}} Boss, {{MiniBoss}} Miniboss or a {{BossRushRoom}} Boss Rush Room",
			Name = "조무래기",
			QuoteDesc = "",
		},
		[Vampire] = {
			Description = "↑ x0.005 Damage multiplier increase for each killed enemy",
			Name = "뱀파이어",
			QuoteDesc = "",
		},
		[Vagabond] = {
			Description = "When held, if Isaac's {{Coin}} Coin amount is 3 or less, triggers a random {{tarotcard}} Tarot Card effect on entering a new hostile room#Using the card spawns a {{Coin}} Lucky Coin",
			Name = "방랑자",
			QuoteDesc = "",
		},
		[Rocket] = {
			Description = "While held, adds +1 {{Coin}} Coin when clearing a room#Clearing a boss room increases the coin amount by +2#Using the card spawns the current bonus as {{Coin}} Pennies",
			Name = "로켓",
			QuoteDesc = "",
		},
		[Hologram] = {
			Description = "↑ x0.08 damage multiplier increase for each used card (including itself)",
			Name = "홀로그램",
			QuoteDesc = "",
		},
	}

	EID:addEntity(5, standard_pack, 1, "{{standardpack}} 스탠다드 팩", "{{playingcard}} 플레잉 카드 3장(선택형)을 소환합니다.#!!! 소환한 카드는 방을 나가면 사라집니다.")
	EID:addEntity(5, standard_packj, 1, "{{standardpackj}} 점보 스탠다드 팩", "{{playingcard}} 플레잉 카드 3장(선택형), {{rune}} 룬 1개를 소환합니다.#!!! 소환한 카드는 방을 나가면 사라집니다.")
	EID:addEntity(5, standard_packm, 1, "{{standardpackm}} 메가 스탠다드 팩", "{{playingcard}} 플레잉 카드 3장(선택형), {{rune}} 룬 1개, {{soulstone}} 영혼석 1개를 소환합니다.#!!! 소환한 카드는 방을 나가면 사라집니다.")
	EID:addEntity(5, arcana_pack, 1, "{{arcanapack}} 아르카나 팩", "{{tarotcard}} 정방향 타로 카드 3장(선택형)을 소환합니다.#!!! 소환한 카드는 방을 나가면 사라집니다.")
	EID:addEntity(5, arcana_packj, 1, "{{arcanapackj}} 점보 아르카나 팩", "{{tarotcard}} 정방향 타로 1장, {{reversecard}} 역방향 타로 1장(선택형)을 소환합니다.#!!! 소환한 카드는 방을 나가면 사라집니다.")
	EID:addEntity(5, arcana_packm, 1, "{{arcanapackm}} 메가 아르카나 팩", "{{tarotcard}} 정방향 타로 3장, {{reversecard}} 역방향 타로 1장, {{randomspecial}} 스페셜 카드 3장(선택형)을 소환합니다.#!!! 소환한 카드는 방을 나가면 사라집니다.")
	EID:addEntity(5, planet_pack, 1, "{{planetpack}} 천체 팩", "{{planetcard}} 천체 카드 3장(선택형)을 소환합니다.#!!! 소환한 카드는 방을 나가면 사라집니다.")
	EID:addEntity(5, planet_packj, 1, "{{planetpackj}} 점보 천체 팩", "{{planetcard}} 천체 카드 4장(선택형)을 소환합니다.#!!! 소환한 카드는 방을 나가면 사라집니다.")
	EID:addEntity(5, planet_packm, 1, "{{planetpackm}} 메가 천체 팩", "{{planetcard}} 천체 카드 5장(선택형)을 소환합니다.#!!! 소환한 카드는 방을 나가면 사라집니다.")
	EID:addEntity(5, buffoon_pack, 1, "{{buffoonpack}} 어릿광대 팩", "Spawns 3x {{bjokercard}} Joker Cards을 소환합니다.#!!! 소환한 카드는 방을 나가면 사라집니다.")
	EID:addEntity(5, buffoon_packj, 1, "{{buffoonpackj}} 점보 어릿광대 팩", "Spawns 4x {{bjokercard}} Joker Cards을 소환합니다.#!!! 소환한 카드는 방을 나가면 사라집니다.")
	EID:addEntity(5, buffoon_packm, 1, "{{buffoonpackm}} 메가 어릿광대 팩", "Spawns 5x {{bjokercard}} Joker Cards을 소환합니다.#!!! 소환한 카드는 방을 나가면 사라집니다.")
	EID:addEntity(5, deck_pack, 1, "{{deckpackt}} Torn Deck 팩", "Spawns 2x {{randomdcard}} Deck Cards을 소환합니다.#!!! 소환한 카드는 방을 나가면 사라집니다.")
	EID:addEntity(5, fun_pack, 1, "{{funpackt}} Torn Fun 팩", "Spawns 2x {{funcard}} Fun Cards을 소환합니다.#!!! 소환한 카드는 방을 나가면 사라집니다.")

	for itemID, itemdesc in pairs(CollectibleDesc) do
		local desc = itemdesc.Description
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
	for itemID, itemdesc in pairs(CardDesc) do
		EID:addCard(itemID, itemdesc.Description, itemdesc.Name, "ko_kr")
	end

	return {
		targetMod = "Balatro Jokers",
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
		cards = CardDesc,
	}

end