// ammo boxes

/obj/item/ammo_magazine/packet
	name = "box of some kind of ammo"
	desc = "A packet containing some kind of ammo."
	icon = 'icons/obj/items/ammo/packet.dmi'
	icon_state_mini = "ammo_packet"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_magazine/packet/attack_hand_alternate(mob/living/user)
	. = ..()
	if(current_rounds <= 0)
		balloon_alert(user, "Empty")
		return
	create_handful(user)

/obj/item/ammo_magazine/packet/p10x24mm
	name = "box of 10x24mm FMJ"
	desc = "A box containing 150 rounds of 10x24mm caseless."
	caliber = CALIBER_10X24_CASELESS
	icon_state = "box_10x24mm"
	ammo_band_icon = "box_10x24mm_band"
	default_ammo = /datum/ammo/bullet/rifle
	current_rounds = 150
	max_rounds = 150

/obj/item/ammo_magazine/packet/pnato
	name = "box of 5.56x45mm"
	desc = "A box containing 150 rounds of 5.56x45mm."
	caliber = CALIBER_556X45
	icon_state = "box_556mm"
	default_ammo = /datum/ammo/bullet/rifle
	current_rounds = 150
	max_rounds = 150

/obj/item/ammo_magazine/packet/groza
	name = "box of 7.62x39mm"
	desc = "A box containing 120 rounds of 7.62x39mm."
	caliber = CALIBER_762X39
	icon_state = "box_76239mm"
	default_ammo = /datum/ammo/bullet/rifle/mpi_km
	current_rounds = 120
	max_rounds = 120

/obj/item/ammo_magazine/packet/groza/ap
	name = "box of AP 7.62x39mm"
	desc = "A box containing 120 AP rounds of 7.62x39mm."
	caliber = CALIBER_762X39
	icon_state = "box_76239mm"
	default_ammo = /datum/ammo/bullet/rifle/mpi_km/ap
	current_rounds = 120
	max_rounds = 120

/obj/item/ammo_magazine/packet/groza/hp
	name = "box of HP 7.62x39mm"
	desc = "A box containing 120 HP rounds of 7.62x39mm."
	caliber = CALIBER_762X39
	icon_state = "box_76239mm"
	default_ammo = /datum/ammo/bullet/rifle/mpi_km/hp
	current_rounds = 120
	max_rounds = 120

/obj/item/ammo_magazine/packet/p10x265mm
	name = "box of 10x26.5mm"
	desc = "A box containing 100 rounds of 10x26.5mm caseless."
	caliber = CALIBER_10X265_CASELESS
	icon_state = "box_10x265mm"
	default_ammo = /datum/ammo/bullet/rifle/br64
	current_rounds = 100
	max_rounds = 100

/obj/item/ammo_magazine/packet/p10x27mm
	name = "box of 10x27mm"
	desc = "A box containing 100 rounds of 10x27mm caseless."
	caliber = CALIBER_10X27_CASELESS
	icon_state = "box_10x27mm"
	default_ammo = /datum/ammo/bullet/rifle/dmr37
	current_rounds = 100
	max_rounds = 100

/obj/item/ammo_magazine/packet/p10x25mm
	name = "box of 10x25mm FMJ"
	desc = "A box containing 125 rounds of 10x25mm caseless."
	caliber = CALIBER_10X25_CASELESS
	icon_state = "box_10x25mm"
	ammo_band_icon = "box_10x25mm_band"
	default_ammo = /datum/ammo/bullet/rifle/heavy
	current_rounds = 125
	max_rounds = 125

/obj/item/ammo_magazine/packet/p492x34mm
	name = "box of 4.92x34mm"
	desc = "A box containing 210 rounds of 4.92x34mm caseless."
	caliber = CALIBER_492X34_CASELESS
	icon_state = "box_492x34mm"
	default_ammo = /datum/ammo/bullet/rifle/hv
	current_rounds = 210
	max_rounds = 210

/obj/item/ammo_magazine/packet/p86x70mm
	name = "box of 8.6x70mm"
	desc = "A box containing 50 rounds of 8.6x70mm caseless."
	caliber = CALIBER_86X70
	icon_state = "box_86x70mm"
	default_ammo = /datum/ammo/bullet/sniper/pfc
	current_rounds = 50
	max_rounds = 50

