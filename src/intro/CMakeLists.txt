myproject_load_sources(SOURCES HEADERS INCLUDES)

add_executable(intro ${SOURCES})

target_link_libraries(
  intro
  PRIVATE myproject::myproject_options
          myproject::myproject_warnings
          myproject::intro_lib
          )

target_link_system_libraries(
  intro
  PRIVATE
          fmt::fmt
          spdlog::spdlog
          )

target_include_directories(intro PRIVATE "${CMAKE_BINARY_DIR}/configured_files/include")

