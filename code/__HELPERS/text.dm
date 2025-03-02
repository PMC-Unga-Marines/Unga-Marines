#define strip_improper(input_text) replacetext(replacetext(input_text, "\proper", ""), "\improper", "")

GLOBAL_LIST_INIT(ru_key_to_en_key, list("й" = "q", "ц" = "w", "у" = "e", "к" = "r", "е" = "t", "н" = "y", "г" = "u", "ш" = "i", "щ" = "o", "з" = "p", "х" = "\[", "ъ" = "]",
										"ф" = "a", "ы" = "s", "в" = "d", "а" = "f", "п" = "g", "р" = "h", "о" = "j", "л" = "k", "д" = "l", "ж" = ";", "э" = "'",
										"я" = "z", "ч" = "x", "с" = "c", "м" = "v", "и" = "b", "т" = "n", "ь" = "m", "б" = ",", "ю" = "."))

GLOBAL_LIST_INIT(en_key_to_ru_key, list(
	"q" = "й", "w" = "ц", "e" = "у", "r" = "к", "t" = "е", "y" = "н",
	"u" = "г", "i" = "ш", "o" = "щ", "p" = "з",
	"a" = "ф", "s" = "ы", "d" = "в", "f" = "а", "g" = "п", "h" = "р",
	"j" = "о", "k" = "л", "l" = "д", ";" = "ж", "'" = "э", "z" = "я",
	"x" = "ч", "c" = "с", "v" = "м", "b" = "и", "n" = "т", "m" = "ь",
	"," = "б", "." = "ю",
))

/proc/convert_ru_key_to_en_key(_key)
	var/new_key = lowertext(_key)
	new_key = GLOB.ru_key_to_en_key[new_key]
	if(!new_key)
		return _key
	return uppertext(new_key)

/proc/convert_ru_string_to_en_string(text)
	. = ""
	for(var/i in 1 to length_char(text))
		. += convert_ru_key_to_en_key(copytext_char(text, i, i+1))

/proc/sanitize_en_key_to_ru_key(char)
	var/new_char = GLOB.en_key_to_ru_key[lowertext(char)]
	return (new_char != null) ? new_char : char

/proc/sanitize_en_string_to_ru_string(text)
	. = ""
	for(var/i in 1 to length_char(text))
		. += sanitize_en_key_to_ru_key(copytext_char(text, i, i+1))


/proc/format_table_name(table)
	return CONFIG_GET(string/feedback_tableprefix) + table


/proc/readd_quotes(t)
	var/list/repl_chars = list("&#34;" = "\"", "&#39;" = "\"")
	for(var/char in repl_chars)
		var/index = findtext(t, char)
		while(index)
			t = copytext(t, 1, index) + repl_chars[char] + copytext(t, index + 5)
			index = findtext(t, char)
	return t


/// Runs byond's html encoding sanitization proc, after replacing new-lines and tabs for the # character.
/proc/sanitize(text)
	var/static/regex/regex = regex(@"[\n\t]", "g")
	return html_encode(regex.Replace(text, "#"))


/// Runs STRIP_HTML_SIMPLE and sanitize.
/proc/strip_html(text, limit = MAX_MESSAGE_LEN)
	return sanitize(STRIP_HTML_SIMPLE(text, limit))


/// Runs STRIP_HTML_SIMPLE and byond's sanitization proc.
/proc/adminscrub(text, limit = MAX_MESSAGE_LEN)
	return html_encode(STRIP_HTML_SIMPLE(text, limit))


/**
 * Returns the text if properly formatted, or null else.
 *
 * Things considered improper:
 * * Larger than max_length.
 * * Presence of non-ASCII characters if asci_only is set to TRUE.
 * * Only whitespaces, tabs and/or line breaks in the text.
 * * Presence of the <, >, \ and / characters.
 * * Presence of ASCII special control characters (horizontal tab and new line not included).
 * */
