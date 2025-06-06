cmake_minimum_required(VERSION 3.14)
project(chatapp LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 COMPONENTS Quick Multimedia Sql REQUIRED)

set(SOURCES
    main.cpp
    src/usermanager.cpp
)

set(HEADERS
    include/usermanager.h
)

qt_add_resources(QML_RESOURCES qml.qrc)

add_executable(${PROJECT_NAME}
    ${SOURCES}
    ${HEADERS}
    ${QML_RESOURCES}
)

target_include_directories(${PROJECT_NAME} PRIVATE include)

target_link_libraries(${PROJECT_NAME}
    Qt6::Quick
    Qt6::Multimedia
    Qt6::Sql
)
