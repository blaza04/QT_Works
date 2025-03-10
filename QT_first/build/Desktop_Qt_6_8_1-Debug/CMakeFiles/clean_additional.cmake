# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appQT_first_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appQT_first_autogen.dir/ParseCache.txt"
  "appQT_first_autogen"
  )
endif()
