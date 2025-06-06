QT += quick
CONFIG += c++11

TARGET = chatapp
TEMPLATE = app

SOURCES += main.cpp

RESOURCES += qml.qrc

# Additional include paths
INCLUDEPATH += backend

# Add future C++ files from backend/
HEADERS += 

# Add assets
ASSETS.files = assets/*
ASSETS.path = assets
INSTALLS += ASSETS
