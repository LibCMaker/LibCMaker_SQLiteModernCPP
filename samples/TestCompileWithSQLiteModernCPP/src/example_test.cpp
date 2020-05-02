/*****************************************************************************
 * Project:  LibCMaker_SQLiteModernCPP
 * Purpose:  A CMake build script for SQLiteModernCPP library
 * Author:   NikitaFeodonit, nfeodonit@yandex.com
 *****************************************************************************
 *   Copyright (c) 2017-2019 NikitaFeodonit
 *
 *    This file is part of the LibCMaker_SQLiteModernCPP project.
 *
 *    This program is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published
 *    by the Free Software Foundation, either version 3 of the License,
 *    or (at your option) any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *    See the GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program. If not, see <http://www.gnu.org/licenses/>.
 ****************************************************************************/

// The code is based on the code from
// <sqlite_modern_cpp>/tests/simple_examples.cc

#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <sqlite_modern_cpp.h>

#include "gtest/gtest.h"

using namespace sqlite;
using namespace std;

TEST(Examle, test) {
  try {
    database db(":memory:");

    db << "CREATE TABLE foo (a integer, b string);";
    db << "INSERT INTO foo VALUES (?, ?)" << 1 << "hello";
    db << "INSERT INTO foo VALUES (?, ?)" << 2 << "world";

    string str;
    db << "SELECT b from FOO where a=?;" << 2L >> str;

    if (str != "world") {
      cout << "Bad result on line " << __LINE__ << endl;
      EXPECT_FALSE(true);
    }

    std::string sql("select 1+1");
    long test = 0;
    db << sql >> test;

    EXPECT_EQ(test, 2);

  } catch (sqlite_exception e) {
    cout << "Unexpected error " << e.what() << endl;
    EXPECT_FALSE(true);
  } catch (...) {
    cout << "Unknown error\n";
    EXPECT_FALSE(true);
  }

  cout << "OK\n";
  EXPECT_TRUE(true);
}
