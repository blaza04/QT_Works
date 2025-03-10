cmake_minimum_required(VERSION 3.16)

project(Map_support VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Multimedia)
find_package(Qt6 REQUIRED COMPONENTS Positioning Location Widgets)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appMap_support
    main.cpp
)

qt_add_qml_module(appMap_support
    URI Map_support
    VERSION 1.0
    QML_FILES
        Main.qml
        RESOURCES Assets/gps.png
        RESOURCES Assets/marker_blue.png
        QML_FILES Controls.qml
        QML_FILES SerachBox.qml
        QML_FILES IconButton.qml
        QML_FILES LabelButton.qml
        RESOURCES Assets/searchIcon.svg Assets/Search.svg Assets/recenter.svg Assets/Plus.svg Assets/path.png Assets/finishline.png Assets/direction.svg
        RESOURCES Assets/locationPin.png Assets/followme.png
        RESOURCES Assets/mapLabel.png
        SOURCES navigation.h navigation.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appMap_support PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appMap_support
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appMap_support
    PRIVATE Qt6::Quick Qt6::Location Qt6::Positioning Qt6::Widgets
)

include(GNUInstallDirs)
install(TARGETS appMap_support
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
