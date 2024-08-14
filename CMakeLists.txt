cmake_minimum_required(VERSION 3.10)
project(ppgui)

# Add the external libraries (submodules)
add_subdirectory(assets/imgui)
add_subdirectory(assets/implot)

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

# Add your main project source files
#add_executable(MyProject src/main.cpp)
add_executable(ppgui ./src/main.cpp)

# Link the external libraries
target_link_libraries(ppgui PRIVATE implot imgui)

