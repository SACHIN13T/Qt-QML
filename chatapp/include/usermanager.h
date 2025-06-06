#ifndef USERMANAGER_H
#define USERMANAGER_H

#include <QObject>

class UserManager : public QObject {
    Q_OBJECT
public:
    explicit UserManager(QObject *parent = nullptr);
    Q_INVOKABLE bool registerUser(const QString &username, const QString &password);
    Q_INVOKABLE bool loginUser(const QString &username, const QString &password);
    Q_INVOKABLE bool isPasswordExpired(const QString &username);
    Q_INVOKABLE bool changePassword(const QString &username, const QString &newPassword);
    Q_INVOKABLE QString getLastLogin(const QString &username);
};

#endif // USERMANAGER_H
