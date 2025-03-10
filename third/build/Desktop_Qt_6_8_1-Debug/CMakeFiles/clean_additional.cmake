# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appthird_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appthird_autogen.dir/ParseCache.txt"
  "appthird_autogen"
  )
endif()
