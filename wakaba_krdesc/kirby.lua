
if KirbyMod then
	if not REPENTOGON then
		table.insert(wakaba_krdesc.ERRORS, {
			NO_RGON = true,
			err_mod = "Kirby Mod!",
		})
		return
	end

	EID._currentMod = "Kirby Mod!"
	local mod = KirbyMod
	-- KirbyMod.enums

	local Items = KirbyMod.enums.Items
	table.insert(EID.TextReplacementPairs,{"{{KirbyActive}}", "{{Collectible"..Items.SWALLOW.."}}"})

	local CharacterDesc = {
		[KirbyMod.enums.Characters.KIRBY] = {
			Name = "Kirby",
			Description = "",
			Detailed = "커비는 {{ColorLime}}별의 커비 시리즈{{CR}}에 등장하는 귀여운 생명체입니다."
				.."#공격키를 꾹 눌러 가장 가까운 적 하나를 빨아들입니다."
				.."#{{Collectible"..Items.SWALLOW.."}} 고유 능력 : 카피"
				.."#!!! 무능력 상태에서는 일반공격이 불가능하며 완충 공격은 공격력 x4(흡수한 적을 다시 뱉는 경우 x3)의 피해를 줍니다."
				.."#!!! 무능력 상태에서 보스를 일정 회수 명중 시 별 총알이 등장하며 별 총알은 초당 캐릭터의 공격력 x30의 피해를 줍니다."
				.."#{{ButtonRT}} 버튼을 꾹 눌러 능력을 해제할 수 있습니다."
				.."",
		},
	}
	local CollectibleDesc = {
		[Items.SWALLOW] = {
			Name = "노멀",
			Description = ""
				.."#흡수할 수 있는 적이 하얗게 표시됩니다."
				.."#적을 머금은 상태에서 사용 시 그 적을 삼켜 능력을 복사합니다."
				.."#패널티 피격 시 능력이 사라지며 능력이 담긴 스타가 등장, 그 스타를 삼키면 능력을 다시 복원합니다."
				.. "",
			QuoteDesc = "",
		},
		[Items.FIRE_ACTIVE] = {
			Name = "파이어",
			Description = ""
				.."#{{Collectible616}} 일반공격이 공격력 x0.5의 불뿜기로 변경"
				.."#불뿜기는 적과 멀수록, 지속적으로 공격할수록 피해량과 사거리가 약해집니다."
				.."#{{KirbyActive}} 사용 시 이동방향으로 돌진, 적에게 최대 공격력 x4의 화염 피해를 줍니다."
				.. "",
			QuoteDesc = "",
		},
		[Items.GHOST_ACTIVE] = {
			Name = "고스트",
			Description = ""
				.."#{{Player16}} 일반공격이 뼈 공격으로 변경"
				.."#{{KirbyActive}} 사용 중일 때: "
				.."#{{ArrowGrayRight}} {{SpeedSmall}} 이동속도 +0.4"
				.."#{{ArrowGrayRight}} 비행 능력을 얻습니다."
				.."#{{ArrowGrayRight}} 모든 피해에 무적이 되며 공격할 수 없습니다."
				.. "",
			QuoteDesc = "",
		},
		[Items.BRIMSTONE_ACTIVE] = {
			Name = "유황",
			Description = ""
				.."#{{Collectible118}} 일반공격이 사거리가 매우 짧은 혈사포로 변경"
				.."#{{KirbyActive}} 사용 시 최대 공격력 x10의 피해를 주는 원형 혈사포를 발사하며;"
				.."#{{BrimstoneCurse}} 반경 1칸 이내의 적에게 유황 표식을 겁니다."
				.. "",
			QuoteDesc = "",
		},
		[Items.SPIDER_ACTIVE] = {
			Name = "스파이더",
			Description = ""
				.."#{{Collectible153}} 일반공격이 연사가 매우 낮은 4발 공격으로 변경"
				.."#{{Collectible234}} 적 처치 시 자폭 거미 생성"
				.."#{{KirbyActive}} 사용 시 10초동안 거미줄을 설치하며;"
				.."#{{Slow}} 거미줄에 닿은 적은 30%만큼 느려집니다."
				.."#{{Blank}} (보스의 경우 5초간 적용)"
				.. "",
			QuoteDesc = "",
		},
		[Items.FLY_ACTIVE] = {
			Name = "플라이",
			Description = ""
				.."#{{Collectible268}} 일반공격 시 자폭 파리 발사"
				.."#{{KirbyActive}} 사용 시 점프합니다."
				.."#!!! 점프 후 구덩이에 빠지면 패널티 피격을 받습니다."
				.. "",
			QuoteDesc = "",
		},
		[Items.ELECTRIC_ACTIVE] = {
			Name = "스파크",
			Description = ""
				.."#{{Collectible561}}{{Collectible68}} 일반공격이 무작위 방향 레이저로 변경"
				.."#{{KirbyActive}} 사용 중일 때 이동불능, 주변의 적에게 초당 공격력 x4.5의 눈물 피해를 줍니다."
				.. "",
			QuoteDesc = "",
		},
		[Items.BOMB_ACTIVE] = {
			Name = "밤",
			Description = ""
				.."#{{Collectible52}} 일반공격이 폭탄으로 변경"
				.."#{{KirbyActive}} 사용 시 설치된 폭탄을 즉시 폭파시킵니다."
				.. "",
			QuoteDesc = "",
		},
		[Items.POISON_ACTIVE] = {
			Name = "포이즌",
			Description = ""
				.."#{{Collectible149}} 일반공격이 구토제로 변경"
				.."#{{KirbyActive}} 사용 시 랜덤 방향으로 튀면서 일정 회수 이후 터지는 구토제를 3개 발사합니다."
				.. "",
			QuoteDesc = "",
		},
		[Items.PSYCHIC_ACTIVE] = {
			Name = "에스퍼",
			Description = ""
				.."#{{Collectible329}} 일반공격이 조종식 공격으로 변경"
				.."#캐릭터와 공격 사이에 캐릭터의 공격력 x0.33의 레이저가 생깁니다."
				.."#{{KirbyActive}} (사용 효과 없음)"
				.. "",
			QuoteDesc = "",
		},
		[Items.POOP_ACTIVE] = {
			Name = "풉",
			Description = ""
				.."#{{Collectible725}}{{Collectible576}} 일정 피해 후 {{Player25}}의 똥 발사, 똥 파괴 시 Dip 1~4마리 소환"
				.."#{{KirbyActive}} 사용 시 똥을 쌉니다."
				.. "",
			QuoteDesc = "",
		},
		[Items.SWORD_ACTIVE] = {
			Name = "소드",
			Description = ""
				.."#{{Collectible579}} 일반공격이 영혼검으로 변경"
				.."#{{KirbyActive}} (사용 효과 없음)"
				.. "",
			QuoteDesc = "",
		},
		[Items.SOY_ACTIVE] = {
			Name = "소이",
			Description = ""
				.."#{{Collectible330}} 일반공격이 두유로 변경"
				.."#{{KirbyActive}} 사용 시 공격방향(방사형)으로 눈물을 매우 빠르게 발사합니다."
				.. "",
			QuoteDesc = "",
		},
		[Items.WATER_ACTIVE] = {
			Name = "워터",
			Description = ""
				.."#{{Collectible330}} 비행 + 일반공격이 충전식 방사형 5발 공격으로 변경, 장판을 남김"
				.."#{{KirbyActive}} 사용 시 이동방향으로 돌진하며 주변의 적에게 최대 캐릭터의 공격력 x5의 피해를 줍니다."
				.. "",
			QuoteDesc = "",
		},
		[Items.ROCK_ACTIVE] = {
			Name = "락",
			Description = ""
				.."#{{Collectible592}} 일반공격이 바위 공격으로 변경"
				.."#{{KirbyActive}} 사용 시 바위로 변하여 주변의 적에게 캐릭터의 공격력 x5의 넉백 피해를 줍니다."
				.."#{{Collectible210}} 바위로 변한 뒤 공격하기 전까지 액티브 충전 불가 + 무적 상태 유지"
				.. "",
			QuoteDesc = "",
		},
	}

	for playerType, birthrightdesc in pairs(CharacterDesc) do
		EID:addCharacterInfo(playerType, birthrightdesc.Description, birthrightdesc.Name, "ko_kr")
		if InventoryDescriptions then
			EID:addEntity(InvDescEIDType.PLAYER, InvDescEIDVariant.DEFAULT, playerType, birthrightdesc.Name, birthrightdesc.Detailed, "ko_kr")
		end
		--EID:addBirthright(playerType, birthrightdesc.Birthright, birthrightdesc.Name, "ko_kr")
	end
	for itemID, itemdesc in pairs(CollectibleDesc) do
		local desc = itemdesc.Description
		EID:addCollectible(itemID, desc, itemdesc.Name, "ko_kr")
	end


	return {
		targetMod = "Kirby Mod!",
		characters = CharacterDesc,
		collectibles = CollectibleDesc,
	}

end