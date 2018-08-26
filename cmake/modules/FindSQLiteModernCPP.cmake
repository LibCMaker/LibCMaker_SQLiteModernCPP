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

# - Find SQLiteModernCPP library
# Find the SQLiteModernCPP includes
# This module defines
#  SQLITEMODERNCPP_INCLUDE_DIR, where to find sqlite_modern_cpp.h
#  SQLITEMODERNCPP_FOUND, If false, do not try to use SQLiteModernCPP.

find_path(SQLITEMODERNCPP_INCLUDE_DIR
  NAMES sqlite_modern_cpp.h
  PATH_SUFFIXES
    include/sqlite_modern_cpp
  NO_CMAKE_ENVIRONMENT_PATH
  NO_SYSTEM_ENVIRONMENT_PATH
  NO_CMAKE_SYSTEM_PATH
)

# Handle the QUIETLY and REQUIRED arguments and set SQLITEMODERNCPP_FOUND to TRUE
# if all listed variables are TRUE.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SQLITEMODERNCPP DEFAULT_MSG SQLITEMODERNCPP_INCLUDE_DIR)

mark_as_advanced(SQLITEMODERNCPP_INCLUDE_DIR)
