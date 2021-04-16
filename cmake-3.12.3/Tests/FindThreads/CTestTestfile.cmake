# CMake generated Testfile for 
# Source directory: /src/cmake-3.12.3/Tests/FindThreads
# Build directory: /src/cmake-3.12.3/Tests/FindThreads
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(FindThreads.C-only "/src/cmake-3.12.3/bin/ctest" "--build-and-test" "/src/cmake-3.12.3/Tests/FindThreads/C-only" "/src/cmake-3.12.3/Tests/FindThreads/C-only" "--build-generator" "Unix Makefiles" "--build-project" "FindThreads_C-only" "--build-options" "-DCMAKE_MAKE_PROGRAM:FILEPATH=/usr/bin/gmake" "--test-command" "/src/cmake-3.12.3/bin/ctest" "-V")
add_test(FindThreads.CXX-only "/src/cmake-3.12.3/bin/ctest" "--build-and-test" "/src/cmake-3.12.3/Tests/FindThreads/CXX-only" "/src/cmake-3.12.3/Tests/FindThreads/CXX-only" "--build-generator" "Unix Makefiles" "--build-project" "FindThreads_CXX-only" "--build-options" "-DCMAKE_MAKE_PROGRAM:FILEPATH=/usr/bin/gmake" "--test-command" "/src/cmake-3.12.3/bin/ctest" "-V")
