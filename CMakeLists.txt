# Define the minimum cmake. This is my installed version.
cmake_minimum_required (VERSION 2.8)

# Define the minimum policy version.
cmake_policy(VERSION 2.8)

# Define the project name.
project(MyBooks)

set (DATADIR "${CMAKE_INSTALL_PREFIX}/share")
set (PKGDATADIR "${DATADIR}/mybooks")
set (GETTEXT_PACKAGE "mybooks")
set (RELEASE_NAME "O-One")
set (VERSION "0.1")
set (CMAKE_C_FLAGS "-ggdb")

configure_file (${CMAKE_SOURCE_DIR}/src/Config.vala.cmake ${CMAKE_SOURCE_DIR}/src/Config.vala)
add_definitions(-DGETTEXT_PACKAGE=\"${GETTEXT_PACKAGE}\")

# Load the modules placed into the ./cmake directory.
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

# Add the src directory. CMake will look for the CMakeLists.txt in this folder
# and work from there.
add_subdirectory (src)