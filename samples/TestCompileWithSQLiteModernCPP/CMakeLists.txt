# ****************************************************************************
#  Project:  LibCMaker_SQLiteModernCPP
#  Purpose:  A CMake build script for SQLiteModernCPP library
#  Author:   NikitaFeodonit, nfeodonit@yandex.com
# ****************************************************************************
#    Copyright (c) 2017-2018 NikitaFeodonit
#
#    This file is part of the LibCMaker_SQLiteModernCPP project.
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published
#    by the Free Software Foundation, either version 3 of the License,
#    or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#    See the GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <http://www.gnu.org/licenses/>.
# ****************************************************************************

cmake_minimum_required(VERSION 3.3)

project(LibCMaker_SQLiteModernCPP_Compile_Test CXX)

set(CMAKE_VERBOSE_MAKEFILE ON)
set(cmr_PRINT_DEBUG ON)


#-----------------------------------------------------------------------
# Configure to find_package()
#-----------------------------------------------------------------------

# Set CMake's search path for find_*() commands.
list(APPEND CMAKE_PREFIX_PATH "${CMAKE_INSTALL_PREFIX}")

if(ANDROID)
  list(APPEND CMAKE_FIND_ROOT_PATH "${CMAKE_INSTALL_PREFIX}")
endif()


#-----------------------------------------------------------------------
# Set path to LibCMaker root
#-----------------------------------------------------------------------

set(LibCMaker_DIR "${CMAKE_CURRENT_LIST_DIR}/cmake/LibCMaker")
# Uncomment it if need functions from LibCMaker
#list(APPEND CMAKE_MODULE_PATH "${LibCMaker_DIR}/cmake")

include(${LibCMaker_DIR}/cmake/cmr_find_package.cmake)


#-----------------------------------------------------------------------
# Set vars to LibCMaker_SQLiteModernCPP
#-----------------------------------------------------------------------

set(SQLITEMODERNCPP_lib_NAME     "SQLiteModernCPP")
set(SQLITEMODERNCPP_lib_VERSION  "3.2")
set(SQLITEMODERNCPP_lib_DIR    "${CMAKE_CURRENT_LIST_DIR}/cmake/LibCMaker_SQLiteModernCPP")

# To use below for sample sources.
set(cmr_UNPACKED_DIR ${CMAKE_CURRENT_BINARY_DIR}/download/unpacked)

# To use our FindSQLiteModernCPP.cmake.
list(APPEND CMAKE_MODULE_PATH "${SQLITEMODERNCPP_lib_DIR}/cmake/modules")

set(COPY_SQLITEMODERNCPP_CMAKE_BUILD_SCRIPTS ON)


#-----------------------------------------------------------------------
# Library specific vars and options
#-----------------------------------------------------------------------


#-----------------------------------------------------------------------
# Build and install the SQLite3
#-----------------------------------------------------------------------

set(SQLITE3_lib_NAME     "SQLite3")
set(SQLITE3_lib_VERSION  "3.24.0")
set(SQLITE3_lib_DIR      "${CMAKE_CURRENT_LIST_DIR}/cmake/LibCMaker_SQLite3")

# To use our FindSQLite3.cmake.
list(APPEND CMAKE_MODULE_PATH "${SQLITE3_lib_DIR}/cmake/modules")

set(COPY_SQLITE3_CMAKE_BUILD_SCRIPTS ON)


#option(BUILD_SHARED_LIBS "build shared library" ${BUILD_SHARED_LIBS})
option(SQLITE_BUILD_SHELL "Build the sqlite3 shell" ON)

option(SQLITE_THREADSAFE "build a thread-safe library" ON)
option(SQLITE_OMIT_LOAD_EXTENSION
  "omits the entire extension loading mechanism" OFF
)

option(SQLITE_ENABLE_FTS3
  "version 3 of the full-text search engine, see also SQLITE_ENABLE_FTS4 which enables FTS3 as well"
  OFF
)
option(SQLITE_ENABLE_FTS3_PARENTHESIS
  "modifies the query pattern parser in FTS3 such that it supports operators AND and NOT and also allows query expressions to contain nested parenthesis"
  OFF
)
option(SQLITE_ENABLE_FTS4
  "versions 3 and 4 of the full-text search engine" OFF
)
option(SQLITE_ENABLE_FTS5 "versions 5 of the full-text search engine" OFF)
option(SQLITE_ENABLE_ICU "the ICU extension to SQLite to be added" OFF)
option(SQLITE_ENABLE_JSON1
  "the JSON SQL functions are added to the build automatically" OFF
)
option(SQLITE_ENABLE_RTREE "include support for the R*Tree index extension" OFF)
option(SQLITE_ENABLE_COLUMN_METADATA
  "include APIs that provide access to meta-data about tables and queries"
  OFF
)

option(SQLITE_DEBUG "Build SQLite debug features" OFF)
option(SQLITE_MEMDEBUG "Build SQLite memory debug features" OFF)


#include(${LibCMaker_DIR}/cmake/cmr_find_package.cmake)
cmr_find_package(
  LibCMaker_DIR   ${LibCMaker_DIR}
  NAME            ${SQLITE3_lib_NAME}
  VERSION         ${SQLITE3_lib_VERSION}
  LIB_DIR         ${SQLITE3_lib_DIR}
  REQUIRED
)


#-----------------------------------------------------------------------
# Build, install and find the SQLiteModernCPP
#-----------------------------------------------------------------------

# Make build and install the library at a config CMake phase.
#include(${LibCMaker_DIR}/cmake/cmr_find_package.cmake)
cmr_find_package(
  LibCMaker_DIR   ${LibCMaker_DIR}
  NAME            ${SQLITEMODERNCPP_lib_NAME}
  VERSION         ${SQLITEMODERNCPP_lib_VERSION}
  LIB_DIR         ${SQLITEMODERNCPP_lib_DIR}
  REQUIRED
)


#-----------------------------------------------------------------------
# Link to the library
#-----------------------------------------------------------------------

find_package(Threads REQUIRED)

if(NOT CMAKE_DL_LIBS)
  message(FATAL_ERROR "Library 'dl' is required.")
endif()
add_library(Dl::dl INTERFACE IMPORTED)
set_property(TARGET Dl::dl PROPERTY
  INTERFACE_LINK_LIBRARIES "${CMAKE_DL_LIBS}"
)


# Get an example sources from the lib sources.
set(lib_EXAMPLES_SRC_DIR
  "${cmr_UNPACKED_DIR}/sqlitemoderncpp-${SQLITEMODERNCPP_lib_VERSION}/sqlite_modern_cpp-${SQLITEMODERNCPP_lib_VERSION}/tests"
)

add_executable(${PROJECT_NAME}
#  ${lib_EXAMPLES_SRC_DIR}/simple_examples.cc
  check_if_table_and_column_of_table_exists.cpp
)
set_target_properties(${PROJECT_NAME} PROPERTIES
  CXX_STANDARD 14
)

# SQLiteModernCPP
target_include_directories(${PROJECT_NAME} PRIVATE ${SQLITEMODERNCPP_INCLUDE_DIR})

# SQLite3
target_include_directories(${PROJECT_NAME} PRIVATE ${SQLITE3_INCLUDE_DIR})
target_link_libraries(${PROJECT_NAME} PRIVATE ${SQLITE3_LIBRARY})

# Threads
target_link_libraries(${PROJECT_NAME} PRIVATE Threads::Threads)

# dl
target_link_libraries(${PROJECT_NAME} PRIVATE Dl::dl)
