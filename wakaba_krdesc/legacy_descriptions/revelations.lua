if REVEL then
	if not REPENTOGON then
		table.insert(wakaba_krdesc.ERRORS, {
			NO_RGON = true,
			err_mod = "Revelations",
		})
		return
	end

EID._currentMod = "Revelations"

local CharacterDesc = {
  [REVEL.CHAR.SARAH.Type] = {
    Name = "Sarah",
		Description = "",
		Detailed = ""
			.."#{{Collectible"..REVEL.ITEM.PENANCE.id.."}} 고유 능력 : 참회"
			.."#{{Blank}} 어떠한 경우에도 악마방이 등장하지 않습니다."
			.."#{{Blank}} 4회 이상 참회 시 비행 능력을 얻습니다."
			.."",
    Birthright = "{{BlackHeart}} 피격 시 블랙하트가 나올 때 하나씩만 나옵니다.",
    QuoteDesc = "내 죄를 용서하소서",
  },
  [REVEL.CHAR.DANTE.Type] = {
    Name = "Dante",
		Description = "",
		Detailed = ""
			.."#{{BossRoom}} 스테이지 진입 시 카론과 흩어지며 보스방을 진입하려면 카론과 만나야 됩니다."
			.."#{{Slow}} 공격이 무언가에 부딪힐 때 적을 느리게 하는 둔화 장판이 생깁니다."
			.."#공격방향으로 책을 내려찍으며 적을 강하게 밀쳐냅니다."
			.."#{{Collectible"..REVEL.ITEM.PHYLACTERY.id.."}} 고유 능력 : 성물함"
			.."#{{Blank}} 아이템을 드는 도중 Phylactery 사용 시 카론이 해당 아이템을 대신 획득합니다."
			.."",
    Birthright = "스테이지 진입 시 둘이 헤어질 때 랜덤 패시브 아이템 3개를 공유합니다.",
    QuoteDesc = "전리품 공유",
  },
  [REVEL.CHAR.CHARON.Type] = {
    Name = "Charon",
		Description = "",
		Detailed = ""
			.."#{{BossRoom}} 스테이지 진입 시 단테와 흩어지며 보스방을 진입하려면 단테과 만나야 됩니다."
			.."#공격이 5~6발로 나갑니다."
			.."#공격방향을 바꾸면 탄속이 감소하며, 같은 방향으로 쓸수록 되돌아옵니다."
			.."#{{Collectible"..REVEL.ITEM.PHYLACTERY.id.."}} 고유 능력 : 성물함"
			.."#{{Blank}} 아이템을 드는 도중 Phylactery 사용 시 단테가 해당 아이템을 대신 획득합니다."
			.."",
    Birthright = "스테이지 진입 시 둘이 헤어질 때 랜덤 패시브 아이템 3개를 공유합니다.",
    QuoteDesc = "전리품 공유",
  },
}