/proc/reject_bad_text(text, max_length = 512, ascii_only = TRUE)
	if(ascii_only)
		if(length(text) > max_length)
			return null
		var/static/regex/non_ascii = regex(@"[^\x20-\x7E\u0410-\u044F\u0401\u0451\t\n]")
		if(non_ascii.Find(text))
			return null
	else if(length_char(text) > max_length)
		return null
	var/static/regex/non_whitespace = regex(@"\S")
	if(!non_whitespace.Find(text))
		return null
	var/static/regex/bad_chars = regex(@"[\\<>/\x00-\x08\x11-\x1F]")
	if(bad_chars.Find(text))
		return null
	return text


/**
 * Used to get a properly sanitized input. Returns null if cancel is pressed.
 *
 * Arguments
 ** user - Target of the input prompt.
 ** message - The text inside of the prompt.
 ** title - The window title of the prompt.
 ** max_length - If you intend to impose a length limit - default is 1024.
 ** no_trim - Prevents the input from being trimmed if you intend to parse newlines or whitespace.
*/
/proc/stripped_input(mob/user, message = "", title = "", default = "", max_length = MAX_MESSAGE_LEN, no_trim = FALSE)
	var/user_input = input(user, message, title, default) as text|null
	if(isnull(user_input)) // User pressed cancel
		return
	if(no_trim)
		return copytext(html_encode(user_input), 1, max_length)
	else
		return trim(html_encode(user_input), max_length) //trim is "outside" because html_encode can expand single symbols into multiple symbols (such as turning < into &lt;)

/**
 * Used to get a properly sanitized input in a larger box. Works very similarly to stripped_input.
 *
 * Arguments
 ** user - Target of the input prompt.
 ** message - The text inside of the prompt.
 ** title - The window title of the prompt.
 ** max_length - If you intend to impose a length limit - default is 1024.
 ** no_trim - Prevents the input from being trimmed if you intend to parse newlines or whitespace.
*/
/proc/stripped_multiline_input(mob/user, message = "", title = "", default = "", max_length=MAX_MESSAGE_LEN, no_trim=FALSE)
	var/user_input = input(user, message, title, default) as message|null
	if(isnull(user_input)) // User pressed cancel
		return
	if(no_trim)
		return copytext(html_encode(user_input), 1, max_length)
	else
		return trim(html_encode(user_input), max_length)


#define NO_CHARS_DETECTED 0
#define SPACES_DETECTED 1
#define SYMBOLS_DETECTED 2
#define NUMBERS_DETECTED 3
#define LETTERS_DETECTED 4

//Filters out undesirable characters from names
/proc/reject_bad_name(t_in, allow_numbers = FALSE, max_length = MAX_NAME_LEN, ascii_only = TRUE)
	if(!t_in)
		return //Rejects the input if it is null

	var/number_of_alphanumeric = 0
	var/last_char_group = NO_CHARS_DETECTED
	var/t_out = ""
	var/t_len = length_char(t_in)
	var/charcount = 0
	var/char = ""


	for(var/i = 1, i <= t_len, i += length_char(char))
		char = copytext_char(t_in, i, i+1)

		switch(text2ascii_char(char))
			// A  .. Z
			if(65 to 90)			//Uppercase Letters
				number_of_alphanumeric++
				last_char_group = LETTERS_DETECTED

			// a  .. z
			if(97 to 122)			//Lowercase Letters
				if(last_char_group == NO_CHARS_DETECTED || last_char_group == SPACES_DETECTED || last_char_group == SYMBOLS_DETECTED) //start of a word
					char = uppertext(char)
				number_of_alphanumeric++
				last_char_group = LETTERS_DETECTED

			// 0  .. 9
			if(48 to 57)			//Numbers
				if(last_char_group == NO_CHARS_DETECTED || !allow_numbers) //suppress at start of string
					continue
				number_of_alphanumeric++
				last_char_group = NUMBERS_DETECTED

			// '  -  .
			if(39,45,46)			//Common name punctuation
				if(last_char_group == NO_CHARS_DETECTED)
					continue
				last_char_group = SYMBOLS_DETECTED

			// ~   |   @  :  #  $  %  &  *  +
			if(126,124,64,58,35,36,37,38,42,43)			//Other symbols that we'll allow (mainly for AI)
				if(last_char_group == NO_CHARS_DETECTED || !allow_numbers) //suppress at start of string
					continue
				last_char_group = SYMBOLS_DETECTED

			//Space
			if(32)
				if(last_char_group == NO_CHARS_DETECTED || last_char_group == SPACES_DETECTED) //suppress double-spaces and spaces at start of string
					continue
				last_char_group = SPACES_DETECTED

			if(127 to INFINITY)
				if(ascii_only)
					continue
				last_char_group = SYMBOLS_DETECTED //for now, we'll treat all non-ascii characters like symbols even though most are letters

			else
				continue

		t_out += char
		charcount++
		if(charcount >= max_length)
			break

	if(number_of_alphanumeric < 2)
		return		//protects against tiny names like "A" and also names like "' ' ' ' ' ' ' '"

	if(last_char_group == SPACES_DETECTED)
		t_out = copytext_char(t_out, 1, -1) //removes the last character (in this case a space)

	for(var/bad_name in list("space","floor","wall","r-wall","monkey","unknown","inactive ai"))	//prevents these common metagamey names
		if(cmptext(t_out,bad_name))
			return	//(not case sensitive)

	return t_out

