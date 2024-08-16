.DEFAULT_GOAL := all

CC=gcc
CFLAGS=-I.
DEPS = queue.h

IMGUI_SRC=./assets/imgui
IMPLOT_SRC=./assets/implot
SOURCES=$(wildcard $(IMGUI_SRC)) $(wildcard $(IMGUI_PLOT))

WASMDIR="./glfw"

all: imgui wasm

imgui:
	./scripts/compile.sh compile

wasm:
	cp ./src/main.cpp $(WASMDIR)
	$(MAKE) -C $(WASMDIR) -f Makefile.emscripten
	$(clean)


serve_wasm:
	./scripts/cgi.pl ./glfw/web/index.html

clean:
	rm $(WASMDIR)/main.cpp
