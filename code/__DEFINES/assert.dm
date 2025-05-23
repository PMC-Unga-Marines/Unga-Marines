#undef ASSERT

/// Override BYOND's native ASSERT to optionally specify a message
#define ASSERT(condition, message...) \
	if (!(condition)) { \
		CRASH(assertion_message(__FILE__, __LINE__, #condition, ##message)) \
	}

///Used by ASSERT to add a more detailed context to CRASH messages
/proc/assertion_message(file, line, condition, message)
	if(!isnull(message))
		message = " - [message]"

	return "[file]:[line]:Assertion failed: [condition][message]"