/obj/item/ammo_magazine/packet/smart_minigun
	name = "SG-85 ammo bin"
	desc = "A hefty container stuffed to the absolute brim with 500 rounds for the SG-85 powerpack."
	icon_state = "box_smartminigun"
	default_ammo = /datum/ammo/bullet/smart_minigun
	caliber = CALIBER_10X26_CASELESS
	current_rounds = 500
	max_rounds = 500
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_magazine/packet/scout_rifle
	name = "Box of A19 high velocity bullets"
	desc = "A box containing 150 rounds of A19 overpressuered high velocity."
	icon_state = "box_tx8"
	default_ammo = /datum/ammo/bullet/rifle/tx8
	caliber = CALIBER_10X28_CASELESS
	current_rounds = 150
	max_rounds = 150

/obj/item/ammo_magazine/packet/scout_rifle/impact
	name = "Box of A19 high velocity impact bullets"
	desc = "A box containing 150 rounds of A19 impact high velocity."
	icon_state = "box_tx8_impact"
	default_ammo = /datum/ammo/bullet/rifle/tx8/impact

/obj/item/ammo_magazine/packet/scout_rifle/incendiary
	name = "Box of A19 high velocity incendiary bullets"
	desc = "A box containing 150 rounds of A19 incendiary high velocity."
	icon_state = "box_tx8_incendiary"
	default_ammo = /datum/ammo/bullet/rifle/tx8/incendiary

/obj/item/ammo_magazine/packet/sr81
	name = "box of low-pressure 8.6x70mm"
	desc = "A box containing 120 rounds of 8.6x70mm low velocity."
	icon_state = "box_t81"
	default_ammo = /datum/ammo/bullet/sniper/auto
	caliber = CALIBER_86X70
	current_rounds = 100
	max_rounds = 100

/obj/item/ammo_magazine/packet/standardautoshotgun
	name = "box of 16 Gauge shotgun slugs"
	desc = "A box containing 16 Gauge slugs, they look like they'd fit in the SH-15."
	icon_state = "box_16gslug"
	default_ammo = /datum/ammo/bullet/shotgun/sh15_slug
	caliber = CALIBER_16G
	current_rounds = 60
	max_rounds = 60

/obj/item/ammo_magazine/packet/standardautoshotgun/flechette
	name = "box of 16 Gauge shotgun flechette shells"
	desc = "A box containing 16 Gauge flechette shells, they look like they'd fit in the SH-15."
	icon_state = "box_16gflech"
	default_ammo = /datum/ammo/bullet/shotgun/sh15_flechette

// pistol packets

/obj/item/ammo_magazine/packet/p9mm
	name = "packet of 9mm"
	desc = "A packet containing 70 rounds of 9mm."
	caliber = CALIBER_9X19
	icon_state = "box_9mm"
	ammo_band_icon = "box_9mm_band"
	current_rounds = 70
	max_rounds = 70
	w_class = WEIGHT_CLASS_SMALL
	default_ammo = /datum/ammo/bullet/pistol

/obj/item/ammo_magazine/packet/magnum
	name = "packet of .44 magnum"
	icon_state = "box_44mag" //Maybe change this
	default_ammo = /datum/ammo/bullet/revolver/r44
	caliber = CALIBER_44
	current_rounds = 49
	max_rounds = 49
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_magazine/packet/mateba
	name = "packet of .454 casull"
	icon_state = "box_454"
	default_ammo = /datum/ammo/bullet/revolver/highimpact
	caliber = CALIBER_454
	current_rounds = 42
	max_rounds = 42

/obj/item/ammo_magazine/packet/acp
	name = "box of .45 ACP"
	icon_state = "box_.45acp"
	default_ammo = /datum/ammo/bullet/smg/acp
	w_class = WEIGHT_CLASS_NORMAL
	caliber = CALIBER_45ACP
	current_rounds = 160
	max_rounds = 160

/obj/item/ammo_magazine/packet/acp/ap
	name = "box of .45 ACP(AP)"
	icon_state = "box_.45acp_ap"
	default_ammo = /datum/ammo/bullet/smg/acp/ap

