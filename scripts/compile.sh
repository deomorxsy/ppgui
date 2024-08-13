#!/bin/sh

#clang -g -O2 -Wall -o plota ./implot.cpp

g++ -o implot_example main.cpp \
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
