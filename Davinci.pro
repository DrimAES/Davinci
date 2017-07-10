TEMPLATE = app

QT += qml quick widgets serialport

CONFIG += c++11

SOURCES += main.cpp \
    app_manager.cpp \
    backlight_manager.cpp \
    comunication_manager.cpp \
    control_cen_manager.cpp \
    setting_manager.cpp \
    time_manager.cpp \
    qtsocketcan.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =


HEADERS += \
    app_manager.h \
    backlight_manager.h \
    comunication_manager.h \
    control_cen_manager.h \
    setting_manager.h \
    time_manager.h \
    qtsocketcan.h

DISTFILES +=
