find_package(Vala REQUIRED)

# Ensure we have a compatible version.
include(ValaVersion)
ensure_vala_version("0.18.0" MINIMUM)

# Include the precompile modules to set things up.
include(ValaPrecompile)

# Declaring our dependancies.
find_package(PkgConfig)
pkg_check_modules(DEPS REQUIRED gobject-2.0 glib-2.0 gio-2.0 gtk+-3.0 gee-1.0 granite)

set(CFLAGS
    ${DEPS_CFLAGS} ${DEPS_CFLAGS_OTHER}
)
set(LIB_PATHS
    ${DEPS_LIBRARY_DIRS}
)
link_directories(${LIB_PATHS})

add_definitions(${CFLAGS} "-DGETTEXT_PACKAGE=\"books\"")

vala_precompile(VALA_C
    BooksApp.vala
    Library.vala
    Widgets/Sidebar.vala
    Widgets/StatusBar.vala
    Widgets/Toolbar.vala
    Widgets/BooksListView.vala
    Config.vala
PACKAGES
    gtk+-3.0
    gee-1.0
    granite)

# Define the executable name.
add_executable(books
    ${VALA_C} )

add_definitions (${DEPS_CFLAGS} -DWNCK_I_KNOW_THIS_IS_UNSTABLE)

# Link the libraries with our Executable.
target_link_libraries(books ${DEPS_LIBRARIES})

install (TARGETS books RUNTIME DESTINATION bin)