local revCollectibleDesc = {

-- Chapter 1
	[REVEL.ITEM.HEAVENLY_BELL.id] = {
		Description = "!!! 스테이지 입장 시 종소리와 함께 아래의 효과 중 하나 발동:#비밀방 입장 시 아이템 소환#슬롯머신 파괴 시 항상 아이템 소환#슬롯머신 파괴 시 많은 동전이 드랍됨#보스방에서 피격당하지 않고 클리어 시 3개의 아이템 중 하나 선택#사망 시 ???로 부활#상점 주인 파괴 시 사다리방으로 가는 트랩도어 생성#{{HardModeSmall}} 하드 모드에서는 힌트가 표시되지 않음",
		Name = "천국의 종",
		QuoteDesc = "천국에서의 수수께끼 음색",
	},
	[REVEL.ITEM.MINT_GUM.id] = {
		Description = "{{Slow}} 공격을 맞출 때마다 서서히 느려집니다.#5번 맞추면 적이 잠시동안 멈춥니다.",
		Name = "민트 껌",
		QuoteDesc = "상쾌한 숨결",
	},
	[REVEL.ITEM.FECAL_FREAK.id] = {
		Description = "공격 키가 반대로 나갑니다.#↑ {{Damage}}공격력 +1.5#↑ {{Damage}}공격력 배율 x1.5#↓ {{Range}}사거리 x0.75#↓ {{Shotspeed}} 탄속 x0.75",
		Name = "대변 도착증",
		QuoteDesc = "똥으로 공격",
	},
	[REVEL.ITEM.LIL_BELIAL.id] = {
		Description = "{{Slow}} 방 입장 시 적 하나를 느려지게 합니다.#느려진 적을 순차적으로 처치 시 {{Card}}카드를 드랍합니다.",
		Name = "리틀 벨리알",
		QuoteDesc = "그의 표식을 따르거라",
	},
	[REVEL.ITEM.AEGIS.id] = {
		Description = "캐릭터의 공격 방향의 반대에서 오는 적의 탄환을 모두 방어합니다.",
		Name = "성스러운 방패",
		QuoteDesc = "뒤를 보호",
	},
	[REVEL.ITEM.BIRTHDAY_CANDLE.id] = {
		Description = "획득 시 아래 중 가장 적게 소지중인 픽업 아이템을 드랍합니다.#{{SoulHeart}} 소울하트가 없을 때 1개#{{Key}} 열쇠가 없을 때 1개#{{Bomb}} 폭탄이 없을 때 1개#{{Coin}} 동전이 15개 미만일 때 10{{Coin}}#!!! 모든 조건 충족 시:#↑ {{Damage}}공격력 +1#↑ {{Tears}}공격 딜레이 x0.9(연사 증가)#↑ {{Speed}}이동속도 배율 x1.1#↓ {{Range}}사거리 배율 x0.9#↑ {{Shotspeed}}탄속 배율 x1.1#↑ {{Luck}}행운 +1",
		Name = "생일초",
		QuoteDesc = "소원 빌기",
	},
	[REVEL.ITEM.DYNAMO.id] = {
		Description = "{{Chargeable}} 공격키를 2.5초 이상 누르면 충전되며 공격키를 떼면 랜덤 방향으로 레이저 3발이 나갑니다.",
		Name = "발전기",
		QuoteDesc = "땀과 눈물로 충전",
	},
	[REVEL.ITEM.BURNBUSH.id] = {
		Description = "공격하는 방향으로 불길을 발사합니다.#너무 오래 공격하고 있으면 불길이 약해집니다.",
		Name = "불타는 덤불",
		QuoteDesc = "화염의 믿음",
	},
	[REVEL.ITEM.PENANCE.id] = {
		Description = "{{BlackHeart}} 블랙하트를 소지한 상태에서 피격 시 그 피격을 무효화하나 소지 중인 모든 {{BlackHeart}}가 캐릭터를 향해 돌진하는 악마로 바뀌며 방 클리어 시 돌아옵니다.#{{BlackHeart}} 습득하지 않은 블랙하트가 방 이동 시 사라집니다.#{{AngelDevilChanceSmall}} 악마방과 천사방이 함께 등장하며 두 방 중 한곳을 선택할 수 있습니다.#{{AngelChanceSmall}} 천사방이 특수하게 변경되며 블랙하트를 소모하여 보상을 획득할 수 있습니다.",
		Name = "참회",
		QuoteDesc = "너의 체력을 탐내지 않게 하도록",
	},
	[REVEL.ITEM.ICETRAY.id] = {
		Description = "공격이 바닥에 미끄러지는 얼음 공격으로 바뀝니다.#얼음 공격 지나간 자리에 푸른 장판이 생기며 닿은 적은 초당 20의 피해를 입습니다.",
		Name = "얼음 트레이",
		QuoteDesc = "냉기와의 만남",
	},
	[REVEL.ITEM.CLEANER.id] = {
		Description = "↑ {{Tears}}연사(+상한) +1#공격이 적의 장판을 지웁니다.",
		Name = "창문 세제",
		QuoteDesc = "장판 지우개",
	},
	[REVEL.ITEM.SPONGE.id] = {
		Description = "↑ {{Bomb}}폭탄 +5#설치한 폭탄이 눈물 및 적의 탄환을 흡수하며 터질 때 흡수한 눈물 수에 비례하여 적에게 더 많은 피해를 줍니다.",
		Name = "스펀지 폭탄",
		QuoteDesc = "초강력 눈물 흡수 + 폭탄 5개",
	},
	[REVEL.ITEM.PATIENCE.id] = {
		Description = "움직이지 않을 때 0.3초마다 적을 향해 푸른 레이저를 발사합니다.",
		Name = "인내의 영혼",
		QuoteDesc = "조금만 기다려 봐...",
	},
	[REVEL.ITEM.TAMPON.id] = {
		Description = "바닥의 장판에 피해를 입지 않습니다.#적의 장판에 닿으면 장판을 흡수하며 4초동안 {{Tears}}연사(+상한) +2",
		Name = "면봉",
		QuoteDesc = "초강력 장판 흡수",
	},
	[REVEL.ITEM.BCONTROL.id] = {
		Description = "모든 패밀리어가 흡수됩니다.#흡수한 패밀리어 당 {{Damage}}공격력 +0.2#일부 패밀리어는 흡수할 때 특수한 효과를 추가로 적용합니다.",
		Name = "생명 조종",
		QuoteDesc = "유일한 아이",
	},
	[REVEL.ITEM.TBUG.id] = {
		Description = "공격중에 때때로 충전이 진행되고 충전이 끝났을 때 공격키를 떼면 커다란 눈물을 한번에 발사합니다.#{{Poison}} {{Pill}}알약 사용 시 공격 방향으로 독 장판을 깝니다.",
		Name = "불룩한 파리",
		QuoteDesc = "움직인다!",
	},
	[REVEL.ITEM.FFIRE.id] = {
		Description = "모닥불에 피해를 받지 않습니다.#방 입장 시 랜덤 위치에 빨간 모닥불을 생성합니다.#모닥불이 적을 향해 눈물을 발사합니다.",
		Name = "친숙한 불",
		QuoteDesc = "불타는 심장?",
	},
	[REVEL.ITEM.MONOLITH.id] = {
		Description = "사용 시 캐릭터의 위치에 모노리스를 설치합니다.#공격이 모노리스를 통과하면 3갈래로 갈라져 나갑니다.",
		Name = "모노리스",
		QuoteDesc = "반대편에서의 눈물",
	},
	[REVEL.ITEM.HYPER_DICE.id] = {
		Description = "사용 시 특수방의 구조를 바꿉니다.#!!! 특수방의 구조를 바꿀 때 (1^(횟수-1)%의 확률로 주사위가 사라지며 {{ErrorRoom}}오류방으로 이동하거나 {{Collectible284}}캐릭터가 소지한 패시브 아이템을 바꿉니다.#{{Blank}} (8회 사용 시 100%)",
		Name = "하이퍼 주사위",
		QuoteDesc = "특별한 것을 바꾸는 능력?",
	},
	[REVEL.ITEM.MIRROR.id] = {
		Description = "캐릭터 주위를 돌며 적의 탄환을 반사합니다.#{{BleedingOut}} 접촉한 적을 출혈 상태로 만듭니다.",
		Name = "거울 조각",
		QuoteDesc = "세계의 조각",
	},

	[REVEL.ITEM.SMBLADE_UNUSED.id] = {
		Description = "사용 시 공격 방향으로 둥근 톱날을 던집니다.#톱날은 벽을 따라 이동하며 적에게 초당 20의 피해를 줍니다.#충전 상태와 상관 없이 재사용 시 톱날을 반대 벽을 향해 발사합니다.#!!! 캐릭터도 톱날에 피해를 받음",
		Name = "슈미보 톱날",
		QuoteDesc = "갈아버릴 수 있을까?",
	},
	[REVEL.ITEM.SMBLADE.id] = {
		Description = "사용 시 공격 방향으로 둥근 톱날을 던집니다.#톱날은 벽을 따라 이동하며 적에게 초당 20의 피해를 줍니다.#충전 상태와 상관 없이 재사용 시 톱날을 반대 벽을 향해 발사합니다.#!!! 캐릭터도 톱날에 피해를 받음",
		Name = "슈미보 톱날",
		QuoteDesc = "갈아버릴 수 있을까?",
	},
	[REVEL.ITEM.PRESCRIPTION.id] = {
		Description = "{{Pill}} 방 입장 시 낮은 확률로 최근에 사용했던 알약을 다시 사용합니다.",
		Name = "처방전",
		QuoteDesc = "오래 가는 효력",
	},
	[REVEL.ITEM.GEODE.id] = {
		Description = "{{Rune}} 색돌에서 나온 소울하트를 룬으로 바꿉니다.",
		Name = "정동석",
		QuoteDesc = "부수는 걸 못 참겠어!",
	},
	[REVEL.ITEM.NOT_A_BULLET.id] = {
		Description = "↑ {{Shotspeed}}탄속 +0.5#눈물의 탄속에 비례하여 적에게 추가 피해를 줍니다.",
		Name = "총알 아님",
		QuoteDesc = "탄속 = 힘",
	},
	[REVEL.ITEM.DRAMAMINE.id] = {
		Description = "사용 시 캐릭터의 위치에 캐릭터의 눈물 효과를 가진 지뢰를 설치합니다.#적에게 닿을 시 지뢰가 폭발합니다.",
		Name = "드라마민",
		QuoteDesc = "구토 억제제",
	},


  -- Chapter 2
	[REVEL.ITEM.WANDERING_SOUL.id] = {
		Description = "방 입장 시 캐릭터의 형태를 한 유령이 생깁니다.#유령은 적을 따라 이동하며 해당 캐릭터의 모습을 한 캐릭터와 같은 공격을 합니다.",
		Name = "헤매는 영혼",
		QuoteDesc = "익숙한 얼굴",
	},
	[REVEL.ITEM.CABBAGE_PATCH.id] = {
		Description = "방 입장 시 새싹이 생기며 그 새싹에 눈물을 여러분 줄 경우 공격력 x5의 폭발과 함께 채소가 자랍니다.#채소는 적에게 틱 당 캐릭터의 공격력 x1.5의 피해를 주나 여러 번 피해를 줄 시 사라집니다.",
		Name = "양배추 씨앗",
		QuoteDesc = "채소를 먹자",
	},
	[REVEL.ITEM.HAPHEPHOBIA.id] = {
		Description = "공격 시 주기적으로 주변의 적을 밀쳐내는 파동을 발산합니다.#{{TearsSmall}} 연사가 높을수록 파동의 주기가 짧아집니다.",
		Name = "혐오공포증",
		QuoteDesc = "물러서!",
	},
	[REVEL.ITEM.FERRYMANS_TOLL.id] = {
		Description = "{{Coin}}동전을 2개 드랍합니다.#사망 시 33{{Coin}}을 강제로 소모하여 시작 방에서 부활합니다.#부활할 때마다 소모되는 동전이 33{{Coin}}씩 증가합니다.#동전이 부족한 경우 부활하지 않습니다.",
		Name = "페리맨의 통행료",
		QuoteDesc = "저승 가는 길도 공짜는 아냐",
	},
	[REVEL.ITEM.DEATH_MASK.id] = {
		Description = "적 10기 처치 시 랜덤 적을 아군 Bony로 바꿉니다.",
		Name = "죽음의 가면",
		QuoteDesc = "죽음이란 자연스럽게 온단다",
	},
	[REVEL.ITEM.MIRROR_BOMBS.id] = {
		Description = "↑ {{Bomb}}폭탄 +5#폭탄이 터질 때 그 방의 배경에 따른 랜덤 추가 효과를 발동합니다.",
		Name = "거울 폭탄",
		QuoteDesc = "주변을 반사하는 폭발 + 폭탄 5개",
	},
	[REVEL.ITEM.CHARONS_OAR.id] = {
		Description = "공격 시 공격 방향으로 공격력 33%의 눈물 4발을 추가로 발사합니다.",
		Name = "부서진 노",
		QuoteDesc = "더 많은 눈물",
	},
	[REVEL.ITEM.PERSEVERANCE.id] = {
		Description = "적 하나를 연속적으로 공격 시 그 적이 받는 피해가 최대 3배(보스는 2배)까지 증가합니다.",
		Name = "끈기",
		QuoteDesc = "노력의 결실",
	},
	[REVEL.ITEM.ADDICT.id] = {
		Description = "방 입장 시 알약의 모양을 한 적이 등장하며 해당 적 처치 시 색상에 따른 긍정/부정 알약을 드랍합니다.#알약을 사용하지 않고 다른 방 입장 시 알약 모양의 적의 등장 수가 늘어납니다.",
		Name = "알약 중독",
		QuoteDesc = "1일 1정",
	},
	[REVEL.ITEM.OPHANIM.id] = {
		Description = "2회 공격 시마다 4방향으로 시계 반대방향으로 원을 그리는 눈물을 발사합니다.#피격 시 고리가 분리되어 4방향 공격을 매우 빠른 속도로 발사합니다.#고리가 여러 번 튕기면 캐릭터에게 돌아옵니다.",
		Name = "오파님",
		QuoteDesc = "심판의 눈",
	},
	[REVEL.ITEM.PILGRIMS_WARD.id] = {
		Description = "방 입장 시 랜덤 위치에 빛의 인장이 생깁니다.#캐릭터가 인장에 닿을 시 주변의 적에게 캐릭터의 공격력 x7만큼의 피해를 주는 고리를 생성하며 다른 위치에 인장이 다시 생깁니다.",
		Name = "방랑자의 구",
		QuoteDesc = "빛이 당신의 길을 비출 수 있기를",
	},
	[REVEL.ITEM.WRATHS_RAGE.id] = {
		Description = "↑ {{Bomb}}폭탄 +5#{{Bomb}} 폭탄이 설치와 동시에 폭발합니다.#캐릭터는 자신의 폭탄에 면역이 되며 해당 폭탄에 맞을 때마다 그 방에서 {{DamageSmall}}공격력 +1(연속 증가 시 반감)#3회 맞을 시 그 방에서 캐릭터의 위치에 불을 남깁니다.",
		Name = "분노",
		QuoteDesc = "참을 인, 참을 인",
	},
	[REVEL.ITEM.PRIDES_POSTURING.id] = {
		Description = "클리어하지 않은 방에서 처음 공격 시 {{Collectible486}}피격 시 효과를 발동하며 x자 모양으로 Pride 미니보스의 레이저를 발사합니다.",
		Name = "교만의 자세",
		QuoteDesc = "몰락하기 전에 빛나라",
	},
	[REVEL.ITEM.SLOTHS_SADDLE.id] = {
		Description = "{{SpeedSmall}} 클리어한 방에서 이동속도가 2로 설정됩니다.#적에게 10의 피해를 줄 때마다 적에게 초당 9의 피해를 주는 작은 구더기를 생성합니다.#작은 구더기는 방 클리어 시 서서히 사라집니다.",
		Name = "나태의 안장",
		QuoteDesc = "한 걸음 한 걸음",
	},
	[REVEL.ITEM.LOVERS_LIB.id] = {
		Description = "방 최초 진입 시 액티브/패시브 아이템에 다리가 생겨 캐릭터에게서 도망칩니다.#해당 아이템을 처치하여 다리를 없앨 수 있으나 처치 이전에 아이템 획득 시 장신구를 드랍합니다.",
		Name = "연인의 리비도",
		QuoteDesc = "도망치는 건 더욱 힘들게 하지",
	},

	[REVEL.ITEM.CHUM.id] = {
		Description = "소지 중 적 처치 시 그 자리에서 곤죽이 남습니다.#사용 시 곤죽이 적에게 핏방울, 이빨, 혹은 뼈 공격을 합니다.",
		Name = "곤죽 양동이",
		QuoteDesc = "시체가 이렇게나 좋게 보인 적이 없었어",
	},
	[REVEL.ITEM.ROBOT.id] = {
		Description = "사용 시 캐릭터가 큰 상자를 뒤집어쓰며 15초동안 공격이 사거리가 짧은 레이저 7발로 바뀝니다.#피격 시 체력 대신 지속시간이 감소하며 방 클리어 시 지속시간이 증가합니다.#재사용 및 지속시간 소진 시 캐릭터가 로봇과 분리되며 로봇이 잠시 후 폭발합니다.",
		Name = "골판지 로봇",
		QuoteDesc = "무거운 지원요청",
	},
	[REVEL.ITEM.GFLAME.id] = {
		Description = "사용 시 공격하는 방향으로 최대 공격력 x6의 피해를 주는 불꽃을 발사합니다.#불꽃으로 적 처치 시 아이템에 불이 붙으며 이후 재사용 시 20초 동안 초당 22의 피해를 주는 유령이 소환되며;#유령은 캐릭터의 공격력 x0.2의 불꽃을 지속적으로 남깁니다.",
		Name = "유령 불꽃",
		QuoteDesc = "굶주려 있어",
	},
	[REVEL.ITEM.GFLAME2.id] = {
		Description = "사용 시 공격하는 방향으로 최대 공격력 x6의 피해를 주는 불꽃을 발사합니다.#불꽃으로 적 처치 시 아이템에 불이 붙으며 이후 재사용 시 20초 동안 초당 22의 피해를 주는 유령이 소환되며;#유령은 캐릭터의 공격력 x0.2의 불꽃을 지속적으로 남깁니다.",
		Name = "유령 불꽃",
		QuoteDesc = "굶주려 있어",
	},
	[REVEL.ITEM.WAKA_WAKA.id] = {
		Description = "사용 시 적의 탄환을 과일로 바꾸며 과일을 먹으면 그 스테이지에서 능력치가 증가합니다.#{{DamageSmall}} 체리 : 공격력 +0.1#{{RangeSmall}} 레몬 : 사거리 +1#{{SpeedSmall}} 바나나 : 이동속도 + 0.05#{{ShotspeedSmall}} 오렌지 : 탄속 +0.05",
		Name = "뻐끔 뻐끔",
		QuoteDesc = "놈 놈 놈",
	},
	[REVEL.ITEM.OOPS.id] = {
		Description = "사용 시 그 방의 함정을 발동 및 비활성화합니다.",
		Name = "이런!",
		QuoteDesc = "비결을 숨겨",
	},
	[REVEL.ITEM.MOXIE.id] = {
		Description = "사용 시 주변의 탄환을 반사하며 주변의 적에게 캐릭터의 공격력 x1.2의 피해를 주는 붕대를 휘두릅니다.",
		Name = "모시의 발",
		QuoteDesc = "힘껏 흔들어!",
	},
	[REVEL.ITEM.MUSIC_BOX.id] = {
		Description = "사용 시 일정 시간동안 오르골을 설치하며 그 방에서 4가지 효과 중 하나를 발동합니다:#{{ColorPastelBlue}}자장가{{CR}} : 그 방의 적이 점점 느려지며 잠듭니다. 잠든 적 공격 시 깨어납니다.#{{ColorLavender}}천사{{CR}} : {{ShotspeedSmall}} -2/{{DamageSmall}} +2/{{Collectible3}}#{{ColorRed}}단테{{CR}} : {{SpeedSmall}}+0.3/{{TearsSmall}}딜레이-2/{{Collectible48}}/{{Collectible115}}#{{ColorSilver}}악마{{CR}} : 적이 서로를 공격합니다.",
		Name = "오르골",
		QuoteDesc = "마에스트로님 고마워요",
	},
	[REVEL.ITEM.HALF_CHEWED_PONY.id] = {
		Description = "!!! 소지 시:#비행 능력을 얻습니다.#{{SpeedSmall}} 이동속도가 1.5 이상으로 고정됩니다.#사용 시 접촉한 적에게 피해를 주는 Sandy의 입을 소환합니다.#!!! 5%의 확률로 아이템이 Sandy에게 먹히며 해당 게임 내내 Sandy가 캐릭터를 도와줍니다.#Sandy의 체력 소진 시 그 스테이지에서는 더 이상 활동할 수 없으며 스테이지 진입 시 돌아옵니다.",
		Name = "씹다 만 포니",
		QuoteDesc = "아직 안 끝났어!",
	},
	[REVEL.ITEM.MOXIE_YARN.id] = {
		Description = "사용 시 공격 방향으로 붕대 뭉치를 던지며 이후 45초간 아군 Catastrophe 보스 중 하나를 소환합니다.(최대 4마리)#Catastrophe는 주변의 적에게 공격력 2.5의 할퀴기 공격을 하며 초당 15의 피해를 줍니다.",
		Name = "모시의 털뭉치",
		QuoteDesc = "플레이 타임!",
	},

	[REVEL.ITEM.VIRGIL.id] = {
		Description = "여러 방면으로 캐릭터를 도와줍니다:#{{BossRoom}} 보스방 위치로 안내#{{Bomb}} 바위를 던져 색돌의 위치를 알림(스테이지 당 3회)#{{Collectible11}} 사망 시 전 방에서 최대 체력으로 부활(일회용)#적에게 바위를 던져 자신을 공격하게 함#트롤폭탄을 캐릭터에게서 멀어지게 함",
		Name = "베르길리우스",
		QuoteDesc = "운명은 그의 편",
	},
	[REVEL.ITEM.MIRROR2.id] = {
		Description = "공격 키를 누르고 있는 상태에서 점점 빠르게 회전하며 공격 키를 떼면 회전 속도에 비례한 거리만큼 거울 조각을 던집니다.#조각이 2개 설치되어 있을 시 거울 사이에 들어온 적에게 최대 4회까지 피해를 줍니다.#4회 공격 시 거울을 다시 던져야 활성화됩니다.",
		Name = "거울 조각",
		QuoteDesc = "남은 조각은 이제 하나",
	},
	[REVEL.ITEM.CURSED_GRAIL.id] = {
		Description = "성배가 {{SacrificeRoom}}희생방의 위치로 안내합니다.#{{SacrificeRoom}} 희생방에서 희생 시마다 {{DamageSmall}}공격력 +0.5#최대 6회까지 채울 수 있으며 6회 사용 시 비행 능력을 얻습니다.",
		Name = "저주받은 성배",
		QuoteDesc = "피를 바쳐라",
	},
	[REVEL.ITEM.BANDAGE_BABY.id] = {
		Description = "캐릭터의 주변을 돌며 주변의 적에게 붕대 더미를 던집니다.#적의 탄환을 막으면 붕대 더미가 되며 3초 후 재생성됩니다.#{{Slow}} 붕대 더미에 닿은 적은 잠시동안 느려집니다.",
		Name = "붕대 아기",
		QuoteDesc = "감싸인 친구",
	},
	[REVEL.ITEM.LIL_MICHAEL.id] = {
		Description = "캐릭터의 공격방향 앞으로 이동하여 캐릭터의 공격과 접촉 시 흡수합니다.(공격이 사라지지 않음)#20회 공격 시 적에게 다가가 흡수한 공격의 수만큼 피해를 줍니다.#{{DamageSmall}} :흡수한 공격 수 * 캐릭터의 공격력 * 1.5",
		Name = "리틀 미카엘",
		QuoteDesc = "나에게 힘을 줘",
	},
	[REVEL.ITEM.HUNGRY_GRUB.id] = {
		Description = "공격하는 방향으로 돌진해 접촉하는 적에게  달라붙으며 초당 12의 피해를 줍니다.#적에게 달라붙을 때마다 성장하여 최대 2회까지 피해량이 증가, 최대치일 때 적에게 초당 20의 피해를 주는 붉은 장판을 생성합니다.#성장 단계는 방 입장 시 초기화됩니다.",
		Name = "배고픈 애벌레",
		QuoteDesc = "그에게 먹이를 주자, 그리고 지켜보자",
	},
	[REVEL.ITEM.ENVYS_ENMITY.id] = {
		Description = "캐릭터의 주변을 돌며 눈물에 맞으면 분열합니다.#분열할 때마다 캐릭터에게서 멀어지며 최대 3번까지 분열할 수 있습니다.#적과 접촉 시 분열 단계에 따라 초당 1~5의 피해를 줍니다.#!!! 적의 탄환을 막아주지 않습니다.",
		Name = "질투의 증오",
		QuoteDesc = "머리 들어!",
	},
	[REVEL.ITEM.BARG_BURD.id] = {
		Description = "캐릭터를 따라다니며 공격키를 누르고 있으면 움직이지 않습니다.#자루에 닿은 적은 최소 5의 피해를 받으며 소지 중인 {{Coin}}/{{Key}}/{{Bomb}}의 수량에 따라 피해량이 증가합니다.",
		Name = "상인의 짐",
		QuoteDesc = "좀 나눠갖자",
	},
	[REVEL.ITEM.WILLO.id] = {
		Description = "오라를 가지고 대각선으로 이동하며 오라 안에 캐릭터가 들어오면 {{DamageSmall}}공격력을 x1.3 증가시켜줍니다.#피격 시 캐릭터를 공격한 적에게 유도 눈물을 발사합니다.",
		Name = "윌로",
		QuoteDesc = "부끄부끄",
	},

  -- Not found in origin
	[REVEL.ITEM.LIL_FRIDER.id] = {
		Description = "적에게 9의 피해를 주는 얼음 큐브를 날립니다.#얼음 큐브가 깨지면 아군 Pooter를 최대 3마리까지 소환합니다.",
		Name = "리틀 얼음기사",
		QuoteDesc = "춥지만 멋져",
	},
	[REVEL.ITEM.GUT.id] = {
		Description = "사용 시 2.5초간 주변의 적을 빨아들입니다.#!!! 직후 재사용하거나 공격 시 다른 효과가 발동:#재사용 시 체력을 {{Heart}}한칸 회복합니다.#공격 시 공격 방향으로 덩어리를 발사합니다.",
		Name = "탐욕의 배짱",
		QuoteDesc = "음식을 입에 담고 말하는거 아니다",
	},
	[REVEL.ITEM.PHYLACTERY.id] = {
		Description = "사용 시 반대편 캐릭터로 교체합니다.#아이템을 드는 도중 사용 시 아이템을 반대편 캐릭터에게 보냅니다.",
		Name = "성물함",
		QuoteDesc = "???",
	},
	[REVEL.ITEM.PHYLACTERY_MERGED.id] = {
		Description = "사용 시 Charon의 공격방향을 바꿉니다.",
		Name = "성물함",
		QuoteDesc = "???",
	},

}

