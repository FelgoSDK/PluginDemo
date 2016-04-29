# allows to add DEPLOYMENTFOLDERS and links to the V-Play library and QtCreator auto-completion
CONFIG += v-play

qmlFolder.source = qml
DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

assetsFolder.source = assets
DEPLOYMENTFOLDERS += assetsFolder

# Add more folders to ship with the application here

RESOURCES += #    resources.qrc # uncomment for publishing

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the DEPLOYMENTFOLDERS += qmlFolder line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the resources.qrc file inclusion and add any qml subfolders to the .qrc file; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the V-Play Documentation

# during development, use the qmlFolder deployment because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp

android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += \
      android/AndroidManifest.xml \
      android/build.gradle
}

ios {
    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST

    LIBS += -L$$PWD/ios
    LIBS += -F$$PWD/ios

    # AdMob SDK
    LIBS += -framework GoogleMobileAds
    QMAKE_LFLAGS += -Wl,-force_load,$$PWD/ios/GoogleMobileAds.framework/GoogleMobileAds

    # Chartboost SDK
    LIBS += -framework Chartboost
    QMAKE_LFLAGS += -Wl,-force_load,$$PWD/ios/Chartboost.framework/Chartboost

    # Facebook SDK
    LIBS += -framework FacebookSDK
    QMAKE_LFLAGS += -Wl,-force_load,$$PWD/ios/FacebookSDK.framework/FacebookSDK

    # Flurry SDK
    LIBS += -lFlurry
    QMAKE_LFLAGS += -Wl,-force_load,$$PWD/ios/libFlurry.a

    # HockeyApp SDK
    LIBS += -framework HockeySDK
    QMAKE_LFLAGS += -Wl,-force_load,$$PWD/ios/HockeySDK.framework/HockeySDK

    # HockeyApp bundle files
    hockey_deployment.files = $$PWD/ios/HockeySDK.framework/Versions/A/Resources/HockeySDKResources.bundle
    hockey_deployment.path =
    QMAKE_BUNDLE_DATA += hockey_deployment

    # OneSignal SDK
    LIBS += -framework OneSignal
    QMAKE_LFLAGS += -Wl,-force_load,$$PWD/ios/OneSignal.framework/OneSignal

    # Soomla SDK
    LIBS += -lSoomlaiOSStore
    LIBS += -lSoomlaiOSCore
    QMAKE_LFLAGS += -Wl,-force_load,$$PWD/ios/libSoomlaiOSStore.a
    QMAKE_LFLAGS += -Wl,-force_load,$$PWD/ios/libSoomlaiOSCore.a

    # Framework dependencies
    LIBS += -framework AdSupport
    LIBS += -framework AudioToolbox
    LIBS += -framework AssetsLibrary
    LIBS += -framework AVFoundation
    LIBS += -framework CoreGraphics
    LIBS += -framework CoreMedia
    LIBS += -framework CoreTelephony
    LIBS += -framework CoreText
    LIBS += -framework EventKit
    LIBS += -framework EventKitUI
    LIBS += -framework MediaPlayer
    LIBS += -framework MessageUI
    LIBS += -framework MobileCoreServices
    LIBS += -framework QuartzCore
    LIBS += -framework QuickLook
    LIBS += -framework Security
    LIBS += -framework StoreKit
    LIBS += -framework SystemConfiguration
}

# set application icons for win and macx
win32 {
    RC_FILE += win/app_icon.rc
}
macx {
    ICON = macx/app_icon.icns
}
