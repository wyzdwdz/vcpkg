if(NOT _VCPKG_LINUX_TOOLCHAIN)
set(_VCPKG_LINUX_TOOLCHAIN 1)
set(CMAKE_SYSTEM_NAME Linux CACHE STRING "")
if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
   set(CMAKE_SYSTEM_PROCESSOR x86_64 CACHE STRING "")
   set(ENV{PKG_CONFIG_PATH} "/usr/lib/x86_64-linux-gnu/pkgconfig")
elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
    set(CMAKE_SYSTEM_PROCESSOR x86 CACHE STRING "")
    if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux")
        set(ENV{PKG_CONFIG_PATH} "/usr/lib/i386-linux-gnu/pkgconfig")
        if(NOT DEFINED CMAKE_CXX_COMPILER)
            set(CMAKE_CXX_COMPILER "i686-linux-gnu-g++")
        endif()
        if(NOT DEFINED CMAKE_C_COMPILER)
            set(CMAKE_C_COMPILER "i686-linux-gnu-gcc")
        endif()
        if(NOT DEFINED CMAKE_ASM_COMPILER)
            set(CMAKE_ASM_COMPILER "i686-linux-gnu-gcc")
        endif()
        if(NOT DEFINED CMAKE_ASM-ATT_COMPILER)
            set(CMAKE_ASM-ATT_COMPILER "i686-linux-gnu-as")
        endif()
        message(STATUS "Cross compiling arm on host ${CMAKE_HOST_SYSTEM_PROCESSOR}, use cross compiler: ${CMAKE_CXX_COMPILER}/${CMAKE_C_COMPILER}")
elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm")
    set(CMAKE_SYSTEM_PROCESSOR armv7l CACHE STRING "")
    if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux")
        set(ENV{PKG_CONFIG_PATH} "/usr/lib/arm-linux-gnueabihf/pkgconfig")
        if(NOT DEFINED CMAKE_CXX_COMPILER)
            set(CMAKE_CXX_COMPILER "arm-linux-gnueabihf-g++")
        endif()
        if(NOT DEFINED CMAKE_C_COMPILER)
            set(CMAKE_C_COMPILER "arm-linux-gnueabihf-gcc")
        endif()
        if(NOT DEFINED CMAKE_ASM_COMPILER)
            set(CMAKE_ASM_COMPILER "arm-linux-gnueabihf-gcc")
        endif()
        if(NOT DEFINED CMAKE_ASM-ATT_COMPILER)
            set(CMAKE_ASM-ATT_COMPILER "arm-linux-gnueabihf-as")
        endif()
        message(STATUS "Cross compiling arm on host ${CMAKE_HOST_SYSTEM_PROCESSOR}, use cross compiler: ${CMAKE_CXX_COMPILER}/${CMAKE_C_COMPILER}")
    endif()
elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm64")
    set(CMAKE_SYSTEM_PROCESSOR aarch64 CACHE STRING "")
    if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux")
        set(ENV{PKG_CONFIG_PATH} "/usr/lib/aarch64-linux-gnu/pkgconfig")
        if(NOT DEFINED CMAKE_CXX_COMPILER)
            set(CMAKE_CXX_COMPILER "aarch64-linux-gnu-g++")
        endif()
        if(NOT DEFINED CMAKE_C_COMPILER)
            set(CMAKE_C_COMPILER "aarch64-linux-gnu-gcc")
        endif()
        if(NOT DEFINED CMAKE_ASM_COMPILER)
            set(CMAKE_ASM_COMPILER "aarch64-linux-gnu-gcc")
        endif()
        if(NOT DEFINED CMAKE_ASM-ATT_COMPILER)
            set(CMAKE_ASM-ATT_COMPILER "aarch64-linux-gnu-as")
        endif()
        message(STATUS "Cross compiling arm64 on host ${CMAKE_HOST_SYSTEM_PROCESSOR}, use cross compiler: ${CMAKE_CXX_COMPILER}/${CMAKE_C_COMPILER}")
    endif()
endif()

if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux")
    if(CMAKE_SYSTEM_PROCESSOR STREQUAL CMAKE_HOST_SYSTEM_PROCESSOR)
        set(CMAKE_CROSSCOMPILING OFF CACHE STRING "")
    else()
        set(CMAKE_CROSSCOMPILING ON CACHE STRING "")
    endif()

    if(NOT DEFINED CMAKE_SYSTEM_VERSION)
        set(CMAKE_SYSTEM_VERSION "${CMAKE_HOST_SYSTEM_VERSION}" CACHE STRING "")
    endif()
endif()

get_property( _CMAKE_IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE )
if(NOT _CMAKE_IN_TRY_COMPILE)
    string(APPEND CMAKE_C_FLAGS_INIT " -fPIC ${VCPKG_C_FLAGS} ")
    string(APPEND CMAKE_CXX_FLAGS_INIT " -fPIC ${VCPKG_CXX_FLAGS} ")
    string(APPEND CMAKE_C_FLAGS_DEBUG_INIT " ${VCPKG_C_FLAGS_DEBUG} ")
    string(APPEND CMAKE_CXX_FLAGS_DEBUG_INIT " ${VCPKG_CXX_FLAGS_DEBUG} ")
    string(APPEND CMAKE_C_FLAGS_RELEASE_INIT " ${VCPKG_C_FLAGS_RELEASE} ")
    string(APPEND CMAKE_CXX_FLAGS_RELEASE_INIT " ${VCPKG_CXX_FLAGS_RELEASE} ")

    string(APPEND CMAKE_MODULE_LINKER_FLAGS_INIT " ${VCPKG_LINKER_FLAGS} ")
    string(APPEND CMAKE_SHARED_LINKER_FLAGS_INIT " ${VCPKG_LINKER_FLAGS} ")
    string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT " ${VCPKG_LINKER_FLAGS} ")
    if(VCPKG_CRT_LINKAGE STREQUAL "static")
        string(APPEND CMAKE_MODULE_LINKER_FLAGS_INIT "-static ")
        string(APPEND CMAKE_SHARED_LINKER_FLAGS_INIT "-static ")
        string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT "-static ")
    endif()
    string(APPEND CMAKE_MODULE_LINKER_FLAGS_DEBUG_INIT " ${VCPKG_LINKER_FLAGS_DEBUG} ")
    string(APPEND CMAKE_SHARED_LINKER_FLAGS_DEBUG_INIT " ${VCPKG_LINKER_FLAGS_DEBUG} ")
    string(APPEND CMAKE_EXE_LINKER_FLAGS_DEBUG_INIT " ${VCPKG_LINKER_FLAGS_DEBUG} ")
    string(APPEND CMAKE_MODULE_LINKER_FLAGS_RELEASE_INIT " ${VCPKG_LINKER_FLAGS_RELEASE} ")
    string(APPEND CMAKE_SHARED_LINKER_FLAGS_RELEASE_INIT " ${VCPKG_LINKER_FLAGS_RELEASE} ")
    string(APPEND CMAKE_EXE_LINKER_FLAGS_RELEASE_INIT " ${VCPKG_LINKER_FLAGS_RELEASE} ")
endif()
endif()
