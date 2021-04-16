# CMake generated Testfile for 
# Source directory: /src/cmake-3.12.3/Tests/CMakeOnly
# Build directory: /src/cmake-3.12.3/Tests/CMakeOnly
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(CMakeOnly.LinkInterfaceLoop "/src/cmake-3.12.3/bin/cmake" "-DTEST=LinkInterfaceLoop" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
set_tests_properties(CMakeOnly.LinkInterfaceLoop PROPERTIES  TIMEOUT "90")
add_test(CMakeOnly.CheckSymbolExists "/src/cmake-3.12.3/bin/cmake" "-DTEST=CheckSymbolExists" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.CheckCXXSymbolExists "/src/cmake-3.12.3/bin/cmake" "-DTEST=CheckCXXSymbolExists" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.CheckCXXCompilerFlag "/src/cmake-3.12.3/bin/cmake" "-DTEST=CheckCXXCompilerFlag" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.CheckLanguage "/src/cmake-3.12.3/bin/cmake" "-DTEST=CheckLanguage" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.CheckStructHasMember "/src/cmake-3.12.3/bin/cmake" "-DTEST=CheckStructHasMember" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.CompilerIdC "/src/cmake-3.12.3/bin/cmake" "-DTEST=CompilerIdC" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.CompilerIdCXX "/src/cmake-3.12.3/bin/cmake" "-DTEST=CompilerIdCXX" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.CompilerIdFortran "/src/cmake-3.12.3/bin/cmake" "-DTEST=CompilerIdFortran" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.AllFindModules "/src/cmake-3.12.3/bin/cmake" "-DTEST=AllFindModules" "-DCMAKE_ARGS=-DCMake_TEST_CMakeOnly.AllFindModules_NO_VERSION=" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.SelectLibraryConfigurations "/src/cmake-3.12.3/bin/cmake" "-DTEST=SelectLibraryConfigurations" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.TargetScope "/src/cmake-3.12.3/bin/cmake" "-DTEST=TargetScope" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.find_library "/src/cmake-3.12.3/bin/cmake" "-DTEST=find_library" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.find_path "/src/cmake-3.12.3/bin/cmake" "-DTEST=find_path" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.ProjectInclude "/src/cmake-3.12.3/bin/cmake" "-DTEST=ProjectInclude" "-DCMAKE_ARGS=-DCMAKE_PROJECT_ProjectInclude_INCLUDE=/src/cmake-3.12.3/Tests/CMakeOnly/ProjectInclude/include.cmake" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.MajorVersionSelection-PythonLibs_2 "/src/cmake-3.12.3/bin/cmake" "-DTEST=MajorVersionSelection-PythonLibs_2" "-DTEST_SOURCE=MajorVersionSelection" "-DCMAKE_ARGS=-DMAJOR_TEST_MODULE=PythonLibs;-DMAJOR_TEST_VERSION=2;-DMAJOR_TEST_NO_LANGUAGES=FALSE;-DMAJOR_TEST_VERSION_VAR=PYTHONLIBS_VERSION_STRING" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.MajorVersionSelection-PythonLibs_3 "/src/cmake-3.12.3/bin/cmake" "-DTEST=MajorVersionSelection-PythonLibs_3" "-DTEST_SOURCE=MajorVersionSelection" "-DCMAKE_ARGS=-DMAJOR_TEST_MODULE=PythonLibs;-DMAJOR_TEST_VERSION=3;-DMAJOR_TEST_NO_LANGUAGES=FALSE;-DMAJOR_TEST_VERSION_VAR=PYTHONLIBS_VERSION_STRING" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.MajorVersionSelection-PythonInterp_2 "/src/cmake-3.12.3/bin/cmake" "-DTEST=MajorVersionSelection-PythonInterp_2" "-DTEST_SOURCE=MajorVersionSelection" "-DCMAKE_ARGS=-DMAJOR_TEST_MODULE=PythonInterp;-DMAJOR_TEST_VERSION=2;-DMAJOR_TEST_NO_LANGUAGES=TRUE;-DMAJOR_TEST_VERSION_VAR=PYTHON_VERSION_STRING" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.MajorVersionSelection-PythonInterp_3 "/src/cmake-3.12.3/bin/cmake" "-DTEST=MajorVersionSelection-PythonInterp_3" "-DTEST_SOURCE=MajorVersionSelection" "-DCMAKE_ARGS=-DMAJOR_TEST_MODULE=PythonInterp;-DMAJOR_TEST_VERSION=3;-DMAJOR_TEST_NO_LANGUAGES=TRUE;-DMAJOR_TEST_VERSION_VAR=PYTHON_VERSION_STRING" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.MajorVersionSelection-Qt_3 "/src/cmake-3.12.3/bin/cmake" "-DTEST=MajorVersionSelection-Qt_3" "-DTEST_SOURCE=MajorVersionSelection" "-DCMAKE_ARGS=-DMAJOR_TEST_MODULE=Qt;-DMAJOR_TEST_VERSION=3;-DMAJOR_TEST_NO_LANGUAGES=FALSE;-DMAJOR_TEST_VERSION_VAR=QT_VERSION_STRING" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.MajorVersionSelection-Qt_4 "/src/cmake-3.12.3/bin/cmake" "-DTEST=MajorVersionSelection-Qt_4" "-DTEST_SOURCE=MajorVersionSelection" "-DCMAKE_ARGS=-DMAJOR_TEST_MODULE=Qt;-DMAJOR_TEST_VERSION=4;-DMAJOR_TEST_NO_LANGUAGES=FALSE;-DMAJOR_TEST_VERSION_VAR=QT_VERSION_STRING" "-P" "/src/cmake-3.12.3/Tests/CMakeOnly/Test.cmake")