#undef NO_CHARS_DETECTED
#undef SPACES_DETECTED
#undef NUMBERS_DETECTED
#undef LETTERS_DETECTED


//Adds 'char' ahead of 'text' until there are 'count' characters total
/proc/add_leading(text, count, char = " ")
	var/charcount = count - length_char(text)
	var/list/chars_to_add[max(charcount + 1, 0)]
	return jointext(chars_to_add, char) + text

//Adds 'char' behind 'text' until there are 'count' characters total
/proc/add_trailing(text, count, char = " ")
	var/charcount = count - length_char(text)
	var/list/chars_to_add[max(charcount + 1, 0)]
	return text + jointext(chars_to_add, char)

//Returns a string with reserved characters and spaces before the first letter removed
/proc/trim_left(text)
	for(var/i in 1 to length(text))
		if(text2ascii(text, i) <= 32)
			continue
		return copytext(text, i)
	return ""

//Returns a string with reserved characters and spaces after the last letter removed
/proc/trim_right(text)
	for(var/i = length(text), i > 0, i--)
		if(text2ascii(text, i) > 32)
			return copytext(text, 1, i + 1)
	return ""

//Returns a string with reserved characters and spaces after the first and last letters removed
//Like trim(), but very slightly faster. worth it for niche usecases
/proc/trim_reduced(text)
	var/starting_coord = 1
	var/text_len = length(text)
	for (var/i in 1 to text_len)
		if (text2ascii(text, i) > 32)
			starting_coord = i
			break

	for (var/i = text_len, i >= starting_coord, i--)
		if (text2ascii(text, i) > 32)
			return copytext(text, starting_coord, i + 1)

	if(starting_coord > 1)
		return copytext(text, starting_coord)
	return ""

//Returns a string with reserved characters and spaces before the first word and after the last word removed.
/proc/trim(text, max_length)
	if(max_length)
		text = copytext_char(text, 1, max_length)
	return trim_left(trim_right(text))

//Returns a string with the first element of the string capitalized.
/proc/capitalize(t)
	. = t
	if(t)
		. = t[1]
		return uppertext(.) + copytext(t, 1 + length(.))

/proc/stringmerge(text,compare,replace = "*")
//This proc fills in all spaces with the "replace" var (* by default) with whatever
//is in the other string at the same spot (assuming it is not a replace char).
//This is used for fingerprints
	var/newtext = text
	var/text_it = 1 //iterators
	var/comp_it = 1
	var/newtext_it = 1
	var/text_length = length(text)
	var/comp_length = length(compare)
	while(comp_it <= comp_length && text_it <= text_length)
		var/a = copytext_char(text, text_it, text_it+1)
		var/b = copytext_char(compare, comp_it, comp_it+1)
