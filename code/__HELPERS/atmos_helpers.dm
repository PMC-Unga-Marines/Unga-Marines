///Moves the icon of the device based on the piping layer and on the direction
#define PIPING_LAYER_SHIFT(T, PipingLayer) \
	if(T.layer > -1) { \
		if(T.dir & (NORTH|SOUTH)) { \
			T.pixel_x = (PipingLayer - PIPING_LAYER_DEFAULT) * PIPING_LAYER_P_X;\
		} \
		if(T.dir & (EAST|WEST)) { \
			T.pixel_y = (PipingLayer - PIPING_LAYER_DEFAULT) * PIPING_LAYER_P_Y;\
		} \
	} else { \
		if(T.dir & (NORTH|SOUTH)) { \
			T.pixel_w = (PipingLayer - PIPING_LAYER_DEFAULT) * PIPING_LAYER_P_X;\
		} \
		if(T.dir & (EAST|WEST)) { \
			T.pixel_z = (PipingLayer - PIPING_LAYER_DEFAULT) * PIPING_LAYER_P_Y;\
		} \
	}

///Moves the icon of the device based on the piping layer on both x and y
#define PIPING_LAYER_DOUBLE_SHIFT(T, PipingLayer) \
	if(T.layer > -1) { \
		T.pixel_x = (PipingLayer - PIPING_LAYER_DEFAULT) * PIPING_LAYER_P_X;\
		T.pixel_y = (PipingLayer - PIPING_LAYER_DEFAULT) * PIPING_LAYER_P_Y; \
	} else { \
		T.pixel_w = (PipingLayer - PIPING_LAYER_DEFAULT) * PIPING_LAYER_P_X;\
		T.pixel_z = (PipingLayer - PIPING_LAYER_DEFAULT) * PIPING_LAYER_P_Y; \
	}

///Moves the icon of the device based on the piping layer and on the direction, the shift amount is dictated by more_shift
#define PIPING_FORWARD_SHIFT(T, PipingLayer, more_shift) \
	if(T.layer > -1) { \
		if(T.dir & (NORTH|SOUTH)) { \
			T.pixel_y += more_shift * (PipingLayer - PIPING_LAYER_DEFAULT);\
		} \
		if(T.dir & (EAST|WEST)) { \
			T.pixel_x += more_shift * (PipingLayer - PIPING_LAYER_DEFAULT);\
		} \
	} else { \
		if(T.dir & (NORTH|SOUTH)) { \
			T.pixel_z += more_shift * (PipingLayer - PIPING_LAYER_DEFAULT);\
		} \
		if(T.dir & (EAST|WEST)) { \
			T.pixel_w += more_shift * (PipingLayer - PIPING_LAYER_DEFAULT);\
		} \
	}
