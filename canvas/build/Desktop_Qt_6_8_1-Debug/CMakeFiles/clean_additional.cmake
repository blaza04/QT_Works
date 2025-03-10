# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appcanvas_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appcanvas_autogen.dir/ParseCache.txt"
  "appcanvas_autogen"
  )
endif()
