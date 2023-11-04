all:
	mkdir -p build release
	bin/scpp scpp/main.c build/scpp.i
	bin/scpp scc_main.c build/scc.i
	bin/scpp asm/main.c build/asm.i
	bin/scc build/scpp.i build/scpp.asm
	bin/scc build/scc.i build/scc.asm
	bin/scc build/asm.i build/asm.asm
	bin/asm build/scpp.asm release/scpp
	bin/asm build/scc.asm release/scc
	bin/asm build/asm.asm release/asm
	cmp bin/scpp release/scpp
	cmp bin/scc release/scc
	cmp bin/asm release/asm
clean:
	rm -rf build release
