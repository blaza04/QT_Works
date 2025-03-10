# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appDiscogs_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appDiscogs_autogen.dir/ParseCache.txt"
  "appDiscogs_autogen"
  )
endif()
