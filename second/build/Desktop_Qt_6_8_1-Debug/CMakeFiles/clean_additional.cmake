# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appsecond_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appsecond_autogen.dir/ParseCache.txt"
  "appsecond_autogen"
  )
endif()
