cmake_minimum_required(VERSION 3.16)

project(second VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appsecond
    main.cpp
)

qt_add_qml_module(appsecond
    URI second
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES Animate.qml
        QML_FILES Animate1.qml
        RESOURCES assets/200.jpg
        SOURCES Signalclass.h Signalclass.cpp
        SOURCES Slotclass.h Slotclass.cpp
        SOURCES Handler.h Handler.cpp
        SOURCES System.h System.cpp

)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appsecond PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appsecond
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appsecond
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appsecond
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
