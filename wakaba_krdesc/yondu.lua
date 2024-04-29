
if Yondu_Arrow_mod then

	EID._currentMod = "whistle piece"
	local mod = Yondu_Arrow_mod

	local Items = mod.ITEMS
	local Trinkets = mod.TRINKETS

	local BirthrightDesc = {
		[mod.yonduType] = {
			Name = "Yondu",
			Description = "",
			Description = "↑ 화살의 속도 및 공격 빈도 증가",
			QuoteDesc = "욘두의 위력을 느껴라",
		},
	}
	local CollectibleDesc = {
		[mod.ITEMS.active_headpiece] = {
			Name = "욘두의 헤드피스",
			Description = ""
				.."#적에게 피해를 주는 화살이 캐릭터 주변을 돕니다."
				.."#공격키를 누른 상태에서 사용 시 화살이 일정 시간동안 적을 공격합니다."
				.. "",
			QuoteDesc = "휘파람 공격",
		},
		[mod.ITEMS.infinity_replicator] = {
			Name = "인피니티 스톤 복제기",
			Description = ""
				.."#적 처치 시 10%의 확률로 인피니티 스톤을 드랍합니다."
				.."#{{LuckSmall}} 행운 14+일 때 50% 확률"
				.."#피격 시 흡수되지 않은 스톤을 일정량 잃습니다."
				.."#{{BossRoom}} 보스방의 보스 처치 시 모은 스톤을 전부 흡수하나, 보스방에서 피격 시 흡수되지 않은 스톤을 전부 잃습니다."
				.."#{{POWER}} ↑{{DamageSmall}}공격력 +0.1"
				.."#{{SPACE}} ↑{{SpeedSmall}}이동속도 +0.02"
				.."#{{TIME}} ↑{{TearsSmall}}연사 +0.01"
				.."#{{MIND}} ↑{{ShotspeedSmall}}탄속 +0.01"
				.."#{{REALITY}} ↑{{LuckSmall}}행운 +0.2"
				.."#{{SOUL}} {{HolyMantleSmall}}10개 모을 때마다 방어막을 1회 획득합니다."
				.. "",
			QuoteDesc = "스톤을 모아 무한한 힘을 복제",
		},
		[mod.ITEMS.bounty_marker] = {
			Name = "현상금 스크린",
			Description = ""
				.."#방 입장 시 5%의 확률로 적에게 현상금을 설정합니다."
				.."#현상금이 걸린 적 처치 시 니켈을 드랍합니다."
				.. "",
			QuoteDesc = "은하 헌터의 돈 버는 방법",
		},
		[mod.ITEMS.balance.power] = {
			Name = "은하 밸런스 - 힘",
			Description = ""
				.."#↑ {{DamageSmall}}공격력 배율 x1.2"
				.."#↓ {{SpeedSmall}}이동속도 배율 x0.95"
				.."#↓ {{TearsSmall}}연사 배율 x0.95"
				.. "",
			QuoteDesc = "힘을 위해",
		},
		[mod.ITEMS.balance.agility] = {
			Name = "은하 밸런스 - 민첩",
			Description = ""
				.."#↑ {{SpeedSmall}}이동속도 배율 x1.2"
				.."#↓ {{DamageSmall}}공격력 배율 x0.95"
				.."#↓ {{TearsSmall}}연사 배율 x0.95"
				.. "",
			QuoteDesc = "속도를 위해",
		},
		[mod.ITEMS.balance.finesse] = {
			Name = "은하 밸런스 - 세련",
			Description = ""
				.."#↑ {{TearsSmall}}연사 배율 x1.2"
				.."#↓ {{DamageSmall}}공격력 배율 x0.95"
				.."#↓ {{SpeedSmall}}이동속도 배율 x0.95"
				.. "",
			QuoteDesc = "섬세함을 위해",
		},
	}
	local TrinketDesc = {
		[mod.TRINKETS.knife] = {
			Name = "레이저 칼",
			Description = ""
				.."#상자를 3회 공격하여 강제로 열 수 있으나;"
				.."#33%의 확률로 상자가 부서집니다."
				.. "",
			QuoteDesc = "상자 뜯기에 좋을 지도?",
		},
	}

	for playerType, birthrightdesc in pairs(BirthrightDesc) do
		EID:addBirthright(playerType, birthrightdesc.Description, birthrightdesc.Name, "ko_kr")
	end
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
		targetMod = "whistle piece",
		birthright = BirthrightDesc,
		collectibles = CollectibleDesc,
		trinkets = TrinketDesc,
	}

end