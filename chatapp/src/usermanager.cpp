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
        query.exec("CREATE TABLE IF NOT EXISTS users ("
                   "username TEXT PRIMARY KEY, "
                   "password TEXT, "
                   "created_at TEXT, "
                   "password_changed_at TEXT, "
                   "last_login TEXT"
                   ")");
    }
}

bool UserManager::registerUser(const QString &username, const QString &password) {
    QSqlQuery query;
    QString now = QDateTime::currentDateTimeUtc().toString(Qt::ISODate);
    query.prepare("INSERT INTO users (username, password, created_at, password_changed_at, last_login) "
                  "VALUES (:username, :password, :created_at, :password_changed_at, :last_login)");
    query.bindValue(":username", username);
    query.bindValue(":password", password);
    query.bindValue(":created_at", now);
    query.bindValue(":password_changed_at", now);
    query.bindValue(":last_login", "");
    if (!query.exec()) {
        qWarning() << "Registration failed:" << query.lastError().text();
        return false;
    }
    return true;
}

bool UserManager::loginUser(const QString &username, const QString &password) {
    QSqlQuery query;
    query.prepare("SELECT password, password_changed_at FROM users WHERE username = :username");
    query.bindValue(":username", username);
    if (query.exec() && query.next()) {
        QString storedPassword = query.value(0).toString();
        QString passwordChangedAt = query.value(1).toString();
        if (storedPassword == password) {
            // Check if password is expired
            QDateTime changed = QDateTime::fromString(passwordChangedAt, Qt::ISODate);
            if (changed.isValid() && changed.daysTo(QDateTime::currentDateTimeUtc()) > 30) {
                // Password expired, do not update last_login, return false
                return false;
            }
            // Update last_login
            QSqlQuery updateQuery;
            QString now = QDateTime::currentDateTimeUtc().toString(Qt::ISODate);
            updateQuery.prepare("UPDATE users SET last_login = :last_login WHERE username = :username");
            updateQuery.bindValue(":last_login", now);
            updateQuery.bindValue(":username", username);
            updateQuery.exec();
            return true;
        }
    }
    return false;
}

bool UserManager::isPasswordExpired(const QString &username) {
    QSqlQuery query;
    query.prepare("SELECT password_changed_at FROM users WHERE username = :username");
    query.bindValue(":username", username);
    if (query.exec() && query.next()) {
        QDateTime changed = QDateTime::fromString(query.value(0).toString(), Qt::ISODate);
        if (changed.isValid() && changed.daysTo(QDateTime::currentDateTimeUtc()) > 30) {
            return true;
        }
    }
    return false;
}

bool UserManager::changePassword(const QString &username, const QString &newPassword) {
    QSqlQuery query;
    QString now = QDateTime::currentDateTimeUtc().toString(Qt::ISODate);
    query.prepare("UPDATE users SET password = :password, password_changed_at = :changed_at WHERE username = :username");
    query.bindValue(":password", newPassword);
    query.bindValue(":changed_at", now);
    query.bindValue(":username", username);
    return query.exec();
}

QString UserManager::getLastLogin(const QString &username) {
    QSqlQuery query;
    query.prepare("SELECT last_login FROM users WHERE username = :username");
    query.bindValue(":username", username);
    if (query.exec() && query.next()) {
        return query.value(0).toString();
    }
    return "";
}
