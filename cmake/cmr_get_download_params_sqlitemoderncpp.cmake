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

# Part of "LibCMaker/cmake/cmr_get_download_params.cmake".

  if(version VERSION_EQUAL "3.2")
    set(arch_file_sha
      "6a741482c0ef474adfc84260b5507d480d5b8e528e67e059284c2f1f9f986d74")
  endif()
  if(version VERSION_EQUAL "3.2.20190217")
    set(arch_file_sha
      "cfb9613b0435c58ca07f45f9553ad2f4d196cdcd8a2c71a1594a4403ad6b4ba5")
    set(src_commit
      "936cd0c86aacac87a3dab32906397944ae5f6c3d")
  endif()

  # https://github.com/SqliteModernCpp/sqlite_modern_cpp/archive/v3.2.tar.gz
  set(base_url "https://github.com/SqliteModernCpp/sqlite_modern_cpp/archive")
  set(src_dir_name    "sqlitemoderncpp-${version}")
  set(arch_file_name  "${src_dir_name}.tar.gz")
  set(unpack_to_dir   "${unpacked_dir}/${src_dir_name}")

  set(${out_ARCH_SRC_URL}   "${base_url}/v${version}.tar.gz" PARENT_SCOPE)
  set(${out_ARCH_DST_FILE}  "${download_dir}/${arch_file_name}" PARENT_SCOPE)
  set(${out_ARCH_FILE_SHA}  "${arch_file_sha}" PARENT_SCOPE)
  set(${out_SHA_ALG}        "SHA256" PARENT_SCOPE)
  set(${out_UNPACK_TO_DIR}  "${unpack_to_dir}" PARENT_SCOPE)
  set(${out_UNPACKED_SOURCES_DIR}
    "${unpack_to_dir}/sqlite_modern_cpp-${version}" PARENT_SCOPE
  )
  set(${out_VERSION_BUILD_DIR} "${build_dir}/${src_dir_name}" PARENT_SCOPE)

  if(src_commit)
    set(${out_ARCH_SRC_URL} "${base_url}/${src_commit}.tar.gz" PARENT_SCOPE)
    set(${out_UNPACKED_SOURCES_DIR}
      "${unpack_to_dir}/sqlite_modern_cpp-${src_commit}" PARENT_SCOPE
    )
  endif()