local revTrinketDesc = {

  -- Chapter 1
	[REVEL.ITEM.SPARE_CHANGE.id] = {
		Description = "{{Shop}} 상점 입장 시 니켈을 하나 드랍합니다.#{{Arcade}} 오락실 입장 시 3{{Coin}}을 드랍합니다.#{{DevilRoom}} 악마방 입장 시 {{SoulHeart}}소울하트를 하나 드랍합니다.",
		Name = "여분의 거래물품",
		QuoteDesc = "좋은 걸 가져봐!",
	},
	[REVEL.ITEM.LIBRARY_CARD.id] = {
		Description = "{{Library}} 책방에 입장 시 {{Key}}열쇠를 소모하지 않습니다.",
		Name = "도서관 카드",
		QuoteDesc = "열쇠 필요 없음",
	},
	[REVEL.ITEM.ARCHAEOLOGY.id] = {
		Description = "특수 오브젝트(항아리, 버섯 등) 파괴 시 확률적으로 보상을 2배로 드랍합니다.",
		Name = "고고학자의 돋보기",
		QuoteDesc = "뭐가 들었을까",
	},
	[REVEL.ITEM.GAGREFLEX.id] = {
		Description = "{{Collectible149}} {{Pill}}알약 사용 시 그 방에서 구토제를 발사합니다.",
		Name = "사기 알약",
		QuoteDesc = "뭔가 느낌이 안좋아",
	},

  -- Chapter 2
  [REVEL.ITEM.TELESCOPE.id] = {
		Description = "별자리 아이템을 강화시킵니다.#{{Blank}} (Item Reminder에서 확인 가능)",
		Name = "망원경",
		QuoteDesc = "별자리가 더 크게 보여",
	},
  [REVEL.ITEM.SCRATCHED_SACK.id] = {
		Description = "피격되지 않은 상태에서 방 클리어 시 낮은 확률로 그 방의 보상을 하나 더 드랍합니다.",
		Name = "찢어진 자루",
		QuoteDesc = "고양이가 그랬어요!",
	},
  [REVEL.ITEM.MAX_HORN.id] = {
		Description = "액티브 아이템 사용 시 굴렁쇠가 떨어집니다.",
		Name = "맥스웰의 뿔",
		QuoteDesc = "네가 부쉈어!",
	},
  [REVEL.ITEM.MEMORY_CAP.id] = {
		Description = "블랙박스에서 적이 랜덤으로 등장합니다.#블랙박스 접촉 시 캐릭터가 블랙박스가 됩니다.#블랙박스가 된 동안에는 캐릭터가 무적이 됩니다.",
		Name = "맥스웰의 뿔",
		QuoteDesc = "[데이터 제거됨]",
	},
  [REVEL.ITEM.XMAS_STOCKING.id] = {
		Description = "픽업이 등장할 때 25%의 확률로 가장 적게 소지한 픽업으로 교체됩니다.#수량 차이에 비례하여 교체 확률 증가(최대 50%)",
		Name = "크리스마스 소원",
		QuoteDesc = "네가 원하던 모든 것",
	},
}