//if it isn't both the same letter, or if they are both the replacement character
//(no way to know what it was supposed to be)
		if(a != b)
			if(a == replace) //if A is the replacement char
				newtext = copytext_char(newtext, 1, newtext_it) + b + copytext_char(newtext, newtext_it + length_char(copytext_char(newtext, newtext_it, newtext_it+1)))
			else if(b == replace) //if B is the replacement char
				newtext = copytext_char(newtext, 1, newtext_it) + a + copytext_char(newtext, newtext_it + length_char(copytext_char(newtext, newtext_it, newtext_it+1)))
			else //The lists disagree, Uh-oh!
				return 0
		text_it += length(a)
		comp_it += length(b)
		newtext_it += length_char(copytext_char(newtext, newtext_it, newtext_it+1))

	return newtext


/proc/stringpercent(text,character = "*")
//This proc returns the number of chars of the string that is the character
//This is used for detective work to determine fingerprint completion.
	if(!text || !character)
		return 0
	var/count = 0
	var/lentext = length(text)
	var/a = ""
	for(var/i = 1, i <= lentext, i += length(a))
		a = copytext_char(text, i, i+1)
		if(a == character)
			count++
	return count


/proc/repeat_string(times, string = "")
	. = ""
	for(var/i in 1 to times)
		. += string


//Used in preferences' SetFlavorText and human's set_flavor verb
//Previews a string of len or less length
/proc/TextPreview(string, length = 40)
	if(length_char(string) > length(string))
		if(length_char(string) > length)
			return "[copytext_char(string, 1, 37)]..."
		if(!length(string))
			return "\[...\]"
		return string
	if(!length(string))
		return "\[...\]"
	if(length(string) > length)
		return "[copytext(string, 1, 37)]..."
	return string


//Used for applying byonds text macros to strings that are loaded at runtime
/proc/apply_text_macros(string)
	var/next_backslash = findtext(string, "\\")
	if(!next_backslash)
		return string

	var/leng = length(string)

	var/next_space = findtext_char(string, " ", next_backslash + length_char(copytext_char(string, next_backslash, next_backslash+1)))
	if(!next_space)
		next_space = leng - next_backslash

	if(!next_space)	//trailing bs
		return string

	var/base = next_backslash == 1 ? "" : copytext(string, 1, next_backslash)
	var/macro = lowertext(copytext_char(string, next_backslash + length_char(copytext_char(string, next_backslash, next_backslash+1)), next_space))
	var/rest = next_backslash > leng ? "" : copytext_char(string, next_space + length_char(copytext_char(string, next_space, next_space+1)))

	//See https://secure.byond.com/docs/ref/info.html#/DM/text/macros
	switch(macro)
		//prefixes/agnostic
		if("the")
			rest = "\the [rest]"
		if("a")
			rest = "\a [rest]"
		if("an")
			rest = "\an [rest]"
		if("proper")
			rest = "\proper [rest]"
		if("improper")
			rest = "\improper [rest]"
		if("roman")
			rest = "\roman [rest]"
		//postfixes
		if("th")
			base = "[rest]\th"
		if("s")
			base = "[rest]\s"
		if("he")
			base = "[rest]\he"
		if("she")
			base = "[rest]\she"
		if("his")
			base = "[rest]\his"
		if("himself")
			base = "[rest]\himself"
		if("herself")
			base = "[rest]\herself"
		if("hers")
			base = "[rest]\hers"

	. = base
	if(rest)
		. += .(rest)


