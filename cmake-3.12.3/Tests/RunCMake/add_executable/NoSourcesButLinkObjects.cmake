enable_language(CXX)
add_library(ObjectLibDependency OBJECT test.cpp)

add_executable(TestExeWithoutSources)
target_link_libraries(TestExeWithoutSources PUBLIC $<TARGET_OBJECTS:ObjectLibDependency>)