local revCardDesc = {

  [REVEL.POCKETITEM.LOTTERY_TICKET.Id] = {
		Description = "{{Collectible689}} 사용 시 방 안의 모든 아이템이 5개의 랜덤한 아이템으로 0.2초마다 전환되어 5개의 아이템 중 하나를 선택할 수 있습니다.#선택지의 순서는 랜덤으로 결정됩니다.",
		Name = "로또 티켓",
		QuoteDesc = "",
	},
  [REVEL.POCKETITEM.BELL_SHARD.Id] = {
		Description = "{{Collectible"..REVEL.ITEM.HEAVENLY_BELL.id.."}} 사용 시 아래의 효과 중 하나 발동:#비밀방 입장 시 아이템 소환#슬롯머신 파괴 시 항상 아이템 소환#슬롯머신 파괴 시 많은 동전이 드랍됨#보스방에서 피격당하지 않고 클리어 시 3개의 아이템 중 하나 선택#사망 시 ???로 부활#상점 주인 파괴 시 사다리방으로 가는 트랩도어 생성#{{HardModeSmall}} 하드 모드에서는 힌트가 표시되지 않음",
		Name = "종 파편",
		QuoteDesc = "",
	},

}

for playerType, birthrightdesc in pairs(CharacterDesc) do
	EID:addCharacterInfo(playerType, birthrightdesc.Description, birthrightdesc.Name, "ko_kr")
	if InventoryDescriptions then
		EID:addEntity(InvDescEIDType.PLAYER, InvDescEIDVariant.DEFAULT, playerType, birthrightdesc.Name, birthrightdesc.Detailed, "ko_kr")
	end
	EID:addBirthright(playerType, birthrightdesc.Birthright, birthrightdesc.Name, "ko_kr")
