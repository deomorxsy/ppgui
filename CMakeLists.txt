cmake_minimum_required(VERSION 3.10)
project(ppgui)

# Add the external libraries (submodules)
add_subdirectory(assets/imgui)
add_subdirectory(assets/implot)


# Enable C++17 standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Define source directories
set(IMGUI_SRC "${CMAKE_SOURCE_DIR}/assets/imgui")
set(IMPLOT_SRC "${CMAKE_SOURCE_DIR}/assets/implot")
set(WASMDIR "${CMAKE_SOURCE_DIR}/glfw_wgpu")


# Apply patches if needed
# Assuming the patch files are stored in the patches/ directory
execute_process(
    COMMAND git apply ${CMAKE_SOURCE_DIR}/assets/patches/imgui.patch
    COMMAND git apply ${CMAKE_SOURCE_DIR}/assets/patches/implot.patch
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/
)

execute_process(
    COMMAND git apply ${CMAKE_SOURCE_DIR}/patches/imgui_patch.diff
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/external/imgui
)

# Include directories
include_directories(${CMAKE_SOURCE_DIR}/external/implot)
include_directories(${CMAKE_SOURCE_DIR}/external/imgui)


set(IMGUI_SOURCES
    ${IMGUI_SRC}/imgui.cpp
    ${IMGUI_SRC}/imgui_draw.cpp
    ${IMGUI_SRC}/imgui_widgets.cpp
    ${IMGUI_SRC}/imgui_demo.cpp
    ${IMGUI_SRC}/imgui_tables.cpp
    ${IMGUI_SRC}/backends/imgui_impl_glfw.cpp
    ${IMGUI_SRC}/backends/imgui_impl_opengl3.cpp
)

set(IMPLOT_SOURCES
    ${IMPLOT_SRC}/implot.cpp
    ${IMPLOT_SRC}/implot_items.cpp
)

# Add your main project source files
#add_executable(MyProject src/main.cpp)
add_executable(./assets/artifacts/ppgui
    ./src/main.cpp
    ${IMGUI_SOURCES}
    ${IMPLOT_SOURCES}
)

# Include directories
target_include_directories(ppgui PRIVATE
    ${IMGUI_SRC}
    ${IMPLOT_SRC}
    ${IMGUI_SRC}/backends
)

# Link the external libraries
target_link_libraries(ppgui PRIVATE glfw GL GLU X11 pthread Xrandr Xi dl                                      )

# Custom target for WebAssembly build
add_custom_target(wasm
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/src/main.cpp ${WASMDIR}
    COMMAND ${CMAKE_COMMAND} --build ${WASMDIR} --config Release --target all -- -f Makefile.emscripten
    COMMAND ${CMAKE_COMMAND} -E rm ${WASMDIR}/main.cpp
    WORKING_DIRECTORY ${WASMDIR}
)


# Serve the WASM build
add_custom_target(serve_wasm
    COMMAND ${CMAKE_COMMAND} -E env ./scripts/cgi.pl ${WASMDIR}/web/index.html
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)

# Custom command for setup (if needed)
add_custom_target(setup
    COMMAND git submodule add https://github.com/emscripten-core/emsdk.git ${CMAKE_SOURCE_DIR}/assets/emsdk/
    COMMAND git submodule add git@github.com:ocornut/imgui.git ${IMGUI_SRC}
    COMMAND git submodule add git@github.com:epezent/implot.git ${IMPLOT_SRC}
    COMMAND patch -p1 < ${CMAKE_SOURCE_DIR}/assets/patches/imgui.patch
    COMMAND patch -p1 < ${CMAKE_SOURCE_DIR}/assets/patches/implot.patch
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)
