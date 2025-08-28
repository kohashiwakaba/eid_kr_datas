
if MattPack then
	if not REPENTOGON then
		table.insert(wakaba_krdesc.ERRORS, {
			NO_RGON = true,
			err_mod = "Lazy Mattpack",
		})
		return
	end

	EID._currentMod = "MattPack"
	local mod = MattPack

	local Q5ToClean = {
		[CollectibleType.COLLECTIBLE_POLYPHEMUS] = true,
		[CollectibleType.COLLECTIBLE_SACRED_HEART] = true,
		[CollectibleType.COLLECTIBLE_ROCK_BOTTOM] = true,
		[CollectibleType.COLLECTIBLE_SPOON_BENDER] = true,
		[CollectibleType.COLLECTIBLE_DAMOCLES] = true,
		[CollectibleType.COLLECTIBLE_MOMS_KNIFE] = true,
		[CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM] = true,
		--[CollectibleType.COLLECTIBLE_CRICKETS_BODY] = true,
	}

	local CollectibleDesc = {
		[MattPack.Items.Balor] = {
			Description = "↑ {{DamageSmall}}공격력 +6"
			.."#↑ {{DamageSmall}}공격력 배율 x3"
			.."#↓ {{TearsSmall}}연사 -1.57"
			.."#↓ {{TearsSmall}}연사 배율 x0.33"
			.."#공격이 적을 관통합니다. (최대 5회)"
			.."#관통할 때마다 효과가 바뀌며 눈물의 피해량이 20%p만큼 감소"
			.."#{{1}} Famine - 둔화"
			.."#{{2}} Pestilence - 중독"
			.."#{{3}} War - 소형 폭발"
			.."#{{4}} Death - 피해량 x2"
			.."#{{5}} Conquest - 빛줄기",
			Name = "발로르",
			QuoteDesc = "묵시의 눈",
			__mattConvert = {
				Origin = CollectibleType.COLLECTIBLE_POLYPHEMUS,
				Append = "{{NameK" .. Card.CARD_HUGE_GROWTH .. "}}을 사용하여 변환",
				q5format = true,
			},
		},
		[MattPack.Items.BenightedHeart] = {
			Description = "↓ {{EmptyHeart}}최대 체력 -1"
			.."#↓ {{Heart}}빨간하트 -12"
			.."#↑ {{BlackHeart}}블랙하트 +2"
			.."#↓ {{DamageSmall}}공격력 -0.4"
			.."#↑ {{TearsSmall}}연사 배율 x2.3"
			.."#↑ {{TearsSmall}}연사 +1"
			.."#↑ {{ShotspeedSmall}}탄속 +0.25"
			.."#적과 픽업이 공격에 끌려옵니다.",
			Name = "무지한 심장",
			QuoteDesc = "위에서와 같이 아래에서도",
			__mattConvert = {
				Origin = CollectibleType.COLLECTIBLE_SACRED_HEART,
				Append = "{{NameC" .. CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL .. "}}/{{NameK" .. Card.CARD_DEVIL .. "}}를 사용하여 변환",
				q5format = true,
				Index = 2,
			},
		},
		[MattPack.Items.BoulderBottom] = {
			Description = "{{Collectible562}} 능력치를 항상 가장 높았던 값으로 고정합니다."
			.."#{{Collectible479}} 장신구 획득 시 흡수됩니다."
			.."#모든 일시적 효과가 영구적으로 유지됩니다."
			.."#>>> ({{Collectible34}}/{{Collectible122}}/{{Collectible160}} 등 그 방 적용 및 시간제 효과)"
			.."#>>> {{ColorYellow}}(부활, 무적류 효과 제외)"
			--.."#이 아이템은 제거되지 않습니다."
			.."",
			Name = "나락",
			QuoteDesc = "이렇게나 올라갈 수 있을까?",
			__mattConvert = {
				Origin = CollectibleType.COLLECTIBLE_ROCK_BOTTOM,
				Append = '{{NameK' .. Card.RUNE_HAGALAZ .. "}}를 사용하여 변환",
				q5format = true,
			},
		},
		[MattPack.Items.CLSpoonBender] = {
			Description = "{{Collectible"..CollectibleType.COLLECTIBLE_SPOON_BENDER .."}} 유도성 효과가 강해집니다."
			.."#유도된 눈물이 계속 떠다닙니다."
			.."#2마리 이상의 적에게 유도된 경우 눈물이 x0.66의 눈물로 갈라집니다.",
			Name = "우스꽝스러운 숟가락",
			QuoteDesc = "오직 숟가락만",
			__mattConvert = {
				Origin = CollectibleType.COLLECTIBLE_SPOON_BENDER,
				Append = '{{NameK' .. Card.CARD_HUGE_GROWTH .. "}}를 사용하여 변환",
				q5format = true,
			},
		},
		[MattPack.Items.KitchenKnife] = {
			Description = "!!! 방 클리어로 충전 불가, 블랙하트로 충전 가능"
			.."#{{HalfBlackHeart}} 완충이 아닐 시, 블랙하트 드랍률 증가"
			.."#사용 시 칼을 바닥에 찍으며 7초동안 그 방의 적에게 방어 무시 피해를 주는 거대한 빛줄기를 소환합니다."
			.."#{{Blank}} 프레임 당 피해량: (0.5 * (스테이지 + 1)), 보스에게 x1.5, 반전 시 x2"
			.."#거대한 빛줄기 발동 중 주변의 적 및 탄환을 반사, 장애물을 파괴합니다.",
			Name = "칼",
			QuoteDesc = "땅을 뜯으리라",
		},
		[MattPack.Items.DevilsYoYo] = {
			Description = "캐릭터 머리 위에 요요가 소환되며 모든 방의 아이템이 3배로 나옵니다."
			.."#{{Warning}} 획득 직후 캐릭터의 전체 체력이 반칸으로 설정될 확률이 생깁니다.#!!! 빈사확률: 1프레임 당 1/2500#!!! 피격 효과가 최소 1회 이상 발동됨",
			Name = "악마의 요요",
			QuoteDesc = "다가오는 필멸",
			__mattConvert = {
				Origin = CollectibleType.COLLECTIBLE_DAMOCLES,
				Append = '{{NameC' .. CollectibleType.COLLECTIBLE_SPIN_TO_WIN .. "}}를 사용하여 변환",
				q5format = true,
			},
		},
		[MattPack.Items.KnifeBender] = {
			Description = "↓ {{TearsSmall}}연사 배율 x0.75"
			.."#↓ {{ShotspeedSmall}}탄속 배율 x0.75"
			.."#{{Collectible"..CollectibleType.COLLECTIBLE_SPOON_BENDER .."}} 탄환이 공격에 끌려오며 주변의 탄환을 흡수합니다."
			.."#탄환을 흡수한 공격은 흡수한 탄환의 피해량 및 효과가 누적되며 사거리가 소량 증가합니다.",
			Name = "초능력 칼",
			QuoteDesc = "유도성 공격?",
			__mattConvert = {
				Origin = CollectibleType.COLLECTIBLE_MOMS_KNIFE,
				Append = '{{Collectible' .. CollectibleType.COLLECTIBLE_SPOON_BENDER .. "}}유도 공격으로 변환",
				q5format = true,
			},
		},
		[MattPack.Items.MultiMush] = {
			Description = "{{MegaArrowUp}} 모든 능력치(악마방,천체방 확률 포함) 배율(+상한) x2"
			.."#↑ {{Heart}}체력 상한 x2"
			.."#{{Warning}} 적 및 탄환의 속도 x1.5",
			Name = "황금버섯",
			QuoteDesc = "2배의 재미!",
			__mattConvert = {
				Origin = CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM,
				Append = '{{GoldenHeart}}황금하트를 파괴하여 변환',
				q5format = true,
			},
		},
		[MattPack.Items.MutantMycelium] = {
			Description = "↑ {{TearsSmall}}연사 배율 x1.25"
			.."#↓ {{DamageSmall}}공격력 배율 x0.85"
			.."#눈물을 4번 발사할 때마다 공격이 4발로 나갑니다.",
			Name = "돌연변이균",
			QuoteDesc = "감염?",
		},
		[MattPack.Items.AltRock] = {
			Description = "{{Warning}}미구현 아이템"
			.."#모든 능력치 증감 효과를 반전시킵니다.",
			Name = "",
			QuoteDesc = "뿌린 대로 거두리라",
		},
		[MattPack.Items.RockCounter] = {
			Description = "{{Warning}}미구현 아이템"
			.."#능력치 감소 효과를 반전시킵니다. (최종 공격력 이후 반영)",
			Name = "",
			QuoteDesc = "실이 곧 득",
		},
		[MattPack.Items.Tech5090] = {
			Description = "이동방향으로 캐릭터 전방에 매우 짧은 레이저를 발사합니다."
			.."#한 방향으로만 이동 시 레이저의 피해량, 사거리, 굵기가 증가하며 탄환을 살짝 밀쳐냅니다."
			.."#{{Blank}} {{ColorGray}}(변화량: 0.5x ~ 5x)",
			Name = "TECH 5090",
			QuoteDesc = "인내를 통한 힘",
		},
		[MattPack.Items.TechOmega] = {
			Description = "공격이 공격력 x0.05의 거대한 지속 레이저 공격으로 변경됩니다."
			.."#적에게 지속적으로 레이저를 명중 시 랜덤 4방향으로 공격력 x0.5의 사거리가 짧은 방사 레이저를 발사합니다.",
			Name = "테크 오메가",
			QuoteDesc = "저 멀리서의 쇼크",
		},
		[MattPack.Items.BloatedBody] = {
			Description = "눈물이 무언가에 부딪힐 때 네갈래로 2번 갈라집니다."
			.."#갈라진 눈물의 공격력은 갈라지기 이전의 절반입니다.",
			Name = "돌연변이 몸체",
			QuoteDesc = "무한의 폭발",
			__mattConvert = {
				Origin = CollectibleType.COLLECTIBLE_CRICKETS_BODY,
				Append = '{{NameK' .. Card.RUNE_JERA .. "}}를 사용하여 변환",
				q5format = true,
			},
		},
		[MattPack.Items.DeadLitter] = {
			Description = ""
			.."#↑ {{DamageSmall}}공격력 배율 x1.66"
			.."#10%의 확률로 고양이 관련 공격이 나갑니다."
			.."#{{LuckSmall}} 행운 10+일 때 50% 확률"
			.."#{{Collectible" .. CollectibleType.COLLECTIBLE_GUPPYS_HEAD .. "}} 공격력 x0.5의 심연의 파리 x3 (1초간 유지됩니다)"
			.."#{{Collectible" .. CollectibleType.COLLECTIBLE_TAMMYS_HEAD .. "}} 캐릭터에게서 9방향 눈물"
			.."#{{Collectible" .. CollectibleType.COLLECTIBLE_CRICKETS_HEAD .. "}} {{Collectible" .. MattPack.Items.BloatedBody .. "}}이중 4분열"
			.."",
			Name = "죽은 새끼",
			QuoteDesc = "4번째는 어디에?",
			__mattConvert = {
				Origin = CollectibleType.COLLECTIBLE_MOVING_BOX,
				Append = "{{Collectible" .. CollectibleType.COLLECTIBLE_GUPPYS_PAW .. "}} {{ColorYellow}}고양이 파츠{{CR}} 3개를 담아 완성",
				q5format = true,
				Logo = true,
			},
		},
		[MattPack.Items.DivineHeart] = {
			Description = ""
			.."#↓ {{TearsSmall}}연사 배율 x0.66"
			.."#↑ {{DamageSmall}}공격력 배율 x1.5"
			.."#↓ {{ShotspeedSmall}}탄속 배율 x0.5"
			.."#{{Collectible"..CollectibleType.COLLECTIBLE_SPOON_BENDER .."}} 공격이 적에게 유도됩니다."
			.."#공격이 적 및 장애물을 관통합니다."
			.."#비행 능력을 얻습니다."
			.."#눈물이 착지할 시 눈물이 지나간 자리에 초당 캐릭터의 공격력 x3.75의 피해를 주는 레이저를 생성합니다."
			.."",
			Name = "신성한 하트",
			QuoteDesc = "오래 가는 믿음",
			__mattConvert = {
				Origin = CollectibleType.COLLECTIBLE_SACRED_HEART,
				Append = "{{EternalHeart}} {{ColorYellow}}이터널하트{{CR}}를 {{ButtonRT}}을 꾹 눌러 희생",
				q5format = true,
				Index = 1,
			},
		},
		[MattPack.Items.WarpedLegion] = {
			Description = ""
			.."#적 직접 처치 시 그 스테이지에서 캐릭터 주변을 도는 미니 인큐버스를 소환합니다."
			.."#미니 인큐버스는 캐릭터의 공격력 x0.06의 피해를 줍니다."
			.."",
			Name = "대군단",
			QuoteDesc = "군단을 만들자",
			__mattConvert = {
				Origin = CollectibleType.COLLECTIBLE_TWISTED_PAIR,
				Append = '{{NameK' .. Card.RUNE_JERA .. "}}를 사용하여 변환",
				q5format = true,
			},
		},
		[MattPack.Items.MoneyisSadness] = {
			Description = "{{TearsSmall}} 동전 1개당 연사 +0.1",
			Name = "돈 = 슬픔",
			QuoteDesc = "돈으로는 행복을 살 수 없어",
		},
	}

	--EID:removeDescriptionModifier("LingerBeanRework")
	EID:addDescriptionModifier("LingerBeanRework",
	function(objectDescription)
		if EID:getLanguage() == "ko_kr" and MattPack.Config.lbReworkEnabled then
			if objectDescription.ObjType == 5
			and objectDescription.ObjVariant == 100
			and objectDescription.ObjSubType == lingerBean then
				return true
			end
		end
	end,
	function(descObject)
		descObject.Description =
			"공격키를 2번 누르면 공격 반대방향으로 구름을 소환합니다."
			.."#{{Timer}} (쿨타임 10초)"
			.."#구름은 7초마다 효과가 추가됩니다."
			.."#{{ArrowGrayRight}} 1단계: 구름이 초당 공격력 x4.29의 피해"
			.."#{{ArrowGrayRight}} 2단계: 지나간 자리에 파란 장판이 생김"
			.."#{{ArrowGrayRight}} 3단계: 장판이 33%의 확률로 캐릭터의 눈물 효과 계승"
			.."#{{ArrowGrayRight}} 4단계: 눈물 효과 확률 100% + 적이 닿으면 공격력 x3의 빛줄기"
		return descObject
	end)

	EID:addDescriptionModifier("DeadLitterCatBitInfo",
	function(objectDescription)
		if EID:getLanguage() == "ko_kr" and MattPack.Config.EIDHintsEnabled then
			if objectDescription.ObjType == 5
			and objectDescription.ObjVariant == 100
			and MattPack.DeadLitterCatBits[objectDescription.ObjSubType]
			and PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_MOVING_BOX) then
				return true
			end
		end
	end,
	function(descObject)
		EID:appendToDescription(descObject, "#{{MPLazyWorm}} "
		.. "{{Collectible" .. CollectibleType.COLLECTIBLE_MOVING_BOX .. "}} Moving Box에 {{ColorYellow}}고양이 파츠{{CR}} 3개를 담아 완성")
		return descObject
	end)

	mod.addSynergyDescription(MattPack.Items.DevilsYoYo,
	CollectibleType.COLLECTIBLE_DAMOCLES,
	"추가 등장 아이템 +1")
	mod.addSynergyDescription(MattPack.Items.CLSpoonBender,
	CollectibleType.COLLECTIBLE_TECH_X,
	"레이저 고리가 적을 향해 이동합니다.")

	-- Synergies
	mod.addSynergyDescription(MattPack.Items.TechOmega,
	CollectibleType.COLLECTIBLE_TECH_X,
	"레이저 고리가 유지되며, 레이저 속도가 감소하나, 피해량과 명중 효과가 감소합니다.")

	--[[ mod.addSynergyDescription(MattPack.Items.TechOmega,
	CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE,
	"Isaac controls a large, low damage laser ring that increases enemies' tech charge on hit") ]]

	mod.addSynergyDescription(MattPack.Items.TechOmega,
	CollectibleType.COLLECTIBLE_BRIMSTONE,
	"방사 레이저가 짧은 혈사포로 바뀝니다.")

	mod.addSynergyDescription(MattPack.Items.TechOmega,
	CollectibleType.COLLECTIBLE_MOMS_KNIFE,
	"방사 레이저가 나올 때 캐릭터의 공격력 x2.5의 칼이 추가로 발사됩니다.")

	-- Multishots
	for i,list in ipairs({mod.multishotPlayersList, mod.multishotsList}) do
		for id,amt in pairs(list) do
			local string = "발사되는 방사 레이저 수 +" .. (amt - 1)
			if i == 1 then
				mod.addSynergyDescription(MattPack.Items.TechOmega, id, string, nil, true)
			else
				mod.addSynergyDescription(MattPack.Items.TechOmega, id, string, nil, nil, true)
			end
		end
	end

	for itemID, itemdesc in pairs(CollectibleDesc) do
		local desc = itemdesc.Description
		if itemdesc.__mattConvert then
			local index = itemdesc.__mattConvert.Index or ""
			if itemdesc.__mattConvert.Origin and Q5ToClean[itemdesc.__mattConvert.Origin] then
				--EID:removeDescriptionModifier("Q5" .. itemdesc.__mattConvert.Origin .. index)
			end
			EID:addDescriptionModifier("Q5" .. itemdesc.__mattConvert.Origin .. index,
			function(objectDescription)
				if (not itemdesc.__mattConvert.q5format) or MattPack.Config.EIDHintsEnabled then
					if objectDescription.ObjType == 5
					and objectDescription.ObjVariant == 100
					and objectDescription.ObjSubType == itemdesc.__mattConvert.Origin then
						return true
					end
				end
			end,
			function(descObject)
				local logo = itemdesc.__mattConvert.Logo and "{{MPLazyWorm}} " or ""
				if itemdesc.__mattConvert.q5format then
					EID:appendToDescription(descObject, "#{{MPLazyWorm}} {{Collectible"..itemID.."}}" .. itemdesc.__mattConvert.Append)
				else
					EID:appendToDescription(descObject, "#"..logo..itemdesc.__mattConvert.Append)
				end
				return descObject
			end)
		end
		EID:addCollectible(itemID, desc, itemdesc.Name, "ko_kr")
	end


	return {
		targetMod = "MattPack",
		collectibles = CollectibleDesc,
	}

end