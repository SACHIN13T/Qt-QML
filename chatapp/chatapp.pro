QT += quick
CONFIG += c++11

TARGET = chatapp
TEMPLATE = app

SOURCES += main.cpp

RESOURCES += 

QML_IMPORT_PATH = qml

# Additional include paths
INCLUDEPATH += backend

# Add future C++ files from backend/
HEADERS += 

# Add QML files from qml/
QML_FILES.files = qml/*.qml
QML_FILES.path = qml
INSTALLS += QML_FILES

# Add assets
ASSETS.files = assets/*
ASSETS.path = assets
INSTALLS += ASSETS
