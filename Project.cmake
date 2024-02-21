set(PROJ_EXEC "intro")

#directories under src that will be added as subdirectories to the project
set(MY_PROJECT_SUBDIRECTORIES "intro_lib;intro")

set(DEFAULT_EXEC ${PROJ_EXEC} CACHE STRING "Default executable to build")

#set(MY_PROJECT_TARGETS "${PROJ_EXEC1} ${SERVER_APP}")
set(MY_PROJECT_TARGETS "${PROJ_EXEC}")

MESSAGE(STATUS "MY PROJECT TARGETS = ${MY_PROJECT_TARGETS}")
