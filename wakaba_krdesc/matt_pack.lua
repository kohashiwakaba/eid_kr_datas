
if MattPack and REPENTOGON then

	EID._currentMod = "MattPack"

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
			Name = "발록",
			QuoteDesc = "묵시의 눈",
			__mattConvert = {
				Origin = CollectibleType.COLLECTIBLE_POLYPHEMUS,
				Append = "{{NameC" .. Card.CARD_HUGE_GROWTH .. "}}을 사용하여 변환",
				q5format = true,
			},
		},
		[MattPack.Items.BenightedHeart] = {
			Description = "↓ {{EmptyHeart}}최대 체력 -1"
			.."#↓ {{Heart}}빨간하트 -12"
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
			},
		},
		[MattPack.Items.BoulderBottom] = {
			Description = "모든 일시적 효과가 영구적으로 유지됩니다."
			.."#!!! (부활, 무적류 효과 제외)"
			--.."#Does not get removed upon self-rerolling"
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
		[MattPack.Items.DarkKnife] = {
			Description = "!!방 클리어로 충전 불가, 블랙하트로 충전 가능"
			.."#{{HalfBlackHeart}} 완충이 아닐 시, 블랙하트 드랍률 증가"
			.."#사용 시 칼을 바닥에 찍으며 7초동안 최대 243의 피해를 주는 거대한 빛줄기를 소환합니다."
			.."#거대한 빛줄기 발동 중 주변의 적 및 탄환을 반사, 장애물을 파괴합니다.",
			Name = "검은 칼",
			QuoteDesc = "땅을 뜯으리라",
		},
		[MattPack.Items.DevilsYoYo] = {
			Description = "캐릭터 머리 위에 요요가 소환되며 모든 방의 아이템이 3배로 나옵니다.#상자/판매 아이템은 영향을 받지 않습니다."
			.."#{{Warning}} 캐릭터의 전체 체력이 반칸으로 설정될 확률이 생깁니다.#!!! 빈사확률: 1프레임 당 1/2500#!!! 피격 효과가 최소 1회 이상 발동됨",
			Name = "악마의 요요",
			QuoteDesc = "다가오는 필멸",
			__mattConvert = {
				Origin = CollectibleType.COLLECTIBLE_DAMOCLES,
				Append = '{{NameK' .. CollectibleType.COLLECTIBLE_SPIN_TO_WIN .. "}}를 사용하여 변환",
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
			.."#적에게 지속적으로 레이저를 명중 시 랜덤 4방향으로 공격력 x0.5의 사거리가 짧은 레이저를 발사합니다.",
			Name = "테크 오메가",
			QuoteDesc = "저 멀리서의 쇼크",
		},
		[MattPack.Items.TechOmega] = {
			Description = "공격이 공격력 x0.05의 거대한 지속 레이저 공격으로 변경됩니다."
			.."#적에게 지속적으로 레이저를 명중 시 랜덤 4방향으로 공격력 x0.5의 사거리가 짧은 레이저를 발사합니다.",
			Name = "테크 오메가",
			QuoteDesc = "저 멀리서의 쇼크",
		},
		[MattPack.Items.MutantBody] = {
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
	}


	for itemID, itemdesc in pairs(CollectibleDesc) do
		local desc = itemdesc.Description
		if itemdesc.__mattConvert then
			if itemdesc.__mattConvert.Origin and Q5ToClean[itemdesc.__mattConvert.Origin] then
				EID:removeDescriptionModifier("Q5" .. itemdesc.__mattConvert.Origin)
			end
			EID:addDescriptionModifier("Q5" .. itemdesc.__mattConvert.Origin,
			function(objectDescription)
				if (not itemdesc.__mattConvert.q5format) or MattPack.EIDHintsEnabled then
					if objectDescription.ObjType == 5
					and objectDescription.ObjVariant == 100
					and objectDescription.ObjSubType == itemdesc.__mattConvert.Origin then
						return true
					end
				end
			end,
			function(descObject)
				if itemdesc.__mattConvert.q5format then
					EID:appendToDescription(descObject, "#{{Collectible"..itemID.."}} " .. itemdesc.__mattConvert.Append)
				else
					EID:appendToDescription(descObject, "#"..itemdesc.__mattConvert.Append)
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