/obj/item/ammo_magazine/packet/acp/hp
	name = "box of .45 ACP(HP)"
	icon_state = "box_.45acp_hp"
	default_ammo = /datum/ammo/bullet/smg/acp/hp

/obj/item/ammo_magazine/packet/rifle762X39
	name = "box of 7.62X39"
	icon_state = "box_7.62x39mm"
	default_ammo = /datum/ammo/bullet/rifle/mpi_km
	w_class = WEIGHT_CLASS_NORMAL
	caliber = CALIBER_762X39
	current_rounds = 150
	max_rounds = 150

/obj/item/ammo_magazine/packet/svd762x54mmR
	name = "box of 7.62X54"
	icon_state = "box_7.62x54mm"
	default_ammo = /datum/ammo/bullet/sniper/svd
	w_class = WEIGHT_CLASS_NORMAL
	caliber = CALIBER_762X54
	current_rounds = 50
	max_rounds = 50

/obj/item/ammo_magazine/packet/p9mm/ap
	name = "packet of 9mm AP"
	desc = "A packet containing 70 rounds of 9mm armor-piercing."
	ammo_band_color = AMMO_BAND_COLOR_AP
	default_ammo = /datum/ammo/bullet/pistol/ap

/obj/item/ammo_magazine/packet/p9mm/hp
	name = "packet of 9mm HP"
	desc = "A packet containing 70 rounds of 9mm hollow-point."
	ammo_band_color = AMMO_BAND_COLOR_HOLLOWPOINT
	default_ammo = /datum/ammo/bullet/pistol/hp

/obj/item/ammo_magazine/packet/p9mm/incendiary
	name = "packet of 9mm incendiary"
	desc = "A packet containing 70 rounds of 9mm incendiary."
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY
	default_ammo = /datum/ammo/bullet/pistol/incendiary

/obj/item/ammo_magazine/packet/p10x26mm
	name = "packet of 10x26mm"
	desc = "A packet containing 100 rounds of 10x26mm caseless."
	icon_state = "box_10x26mm"
	caliber = CALIBER_10X26_CASELESS
	default_ammo = /datum/ammo/bullet/rifle/machinegun
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 100
	max_rounds = 100

/obj/item/ammo_magazine/packet/p10x20mm
	name = "packet of 10x20mm"
	desc = "A packet containing 125 rounds of 10x20mm caseless."
	icon_state = "box_10x20mm"
	caliber = CALIBER_10X20_CASELESS
	default_ammo = /datum/ammo/bullet/smg
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 150
	max_rounds = 150

/obj/item/ammo_magazine/packet/p4570
	name = "packet of .45-70"
	desc = "A packet containing 50 rounds of .45-70 Government."
	caliber = CALIBER_4570
	icon_state = "box_4570rim_mag"
	icon_state_mini = "ammo_packet_blue"
	default_ammo = /datum/ammo/bullet/rifle/repeater
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 50
	max_rounds = 50

/obj/item/ammo_magazine/packet/p380acp
	name = "packet of .380 ACP"
	desc = "A packet containing 210 rounds of .380 ACP."
	caliber = CALIBER_380ACP
	icon_state = "box_380acp"
	default_ammo = /datum/ammo/bullet/pistol/tiny/ap
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 210
	max_rounds = 210

/obj/item/ammo_magazine/packet/long_special
	name = "box of .44 Long Special"
	desc = "A packet containing 40 rounds of .44 Long Special."
	icon_state = "44LSbox"
	default_ammo = /datum/ammo/bullet/revolver/rifle
	caliber = CALIBER_44LS
	current_rounds = 40
	icon_state_mini = "44LSbox"
	max_rounds = 40

/obj/item/ammo_magazine/packet/t25
	name = "box of 10x26mm high-pressure"
	desc = "A box containing 300 rounds of 10x26mm 'HP' caseless tuned for a smartgun."
	icon_state = "box_t25"
	default_ammo = /datum/ammo/bullet/rifle/t25
	caliber = CALIBER_10X26_CASELESS
	current_rounds = 300
	max_rounds = 300

