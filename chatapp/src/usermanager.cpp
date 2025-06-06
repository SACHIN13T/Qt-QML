#include "include/usermanager.h"
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlError>
#include <QDebug>

UserManager::UserManager(QObject *parent) : QObject(parent) {
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("chatapp_users.db");
    if (!db.open()) {
        qWarning() << "Failed to open database:" << db.lastError().text();
    } else {
        QSqlQuery query;
        query.exec("CREATE TABLE IF NOT EXISTS users (username TEXT PRIMARY KEY, password TEXT)");
    }
}

bool UserManager::registerUser(const QString &username, const QString &password) {
    QSqlQuery query;
    query.prepare("INSERT INTO users (username, password) VALUES (:username, :password)");
    query.bindValue(":username", username);
    query.bindValue(":password", password);
    if (!query.exec()) {
        qWarning() << "Registration failed:" << query.lastError().text();
        return false;
    }
    return true;
}

bool UserManager::loginUser(const QString &username, const QString &password) {
    QSqlQuery query;
    query.prepare("SELECT password FROM users WHERE username = :username");
    query.bindValue(":username", username);
    if (query.exec() && query.next()) {
        QString storedPassword = query.value(0).toString();
        return storedPassword == password;
    }
    return false;
}
