# ****************************************************************************
#  Project:  LibCMaker_SQLiteModernCPP
#  Purpose:  A CMake build script for SQLiteModernCPP library
#  Author:   NikitaFeodonit, nfeodonit@yandex.com
# ****************************************************************************
#    Copyright (c) 2017-2019 NikitaFeodonit
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

#-----------------------------------------------------------------------
# The file is an example of the convenient script for the library build.
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Lib's name, version, paths
#-----------------------------------------------------------------------

set(SQLITEMODERNCPP_lib_NAME "SQLiteModernCPP")
set(
  SQLITEMODERNCPP_lib_VERSION "3.2.20190217"
  CACHE STRING "SQLITEMODERNCPP_lib_VERSION"
)
set(
  SQLITEMODERNCPP_lib_DIR "${CMAKE_CURRENT_LIST_DIR}"
  CACHE PATH "SQLITEMODERNCPP_lib_DIR"
)

# To use our Find<LibName>.cmake.
list(APPEND CMAKE_MODULE_PATH "${SQLITEMODERNCPP_lib_DIR}/cmake/modules")


#-----------------------------------------------------------------------
# LibCMaker_<LibName> specific vars and options
#-----------------------------------------------------------------------

option(
  COPY_SQLITEMODERNCPP_CMAKE_BUILD_SCRIPTS
  "COPY_SQLITEMODERNCPP_CMAKE_BUILD_SCRIPTS"
  ON
)


#-----------------------------------------------------------------------
# Library specific vars and options
#-----------------------------------------------------------------------


#-----------------------------------------------------------------------
# Build, install and find the library
#-----------------------------------------------------------------------

cmr_find_package(
  LibCMaker_DIR   ${LibCMaker_DIR}
  NAME            ${SQLITEMODERNCPP_lib_NAME}
  VERSION         ${SQLITEMODERNCPP_lib_VERSION}
  LIB_DIR         ${SQLITEMODERNCPP_lib_DIR}
  REQUIRED
)