GLOBAL_LIST_INIT(sanitize, list("<script", "/script>", "<iframe", "/iframe>", "<input", "<video", "<body", "<form", "<link", "<applet", "<frameset", "onerror",
	"onpageshow", "onscroll", "onforminput", "oninput", "onstorage", "onresize", "onpopstate", "onpagehide", "ononline", "onoffline", "onmessage", "onload",
	"onhashchange", "onbeforeunload", "onbeforeprint", "onafterprint", "onkeydown", "onkeyup", "onkeypress", "onfocus", "oncontextmenu", "onchange", "onblur",
	"oninvalid", "onreset", "onsearch", "onselect", "onsubmit", "ondblclick", "onclick", "onmousedown", "onmousemove", "onmousewheel", "onwheel", "onmouseup",
	"onmouseover", "onmouseout", "ondrop", "ondragstart", "ondragover", "ondragleave", "ondragenter", "ondragend", "ondrag", "onpaste", "oncut", "oncopy",
	"ontoggle", "onvolumechange", "onwaiting", "ontimeupdate", "onsuspend", "onstalled", "onseeking", "onseeked", "onratechange", "onprogress", "onplaying",
	"onplay", "onpause", "onloadstart", "onloadedmetadata", "onloadeddata", "onended", "onemptied", "ondurationchange", "oncuechange", "oncanplaythrough",
	"oncanplay", "onabort", "<source", "<event-source"))
GLOBAL_PROTECT(sanitize)

/proc/noscript(text)
	for(var/i in GLOB.sanitize)
		text = replacetext(text, i, "")
	return text

/proc/sanitizediscord(text)
	text = replacetext(text, "\improper", "")
	text = replacetext(text, "\proper", "")
	text = replacetext(text, "<@", "")
	text = replacetext(text, "@here", "")
	text = replacetext(text, "@everyone", "")
	return text


GLOBAL_LIST_INIT(zero_character_only, list("0"))
GLOBAL_LIST_INIT(hex_characters, list("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"))
GLOBAL_LIST_INIT(alphabet, list("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"))
GLOBAL_LIST_INIT(binary, list("0","1"))

//json decode that will return null on parse error instead of runtiming.
/proc/safe_json_decode(data)
	try
		return json_decode(data)
	catch
		return


/**
 * Formats a number to human readable form with the appropriate SI unit.
 *
 * Supports SI exponents between 1e-15 to 1e15, but properly handles numbers outside that range as well.
 * Examples:
 * * `siunit(1234, "Pa", 1)` -> `"1.2 kPa"`
 * * `siunit(0.5345, "A", 0)` -> `"535 mA"`
 * * `siunit(1000, "Pa", 4)` -> `"1 kPa"`
 * Arguments:
 * * value - The number to convert to text. Can be positive or negative.
 * * unit - The base unit of the number, such as "Pa" or "W".
 * * maxdecimals - Maximum amount of decimals to display for the final number. Defaults to 1.
 * *
 * * For pressure conversion, use proc/siunit_pressure() below
 */
/proc/siunit(value, unit, maxdecimals=1)
	var/static/list/prefixes = list("f","p","n","μ","m","","k","M","G","T","P")

	// We don't have prefixes beyond this point
	// and this also captures value = 0 which you can't compute the logarithm for
	// and also byond numbers are floats and doesn't have much precision beyond this point anyway
	if(abs(value) <= 1e-18)
		return "0 [unit]"

	var/exponent = clamp(log(10, abs(value)), -15, 15) // Calculate the exponent and clamp it so we don't go outside the prefix list bounds
	var/divider = 10 ** (round(exponent / 3) * 3) // Rounds the exponent to nearest SI unit and power it back to the full form
	var/coefficient = round(value / divider, 10 ** -maxdecimals) // Calculate the coefficient and round it to desired decimals
	var/prefix_index = round(exponent / 3) + 6 // Calculate the index in the prefixes list for this exponent

	// An edge case which happens if we round 999.9 to 0 decimals for example, which gets rounded to 1000
	// In that case, we manually swap up to the next prefix if there is one available
	if(coefficient >= 1000 && prefix_index < 11)
		coefficient /= 1e3
		prefix_index++

	var/prefix = prefixes[prefix_index]
	return "[coefficient] [prefix][unit]"
