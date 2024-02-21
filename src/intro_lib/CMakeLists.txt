myproject_load_sources(SOURCES HEADERS INCLUDES)

add_library(intro_lib ${SOURCES})
add_library(myproject::intro_lib ALIAS intro_lib)

target_link_libraries(intro_lib PRIVATE myproject_options myproject_warnings)

target_include_directories(intro_lib ${WARNING_GUARD} PUBLIC ${INCLUDES})

target_compile_features(intro_lib PUBLIC cxx_std_20)

set_target_properties(
  intro_lib
  PROPERTIES VERSION ${PROJECT_VERSION}
             CXX_VISIBILITY_PRESET hidden
             VISIBILITY_INLINES_HIDDEN YES
)


if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(intro_lib PUBLIC intro_lib_STATIC_DEFINE)
endif()

