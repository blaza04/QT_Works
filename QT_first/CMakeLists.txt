cmake_minimum_required(VERSION 3.16)

project(QT_first VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Multimedia)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appQT_first
    main.cpp
)

qt_add_qml_module(appQT_first
    URI QT_first
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES Custom.qml
        RESOURCES Assets/launcherDesign_2_background.png Assets/playBack.png Assets/playNext.png
        SOURCES radio.h radio.cpp
        SOURCES audio.h audio.cpp
        RESOURCES Assets/musicPause.png Assets/musicPlay.png
        RESOURCES Assets/musicAdd_blueShade.png Assets/musicAdd_brownShade.png Assets/musicAdd_greenShade.png Assets/musicAdd_lightShade.png Assets/musicAdd_redShade.png
        RESOURCES Assets/listBackgroud_green.png Assets/listBackground_blue.png Assets/listBackground_brown.png Assets/listBackground_light.png Assets/listBackground_red.png
        RESOURCES Assets/musicStop_blueShade.png Assets/musicStop_brownShade.png Assets/musicStop_greenShade.png Assets/musicStop_lightShade.png Assets/musicStop_redShade.png
        RESOURCES Assets/musicPlay_blue.png Assets/musicPlay_brown.png Assets/musicPlay_green.png Assets/musicPlay_light.png Assets/musicPlay_red.png
        RESOURCES Assets/listBackgroud_green.png Assets/listBackground_blue.png Assets/listBackground_brown.png Assets/listBackground_light.png Assets/listBackground_red.png Assets/mainBackground_GB.png Assets/mainBackground_ML.png Assets/mainBackground_NG.png Assets/mainBackground_RR.png
        QML_FILES Constants.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appQT_first PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appQT_first
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appQT_first
    PRIVATE Qt6::Quick
    Qt6::Multimedia
)

include(GNUInstallDirs)
install(TARGETS appQT_first
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
