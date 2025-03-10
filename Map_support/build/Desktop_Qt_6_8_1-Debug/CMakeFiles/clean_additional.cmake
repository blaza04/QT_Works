# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appMap_support_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appMap_support_autogen.dir/ParseCache.txt"
  "appMap_support_autogen"
  )
endif()
