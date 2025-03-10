# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appQt_componets_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appQt_componets_autogen.dir/ParseCache.txt"
  "appQt_componets_autogen"
  )
endif()