end
for itemID, itemdesc in pairs(revCollectibleDesc) do
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
for itemID, itemdesc in pairs(revTrinketDesc) do
  local desc = itemdesc.Description
  if itemdesc.StatusEffects then
    for _, eff in ipairs(itemdesc.StatusEffects) do
      desc = desc .. eff
    end
  end
  EID:addTrinket(itemID, desc, itemdesc.Name, "ko_kr")
end
for itemID, itemdesc in pairs(revCardDesc) do
  EID:addCard(itemID, itemdesc.Description, itemdesc.Name, "ko_kr")
end

local ShrineTypes = require("scripts.revelations.common.enums.ShrineTypes")

local revShrines = {
  [ShrineTypes.CHAMPIONS] = {
    Name = "챔피언",
    Description = "Revelation 모드의 적이 챔피언으로 등장할 수 있습니다."
        .. "#보스가 챔피언 보스로 나올 확률이 증가합니다."
        .. "#해당 석상의 효과는 중첩됩니다.",
  },
  [ShrineTypes.PUNISHMENT] = {
      Name = "단죄",
      Description = "랜덤 패시브 아이템 하나를 제거합니다."
  },
  [ShrineTypes.MASOCHISM] = {
      Name = "마조히즘",
      Description = "모든 피격을 최소 체력 1칸의 피해로 받습니다."
  },
  [ShrineTypes.SCARCITY] = {
      Name = "희소",
      Description = "모든 픽업이 33%의 확률로 증발합니다."
  },
  [ShrineTypes.GROUNDING] = {
      Name = "대지",
      Description = "이 스테이지에서 비행 능력을 잃습니다."
  },
  [ShrineTypes.PURGATORY] = {
      Name = "연옥",
      Description = "적 처치 시 7.5%의 확률로 캐릭터를 향해 달려오는 유령을 소환합니다."
          .. "#유령은 캐릭터와 접촉 시 폭발합니다."
  },
  [ShrineTypes.BLEEDING] = {
      Name = "출혈",
      Description = "이 스테이지에서 빨간하트가 주기적으로 감소합니다."
  },
  [ShrineTypes.MITOSIS] = {
      Name = "분열",
      Description = "적이 확률적으로 2마리로 등장합니다."
  },

  [ShrineTypes.MISCHIEF_G] = {
    Name = "장난꾸러기",
    Description = "방 안의 픽업을 훔치는 Prank가 생깁니다."
        .. "#Prank는 클리어하지 않은 방에서 캐릭터를 향해 주기적으로 눈덩이를 던집니다."
        .. "#Prank 처치 시 훔친 픽업을 전부 드랍하며 공허치로 판매하는 상점 품목을 할인합니다."
  },
  [ShrineTypes.FROST] = {
      Name = "강추위",
      Description = "불꽃의 범위가 짧아집니다."
          .. "#{{ColorOrange}}Grill O' Wisps{{CR}}가 더 빠르게 움직입니다."
          .. "#눈보라가 더 강해져 캐릭터가 얼기까지의 시간이 짧아집니다."
  },
  [ShrineTypes.FRAGILITY] = {
      Name = "연약",
      Description = "방의 땅이 얼어붙습니다."
          .. "#!!! 캐릭터가 얼음 타일에 서있을 경우 얼음이 깨질 수 있습니다."
          .. "#얼어 있는 적이 움직일 수 있습니다."
  },
  [ShrineTypes.ICE_WRAITH] = {
      Name = "얼음의 망령",
      Description = "특수한 {{ColorBlue}}Chill o' Wisp{{CR}} 몬스터가 캐릭터를 향해 쫓아옵니다.#해당 적의 오라에 오랫동안 있을 경우 일정 시간동안 공격할 수 없습니다."
  },

  [ShrineTypes.MISCHIEF_T] = {
    Name = "단죄",
    Description = "방 안의 픽업을 훔치는 Prank가 생깁니다."
        .. "#Prank는 클리어하지 않은 방에서 주기적으로 함정을 발동합니다."
        .. "#Prank 처치 시 훔친 픽업을 전부 드랍하며 공허치로 판매하는 상점 품목을 할인합니다."
  },
  [ShrineTypes.REVIVAL] = {
    Name = "부활",
    Description = "적 처치 시 붕대가 더 자주 등장합니다.#가끔 보라색 방울이 넝마한테 날아와 닿으면 강화된 상태로 부활시킵니다."
  },
  [ShrineTypes.PERIL] = {
    Name = "위기",
    Description = "함정 타일이 더 자주 등장하며 함정 발동 유무와 무관하게 관에서 몬스터가 나올 수 있습니다."
  },
  [ShrineTypes.PARANOIA] = {
      Name = "파라노이아",
      Description = "모든 함정이 ?로 표시됩니다.#가짜 함정 타일이 등장합니다."
  },
}
revShrines[ShrineTypes.CHAMPIONS_G] = revShrines[ShrineTypes.CHAMPIONS]
revShrines[ShrineTypes.CHAMPIONS_T] = revShrines[ShrineTypes.CHAMPIONS]
--revShrines[ShrineTypes.MISCHIEF_G] = revShrines[ShrineTypes.MISCHIEF]
--revShrines[ShrineTypes.MISCHIEF_T] = revShrines[ShrineTypes.MISCHIEF]
revShrines[ShrineTypes.PUNISHMENT_G] = revShrines[ShrineTypes.PUNISHMENT]
revShrines[ShrineTypes.PUNISHMENT_T] = revShrines[ShrineTypes.PUNISHMENT]
revShrines[ShrineTypes.MASOCHISM_G] = revShrines[ShrineTypes.MASOCHISM]
revShrines[ShrineTypes.MASOCHISM_T] = revShrines[ShrineTypes.MASOCHISM]
revShrines[ShrineTypes.SCARCITY_G] = revShrines[ShrineTypes.SCARCITY]
revShrines[ShrineTypes.SCARCITY_T] = revShrines[ShrineTypes.SCARCITY]
revShrines[ShrineTypes.GROUNDING_G] = revShrines[ShrineTypes.GROUNDING]
revShrines[ShrineTypes.GROUNDING_T] = revShrines[ShrineTypes.GROUNDING]
revShrines[ShrineTypes.PURGATORY_G] = revShrines[ShrineTypes.PURGATORY]
revShrines[ShrineTypes.PURGATORY_T] = revShrines[ShrineTypes.PURGATORY]
revShrines[ShrineTypes.BLEEDING_G] = revShrines[ShrineTypes.BLEEDING]
revShrines[ShrineTypes.BLEEDING_T] = revShrines[ShrineTypes.BLEEDING]
revShrines[ShrineTypes.MITOSIS__G] = revShrines[ShrineTypes.MITOSIS]
revShrines[ShrineTypes.MITOSIS__T] = revShrines[ShrineTypes.MITOSIS]

