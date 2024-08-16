#!/bin/sh

#clang -g -O2 -Wall -o plota ./implot.cpp
IMGUI_SRC="./assets/imgui/"
IMPLOT_SRC="./assets/implot/"
EMSDK_SRC="./assets/emsdk/"
#IMGUI_PATCH="./assets/patches/imgui.patch"
#IMPLOT_PATCH="./assets/patches/implot.patch"

compile() {
if [ -d "$IMGUI_SRC" ] && [ -d "$IMPLOT_SRC" ] && [ -d "$EMSDK_SRC" ]; then
    em++ -o ./glfw/web/wasmgui ./src/main.cpp \
    assets/imgui/imgui.cpp \
    assets/imgui/imgui_draw.cpp \
    assets/imgui/imgui_widgets.cpp \
    assets/imgui/imgui_demo.cpp \
    assets/imgui/imgui_tables.cpp \
    assets/implot/implot_items.cpp \
    assets/implot/implot.cpp \
    assets/imgui/backends/imgui_impl_glfw.cpp \
    assets/imgui/backends/imgui_impl_opengl3.cpp \
    -Iassets/imgui \
    -Iassets/implot \
    -Iassets/imgui/backends \
    -lglfw -lGL -lGLU -lX11 -ldl
    #-lpthread -lXrandr -lXi kept out
else
    echo "Call setup first."
    #setup
fi
}

setup() {
    # deps
    if [ ! -d "$IMGUI_SRC" ]; then
    cd assets || return
    git submodule add https://github.com/emscripten-core/emsdk.git ./assets/emsdk/
    git submodule add git@github.com:ocornut/imgui.git ./assets/imgui/
    git submodule add git@github.com:epezent/implot.git ./assets/implot/
    cd - || return

    # apply patches; these are under version control
    patch -p1 < "$IMGUI_PATCH"
    patch -p1 < "$IMPLOT_PATCH"
    fi
}

#diffing() {
#        if []cp -r "$IMGUI_SRC" ./assets/imgui-cpy
#        diff -crB./assets/imgui ./assets/imgui-cpy > "$IMGUI_PATCH"
#        patch -p1 < ./assets/patches/imgui.patch
#}

# posix boolean check
if [ "$1" = "compile" ]; then
    compile
else
    echo "Invalid function name. Please specify one of: function1, function2, function3"
fi
