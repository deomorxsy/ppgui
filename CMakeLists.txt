cmake_minimum_required(VERSION 3.10)
project(MyProject)

# Add the external libraries (submodules)
add_subdirectory(external/implot)
add_subdirectory(external/imgui)

# Apply patches if needed
# Assuming the patch files are stored in the patches/ directory
execute_process(
    COMMAND git apply ${CMAKE_SOURCE_DIR}/patches/implot_patch.diff
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/external/implot
)

execute_process(
    COMMAND git apply ${CMAKE_SOURCE_DIR}/patches/imgui_patch.diff
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/external/imgui
)

# Include directories
include_directories(${CMAKE_SOURCE_DIR}/external/implot)
include_directories(${CMAKE_SOURCE_DIR}/external/imgui)

# Add your main project source files
add_executable(MyProject src/main.cpp)

# Link the external libraries
target_link_libraries(MyProject PRIVATE implot imgui)

