cmake_minimum_required(VERSION 3.16)

project(PluginDemo VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Felgo REQUIRED)

# Project identifier and version
# More information: https://felgo.com/doc/felgo-publishing/#project-configuration
set(PRODUCT_IDENTIFIER "net.vplay.demos.PluginDemo")
set(PRODUCT_VERSION_NAME "1.0")
set(PRODUCT_VERSION_CODE "1")

# Optionally set a license key that is used instead of the license key from
# main.qml file (App::licenseKey for your app or GameWindow::licenseKey for your game)
# Only used for local builds and Felgo Cloud Builds (https://felgo.com/cloud-builds)
# Not used if using Felgo Live
#set(PRODUCT_LICENSE_KEY "my-license")

set(FELGO_PLUGINS admob chartboost facebook firebase gamecenter soomla)

# Add more folders to ship with the application here
file(GLOB_RECURSE QmlFolder RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} qml/*.qml)
file(GLOB_RECURSE AssetsFolder RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} assets/* qml/config.json qml/helper/qmldir)

qt_add_executable(PluginDemo
    main.cpp
    ${QmlFolder}
    ${AssetsFolder}
)

felgo_configure_executable(PluginDemo)

qt_add_qml_module(PluginDemo
    URI PluginDemo
    VERSION 1.0
    # for publishing - bundle resources directly inside your application binary
    QML_FILES ${QmlFolder}
    RESOURCES ${AssetsFolder}
    NO_RESOURCE_TARGET_PATH
)

# for development - deploy resource files next to application
# (needs install target enabled)
#deploy_resources("${QmlFolder};${AssetsFolder}")

target_compile_definitions(PluginDemo
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

target_link_libraries(PluginDemo PRIVATE Felgo)
