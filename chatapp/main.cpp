#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QResource>
#include "include/usermanager.h"
#include <regex>

bool isValidUsername(const QString &username) {
    // Example: at least 4 chars, only letters and numbers
    QRegularExpression re("^[A-Za-z0-9]{4,}$");
    return re.match(username).hasMatch();
}

bool isValidPassword(const QString &password) {
    // Example: at least 6 chars, at least one letter and one number
    QRegularExpression re("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$");
    return re.match(password).hasMatch();
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QResource::registerResource("qml.qrc");
    QQmlApplicationEngine engine;

    // Register UserManager for QML use (future use)
    qmlRegisterType<UserManager>("Backend", 1, 0, "UserManager");

    // Expose validation functions to QML
    engine.rootContext()->setContextProperty("isValidUsername", QVariant::fromValue(&isValidUsername));
    engine.rootContext()->setContextProperty("isValidPassword", QVariant::fromValue(&isValidPassword));

    engine.load(QUrl(QStringLiteral("qrc:/qml/RegisterView.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
