// СУПЕР ПРОСТОЙ UI для контрактов - всего основы!

/datum/simple_contracts_ui
	var/mob/user

/datum/simple_contracts_ui/New(mob/user)
	src.user = user

// Эта функция открывает UI
/datum/simple_contracts_ui/ui_interact(mob/user)
	var/datum/tgui/ui = new(user, src, "SimpleContracts", "My Contracts")
	ui.open()

// Эта функция отправляет данные в интерфейс
/datum/simple_contracts_ui/ui_data(mob/user)
	. = list()
	.["user_name"] = user.real_name
	.["message"] = "Hello from TGUI!"

// Эта функция обрабатывает нажатия кнопок
/datum/simple_contracts_ui/ui_act(action, params)
	switch(action)
		if("test_button")
			to_chat(user, "Кнопка работает!")
			return TRUE
	return FALSE
