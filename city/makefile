
small: makefile city_small.png
	open city_small.png

big: makefile city_big.png
	open city_big.png

city_small.png: makefile city.pov
	povray +H100 +W100 city.pov +ocity_small.png

city_big.png: makefile city.pov
	povray +H1024 +W1024 +A city.pov +ocity_big.png