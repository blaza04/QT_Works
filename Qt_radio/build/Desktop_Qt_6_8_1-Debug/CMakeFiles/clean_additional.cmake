# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appQt_radio_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appQt_radio_autogen.dir/ParseCache.txt"
  "appQt_radio_autogen"
  )
endif()