/obj/item/ammo_magazine/packet/acp_smg
	name = "box of .45 ACP HP"
	desc = "A box containing common .45 ACP hollow-point rounds."
	icon_state = "box_45acp"
	default_ammo = /datum/ammo/bullet/smg/acp
	w_class = WEIGHT_CLASS_SMALL
	caliber = CALIBER_45ACP
	current_rounds = 120
	max_rounds = 120

/obj/item/ammo_magazine/packet/t500
	name = "packet of .500 Nigro Express"
	icon_state = "boxt500"
	default_ammo = /datum/ammo/bullet/revolver/t500
	caliber = CALIBER_500
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 50
	max_rounds = 50
	used_casings = 5

/obj/item/ammo_magazine/packet/t500/qk
	name = "packet of .500 'Queen Killer'"
	icon_state = "boxt500_qk"
	default_ammo = /datum/ammo/bullet/revolver/t500/qk

/obj/item/ammo_magazine/packet/t500/slavs
	name = "packet of .500 'Slavs'"
	icon_state = "boxt500_sv"
	default_ammo = /datum/ammo/bullet/revolver/t500/slavs

/obj/item/ammo_magazine/packet/standard_magnum
	name = "packet of .12x7mm"
	icon_state = "box_t76"
	default_ammo = /datum/ammo/bullet/revolver/t76
	caliber = CALIBER_12X7
	w_class = WEIGHT_CLASS_SMALL
	current_rounds = 50
	max_rounds = 50
	used_casings = 5

/obj/item/ammo_magazine/packet/p10x24mm/ap
	name = "box of 10x24mm AP"
	desc = "A box containing 150 armor piercing rounds of 10x24mm caseless."
	ammo_band_color = AMMO_BAND_COLOR_AP
	default_ammo = /datum/ammo/bullet/rifle/ap

/obj/item/ammo_magazine/packet/p10x24mm/incendiary
	name = "box of 10x24mm incendiary"
	desc = "A box containing 150 incendiary rounds of 10x24mm caseless."
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY
	default_ammo = /datum/ammo/bullet/rifle/incendiary

/obj/item/ammo_magazine/packet/p10x24mm/hp
	name = "box of 10x24mm HP"
	desc = "A box containing 150 hollow-point rounds of 10x24mm caseless."
	ammo_band_color = AMMO_BAND_COLOR_HOLLOWPOINT
	default_ammo = /datum/ammo/bullet/rifle/hp

/obj/item/ammo_magazine/packet/p10x25mm/ap
	name = "box of 10x25mm AP"
	desc = "A box containing 125 armor piercing rounds of 10x25mm caseless."
	ammo_band_color = AMMO_BAND_COLOR_AP
	default_ammo = /datum/ammo/bullet/rifle/heavy/ap

/obj/item/ammo_magazine/packet/p10x25mm/hp
	name = "box of 10x25mm HP"
	desc = "A box containing 125 hollow-point rounds of 10x25mm caseless."
	ammo_band_color = AMMO_BAND_COLOR_HOLLOWPOINT
	default_ammo = /datum/ammo/bullet/rifle/heavy/hp

/obj/item/ammo_magazine/packet/p10x25mm/incendiary
	name = "box of 10x25mm incendiary"
	desc = "A box containing 125 incendiary rounds of 10x25mm caseless."
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY
	default_ammo = /datum/ammo/bullet/rifle/heavy/incendiary

/obj/item/ammo_magazine/packet/p10x265mm/ap
	desc = "A box containing 100 armor piercing rounds of 10x26.5mm caseless."
	icon_state = "box_10x265mm_ap"
	default_ammo = /datum/ammo/bullet/rifle/br64/ap

/obj/item/ammo_magazine/packet/p10x20mm/ap
	desc = "A packet containing 125 rounds of 10x20mm caseless."
	icon_state = "box_10x20mm_ap"
	default_ammo = /datum/ammo/bullet/smg/ap

/obj/item/ammo_magazine/packet/sg62
	name = "box of 10x27mm"
	desc = "A box containing 200 rounds of 10x27mm caseless."
	icon_state = "box_sg62"
	default_ammo = /datum/ammo/bullet/sg62
	caliber = CALIBER_10X27_CASELESS
	current_rounds = 200
	max_rounds = 200
