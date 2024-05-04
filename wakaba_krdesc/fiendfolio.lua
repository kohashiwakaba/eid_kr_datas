
if FiendFolio then
	local versionRequ = "2.8.3"
	local versionNext = "2.8.4"

	if not (FiendFolio.modVersionNumber and FiendFolio.modVersionNumber >= versionRequ) then
		table.insert(wakaba_krdesc.ERRORS, {
			err_mod = "Fiend Folio",
			current = FiendFolio.modVersionNumber,
			required = versionRequ,
		})
		return
	end

  EID._currentMod = "Fiend Folio"
  --EID:setModIndicatorName("Fiend Folio")

  EID.descriptions["en_us"].PerfectGenericObjectCharge = "Perfectly Generic Object charge:"
  EID.descriptions["ko_kr"].PerfectGenericObjectCharge = "Perfectly Generic Object 충전량:"

  EID.InlineIcons["FFCursedPennyTint"] = function(_)
    EID._NextIconModifier = function(sprite)
      sprite.Color = Color(1, 1, 1, EID.Config["Transparency"] * 0.5, 0.5, 0, 0.8)
    end
    return {"Blank", 0, 0, 0}
  end
  EID.InlineIcons["FFCopperBombTint"] = function(_)
    EID._NextIconModifier = function(sprite)
      sprite.Color = Color(1, 1, 1, EID.Config["Transparency"] * 0.3, 0.2, 0.5, 0)
    end
    return {"Blank", 0, 0, 0}
  end
  EID.InlineIcons["FFSpicyKeyTint"] = function(_)
    EID._NextIconModifier = function(sprite)
      sprite.Color = Color(1, 1, 1, EID.Config["Transparency"] * 0.5, 0.5, 0, 0)
    end
    return {"Blank", 0, 0, 0}
  end
  EID.InlineIcons["FFImmoralHeartTint"] = function(_)
    EID._NextIconModifier = function(sprite)
      sprite.Color = Color(1, 1, 1, EID.Config["Transparency"] * 0.5, 0.5, 0.2, 0.7)
    end
    return {"Blank", 0, 0, 0}
  end
  EID.InlineIcons["FFMorbidHeartTint"] = function(_)
    EID._NextIconModifier = function(sprite)
      sprite.Color = Color(1, 1, 1, EID.Config["Transparency"] * 0.15, 0.25, 0.25, 0.25)
    end
    return {"Blank", 0, 0, 0}
  end


	local ffStatusEffectDesc = {
		BERSERK = "#{{ffBerserk}} 폭주 상태의 적은 공격 목표를 수시로 바꾸고 추가 피해를 받으나 더 빠르게 행동합니다.",
		BRUISE = "#{{ffBruise}} 멍든 적은 해당 상태 중첩 수만큼 추가 피해를 받습니다.",
		DOOM = "#{{ffDoom}} 심판 상태의 적은 명중 시마다 카운트가 감소하며;#카운트가 0이 될 때 추가 피해를 주며 심판 상태를 제거합니다.",
		DROWSY_AND_SLEEP = "#{{ffSleeping}} 나른한 적은 서서히 둔화되며 서서히 잠듭니다.#잠든 적은 움직이지 않으며 맞추면 2배의 피해를 받으나 잠듦/나른한 상태가 해제됩니다.",
		HEMORRHAGE = "#{{ffHemorrhage}} 대출혈 상태의 적은 주기적으로 피해를 받고 붉은 장판을 깔며 랜덤 방향으로 핏방울을 흩뿌립니다.",
		MARTYR = "#{{ffMartyr}} 처치된 순교자는 오라와 함께 5초동안 행동불능이 되며 오라 안에 있을 시 {{DamageSmall}}공격력/{{TearsSmall}}연사가 증가하며 공격이 적에게 유도됩니다.",
		SEW = "#{{ffSew}} 귀속된 적이 피해를 받을 시 다른 귀속된 적이 같이 피해를 받습니다.",
		MULTIEUCLIDEAN = "#{{ffmultieuclidean}} 공격이 유클리드 상태의 적을 통과할 수 있으며 2개로 복제되어 나갑니다.",
		GOLEM_NORMAL = "#{{Player"..FiendFolio.PLAYER.GOLEM.."}} 석기 장신구 : 일반 타입",
		GOLEM_FOSSIL = "#{{Player"..FiendFolio.PLAYER.GOLEM.."}} 석기 장신구 : {{ColorRed}}화석{{CR}} 타입",
		GOLEM_GEODE = "#{{Player"..FiendFolio.PLAYER.GOLEM.."}} 석기 장신구 : {{ColorTeal}}정동석{{CR}} 타입",
		GOLEM_DUAL = "#{{Player"..FiendFolio.PLAYER.GOLEM.."}} 석기 장신구 : {{ColorTeal}}정동석{{CR}}+{{ColorRed}}화석{{CR}} 타입",
	}

	wakaba_krdesc.ffStatusEffectDesc = ffStatusEffectDesc

  -- Birthright
	local ffBirthrightDesc = {
		[FiendFolio.PLAYER.FIEND] = {
			Name = "Fiend",
			Description = "Fiend의 파이어볼이 적에게 유도되며;#발사 시 지나간 자리에 불길을 남기며;#폭파 시 적 처치 여부와 관계없이 33%의 확률로 Fiend의 부하를 추가로 소환합니다.#Fiend의 파이어볼로 적 처치 시 {{ffImmoralHeart}}이모럴하트 등장 확률이 증가합니다.",
			QuoteDesc = "악동 파이어볼",
		},
		[FiendFolio.PLAYER.BIEND] = {
			Name = "Tainted Fiend",
			Description = "{{Collectible"..FiendFolio.ITEM.COLLECTIBLE.MALICE.."}}Malice로 적 처치 시 블랙하트를 드랍할 확률이 증가합니다.#{{Collectible"..FiendFolio.ITEM.COLLECTIBLE.MALICE.."}}Malice로 폼 전환 시마다 Fiend의 부하가 각각 랜덤 모자를 쓰며 모자에 따라 {{DamageSmall}}/{{TearsSmall}}/{{LuckSmall}}/{{TearsizeSmall}}이 달라집니다.",
			QuoteDesc = "악한 회복 + 개성 증가",
		},
		[FiendFolio.PLAYER.GOLEM] = {
			Name = "Golem",
			Description = "↑ {{LuckSmall}}행운 +2#색돌 파괴 시 소울하트 대신 석기 장신구를 드랍합니다.",
			QuoteDesc = "단단해진 색돌 + 행운 증가",
		},
		[FiendFolio.PLAYER.SLIPPY] = {
			Name = "Slippy",
			Description = "{{Collectible"..FiendFolio.ITEM.COLLECTIBLE.FROG_HEAD.."}}Golden Frog Head의 방귀의 크기에 따른 독가스를 추가로 남깁니다.",
			QuoteDesc = "더욱 지독해진 냄새",
		},
		[FiendFolio.PLAYER.CHINA] = {
			Name = "China",
			Description = "카드/알약 슬롯에 {{Collectible"..FiendFolio.ITEM.COLLECTIBLE.HORSE_PASTE.."}}Horse Paste 아이템이 배정됩니다.#{{Collectible"..FiendFolio.ITEM.COLLECTIBLE.HORSE_PASTE.."}} 사용 시 {{BrokenHeart}}부서진하트 -1",
			QuoteDesc = "초강력 접착제",
		},
	}

	local ffCardDesc = {
		[FiendFolio.ITEM.CARD.PLUS_3_FIREBALLS] = {
			Description = "파이어볼 불꽃을 3마리 소환합니다.(최대 12)#공격키를 두번 누르면 불꽃을 소모하여 공격하는 방향으로 파이어볼을 발사합니다.",
			Name = "파이어볼 +3",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.REVERSE_3_FIREBALLS] = {
			Description = "{{Collectible"..FiendFolio.ITEM.COLLECTIBLE.MALICE.."}} 캐릭터의 공격방향으로 벽에 여러번 부딪힐 때까지 돌진합니다.#돌진 상태에서 적 처치 시 낮은 확률로 {{BlackHeart}}블랙하트를 드랍합니다.",
			Name = "파이어볼? +3",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.IMPLOSION] = {
			Description = "사용 시 3방향으로 초록색 Fiend의 파이어볼 불꽃을 즉시 발사합니다.#파이어볼 폭파 시 Fiend의 부하를 소환합니다.#Fiend의 부하는 방 클리어 시 소멸합니다.",
			Name = "내부파열",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.CALLING_CARD] = {
			Description = "사용 시 아군 Psi Hunter 몬스터를 소환합니다.",
			Name = "사신 호출 카드",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.PLAGUE_OF_DECAY] = {
			Description = "사용 시 {{RottenHeart}}썩은하트 +5",
			Name = "부패 역병",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.GROTTO_BEAST] = {
			Description = "사용 시 Fiend Folio 출신의 아군 몬스터를 하나 소환합니다.",
			Name = "어두운 곳의 짐승",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.DEFUSE] = {
			Description = "사용 시 트롤폭탄 및 폭탄이 박힌 돌을 해체하여 폭탄 픽업으로 바꾸며;.#폭발성 몬스터를 일반형으로 바꿉니다.",
			Name = "해체",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.POT_OF_GREED] = {
			Description = "카드를 2장 드랍합니다.",
			Name = "욕망의 항아리",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.DOWNLOAD_FAILURE] = {
			Description = "사용 시 그 방의 적은 일부 행동이 중단되거나;#Poople 몬스터의 행동을 합니다: 일정 확률로 미끄러지는 장판을 깔며 캐릭터와 대칭되는 위치로 이동합니다.",
			Name = "다운로드 실패",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.SMALL_CONTRABAND] = {
			Description = "!!! 소지하지 않은 상태에서는 특정 몬스터가 해당 카드를 훔칠 수 있습니다!#해당 카드를 검은 모자의 거지에게 배달 시 특수 배열의 아이템을 소환합니다.#!!! 사용 효과 없음",
			Name = "작은 밀매품",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.SKIP_CARD] = {
			Description = "사용 시 모든 오브젝트 및 엔티티(적/아이템 등)을 지웁니다.#스킵 카드로 방 클리어 시 액티브 아이템 게이지가 충전되지 않으며 방 클리어 보상이 소환되지 않습니다.#{{BossRoom}}보스방의 경우 아이템이 소환되지 않습니다.#최종 보스의 경우 해당 페이즈를 건너뛰지만 마지막 페이즈에서의 사용 시 면역입니다.",
			Name = "스킵 카드",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.CARDJITSU_SOCCER] = {
			Description = "사용 시 그 방에서 굴릴 수 있는 축구공을 소환합니다.#축구공은 접촉 시 적에게 속도에 비례한 피해를 줍니다.",
			Name = "축구",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.CARDJITSU_FLOORING_UPGRADE] = {
			Description = "사용 시 그 방 전체에 랜덤 장판을 깝니다.",
			Name = "바닥 업그레이드",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.CARDJITSU_AC_3000] = {
			Description = "{{Freezing}} 그 방에서 적 처치 시 해당 적을 얼립니다.",
			Name = "",
			QuoteDesc = "",
		},

		[FiendFolio.ITEM.CARD.ENERGY_GRASS] = {
			Description = "방 안의 모든 적을 4초간 {{Poison}}중독시킵니다.",
			Name = "자연 속성 에너지",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.ENERGY_FIRE] = {
			Description = "방 안의 모든 적에게 4초간 {{Burning}}화상을 입힙니다.",
			Name = "불 속성 에너지",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.ENERGY_WATER] = {
			Description = "방 안의 적이 4초간 8방향으로 파란 눈물을 여러번 쏩니다.#파란 눈물을 쏠 때마다 미세한 피해를 받습니다.",
			Name = "물 속성 에너지",
			QuoteDesc = "",
		},-- "Inflicts all enemies in the room with bloating."
		[FiendFolio.ITEM.CARD.ENERGY_LIGHTNING] = {
			Description = "방 안의 모든 적이 4초간 짧은 레이저를 발사하며 미세한 피해를 받습니다.",
			Name = "전기 속성 에너지",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.ENERGY_FIGHTING] = {
			Description = "방 안의 모든 적이 4초간 {{ffBerserk}}폭주 상태가 됩니다.#{{ffBerserk}} 폭주 상태의 적은 공격 목표를 수시로 바꾸고 추가 피해를 받으나 더 빠르게 행동합니다.",
			Name = "폭주 속성 에너지",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.ENERGY_PSYCHIC] = {
			Description = "방 안의 모든 적이 4초간 {{Confusion}}혼란에 걸립니다.",
			Name = "초능력 에너지",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.ENERGY_COLORLESS] = {
			Description = "방 안의 모든 적이 4초간 {{ffHemorrhage}}대출혈에 걸립니다.#{{ffHemorrhage}} 대출혈 상태의 적은 주기적으로 피해를 받고 붉은 장판을 깔며 랜덤 방향으로 핏방울을 흩뿌립니다.",
			Name = "무속성 에너지",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.ENERGY_DARKNESS] = {
			Description = "방 안의 모든 적이 4초간 {{Fear}}공포에 걸립니다.",
			Name = "어둠 속성 에너지",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.ENERGY_METAL] = {
			Description = "방 안의 모든 적을 {{ffBruise}}멍들게 합니다.#{{ffBruise}} 멍든 적은 해당 상태 중첩 수만큼 추가 피해를 받습니다.",
			Name = "강철 속성 에너지",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.ENERGY_FAIRY] = {
			Description = "방 안의 모든 적에게 4초간 {{Charm}}매혹을 겁니다.",
			Name = "요정 속성 에너지",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.ENERGY_DRAGON] = {
			Description = "사용 시 랜덤 에너지 계열 카드 효과를 발동합니다.",
			Name = "드래곤 속성 에너지",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.TRAINER_CARD] = {
			Description = "!!! 현재 미구현.#해당 카드 등장 시 Fiend Folio 제작진에게 문의해 주세요",
			Name = "트레이너 카드",
			QuoteDesc = "",
		},

		[FiendFolio.ITEM.CARD.GLASS_D6] = {
			Description = "{{Collectible105}} 사용 시 방 안의 모든 아이템을 다른 아이템으로 바꿉니다.",
			Name = "유리 6면 조각",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.GLASS_D4] = {
			Description = "{{Collectible284}} 사용 시 소지중인 모든 패시브 아이템을 모두 바꿉니다.#스테이지 진행에 필요한 아이템은 바뀌지 않습니다.",
			Name = "유리 4면 조각",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.GLASS_D8] = {
			Description = "{{Collectible406}} 사용 시 {{DamageSmall}}공격력, {{TearsSmall}}연사, {{RangeSmall}}사거리, {{SpeedSmall}}이동속도 배율을 랜덤으로 바꿉니다.",
			Name = "유리 8면 조각",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.GLASS_D100] = {
			Description = "{{Collectible283}} 사용 시 이하의 주사위 아이템을 모두 발동:#{{Blank}} {{Collectible476}}{{Collectible284}}{{Collectible105}}{{Collectible437}}{{Collectible406}}{{Collectible285}}{{Collectible386}}{{Collectible166}}#방 안의 아이템, 픽업 아이템, 장애물, 소지중인 아이템, 능력치를 모두 바꿉니다.#그 방을 다시 시작하며, 방 클리어 시 이전과 다른 보상이 드랍됩니다.#방 안의 픽업 아이템 중 하나를 복사합니다.",
			Name = "유리 100면 조각",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.GLASS_D10] = {
			Description = "{{Collectible285}} 사용 시 방 안의 모든 적을 바꿉니다.#높은 확률로 최대 체력이 비슷한 적으로 바뀝니다.",
			Name = "유리 10면 조각",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.GLASS_D20] = {
			Description = "{{Collectible166}} 사용 시 방 안의 모든 픽업 아이템을 다른 픽업 아이템으로 바꿉니다.",
			Name = "유리 20면 조각",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.GLASS_D12] = {
			Description = "{{Collectible386}} 사용 시 방 안의 모든 장애물을 바꿉니다.",
			Name = "유리 12면 조각",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.GLASS_SPINDOWN] = {
			Description = "{{Collectible723}} 사용 시 방 안의 모든 아이템을 코드 앞번호의 아이템으로 바꿉니다.#!!! 해금하지 않은 아이템은 등장하지 않습니다.",
			Name = "유리 스핀다운 조각",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.GLASS_AZURITE_SPINDOWN] = {
			Description = "{{Collectible" .. tostring(FiendFolio.ITEM.COLLECTIBLE.AZURITE_SPINDOWN) .. "}} 사용 시 방 안의 모든 장신구를 코드 앞번호의 장신구로 바꿉니다.",
			Name = "아주라이트 스핀다운 조각",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.GLASS_D2] = {
			Description = "{{Collectible" .. tostring(FiendFolio.ITEM.COLLECTIBLE.D2) .. "}} 사용 시 주사위를 들며 공격방향으로 던집니다.#착지한 주사위에 닿은 적, 픽업 아이템, 눈물이 같은 유형의 다른 항목으로 바뀝니다.",
			Name = "유리 2면 조각",
			QuoteDesc = "",
		},

		[FiendFolio.ITEM.CARD.GREEN_HOUSE] = {
			Description = "그 방의 모든 적 및 픽업을 보관합니다.#보관된 적 및 픽업은 다음 방 진입 시 강제로 소환됩니다.",
			Name = "녹색 모형집",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.BRICK_SEPERATOR] = {
			Description = "{{Collectible631}} 사용 시 방 안의 모든 적을 0.4배의 체력을 가진 적 2마리로 나누며;#그 방에서 공격이 적을 관통합니다.",
			Name = "브릭분해기",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.PUZZLE_PIECE] = {
			Description = "운세 퍼즐을 1/3만큼 기록합니다.#!!! 운세 퍼즐이 완성되면 해당 운세에 맞는 아이템을 소환합니다.",
			Name = "퍼즐 조각",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.COOL_PHOTO] = {
			Description = "{{Coin}}동전 1~2개를 소환합니다.",
			Name = "멋진 사진",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.BLANK_LETTER_TILE] = {
			Description = "사용 후 키 입력 시 그 스테이지에서 입력한 키를 키캡에 작성합니다.#작성된 키캡의 키를 누르고 있는 동안:#↑ {{DamageSmall}}공격력 +1#↑ {{TearsSmall}}연사 +1",
			Name = "빈 키캡",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.HORSE_PUSHPOP] = {
			Description = "!!! China 전용#사용 시 {{BrokenHeart}}부서진하트 -1",
			Name = "말 푸시팝",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.TOP_HAT] = {
			Description = "열린 상점 상자를 소환합니다.",
			Name = "탑모자",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.GIFT_CARD] = {
			Description = "방 안의 모든 아이템을 {{Collectible515}}Mystery Gift로 바꿉니다.",
			Name = "선물 카드",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.STUD] = {
			Description = "레고 페니를 하나 소환합니다.#레고 페니는 습득 시 1{{Coin}}을 획득하지만 {{Collectible486}}캐릭터에게 가짜 피해를 줍니다.#레고 페니에 접촉한 적에게 5의 피해를 줍니다.",
			Name = "레고 뚜껑",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.STUD_2] = {
			Description = "레고 페니를 하나 소환합니다.#레고 페니는 습득 시 1{{Coin}}을 획득하지만 {{Collectible486}}캐릭터에게 가짜 피해를 줍니다.#레고 페니에 접촉한 적에게 5의 피해를 줍니다.",
			Name = "레고 뚜껑",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.STUD_3] = {
			Description = "레고 페니를 하나 소환합니다.#레고 페니는 습득 시 1{{Coin}}을 획득하지만 {{Collectible486}}캐릭터에게 가짜 피해를 줍니다.#레고 페니에 접촉한 적에게 5의 피해를 줍니다.",
			Name = "레고 뚜껑",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.STUD_4] = {
			Description = "레고 페니를 하나 소환합니다.#레고 페니는 습득 시 1{{Coin}}을 획득하지만 {{Collectible486}}캐릭터에게 가짜 피해를 줍니다.#레고 페니에 접촉한 적에게 5의 피해를 줍니다.",
			Name = "레고 뚜껑",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.STUD_5] = {
			Description = "레고 페니를 하나 소환합니다.#레고 페니는 습득 시 1{{Coin}}을 획득하지만 {{Collectible486}}캐릭터에게 가짜 피해를 줍니다.#레고 페니에 접촉한 적에게 5의 피해를 줍니다.",
			Name = "레고 뚜껑",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.STUD_6] = {
			Description = "레고 페니를 하나 소환합니다.#레고 페니는 습득 시 1{{Coin}}을 획득하지만 {{Collectible486}}캐릭터에게 가짜 피해를 줍니다.#레고 페니에 접촉한 적에게 5의 피해를 줍니다.",
			Name = "레고 뚜껑",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.CHRISTMAS_CRACKER] = {
			Description = "캐릭터 주변에 작은 폭발을 일으키며 랜덤 오브젝트를 드랍합니다.#캐릭터는 이 폭발에 피해를 입지 않습니다.",
			Name = "크리스마스 캔디",
			QuoteDesc = "",
		},

		[FiendFolio.ITEM.CARD.TREASURE_DISC] = {
			Description = "1분간 3~5개의 {{TreasureRoom}}보물방 배열 패시브 아이템의 효과를 받습니다.",
			Name = "보믈방 체험판 디스크",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.SHOP_DISC] = {
			Description = "1분간 3~5개의 {{Shop}}상점({{Trinket184}}:패밀리어) 배열 패시브 아이템의 효과를 받습니다.",
			Name = "상점 체험판 디스크",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.BOSS_DISC] = {
			Description = "1분간 3~5개의 {{BossRoom}}보스방 배열 패시브 아이템의 효과를 받습니다.",
			Name = "보스방 체험판 디스크",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.SECRET_DISC] = {
			Description = "1분간 3~5개의 {{SecretRoom}}비밀방 배열 패시브 아이템의 효과를 받습니다.",
			Name = "비밀방 체험판 디스크",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.DEVIL_DISC] = {
			Description = "1분간 3~5개의 {{DevilRoom}}악마방 배열 패시브 아이템의 효과를 받습니다.",
			Name = "악마방 체험판 디스크",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.ANGEL_DISC] = {
			Description = "1분간 3~5개의 {{AngelRoom}}천사방 배열 패시브 아이템의 효과를 받습니다.",
			Name = "천사방 체험판 디스크",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.PLANETARIUM_DISC] = {
			Description = "1분간 3~5개의 {{Planetarium}}천체관 배열 패시브 아이템의 효과를 받습니다.",
			Name = "천체관 체험판 디스크",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.CHAOS_DISC] = {
			Description = "1분간 3~5개의 {{Collectible402}}랜덤 배열 패시브 아이템의 효과를 받습니다.",
			Name = "혼돈의 체험판 디스크",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.BROKEN_DISC] = {
			Description = "1분간 3~5개의 {{Collectible347}}동일한 랜덤 패시브 아이템의 효과를 받습니다.",
			Name = "망가진 체험판 디스크",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.TAINTED_TREASURE_DISC] = {
			Description = "1분간 3~5개의 {{TreasureRoom}}더럽혀진 보물방 배열 패시브 아이템의 효과를 받습니다.",
			Name = "더럽혀진 보믈방 체험판 디스크",
			QuoteDesc = "",
		},

		[FiendFolio.ITEM.CARD.MISPRINTED_TWO_OF_CLUBS] = {
			Description = "소지 중인 {{Bomb}}폭탄 x2#!!!소지 중인 모든 폭탄을 {{FFCopperBombTint}}{{Bomb}}구리폭탄으로 바꿉니다.",
			Name = "클로버 2?",
			QuoteDesc = "",
		},

		[FiendFolio.ITEM.CARD.THREE_OF_CLUBS] = {
			Description = "{{Bomb}} 랜덤 폭탄 픽업을 3개 소환합니다.#소환될 수 있는 폭탄의 종류는 각각 동일한 확률을 가집니다.",
			Name = "클로버 3",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.THREE_OF_DIAMONDS] = {
			Description = "{{Coin}} 랜덤 동전 픽업을 3개 소환합니다.#소환될 수 있는 동전의 종류는 각각 동일한 확률을 가집니다.",
			Name = "다이아 3",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.THREE_OF_SPADES] = {
			Description = "{{Key}} 랜덤 열쇠 픽업을 3개 소환합니다.#소환될 수 있는 열쇠의 종류는 각각 동일한 확률을 가집니다.",
			Name = "스페이드 3",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.THREE_OF_HEARTS] = {
			Description = "{{Heart}} 랜덤 하트 픽업을 3개 소환합니다.#소환될 수 있는 하트의 종류는 각각 동일한 확률을 가집니다.",
			Name = "하트 3",
			QuoteDesc = "",
		},

		[FiendFolio.ITEM.CARD.JACK_OF_DIAMONDS] = {
			Description = "{{FFCursedPennyTint}}{{Coin}}저주받은 동전 2~4개를 소환합니다.#그 방의 모든 동전 픽업을 {{FFCursedPennyTint}}{{Coin}}저주받은 동전으로 바꿉니다.",
			Name = "다이아 J",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.MISPRINTED_JACK_OF_CLUBS] = {
			Description = "황금 트롤폭탄을 소환합니다.#그 방의 모든 폭탄 픽업을 트롤폭탄으로 바꿉니다.",
			Name = "클로버 J?",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.JACK_OF_CLUBS] = {
			Description = "{{FFCopperBombTint}}{{Bomb}}구리폭탄 2~3개를 소환합니다.#그 방의 모든 폭탄 픽업을 {{FFCopperBombTint}}{{Bomb}}구리폭탄으로 바꿉니다.",
			Name = "클로버 J",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.JACK_OF_SPADES] = {
			Description = "{{FFSpicyKeyTint}}{{Key}}매운열쇠 2~3개를 소환합니다.#그 방의 모든 열쇠 픽업을 {{FFSpicyKeyTint}}{{Key}}매운열쇠로 바꿉니다.",
			Name = "스페이드 J",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.JACK_OF_HEARTS] = {
			Description = "소지 중인 모든 소울하트/블랙하트를 {{ffImmoralHeart}}이모럴하트로 바꿉니다.#소지 중인 {{SoulHeart}}/{{BlackHeart}}가 없을 경우 {{ffImmoralHeart}}이모럴하트 하나를 드랍합니다.#{{ffImmoralHeart}}이모럴하트 소지 상태에서 피격 시 모든 {{ffImmoralHeart}}가 Fiend의 부하로 바뀌며 방 클리어 시 바뀐 부하는 다시 {{ffImmoralHeart}} 픽업으로 돌아옵니다.",
			Name = "하트 J",
			QuoteDesc = "",
		},

		[FiendFolio.ITEM.CARD.KING_OF_CLUBS] = {
			Description = "기가폭탄을 하나 소환합니다.#다음 폭탄 사용 시 기가폭탄이 설치되며 폭발한 자리에 구덩이가 생기고 적에게 300의 피해를 줍니다.",
			Name = "클로버 K",
			QuoteDesc = "",
		},

		[FiendFolio.ITEM.CARD.QUEEN_OF_DIAMONDS] = {
			Description = "방 안의 모든 돌덩이/똥 오브젝트를 동전으로 바꿉니다.#!!! 바뀐 동전은 잠시 후 사라집니다.",
			Name = "다이아 Q",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.QUEEN_OF_CLUBS] = {
			Description = "{{Collectible52}} 그 방에서 공격이 폭탄 발사 공격으로 변경됩니다.",
			Name = "클로버 Q",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.QUEEN_OF_SPADES] = {
			Description = "{{Key}}열쇠를 1~10개 소환합니다.",
			Name = "스페이드 Q",
			QuoteDesc = "",
		},

		[FiendFolio.ITEM.CARD.KING_OF_DIAMONDS] = {
			Description = "그 방의 적을 적을 멈추게 만들며 멈춘 적 처치시 {{Coin}}동전을 1~3개 드랍합니다.#일부 돌덩이 오브젝트를 금광으로 바꿉니다.",
			Name = "다이아 K",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.KING_OF_SPADES] = {
			Description = "{{Key}}열쇠 +1#{{Collectible623}} 그 방에서 눈물을 쏠 때마다 열쇠를 소모하여 Sharp Key의 열쇠로 바꿉니다.#Sharp Key의 눈물이 무언가에 부딪히거나 떨어지면 열쇠를 드랍합니다.#!!! 열쇠가 없을 경우 변환되지 않습니다.",
			Name = "스페이드 K",
			QuoteDesc = "",
		},

		[FiendFolio.ITEM.CARD.ACE_OF_WANDS] = {
			Description = "방 안의 모든 적과 픽업을 {{Battery}}배터리로 바꿉니다.#!!! 바뀐 배터리는 잠시 후 사라집니다.",
			Name = "완드 A",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.TWO_OF_WANDS] = {
			Description = "소지 중인 {{Battery}}액티브 아이템 충전량 x2.#충전량이 없을 시 충전량 1칸을 채워줍니다.#{{Collectible63}} 초과 충전이 가능합니다.",
			Name = "완드 2",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.THREE_OF_WANDS] = {
			Description = "{{Battery}} {{ColorOrange}}3초 이후 사라지는{{CR}} 랜덤 배터리 픽업을 3개 소환합니다.#소환될 수 있는 배터리 종류는 각각 동일한 확률을 가집니다.",
			Name = "완드 3",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.KING_OF_WANDS] = {
			Description = "방 안의 {{Battery}}배터리 픽업을 강화시킵니다.",
			Name = "완드 K",
			QuoteDesc = "",
		},

		[FiendFolio.ITEM.CARD.ACE_OF_PENTACLES] = {
			Description = "방 안의 모든 적과 픽업을 장신구로 바꿉니다.",
			Name = "펜타클 A",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.TWO_OF_PENTACLES] = {
			Description = "소지 중인 장신구를 복제하여 소환합니다.#소지 중인 장신구가 없을 시 랜덤 장신구를 드랍합니다.#!!! 흡수한 장신구는 복제하지 않습니다.",
			Name = "펜타클 2",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.THREE_OF_PENTACLES] = {
			Description = "랜덤 장신구(석기 장신구 포함)를 3개 소환합니다.#각 장신구는 50%의 확률로 황금 형태로 소환됩니다.",
			Name = "펜타클 3",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.KING_OF_PENTACLES] = {
			Description = "소지 중인 장신구를 황금 형태로 바꿉니다.#!!! 흡수한 장신구는 무효과",
			Name = "펜타클 K",
			QuoteDesc = "",
		},

		[FiendFolio.ITEM.CARD.ACE_OF_SWORDS] = {
			Description = "방 안의 모든 적과 픽업을 아군 자폭 파리/거미/벼룩으로 바꿉니다.",
			Name = "소드 A",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.TWO_OF_SWORDS] = {
			Description = "사용 시 방 안의 모든 아군 dip 및 자폭 파리/거미/벼룩을 복제하며;#{{Collectible357}} 그 방에서 소지중인 패밀리어를 복사합니다.#복사할 수 있는 패밀리어가 없다면 그 방에서 {{Collectible113}}Demon Baby 패밀리어를 소환합니다.",
			Name = "소드 2",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.THREE_OF_SWORDS] = {
			Description = "사용 시 랜덤 색상의 아군 자폭 파리/거미/벼룩/flea/dip을 3마리 소환합니다.",
			Name = "소드 3",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.KING_OF_SWORDS] = {
			Description = "{{Collectible247}} 그 스테이지에서 패밀리어의 공격력을 2배로 증가시킵니다.",
			Name = "소드 K",
			QuoteDesc = "",
		},

		[FiendFolio.ITEM.CARD.ACE_OF_CUPS] = {
			Description = "방 안의 모든 적과 픽업을 알약으로 바꿉니다.",
			Name = "컵 A",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.TWO_OF_CUPS] = {
			Description = "소지 중인 알약 및 방 안의 모든 알약을 복제합니다.#복제할 알약이 없을 경우 랜덤 알약을 2개 드랍합니다.",
			Name = "컵 2",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.THREE_OF_CUPS] = {
			Description = "랜덤 알약을 3개 소환합니다.#각 알약은 50%의 확률로 거대 형태로 소환됩니다.",
			Name = "컵 3",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.KING_OF_CUPS] = {
			Description = "소지 중인 알약 및 방 안의 모든 알약을 거대 형태로 바꿉니다.",
			Name = "컵 K",
			QuoteDesc = "",
		},

		[FiendFolio.ITEM.CARD.MISPRINTED_JOKER] = {
			Description = "사용 시 방 안의 모든 아이템을 {{DevilRoom}}악마방/{{AngelRoom}}천사방 아이템으로 바꿉니다.#!!! 낮은 확률로 아이템이 아닌 성스러운/악한 테마의 하트/상자 픽업으로 바뀝니다.",
			Name = "조커?",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.THIRTEEN_OF_STARS] = {
			Description = "{{Collectible721}} 2~6개의 효과와 발동 조건이 혼합된 오류 아이템을 소환합니다.",
			Name = "스타 13",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.REVERSE_KING_OF_CLUBS] = {
			Description = "사용 시 사망하며 캐릭터의 자리에 기가폭탄의 폭발을 일으킵니다.",
			Name = "클로버 K?",
			QuoteDesc = "",
		},

		[FiendFolio.ITEM.CARD.RUNE_ANSUS] = {
			Description = "{{Collectible333}} (거짓)그 스테이지에서 맵에 특수방 위치, 비밀방 위치, 스테이지 구조가 표시됩니다.",
			Name = "안수즈?",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.SOUL_OF_FIEND] = {
			Description = "사용 시 Fiend의 부하를 5~8마리(일반형)와 0~2마리(블랙형) 소환합니다.",
			Name = "핀드의 영혼",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.SOUL_OF_GOLEM] = {
			Description = "석기 장신구를 3개 드랍합니다.",
			Name = "골렘의 영혼",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.SOUL_OF_RANDOM] = {
			Description = "사용 시 랜덤 영혼석 효과를 발동합니다.",
			Name = "미지의 영혼석",
			QuoteDesc = "",
		},

		[FiendFolio.ITEM.CARD.STORAGE_BATTERY_0] = {
			Description = "사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.#충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다.#{{Collectible63}} 초과 충전이 가능합니다.#{{Card" .. tostring(Card.CORRODED_BATTERY_0) .. "}} 스테이지 진입 시 부식되며 부식된 상태에서 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.",
			Name = "보조 배터리",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.STORAGE_BATTERY_1] = {
			Description = "사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.#충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다.#{{Collectible63}} 초과 충전이 가능합니다.#{{Card" .. tostring(Card.CORRODED_BATTERY_1) .. "}} 스테이지 진입 시 부식되며 부식된 상태에서 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.",
			Name = "보조 배터리",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.STORAGE_BATTERY_2] = {
			Description = "사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.#충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다.#{{Collectible63}} 초과 충전이 가능합니다.#{{Card" .. tostring(Card.CORRODED_BATTERY_2) .. "}} 스테이지 진입 시 부식되며 부식된 상태에서 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.",
			Name = "보조 배터리",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.STORAGE_BATTERY_3] = {
			Description = "사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.#충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다.#{{Collectible63}} 초과 충전이 가능합니다.#{{Card" .. tostring(Card.CORRODED_BATTERY_3) .. "}} 스테이지 진입 시 부식되며 부식된 상태에서 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.",
			Name = "보조 배터리",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.CORRODED_BATTERY_0] = {
			Description = "사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.#충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다.#{{Collectible63}} 초과 충전이 가능합니다.#!!! 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.",
			Name = "부식된 배터리",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.CORRODED_BATTERY_1] = {
			Description = "사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.#충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다.#{{Collectible63}} 초과 충전이 가능합니다.#!!! 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.",
			Name = "부식된 배터리",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.CORRODED_BATTERY_2] = {
			Description = "사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.#충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다.#{{Collectible63}} 초과 충전이 가능합니다.#!!! 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.",
			Name = "부식된 배터리",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.CARD.CORRODED_BATTERY_3] = {
			Description = "사용 시 액티브 아이템의 충전량을 최대 3칸까지 저장합니다.#충전된 상태에서 재사용 시 충전량을 액티브 아이템으로 옮깁니다.#{{Collectible63}} 초과 충전이 가능합니다.#!!! 액티브 아이템 충전 시 잠시 후 충전한 위치에서 폭발합니다.",
			Name = "부식된 배터리",
			QuoteDesc = "",
		},
	}
	local ffPillDesc = {
		[FiendFolio.ITEM.PILL.CYANIDE] = {
			Description = "↑ 발동 중일 때 모든 능력치 증가#{{Pill}}방 클리어 시 알약이 등장할 확률이 대폭 증가합니다.#!!! {{Pill}}{{ColorRed}}다른 알약을 사용하지 않았을 경우 60초 후 캐릭터가 즉사합니다.",
			Name = "나트륨",
			QuoteDesc = "모든 능럭치 증가, 1분 안에 다른 알약을 먹어야 한다!",
		},
		[FiendFolio.ITEM.PILL.MELATONIN] = {
			Description = "{{ffSleeping}} 방 안의 적을 나른한 상태로 만듭니다.#{{ffSleeping}} 나른한 적은 서서히 둔화되며 서서히 잠듭니다.#잠든 적은 움직이지 않으며 맞추면 2배의 피해를 받으나 잠듦/나른한 상태가 해제됩니다.",
			Name = "멜라토닌",
			QuoteDesc = "적이 서서히 잠듦",
		},
		[FiendFolio.ITEM.PILL.HOLY_SHIT] = {
			Description = "신성한 똥을 쌉니다.",
			Name = "이런 젠장",
			QuoteDesc = "신성한 똥을 쌌다!",
		},
		[FiendFolio.ITEM.PILL.HAEMORRHOIDS] = {
			Description = "빨간 똥을 쌉니다.",
			Name = "치질",
			QuoteDesc = "빨간 똥을 쌌다!",
		},
		[FiendFolio.ITEM.PILL.FISH_OIL] = {
			Description = "↑ 눈물크기 증가",
			Name = "생선 기름",
			QuoteDesc = "눈물 크기 증가",
		},
		[FiendFolio.ITEM.PILL.LEMON_JUICE] = {
			Description = "↓ 눈물크기 감소",
			Name = "레몬 주스",
			QuoteDesc = "눈물 크기 감소",
		},
		[FiendFolio.ITEM.PILL.EPIDERMOLYSIS] = {
			Description = "↓ 그 방에서 피격 무적시간 감소",
			Name = "표피분해",
			QuoteDesc = "피격 무적시간 감소",
		},
		[FiendFolio.ITEM.PILL.CLAIRVOYANCE] = {
			Description = "{{CurseCursedSmall}} Labyrinth 및 특수 시드를 제외한 현재 스테이지의 저주를 제거합니다.",
			Name = "투시",
			QuoteDesc = "저주 해제",
		},
		[FiendFolio.ITEM.PILL.SPIDER_UNBOXING] = {
			Description = "아군 거미를 여러 마리 소환합니다.",
			Name = "거미 대개봉",
			QuoteDesc = "",
		},
	}
	local ffCollectibleDesc = {
		[FiendFolio.ITEM.COLLECTIBLE.PYROMANCY] = {
			Description = "주기적으로 캐릭터의 주변을 도는 Fiend의 파이어볼이 최대 3마리까지 생성됩니다.#공격키를 두번 누르면 파이어볼을 발사합니다.#발사한 파이어볼은 지나간 자리에 작은 불을 남기며 무언가에 부딪힐 시 폭발합니다.",
			Name = "방화술사",
			QuoteDesc = "더블탭 파이어볼",
		},
		[FiendFolio.ITEM.COLLECTIBLE.FIEND_FOLIO] = {
			Description = "사용 시 그 방에서 Fiend Folio 출신 아군 보스를 소환합니다.#소환된 아군 보스는 일부 패턴 사용 후 떠납니다.",
			Name = "",
			QuoteDesc = "악마의 친구들 소환",
		},
		[FiendFolio.ITEM.COLLECTIBLE.D2] = {
			Description = "사용 시 주사위를 들며 공격방향으로 던집니다.#착지한 주사위에 닿은 적, 픽업 아이템, 눈물이 같은 유형의 다른 항목으로 바뀝니다.",
			Name = "2면 주사위",
			QuoteDesc = "던질 수 있는 주사위",
		},
		[FiendFolio.ITEM.COLLECTIBLE.STORE_WHISTLE] = {
			Description = "사용 시 미니 상점 상자를 소환합니다.#미니 상점은 열 때 {{Key}}열쇠를 하나 소모하며 열 때 1~3개의 상점 품목을 판매합니다.",
			Name = "상점 호루라기",
			QuoteDesc = "이동식 상점",
		},
		[FiendFolio.ITEM.COLLECTIBLE.DICE_BAG] = {
			Description = "방 8개({{Collectible247}}:3개) 클리어 시 유리 주사위 조각을 드랍합니다.#유리 주사위 조각은 각 주사위를 일회성으로 사용할 수 있습니다.#Glass D4 및 Glass D100 사용 시에도 Dice Bag가 보존됩니다.",
			Name = "주사위 가방",
			QuoteDesc = "주사위가 한가득",
		},
		[FiendFolio.ITEM.COLLECTIBLE.LIL_FIEND] = {
			Description = "대각선으로 이동하며 적 및 탄환과 접촉 시 일정 확률로 Fiend의 부하를 소환합니다.#Lil Fiend로 소환된 Fiend의 부하는 방 클리어 시 사라지며 블랙하트를 드랍하지 않습니다.#{{Collectible247}}BFFs 소지 시 접촉 판정 크기 및 부하 소환 확률 증가",
			Name = "리틀 핀드",
			QuoteDesc = "너만의 악마",
		},
		[FiendFolio.ITEM.COLLECTIBLE.BABY_CRATER] = {
			Description = "공격하는 동안 크레이터 주변을 도는 눈물을 최대 8개까지 모으며;#공격키를 떼면 모은 눈물을 발사합니다.#Womb 스테이지의 핏덩이 오브젝트 파괴 시 낮은 확률로 소환됩니다.",
			Name = "크레이터 아기",
			QuoteDesc = "소용돌이 친구",
		},
		[FiendFolio.ITEM.COLLECTIBLE.MAMA_SPOOTER] = {
			Description = "적을 추적하며 주기적으로 적을 향해 눈물을 발사합니다.",
			Name = "미스 스푸터",
			QuoteDesc = "추격 터렛",
		},
		[FiendFolio.ITEM.COLLECTIBLE.RANDY_THE_SNAIL] = {
			Description = "방 안을 느리게 돌아다니며 캐릭터 및 캐릭터의 눈물과 접촉 시 껍질에 숨으면서 굴러갑니다.#굴러가는 도중 캐릭터/눈물 및 적과 계속 접촉하여 연속적으로 굴릴 수 있습니다.#{{Collectible247}}BFFs 소지 시 접촉 판정 크기 및 피해량 증가",
			Name = "달팽이 랜디",
			QuoteDesc = "도탄 친구",
		},
		[FiendFolio.ITEM.COLLECTIBLE.CORN_KERNEL] = {
			Description = "획득할 때마다 성장합니다.#1/2단계: 캐릭터의 주위를 돌며 적의 탄환을 막아줍니다.#2/4단계: 공격하는 방향으로 공격력 3.5의 {{ColorOrange}}폭발성{{CR}} 눈물을 발사합니다.#3/4단계: 방 안을 돌아다니며 주기적으로 랜덤 위치로 순간이동합니다.#4단계: 적을 따라다니며 접촉한 적에게 3.5의 피해를 줍니다.",
			Name = "옥수수 알갱이",
			QuoteDesc = "넌 내 옥수수야!",
		},
		[FiendFolio.ITEM.COLLECTIBLE.GRABBER] = {
			Description = "캐릭터의 반대로 움직이며 캐릭터가 있는 방향으로 손을 움직입니다.#잡는 손에 닿은 적에게 5의 피해를 줍니다.",
			Name = "욕심쟁이",
			QuoteDesc = "손을 던지는 친구",
		},
		[FiendFolio.ITEM.COLLECTIBLE.PEACH_CREEP] = {
			Description = "벽을 따라 움직이며 적과 일렬로 맞추고 공격력 2의 눈물을 4발 연속으로 발사합니다.",
			Name = "피치 크리프",
			QuoteDesc = "무서운 친구",
		},
		[FiendFolio.ITEM.COLLECTIBLE.GMO_CORN] = {
			Description = "↑ {{Heart}}최대 체력 +1#↑ {{DamageSmall}}공격력 +1#{{Pill}} 획득 시 강제로 랜덤 알약을 7개({{Collectible252}}:10개) 사용합니다.",
			Name = "유전자 변형 옥수수",
			QuoteDesc = "악마의 채소",
		},
		[FiendFolio.ITEM.COLLECTIBLE.COOL_SUNGLASSES] = {
			Description = "↑ {{Coin}}동전 +6#{{SpeedSmall}} 동전과 가까울수록 이동속도가 빨라집니다.#{{Coin}} 동전 획득 시 방 전체에게 피해를 줍니다.#!!! 방 진입 시 소지 중인 동전 3개를 강제로 랜덤 위치에 뿌립니다.",
			Name = "멋진 선글라스",
			QuoteDesc = "황금 러쉬",
		},
		[FiendFolio.ITEM.COLLECTIBLE.FIENDS_HORN] = {
			Description = "적 처치 시 5%의 확률로 Fiend의 부하를 소환합니다.#!!! {{LuckSmall}}행운 수치 비례: 행운 14 이상일 때 20% 확률#소지한 {{ffImmoralHeart}}이모럴하트에 비례하여 소환 확률이 추가로 증가합니다.#Fiend의 부하는 방 클리어 시 소멸합니다.",
			Name = "핀드의 뿔",
			QuoteDesc = "우리 모두의 마음 속엔 악이 자리잡고 있지",
		},
		[FiendFolio.ITEM.COLLECTIBLE.RISKS_REWARD] = {
			Description = "!!! 스테이지 당 보물방에서만 1회 사용 가능:#사용 시 방 안의 아이템을 특수한 이공간으로 빨아들이며 더 높은 등급의 아이템으로 바꿉니다.#검은 포탈을 통해 특수한 이공간으로 이동할 수 있으며 이공간에서 Hermit 처치 시 바뀐 아이템을 획득할 수 있습니다.",
			Name = "위험에 따른 보상",
			QuoteDesc = "초능력으로 바꾸기 + 더 나은 아이템",
		},
		[FiendFolio.ITEM.COLLECTIBLE.SPARE_RIBS] = {
			Description = "↑ {{EmptyBoneHeart}}뼈하트 +1#피격 시 일정 확률로 뼛조각 여러개를 발사합니다.#뼛조각은 발사 후 캐릭터에게 되돌아오며 적 및 탄환을 막아줍니다.",
			Name = "여분의 뼛조각",
			QuoteDesc = "주인에게로 돌아가거라",
		},

		[FiendFolio.ITEM.COLLECTIBLE.BACON_GREASE] = {
			Description = "↑ {{EmptyHeart}}빈 최대 체력 +1#↓ {{Heart}}빨간하트 -1#↑ {{ShotspeedSmall}}탄속 +0.15",
			Name = "베이컨 지방",
			QuoteDesc = "저칼로리",
		},
		[FiendFolio.ITEM.COLLECTIBLE.NUGGET_BOMBS] = {
			Description = "↑ {{Bomb}}폭탄 +5#{{Collectible504}} 폭탄이 터진 자리에 주위의 적에게 공격력 3.5의 눈물을 발사하는 파란 파리를 설치합니다.",
			Name = "너겟 폭탄",
			QuoteDesc = "친구가 담긴 폭탄 + 폭탄 5개",
		},
		[FiendFolio.ITEM.COLLECTIBLE.DEVILS_UMBRELLA] = {
			Description = "때때로 적에게 피해를 주는 노란 장판을 까는 작은 눈물을 여러 개 흩뿌립니다.#{{LuckSmall}}행운이 높을수록 노란 눈물의 주기가 짧아집니다.",
			Name = "악마의 우산",
			QuoteDesc = "청소하기 너무 힘든 것",
		},
		[FiendFolio.ITEM.COLLECTIBLE.BEE_SKIN] = {
			Description = "눈물을 발사할 때마다 3방향으로 공격력 x0.3의 눈물을 발사합니다.#3방향 눈물은 시계방향으로 서서히 돌아가면서 발사됩니다.",
			Name = "꿀벌의 몸통",
			QuoteDesc = "위이이잉",
		},
		[FiendFolio.ITEM.COLLECTIBLE.ALPHA_COIN] = {
			Description = "사용 시 각각 발동:#25% 의 확률로 {{Coin}}동전을 드랍합니다.#25%의 확률로 {{Card}}카드/{{Pill}}알약을 드랍합니다.#현재 방 및 스테이지 진행 상태에 따라 다른 효과를 발동합니다.",
			Name = "알파 코인",
			QuoteDesc = "사용법을 배우거라",
		},
		[FiendFolio.ITEM.COLLECTIBLE.DADS_WALLET] = {
			Description = "획득 시 {{Card43}}Credit Card를 드랍합니다.#소지 중인 동전이 부족해도 상점 아이템을 구매할 수 있습니다.#부족한 금액 당 {{DamageSmall}}{{ColorOrange}}공격력 배율{{CR}}이 감소합니다.#!!! 부족한 예상 금액이 99{{Coin}}인 경우 더 이상 구매할 수 없습니다.",
			Name = "아빠의 지갑",
			QuoteDesc = "공격력 빚지기",
		},
		[FiendFolio.ITEM.COLLECTIBLE.FROG_HEAD] = {
			Description = "사용 버튼을 누르고 있는 동안 캐릭터를 멈추게 합니다.#멈춘 시간에 비례하여 적을 밀어내는 방귀를 뀝니다.",
			Name = "황금 개구리 머리",
			QuoteDesc = "방귀는 좋아",
		},
		[FiendFolio.ITEM.COLLECTIBLE.BEGINNERS_LUCK] = {
			Description = "↑ {{LuckSmall}}행운 +5#↓ 스테이지 진행 상태 당 {{LuckSmall}}행운 -0.5(최소 1)",
			Name = "초심자의 행운",
			QuoteDesc = "시간이 지날수록 줄어드는 행운",
		},
		[FiendFolio.ITEM.COLLECTIBLE.DICHROMATIC_BUTTERFLY] = {
			Description = "피격 판정 크기가 줄어들며 피격 판정의 범위가 표시됩니다.#탄환을 가까스로 피할 시 그 방에서 {{DamageSmall}}공격력 +0.2(최대 +3)#일정 확률로 공격력 x1.25의 강한 유도 공격이 나갑니다.",
			Name = "색이 다른 나비",
			QuoteDesc = "피격 판정 감소, 유도성 부적",
		},
		[FiendFolio.ITEM.COLLECTIBLE.BIRTHDAY_GIFT] = {
			Description = "{{Collectible515}} 모든 아이템이 Mystery Gift로 등장합니다.#바뀐 아이템 및 고정 드랍은 Mystery Gift로 변경되지 않습니다.",
			Name = "생일 선물",
			QuoteDesc = "뭘 원할 건지 생각해",
		},
		[FiendFolio.ITEM.COLLECTIBLE.IMP_SODA] = {
			Description = "확률적으로({{LuckSmall}}) 치명타 피해를 주는 공격을 발사합니다.#치명타는 적에게 공격력 x5의 피해를 줍니다.",
			Name = "도깨비 소다",
			QuoteDesc = "치명타 공격",
		},
		[FiendFolio.ITEM.COLLECTIBLE.SLIPPYS_GUTS] = {
			Description = "적 처치 시 최대 체력에 비례한 확률로 작은 구름을 생성합니다.#폭탄이 터지면 그 자리에 작은 구름을 생성합니다.#{{Poison}} 작은 구름은 닿은 적을 중독시킵니다.",
			Name = "슬리피의 내장",
			QuoteDesc = "음정",
		},
		[FiendFolio.ITEM.COLLECTIBLE.SLIPPYS_HEART] = {
			Description = "적에게 가까이 있으면 확률적으로({{LuckSmall}}) 적을 밀쳐내는 랜덤 방귀를 뀝니다.",
			Name = "슬리피의 심장",
			QuoteDesc = "정교",
		},
		[FiendFolio.ITEM.COLLECTIBLE.COMMUNITY_ACHIEVEMENT] = {
			Description = "↑ {{DamageSmall}}공격력 +"..(math.ceil(100 * math.log(FiendFolio.CountingChannelWorldRecords.Canon.Regular * math.log(FiendFolio.CountingChannelWorldRecords.Canon.Hardcore, 10),15))/100).."#{{DamageSmall}}공격력 증가량은 Fiend Folio 디스코드 Counting 계열 채널의 기록에 비례합니다.#!!! 현재 모드에 기록된 최고기록:#{{Blank}} 일반:"..FiendFolio.CountingChannelWorldRecords.Canon.Regular.."#{{Blank}} 하드:"..FiendFolio.CountingChannelWorldRecords.Canon.Hardcore,
			Name = "커뮤니티 업적",
			QuoteDesc = "숫자세기에 정통",
		},
		[FiendFolio.ITEM.COLLECTIBLE.CHIRUMIRU] = {
			Description = "↑ {{SoulHeart}}소울하트 +1#↑ {{DamageSmall}}공격력 +0.9#방 입장 시 모든 적을 0.9초간 석화시킵니다.",
			Name = "치르밀",
			QuoteDesc = "체력, 공격력 증가 + [퍼펙트 프리즈]",
		},
		[FiendFolio.ITEM.COLLECTIBLE.GOLEMS_ORB] = {
			Description = "↑ {{SoulHeart}}소울하트 +2#↑ {{SpeedSmall}}이동속도 +0.2#↑ {{ShotspeedSmall}}탄속 +0.23#↑ {{LuckSmall}}행운 +1",
			Name = "골렘의 오브",
			QuoteDesc = "분실품",
		},
		[FiendFolio.ITEM.COLLECTIBLE.GOLEMS_ROCK] = {
			Description = "획득 시 석기 장신구를 소환합니다.#사용 시 현재 소지 중인 장신구를 빻아 석기 장신구를 소환합니다.#석기 장신구는 일반적으로 등장하지 않으며 Golem 캐릭터 플레이 시에만 등장하는 특수 장신구입니다.",
			Name = "골렘의 맷돌",
			QuoteDesc = "장신구 분해기",
		},
		[FiendFolio.ITEM.COLLECTIBLE.LEFTOVER_TAKEOUT] = {
			Description = "↑ {{Heart}}최대 체력 +1#↑ {{DamageSmall}}공격력 배율 x1.5#↑ {{TearsSmall}}공격 딜레이 x0.9(연사 증가)#↑ {{RangeSmall}}사거리 +1.5#↑ {{SpeedSmall}}이동속도 +0.3#↑ {{LuckSmall}}행운 +1#확률적으로({{LuckSmall}}) 적에게 명중 시 운세를 보여주는 공격력 x1.05의 포춘쿠키를 발사합니다.",
			Name = "먹다 남은 배달 음식",
			QuoteDesc = "모든 능력치 증가 + 운세 증가",
		},
		[FiendFolio.ITEM.COLLECTIBLE.CLEAR_CASE] = {
			Description = "!!! 획득과 동시에 카드/알약 슬롯에 배치됨#소지한 상태에서 다음 액티브 아이템 획득 시 해당 액티브 아이템이 카드/알약 슬롯에 배치됩니다.",
			Name = "투명 케이스",
			QuoteDesc = "간편한 액티브 아이템 수납공간",
		},
		[FiendFolio.ITEM.COLLECTIBLE.MODERN_OUROBOROS] = {
			Description = "공격이 무언가에 부딪힐 때 기름 장판이 생기며 #캐릭터/불이 기름 장판에 닿으면 불이 붙습니다.#캐릭터는 이 불에 피해를 받지 않습니다.",
			Name = "모던 우로보로스",
			QuoteDesc = "악마를 닮은 목소리",
		},
		[FiendFolio.ITEM.COLLECTIBLE.BLACK_LANTERN] = {
			Description = "↑ {{BlackHeart}}블랙하트 +1#{{CurseCursedSmall}} 항상 저주에 걸리며 기존의 저주가 아닌 새로운 형태의 저주가 걸립니다.",
			Name = "검은 랜턴",
			QuoteDesc = "낙관스런 저주",
		},
		[FiendFolio.ITEM.COLLECTIBLE.CRUCIFIX] = {
			Description = "적 처치 시 {{ffMartyr}}순교자로 만듭니다.",
			Name = "십자가",
			QuoteDesc = "우리의 죄를 사하소서",
			StatusEffects = {ffStatusEffectDesc.MARTYR},
		},
		[FiendFolio.ITEM.COLLECTIBLE.BEDTIME_STORY] = {
			Description = "{{ffSleeping}} 사용 시 방 안의 적을 나른한 상태로 만듭니다.",
			Name = "자장가",
			QuoteDesc = "이제 눈을 감을 시간",
			StatusEffects = {ffStatusEffectDesc.DROWSY_AND_SLEEP},
		},
		[FiendFolio.ITEM.COLLECTIBLE.PINHEAD] = {
			Description = "확률적으로({{LuckSmall}}) 적을 {{ffSew}}귀속시키는 재봉틀 눈물을 발사합니다.",
			Name = "묶인 단추",
			QuoteDesc = "재봉틀 발사",
			StatusEffects = {ffStatusEffectDesc.SEW},
		},
		[FiendFolio.ITEM.COLLECTIBLE.PRANK_COOKIE] = {
			Description = "공격할 때마다 확률적으로 랜덤한 상태이상 효과 공격이 나갑니다.#{{Blank}} ({{ffBerserk}}/{{ffBruise}}/{{ffDoom}}/{{ffSleeping}}/{{ffHemorrhage}}/{{ffMartyr}}/{{ffSew}}/{{ffmultieuclidean}})",
			Name = "장난꾸러기 쿠키",
			QuoteDesc = "옥수수 맛이 나",
		},
		[FiendFolio.ITEM.COLLECTIBLE.DEVILS_HARVEST] = {
			Description = "↑ 목숨 +1#사망 시 전 방에서 Fiend 캐릭터로 부활합니다.",
			Name = "악마의 수확",
			QuoteDesc = "개조된 생명",
		},
		[FiendFolio.ITEM.COLLECTIBLE.RUBBER_BULLETS] = {
			Description = "확률적으로({{LuckSmall}}) 적을 {{ffBruise}}멍들게 하는 총알을 발사합니다.",
			Name = "고무 총알",
			QuoteDesc = "멍들게 하는 총알",
			StatusEffects = {ffStatusEffectDesc.BRUISE},
		},
		[FiendFolio.ITEM.COLLECTIBLE.THE_DELUXE] = {
			Description = "↑ {{BoneHeart}}뼈하트 +1#↑ {{ffMorbidHeart}}병든하트 +1#↑ 황금하트 +1#↑ {{EternalHeart}}이터널하트 +1",
			Name = "디럭스 세트",
			QuoteDesc = "각종 조미료",
		},
		[FiendFolio.ITEM.COLLECTIBLE.LIL_MINX] = {
			Description = "적에게 돌진하여 접촉한 적에게 3.5의 피해를 줍니다.#공격키를 두번 누르면 가장 가까운 적에게 빙의하여 {{ffBerserk}}폭주 상태로 만듭니다.#빙의 중인 적이 있을 때 다시 공격키를 두번 누르면 여러 개의 눈물을 흩뿌리며 빠져나옵니다.",
			Name = "리틀 밍스",
			QuoteDesc = "더블탭 빙의",
			StatusEffects = {ffStatusEffectDesc.BERSERK},
		},
		[FiendFolio.ITEM.COLLECTIBLE.PURPLE_PUTTY] = {
			Description = "사용 시 {{ffImmoralHeart}}이모럴하트 +1#{{ffImmoralHeart}}이모럴하트 소지 상태에서 피격 시 모든 {{ffImmoralHeart}}가 Fiend의 부하로 바뀌며 방 클리어 시 바뀐 부하는 다시 {{ffImmoralHeart}} 픽업으로 돌아옵니다.",
			Name = "보라색 퍼티",
			QuoteDesc = "충전식 인체개조",
		},
		[FiendFolio.ITEM.COLLECTIBLE.FETAL_FIEND] = {
			Description = "↑ {{DamageSmall}}공격력 배율 x1.5#모든 소울/블랙하트를 {{ffImmoralHeart}}이모럴하트로 바꿉니다.#모든 빨간하트를 제거하며 50%만큼 {{ffImmoralHeart}}이모럴하트를 획득합니다.#{{ffImmoralHeart}}이모럴하트 소지 상태에서 피격 시 모든 {{ffImmoralHeart}}가 Fiend의 부하로 바뀌며 방 클리어 시 바뀐 부하는 다시 {{ffImmoralHeart}} 픽업으로 돌아옵니다.",
			Name = "핀드의 꽃잎",
			QuoteDesc = "아낌없이 주는 몸",
		},
		[FiendFolio.ITEM.COLLECTIBLE.FIEND_MIX] = {
			Description = "사용 시 현재 체력의 절반을 Fiend의 부하로 바꿉니다.",
			Name = "핀드 믹스",
			QuoteDesc = "핀드의 부하 제조기",
		},
		[FiendFolio.ITEM.COLLECTIBLE.SECRET_STASH] = {
			Description = "획득 시 {{Coin}}동전, {{Key}}열쇠, {{Bomb}}폭탄, {{Card}}카드/{{Pill}}알약/{{Rune}}룬을 하나씩 드랍합니다.#다음 게임에서 이전 게임에 소지했던 {{Coin}}동전, {{Key}}열쇠, {{Bomb}}폭탄의 10%(반내림, 최대 5) 및 {{Card}}카드/{{Pill}}알약/{{Rune}}룬을 소환합니다.",
			Name = "숨겨진 보관함",
			QuoteDesc = "...그래요, 아직 사라지지 않았어요!",
		},
		[FiendFolio.ITEM.COLLECTIBLE.SANGUINE_HOOK] = {
			Description = "사용 시 공격하는 방향으로 적 및 픽업을 끌고 오는 후크를 던집니다.#{{ffBruise}} 후크에 묶인 적은 멍든 상태가 되어 추가 피해를 받습니다.#묶인 적이 있는 상태에서 재사용 시 해당 적을 놓으며 {{ffHemorrhage}}대출혈 상태로 만들어 눈물을 흩뿌리게 만듭니다.",
			Name = "핏빛 후크",
			QuoteDesc = "너의 것이 아니야",
		},
		[FiendFolio.ITEM.COLLECTIBLE.GORGON] = {
			Description = "방 중앙에 가만히 있으며 랜덤 적을 향해 주시합니다.#고르곤의 시야에 닿은 적을 석화시킵니다.",
			Name = "고르곤",
			QuoteDesc = "수줍은 석상",
		},
		[FiendFolio.ITEM.COLLECTIBLE.FIDDLE_CUBE] = {
			Description = "리듬에 맞춰 반복적으로 사용 시#↑ {{DamageSmall}}공격력 배율 x1.5#↑ {{TearsSmall}}연사 +1#잠시 동안 사용하지 않을 시 증가한 {{DamageSmall}}공격력 및 {{TearsSmall}}연사가 서서히 감소합니다.",
			Name = "바이올린 큐브",
			QuoteDesc = "놀고 있는 악마의 장난감",
		},
		[FiendFolio.ITEM.COLLECTIBLE.AVGM] = {
			Description = "여러 번 사용 시 동전을 하나 드랍합니다.#동전을 드랍할 때마다 다음 동전 드랍에 필요한 사용 횟수가 증가합니다.",
			Name = "딸깍이",
			QuoteDesc = "중독성",
		},
		[FiendFolio.ITEM.COLLECTIBLE.DEIMOS] = {
			Description = "공격하는 방향으로 적 및 픽업을 끌고 오는 후크를 던집니다.#{{ffBruise}} 후크에 묶인 적은 멍든 상태가 되어 추가 피해를 받습니다.#묶인 적이 있는 상태에서 공격키를 떼면 해당 적을 놓으며 {{ffHemorrhage}}대출혈 상태로 만들어 눈물을 흩뿌리게 만듭니다.",
			Name = "데이모스",
			QuoteDesc = "인생 파트너",
		},
		[FiendFolio.ITEM.COLLECTIBLE.PET_ROCK] = {
			Description = "가만히 있으며 탄환을 막아줍니다.#캐릭터가 밀쳐낼 수 있으며 구덩이에 떨어트리면 해당 구덩이를 메울 수 있습니다(방 당 1회)",
			Name = "돌멩이 펫",
			QuoteDesc = "움직일 수 있는 커버",
		},
		[FiendFolio.ITEM.COLLECTIBLE.CONTRABAND] = {
			Description = "!!! 소지하지 않은 상태에서는 특정 몬스터가 해당 아이템을 훔칠 수 있습니다!#해당 카드를 검은 모자의 거지에게 배달 시 특수 배열의 아이템을 소환합니다.",
			Name = "밀매품",
			QuoteDesc = "검은 모자가 배달료를 줄거야",
		},
		[FiendFolio.ITEM.COLLECTIBLE.ETERNAL_D12] = {
			Description = "!!! 사용할 때마다 형태를 바꿉니다:#사용 시 방 안의 모든 장애물을 바꿉니다.#현재 형태의 충전량이 높을수록 장애물이 사라질 확률이 감소합니다.",
			Name = "이터널 D12",
			QuoteDesc = "???",
		},
		[FiendFolio.ITEM.COLLECTIBLE.ETERNAL_D12_ALT] = {
			Description = "!!! 사용할 때마다 형태를 바꿉니다:#사용 시 방 안의 모든 장애물을 바꿉니다.#현재 형태의 충전량이 높을수록 장애물이 사라질 확률이 감소합니다.",
			Name = "이터널 D12",
			QuoteDesc = "???",
		},
		[FiendFolio.ITEM.COLLECTIBLE.GLIZZY] = {
			Description = "↑ {{HalfHeart}}절반 채워진 최대 체력 +1#↑ {{SpeedSmall}}이동속도 +0.1#↑ {{TearsSmall}}연사 +0.1#↑ {{DamageSmall}}공격력 +0.1#↑ {{RangeSmall}}사거리 +0.1#↑ {{ShotspeedSmall}}탄속 +0.1#↑ {{LuckSmall}}행운 +0.1",
			Name = "글리지 소시지",
			QuoteDesc = "허기는 채워야지",
		},
		[FiendFolio.ITEM.COLLECTIBLE.FIEND_HEART] = {
			Description = "↑ {{ffImmoralHeart}}이모럴하트 +3#{{ffImmoralHeart}}이모럴하트 소지 상태에서 피격 시 모든 {{ffImmoralHeart}}가 Fiend의 부하로 바뀌며 방 클리어 시 바뀐 부하는 다시 {{ffImmoralHeart}} 픽업으로 돌아옵니다.",
			Name = "핀드의 심장",
			QuoteDesc = "체력 증가?",
		},
		[FiendFolio.ITEM.COLLECTIBLE.DEVILLED_EGG] = {
			Description = "↑ {{ffImmoralHeart}}이모럴하트 +2#↑ {{TearsSmall}}연사 +0.3#{{ffImmoralHeart}}이모럴하트 소지 상태에서 피격 시 모든 {{ffImmoralHeart}}가 Fiend의 부하로 바뀌며 방 클리어 시 바뀐 부하는 다시 {{ffImmoralHeart}} 픽업으로 돌아옵니다.",
			Name = "악마화된 알",
			QuoteDesc = "연사, 부도덕함 증가",
		},
		[FiendFolio.ITEM.COLLECTIBLE.TEA] = {
			Description = "↑ {{Heart}}최대 체력 +1#↑ {{Heart}}빨간하트 +1",
			Name = "녹차",
			QuoteDesc = "체력 증가",
		},
		[FiendFolio.ITEM.COLLECTIBLE.OPHIUCHUS] = {
			Description = "방 안을 돌아다니며 적을 향해 이동합니다.#{{Poison}} 적과 접촉 시 캐릭터의 공격력 x0.2의 피해를 주며 1초간 공격력 x4({{BossRoom}}:x2)의 피해를 줍니다.#중독되지 않은 적을 우선적으로 추적합니다.",
			Name = "뱀주인자리",
			QuoteDesc = "뱀의 주인이 되다",
		},
		[FiendFolio.ITEM.COLLECTIBLE.FRAUDULENT_FUNGUS] = {
			Description = "↑ {{RottenHeart}}썩은 최대 체력 +1#↑ {{SpeedSmall}}이동속도 +0.2#↑ {{DamageSmall}}공격력 +0.3#↑ {{RangeSmall}}사거리 +2.5",
			Name = "썩은 버섯",
			QuoteDesc = "일부 능력치 증가",
		},
		[FiendFolio.ITEM.COLLECTIBLE.SMALL_PIPE] = {
			Description = "↑ {{DamageSmall}}공격력 +0.2#↑ {{TearsSmall}}연사 +0.2#↑ {{ShotspeedSmall}}탄속 +0.2#↑ {{SpeedSmall}}이동속도 +0.2",
			Name = "작은 파이프",
			QuoteDesc = "파이프 깨뜨린걸 축하해!",
		},
		[FiendFolio.ITEM.COLLECTIBLE.SMALL_WOOD] = {
			Description = "↑ {{TearsSmall}}연사 +1#↑ {{DamageSmall}}공격력 +0.2#↓ {{ShotspeedSmall}}탄속 -0.2",
			Name = "작은 나무판",
			QuoteDesc = "연사 증가",
		},
		[FiendFolio.ITEM.COLLECTIBLE.WHITE_PEPPER] = {
			Description = "사용 시 5방향으로 캐릭터의 공격력 x1의 푸른 지속 불꽃을 날립니다.",
			Name = "하얀 페퍼",
			QuoteDesc = "퍼지는 유령 불꽃",
		},
		[FiendFolio.ITEM.COLLECTIBLE.PEPPERMINT] = {
			Description = "{{Freezing}}공격 시 확률적으로 처치 시 적을 얼리는 불꽃을 날립니다.",
			Name = "페퍼민트",
			QuoteDesc = "뜨거워! ...가 아니잖아",
		},
		[FiendFolio.ITEM.COLLECTIBLE.PAGE_OF_VIRTUES] = {
			Description = "획득 시 랜덤 불꽃을 소환합니다.#이 불꽃이 꺼지면 새로운 랜덤 불꽃을 소환합니다.",
			Name = "미덕의 페이지",
			QuoteDesc = "진실은 너의 운명 속에",
		},
		[FiendFolio.ITEM.COLLECTIBLE.BRIDGE_BOMBS] = {
			Description = "↑ {{Bomb}}폭탄 +5#폭탄이 터질 때 주변의 구덩이를 메웁니다.",
			Name = "징검다리 폭탄",
			QuoteDesc = "구덩이를 채우는 폭발 + 폭탄 5개",
		},
		[FiendFolio.ITEM.COLLECTIBLE.LAWN_DARTS] = {
			Description = "확률적으로({{LuckSmall}}) 적에게 {{ffHemorrhage}}대출혈을 거는 공격이 나갑니다.",
			Name = "잔디 다트",
			QuoteDesc = "대출혈 다트",
			StatusEffects = {ffStatusEffectDesc.HEMORRHAGE},
		},
		[FiendFolio.ITEM.COLLECTIBLE.TOY_PIANO] = {
			Description = "확률적으로({{LuckSmall}}) {{ffDoom}}적에게 심판을 거는 공격이 나갑니다.",
			Name = "장난감 피아노",
			QuoteDesc = "악마의 노래",
			StatusEffects = {ffStatusEffectDesc.DOOM},
		},
		[FiendFolio.ITEM.COLLECTIBLE.HYPNO_RING] = {
			Description = "확률적으로({{LuckSmall}}) 적에게 {{ffSleeping}}나른한 상태로 만드는 공격이 나갑니다.",
			Name = "최면 링",
			QuoteDesc = "나른한 공격",
			StatusEffects = {ffStatusEffectDesc.DROWSY_AND_SLEEP},
		},
		[FiendFolio.ITEM.COLLECTIBLE.MUSCA] = {
			Description = "↑ {{Bomb}}폭탄 +3#폭탄이 터질 때 랜덤 자폭 파리 3마리가 나옵니다.#적 처치 시 확률적으로({{LuckSmall}}) 랜덤 자폭 파리가 나옵니다.",
			Name = "파리자리",
			QuoteDesc = "파리가 담긴 폭발 + 폭탄 3개",
		},
		[FiendFolio.ITEM.COLLECTIBLE.MODEL_ROCKET] = {
			Description = "↑ {{ShotspeedSmall}}탄속 배율 x2#↑ {{RangeSmall}}사거리 +1.5#눈물이 멈춘 상태에서 발사되며 탄속이 서서히 증가합니다.#눈물의 탄속에 비례하여 적에게 추가 피해를 줍니다.",
			Name = "로켓 모형",
			QuoteDesc = "추진 공격",
		},
		[FiendFolio.ITEM.COLLECTIBLE.SIBLING_SYL] = {
			Description = "공격하는 방향으로 공격력 4.75의 눈물을 발사합니다.",
			Name = "실",
			QuoteDesc = "영원한 친구",
		},
		[FiendFolio.ITEM.COLLECTIBLE.WRONG_WARP] = {
			Description = "!!! 사용 시 랜덤 스테이지로 순간이동합니다.",
			Name = "엉뚱한 워프",
			QuoteDesc = "시퀀스 브레이크",
		},
		[FiendFolio.ITEM.COLLECTIBLE.THE_BROWN_HORN] = {
			Description = "사용 시 방 안의 적 및 dip 패밀리어가 설사하게 만듭니다.#설사하는 동안 설사포를 발사해 캐릭터의 반대방향으로 밀어내고 아군 dip 패밀리어를 소환합니다.",
			Name = "똥을 부르는 나팔",
			QuoteDesc = "하나의 우주",
		},
		[FiendFolio.ITEM.COLLECTIBLE.NYX] = {
			Description = "공격 시 적을 향해 날아가는 유도 보석을 3개 획득합니다.#유도 보석이 적과 접촉 시 적에게 피해를 주며 {{ffBruise}}멍들게 합니다.#{{ffBruise}} 멍든 적은 해당 상태 중첩 수만큼 추가 피해를 받습니다.#일부 아이템과의 추가 시너지 존재",
			Name = "닉스",
			QuoteDesc = "투척",
		},
		[FiendFolio.ITEM.COLLECTIBLE.SNOW_GLOBE] = {
			Description = "사용 시 모든 오브젝트의 위치를 가까운 위치로 날립니다.",
			Name = "스노 글로브",
			QuoteDesc = "돌덩이 흔들기",
		},
		[FiendFolio.ITEM.COLLECTIBLE.ETERNAL_CLICKER] = {
			Description = "사용 시 가장 최근에 획득한 패시브 아이템을 제거하고 캐릭터를 랜덤하게 바꾸며;#!!! {{ColorRed}}50%의 확률로 캐릭터가 사라집니다.",
			Name = "이터널 클리커",
			QuoteDesc = "???",
		},
		[FiendFolio.ITEM.COLLECTIBLE.DICE_GOBLIN] = {
			Description = "획득 시 랜덤 오브젝트 픽업을 3개 드랍합니다.#스테이지 진입 시 랜덤 오브젝트 픽업을 하나 드랍합니다.",
			Name = "주사위 고블린",
			QuoteDesc = "오브젝트 수집가",
		},
		[FiendFolio.ITEM.COLLECTIBLE.CHERRY_BOMB] = {
			Description = "사용 시 잠시 후 폭발하는 작은 폭탄을 듭니다.#작은 폭탄은 장애물을 부술 수 없고 폭발 크기가 작으나 캐릭터에게 피해를 주지 않습니다.",
			Name = "체리 폭탄",
			QuoteDesc = "작은 폭발",
		},
		[FiendFolio.ITEM.COLLECTIBLE.ASTROPULVIS] = {
			Description = "사용 시 가장 가까운 장애물을 파괴하여 거대한 붉은 귀신으로 만듭니다.#붉은 귀신이 있는 상태에서 재사용 시 붉은 귀신이 폭파되며 주변의 적에게 피해를 줍니다.",
			Name = "아스트로풀비스",
			QuoteDesc = "초신성",
		},
		[FiendFolio.ITEM.COLLECTIBLE.SPINDLE] = {
			Description = "획득 시 디스크를 3장 드랍합니다.#디스크류 픽업은 사용 시 랜덤 아이템의 효과를 1분간 부여합니다.#{{BossRoom}}보스방 진입 시 디스크류 아이템 하나를 드랍합니다.",
			Name = "스핀들",
			QuoteDesc = "더 많은 디스크!",
		},
		[FiendFolio.ITEM.COLLECTIBLE.AZURITE_SPINDOWN] = {
			Description = "사용 시 방 안의 모든 장신구를 코드 앞번호의 장신구로 바꿉니다.",
			Name = "아주라이트 스핀다운",
			QuoteDesc = "-1",
		},
		[FiendFolio.ITEM.COLLECTIBLE.KING_WORM] = {
			Description = "사용 시 그 방에서 랜덤 벌레 장신구 효과를 얻습니다.",
			Name = "벌레 왕",
			QuoteDesc = "일시적 벌레의 힘",
		},
		[FiendFolio.ITEM.COLLECTIBLE.HEART_OF_CHINA] = {
			Description = "체력이 없거나 꽉 찬 상태에서 빨간하트 습득 시 특수 체력 게이지가 채워집니다.#특수 체력 게이지 완충 시 {{EmptyHeart}}빈 최대 체력 +1 증가#특수 체력 게이지의 총량은 현재 소지 중인 최대 체력에 비례하며;#{{ButtonRT}}버튼을 꾹 누르거나 빨간하트 근처에 있을 때 캐릭터 위에 표시됩니다.",
			Name = "차이나의 심장",
			QuoteDesc = "취급주의",
		},
		[FiendFolio.ITEM.COLLECTIBLE.HORSE_PASTE] = {
			Description = "!!! China 전용#사용 시 {{BrokenHeart}}부서진하트 -1",
			Name = "말 접착제",
			QuoteDesc = "계속 갖고 있어",
		},
		[FiendFolio.ITEM.COLLECTIBLE.DADS_DIP] = {
			Description = "↑ {{ffMorbidHeart}}병든 최대 체력 +1",
			Name = "아빠의 디핑소스",
			QuoteDesc = "체력 증가..?",
		},
		[FiendFolio.ITEM.COLLECTIBLE.YICK_HEART] = {
			Description = "사용 시 {{ffMorbidHeart}}병든하트 +1",
			Name = "조용한 하트",
			QuoteDesc = "충전식 악의",
		},

		[FiendFolio.ITEM.COLLECTIBLE.LIL_LAMB] = {
			Description = "{{Chargeable}} 공격키를 1초 이상 누르면 충전되며 공격키를 떼면 {{Collectible149}}공격력 25의 폭발성 구토제를 발사합니다.#캐릭터가 이 폭발로 피해를 받을 시 몸통과 머리가 분리되며 분리된 몸통 근처의 적을 향해 자동으로 공격합니다.",
			Name = "리틀 램",
			QuoteDesc = "좋아하는 척 하는 친구",
		},
		[FiendFolio.ITEM.COLLECTIBLE.GRAPPLING_HOOK] = {
			Description = "사용 시 공격방향으로 후크를 던지며 공격키를 떼면 후크의 위치로 이동합니다.#구덩이와 장애물을 넘어갈 수 있으며 후크에서 떼도 장애물 위에 착지할 수 있습니다.#!!! 후크 해제 시 구덩이에 떨어지면 체력 반칸의 피해를 받습니다.",
			Name = "그래플링 후크",
			QuoteDesc = "위기탈출",
		},
		[FiendFolio.ITEM.COLLECTIBLE.CETUS] = {
			Description = "피격 시 2초간 푸른 장판을 까는 눈물을 흩뿌립니다.",
			Name = "고래자리",
			QuoteDesc = "고래의 보복",
		},
		[FiendFolio.ITEM.COLLECTIBLE.MALICE] = {
			Description = "사용 시 캐릭터의 공격방향으로 벽에 부딪힐 때까지 돌진합니다.#돌진 상태에서 적 처치 시 낮은 확률로 {{BlackHeart}}블랙하트를 드랍합니다.",
			Name = "악의",
			QuoteDesc = "집중성 악의",
		},
		[FiendFolio.ITEM.COLLECTIBLE.MALICE_REFORM] = {
			Description = "!!! Tainted Fiend 전용:#!!! {{ColorOrange}}현재 분리된 상태;#체력과 상관없이 적에게 맞을 시 사라지며 모든 부하 사망 시 본체도 즉사합니다.{{CR}}#사용 시 본체 상태로 돌아옵니다.",
			Name = "악의",
			QuoteDesc = "집중성 악의",
		},
		[FiendFolio.ITEM.COLLECTIBLE.BLACK_MOON] = {
			Description = "적 처치 시 주변의 적에게 피해를 주는 십자가를 소환합니다.#십자가로 처치된 적은 또 다른 십자가를 소환하지 않습니다.",
			Name = "검은 달",
			QuoteDesc = "모든것은 무로 돌아간다",
		},

		[FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_1] = {
			Description = "획득 시 랜덤 오브젝트를 하나 드랍합니다.#사용 시 소지중인 오브젝트의 효과를 발동합니다.#오브젝트에 따라서 충전량이 달라집니다.",
			Name = "기초 오브젝트",
			QuoteDesc = "유사 오브젝트",
		},
		[FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_2] = {
			Description = "획득 시 랜덤 오브젝트를 하나 드랍합니다.#사용 시 소지중인 오브젝트의 효과를 발동합니다.#오브젝트에 따라서 충전량이 달라집니다.",
			Name = "기초 오브젝트",
			QuoteDesc = "유사 오브젝트",
		},
		[FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_3] = {
			Description = "획득 시 랜덤 오브젝트를 하나 드랍합니다.#사용 시 소지중인 오브젝트의 효과를 발동합니다.#오브젝트에 따라서 충전량이 달라집니다.",
			Name = "기초 오브젝트",
			QuoteDesc = "유사 오브젝트",
		},
		[FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_4] = {
			Description = "획득 시 랜덤 오브젝트를 하나 드랍합니다.#사용 시 소지중인 오브젝트의 효과를 발동합니다.#오브젝트에 따라서 충전량이 달라집니다.",
			Name = "기초 오브젝트",
			QuoteDesc = "유사 오브젝트",
		},
		[FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_5] = {
			Description = "획득 시 랜덤 오브젝트를 하나 드랍합니다.#사용 시 소지중인 오브젝트의 효과를 발동합니다.#오브젝트에 따라서 충전량이 달라집니다.",
			Name = "기초 오브젝트",
			QuoteDesc = "유사 오브젝트",
		},
		[FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_6] = {
			Description = "획득 시 랜덤 오브젝트를 하나 드랍합니다.#사용 시 소지중인 오브젝트의 효과를 발동합니다.#오브젝트에 따라서 충전량이 달라집니다.",
			Name = "기초 오브젝트",
			QuoteDesc = "유사 오브젝트",
		},
		[FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_8] = {
			Description = "획득 시 랜덤 오브젝트를 하나 드랍합니다.#사용 시 소지중인 오브젝트의 효과를 발동합니다.#오브젝트에 따라서 충전량이 달라집니다.",
			Name = "기초 오브젝트",
			QuoteDesc = "유사 오브젝트",
		},
		[FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_12] = {
			Description = "획득 시 랜덤 오브젝트를 하나 드랍합니다.#사용 시 소지중인 오브젝트의 효과를 발동합니다.#오브젝트에 따라서 충전량이 달라집니다.",
			Name = "기초 오브젝트",
			QuoteDesc = "유사 오브젝트",
		},

				-- 뱃지 : The Gauntlet 챌린지에서만 존재
		[FiendFolio.ITEM.COLLECTIBLE.SPATULA_BADGE] = {
			Description = "↑ {{DamageSmall}}공격력 +0.1",
			Name = "주걱 배지",
			QuoteDesc = "철판에다 던져버려!",
		}, -- Griddle Horn의 보스 방에서 White Pepper 사용
		[FiendFolio.ITEM.COLLECTIBLE.COMMISSIONED_BADGE] = {
			Description = "↑ {{DamageSmall}}공격력 +0.1",
			Name = "분해된 배지",
			QuoteDesc = "이거 50달러나 한다구!",
		}, -- Buster 보스 사망 모션 도중 Defuse 카드 사용
		[FiendFolio.ITEM.COLLECTIBLE.MYSTERY_BADGE] = {
			Description = "↑ {{DamageSmall}}공격력 +0.1",
			Name = "미스테리 배지",
			QuoteDesc = "뭐가 들었을까?",
		}, -- Buck 보스를 Bag of Crafting으로 막타 처치
		[FiendFolio.ITEM.COLLECTIBLE.BABY_BADGE] = {
			Description = "↑ {{DamageSmall}}공격력 +0.1",
			Name = "아기 배지",
			QuoteDesc = "잘 갖고 있어!",
		}, -- Battie 보스 방에서 Fiend Folio 사용
		[FiendFolio.ITEM.COLLECTIBLE.DRIPPING_BADGE] = {
			Description = "↑ {{DamageSmall}}공격력 +0.1",
			Name = "드립 배지",
			QuoteDesc = "하긴, 여긴 많이 습하지",
		}, -- Monsoon 보스가 분할된 상태에서 Flush 사용
		[FiendFolio.ITEM.COLLECTIBLE.HAUNTED_BADGE] = {
			Description = "↑ {{DamageSmall}}공격력 +0.1",
			Name = "유령 배지",
			QuoteDesc = "강력한 탄알을 얻었다!",
		}, -- Organization 보스를 Power Pill 알약을 먹은 상태로 접촉
		[FiendFolio.ITEM.COLLECTIBLE.PLANET_BADGE] = {
			Description = "↑ {{DamageSmall}}공격력 +0.1",
			Name = "행성 배지",
			QuoteDesc = "스페이스 캠프에 온 걸 환영해!",
		}, -- The Sun 보스를 Chaos Card로 처치
		[FiendFolio.ITEM.COLLECTIBLE.YOUR_ETERNAL_REWARD] = {
			Description = "↑ {{DamageSmall}}공격력 +0.1",
			Name = "배지 완성 보상",
			QuoteDesc = "배지를 모두 모았다!",
		},

		[FiendFolio.ITEM.COLLECTIBLE.MARIAS_IPAD] = {
			Description = "사용 시 캐릭터를 제외한 모든 것을 방의 아래쪽으로 밀어넣습니다.",
			Name = "마리아의 iPad",
			QuoteDesc = "제발...",
		},

		[FiendFolio.ITEM.COLLECTIBLE.GREG_THE_EGG] = {
			Description = "방 안을 돌아다니며 적의 탄환을 막아줍니다.#방 클리어 시 확률적으로 픽업을 소환합니다.#!!! 적의 탄환을 막으면 일정 확률로 달걀이 깨져 사라지며 랜덤 아이템을 드랍합니다.",
			Name = "달걀 그레그",
			QuoteDesc = "서프라이즈로 가득찬 알",
		},
		[FiendFolio.ITEM.COLLECTIBLE.FAMILIAR_FLY] = {
			Description = "캐릭터의 주변을 돌며 적과 접촉 시 2의 피해를 줍니다.#{{Charm}} 주변의 파리류 적에 매혹을 겁니다.#적과 오랫동안 접촉 시 폭발하며 8방향으로 눈물을 발사하며 적에게 매혹을 겁니다.",
			Name = "뭔가 익숙한 그 파리",
			QuoteDesc = "많은 이들에게 사랑받았지",
		},
		[FiendFolio.ITEM.COLLECTIBLE.MONAS_HIEROGLYPHICA] = {
			Description = "스테이지마다 랜덤한 천체관 아이템의 효과를 가집니다.",
			Name = "모나스 상형 문자",
			QuoteDesc = "하나가 된 우주",
		},
		[FiendFolio.ITEM.COLLECTIBLE.CYANIDE_DEADLY_DOSE] = {
			Description = "{{Pill}} 획득 시 Cyanide 알약을 드랍합니다.#{{Pill}} 해당 게임에서 Cyanide 알약이 등장할 수 있습니다.#!!! Cyanide 알약은 발동되는 동안 모든 능력치가 증가하나 사용 후 다른 알약을 사용하지 않으면 1분 후 사망합니다.",
			Name = "과다투약",
			QuoteDesc = "치사성 초강력 알약",
		},
		[FiendFolio.ITEM.COLLECTIBLE.DADS_POSTICHE] = {
			Description = "공격 시 확률적으로 아군 자폭 벼룩을 소환합니다.#{{ffMorbidHeart}}병든하트 소지 시 소환 확률 증가",
			Name = "아빠의 가발",
			QuoteDesc = "머리가 가려워...",
		},
		[FiendFolio.ITEM.COLLECTIBLE.EXCELSIOR] = {
			Description = "액티브 아이템 사용 시 유도성 로켓을 여러 발 발사합니다.#유도성 로켓의 발사 수량과 공격력은 사용한 액티브 아이템의 최대 충전량에 비례합니다.",
			Name = "더 높이!",
			QuoteDesc = "폭발성 액티브 아이템",
		},
		[FiendFolio.ITEM.COLLECTIBLE.GRIDDLED_CORN] = {
			Description = "↑ {{BlackHeart}}블랙하트 +1#↑ {{DamageSmall}}공격력 +1#{{FFSpicyKeyTint}}{{Key}}매운열쇠를 드랍합니다.",
			Name = "옥수수 철판구이",
			QuoteDesc = "공격력 증가 + 구워진 옥수수",
		},
		[FiendFolio.ITEM.COLLECTIBLE.ETERNAL_D10] = {
			Description = "사용 시 방 안의 모든 적을 바꾸며 낮은 확률로 적이 사라집니다.",
			Name = "이터널 D10",
			QuoteDesc = "???",
		},
		[FiendFolio.ITEM.COLLECTIBLE.TOY_CAMERA] = {
			Description = "사용 후 공격하는 방향으로 사진을 촬영합니다.#캐릭터 촬영 시 {{TearsSmall}}빠르게 감소하는 연사가 대폭 증가합니다.#촬영 범위에 있는 적에게 혼란을 걸며 탄환을 없앱니다.#한번에 적을 4마리 이상 촬영 시 {{Card"..FiendFolio.ITEM.CARD.COOL_PHOTO.."}}Cool Photo를 드랍합니다.(방당 1회)",
			Name = "장난감 카메라",
			QuoteDesc = "사진작가 전문",
		},
		[FiendFolio.ITEM.COLLECTIBLE.HAPPYHEAD_AXE] = {
			Description = "주기적으로 가장 가까운 적을 향해 사거리가 짧은 도끼를 던집니다.#도끼는 던진 방향의 반대방향으로 되돌아갑니다.",
			Name = "칼데아 도끼",
			QuoteDesc = "쓸어버려!",
		}, -- Chaldean axe
		[FiendFolio.ITEM.COLLECTIBLE.PENNY_ROLL] = {
			Description = "{{Coin}} 획득 시 페니류 장신구, 황금동전, 랜덤 동전 4개를 드랍합니다.",
			Name = "페니 롤",
			QuoteDesc = "용돈",
		},
		[FiendFolio.ITEM.COLLECTIBLE.EVIL_STICKER] = {
			Description = "{{ffImmoralHeart}}이모럴하트, {{FFCursedPennyTint}}{{Coin}}저주받은 동전, 장난꾸러기 상자, {{FFSpicyKeyTint}}{{Key}}매운열쇠, {{FFCopperBombTint}}{{Bomb}}구리폭탄, 저주받은 배터리의 등장 확률이 증가합니다.",
			Name = "악마 스티커",
			QuoteDesc = "위험한 픽업",
		},
		[FiendFolio.ITEM.COLLECTIBLE.WIMPY_BRO] = {
			Description = "적을 향해 짧은 거리를 도약하며 착지한 위치의 적에게 5의 피해를 줍니다.",
			Name = "겁쟁이 동생",
			QuoteDesc = "하핫 위이이이!",
		},
		[FiendFolio.ITEM.COLLECTIBLE.ROBOBABY3] = {
			Description = "캐릭터 이동방향의 사선으로 움직이며 적과 접촉 시 8방향으로 공격력 3.5의 레이저를 발사합니다.",
			Name = "로보 아기 3.0",
			QuoteDesc = "이젠 하나의 예술작품",
		},
		[FiendFolio.ITEM.COLLECTIBLE.TELEBOMBS] = {
			Description = "↑ {{Bomb}}폭탄 +5#타겟이 캐릭터가 지나간 길을 0.66초 후 따라갑니다.#타겟 위치 밖에서 폭탄 설치 시 캐릭터를 타겟의 위치로 순간이동하며 설치한 폭탄은 즉시 폭발합니다.#!!! 캐릭터가 설치한 폭탄에 면역을 갖지 않습니다.",
			Name = "텔레폭탄",
			QuoteDesc = "폭탄이랑 자리 맞바꾸기 + 폭탄 5개",
		},
		[FiendFolio.ITEM.COLLECTIBLE.DEVILS_DAGGER] = {
			Description = "공격방향으로 단검을 추가로 발사합니다.#적 처치 시 단검을 강화시킬 수 있는 보석을 드랍합니다.#단검의 강화 단계는 스테이지 진입 시 초기화됩니다.",
			Name = "악마의 단검",
			QuoteDesc = "서두름이 곧 힘",
		},
		[FiendFolio.ITEM.COLLECTIBLE.STRANGE_RED_OBJECT] = {
			Description = "↑ {{Heart}}최대 체력 +1#↑ {{DamageSmall}}공격력 +0.3#↑ {{SpeedSmall}}이동속도 +0.05#↑ {{LuckSmall}}행운 +2",
			Name = "수상한 빨간 물체",
			QuoteDesc = "자연스럽게 빛나고 있어",
		},
		[FiendFolio.ITEM.COLLECTIBLE.D3] = {
			Description = "캐릭터 주위를 돌며 통과한 눈물을 다른 눈물로 바꿉니다.",
			Name = "3면 주사위",
			QuoteDesc = "눈물을 바꾸다",
		},
		[FiendFolio.ITEM.COLLECTIBLE.EMOJI_GLASSES] = {
			Description = "3개의 이모지 모양의 눈물을 번갈아 발사합니다.#이모지에 따라 다른 눈물 효과가 적용됩니다.",
			Name = "이모지 안경",
			QuoteDesc = "이거, 켜져 있어",
		},
		[FiendFolio.ITEM.COLLECTIBLE.SACK_OF_SPICY] = {
			Description = "방 7개 클리어 시 {{FFSpicyKeyTint}}{{Key}}매운열쇠를 드랍합니다.",
			Name = "매운 자루",
			QuoteDesc = "주머니가 뜨거워",
		},
		[FiendFolio.ITEM.COLLECTIBLE.DEVILS_ABACUS] = {
			Description = "1개부터 시작하며 숫자의 개수만큼 눈물을 발사한 수만큼 발사 후 공격키를 떼면 {{DamageSmall}}공격력과 {{TearsSmall}}연사가 증가합니다.#단계가 증가할 때마다 발사해야 되는 눈물의 수가 하나씩 증가합니다.#공격키를 뗄 때 눈물의 개수가 맞지 않으면 증가량이 초기화됩니다.",
			Name = "악마의 주판",
			QuoteDesc = "숫자 세는 법을 배우자",
		},
		[FiendFolio.ITEM.COLLECTIBLE.DAZZLING_SLOT] = {
			Description = "{{Coin}}동전 5개를 소모하여 랜덤 적 하나를 황금 슬롯머신으로 바꿉니다.#바뀐 슬롯머신은 확률적으로 보상을 드랍하고 사라집니다.",
			Name = "빛나는 슬롯머신",
			QuoteDesc = "탐욕에 솔직해지자",
		},
		[FiendFolio.ITEM.COLLECTIBLE.INFINITY_VOLT] = {
			Description = "공격키를 두번 눌러 적에게 콘센트를 꼽습니다.#콘센트에 꽃힌 적은 매혹 상태에 걸리며 레이저를 발산하며 오랫동안 꽂고 있으면 적이 폭발합니다.",
			Name = "무한 볼트",
			QuoteDesc = "더블탭 콘센트",
		},
		[FiendFolio.ITEM.COLLECTIBLE.KALUS_HEAD] = {
			Description = "사용 시 머리를 들며 공격하는 방향으로 보라빛 손전등을 비춥니다.#보라빛에 닿은 적은 1.1의 피해를 받으며 잠시동안 멈춥니다.#멈춘 적 처치 시 여러 갈래의 눈물을 발사합니다.",
			Name = "칼루의 머리",
			QuoteDesc = "무서운 가면",
		},
		[FiendFolio.ITEM.COLLECTIBLE.HORNCOB] = {
			Description = "{{Pill}} 적 처치 시 일정 확률로 랜덤 알약을 강제로 사용합니다.",
			Name = "뿔 달린 옥수수",
			QuoteDesc = "뿌린 대로 거두는 법",
		},
		[FiendFolio.ITEM.COLLECTIBLE.X10KACHING] = {
			Description = "↑ {{Coin}}동전 +10",
			Name = "",
			QuoteDesc = "동전 10개",
		},
		[FiendFolio.ITEM.COLLECTIBLE.X10BATOOMKLING] = {
			Description = "↑ {{Key}}열쇠 +10",
			Name = "",
			QuoteDesc = "열쇠 10개",
		},
		[FiendFolio.ITEM.COLLECTIBLE.X10BADUMP] = {
			Description = "↑ {{Heart}}빨간하트 +10(최대 체력 없음)",
			Name = "",
			QuoteDesc = "하트 10개",
		},
		[FiendFolio.ITEM.COLLECTIBLE.X10BZZT] = {
			Description = "↑ {{Battery}}액티브 아이템 충전량 +10",
			Name = "",
			QuoteDesc = "배터리 10개",
		},
		[FiendFolio.ITEM.COLLECTIBLE.X10CHOMPCHOMP] = {
			Description = "↑ {{Heart}}최대 체력 +5#↑ {{EmptyHeart}}빈 최대 체력 +5#↑ {{SpeedSmall}}이동속도 +1#↑ {{TearsSmall}}연사 +1#↑ {{DamageSmall}}공격력 +1#↑ {{RangeSmall}}사거리 +1#↑ {{ShotspeedSmall}}탄속 +1#↑ {{LuckSmall}}행운 +1",
			Name = "",
			QuoteDesc = "그리즐 소시지 10개",
		},
		[FiendFolio.ITEM.COLLECTIBLE.RAT_POISON] = {
			Description = "특정 방 제작자가 명시되어 있는 방에서 사용 시 해당 게임에서 그 방 제작자가 제작한 모든 방에 있는 존재를 지웁니다.#방 제작자는 UI 하단에서 확인할 수 있습니다.",
			Name = "쥐약",
			QuoteDesc = "전부 건너뛰기",
		},
		[FiendFolio.ITEM.COLLECTIBLE.ANGELIC_LYRE_B] = {
			Description = "소지 시 리라의 색상에 따라 다른 효과의 눈물을 발사합니다.#사용 시 리라의 현재 색상을 바꿉니다.#{{ColorBlue}}파랑{{CR}}: #{{Blank}} {{SpeedSmall}}+0.2/{{TearsSmall}}+0.8/{{LuckSmall}}+3#{{Blank}} {{ShotspeedSmall}}-0.2#눈물을 1발 > 3발 > 0발을 번갈아가며 발사합니다.",
			Name = "천국의 리라",
			QuoteDesc = "색다른 음색 연주",
		},
		[FiendFolio.ITEM.COLLECTIBLE.ANGELIC_LYRE_R] = {
			Description = "소지 시 리라의 색상에 따라 다른 효과의 눈물을 발사합니다.#사용 시 리라의 현재 색상을 바꿉니다.#{{ColorRed}}빨강{{CR}}: #{{Blank}} {{DamageSmall}}x2#{{Blank}} {{TearsSmall}}x0.2#공격이 4발로 나가며 지형을 관통합니다.",
			Name = "천국의 리라",
			QuoteDesc = "색다른 음색 연주",
		},
		[FiendFolio.ITEM.COLLECTIBLE.ANGELIC_LYRE_Y] = {
			Description = "소지 시 리라의 색상에 따라 다른 효과의 눈물을 발사합니다.#사용 시 리라의 현재 색상을 바꿉니다.#{{ColorYellow}}노랑{{CR}}: #{{Blank}} {{TearsSmall}}x4.5/{{RangeSmall}}+3#{{Blank}} {{DamageSmall}}x0.2 #유도 눈물을 10발 연속 발사하며 이후 잠시동안 공격을 멈춥니다.#연사가 높을수록 공격을 멈추는 시간이 짧아집니다.",
			Name = "천국의 리라",
			QuoteDesc = "색다른 음색 연주",
		},
		[FiendFolio.ITEM.COLLECTIBLE.LEMON_MISHUH] = {
			Description = "{{Collectible56}} 사용 후 공격방향으로 레몬을 투척합니다.#투척한 자리에 노란 장판이 생성되며 장판에 닿은 적은 초당 24의 피해를 입습니다.",
			Name = "레몬빛 실수?",
			QuoteDesc = "사고 나기 전에 던지기",
		},
		[FiendFolio.ITEM.COLLECTIBLE.MIME_DEGREE] = {
			Description = "적 및 탄환이 지나갈 수 없는 흰색 블럭을 소환합니다.#캐릭터가 흰색 블럭 접촉 시 해당 블럭을 랜덤 위치에 재배치합니다.",
			Name = "익살스러운 학위",
			QuoteDesc = "...",
		},
		[FiendFolio.ITEM.COLLECTIBLE.CRAZY_JACKPOT] = {
			Description = "피격 시 확률적으로 아래 효과 중 하나를 발동합니다:#{{Coin}} 동전 1~2개#{{Heart}} 잠시 후 사라지는 하트#그 방에서 {{DamageSmall}}공격력/{{TearsSmall}}연사/{{LuckSmall}}행운 증가#주변의 적에게 캐릭터의 공격력 x5만큼 피해#{{Collectible56}} 노란 장판 생성",
			Name = "크레이지 잭팟",
			QuoteDesc = "화풀이 도박",
		},
		[FiendFolio.ITEM.COLLECTIBLE.NIL_PASTA] = {
			Description = "사용 시 랜덤 방향으로 짧은 스파게티 줄을 여러개 발사합니다.#스파게티 줄에 닿은 적은 일부 행동이 불가능해집니다.",
			Name = "nil 파스타",
			QuoteDesc = "스파게티 코드",
		},
		[FiendFolio.ITEM.COLLECTIBLE.CLUTCHS_CURSE] = {
			Description = "주기적으로 캐릭터에게 빙의합니다.#캐릭터에게 빙의했을 때 다음 공격이 {{Collectible149}}유도성 폭발 공격으로 바꿉니다.#방 입장 시 일부 돌덩이가 보라빛으로 빛나며 보랏빛 돌 파괴 시 십자 모양으로 불길을 내뿜습니다.#!!! 불길은 캐릭터에게도 피해를 줍니다.",
			Name = "클러치의 저주",
			QuoteDesc = "만약 보라빛이였다면?",
		},
		[FiendFolio.ITEM.COLLECTIBLE.PET_PEEVE] = {
			Description = "방을 느리게 돌아다니며 접촉한 적에게 피해를 줍니다.#공격키를 두번 누르면 즉시 공격방향으로 돌진합니다.",
			Name = "짜증나는 펫",
			QuoteDesc = "더블탭 가시돌이",
		},
		[FiendFolio.ITEM.COLLECTIBLE.MOMS_STOCKINGS] = {
			Description = "↑ {{RangeSmall}}사거리 +2.5#아군 자폭 벼룩을 0~6마리 소환합니다.",
			Name = "엄마의 스타킹",
			QuoteDesc = "사거리 증가",
		},
		[FiendFolio.ITEM.COLLECTIBLE.GOLDEN_POPSICLE] = {
			Description = "↑ {{SoulHeart}}소울하트 +1#↑ {{LuckSmall}}행운 +1#황금 픽업 아이템 하나를 드랍합니다.",
			Name = "황금 아이스크림",
			QuoteDesc = "행운 증가",
		},
		[FiendFolio.ITEM.COLLECTIBLE.TIME_ITSELF] = {
			Description = "확률적으로 적에게 {{ffmultieuclidean}}유클리드를 거는 공격이 나갑니다.",
			Name = "시간 그 자체",
			QuoteDesc = "다중 유클리드 눈물",
			StatusEffects = {ffStatusEffectDesc.MULTIEUCLIDEAN},
		},
		[FiendFolio.ITEM.COLLECTIBLE.EMPTY_BOOK] = {
			Description = "사용 시 이야기를 작성합니다.#작성한 이야기에 따라 쿨타임 및 효과가 달라집니다.",
			Name = "빈 공책",
			QuoteDesc = "나만의 이야기를 쓰자!",
		},
		[FiendFolio.ITEM.COLLECTIBLE.MY_STORY_2] = {
			Description = "",
			Name = "나의 이야기",
			QuoteDesc = "내가 쓴 이야기",
		},
		[FiendFolio.ITEM.COLLECTIBLE.MY_STORY_4] = {
			Description = "",
			Name = "나의 이야기",
			QuoteDesc = "내가 쓴 이야기",
		},
		[FiendFolio.ITEM.COLLECTIBLE.MY_STORY_6] = {
			Description = "",
			Name = "나의 이야기",
			QuoteDesc = "내가 쓴 이야기",
		},
		[FiendFolio.ITEM.COLLECTIBLE.HOST_ON_TOAST] = {
			Description = "↑ {{DamageSmall}}공격력 +0.5#↑ {{RangeSmall}}사거리 +1.5",
			Name = "호스트 발린 토스트",
			QuoteDesc = "공격력, 사거리 증가",
		},
		[FiendFolio.ITEM.COLLECTIBLE.BAG_OF_BOBBIES] = {
			Description = "방 클리어 시 일정 확률로 {{Collectible8}}Fragile Bobby를 소환합니다.#{{Collectible8}} Fragile bobby는 Brother Bobby와 동일하나 5회 피격 시 사라집니다.",
			Name = "보비 가방",
			QuoteDesc = "보비가 가득!",
		},
		[FiendFolio.ITEM.COLLECTIBLE.BOX_TOP] = {
			Description = "↑ {{LuckSmall}}행운 +2#{{Card"..FiendFolio.ITEM.CARD.PUZZLE_PIECE.."}}퍼즐 조각을 드랍합니다.",
			Name = "박스 탑",
			QuoteDesc = "행운 증가 + 적립성 상품",
		},
		[FiendFolio.ITEM.COLLECTIBLE.KINDA_EGG] = {
			Description = "↑ {{Heart}}최대 체력 +1#카드/알약/룬이 아닌 랜덤 오브젝트를 드랍합니다.",
			Name = "이래뵈도 알",
			QuoteDesc = "체력 증가 + 삼키면 안돼!",
		},
		[FiendFolio.ITEM.COLLECTIBLE.SMASH_TROPHY] = {
			Description = "↑ {{DamageSmall}}공격력 +1 #적의 체력이 적을수록 공격이 적을 더 크게 밀쳐냅니다.",
			Name = "스매시 트로피",
			QuoteDesc = "승자 마리아",
		},
		[FiendFolio.ITEM.COLLECTIBLE.BOTTLE_OF_WATER] = {
			Description = "↑ {{SoulHeart}}소울하트 +2#{{Pill}}알약 하나를 드랍합니다.#현재 소지 중인 장신구를 흡수합니다.",
			Name = "물 한 병",
			QuoteDesc = "삼켜!",
		},
		[FiendFolio.ITEM.COLLECTIBLE.GAMMA_GLOVES] = {
			Description = "사용 시 가까이에 있는 적을 밀쳐냅니다.",
			Name = "감마 장갑",
			QuoteDesc = "밀쳐!",
		},
		[FiendFolio.ITEM.COLLECTIBLE.SHREDDER] = {
			Description = "사용 시 그 방의 아이템을 여러 개의 픽업 아이템으로 분해합니다.",
			Name = "파쇄기",
			QuoteDesc = "아이템 재활용",
		},
		[FiendFolio.ITEM.COLLECTIBLE.FISTFUL_OF_ASH] = {
			Description = "↑ {{Bomb}}폭탄 +3#↓ 스테이지 진입 시 {{BrokenHeart}}소지 불가능 체력 +1#색돌의 등장 빈도 수가 증가합니다.#색돌 파괴 시 서서히 감소하는 공격력이 증가하며 50%의 확률로 {{BrokenHeart}}소지 불가능 체력 -1",
			Name = "잿더미 한 줌",
			QuoteDesc = "인간보다 못한 존재",
		},
		[FiendFolio.ITEM.COLLECTIBLE.GOLDEN_PLUM_FLUTE] = {
			Description = "사용 시 10초 동안 아군 Golden Baby Plum 보스를 소환합니다.",
			Name = "황금 플럼 피리",
			QuoteDesc = "플레이 타임!",
		},

		--------------------------------------
		---- FF 2.8: The Spitshine Update ----
		--------------------------------------

		[FiendFolio.ITEM.COLLECTIBLE.FIENDS_THIRD_LEG] = {
			Description = "↑ {{DamageSmall}}공격력 배율 x3.33#↑ {{TearsSmall}}연사 배율 x1.5#공격에 유도 효과가 생기며 적에게 피해를 주는 보라색 장판을 생성합니다.#공격이 무언가에 부딪힐 시 Fiend의 부하를 소환합니다.",
			Name = "핀드의 세번째 다리",
			QuoteDesc = "많다...",
		},

		[FiendFolio.ITEM.COLLECTIBLE.LOADED_D6] = {
			Description = "사용 시 그 방의 아이템을 캐릭터가 소지 중인 아이템으로 바꿉니다.#중첩 가능한 아이템이 우선적으로 등장합니다.",
			Name = "취한 주사위",
			QuoteDesc = "운명을 반복하는 능력",
		},

		[FiendFolio.ITEM.COLLECTIBLE.ISAAC_DOT_CHR] = {
			Description = "↑ 목숨 +1#사망 시 그 방에서 일부 아이템이 오류 아이템으로 바뀐 채 부활합니다.",
			Name = "",
			QuoteDesc = "캐릭터 백업 파일 생성 중...",
		},

		[FiendFolio.ITEM.COLLECTIBLE.WORM_INSIGNIA] = {
			Description = "↑ {{SpeedSmall}}이동속도 +0.02",
			Name = "벌레 휘장",
			QuoteDesc = "일찍 일어나는 벌레가... 응?",
		},

		[FiendFolio.ITEM.COLLECTIBLE.DADS_BATTERY] = {
			Desc = "Allows you to use your active item without having enough charge, resulting in negative charge (capped at -12)#Having negative charge reduces your move speed and shot speed, and persists even if you switch active items",
			Description = "액티브 아이템의 충전량이 모두 채워지지 않았을 때 액티브 아이템 사용 시 부족한 충전량 한칸 당 {{SpeedSmall}}/{{ShotspeedSmall}}(배율)을 깎고 사용합니다.(최대 12칸)",
			Name = "아빠의 배터리",
			QuoteDesc = "충전 빚지기",
		},

		[FiendFolio.ITEM.COLLECTIBLE.TORTURE_COOKIE] = {
			--Desc = "On use, deals half a red heart of damage to the player, and either displays an evil fortune, spawns a black heart, spawns a reverse tarot card or spawns an evil-themed trinket",
			Description = "사용 시 체력 반칸을 깎고 확률적으로 {{BlackHeart}}블랙하트(16%)/{{Card}}역타로카드(14%) 및 악마 관련 장신구(3%)를 드랍합니다.#빨간하트를 우선적으로 깎습니다.",
			Name = "고문 쿠키",
			QuoteDesc = "재사용 가능한 고문",
		},

		[FiendFolio.ITEM.COLLECTIBLE.ISAACD_EULOGY] = {
			--Desc = "Enemies have a luck-based chance to cause a Dice item (D6, D20, etc.) effect to occur upon death",
			Description = "적 처치 시 랜덤 주사위 효과를 발동합니다.#{{Blank}} ("
				.."{{Collectible"..CollectibleType.COLLECTIBLE_D1.."}}"
				.."{{Collectible"..CollectibleType.COLLECTIBLE_D6.."}}"
				.."{{Collectible"..CollectibleType.COLLECTIBLE_ETERNAL_D6.."}}"
				.."{{Collectible"..CollectibleType.COLLECTIBLE_D7.."}}"
				.."{{Collectible"..CollectibleType.COLLECTIBLE_D8.."}}"
				.."{{Collectible"..CollectibleType.COLLECTIBLE_D10.."}}"
				.."{{Collectible"..CollectibleType.COLLECTIBLE_D12.."}}"
				.."{{Collectible"..CollectibleType.COLLECTIBLE_D20.."}}"
				.."{{Collectible"..CollectibleType.COLLECTIBLE_SPINDOWN_DICE.."}}"
				.."{{Collectible"..FiendFolio.ITEM.COLLECTIBLE.D2.."}}"
				.."{{Collectible"..FiendFolio.ITEM.COLLECTIBLE.ETERNAL_D10.."}}"
				.."{{Collectible"..FiendFolio.ITEM.COLLECTIBLE.ETERNAL_D12.."}}"
				.."{{Collectible"..FiendFolio.ITEM.COLLECTIBLE.DUSTY_D10.."}}"
				.."{{Collectible"..FiendFolio.ITEM.COLLECTIBLE.LOADED_D6.."}}"
				.."{{Collectible"..FiendFolio.ITEM.COLLECTIBLE.AZURITE_SPINDOWN.."}}"
				..")"
				.."#!!! {{Collectible"..CollectibleType.COLLECTIBLE_D4.."}}/{{Collectible"..CollectibleType.COLLECTIBLE_D100.."}} : 0.01% 확률",
			Name = "주사위 찬사",
			QuoteDesc = "죽음으로 굴리기",
		},

		[FiendFolio.ITEM.COLLECTIBLE.BRICK_FIGURE] = {
			--Desc = "Spawns a Brick Separator and 4 Studs on pickup#Pennies have a 20% chance to be converted into Studs",
			Description = "Brick Separator와 4개의 레고 페니를 드랍합니다.#동전이 20%의 확률로 레고 페니로 바뀝니다.",
			Name = "벽돌 모형",
			QuoteDesc = "벽돌 집기",
		},

		--[[ [FiendFolio.ITEM.COLLECTIBLE.HAZELS_MOONBEAM] = {
			Description = "",
			Name = "",
			QuoteDesc = "",
		}, ]]

		[FiendFolio.ITEM.COLLECTIBLE.GOLDSHI_LUNCH] = {
			--Desc = "\1 +1 max heart#\1 +0.1 speed up#\1 +0.2 shotspeed up#In cleared rooms, this increases to +0.85 speed and +0.4 shotspeed",
			Description = "↑ {{Heart}}최대 체력 +1#↑ {{SpeedSmall}}이동속도 +0.1#{{Blank}} (클리어한 방의 경우 +0.85)#↑ {{ShotspeedSmall}}탄속 +0.2#{{Blank}} (클리어한 방의 경우 +0.4)",
			Name = "금시 점심",
			QuoteDesc = "체력 증가, 말처럼 빨리",
		},

		[FiendFolio.ITEM.COLLECTIBLE.TWINKLE_OF_CONTAGION] = {
			--Desc = "Enemies have a chance to glow upon entering a room#Looking at a glowing enemy passes the effect onto you, giving you a stat boost while under the effect#After a period of time, the glowing effect will jump from the player to a random enemy",
			Description = "방 입장 시 적 하나에 후광이 생깁니다.#캐릭터가 후광을 보면 그 후광이 캐릭터에게 옮겨지며 잠시동안 {{DamageSmall}}/{{TearsSmall}}/{{LuckSmall}}이 증가합니다.#일정 시간 이후 다른 적에게 오라가 옮겨집니다.",
			Name = "빛나는 전염",
			QuoteDesc = "도전해보기",
		},

		[FiendFolio.ITEM.COLLECTIBLE.DUSTY_D10] = {
			--Desc = "On use, rerolls all enemies in the room into different enemies from anywhere in the game#Attempts to reroll enemies into those with similar max HP",
			Description = "사용 시 그 방의 적을 다른 적으로 바꿉니다.",
			Name = "낡은 10면 주사위",
			QuoteDesc = "예전의 믿지 못할 물건",
		},

		[FiendFolio.ITEM.COLLECTIBLE.TOKEN_BAG] = {
			--Desc = "Familiar that drops 1 token every 10 rooms",
			Description = "방 10개 클리어 시 토큰을 하나 드랍합니다.",
			Name = "토큰 가방",
			QuoteDesc = "토큰 한가득",
		},

		[FiendFolio.ITEM.COLLECTIBLE.GREEN_ORANGE] = {
			--Desc = "\1 +0.7 damage up#\1 +0.5 tears up",
			Description = "↑ {{DamageSmall}}공격력 +0.7#↑ {{TearsSmall}}연사 +0.5",
			Name = "녹색 오렌지",
			QuoteDesc = "부디 깨달아주길...",
		},

		[FiendFolio.ITEM.COLLECTIBLE.REHEATED_PIZZA] = {
			--Desc = "\1 +1 max heart#At the start of each floor, spawns a random heart pickup",
			Description = "↑ {{Heart}}최대 체력 +1#{{UnknownHeart}} 스테이지 입장 시 랜덤 하트를 하나 드랍합니다.",
			Name = "뜨거운 피자",
			QuoteDesc = "일일 식사",
		},

		[FiendFolio.ITEM.COLLECTIBLE.HEDONISTS_COOKBOOK] = {
			--Desc = "On use, causes all enemies with the lowest max HP in the room to explode in a shower of projectiles",
			Description = "사용 시 그 방에서 최대 체력이 가장 낮은 적을 즉사시키며 그 자리에서 여러 개의 눈물을 흩뿌립니다.",
			Name = "쾌락주의자의 요리책",
			QuoteDesc = "자연 수확",
		},

		[FiendFolio.ITEM.COLLECTIBLE.ERRORS_CRAZY_SLOTS] = {
			--Desc = "On use, a three number slot appears above your head#Using the item again locks in a number, and the slot cycles faster after each number is locked#Once all three numbers are locked in, the player is granted the item of the ID shown by the three numbers#If the item ID is invalid then the player is teleported to the Error Room",
			Description = "!!! 일회용#사용 시 슬롯머신을 시작하며 아이템 사용 버튼을 누르면 왼쪽부터 하나씩 숫자를 멈춥니다.#3개의 숫자를 멈추면 해당 번호에 해당되는 아이템을 획득하며 유효하지 않은 아이템의 경우 {{ErrorRoom}}오류방으로 이동합니다.",
			Name = "오류난 슬롯머신",
			QuoteDesc = "운명을 돌리는 능력",
		},

		[FiendFolio.ITEM.COLLECTIBLE.SPELLING_BEE] = {
			Description = "현재 게임의 시드를 기반으로 각 글자가 능력치 및 픽업의 기반이 되는 경우 해당 능력치 및 픽업을 증가, 숫자의 경우 모든 능력치가 감소합니다.#!!! (예시 :D,A,M,A,G,E 중 한 글자 포함 시 {{DamageSmall}}공격력 증가)",
			Name = "스펠링 비",
			QuoteDesc = "글자의 효율",
		},

		[FiendFolio.ITEM.COLLECTIBLE.SCULPTED_PEPPER] = {
			--Desc = "On use, spawns a stone block#Attacking the stone block chisels it#Fully chiseled stone blocks produce an aura that gives status effects to enemies and buffs to the player",
			Description = "사용 시 그 방에 석상을 투하합니다.#석상 공격 시 조각상이 만들어지며 완성 시 주변의 적에게 {{Fear}}공포를 거는 오라를 생성합니다.",
			Name = "조각 고추",
			QuoteDesc = "오만의 힘",
		},

		[FiendFolio.ITEM.COLLECTIBLE.TOO_MANY_OPTIONS] = {
			Description = "모든 특수방이 3종류의 랜덤 특수방으로 전환되며 3개 중 하나를 선택할 수 있습니다.#!!! {{CurseRoom}}저주방 선택 시 방 문에 가시가 생깁니다.",
			Name = "너무 많은 선택",
			QuoteDesc = "너무 많아!",
		},


	}
	local ffTrinketDesc = {
		[FiendFolio.ITEM.TRINKET.SHARD_OF_CHINA] = {
			Description = "체력이 없거나 꽉 찬 상태에서 빨간하트 습득 시 특수 체력 게이지가 채워집니다.#채워진 게이지 1칸 당 {{DamageSmall}}공격력 +1.5#게이지 완충 시 자동으로 흡수되어 공격력 증가 효과가 영구적으로 적용됩니다.#특수 체력 게이지는 {{ButtonRT}}버튼을 꾹 누르거나 빨간하트 근처에 있을 때 캐릭터 위에 표시됩니다.",
			Name = "차이나의 조각",
			QuoteDesc = "자기 자신을 다시 조립하다",
		},
		[FiendFolio.ITEM.TRINKET.BIFURCATED_STARS] = {
			Description = "맵에 {{BossRoom}}보스방의 위치가 표시됩니다.#{{BossRoom}}보스방 클리어 시 보스방 출구가 {{TreasureRoom}}보물방으로 향하게 바뀝니다.",
			Name = "찢어진 별",
			QuoteDesc = "보스에게 찾아가라, 그리고 보상을 받아가라",
		},
		[FiendFolio.ITEM.TRINKET.FORTUNE_WORM] = {
			Description = "↑ {{ShotspeedSmall}}탄속 +0.2#↑ {{LuckSmall}}행운 +2#확률적으로({{LuckSmall}}) 적에게 명중 시 운세를 보여주는 공격력 x1.05의 포춘쿠키를 발사합니다.",
			Name = "운세 지렁이",
			QuoteDesc = "어쩌구 저쩌구",
		},
		[FiendFolio.ITEM.TRINKET.FOOLS_GOLD] = {
			Description = "방 클리어 보상이 일정 확률로 {{FFCursedPennyTint}}{{Coin}}저주받은 동전으로 바뀝니다.",
			Name = "바보를 위한 금덩이",
			QuoteDesc = "돈을 더 원해?",
		},
		[FiendFolio.ITEM.TRINKET.EXTRA_VESSEL] = {
			Description = "소지 시 임시 체력의 역할을 합니다.#체력 거래에 사용할 수 없습니다.#{{EmptyHeart}} 현재 비어 있음",
			Name = "추가 그릇",
			QuoteDesc = "체력 증가",
		},
		[FiendFolio.ITEM.TRINKET.HALF_VESSEL] = {
			Description = "소지 시 임시 체력의 역할을 합니다.#체력 거래에 사용할 수 없습니다.#{{HalfHeart}} 현재 반칸 채워짐",
			Name = "추가 그릇",
			QuoteDesc = "체력 증가",
		},
		[FiendFolio.ITEM.TRINKET.FULL_VESSEL] = {
			Description = "소지 시 임시 체력의 역할을 합니다.#체력 거래에 사용할 수 없습니다.#{{FullHeart}} 현재 한칸 채워짐",
			Name = "추가 그릇",
			QuoteDesc = "체력 증가",
		},
		[FiendFolio.ITEM.TRINKET.CHILI_POWDER] = {
			Description = "모든 열쇠를 {{FFSpicyKeyTint}}{{Key}}매운열쇠로 바꿉니다.#{{FFSpicyKeyTint}}{{Key}}매운열쇠는 기존 열쇠의 개수에 하나를 추가하나 획득 시 체력 반칸의 피해를 줍니다.",
			Name = "칠리 파우더",
			QuoteDesc = "그 시절의 뜨거운 열쇠고리",
		},
		[FiendFolio.ITEM.TRINKET.GMO_PENNY] = {
			Description = "동전을 주울 시 확률적으로({{LuckSmall}}) 랜덤 알약을 강제로 사용합니다.",
			Name = "GMO 페니",
			QuoteDesc = "알약 부자",
		},
		[FiendFolio.ITEM.TRINKET.MOLTEN_PENNY] = {
			Description = "동전을 주울 시 확률적으로({{LuckSmall}}) 현재 소지 중인 장신구를 흡수합니다.",
			Name = "녹아내리는 페니",
			QuoteDesc = "일한 만큼의 대가",
		},

		[FiendFolio.ITEM.TRINKET.BLOODY_SANDPAPER] = {
			Description = "캐릭터의 이동 관성을 제거하여 이동키를 떼면 즉시 멈춥니다.",
			Name = "피 묻은 사포",
			QuoteDesc = "멈춰!",
		},
		[FiendFolio.ITEM.TRINKET.RIGHT_HAND] = {
			Description = "{{EternalChest}} 상자가 33%의 확률로 이터널 상자로 교체됩니다.",
			Name = "오른손목",
			QuoteDesc = "빛의 보상을 거두어들이다",
		},
		[FiendFolio.ITEM.TRINKET.RED_RIBBON] = {
			Description = "{{EternalHeart}} 이터널하트 반칸 픽업을 한칸 픽업으로 바꿉니다.#{{Heart}} 한칸짜리 이터널하트 획득 즉시 최대 체력 +1",
			Name = "빨간 리본",
			QuoteDesc = "영원 2배",
		},

		[FiendFolio.ITEM.TRINKET.FLEA_MELTDOWN] = {
			Description = "방 입장 시 적에게 {{Burning}}화상을 입히는 주황색 아군 벼룩을 소환합니다.",
			Name = "붕괴의 벼룩",
			QuoteDesc = "붕괴를 초래",
		},
		[FiendFolio.ITEM.TRINKET.FLEA_DELUGE] = {
			Description = "방 입장 시 적과 접촉 시 8방향으로 눈물을 흩뿌리는 푸른색 아군 벼룩을 소환합니다.",
			Name = "홍수의 벼룩",
			QuoteDesc = "홍수를 초래",
		},
		[FiendFolio.ITEM.TRINKET.FLEA_POLLUTION] = {
			Description = "방 입장 시 적을 {{Slow}}느려지게 하는 보라색 아군 벼룩을 소환합니다.",
			Name = "오염의 벼룩",
			QuoteDesc = "오염을 초래",
		},
		[FiendFolio.ITEM.TRINKET.FLEA_PROPAGANDA] = {
			Description = "방 입장 시 적을 {{Charm}}매혹시키는 보라색 아군 벼룩을 소환합니다.",
			Name = "선전의 벼룩",
			QuoteDesc = "선전을 초래",
		},

		[FiendFolio.ITEM.TRINKET.FUZZY_PENNY] = {
			Description = "동전을 주울 시 아군 자폭 벼룩을 소환합니다.",
			Name = "털 많은 페니",
			QuoteDesc = "벼룩 부자",
		},
		[FiendFolio.ITEM.TRINKET.CHUNK_OF_TAR] = {
			Description = "방 진입 시 아군 blot을 1~3마리 소환합니다.",
			Name = "타르 덩이",
			QuoteDesc = "진흙 친구",
		},
		[FiendFolio.ITEM.TRINKET.FORTUNE_GRUB] = {
			Description = "↑ {{LuckSmall}}행운 +1#거지 및 슬롯머신이 보답을 내놓을 시 운세를 같이 표시합니다.",
			Name = "운세 애벌레",
			QuoteDesc = "점술기계의 속삭임",
		},
		[FiendFolio.ITEM.TRINKET.JIGSAW_PUZZLE_BOX] = {
			Description = "스테이지 진입 시 {{Card"..FiendFolio.ITEM.CARD.PUZZLE_PIECE.."}}퍼즐 조각을 소환합니다.(일회용)#{{Card"..FiendFolio.ITEM.CARD.PUZZLE_PIECE.."}}퍼즐 조각이 등장할 확률이 증가합니다.",
			Name = "직소 퍼즐 상자",
			QuoteDesc = "조각은 잃어버리기 마련",
		},

		[FiendFolio.ITEM.TRINKET.YIN_YANG_ORB] = {
			Description = "확률적으로({{LuckSmall}}) 공격력 x1.25의 강한 유도 공격이 나갑니다.#{{LuckSmall}} :20%, 7{{LuckSmall}} 이상: 66%",
			Name = "음양 오브",
			QuoteDesc = "유도성 부적",
		},
		[FiendFolio.ITEM.TRINKET.SWALLOWED_M90] = {
			Description = "피격 시 M90을 꺼내;#다음 공격 시 공격력 x3.5의 적을 관통하는 탄속이 빠른 눈물을 발사합니다.#!!! 눈물 발사 시 캐릭터가 뒤로 밀려납니다.",
			Name = "삼킨 M90",
			QuoteDesc = "푸슉!",
		},
		[FiendFolio.ITEM.TRINKET.TRINITY_WORM] = {
			Description = "↑ {{TearsSmall}}연사 +0.4#↑ {{RangeSmall}}사거리 +12.5#눈물이 트리케트라 모양으로({{Collectible333}}) 날아갑니다.#공격이 장애물을 관통합니다.",
			Name = "트리니티 벌레",
			QuoteDesc = "워 워 워!",
		},
		[FiendFolio.ITEM.TRINKET.IOU] = {
			Description = "방 클리어 보상 및 상자에서 장신구가 드랍될 확률이 증가합니다.#게임 종료(게임오버/엔딩) 시점에서 이 장신구 소지 시 다음 게임 시작 시 랜덤 장신구를 하나 소환합니다.",
			Name = "",
			QuoteDesc = "언젠간 돌려줄게",
		},
		[FiendFolio.ITEM.TRINKET.AUTOPSY_KIT] = {
			Description = "상점 주인 처치 시 동전 대신 {{Heart}}빨간하트 및 낮은 확률로 {{EmptyBoneHeart}}뼈하트를 드랍합니다.#원래 동전의 등급이 높을수록 뼈하트의 드랍률이 증가합니다..",
			Name = "포렌식 키트",
			QuoteDesc = "장기 수확",
		},
		[FiendFolio.ITEM.TRINKET.SPIRE_GROWTH] = {
			Description = "타로 타입 카드 사용 시 사용한 카드 번호의 숫자에 비례하여 {{DamageSmall}}공격력이 증가합니다.",
			Name = "스파이어 성장",
			QuoteDesc = "카드의 힘",
		},
		[FiendFolio.ITEM.TRINKET.FLEA_CIRCUS] = {
			Description = "적 처치 시 확률적으로 랜덤 벼룩을 소환합니다.",
			Name = "벼룩 서커스",
			QuoteDesc = "감염",
		},
		[FiendFolio.ITEM.TRINKET.SHARP_PENNY] = {
			Description = "동전을 주울 시 확률적으로 피격 시 효과를 발동합니다.",
			Name = "뾰족한 페니",
			QuoteDesc = "고통 부자",
		},
		[FiendFolio.ITEM.TRINKET.ANGRY_FAIC] = {
			Description = "보스 및 미니보스의 체력이 증가합니다.#보스 처치 시 하트류 픽업을 추가로 드랍합니다..",
			Name = "",
			QuoteDesc = "풍부한 보스",
		},
		[FiendFolio.ITEM.TRINKET.ETERNAL_CAR_BATTERY] = {
			Description = "액티브 아이템 사용 시 효과가 4~6번 발동되지만 50%의 확률로 액티브 아이템이 사라집니다.",
			Name = "이터널 자동차 건전지",
			QuoteDesc = "???",
		},
		[FiendFolio.ITEM.TRINKET.POCKET_DICE] = {
			Description = "스테이지 진입 시 랜덤 유리 주사위 조각 2개와 동전을 하나 드랍합니다.",
			Name = "주사위 주머니",
			QuoteDesc = "층마다 새로운 운명",
		},
		[FiendFolio.ITEM.TRINKET.LOCKED_SHACKLE] = {
			Description = "!!! 교체불가#↑ {{DamageSmall}}공격력 +1#↑ {{TearsSmall}}연사 +0.35#↑ {{RangeSmall}}사거리 +1#↑ {{ShotspeedSmall}}탄속 +0.16#↑ {{LuckSmall}}행운 +1#열쇠를 주울 시 열쇠를 강제로 소모하고 장신구를 파괴합니다.",
			Name = "잠겨있는 족쇄",
			QuoteDesc = "모든 능력치 증가 + 열쇠가 없어",
		},
		[FiendFolio.ITEM.TRINKET.SOLEMN_VOW] = {
			Description = "{{Collectible403}} 적의 체력과 적에게 주는 피해량이 수치로 표시됩니다.",
			Name = "굳건한 맹세",
			QuoteDesc = "해롭지 않음",
		},
		[FiendFolio.ITEM.TRINKET.DEALMAKERS] = {
			Description = "방 입장시마다 {{Shop}}모든 판매 아이템의 가격이 바뀝니다.#일부 품목은 빠른 속도로 가격이 계속 바뀝니다.",
			Name = "딜메이커",
			QuoteDesc = "특별 거래",
		},
		[FiendFolio.ITEM.TRINKET.JEVILSTAIL] = {
			Description = "방 입장시마다 정해진 순서대로 특정 효과를 발동합니다.",
			Name = "제빌의 꼬리",
			QuoteDesc = "뭐든지 할 수 있어!",
		},
		[FiendFolio.ITEM.TRINKET.PETRIFIED_GEL] = {
			Description = "일반 똥이 확률적으로 샴푸로 대체됩니다.#샴푸 파괴 시 랜덤 픽업을 드랍합니다.",
			Name = "굳은 젤",
			QuoteDesc = "운이 좋은 건가?",
		},
		[FiendFolio.ITEM.TRINKET.HATRED] = {
			Description = "캐릭터와 같이 이동하며 공격하는 방향으로 캐릭터의 공격과 같은 공격을 발사합니다.#공격키를 두번 누르면 장애물에 부딪힐 때까지 돌진하며 접촉한 적에게 피해를 주고 돌진한 자리에 적을 느려지게 하는 장판을 생성합니다.#돌진 후 장애물에 부딪히면 사라지며 일정 시간 이후 다시 생성됩니다.",
			Name = "혐오",
			QuoteDesc = "더블탭 악의",
		},
		[FiendFolio.ITEM.TRINKET.FROG_PUPPET] = {
			Description = "!!! 일회용#사망 시 즉시 {{Player"..FiendFolio.PLAYER.SLIPPY.."}}Slippy(3{{Heart}})로 부활하며 {{Collectible"..FiendFolio.ITEM.COLLECTIBLE.FROG_HEAD.."}}Golden Frog Head가 카드/알약 슬롯에 배정됩니다.#{{Player"..FiendFolio.PLAYER.SLIPPY.."}}Slippy는 이동키를 떼도 멈출 수 없습니다.",
			Name = "개구리 인형",
			QuoteDesc = "이세계의 초록빛",
		},
		[FiendFolio.ITEM.TRINKET.TATTERED_FROG_PUPPET] = {
			Description = "!!! 일회용#사망 시 즉시 {{Player"..FiendFolio.PLAYER.SLIPPY.."}}Slippy(3{{Heart}})로 부활하며 {{Collectible"..FiendFolio.ITEM.COLLECTIBLE.FROG_HEAD.."}}Golden Frog Head가 카드/알약 슬롯에 배정됩니다.#{{Player"..FiendFolio.PLAYER.SLIPPY.."}}Slippy는 이동키를 떼도 멈출 수 없습니다.",
			Name = "찢어진 개구리 인형",
			QuoteDesc = "이젠 네가 초록빛이야",
		},
		[FiendFolio.ITEM.TRINKET.CURSED_URN] = {
			Description = "!!! 일회용/{{ColorOrange}}교체 및 버리기 시 깨짐{{CR}}#↑ {{TearsSmall}}연사 증가#사망 시 즉시 {{Player"..FiendFolio.PLAYER.CHINA.."}}China로 부활합니다.#{{Player"..FiendFolio.PLAYER.CHINA.."}} China는 체력이 없으며 피격 시 {{BrokenHeart}}부서진하트 하나가 추가됩니다.",
			Name = "저주받은 항아리",
			QuoteDesc = "영원한 생명?",
		},
		[FiendFolio.ITEM.TRINKET.SHATTERED_CURSED_URN] = {
			Description = "!!! 일회용#↑ {{TearsSmall}}연사 증가#{{Collectible439}} Mom's Box 소지 상태에서 사망 시 즉시 {{Player"..FiendFolio.PLAYER.CHINA.."}}China로 부활합니다.#{{Player"..FiendFolio.PLAYER.CHINA.."}} China는 체력이 없으며 피격 시 {{BrokenHeart}}부서진하트 하나가 추가됩니다.",
			Name = "깨진 항아리",
			QuoteDesc = "이미 깨졌어",
		},
		[FiendFolio.ITEM.TRINKET.CONJOINED_CARD] = {
			Description = "스테이지 진입 시 미니보스방을 추가로 생성합니다.#!!! Blue Womb, The Void, Home 스테이지는 무효과",
			Name = "쌍둥이 카드",
			QuoteDesc = "작은 황제",
		},

		[FiendFolio.ITEM.TRINKET.LOST_FLOWER_CROWN] = {
			Description = "스테이지 당 1회 한정으로 랜덤 적 하나가 해당 게임에서 제거되어 다시 등장하지 않습니다.",
			Name = "잊혀진 꽃 왕관",
			QuoteDesc = "잊혀진 기억",
		},
		[FiendFolio.ITEM.TRINKET.WACKEY] = {
			Description = "{{Key}} 열쇠류 픽업의 드랍률이 동일하게 변경됩니다.",
			Name = "왜키",
			QuoteDesc = "엉뚱한 열쇠",
		},
		[FiendFolio.ITEM.TRINKET.HEARTACHE] = {
			Description = "피격 시 그 피격을 무효화하고 {{BrokenHeart}}소지 불가능 체력 +1",
			Name = "심장통",
			QuoteDesc = "마음이 아파",
		},
		[FiendFolio.ITEM.TRINKET.REDHAND] = {
			Description = "캐릭터/픽업/적을 잡아 강제로 이동시키는 빨간 손 2개가 방을 돌아다닙니다.",
			Name = "붉은 손",
			QuoteDesc = "잡았다!",
		},
		[FiendFolio.ITEM.TRINKET.MIDDLE_HAND] = {
			Description = "상자가 높은 확률로 장난꾸러기 상자로 교체됩니다.",
			Name = "가운데손목",
			QuoteDesc = "부덕한 보상을 거두어들이다",
		},
		[FiendFolio.ITEM.TRINKET.RAINBOW_BEAN] = {
			Description = "적에게 가까이 다가갈 시 확률적으로 랜덤 방귀를 뀝니다.",
			Name = "무지개 콩",
			QuoteDesc = "친숙한 방귀",
		},
		[FiendFolio.ITEM.TRINKET.FAULTY_FUSE] = {
			Description = "{{FFCopperBombTint}}{{Bomb}}구리폭탄이 등장할 확률이 증가합니다.#{{Collectible106}} {{FFCopperBombTint}}{{Bomb}}구리폭탄은 일반 폭탄보다 범위와 공격력이 더 크나 불발할 수 있습니다.",
			Name = "끊어진 퓨즈",
			QuoteDesc = "탄 구리 맛",
		},
		[FiendFolio.ITEM.TRINKET.ENERGY_SEARCHER] = {
			Description = "에너지 카드가 등장할 확률이 증가합니다.#에너지 카드 사용 시 일정 확률로 다른 에너지 카드를 소환합니다.",
			Name = "에너지 탐지기",
			QuoteDesc = "에너지 카드를 드로우",
		},
		[FiendFolio.ITEM.TRINKET.MASSIVE_AMETHYST] = {
			Description = "{{SecretRoom}}비밀방 상점 주인이 룬이 박힌 돌덩이로 바뀝니다.#룬이 박힌 돌덩이 파괴 시 {{Card55}}Rune Shard 0~3개, {{Rune}}룬 0~2개를 드랍합니다.",
			Name = "거대 아메시스트",
			QuoteDesc = "수정화된 주인",
		},
		[FiendFolio.ITEM.TRINKET.BROKEN_RECORD] = {
			Description = "아이템이 등장할 때 확률적으로 소지 중인 아이템으로 등장합니다.#중첩 가능한 아이템만 등장합니다.",
			Name = "부서진 레코드",
			QuoteDesc = "반복된 채로 멈춰있어",
		},
		[FiendFolio.ITEM.TRINKET.FUSHIGI] = {
			--Description = "Luck-affected chance to fire a metal tear with the Eye of the Occult effect with increased range and double damage.",
			Description = "{{Collectible606}} 공격 시 확률적으로 2초간 적과 탄환을 끌어들이는 블랙홀이 생성됩니다",
			Name = "불가사의",
			QuoteDesc = "떠다니게 해!",
		},
		[FiendFolio.ITEM.TRINKET.NESTING_DOLL] = {
			--Description = "When blowing up a beggar, has a chance to spawn a different random beggar in its place.",
			Description = "거지 폭파 시 확률적으로 그 자리에서 다른 거지가 생깁니다.",
			Name = "인형 안의 인형",
			QuoteDesc = "안에서의 서프라이즈",
		},
		[FiendFolio.ITEM.TRINKET.EGG_PENNY] = {
			--Description = "Chance to spawn a Fragile Bobby on picking up a coin.",
			Description = "{{Coin}}동전을 주울 때 확률적으로 Fragile Bobby를 소환합니다.",
			Name = "알 페니",
			QuoteDesc = "아기 부자",
		},
		[FiendFolio.ITEM.TRINKET.LEFTOVERS] = {
			--Description = "Overhealed health gained from heart pickups will be left on the ground for later use.",
			Description = "{{Heart}} 초과회복된 하트류 픽업을 남깁니다.",
			Name = "먹다 남은 음식",
			QuoteDesc = "나중을 위해 아껴",
		},
		[FiendFolio.ITEM.TRINKET.FUZZY_PICKLE] = {
			--Description = "Grants +0.1 damage up for each reference item/trinket the player has#Active items grant +0.5 damage up instead#Loose references only grant half of the corresponding damage up.",
			Description = "패러디 아이템 당 {{DamageSmall}}공격력 +0.1#{{Blank}} (패러디가 약한 경우 +0.05)#액티브 아이템인 경우 +0.5",
			Name = "퍼지 피클",
			QuoteDesc = "패러디 증가",
		},
		[FiendFolio.ITEM.TRINKET.DUDS_FLOWER] = {
			--Description = "All bombs spawned by the player will become copper bombs.",
			Description = "캐릭터가 설치한 폭탄이 전부 구리폭탄으로 설치됩니다.",
			Name = "바보의 꽃",
			QuoteDesc = "멍청한 폭탄",
		},
		[FiendFolio.ITEM.TRINKET.BOMB_TOKEN] = {
			--Description = "Increases the flat damage dealt by bombs spawned by the player by 100#{{Collectible52}} Grants a 1.5x damage multiplier to Dr. Fetus bombs (instead of the flat damage up).",
			Description = "{{Bomb}} 플레이어의 폭탄의 피해량 +100#{{Collectible52}} 페투스 폭탄의 경우 피해량 x1.5",
			Name = "폭탄 토큰",
			QuoteDesc = "폭발력 증가",
		},

		[FiendFolio.ITEM.ROCK.DIRT_CLUMP] = {
			Description = "{{ffGrind}} 채굴기로 이 장신구 소모 시 동전을 소모하지 않습니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "흙덩이",
			QuoteDesc = "공짜 채굴",
		},
		[FiendFolio.ITEM.ROCK.ROLLING_ROCK] = {
			Description = "방 클리어 시 {{SpeedSmall}}이동속도가 +0.05씩 최대 3번 증가합니다.#패널티 피격 시 이동속도 증가치가 초기화됩니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "굴러가는 돌멩이",
			QuoteDesc = "이동속도 증가 + 그 페이스를 유지해줘",
		},
		[FiendFolio.ITEM.ROCK.POCKET_SAND] = {
			Description = "무효과",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "가루 한 줌",
			QuoteDesc = "아무것도 없어",
		},
		[FiendFolio.ITEM.ROCK.ROUGH_ROCK] = {
			Description = "{{ffGrind}} 채굴기로 이 장신구 소모 시 등장 확률이 낮은 장신구가 나옵니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "거친 돌",
			QuoteDesc = "갈아버려!",
		},
		[FiendFolio.ITEM.ROCK.BLOODY_ROCK] = {
			Description = "눈물을 4번 발사할 때마다 공격력 x2의 눈물을 발사합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "피묻은 돌",
			QuoteDesc = "아픈 눈물",
		},
		[FiendFolio.ITEM.ROCK.SPIKED_ROCK] = {
			Description = "최초 획득 시 캐릭터가 체력 반칸의 피해를 받습니다.(사망하지 않음)#가시나 가시상자에 피해를 받지 않습니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "가시돌",
			QuoteDesc = "고통은 한순간 + 가시 면역",
		},
		[FiendFolio.ITEM.ROCK.SLIPPY_ROCK] = {
			Description = "↑ {{SpeedSmall}}이동속도 +0.15#캐릭터의 이동이 더 미끄러집니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "미끄러운 돌",
			QuoteDesc = "이동속도 증가 + 마찰력 감소",
		},
		[FiendFolio.ITEM.ROCK.ARCANE_ROCK] = {
			Description = "확률적으로({{LuckSmall}}) 공격력 +2의 유도 눈물을 발사합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "마법의 돌",
			QuoteDesc = "확률 유도 공격 + 유도 공격력 증가",
		},
		[FiendFolio.ITEM.ROCK.MINERAL_ROCK] = {
			Description = "↑ 장애물에 접촉하는 동안 모든 능력치 증가",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "광물 암석",
			QuoteDesc = "돌에 비비면 모든 능력치 증가",
		},
		[FiendFolio.ITEM.ROCK.THORNY_ROCK] = {
			Description = "피격 시 캐릭터 주위에 충격파를 일으킵니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "가시넝쿨에 묶인 돌",
			QuoteDesc = "맞으면 지진파",
		},
		[FiendFolio.ITEM.ROCK.TIME_LOST_DIAMOND] = {
			Description = "{{Collectible422}} 피격 시 방당 1회 한정으로 이전 방의 시점으로 시간을 되돌립니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "시간이 멈춘 돌",
			QuoteDesc = "맞으면 시간 되돌리기",
		},
		[FiendFolio.ITEM.ROCK.OBSIDIAN_GRINDSTONE] = {
			Description = "{{DamageSmall}}공격력/{{TearsSmall}}연사가 증가하며 다른 장신구를 같이 들고 있을 경우 추가로 증가합니다.#눈물을 10번 발사할 때마다 {{Trinket"..FiendFolio.ITEM.ROCK.POCKET_SAND.."}}Pocket Sand를 제외한 소지 중인 다른 장신구를 바꿉니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "흑요석 숫돌",
			QuoteDesc = "공격력, 연사 증가 + 석기 교체",
		},
		[FiendFolio.ITEM.ROCK.GODS_MARBLE] = {
			Description = "확률적으로({{LuckSmall}}) 적에게 명중 시 추가 공격력의 빛줄기가 떨어지는 공격이 나갑니다.#!!!캐릭터도 빛줄기에 피해를 받습니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "신의 구슬",
			QuoteDesc = "성지",
		},
		[FiendFolio.ITEM.ROCK.TWENTY_SIDED_EMERALD] = {
			Description = "픽업 주위에 3초동안 가까이 있으면 최대 3번까지 다른 픽업으로 바꿉니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "12각 에메랄드",
			QuoteDesc = "근접 바꾸기",
		},
		[FiendFolio.ITEM.ROCK.TECHNOLOGICAL_RUBY_2] = {
			Description = "소지 시 캐릭터 주변에 2개의 원형 레이저를 발산합니다.#내부 레이저는 캐릭터 공격력 x0.25의 피해를, 외부 레이저는 캐릭터 공격력 x0.1의 피해를 줍니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "기계 루비 2.0",
			QuoteDesc = "강력한 보안에는 대가가 필요하다",
		},
		[FiendFolio.ITEM.ROCK.LEAKY_ROCK] = {
			Description = "캐릭터가 움직일 때마다 캐릭터의 공격력의 눈물을 제자리에 흘립니다.#연사가 빠를수록 흘리는 주기가 짧아집니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "눈물나는 돌",
			QuoteDesc = "흘리고 있어",
		},
		[FiendFolio.ITEM.ROCK.TWIN_TUFFS] = {
			Description = "25%(+2.5 x {{LuckSmall}})의 확률로 픽업이 1+1로 드랍됩니다.#방 클리어 보상이 확률적으로 하나 더 등장합니다.#15%(+1.5 x {{LuckSmall}})의 확률로 방 클리어 보상이 하나 더 등장합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "터프한 쌍둥이",
			QuoteDesc = "쌍둥이 보상",
		},
		[FiendFolio.ITEM.ROCK.WETSTONE] = {
			Description = "클리어하지 않은 방에서 주기적으로 방울을 소환합니다.#이 장신구로 소환된 방울은 캐릭터에게 피해를 주지 않으며 적의 탄환을 막아줍니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "습한 돌",
			QuoteDesc = "방울방울",
		},
		[FiendFolio.ITEM.ROCK.STROMATOLITE] = {
			Description = "장애물 파괴 시 확률적으로 {{HalfHeart}}빨간하트 반칸을 드랍합니다.#색돌 파괴 시 확률적으로 {{SoulHeart}}소울하트를 추가로 드랍합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "스트로마톨라이트",
			QuoteDesc = "돌의 활력",
		},
		[FiendFolio.ITEM.ROCK.RIBBED_ROCK] = {
			Description = "↑ {{EmptyBoneHeart}}뼈하트 +1#{{EmptyBoneHeart}} 최대 체력 증가 아이템 획득 시 최대 체력 대신 뼈하트가 증가합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "늑골석",
			QuoteDesc = "그녀에게 기쁨을",
		},
		[FiendFolio.ITEM.ROCK.FIENDISH_AMETHYST] = {
			Description = "클리어하지 않은 방 입장 시 Fiend의 부하를 4마리 소환합니다.(Amethyst 타입)",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "악한 아메시스트",
			QuoteDesc = "핀드 투성이!",
		},
		[FiendFolio.ITEM.ROCK.STURDY_ROCK] = {
			Description = "{{SoulHeart}} 스테이지 입장 시 소울하트 +1",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "견고한 돌",
			QuoteDesc = "체력적인 시작",
		},
		[FiendFolio.ITEM.ROCK.BRICK_ROCK] = {
			Description = "공격키를 누르면 장신구를 소모하여 공격력 15의 피해를 주는 벽돌을 발사합니다.#발사한 벽돌은 다시 주울 수 있습니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "벽돌",
			QuoteDesc = "던져!",
		},
		[FiendFolio.ITEM.ROCK.SAPPHIC_SAPPHIRE] = {
			Description = "{{Charm}} 모든 암컷의 적을 매혹시킵니다.#{{Freezing}} 확률적으로 적 처치시 얼어붙는 공격을 발사합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "사픽 사파이어",
			QuoteDesc = "푸른색을 못쓰게 하는 돌",
		},
		[FiendFolio.ITEM.ROCK.BLOOD_DIAMOND] = {
			Description = "{{BleedingOut}} 확률적으로 적을 출혈시키는 공격을 발사합니다.#피격 시 캐릭터의 위치에 적에게 피해를 주는 빨간 장판을 생성합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "핏빛 다이아몬드",
			QuoteDesc = "출혈 공격",
		},
		[FiendFolio.ITEM.ROCK.SCENTED_ROCK] = {
			Description = "{{Charm}} 캐릭터와 가까이 있는 적을 매혹시킵니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "향기로운 돌",
			QuoteDesc = "매혹 오라",
		},
		[FiendFolio.ITEM.ROCK.ARCADE_ROCK] = {
			Description = "25%(+2.5 x {{LuckSmall}})의 확률로 동전 슬롯머신 사용 시 동전을 소모하지 않습니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "오락석",
			QuoteDesc = "버그 걸린 오락기계",
		},
		[FiendFolio.ITEM.ROCK.TINTED_HEART] = {
			Description = "피격 시 확률적으로 {{Heart}}빨간하트를 하나 드랍합니다.#폭발 피해를 받으면 확률적으로 {{SoulHeart}}소울하트 및 {{Key}}/{{Bomb}}/{{Chest}}를 각각 드랍합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "하트 모양 색돌",
			QuoteDesc = "영혼이 담겨있어",
		},
		[FiendFolio.ITEM.ROCK.ROSE_QUARTZ] = {
			Description = "피격 시 2.5초동안 {{ColorOrange}}적의 탄환을 막아주는{{CR}} 보호막을 생성합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "장미색 쿼츠",
			QuoteDesc = "탄환 방어막",
		},
		[FiendFolio.ITEM.ROCK.HAILSTONE] = {
			Description = "캐릭터와 가까이 있는 적을 {{Slow}}둔화 시키며 둔화된 적 처치 시 {{Freezing}}얼어붙습니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "우박",
			QuoteDesc = "냉기 오라",
		},
		[FiendFolio.ITEM.ROCK.RAMBLIN_OPAL] = {
			Description = "적이 있는 방에서 주기적으로 아군 Shiitake Spore를 최대 3마리까지 소환합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "걸어가는 오팔",
			QuoteDesc = "보석 포자",
		},
		[FiendFolio.ITEM.ROCK.SAND_DOLLAR] = {
			Description = "{{Shop}}상점에서 장신구를 버리면 10~20{{Coin}} 상당의 픽업으로 바꿉니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "모래 지폐",
			QuoteDesc = "상점에 팔 수 있어",
		},
		[FiendFolio.ITEM.ROCK.HENGE_ROCK] = {
			Description = "소지한 석기 장신구의 효과를 강화시킵니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "스톤헨지",
			QuoteDesc = "석기 강화",
		},
		[FiendFolio.ITEM.ROCK.SALT_LAMP] = {
			Description = "2분간 적과 탄환을 강하게 밀쳐냅니다.#2분이 지나면 전구가 꺼지며 배터리 픽업을 주울 시 배터리 크기에 비례한 만큼 재사용할 수 있습니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "소금 램프",
			QuoteDesc = "충전식 오라",
		},
		[FiendFolio.ITEM.ROCK.MOLTEN_SLAG] = {
			Description = "{{Burning}} 캐릭터와 가까이 있는 적에게 화상을 입힙니다.#채굴기로 이 장신구 소모 시 다른 장신구를 흡수합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "녹아내리는 화산암재",
			QuoteDesc = "흡수성 채굴",
		},
		[FiendFolio.ITEM.ROCK.THUNDER_EGG] = {
			Description = "↓ {{SpeedSmall}}이동속도 -0.1#방 클리어 시 확률적으로 희귀한 석기 장신구로 바꿉니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "계룡 알",
			QuoteDesc = "희귀한 걸 품은 것",
		},
		[FiendFolio.ITEM.ROCK.UNOBTAINIUM] = {
			Description = "!!! 획득 불가",
			Name = "",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.ROCK.SANDSTONE] = {
			Description = "확률적으로({{LuckSmall}}) 캐릭터와 가까울수록 공격력이 4배 증가하며 멀어질수록 0배로 감소, 적에게 {{Confusion}}혼란을 거는 거대한 돌덩이를 발사합니다.#폭발 피해를 받으면 {{Trinket"..FiendFolio.ITEM.ROCK.POCKET_SAND.."}}Pocket Sand로 바뀝니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "사암",
			QuoteDesc = "쉽게 부서지지...",
		},
		[FiendFolio.ITEM.ROCK.FAKE_ROCK] = {
			Description = "획득 시 {{Key}}열쇠를 하나 드랍합니다.#{{Key}} 방 안에 잠긴 문이 있으면 장애물 파괴 시 방당 1회 한정으로 열쇠를 드랍합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "가짜 돌",
			QuoteDesc = "자물쇠에서 멀어지지 마",
		},
		[FiendFolio.ITEM.ROCK.CITRINE_PULP] = {
			Description = "공격 시 낮은 확률로 여러 개의 눈물을 흩뿌립니다.#적과 가까이 있으면 적에게 피해를 주는 노란 장판을 깝니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "황수정 펄프",
			QuoteDesc = "짧은 사거리의 음료수",
		},
		[FiendFolio.ITEM.ROCK.BLOODSTONE] = {
			Description = "적 처치 시 {{DamageSmall}}공격력 +0.1#피격 시 {{DamageSmall}}공격력 +1#증가한 공격력은 서서히 감소합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "혈석",
			QuoteDesc = "고통받을수록 강해지다",
		},
		[FiendFolio.ITEM.ROCK.EMETIC_ANTIMONY] = {
			Description = "{{Collectible149}}주기적으로 구토제 눈물을 발사합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "메스꺼운 안티몬",
			QuoteDesc = "틈만 나면 구토",
		},
		[FiendFolio.ITEM.ROCK.DOUBLE_RUBBLE] = {
			Description = "{{ffGrind}} 채굴기로 이 장신구 소모 시 2개의 석기 장신구를 캐냅니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "더블 재갈",
			QuoteDesc = "채굴 2배",
		},
		[FiendFolio.ITEM.ROCK.ROCK_FROM_AN_ABYSS] = {
			Description = "방 입장 시 20%의 확률로 {{ffDoom}}적에게 심판을 겁니다.",
			StatusEffects = {ffStatusEffectDesc.DOOM,ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "심연에서 온 돌멩이",
			QuoteDesc = "그들은 운명을 깨달았을 거야",
		},
		[FiendFolio.ITEM.ROCK.HECTOR] = {
			Description = "↑ {{DamageSmall}}공격력 +1#↑ {{TearsSmall}}공격 딜레이 -1(연사 증가)#↓ {{SpeedSmall}}이동속도 -0.1#피격 시 강제로 내려놓습니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "헥토르",
			QuoteDesc = "변화",
		},
		[FiendFolio.ITEM.ROCK.VESSEL_ROCK] = {
			Description = "소지 시 임시 체력의 역할을 하며 비어 있는 상태에서 피격 시 {{Trinket"..FiendFolio.ITEM.ROCK.POCKET_SAND.."}}Pocket Sand로 바뀝니다.#체력 거래에 사용할 수 없습니다.#{{EmptyHeart}} 현재 비어 있음",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "돌 그릇",
			QuoteDesc = "체력 증가",
		},
		[FiendFolio.ITEM.ROCK.HALF_VESSEL_ROCK] = {
			Description = "소지 시 임시 체력의 역할을 하며 비어 있는 상태에서 피격 시 {{Trinket"..FiendFolio.ITEM.ROCK.POCKET_SAND.."}}Pocket Sand로 바뀝니다.#체력 거래에 사용할 수 없습니다.#{{HalfHeart}} 현재 반칸 채워짐",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "돌 그릇",
			QuoteDesc = "체력 증가",
		},
		[FiendFolio.ITEM.ROCK.FULL_VESSEL_ROCK] = {
			Description = "소지 시 임시 체력의 역할을 하며 비어 있는 상태에서 피격 시 {{Trinket"..FiendFolio.ITEM.ROCK.POCKET_SAND.."}}Pocket Sand로 바뀝니다.#체력 거래에 사용할 수 없습니다.#{{FullHeart}} 현재 한칸 채워짐",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "돌 그릇",
			QuoteDesc = "체력 증가",
		},
		[FiendFolio.ITEM.ROCK.CONSTANT_ROCK_SHOOTER] = {
			Description = "↑ {{TearsSmall}}공격 딜레이 -2.5(연사 증가)#캐릭터가 자동으로 공격합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "무한 돌멩이 발사기",
			QuoteDesc = "계속 발사해!",
		},
		[FiendFolio.ITEM.ROCK.ROBOT_ROCK] = {
			Description = "적에게 랜덤 상태이상을 거는 짧은 레이저 2개를 시계방향으로 발사합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "로봇 돌덩이",
			QuoteDesc = "부와부와부와부와부와",
		},
		[FiendFolio.ITEM.ROCK.ROCK_CANDY] = {
			Description = "확률적으로({{LuckSmall}}) 적에게 {{Charm}}매혹을 거는 공격력 x1.5의 공격을 발사합니다.#적 처치 시 잠시 후 사라지는 {{HalfHeart}}설탕 크리스탈을 드랍합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "돌사탕",
			QuoteDesc = "달콤한 크리스탈",
		},
		[FiendFolio.ITEM.ROCK.KEYSTONE] = {
			Description = "{{Key}} 열쇠 소모 시 그 층에서 {{TearsSmall}}연사 +0.35, {{SpeedSmall}}이동속도 +0.1",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "쐐기돌",
			QuoteDesc = "보너스 잠금해제",
		},
		[FiendFolio.ITEM.ROCK.SILVER_TONGUE] = {
			Description = "채굴기 사용 금액이 1{{Coin}} 감소합니다.#!!! 흡수 시 50%의 확률로 감소",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "은색 혓바닥",
			QuoteDesc = "저렴한 채굴",
		},
		[FiendFolio.ITEM.ROCK.MEAT_SLAB] = {
			Description = "주기적으로 캐릭터가 눈물을 하나씩 흩뿌립니다.#눈물을 흩뿌리는 속도는 캐릭터의 전체 체력이 적을수록 빨라집니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "고기덩이",
			QuoteDesc = "땀나!",
		}, -- no sweating effect
		[FiendFolio.ITEM.ROCK.SHEEP_ROCK] = {
			Description = "확률적으로({{LuckSmall}}) 눈물이 체공하며 다른 눈물과 부딪힐 시 서로 튕겨나가며 움직입니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "염소모양 돌",
			QuoteDesc = "느릿느릿한 눈물",
		},
		[FiendFolio.ITEM.ROCK.REBELLION_ROCK] = {
			Description = "피격 시 주변의 적을 밀쳐내며 {{ffBruise}}멍들게 합니다.#{{ffBruise}} 멍든 적은 해당 상태 중첩 수만큼 추가 피해를 받습니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "혁명석",
			QuoteDesc = "적들에게서 극복하라",
		},
		[FiendFolio.ITEM.ROCK.DADS_LEGENDARY_GOLDEN_ROCK] = {
			Description = "항상 황금 형태로 등장합니다.#{{ffGrind}} 채굴기로 이 장신구 소모 시 항상 황금 형태의 석기 장신구가 등장합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "아빠의 전설적인 황금",
			QuoteDesc = "드디어 황금 채굴",
		},
		[FiendFolio.ITEM.ROCK.BEDROCK] = {
			Description = "스테이지 진입 시 33%의 확률로 침대를 소환합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "배게",
			QuoteDesc = "쿨쿨...",
		},
		[FiendFolio.ITEM.ROCK.SHEETROCK] = {
			Description = "스테이지 진입 시 {{Heart}}체력을 2칸 회복합니다.#침대에서 자면 {{SoulHeart}}소울하트 2개를 추가로 획득합니다..",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "이불",
			QuoteDesc = "편안한 잠자리",
		},
		[FiendFolio.ITEM.ROCK.FETAL_STONE] = {
			Description = "{{Confusion}} 공격하는 방향으로 확률적으로 적에게 혼란을 거는 공격력 5의 돌덩이를을 발사합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "돌멩이 아기",
			QuoteDesc = "고대의 친구",
		},
		[FiendFolio.ITEM.ROCK.GRIMACE_ROCK1] = {
			Description = "주변의 적에게 캐릭터의 공격력의 눈물을 발사합니다.#내려놓은 상태에서도 동작합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "꼬마 돌머리",
			QuoteDesc = "돌덩이 친구",
		},
		[FiendFolio.ITEM.ROCK.GRIMACE_ROCK2] = {
			Description = "주변의 적에게 캐릭터의 공격력 +10의 폭발성 구토제를 발사합니다.#내려놓은 상태에서도 동작합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "꼬마 구토머리",
			QuoteDesc = "폭발하는 친구",
		},
		[FiendFolio.ITEM.ROCK.GRIMACE_ROCK3] = {
			Description = "적이 있는 방에서 주기적으로 적에게 피해를 주거나 탄환을 막아주는 방울을 소환합니다.#내려놓은 상태에서도 동작합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "꼬마 젖은머리",
			QuoteDesc = "방울방울 친구",
		},
		[FiendFolio.ITEM.ROCK.GRIMACE_ROCK4] = {
			Description = "한 방향으로 캐릭터의 공격력의 눈물을 계속 발사합니다.#내려놓거나 다시 주울 때마다 방향을 바꿀 수 있습니다.#내려놓은 상태에서도 동작합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "꼬마 우직머리",
			QuoteDesc = "올곧은 친구",
		},
		[FiendFolio.ITEM.ROCK.GRIMACE_ROCK5] = {
			Description = "근처의 적을 주기적으로 빨아들였다가 멈춥니다.#내려놓은 상태에서도 동작합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "깨진 꼬마 구멍머리",
			QuoteDesc = "빨아들이는 친구",
		},
		[FiendFolio.ITEM.ROCK.GRIMACE_ROCK6] = {
			Description = "한 방향으로 캐릭터의 최대 공격력 x6.6의 피해를 주는 얇은 혈사포를 발사합니다#내려놓거나 다시 주울 때마다 방향을 바꿀 수 있습니다.#내려놓은 상태에서도 동작합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "꼬마 뿔머리",
			QuoteDesc = "혈사 친구",
		},
		[FiendFolio.ITEM.ROCK.GRIMACE_ROCK7] = {
			Description = "캐릭터의 공격력의 눈물을 십자/X자 모양을 번갈아가면서 발사합니다.#내려놓은 상태에서도 동작합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "꼬마 십자머리",
			QuoteDesc = "십자 친구",
		},
		[FiendFolio.ITEM.ROCK.GRIMACE_ROCK8] = {
			Description = "적이 있는 방에서 캐릭터의 공격력 x0.66의 레이저를 회전하면서 계속 발사합니다.#내려놓은 상태에서도 동작합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "꼬마 눈알",
			QuoteDesc = "레이저 친구",
		},
		[FiendFolio.ITEM.ROCK.GRIMACE_ROCK9] = {
			Description = "주기적으로 방 안의 적 하나를 아군으로 복사합니다.#복사한 아군은 방을 이동하면 사라집니다.#내려놓은 상태에서도 동작합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "꼬마 가마솥",
			QuoteDesc = "마술 친구",
		},
		[FiendFolio.ITEM.ROCK.GRIMACE_ROCK10] = {
			Description = "픽업 아이템이 끌려옵니다.#내려놓은 상태에서도 동작합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "꼬마 구멍머리",
			QuoteDesc = "빨아들이는 친구",
		},
		[FiendFolio.ITEM.ROCK.GRIMACE_ROCK11] = {
			Description = "주변의 적에게 캐릭터의 공격력의 눈물을 세갈래로 발사합니다.#내려놓은 상태에서도 동작합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "꼬마 삼눈머리",
			QuoteDesc = "삼눈 친구",
		},
		[FiendFolio.ITEM.ROCK.GRIMACE_ROCK12] = {
			Description = "특정 이동키를 입력하는 동안 그 방향으로 캐릭터의 공격력의 눈물을 계속 발사합니다.#내려놓거나 다시 주울 때마다 방향을 바꿀 수 있습니다.#내려놓은 상태에서도 동작합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "꼬마 센서머리",
			QuoteDesc = "느낌가는 친구",
		},
		[FiendFolio.ITEM.ROCK.FOCUS_CRYSTAL] = {
			Description = "캐릭터와 {{ColorYellow}}2.5 타일{{CR}} 내에 있는 적은{{ColorYellow}}20%{{CR}}의 추가 피해를 받습니다. {{ColorGray}}(중첩 당 +20% 복리 증가).{{CR}}",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "집중의 돌",
			QuoteDesc = "가까운 적에게 추가 피해",
		},
		[FiendFolio.ITEM.ROCK.ODDLY_SMOOTH_STONE] = {
			Description = "{{BlendedHeart}} 하트류 픽업의 획득량이 반칸만큼 추가로 증가합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "부드러운 돌",
			QuoteDesc = "더 나은 체력",
		},
		[FiendFolio.ITEM.ROCK.MOONSTONE] = {
			Description = "소지한 상태에서 {{SecretRoom}}{{SuperSecretRoom}}비밀방 진입 시 아래 능력치 중 하나 증가:#{{TearsSmall}}/{{RangeSmall}}/{{ShotspeedSmall}}/{{LuckSmall}}",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "월석",
			QuoteDesc = "달님을 쳐다보라",
		},
		[FiendFolio.ITEM.ROCK.LIMESTONE] = {
			Description = "캐릭터가 지나간 자리에 초록 장판이 생기며 닿은 적은 초당 캐릭터의 공격력 x0.5의 피해를 입습니다.#감귤 타입의 적을 아군으로 만듭니다.#일부 몬스터가 특수하게 변경됩니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "라임석",
			QuoteDesc = "신 맛",
		},
		[FiendFolio.ITEM.ROCK.CARNAL_CARNELIAN] = {
			Description = "적과 가까울수록 {{DamageSmall}}공격력/{{SpeedSmall}}이동속도가 증가합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "카넬리안",
			QuoteDesc = "적과 가까울수록 강해진다",
		},
		[FiendFolio.ITEM.ROCK.REBAR_ROCK] = {
			Description = "#{{Heart}}{{ColorYellow}}빨간하트{{CR}} 피해를 25%의 확률로 무시하며 항상 반칸으로 줄여줍니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "철근석",
			QuoteDesc = "단단해진 빨간 하트",
		},
		[FiendFolio.ITEM.ROCK.STALACTITE] = {
			Description = "폭발성 피격 시 캐릭터의 공격력 x2의 피해를 주는 돌덩이 여러개가 랜덤 위치에 떨어집니다.#떨어지는 돌덩이에 피해를 입지 않습니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "종유석",
			QuoteDesc = "천장이 무너져",
		},
		[FiendFolio.ITEM.ROCK.CAST_GEM] = {
			Description = "공격 시 적을 향해 날아가는 유도 보석을 3개 획득합니다.#유도 보석이 적과 접촉 시 적에게 피해를 주며 {{ffBruise}}멍들게 합니다.#{{ffBruise}} 멍든 적은 해당 상태 중첩 수만큼 추가 피해를 받습니다.#일부 아이템과의 추가 시너지 존재#{{Collectible"..CollectibleType.COLLECTIBLE_NYX.."}} (Nyx의 보석과 동일)",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "주문 보석",
			QuoteDesc = "보석 친구",
		},
		[FiendFolio.ITEM.ROCK.SHARD_OF_GOLGOTHA] = {
			Description = "{{Collectible722}} 방 입장 시 최대 체력이 가장 많은 적을 5초간 움직이지 못하게 만듭니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "골고타 조각",
			QuoteDesc = "적 묶기",
		},
		[FiendFolio.ITEM.ROCK.SMOKY_QUARTZ] = {
			Description = "{{Confusion}} 피격 시 주변의 적에게 혼란을 겁니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "연기나는 쿼츠",
			QuoteDesc = "맞으면 연기를 뿜다",
		},
		[FiendFolio.ITEM.ROCK.TWINKLING_ROCK] = {
			Description = "{{ffGrind}} 채굴기로 이 장신구 소모 시 {{ColorTeal}}정동석{{CR}} 타입의 석기 장신구로 바뀝니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "빛나는 돌",
			QuoteDesc = "정동석 채굴",
		},
		[FiendFolio.ITEM.ROCK.ROCK_CAKE] = {
			Description = "{{ffGrind}} 채굴기 사용 시 {{HalfHeart}}빨간하트를 반칸 회복합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "돌 케이크",
			QuoteDesc = "채굴 회복",
		},
		[FiendFolio.ITEM.ROCK.CHARCOAL] = {
			Description = "{{Collectible132}} 확률적으로 탄속이 느리지만 공격이 멀리 나갈수록 공격력이 증가하는 눈물을 발사합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "숯덩이",
			QuoteDesc = "크람푸스의 석탄을 베낀 것",
		},
		[FiendFolio.ITEM.ROCK.KNIFE_PEBBLE] = {
			Description = "↑ {{DamageSmall}}공격력 +1.25",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "칼모양 조약돌",
			QuoteDesc = "공격력 증가",
		},
		[FiendFolio.ITEM.ROCK.TEARDROP_PEBBLE] = {
			Description = "↑ {{TearsSmall}}공격 딜레이 -2(연사 증가)",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "물방울 조약돌",
			QuoteDesc = "연사 증가",
		},
		[FiendFolio.ITEM.ROCK.ARROW_PEBBLE] = {
			Description = "↑ {{RangeSmall}}사거리 +1.25#↑ {{ShotspeedSmall}}탄속 +0.2",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "활 조약돌",
			QuoteDesc = "사거리, 탄속 증가",
		},
		[FiendFolio.ITEM.ROCK.CLOVER_PEBBLE] = {
			Description = "↑ {{LuckSmall}}행운 +2",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "클로버 조약돌",
			QuoteDesc = "행운 증가",
		},
		[FiendFolio.ITEM.ROCK.SHOE_PEBBLE] = {
			Description = "↑ {{SpeedSmall}}이동속도 +0.3",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "신발 조약돌",
			QuoteDesc = "이동속도 증가",
		},
		[FiendFolio.ITEM.ROCK.FRUITY_PEBBLE] = {
			Description = "↑ {{SpeedSmall}}이동속도 +0.15#↑ {{DamageSmall}}공격력 +0.3#↑ {{TearsSmall}}공격 딜레이 -0.7(연사 증가)#↑ {{RangeSmall}}사거리 +0.75#↑ {{ShotspeedSmall}}탄속 +0.18#↑ {{LuckSmall}}행운 +1",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "과일 조약돌",
			QuoteDesc = "모든 능력치 증가",
		},
		[FiendFolio.ITEM.ROCK.ACHILLES_ROCK] = {
			Description = "적에게 랜덤 방향으로 급소가 생깁니다.#급소 명중 시 1.5배의 피해를 받습니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "아킬레스석",
			QuoteDesc = "약점 찾기",
		},
		[FiendFolio.ITEM.ROCK.ELECTRUM] = {
			Description = "액티브 아이템 사용 시 전류를 발산하여 주변의 적에게 캐릭터의 공격력 및 액티브 아이템 충전량에 비례한 피해를 줍니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "엘렉트륨",
			QuoteDesc = "액티브 전류 발산",
		},
		[FiendFolio.ITEM.ROCK.PURE_QUARTZ] = {
			Description = "피격 시 소울하트가 없으면 10초간 무적 상태가 되며 {{HolyMantleSmall}} 피격 시 피해를 1회 무시하는 보호막을 제공합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "순수한 쿼츠",
			QuoteDesc = "영혼을 바친 보호막",
		},
		[FiendFolio.ITEM.ROCK.AMAZONITE] = {
			Description = "스테이지에서 가장 먼저 줍는 픽업은 1{{Coin}}으로 구매해야 되며 구매 시 사라집니다.#사라진 픽업은 다음 스테이지 진입 시 소환됩니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "천하석",
			QuoteDesc = "배송기간이 있어",
		},
		[FiendFolio.ITEM.ROCK.STAR_SAPPHIRE] = {
			Description = "가장 가까운 적 및 탄환을 바라보는 방향에서 앞뒤로 움직입니다.#탄환을 막으면서 접촉하는 적에게 초당 공격력 x1.5의 피해를 입힙니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "별모양 사파이어",
			QuoteDesc = "이동 탐지기",
		},
		[FiendFolio.ITEM.ROCK.GRAVESTONE] = {
			Description = "피격 시 혹은 장애물을 부술 시 {{Collectible634}}Purgatory 혹은 {{Collectible684}}Hungry Soul의 유령을 소환합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "묘비",
			QuoteDesc = "무서운 신성 모독",
		},
		[FiendFolio.ITEM.ROCK.SAND_CASTLE] = {
			Description = "피격을 3회 무효화하며 3회 피격 시 {{Trinket"..FiendFolio.ITEM.ROCK.POCKET_SAND.."}}Pocket Sand로 바뀝니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "모래성",
			QuoteDesc = "약한 방패",
		},
		[FiendFolio.ITEM.ROCK.DAMAGED_SAND_CASTLE] = {
			Description = "피격을 2회 무효화하며 3회 피격 시 {{Trinket"..FiendFolio.ITEM.ROCK.POCKET_SAND.."}}Pocket Sand로 바뀝니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "모래성",
			QuoteDesc = "약한 방패",
		},
		[FiendFolio.ITEM.ROCK.BROKEN_SAND_CASTLE] = {
			Description = "피격을 1회 무효화하며 3회 피격 시 {{Trinket"..FiendFolio.ITEM.ROCK.POCKET_SAND.."}}Pocket Sand로 바뀝니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "모래성",
			QuoteDesc = "약한 방패",
		},
		[FiendFolio.ITEM.ROCK.GUARDED_GARNET] = {
			Description = "피격 시 그 방에서 확률적으로 피해를 1회 막아주는 붉은 보호막을 생성합니다.#붉은 보호막 파괴 시 주변의 적을 밀쳐냅니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "보호의 가넷",
			QuoteDesc = "맞으면 보호막",
		},
		[FiendFolio.ITEM.ROCK.SHAMROCK] = {
			Description = "↑ {{LuckSmall}}행운 +4#피격 시 그 스테이지에서 {{LuckSmall}}행운 -1",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "행운석",
			QuoteDesc = "연약한 행운 증가",
		},
		[FiendFolio.ITEM.ROCK.GAS_POCKET] = {
			Description = "주기적으로 랜덤 장애물 주변에 작은 독가스가 생깁니다.#{{Poison}} 장애물 파괴 시 커다란 독가스가 생깁니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "가스 주머니",
			QuoteDesc = "유독성 돌덩이",
		},
		[FiendFolio.ITEM.ROCK.SOAP_STONE] = {
			Description = "피격 시 그 방의 탄환을 모두 지우며 적의 탄환을 막아주는 방울을 소환합니다.#방 클리어 시 그 방의 탄환을 모두 지웁니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "굳은 비누",
			QuoteDesc = "방 클리어 마무리",
		},
		[FiendFolio.ITEM.ROCK.SPIRIT_URN] = {
			Description = "{{BossRoom}}보스방/미니보스방/{{ChallengeRoom}}도전방 시작 시 {{Collectible584}}Book of Virtues의 불꽃을 3마리 소환합니다..",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "영혼 항아리",
			QuoteDesc = "위험할 때 영혼 소환",
		},
		[FiendFolio.ITEM.ROCK.SUN_SHARD] = {
			Description = "캐릭터의 주위를 돌며 적의 탄환을 막아줍니다.#적의 탄환을 막으면 잠시동안 회전 속도가 빨라지며 그 자리에 주기적으로 핏방울과 빨간 장판을 남깁니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "태양 조각",
			QuoteDesc = "당신만의 태양계",
		},
		[FiendFolio.ITEM.ROCK.STEADFAST_STONE] = {
			Description = "!!! 일회용#피격 시 남은 체력이 없을 경우 피격을 무효화하고 장신구를 파괴합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "확고한 돌",
			QuoteDesc = "최후의 수단",
		},
		[FiendFolio.ITEM.ROCK.RAI_STONE] = {
			Description = "적 처치 시 15%의 확률로 {{Coin}}잠시 후 사라지는 동전을 드랍합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "라이 석화",
			QuoteDesc = "마몬의 선물",
		},
		[FiendFolio.ITEM.ROCK.ORE_PENNY] = {
			Description = "{{Trinket52}} 동전 획득 시 50% 확률로 {{Coin}}동전을 하나 더 얻습니다.#장애물을 확률적으로 금광석으로 바꿉니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "금광 페니",
			QuoteDesc = "금광 부자",
		},
		[FiendFolio.ITEM.ROCK.HEAVY_METAL] = {
			Description = "↓ {{SpeedSmall}}이동속도 -0.15#이동속도에 반비례하여 {{DamageSmall}}공격력이 증가합니다.#확률적으로 피격을 무효화하며 이동속도가 느릴수록 확률이 증가합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "무거운 메탈",
			QuoteDesc = "이동속도 감소, 공격력 증가",
		},
		[FiendFolio.ITEM.ROCK.GROSSULAR] = {
			Description = "클리어하지 않은 방에서 주기적으로 주변의 적에게 공포, 혼란, 독 중 하나를 거는 파동을 발산합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "그로설라",
			QuoteDesc = "역겨운 걸 발산",
		},
		[FiendFolio.ITEM.ROCK.SULFUR_CRYSTAL] = {
			Description = "{{Collectible118}} 4번째 방마다 그 방에서 혈사포를 발사합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "황산 보석",
			QuoteDesc = "일시적 강력함",
		},
		[FiendFolio.ITEM.ROCK.TROLLITE] = {
			Description = "!!! 채굴기로 이 장신구 소모 시 채굴기가 폭발합니다.#!!! 분해 시 트롤폭탄을 드랍합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "트롤라이트",
			QuoteDesc = "딱 한번만이야...",
		},
		[FiendFolio.ITEM.ROCK.THROWLOMITE] = {
			Description = "주기적으로 가장 가까운 적에게 돌덩이를 던집니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "쓰로마이트",
			QuoteDesc = "돌멩이 던지기",
		},
		[FiendFolio.ITEM.ROCK.HEARTHSTONE] = {
			Description = "{{Card}} 카드 사용 시 랜덤 긍정 효과를 발동합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "하스스톤",
			QuoteDesc = "무작위 카드 효과",
		},
		[FiendFolio.ITEM.ROCK.MAGNETIC_SAND] = {
			Description = "↑ {{TearsSmall}}연사 +0.45#↓ {{DamageSmall}}공격력 -0.35#{{Magnetize}} 확룰적으로 맞은 적에게 자력 효과가 부여되는 공격이 나갑니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "자기 모래",
			QuoteDesc = "연사 증가 + 자석 눈물",
		},
		[FiendFolio.ITEM.ROCK.INSATIABLE_APATITE] = {
			Description = "하트류 픽업 획득 시 {{DamageSmall}}서서히 감소하는 공격력이 증가합니다.#체력이 꽉 찼을 경우 {{DamageSmall}}공격력 추가 증가",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "배고픈 인회석",
			QuoteDesc = "하트를 먹여주면 공격력 증가",
		},
		[FiendFolio.ITEM.ROCK.POWER_ROCK] = {
			Description = "장애물 파괴 시 확률적으로 액티브 아이템의 충전량을 1칸 충전합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "충전된 돌",
			QuoteDesc = "굳은 충전",
		},
		[FiendFolio.ITEM.ROCK.TIGERS_EYE] = {
			Description = "대각선으로 이동하며 벽과 부딪힐 시 적을 향해 반사됩니다.#탄환을 막으며 접촉하는 적에게 캐릭터 공격력 x0.66의 피해를 줍니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "호랑이의 눈",
			QuoteDesc = "수호자의 시선",
		},
		[FiendFolio.ITEM.ROCK.SMALLER_ROCK] = {
			Description = "색돌 파괴 시 {{SpeedSmall}}이동속도 -0.06, {{DamageSmall}}공격력 +0.33.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "더 작은 돌",
			QuoteDesc = "색돌을 찾아라",
		},
		[FiendFolio.ITEM.ROCK.NITRO_CRYSTAL] = {
			Description = "{{Coin}}동전을 주울 시 니트로를 잠시동안 활성화합니다.#니트로가 활성화되어 있는 동안 {{SpeedSmall}}이동속도/{{TearsSmall}}연사가 증가합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "니트로 보석",
			QuoteDesc = "돈을 써서 보너스 획득",
		},
		[FiendFolio.ITEM.ROCK.SHARD_OF_GOLEM] = {
			Description = "초과 회복 시 특수 게이지를 채웁니다.#특수 게이지 완충 시 소지 중인 장신구를 전부 흡수합니다.#특수 게이지 1칸 당 {{DamageSmall}}공격력 +0.45",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "골렘의 조각",
			QuoteDesc = "골렘의 선물",
		},
		[FiendFolio.ITEM.ROCK.ROCK_WORM] = {
			Description = "↑ {{TearsSmall}}연사 +0.4#↑ {{DamageSmall}}공격력 +0.4#스테이지 진입 시 그 스테이지에서 랜덤 벌레 장신구 효과를 얻습니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "돌멩이 벌레",
			QuoteDesc = "웅가붕가",
		},
		[FiendFolio.ITEM.ROCK.FOOLS_UNOBTAINIUM] = {
			Description = "!!! 획득불가.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "",
			QuoteDesc = "",
		},
		[FiendFolio.ITEM.ROCK.MINICHIBISIDIAN] = {
			Description = "적이 확률적으로 Bony로 바뀝니다.#바뀐 Bony는 바뀌기 전의 체력을 따릅니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "",
			QuoteDesc = "뼈다귀 교체술",
		},
		[FiendFolio.ITEM.ROCK.FRIENDLY_RAPID_FIRE_OPAL] = {
			Description = "방 입장 시 12발의 총알이 제공되며 총알이 남아있는 동안 라이플을 난사할 수 있습니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "난사 장난감 오팔",
			QuoteDesc = "완전 자동, 장전 완료!",
		},
		[FiendFolio.ITEM.ROCK.HIDDENITE] = {
			Description = "!!! 획득불가.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "",
			QuoteDesc = "",
		},

		[FiendFolio.ITEM.ROCK.POCKET_ROCKIT] = {
			--Description = "Chance to fire a rocket tear that homes in on enemies#Rockets shoot low damage tears when close to enemies#Rockets pop into a tear pattern on impact, depending on its color.",
			Description = "공격 시 10%의 확률로 로켓을 발사합니다.#{{LuckSmall}} :행운 10+일 때 25%#로켓이 무언가에 부딪힌 위치에 8방향으로 특정 패턴의 눈물을 발사합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "포켓 로켓",
			QuoteDesc = "로켓 사이언스",
		},

		[FiendFolio.ITEM.ROCK.WORMHOLE_ROCK] = {
			--Description = "Spawns two wormholes#Tears and projectiles that enter a portal will emerge from the other, aimed towards enemies and sometimes gaining additional effects#The wormholes will occasionally burst into tears and change positions.",
			Description = "방 입장 시 특수 포탈을 2개 소환합니다.#포탈 공격 시 다른 포탈에서 적을 향해 공격력 x1.5의 랜덤 효과의 공격으로 나갑니다.#주기적으로 포탈의 위치가 바뀝니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "웜홀석",
			QuoteDesc = "오, 웜홀?",
		},

		[FiendFolio.ITEM.ROCK.ATLAS_BURDEN] = {
			--Description = "↓0.4 speed down#Dealing damage to enemies has a chance to drop a boulder onto them, slowing them down and periodically doing heavy damage.",
			Description = "↓ {{SpeedSmall}}이동속도 -0.4#적 명중 시 최대 25%의 확률로 적에게 하늘을 떠받치게 하며 즉사, 보스의 경우 {{Slow}}둔화 + 주기적으로 공격력 x4의 피해를 줍니다.#{{LuckSmall}} :행운 2.5+일 때 50%, 하늘을 떠받친 적 수에 반비례",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "아틀라스의 부담",
			QuoteDesc = "다른 놈들한테 넘겨",
		},

		[FiendFolio.ITEM.ROCK.ARACHNITE] = {
			--Description = "Blue spiders are replaced with friendly rock spiders#Chance to replace with tinted or coal rock spiders.",
			Description = "모든 아군 자폭 파리가 아군 Rock Spider로 바뀝니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "아라크나이트",
			QuoteDesc = "돌 속에서의 몸부림",
		},

		[FiendFolio.ITEM.ROCK.HOMOEROTIC_RUBY] = {
			--Description = "Chance to fire flaming tears that inflict burn.#Women periodically have a chance to go berserk.",
			Description = "{{Burning}} 공격 시 10%의 확률로 적에게 화상을 입히는 공격이 나갑니다.#{{LuckSmall}} :행운 8+일 때 50%#{{ffBerserk}} 암컷 적의 경우 확률적으로 폭주 상태가 됩니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL,ffStatusEffectDesc.BERSERK},
			Name = "호모 루비",
			QuoteDesc = "열정적이야, 베이베!",
		},

		[FiendFolio.ITEM.ROCK.GAY_GARNET] = {
			--Description = "Chance to fire freezing flames.#Women periodically have a chance to go berserk.#Women start out charmed.",
			Description = "{{Freezing}} 15%의 확률로 처치시 적을 얼리는 불꽃을 날립니다#{{LuckSmall}} :행운 7+일 때 50%#{{ffBerserk}} 암컷 적의 경우 등장 시 10초동안 {{Charm}}매혹에 걸리며 확률적으로 폭주 상태가 됩니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL,ffStatusEffectDesc.BERSERK},
			Name = "게이 가넷",
			QuoteDesc = "교미",
		},

		[FiendFolio.ITEM.ROCK.LITHOPEDIAN] = {
			--Description = "Grants a Stoney Gaper familiar that pushes enemies around and blocks shots.",
			Description = "적을 추적 후 밀쳐내며 적의 탄환을 막아주는 패밀리어를 소환합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "리소페디안",
			QuoteDesc = "당신만의 스토니",
		},

		[FiendFolio.ITEM.ROCK.JESUS_ROCK] = {
			Description = "!!! 일회용#사망 시 그 방에서 체력 6칸으로 부활합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "예수석",
			QuoteDesc = "죽음으로부터의 부활",
		},

		[FiendFolio.ITEM.ROCK.LOST_ARTIFACT] = {
			--Description = "Upon clearing rooms, spawns a random amount of fairy fly familiars#Fairy flies deal contact damage to enemies, and die after some time#Little fairy flies periodically fire player tears#Round fairy flies explode into a ring of player tears on-death#Big fairy flies divebomb on-death, causing a giga bomb explosion and firing a large ring of player tears.",
			Description = "방 클리어 시 적과 접촉 시 피해를 주는 요정 파리가 옵니다.#소형 : 주기적으로 캐릭터의 눈물을 발사합니다.#중형 : 터질 때 8방향으로 캐릭터의 눈물을 발사합니다.#대형 : 터질 때 기가 폭발을 일으키며 8방향으로 캐릭터의 눈물을 발사합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "잊혀진 유물",
			QuoteDesc = "냥냥 요정",
		},

		[FiendFolio.ITEM.ROCK.RIDICULOUS_METAL] = {
			Description = "방 입장 시 적이 있는 경우 미니 리듬게임을 시작합니다.#정확한 타이밍에 공격 시 적 전체에게 피해를 줍니다.#연속 성공 시 피해량이 증가합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "익살스러운 메탈",
			QuoteDesc = "리듬의 보상",
		},

		[FiendFolio.ITEM.ROCK.TOP_ROCK] = {
			Description = "↑ 모든 능력치 증가#소지 중일 때 능력치가 상승하지 않습니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
			Name = "꼭대기 돌덩이",
			QuoteDesc = "이제 내려갈 일만 남았어",
		},

		[FiendFolio.ITEM.ROCK.BREAKFAST_FOSSIL] = {
			Description = "{{ffCrush}} 분해 시 {{Heart}}최대 체력 +1",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "아침밥 화석",
			QuoteDesc = "체력 증가 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.SACK_FOSSIL] = {
			Description = "{{GrabBag}} 픽업 아이템을 일정 확률로 픽업 자루로 바꿉니다.#{{ffCrush}} 분해 시 픽업 자루를 추가로 소환합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "자루 화석",
			QuoteDesc = "더 많은 자루 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.COPROLITE_FOSSIL] = {
			Description = "방 최초 입장 시 파란 아군 자폭 파리를 하나 소환합니다.#{{ffCrush}} 분해 시 파란 아군 자폭 파리를 12마리 소환합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "코프롤라이트",
			QuoteDesc = "똥 아티팩트 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.BEETER_FOSSIL] = {
			Description = "눈물을 발사할 때마다 다른 방향으로 공격력 x0.4의 눈물을 발사합니다.#눈물은 시계방향으로 서서히 돌아가면서 발사됩니다.#{{ffCrush}} 분해 시 아군 Beeter롤 소환합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "벌꿀 화석",
			QuoteDesc = "벌꿀맛 호박 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.FLY_FOSSIL] = {
			Description = "방 최초 입장 시 랜덤 색상의 아군 자폭 파리를 하나 소환합니다.#{{ffCrush}} 분해 시 적의 탄환을 막아주는 파리 한마리를 얻습니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "파리 화석",
			QuoteDesc = "영원한 친구 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.GMO_FOSSIL] = {
			Description = "{{Pill}} 보스 처치 시 랜덤 알약 2개를 강제로 사용합니다.#{{ffCrush}} 분해 시 랜덤 알약 3개를 강제로 사용합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "GMO 화석",
			QuoteDesc = "보스의 알약 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.SWORD_FOSSIL] = {
			Description = "↑ {{DamageSmall}}공격력 +0.3#↑ {{TearsSmall}}공격 딜레이 -1(연사 증가)#↑ {{RangeSmall}}사거리 +0.75#↑ {{ShotspeedSmall}}탄속 +0.2#{{ffCrush}} 분해 시 능력치 상승량의 절반만큼 영구적으로 증가합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "검의 화석",
			QuoteDesc = "모든 능력치 증가 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.FORTUNE_WORM_FOSSIL] = {
			Description = "↑ {{ShotspeedSmall}}탄속 +0.2#↑ {{LuckSmall}}행운 +2#{{Trinket"..FiendFolio.ITEM.TRINKET.FORTUNE_WORM.."}} 확률적으로({{LuckSmall}}) 적에게 명중 시 운세를 보여주는 공격력 x1.05의 포춘쿠키를 발사합니다.#{{ffCrush}} 분해 시 {{SoulHeart}}소울하트를 추가로 드랍하며 랜덤 운세 3개를 보여줍니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "운세 화석",
			QuoteDesc = "과거에서의 미래 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.PRIMORDIAL_FOSSIL] = {
			Description = "{{Collectible317}} 6.66%의 확률로 여러 개의 독성 눈물을 흩뿌리면서 발사합니다.#{{ffCrush}} 분해 시 Golem 캐릭터의 시작 장신구를 추가로 드랍합니다. ({{Trinket"..FiendFolio.ITEM.ROCK.DIRT_CLUMP.."}} + {{Trinket"..FiendFolio.ITEM.ROCK.ROLLING_ROCK.."}})",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "원시 화석",
			QuoteDesc = "초보자 키트 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.REROLLIGAN_FOSSIL] = {
			Description = "{{Collectible285}} 적 명중 시 확률적으로 다른 적으로 바꿉니다.#{{ffCrush}} 분해 시 랜덤 유리 주사위 조각을 추가로 드랍합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "주사위 화석",
			QuoteDesc = "적을 바꾸는 공격 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.FOSSILIZED_FOSSIL] = {
			Description = "소지한 상태에서 다른 화석 타입 장신구 분해시 효과 2배#{{ffCrush}} 분해 시 소지 중인 다른 화석 타입 장신구의 분해 효과를 발동합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "비옥한 화석",
			QuoteDesc = "화석 복제 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.FISH_FOSSIL] = {
			Description = "피격 시 파란 아군 자폭 파리를 1~4마리 소환합니다.#{{ffCrush}} 분해 시 아군 Portal 몬스터를 추가로 소환합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "생선 화석",
			QuoteDesc = "쓰레기의 왕 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.RUNIC_FOSSIL] = {
			Description = "{{Rune}} 룬의 등장 확률이 증가합니다.#{{Rune}}룬 사용 시 {{Card55}}Rune Shard를 드랍합니다.#{{ffCrush}} 분해 시 {{Card55}}Rune Shard 4개를 추가로 드랍합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "룬 화석",
			QuoteDesc = "연약한 룬 + 분해 보너스",
		}, -- Rune Fossil : Does not change trinkets into runes, only non-rock trinkets
		[FiendFolio.ITEM.ROCK.CANNED_FOSSIL] = {
			Description = "피격 시 적을 밀쳐내는 랜덤 방귀를 뀝니다.#{{ffCrush}} 분해 시 아군 Litter bug를 추가로 소환합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "취한 화석",
			QuoteDesc = "콩의 위력 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.BALANCED_FOSSIL] = {
			Description = "{{Heart}}/{{Coin}}/{{Key}}/{{Bomb}}의 개수가 적은 경우 방 클리어 보상을 50%의 확률로 {{Heart}}/{{Coin}}/{{Key}}/{{Bomb}}로 바꿉니다.#{{ffCrush}} 분해 시 가장 적게 소지중인 픽업 아이템 3개를 추가로 드랍합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "균형의 화석",
			QuoteDesc = "균형의 방 보상 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.BURIED_FOSSIL] = {
			Description = "스테이지 당 하나씩 바닥에 틈새가 생기고 그 틈새를 {{Bomb}}폭탄으로 터트릴 시 화석 장신구를 드랍합니다.#Dark Room 스테이지의 무덤을 {{Bomb}}폭탄으로 열 수 있습니다.#{{ffCrush}} 분해 시 랜덤 화석 장신구를 추가로 드랍합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "묻혀있는 화석",
			QuoteDesc = "땅을 파 봐 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.TRIPPY_FOSSIL] = {
			Description = "{{Collectible398}} 확률적으로 적을 작아지게 만드는 공격이 나갑니다.#{{ffCrush}} 분해 시 캐릭터의 크기가 작아집니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "환각 화석",
			QuoteDesc = "허 우워... + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.MAXS_FOSSIL] = {
			Description = "{{Collectible445}} {{SecretRoom}}{{SuperSecretRoom}}비밀방이 연결되어 있을 경우 개 울음소리가 납니다.#{{ffCrush}} 분해 시 이후에 등장하는 색돌 하나가 밝혀집니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "맥스의 화석",
			QuoteDesc = "개 울음소리 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.BOMB_SACK_FOSSIL] = {
			Description = "{{Bomb}}폭탄이 터지면 폭탄 주위에 충격파를 일으킵니다.#{{ffCrush}} 분해 시 {{Bomb}}폭탄 5개를 추가로 드랍합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "폭탄자루 화석",
			QuoteDesc = "지진파 폭발 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.DEATH_CAP_FOSSIL] = {
			Description = "↓ 방 입장시 마다 모든 능력치가 감소합니다.#{{ffCrush}} 분해 시 감소량만큼 능력치가 영구적으로 증가합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "똥모자 화석",
			QuoteDesc = "아직 효력이 있어 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.EXPLOSIVE_FOSSIL] = {
			Description = "{{Bomb}} 방 클리어 시 확률적으로 폭탄을 추가로 드랍합니다.#장애물이 일정 확률로 폭탄 돌덩이로 바뀝니다.#{{ffCrush}} 분해 시 이후 클리어하지 않은 3개의 방에 {{Collectible483}}Mama Mega의 폭발을 일으킵니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "폭발성 화석",
			QuoteDesc = "더 많은 폭탄 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.COLOSSAL_FOSSIL] = {
			Description = "눈물 크기 x2#{{ffCrush}} 분해 시 3개의 랜덤 화석 장신구 효과를 발동합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "거대 화석",
			QuoteDesc = "여러 개의 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.SKUZZ_FOSSIL] = {
			Description = "방 입장 시 적을 {{Slow}}느려지게 하는 보라색 아군 벼룩을 2~3마리 소환합니다.#{{ffCrush}} 분해 시 파란 아군 자폭 벼룩을 5~7마리 소환합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "벼룩 화석",
			QuoteDesc = "영원한 친구 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.FOSSILIZED_BLESSING] = {
			Description = "↑ {{TearsSmall}}연사 +0.4#{{ffCrush}} 분해 시 다음 게임 시작 시 랜덤 석기 장신구를 하나 드랍합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "골렘의 축복",
			QuoteDesc = "에덴의 축복 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.PETRIFIED_SOCK] = {
			Description = "확률적으로 적을 석화시키는 눈물이 나갑니다.#{{ffCrush}} 분해 시 {{Card92}}랜덤 패밀리어를 획득합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "굳은 양말",
			QuoteDesc = "딱딱한 눈물 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.MOLTEN_FOSSIL] = {
			Description = "흡수한 정동석의 효과를 강화시킵니다.#{{ffCrush}} 분해 시 랜덤 석기 장신구를 흡수합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "녹아내리는 화석",
			QuoteDesc = "녹아내린 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.VALUE_FOSSIL] = {
			Description = "{{Shop}}상점의 판매 가격을 1{{Coin}} 할인합니다.#{{ffCrush}} 분해 시 {{Coin}}동전 3개를 추가로 드랍합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "가치있는 화석",
			QuoteDesc = "상점 할인 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.CORAL_FOSSIL] = {
			Description = "↑ {{Heart}}빨간하트 +1#공격 시 확률적으로 X자 방향의 눈물을 추가로 발사합니다.#{{ffCrush}} 분해 시 {{Heart}}빨간하트 +1, 아군 Drowned charger 3마리를 추가로 소환합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "코랄 화석",
			QuoteDesc = "뭔가 물에 찬 느낌 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.NECROMANTIC_FOSSIL] = {
			Description = "적 처치 시 확률적으로 캐릭터의 주위를 도는 뼛조각을 소환합니다.#{{ffCrush}} 분해 시 현재 게임에서 분해했던 석기 장신구를 추가로 소환합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "네크로 화석",
			QuoteDesc = "죽음으로부터 되돌려라 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.BRAIN_FOSSIL] = {
			Description = "공격이 잠시동안 적에게 유도됩니다.#{{ffCrush}} 분해 시 The Magician 카드를 추가로 소환합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "두뇌 화석",
			QuoteDesc = "잠깐동안의 유도 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.REFUND_FOSSIL] = {
			Description = "다른 화석 분해 시 {{Trinket"..FiendFolio.ITEM.ROCK.POCKET_SAND.."}}Pocket Sand를 소환합니다.#채굴기로 {{Trinket"..FiendFolio.ITEM.ROCK.POCKET_SAND.."}}Pocket Sand 채굴 시 {{Coin}}을 소모하지 않습니다.#{{ffCrush}} 분해 시 {{Trinket"..FiendFolio.ITEM.ROCK.POCKET_SAND.."}}Pocket Sand 2개를 추가로 소환합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "흥정 화석",
			QuoteDesc = "모래 채굴 무료 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.LEFT_FOSSIL] = {
			Description = "{{Trinket61}} 모든 상자가 {{RedChest}}빨간상자로 교체됩니다.#{{ffCrush}} 분해 시 {{RedChest}}빨간상자를 추가로 소환합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "왼손목 화석",
			QuoteDesc = "어둠의 보상을 거두어들이다 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.THANK_YOU_FOSSIL] = {
			Description = "거지가 픽업을 2배로 보답합니다.#!!! (패시브/액티브 보상은 미적용)#{{ffCrush}} 분해 시 Judgement 카드를 추가로 소환합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "감사의 화석",
			QuoteDesc = "풍성한 거지 + 분해 보너스",
		},
		[FiendFolio.ITEM.ROCK.HOLLOW_FOSSIL] = {
			--Description = "↑ +1.35 damage#{{ffCrush}} Guarantees a deal room and spawns a black heart instead of a soul heart when crushed.",
			Description = "↑ {{DamageSmall}}공격력 +1.35#{{ffCrush}} 분해 시 소울하트 대신 {{BlackHeart}}블랙하트가 나오며 그 스테이지에서 악마방 확률을 100%로 고정해 줍니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_FOSSIL},
			Name = "공허의 화석",
			QuoteDesc = "암흑의 기운이 담겨 있어 + 분해 보너스",
		},

		[FiendFolio.ITEM.ROCK.CURVED_GEODE] = {
			Description = "↑ {{DamageSmall}}공격력 +1#↑ 다른 정동석 소지 시 {{DamageSmall}}추가 공격력 +0.5",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "굽은 정동",
			QuoteDesc = "공격력 증가 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.HAUNTED_GEODE] = {
			Description = "확률적으로({{LuckSmall}}) 적과 장애물을 관통하는 눈물을 발사합니다.#다른 정동석 소지 시 확률 증가",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "공포의 정동",
			QuoteDesc = "유령 공격 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.HEALTH_GEODE] = {
			Description = "!!! 일회용#전체 체력이 빨간하트 1칸 이하일 때 {{Heart}}체력을 전부 회복합니다.#!!! 최대 체력이 1칸일 경우 빨간하트 반칸일 때 발동#다른 정동석 소지 시 {{SoulHeart}}소울하트를 추가로 획득합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "체력의 정동",
			QuoteDesc = "두번째 기회 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.LITTLE_GEODE] = {
			Description = "캐릭터의 크기가 작아집니다.#다른 정동석 소지 시 추가로 작아집니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "작은 정동",
			QuoteDesc = "크기 감소 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.QUICK_GEODE] = {
			Description = "↑ 클리어한 방에서 {{SpeedSmall}}이동속도가 최소 1.75 이상으로 고정됩니다.#다른 정동석 소지 시 {{SpeedSmall}}고정 이동속도 +0.1",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "신속의 정동",
			QuoteDesc = "재빠른 탐색 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.WEBBY_GEODE] = {
			Description = "확률적으로(20% + 2x{{LuckSmall}}%p) {{Slow}}적을 둔화시키는 눈물을 발사합니다.#다른 정동석 소지 시 둔화 눈물로 적을 맞추면 적을 느리게 하는 흰색 장판을 생성합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "거미 정동",
			QuoteDesc = "둔화 공격 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.LUCKY_GEODE] = {
			Description = "↑ {{LuckSmall}}행운 +1#↑ 다른 정동석 소지 시 {{LuckSmall}}추가 행운 +2",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "행운의 정동",
			QuoteDesc = "행운 증가 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.PHLEGMY_GEODE] = {
			Description = "확률적으로(10% + {{LuckSmall}}%p) 접착 눈물이 나가며 접착 눈물이 적에게 붙을 시 10초동안 지속 피해를 입힙니다.#다른 정동석 소지 시 접촉 눈물이 {{Slow}}적을 둔화시킵니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "가래 정동",
			QuoteDesc = "접착 공격 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.LOB_GEODE] = {
			Description = "↑ {{RangeSmall}}사거리 +6#↑ 다른 정동석 소지 시 {{RangeSmall}}추가 사거리 +3#눈물을 곡선형으로 발사합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "로브 정동",
			QuoteDesc = "공성 공격 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.SODALITE_GEODE] = {
			Description = "확률적으로({{LuckSmall}}) 공격력 x5의 피해를 주는 치명타 눈물을 발사합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "소달라이트",
			QuoteDesc = "치명타 공격 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.PLACEBEODE] = {
			Description = "무효과#흡수 시 추가 정동석 소지 효과를 받습니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "위약 정동",
			QuoteDesc = "흡수 시 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.WARM_GEODE] = {
			Description = "캐릭터가 불 주변에 있는 동안 {{DamageSmall}}공격력/{{ShotspeedSmall}}탄속 증가#다른 정동석 소지 시 캐릭터가 불 주변에 있는 동안 {{Burning}}적에게 화상을 입히는 눈물을 발사합니다.#따뜻한 스테이지에서는 위 효과가 항상 발동합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "따뜻한 정동",
			QuoteDesc = "불의 힘 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.CHAIN_GEODE] = {
			Description = "장애물 파괴 시 40%의 확률로 인접한 장애물을 파괴합니다.#다른 정동석 소지 시 확률이 70%로 증가하며 추가로 20%의 확률로 인접한 구덩이를 메웁니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "연쇄 정동",
			QuoteDesc = "연쇄적 장애물 파괴 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.RUSTY_GEODE] = {
			Description = "↑ {{DamageSmall}}서서히 감소하는 공격력 +8#다른 정동석 소지 시 공격력 감소 속도가 느려집니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "녹슨 정동",
			QuoteDesc = "식어가는 욕망 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.FRAGMENTED_ONYX_GEODE] = {
			Description = "10%의 확률로 적을 {{Fear}}도망가게 하는 공격이 나갑니다.#다른 정동석 소지 시 확률이 15%로 증가하며 {{Fear}}공포 상태의 적에게 현재 악마방 확률에 비례한 추가 피해를 줍니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "오닉스 조각",
			QuoteDesc = "공포 공격 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.QUANTUM_GEODE] = {
			Description = "눈물이 3갈래로 나가며 하나를 명중시키면 나머지는 사라집니다.#다른 정동석 소지 시 두개를 명중시키면 나머지는 사라집니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "양자 정동",
			QuoteDesc = "혼란스러운 공격 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.TECHNOLOGICAL_GEODE] = {
			Description = "공격방향으로 캐릭터의 공격력 x0.3의 매우 짧은 레이저를 발사합니다.#다른 정동석 소지 시 레이저를 2개 동시에 발사합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "기계 정동",
			QuoteDesc = "주변 레이저 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.RUBBER_GEODE] = {
			Description = "확률적으로 튕겨져 나가며 {{ffBruise}}적을 멍들게 하고 강하게 밀쳐내는 테니스공을 발사합니다.#다른 정동석 소지 시 테니스공 발사 확률 및 밀쳐내는 강도와 탄속이 추가로 증가합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "고무 정동",
			QuoteDesc = "통통 튀는 눈물 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.CALZONE_GEODE] = {
			Description = "확률적으로(5% + 5x{{LuckSmall}}%p) {{Bait}}적에게 표식을 걸며 캐릭터에게 다시 돌아오는 처비를 발사합니다.#다른 정동석 소지 시 확률 +10%p",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "칼초네 정동",
			QuoteDesc = "처비 발사 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.TOUGH_GEODE] = {
			Description = "{{ffCrush}} 분해 시 확률적으로 장신구가 소모되지 않고 보존됩니다.#다른 정동석 소지 시 보존 확률 증가",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "딱딱한 정동",
			QuoteDesc = "보존력이 강함 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.TIPSY_GEODE] = {
			Description = "↑ {{DamageSmall}}공격력 +2#움직임이 불안정해집니다.#다른 정동석 소지 시 {{DamageSmall}}공격력 배율 x3.5, 이동 불안정성 증가",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "술취한 정동",
			QuoteDesc = "불안정한 이동 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.VINYL_GEODE_A] = {
			Description = "↑ {{DamageSmall}}공격력 +1#↑ {{ShotspeedSmall}}탄속 +0.24#짝수 스테이지 진입 시 뒷면으로 뒤집습니다.({{SpeedSmall}}/{{TearsSmall}} 증가)#다른 정동석 소지 시:#↑ {{SpeedSmall}}이동속도 +0.07#↑ {{TearsSmall}}공격 딜레이 -0.6(연사 증가)",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "비닐 정동 - 앞면",
			QuoteDesc = "양면 능력치 증가 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.VINYL_GEODE_B] = {
			Description = "↑ {{SpeedSmall}}이동속도 +0.2#↑ {{TearsSmall}}공격 딜레이 -1.8(연사 증가)#홀수 스테이지 진입 시 앞면으로 뒤집습니다.({{DamageSmall}}/{{ShotspeedSmall}} 증가)#다른 정동석 소지 시:#↑ {{DamageSmall}}공격력 +0.3#↑ {{ShotspeedSmall}}탄속 +0.08",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "비닐 정동 - 뒷면",
			QuoteDesc = "양면 능력치 증가 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.PRISMATIC_GEODE] = {
			Description = "적 처치 시 확률적으로 랜덤 능력치를 10초동안 증가시켜주는 프리즘 조각을 드랍합니다.#방 클리어 시 확률적으로 프리즘 조각을 추가로 드랍합니다.#다른 정동석 소지 시 증가량 및 지속시간 증가",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "프리즘 정동",
			QuoteDesc = "무지개빛의 힘 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.FRACTAL_GEODE] = {
			Description = "{{ffSleeping}} 확률적으로 적을 나른하게 만드는 눈물을 회오리 모양으로 발사합니다.#다른 정동석 소지 시 확률적으로 나른한 적을 즉시 잠들게 합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "프랙탈 정동",
			QuoteDesc = "깊이 보려고 하지 마 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.GMO_GEODE] = {
			Description = "알약 사용 시 랜덤 효과의 알약을 강제로 사용합니다.#다른 정동석 소지 시 긍정적 효과의 랜덤 알약을 추가로 사용합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "GMO 정동",
			QuoteDesc = "잠재성 알약 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.SWALLOWED_GEODE] = {
			Description = "피격 시 {{Coin}}동전을 하나 드랍합니다.#다른 정동석 소지 시 확률적으로 1+1 동전을 드랍합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "삼켜진 페니",
			QuoteDesc = "꿀꺽! + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.VOODOO_GEODE] = {
			Description = "{{CurseCursedSmall}} 저주가 걸려 있는 동안 {{DamageSmall}}공격력 +1.5#{{CurseRoom}}저주방 최초 진입 시 그 스테이지에서 {{DamageSmall}}공격력 +0.35#다른 정동석 소지 시 공격력 증가량이 1.5배가 됩니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "부두 정동",
			QuoteDesc = "저주가 곧 힘 + 정동 보너스",
		},
		[FiendFolio.ITEM.ROCK.UMBILICAL_GEODE] = {
			Description = "{{HalfHeart}} 방 입장 시 빨간하트가 반칸 이하일 때 {{Collectible100}}Little Steven을 소환합니다.#피격 시 확률적으로 그 방에서 {{Collectible318}}Gemini 패밀리어를 소환합니다.#다른 정동석 소지 시 {{Collectible318}}Gemini의 소환 확률 증가, {{Collectible100}}Little Steven의 조건이 {{Heart}}빨간하트 한칸 이하로 늘어납니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_GEODE},
			Name = "탯줄",
			QuoteDesc = "태아 보호 + 정동 보너스",
		},

		[FiendFolio.ITEM.ROCK.GEODE_FOSSIL] = {
			Description = "↑ {{RangeSmall}}사거리 +8#↑ 다른 정동석 소지 시 {{RangeSmall}}추가 사거리 +6#{{ffCrush}} 분해 시 랜덤 정동석을 드랍합니다.#{{ffCrush}} 다른 정동석 소지 시 분해 할 때 랜덤 정동석을 추가로 드랍합니다.",
			StatusEffects = {ffStatusEffectDesc.GOLEM_DUAL},
			Name = "정동화석",
			QuoteDesc = "궁극의 보석 + 정동, 분해 보너스",
		},
	}

	if FiendFolio.modVersionNumber >= versionNext then
		wakaba_krdesc.KeyValueBulkAppend(ffTrinketDesc, {
			[FiendFolio.ITEM.ROCK.CHUNK_OF_GALLIUM] = {
				Description = "15%의 확률로 적을 느려지게 하는 장판을 생성하는 공격이 나갑니다.",
				StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
				Name = "갈륨 덩이",
				QuoteDesc = "느릿느릿한 흐름",
			},
			[FiendFolio.ITEM.ROCK.ONION_ROCK] = {
				Description = "주변에 있으면 공격방향을 향해 공격하는 Brickmin 패밀리어를 소환합니다.#Brickmin의 효과는 종류에 따라 다릅니다.#스테이지 입장 시 Brickmin의 효과가 바뀝니다.",
				StatusEffects = {ffStatusEffectDesc.GOLEM_NORMAL},
				Name = "양파 돌덩이",
				QuoteDesc = "던질 수 있는 친구들",
			},
		})
	end































	for playerType, birthrightdesc in pairs(ffBirthrightDesc) do
		EID:addBirthright(playerType, birthrightdesc.Description, birthrightdesc.Name, "ko_kr")
	end
	for itemID, itemdesc in pairs(ffCollectibleDesc) do
		local desc = itemdesc.Description
		if itemdesc.StatusEffects then
			for _, eff in ipairs(itemdesc.StatusEffects) do
				itemdesc.Description = itemdesc.Description .. eff
			end
		end
		EID:addCollectible(itemID, desc, itemdesc.Name, "ko_kr")
		if itemdesc.Wisps and itemdesc.Wisps ~= "" then
			EID.descriptions["ko_kr"].bookOfVirtuesWisps[itemID] = itemdesc.Wisps
		end
		if itemdesc.Belial and itemdesc.Belial ~= "" then
			EID.descriptions["ko_kr"].bookOfBelialBuffs[itemID] = itemdesc.Belial
		end
	end
	for itemID, itemdesc in pairs(ffTrinketDesc) do
		local desc = itemdesc.Description
		if itemdesc.StatusEffects then
			for _, eff in ipairs(itemdesc.StatusEffects) do
				itemdesc.Description = itemdesc.Description .. eff
			end
		end
		EID:addTrinket(itemID, desc, itemdesc.Name, "ko_kr")
	end
	for itemID, itemdesc in pairs(ffCardDesc) do
		EID:addCard(itemID, itemdesc.Description, itemdesc.Name, "ko_kr")
	end
	for itemID, itemdesc in pairs(ffPillDesc) do
		EID:addPill(itemID, itemdesc.Description, itemdesc.Name, "ko_kr")
	end

	EID:addEntity(5, 20, FiendFolio.PICKUP.COIN.CURSED, "저주받은 페니", "획득 시 -2 ~ +2개의 동전을 획득하며 낮은 확률로 모든 능력치가 증가하거나 {{ColorOrange}}폭발합니다{{CR}}", "ko_kr")
	EID:addEntity(5, 20, FiendFolio.PICKUP.COIN.HAUNTED, "으스스한 페니", "획득 시 {{Collectible584}}미덕의 불꽃이 같이 소환됩니다.", "ko_kr")
	EID:addEntity(5, 20, FiendFolio.PICKUP.COIN.HONEY, "달콤한 페니", "획득 시 일정 시간동안 적을 느려지게 하는 장판을 깝니다.", "ko_kr")
	EID:addEntity(5, 20, FiendFolio.PICKUP.COIN.GOLDENCURSED, "저주받은 페니", "획득 시 -2 ~ +2개의 동전을 획득하며 낮은 확률로 모든 능력치가 증가하거나 {{ColorOrange}}폭발합니다{{CR}}#{{ColorGold}}확률적으로 방 안에 다시 등장합니다.{{CR}}", "ko_kr")
	EID:addEntity(5, 20, FiendFolio.PICKUP.COIN.LEGOSTUD, "레고 페니", "습득 시 1{{Coin}}을 획득하지만 {{Collectible486}}캐릭터에게 가짜 피해를 줍니다.#레고 페니에 접촉한 적에게 5의 피해를 줍니다.", "ko_kr")

	EID:addEntity(5, 30, FiendFolio.PICKUP.KEY.SPICY, "매운 열쇠", "{{Key}} 열쇠 +2#반칸의 피해를 입습니다.", "ko_kr")
	EID:addEntity(5, 30, FiendFolio.PICKUP.KEY.SUPERSPICY, "매운 열쇠", "{{Key}} 열쇠 +3#반칸의 피해를 입습니다.", "ko_kr")
	EID:addEntity(5, 30, FiendFolio.PICKUP.KEY.CHARGEDSPICY, "매운 열쇠", "{{Key}} 열쇠 +2#액티브 아이템의 게이지를 6칸 충전시키며 반칸의 피해를 입습니다.", "ko_kr")
	EID:addEntity(5, 30, FiendFolio.PICKUP.KEY.SPICY_BOX, "매운 열쇠", "{{Key}} 열쇠 +3#반칸의 피해를 입습니다.", "ko_kr")
	EID:addEntity(5, 30, FiendFolio.PICKUP.KEY.SUPERSPICY_BOX, "매운 열쇠", "{{Key}} 열쇠 +4#반칸의 피해를 입습니다.", "ko_kr")
	EID:addEntity(5, 30, FiendFolio.PICKUP.KEY.CHARGEDSPICY_BOX, "매운 열쇠", "{{Key}} 열쇠 +3#액티브 아이템의 게이지를 6칸 충전시키며 반칸의 피해를 입습니다.", "ko_kr")
	EID:addEntity(5, 30, FiendFolio.PICKUP.KEY.SPICY_PERM, "매운 열쇠", "{{Key}} 열쇠 +2#반칸의 피해를 입습니다.", "ko_kr")
	EID:addEntity(5, 30, FiendFolio.PICKUP.KEY.SUPERSPICY_PERM, "매운 열쇠", "{{Key}} 열쇠 +3#반칸의 피해를 입습니다.", "ko_kr")
	EID:addEntity(5, 30, FiendFolio.PICKUP.KEY.CHARGEDSPICY_PERM, "매운 열쇠", "{{Key}} 열쇠 +2#액티브 아이템의 게이지를 6칸 충전시키며 반칸의 피해를 입습니다.", "ko_kr")

	EID:addEntity(5, 40, FiendFolio.PICKUP.BOMB.COPPER, "구리 폭탄", "설치 시 확률적으로 불발되거나 {{Collectible106}}거대한 폭발을 일으킵니다.", "ko_kr")
	EID:addEntity(5, 40, FiendFolio.PICKUP.BOMB.DOUBLE_COPPER, "구리 폭탄", "설치 시 확률적으로 불발되거나 {{Collectible106}}거대한 폭발을 일으킵니다.", "ko_kr")
	EID:addEntity(5, 40, FiendFolio.PICKUP.BOMB.MIXED_DOUBLE, "구리 폭탄", "설치 시 확률적으로 불발되거나 {{Collectible106}}거대한 폭발을 일으킵니다.", "ko_kr")

	EID:addEntity(5, FiendFolio.PICKUP.VARIANT.FIREWORK_BATTERY, 0, "폭죽 배터리", "{{Collectible"..FiendFolio.ITEM.COLLECTIBLE.EXCELSIOR.."}}다음 액티브 사용 시 유도성 로켓을 여러 발 발사합니다.", "ko_kr")
	EID:addEntity(5, FiendFolio.PICKUP.VARIANT.VIRTUOUS_BATTERY, 0, "미덕의 배터리", "{{Collectible584}}다음 액티브 사용 시 해당 액티브의 불꽃을 같이 소환합니다.", "ko_kr")
	EID:addEntity(5, FiendFolio.PICKUP.VARIANT.POTATO_BATTERY, 0, "감자도스", "1칸을 충전합니다.", "ko_kr")
	EID:addEntity(5, FiendFolio.PICKUP.VARIANT.CURSED_BATTERY, 0, "저주받은 배터리", "-2~4칸을 충전합니다.#The Battery 없이 초과 충전이 가능합니다.", "ko_kr")

	EID:addEntity(5, FiendFolio.PICKUP.VARIANT.TOKEN, 0, "토큰", "가장 최근에 집은 픽업을 다시 집습니다.", "ko_kr")

	EID:addEntity(6, 880, 0, "장애물 재설정 기계", "1{{Bomb}} 필요#{{Collectible386}} 확률적으로 그 방의 장애물을 바꿉니다.", "ko_kr")
	EID:addEntity(6, FiendFolio.FF.PokerTable.Var, 0, "포커 테이블", "베팅할 픽업의 수를 선택하고 터치 시 확률적으로 돌려받거나 전부 잃습니다.#3번 승리 시 투자한 픽업의 수에 비례하여 픽업 및 아이템을 드랍합니다.", "ko_kr")
	EID:addEntity(6, FiendFolio.FF.Blacksmith.Var, 0, "대장장이", "장신구 2개를 소모하여 새로운 장신구로 바꿉니다.", "ko_kr")
	EID:addEntity(6, 1035, 0, "???", "필요한 건 가져오셨나?", "ko_kr")
	EID:addEntity(6, FiendFolio.FF.ZodiacBeggar.Var, 0, "천체 거지", "1{{Coin}} 필요#확률적으로 {{Planetarium}}천체관/별자리 아이템 불꽃, 혹은 {{Collectible584}}미덕의 불꽃을 소환합니다.", "ko_kr")
	EID:addEntity(6, FiendFolio.FF.RobotTeller.Var, 0, "로봇 점술기계", "1{{Coin}} 필요#작동 시 확률적으로 {{Collectible287}}일부 위치를 보여주거나#포탈을 소환하거나#카드를 제시하거나#제시한 카드를 사용합니다.#제시한 상태에서 폭파 시 해당 카드가 드랍됩니다.", "ko_kr")
	EID:addEntity(6, FiendFolio.FF.EvilBeggar.Var, 0, "짐승 거지", "1{{Heart}}(최대 체력)/2{{SoulHeart}} 필요#1~3회 기부 시 {{DevilRoom}}악마방 아이템을 주고 떠납니다.", "ko_kr")
	EID:addEntity(6, FiendFolio.FF.CellGame.Var, 0, "셀 게임", "1{{Key}} 필요#확률적으로 제시한 아이템을 받을 수 있습니다.", "ko_kr")
	--EID:addEntity(6, FiendFolio.FF.HugBeggar.Var, 0, "엔티티이름", "설명", "ko_kr")
	--EID:addEntity(6, FiendFolio.FF.CosplayBeggar.Var, 0, "엔티티이름", "설명", "ko_kr")
	--EID:addEntity(6, FiendFolio.FF.PhoneBooth.Var, 0, "엔티티이름", "설명", "ko_kr")
	EID:addEntity(6, FiendFolio.FF.GoldenSlotMachine.Var, 0, "황금 슬롯머신", "1{{Coin}} 필요#작동 시 랜덤 보상을 획득하며 그 스테이지의 랜덤 방으로 이동합니다.", "ko_kr")
	--EID:addEntity(6, FiendFolio.FF.Jukebox.Var, 0, "엔티티이름", "설명", "ko_kr")

	EID:addEntity(6, 1020, 0, "채굴기", "현재 들고 있는 장신구와 {{Coin}}동전 3개를 소모하여 다른 석기 장신구로 교체합니다.", "ko_kr")
	EID:addEntity(6, 1021, 0, "분해기", "현재 들고 있는 장신구를 {{SoulHeart}}소울하트 1~1.5개로 분해합니다.", "ko_kr")
	EID:addEntity(6, 1022, 0, "은둔자", "{{SoulHeart}}소울하트 1.5칸을 소모하여 현재 소지 중인 석기 장신구를 흡수합니다.#!!! 흡수된 석기 장신구의 효과는 원래 효과의 66%로 줄어듭니다.", "ko_kr")
	EID:addEntity(6, 1023, 0, "???", "이후 스테이지에 다시 와주세요.#폭파 시 랜덤 장신구를 드랍합니다.", "ko_kr")
	EID:addEntity(6, 1024, 0, "정동 골렘", "!!! 스테이지 당 일회용#현재 들고 있는 장신구를 {{ColorTeal}}정동석{{CR}} 장신구 2개로 바꿉니다.#정동성 타입의 장신구는 해당 장신구를 복제합니다.", "ko_kr")
	EID:addEntity(6, 1024, 1, "정동 골렘", "!!! 이미 사용됨. 다음 스테이지부터 등장 시 다시 사용할 수 있습니다.", "ko_kr")
	EID:addEntity(6, FiendFolio.FF.Midarizer.Var, 0, "미다라이저", "현재 들고 있는 장신구와 {{Coin}}동전 10개를 소모하여 황금 형태로 바꿉니다.#사용 후 50%의 확률로 비활성화되어 더 이상 사용할 수 없게 됩니다.", "ko_kr")
	EID:addEntity(6, FiendFolio.FF.Midarizer.Var, 10, "미다라이저", "!!! 비활성화됨. 다음 스테이지부터 등장 시 다시 사용할 수 있습니다.", "ko_kr")
	EID:addEntity(6, FiendFolio.FF.Sweetpuss.Var, 0, "스윗퍼스", "!!! 일회용#현재 들고 있는 장신구를 {{ColorRed}}화석{{CR}} 장신구로 바꿉니다.#화석 타입의 장신구는 해당 장신구를 파괴합니다.", "ko_kr")


  EID.descriptions["ko_kr"].bingeEaterBuffs[FiendFolio.ITEM.COLLECTIBLE.TEA] = "↑ {{RangeSmall}}사거리 +1.5#↑ {{LuckSmall}}행운 +1#↓ {{SpeedSmall}}이동속도 -0.03"

	local function FF_EIDKR_RockSlotCondition(descObj)
	  if EID:getLanguage() ~= "ko_kr" then return false end
	  if not descObj.ObjType == EntityType.ENTITY_SLOT then return false end
	  if not descObj.Entity then return end
	  if descObj.ObjVariant == 1020
	  or descObj.ObjVariant == 1021
	  or descObj.ObjVariant == 1022
	  or (descObj.ObjVariant == 1024 and descObj.ObjSubType == 0)
		or (descObj.ObjVariant == FiendFolio.FF.Midarizer.Var and descObj.ObjSubType ~= 10)
		or descObj.ObjVariant == FiendFolio.FF.Sweetpuss.Var
	  then
	    local holdUpRockRange = 100

	    local game = Game()
	    local slot = descObj.Entity
	    local anim = slot:GetSprite():GetAnimation()
	    for i=0, game:GetNumPlayers()-1 do
	      local player = game:GetPlayer(i)
	      local data = player:GetData()

	      if player and player:Exists() then
					local trinket
					if slot.Variant == FiendFolio.FF.Midarizer.Var then
						trinket = FiendFolio.GetMostRecentRockTrinket(player, nil, true)
					else
						trinket = FiendFolio.GetMostRecentRockTrinket(player)
					end
	        local price = FiendFolio.GetGrindPriceForTrinket(trinket, player)

	        local shouldHoldUpRockTrinket = trinket > 0
	          and (data.holdingUpRockTouchingPickup or 0) == 0
	          and not player:IsHoldingItem()
	          and (anim == 'Idle' or anim == 'IdleRandom')
	          and player.Position:Distance(slot.Position) < holdUpRockRange
	          and player:GetShootingInput():Length() < 0.1
	          and not (slot.Variant == 1020 and player:GetNumCoins() < price)
	          and not (slot.Variant == 1022 and player:GetSoulHearts() < 3)

	        return shouldHoldUpRockTrinket
	      end

	    end
	  end
	end

	local function FF_EIDKR_RockSlotCallback(descObj)
	  for i = 0, Game():GetNumPlayers() -1 do
	    local player = Isaac.GetPlayer()
	    local data = player:GetData()
	    local trinket = FiendFolio.GetMostRecentRockTrinket(player)
	    if data.isHoldingUpRockTrinket and trinket > 0 then
	      trinket = trinket % TrinketType.TRINKET_GOLDEN_FLAG
	      local demoDescObj = EID:getDescriptionObj(5, 350, trinket)

	      local appendDesc = "#!!! 아래 장신구가 소모됨 : #"
	      if descObj.ObjVariant == 1020 then
	        appendDesc = "#!!! 아래 장신구가 {{ColorLightOrange}}소모됨{{CR}} : #"
	      elseif descObj.ObjVariant == 1021 then
	        appendDesc = "#!!! 아래 장신구가 {{ColorPastelBlue}}분해됨{{CR}} : #"
	      elseif descObj.ObjVariant == 1022 then
	        appendDesc = "#!!! 아래 장신구가 {{ColorSilver}}흡수됨{{CR}} : #"
	      elseif descObj.ObjVariant == FiendFolio.FF.Midarizer.Var then
	        appendDesc = "#!!! 아래 장신구가 {{ColorGold}}강화됨{{CR}} : #"
	      elseif descObj.ObjVariant == FiendFolio.FF.Sweetpuss.Var then
	        appendDesc = "#!!! 아래 장신구가 {{ColorEIDError}}소모됨{{CR}} : #"
	      end
	      appendDesc = appendDesc .. "{{Trinket"..trinket.."}} {{ColorEIDObjName}}" .. demoDescObj.Name .. "#" .. demoDescObj.Description .. "#"
	      EID:appendToDescription(descObj, appendDesc)
	      break
	    end
	  end

	  return descObj
	end

	local function FF_EIDKR_EmptyBookCondition(descObj)
	  if EID:getLanguage() ~= "ko_kr" then return false end
	  if not FiendFolio.savedata.run.emptybookeffects then return false end
	  if not (descObj.ObjType == EntityType.ENTITY_PICKUP and descObj.ObjVariant == PickupVariant.PICKUP_COLLECTIBLE) then return false end
	  return (descObj.ObjSubType == FiendFolio.ITEM.COLLECTIBLE.MY_STORY_2 or descObj.ObjSubType == FiendFolio.ITEM.COLLECTIBLE.MY_STORY_4 or descObj.ObjSubType == FiendFolio.ITEM.COLLECTIBLE.MY_STORY_6)
	end
	local checkNames = {
	  [FiendFolio.ITEM.COLLECTIBLE.MY_STORY_2] = "short story",
	  [FiendFolio.ITEM.COLLECTIBLE.MY_STORY_4] = "average story",
	  [FiendFolio.ITEM.COLLECTIBLE.MY_STORY_6] = "long story",
	}
	local function FF_EIDKR_EmptyBookCallback(descObj)
	  local effects
	  local multiplier
	  local existingEffects = FiendFolio.savedata.run.emptybookeffects
	  local appendDesc = "!!! 사용 시:"
	  local shouldAppend = true
	  if existingEffects then
	    if existingEffects and existingEffects[checkNames[descObj.ObjSubType]] then
	      effects = existingEffects[checkNames[descObj.ObjSubType]]
	      multiplier = Isaac.GetItemConfig():GetCollectible(descObj.ObjSubType).MaxCharges
	      multiplier = multiplier and multiplier / 2
	    else
	      shouldAppend = false
	      appendDesc = "!!! 랜덤 효과를 2번 발동합니다."
	      effects = {"wild", "wild"}
	      multiplier = 2
	    end

	    if effects and multiplier and shouldAppend then
	      for _, effect in ipairs(effects) do
	        while effect == "wild" do
	          appendDesc = appendDesc .. "#랜덤 효과를 발동합니다."
	        end
	        if effect == "sad" then
	          appendDesc = appendDesc .. "#그 방에서 {{TearsSmall}}연사 +" .. (0.25 * multiplier)
	        elseif effect == "frightning" then
	          local rangeStr = multiplier == 1 and "주변의 " or "그 방의 "
	          local durations = {
	            [1] = "7", [2] = "5", [3] = "8"
	          }
	          appendDesc = appendDesc .. "#{{Fear}} " .. rangeStr .. "적에게 " .. durations[multiplier] .. "초동안 공포를 겁니다."
	        elseif effect == "shocking" then
	          local rangeStr = multiplier == 1 and "주변의 " or "그 방의 "
	          local durations = {
	            [1] = 7, [2] = 5, [3] = 8
	          }
	          appendDesc = appendDesc .. "#{{ffBruise}} " .. rangeStr .. "적을 " .. tostring(math.ceil(durations[multiplier] * 1.5)) .. "초동안 멍들게 합니다."
	        elseif effect == "violent" then
	          local rangeStr = multiplier == 1 and "주변의 " or "그 방의 "
	          local dmgStrings = {
	            [1] = "15 + (3 * 현재 스테이지)",
	            [2] = "20 + (3 * 현재 스테이지)",
	            [3] = "30 + (4 * 현재 스테이지)"
	          }
	          appendDesc = appendDesc .. "#" .. rangeStr .. "적에게 " .. dmgStrings[multiplier] .. "만큼의 피해를 줍니다."
	        elseif effect == "profitable" then
	          local coinStrings = {
	            [1] = "페니 2개를 드랍합니다.",
	            [2] = "페니 1개와 랜덤 동전을 드랍합니다.",
	            [3] = "페니 1개, 랜덤 동전 1개, 랜덤 픽업 1개를 드랍합니다."
	          }
	          appendDesc = appendDesc .. "#{{Coin}} " .. coinStrings[multiplier]
	        elseif effect == "religious" then
	          appendDesc = appendDesc .. "#{{Collectible584}} Book of Virtues의 불꽃을 " ..tostring(math.ceil(multiplier)) .. "개 소환합니다."
	        elseif effect == "love" then
	          local heartStrings = {
	            [1] = "#{{HalfHeart}} 빨간하트 반칸을 드랍합니다.",
	            [2] = "#{{Heart}} 빨간하트 한칸을 드랍합니다.",
	            [3] = "#{{SoulHeart}} 소울하트 한칸을 드랍합니다."
	          }
	          appendDesc = appendDesc .. heartStrings[multiplier]

	        elseif effect == "funny" then
	          local funnyStrings = {
	            [1] = "적을 밀쳐내는 ",
	            [2] = "적을 밀쳐내는 독",
	            [3] = "주변의 적을 {{Poison}}중독시키는 거대한 독"
	          }
	          appendDesc = appendDesc .. "#{{Collectible294}} " .. funnyStrings[multiplier] .. "방귀를 뀝니다."

	        elseif effect == "mischievous" then
	          appendDesc = appendDesc .. "#{{Collectible"..FiendFolio.ITEM.COLLECTIBLE.FIENDS_HORN.."}} Fiend의 부하를 " ..tostring(math.ceil(multiplier)) .. "마리 소환합니다."
	        elseif effect == "festering" then
	          appendDesc = appendDesc .. "#파란 아군 자폭 벼룩을 " .. tostring(math.ceil(multiplier * 2)) .. "마리 소환합니다."
	        end
	      end
	    end
	    descObj.Description = appendDesc .. descObj.Description
	    --EID:appendToDescription(descObj, appendDesc)
	  end
	  return descObj
	end

	local function FF_EIDKR_PerfectGenericObjectCondition(descObj)
	  if EID:getLanguage() ~= "ko_kr" then return false end
	  if not (descObj.ObjType == EntityType.ENTITY_PICKUP and descObj.ObjVariant == PickupVariant.PICKUP_TAROTCARD) then return false end
	  local numPlayers = Game():GetNumPlayers()
	  for i = 0, numPlayers - 1 do
	    if Isaac.GetPlayer(i):HasCollectible(FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_4) or (EID.absorbedItems[tostring(i)] and EID.absorbedItems[tostring(i)][tostring(FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_4)])  then
	      return true
	    end
	    if Isaac.GetPlayer(i):HasCollectible(FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_1) or (EID.absorbedItems[tostring(i)] and EID.absorbedItems[tostring(i)][tostring(FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_1)])  then
	      return true
	    end
	    if Isaac.GetPlayer(i):HasCollectible(FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_2) or (EID.absorbedItems[tostring(i)] and EID.absorbedItems[tostring(i)][tostring(FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_2)])  then
	      return true
	    end
	    if Isaac.GetPlayer(i):HasCollectible(FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_3) or (EID.absorbedItems[tostring(i)] and EID.absorbedItems[tostring(i)][tostring(FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_3)])  then
	      return true
	    end
	    if Isaac.GetPlayer(i):HasCollectible(FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_5) or (EID.absorbedItems[tostring(i)] and EID.absorbedItems[tostring(i)][tostring(FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_5)])  then
	      return true
	    end
	    if Isaac.GetPlayer(i):HasCollectible(FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_6) or (EID.absorbedItems[tostring(i)] and EID.absorbedItems[tostring(i)][tostring(FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_6)])  then
	      return true
	    end
	    if Isaac.GetPlayer(i):HasCollectible(FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_8) or (EID.absorbedItems[tostring(i)] and EID.absorbedItems[tostring(i)][tostring(FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_8)])  then
	      return true
	    end
	    if Isaac.GetPlayer(i):HasCollectible(FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_12) or (EID.absorbedItems[tostring(i)] and EID.absorbedItems[tostring(i)][tostring(FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_12)])  then
	      return true
	    end
	  end
	end


	local function FF_EIDKR_PerfectGenericObjectCallback(descObj)
	  local text = EID:getDescriptionEntry("PerfectGenericObjectCharge")
	  local charge = FiendFolio:getPocketObjectMimicCharge(descObj.ObjSubType)
	  if text ~= nil and charge ~= nil then
	    local iconStr = "#{{Collectible"..FiendFolio.ITEM.COLLECTIBLE.PERFECTLY_GENERIC_OBJECT_4.."}} {{ColorSilver}}"
	    EID:appendToDescription(descObj, iconStr..text.." {{"..charge.."}}{{Battery}}")
	  end
	  return descObj
	end

	EID:addDescriptionModifier("FF_EIDKR_GolemMachines", FF_EIDKR_RockSlotCondition, FF_EIDKR_RockSlotCallback)
	EID:addDescriptionModifier("FF_EIDKR_EmptyBook", FF_EIDKR_EmptyBookCondition, FF_EIDKR_EmptyBookCallback)
	EID:addDescriptionModifier("FF_EIDKR_PerfectGenericObject", FF_EIDKR_PerfectGenericObjectCondition, FF_EIDKR_PerfectGenericObjectCallback)

	local diceTable = {
	  [881] = {"881", "12번", "{{Collectible386}} 스테이지 안의 모든 장애물 변경"},
	  [882] = {"882", "12번", "{{Collectible386}} 스테이지 안의 모든 장애물 변경"}
	}
	EID:updateDescriptionsViaTable(diceTable, EID.descriptions["ko_kr"].dice)
	wakaba_krdesc:AddCallback(ModCallbacks.MC_USE_PILL, function (_, pillEffectID, playerWhoUsedItem, useFlags)
		if Options.Language ~= "kr" or useFlags & UseFlag.USE_NOHUD == UseFlag.USE_NOHUD then return end
		if ffPillDesc[pillEffectID] then
			Game():GetHUD():ShowItemText(ffPillDesc[pillEffectID].Name, ffPillDesc[pillEffectID].QuoteDesc)
		end
	end)

	return {
		targetMod = "Fiend Folio",
		birthright = ffBirthrightDesc,
		collectibles = ffCollectibleDesc,
		trinkets = ffTrinketDesc,
		cards = ffCardDesc,
		pills = ffPillDesc,
	}

end
