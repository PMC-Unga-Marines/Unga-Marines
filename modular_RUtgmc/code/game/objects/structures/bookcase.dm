/obj/structure/bookcase/ex_act(severity)
	if(prob(severity / 3))
		for(var/obj/item/book/our_book in contents)
			if(prob(severity / 2))
				qdel(our_book)
			else
				our_book.forceMove(get_turf(src))
		qdel(src)
