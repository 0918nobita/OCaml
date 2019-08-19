build:
	g++ -c -I /usr/local/lib/ocaml hello.cpp
	libtool -static -o libhello.a hello.o
	ocamlc -a -o hellolib.cma -cclib -lhello
	ocamlc -o hello -custom hellolib.cma -cclib -lstdc++ main.ml

clean:
	rm -f hello.o libhello.a hellolib.cma main.cmi main.cmo hello
