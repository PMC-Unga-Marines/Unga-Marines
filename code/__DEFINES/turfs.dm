//supposedly the fastest way to do this according to https://gist.github.com/Giacom/be635398926bb463b42a
#define RANGE_TURFS(RADIUS, CENTER) \
block( \
	locate(max(CENTER.x - (RADIUS), 1 ),   max(CENTER.y - (RADIUS), 1), CENTER.z), \
	locate(min(CENTER.x + (RADIUS), world.maxx), min(CENTER.y + (RADIUS), world.maxy), CENTER.z) \
)

#define TURF_FROM_COORDS_LIST(List) (locate(List[1], List[2], List[3]))
