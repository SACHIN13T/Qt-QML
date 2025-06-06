#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QResource>
#include "include/usermanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QResource::registerResource("qml.qrc");
    QQmlApplicationEngine engine;

    // Register UserManager for QML use (future use)
    qmlRegisterType<UserManager>("Backend", 1, 0, "UserManager");

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
