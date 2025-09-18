cmake_minimum_required(VERSION 3.20)

project(marco LANGUAGES C CXX)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-exceptions -fno-rtti")

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin)

if (DEFINED LLVM_PATH)
    get_filename_component(LLVM_ABS_PATH ${LLVM_PATH} ABSOLUTE)
    set(LLVM_DIR "${LLVM_ABS_PATH}/lib/cmake/llvm")
    set(MLIR_DIR "${LLVM_ABS_PATH}/lib/cmake/mlir")
endif()

find_package(Python3 REQUIRED)
find_package(LLVM REQUIRED CONFIG)
find_package(MLIR REQUIRED CONFIG)

# These are a bit of a hack, because we're hijacking a lot of LLVM machinery.
set(LLVM_LIBRARY_OUTPUT_INTDIR ${CMAKE_BINARY_DIR}/lib)
set(LLVM_RUNTIME_OUTPUT_INTDIR ${CMAKE_BINARY_DIR}/bin)
set(MLIR_BINARY_DIR ${CMAKE_BINARY_DIR})

list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
list(APPEND CMAKE_MODULE_PATH "${MLIR_CMAKE_DIR}")

include(HandleLLVMOptions)
include(TableGen)
include(AddLLVM)
include(AddMLIR)

link_directories(${LLVM_BUILD_LIBRARY_DIR})

find_program(LLVM_TABLEGEN_EXE "llvm-tblgen"
        PATHS ${LLVM_TOOLS_BINARY_DIR}
        NO_DEFAULT_PATH
        NO_CMAKE_FIND_ROOT_PATH)

add_compile_options("-fsanitize=address")
add_link_options("-fsanitize=address")

include_directories(${LLVM_INCLUDE_DIRS})
include_directories(${MLIR_INCLUDE_DIRS})

include_directories(
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        ${CMAKE_CURRENT_BINARY_DIR}/include)

add_subdirectory(include)
add_subdirectory(lib)
add_subdirectory(tool)
