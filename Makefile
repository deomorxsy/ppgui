.DEFAULT_GOAL := all

CC=gcc
CFLAGS=-I.
DEPS = queue.h

IMGUI_SRC=./assets/imgui
IMPLOT_SRC=./assets/implot
SOURCES=$(wildcard $(IMGUI_SRC)) $(wildcard $(IMGUI_PLOT))

WASMDIR="./glfw_wgpu"

all: imgui wasm

imgui:
	./scripts/compile.sh; compile

wasm:
	$(MAKE) -C $(WASMDIR) M=$(PWD)

serve_wasm:
	./scripts/cgi.pl ./glfw_wgpu/web/index.html