--REVEL.ENT.CURSED_SHRINE.id
--REVEL.ENT.CURSED_SHRINE.variant

wakaba_krdesc:AddCallback(ModCallbacks.MC_NPC_UPDATE, function(_, npc)
	if npc.Variant ~= REVEL.ENT.CURSED_SHRINE.variant then
		return
	end

	local revelShrineData = REVEL.GetData(npc)
	local shrineData = npc:GetData()
	--print(shrineData.Init, shrineData.ShrineSet, shrineData.ShrineType)
	if shrineData.IsKrDescReplaced then return end
	if not shrineData.EID_Description then return end
	local shrineName = revelShrineData.ShrineType
	local shrineNameKR = revShrines[shrineName].Name
	local shrineDescKR = revShrines[shrineName].Description
	local rewardValue = revelShrineData.Value
	shrineDescKR = shrineDescKR .. ("#↑ 공허치 +%d"):format(rewardValue)
	shrineDescKR = shrineDescKR .. "#공허치는 Revelations 스테이지 2번째 층에서 사용할 수 있습니다."

	shrineData.EID_Description.Name = shrineNameKR
	shrineData.EID_Description.Description = shrineDescKR
	if npc.FrameCount > 1 then
		shrineData.IsKrDescReplaced = true
	end

end, REVEL.ENT.CURSED_SHRINE.id)


return {
	targetMod = "Revelations",
	characters = CharacterDesc,
	collectibles = revCollectibleDesc,
	trinkets = revTrinketDesc,
	cards = revCardDesc,
}

end

