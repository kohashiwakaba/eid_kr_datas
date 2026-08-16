
if AliceOfBlueArchive then

	EID._currentMod = "AliceOfBlueArchive"
	local mod = AliceOfBlueArchive
	local id_sword_of_light = Isaac.GetItemIdByName("Sword of Light")
	local id_commander = Isaac.GetItemIdByName("Commander")

	local CharacterDesc = {
		[Isaac.GetPlayerTypeByName("Alice")] = {
			Name = "Alice",
			Description = "",
			Detailed = "아리스는 넥슨의 {{ColorLime}}블루 아카이브{{CR}}에 등장하는 귀여운 로봇입니다.#적 명중 시 확률적으로 2배의 피해를 줍니다.#{{Collectible"..id_sword_of_light.."}} 고유 능력 : 빛의 검",
			Birthright = "{{Collectible"..id_sword_of_light.."}} The Sword of Light - '밸런스 붕괴'의 배수가 최대(x3)로 고정됩니다.",
			QuoteDesc = "강화 마법입니다!",
		},
		[Isaac.GetPlayerTypeByName("Tainted Alice", true)] = {
			Name = "???",
			Description = "",
			Detailed = "아리스는 넥슨의 {{ColorLime}}블루 아카이브{{CR}}에 등장하는 귀여운 로봇입니다.#아군 몬스터 사망 시 그 방에서 {{DamageSmall}}공격력과 {{TearsSmall}}연사가 증가합니다.#{{Collectible"..id_commander.."}} 고유 능력 : 커맨더",
			Birthright = "아군 몬스터가 항상 무적이 됩니다.",
			QuoteDesc = "???",
		},
	}
	local CollectibleDesc = {
		[id_sword_of_light] = {
			Name = "빛의 검",
			Description = ""
				.."#{{Chargeable}} 소지 시 공격이 충전형 레일건 ({{DamageSmall}}x7}}으로 변경됩니다."
				.."#공격 시마다 충전되며 완충 시에도 에너지를 최대 x3까지 초과 충전이 가능합니다."
				.."#사용 시 에너지를 소모하여 '밸런스 붕괴'를 발동, 공격방향으로 거대한 레이저를 발사합니다."
				.. "",
			QuoteDesc = "슈퍼노바",
		},
		[id_commander] = {
			Name = "커맨더",
			Description = "!!! 아래 중 하나 발동:"
				.."#사용 시 코스트 1을 소모, 가장 가까운 일반 몬스터를 아군으로 만들며(최대 8) 커맨더 스택 +1"
				.."#사용 시 커맨더 스택 20을 소모, 가장 가까운 아이템 하나를 다른 아이템으로 바꿉니다."
				.."#사용 키를 꾹 누르면 모든 아군을 폭파시킵니다."
				.. "",
			QuoteDesc = "컨트롤러",
		},
	}

	for playerType, birthrightdesc in pairs(CharacterDesc) do
		EID:addCharacterInfo(playerType, birthrightdesc.Description, birthrightdesc.Name, "ko_kr")
		if InventoryDescriptions then
			EID:addEntity(InvDescEIDType.PLAYER, InvDescEIDVariant.DEFAULT, playerType, birthrightdesc.Name, birthrightdesc.Detailed, "ko_kr")
		end
		EID:addBirthright(playerType, birthrightdesc.Birthright, birthrightdesc.Name, "ko_kr")
	end
	for itemID, itemdesc in pairs(CollectibleDesc) do
		local desc = itemdesc.Description
		EID:addCollectible(itemID, desc, itemdesc.Name, "ko_kr")
	end


	return {
		targetMod = "AliceOfBlueArchive",
		characters = CharacterDesc,
		collectibles = CollectibleDesc,
	}

end