# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appFourth_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appFourth_autogen.dir/ParseCache.txt"
  "appFourth_autogen"
  )
endif()
