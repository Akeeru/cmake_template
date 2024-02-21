function(myproject_read_sources JSON SOURCES HEADERS INCLUDE_DIR)

    string(JSON TMP_PREFIX ERROR_VARIABLE TMP_PREFIX_ERROR GET ${JSON} "prefix")

    if(NOT ${TMP_PREFIX_ERROR} STREQUAL "NOTFOUND")
        SET(TMP_PREFIX "")
    endif()

    string(JSON TMP_SOURCES_LEN LENGTH ${JSON} "sources")
    math(EXPR TMP_SOURCES_LEN "${TMP_SOURCES_LEN}-1")
    SET(TMP_SOURCES "")
    if(${TMP_SOURCES_LEN} GREATER_EQUAL 0)
        foreach(IDX RANGE ${TMP_SOURCES_LEN})
            string(JSON TMP_SOURCES_ITEM GET ${JSON} "sources" ${IDX})
            list(APPEND TMP_SOURCES ${TMP_SOURCES_ITEM})
        endforeach()
        list(TRANSFORM TMP_SOURCES PREPEND ${CMAKE_CURRENT_SOURCE_DIR}/${TMP_PREFIX}/)
    endif()

    string(JSON TMP_HEADERS_LEN LENGTH ${JSON} "headers")
    math(EXPR TMP_HEADERS_LEN "${TMP_HEADERS_LEN}-1")
    SET(TMP_HEADERS "")
    if(${TMP_HEADERS_LEN} GREATER_EQUAL 0)
        foreach(IDX RANGE ${TMP_HEADERS_LEN})
            string(JSON TMP_HEADERS_ITEM GET ${JSON} "headers" ${IDX})
            list(APPEND TMP_HEADERS ${TMP_HEADERS_ITEM})
        endforeach()
        list(TRANSFORM TMP_HEADERS PREPEND ${CMAKE_CURRENT_SOURCE_DIR}/${TMP_PREFIX}/)
    endif()


    SET(${SOURCES} ${TMP_SOURCES} PARENT_SCOPE)
    SET(${HEADERS} ${TMP_HEADERS} PARENT_SCOPE)
    SET(${INCLUDE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/${TMP_PREFIX}/ PARENT_SCOPE)

endfunction()


function(myproject_load_sources SOURCES HEADERS INCLUDES)

    set_property(
        DIRECTORY
        APPEND
        PROPERTY CMAKE_CONFIGURE_DEPENDS
        files.json
    )

    list(APPEND CMAKE_CONFIGURE_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/files.json PARENT_SCOPE)

    file(READ ${CMAKE_CURRENT_SOURCE_DIR}/files.json JSON_STR)


    string(JSON JSON_TYPE TYPE ${JSON_STR})

    if (${JSON_TYPE} STREQUAL "ARRAY")
        string(JSON TMP_GROUPS_LEN LENGTH ${JSON_STR})
        math(EXPR TMP_GROUPS_LEN "${TMP_GROUPS_LEN}-1")
        if(${TMP_GROUPS_LEN} GREATER_EQUAL 0)
            foreach(IDX RANGE ${TMP_GROUPS_LEN})
                string(JSON TMP_GROUP GET ${JSON_STR} ${IDX})

                myproject_read_sources(${JSON_STR} TMP_SOURCES TMP_HEADERS TMP_INCLUDE_DIR)
                list(APPEND ALL_SOURCES ${TMP_SOURCES})
                list(APPEND ALL_HEADERS ${TMP_HEADERS})
                list(APPEND ALL_INCLUDES ${TMP_INCLUDE_DIR})

            endforeach()
        endif()

    elseif(${JSON_TYPE} STREQUAL "OBJECT")

        myproject_read_sources(${JSON_STR} TMP_SOURCES TMP_HEADERS TMP_INCLUDE_DIR)
        list(APPEND ALL_SOURCES ${TMP_SOURCES})
        list(APPEND ALL_HEADERS ${TMP_HEADERS})
        list(APPEND ALL_INCLUDES ${TMP_INCLUDE_DIR})

        string(JSON TMP_GROUPS_LEN ERROR_VARIABLE TMP_GROUPS_LEN_ERROR LENGTH ${JSON_STR} "childrens")
        if(${TMP_GROUPS_LEN_ERROR} STREQUAL "NOTFOUND")
            math(EXPR TMP_GROUPS_LEN "${TMP_GROUPS_LEN}-1")
            if(${TMP_GROUPS_LEN} GREATER_EQUAL 0)
                foreach(IDX RANGE ${TMP_GROUPS_LEN})
                    string(JSON TMP_GROUP GET ${JSON_STR} "childrens" ${IDX})
                    myproject_read_sources(${TMP_GROUP} TMP_SOURCES TMP_HEADERS TMP_INCLUDE_DIR)
                    list(APPEND ALL_SOURCES ${TMP_SOURCES})
                    list(APPEND ALL_HEADERS ${TMP_HEADERS})
                    list(APPEND ALL_INCLUDES ${TMP_INCLUDE_DIR})
                endforeach()
            endif()
        endif()
    else()
        message(FATAL_ERROR "JSON must be in ARRAY or OBJECT format!: " ${CMAKE_CURRENT_SOURCE_DIR}/files.json)
    endif()

    SET(${SOURCES} ${ALL_SOURCES} PARENT_SCOPE)
    SET(${HEADERS} ${ALL_HEADERS} PARENT_SCOPE)
    SET(${INCLUDES} ${ALL_INCLUDES} PARENT_SCOPE)
endfunction()
