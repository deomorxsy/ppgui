#!/bin/sh

#clang -g -O2 -Wall -o plota ./implot.cpp
IMGUI_SRC="./assets/imgui/"
IMPLOT_SRC="./assets/implot/"

compile() {
if [ -d "$IMGUI_SRC"] && [ -d "$IMPLOT" ]; then
    g++ -o implot_example ./src/main.cpp \
    assets/imgui/imgui.cpp \
    assets/imgui/imgui_draw.cpp \
    assets/imgui/imgui_widgets.cpp \
    assets/imgui/imgui_demo.cpp \
    assets/imgui/imgui_tables.cpp \
    assets/implot/implot_items.cpp \
    assets/implot/implot.cpp \
    assets/imgui/backends/imgui_impl_glfw.cpp \
    assets/imgui/backends/imgui_impl_opengl3.cpp \
    -Iimgui \
    -Iimplot \
    -Ibackends \
    -lglfw -lGL -lGLU -lX11 -lpthread -lXrandr -lXi -ldl
else
    setup
fi
}

setup() {
    # deps
    git clone git@github.com:ocornut/imgui.git
    cd assets || return
    git clone git@github.com:ocornut/imgui.git
    git clone git@github.com:epezent/implot.git
    cd - || return

    #-Naru for a single file
    # diff step
    diff -crB./assets/imgui ./assets/imgui-cpy > ./assets/patches/imgui.patch
    diff -crB ./assets/implot ./assets/implot-cpy > ./assets/patches/imgui.patch

    # apply patches
    patch -p1 < ./assets/patches/imgui.patch
    patch -p1 < ./assets/patches/implot.patch

}
