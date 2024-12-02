/datum/supply_order
	var/id
	var/orderer
	var/orderer_rank
	var/orderer_ckey
	var/reason
	var/authorised_by
	var/list/datum/supply_packs/pack
	///What faction ordered this
	var/faction = FACTION_TERRAGOV

/datum/export_report
	/// How many points from that export
	var/points
	/// Name of the item exported
	var/export_name
	/// What faction did the export
	var/faction

/datum/export_report/New(_points, _export_name, _faction)
	points = _points
	export_name = _export_name
	faction = _faction
