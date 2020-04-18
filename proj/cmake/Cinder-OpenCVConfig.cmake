if(NOT TARGET Cinder-OpenCV)
    get_filename_component(Cinder-OpenCV_PROJECT_ROOT "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)
    get_filename_component(CINDER_PATH "${Cinder-OpenCV_PROJECT_ROOT}/../.." ABSOLUTE)
    file(GLOB LIBRARY_LIST CONFIGURE_DEPENDS "${Cinder-OpenCV_PROJECT_ROOT}/lib/macosx/*.a" )

    add_library(Cinder-OpenCV ${LIBRARY_LIST})
    target_include_directories(Cinder-OpenCV PUBLIC
            "${Cinder-OpenCV_PROJECT_ROOT}/include"
            "${Cinder-OpenCV_PROJECT_ROOT}/include/opencv2")
    target_include_directories(Cinder-OpenCV SYSTEM BEFORE PUBLIC "${CINDER_PATH}/include")

    if(NOT TARGET cinder)
        include("${CINDER_PATH}/proj/cmake/configure.cmake")
        find_package(cinder REQUIRED PATHS
                "${CINDER_PATH}/${CINDER_LIB_DIRECTORY}"
                "$ENV{CINDER_PATH}/${CINDER_LIB_DIRECTORY}")
    endif()
    target_link_libraries(Cinder-OpenCV PRIVATE cinder)

endif()