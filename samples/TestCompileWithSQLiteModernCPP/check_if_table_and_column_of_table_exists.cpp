#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <sqlite_modern_cpp.h>
using namespace sqlite;
using namespace std;

// Based on the code from:
// https://github.com/SqliteModernCpp/sqlite_modern_cpp/blob/master/tests/simple_examples.cc
// and from:
// https://github.com/SqliteModernCpp/sqlite_modern_cpp/issues/171#issuecomment-416000254

struct TmpFile
{
  string fname;

  TmpFile()
      : fname(tmpnam(nullptr))
  {
  }

  ~TmpFile() { remove(fname.c_str()); }
};

// Based on the code from:
// https://github.com/SqliteModernCpp/sqlite_modern_cpp/issues/171#issuecomment-416000254
bool has_table(sqlite::database& db, const std::string& table)
{
  bool result;
  db << "SELECT COUNT(*) FROM sqlite_master WHERE name = ? AND type = 'table'"
     << table
      >> result;
  return result;
}

// Based on the code from:
// https://github.com/SqliteModernCpp/sqlite_modern_cpp/issues/171#issuecomment-416000254
bool has_column(
    sqlite::database& db, const std::string& table, const std::string& column)
{
  bool result;
  db << "SELECT COUNT(*) FROM pragma_table_info(?) WHERE name = ?" << table
     << column
      >> result;
  return result;
}

int main()
{
  try {
    TmpFile file;
    database db(file.fname);

    db << "CREATE TABLE foo (a integer, b string);";

    if(!has_table(db, "foo")) {
      std::cout << "There is NO table called '"
                << "foo"
                << "'\n";
    } else {
      std::cout << "There is table called '"
                << "foo"
                << "'\n";
    }
    if(!has_table(db, "bar")) {
      std::cout << "There is NO table called '"
                << "bar"
                << "'\n";
    } else {
      std::cout << "There is table called '"
                << "bar"
                << "'\n";
    }

    if(!has_column(db, "foo", "a")) {
      std::cout << "In this table there is NO column called '"
                << "a"
                << "'\n";
    } else {
      std::cout << "In this table there is column called '"
                << "a"
                << "'\n";
    }
    if(!has_column(db, "foo", "bb")) {
      std::cout << "In this table there is NO column called '"
                << "bb"
                << "'\n";
    } else {
      std::cout << "In this table there is column called '"
                << "bb"
                << "'\n";
    }

  } catch(sqlite_exception e) {
    cout << "Unexpected error " << e.what() << endl;
    exit(EXIT_FAILURE);
  } catch(...) {
    cout << "Unknown error\n";
    exit(EXIT_FAILURE);
  }

  cout << "OK\n";
  exit(EXIT_SUCCESS);
}
