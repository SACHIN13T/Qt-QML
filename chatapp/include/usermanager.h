#ifndef USERMANAGER_H
#define USERMANAGER_H

#include <QObject>

class UserManager : public QObject {
    Q_OBJECT
public:
    explicit UserManager(QObject *parent = nullptr);
    Q_INVOKABLE bool registerUser(const QString &username, const QString &password);
};

#endif // USERMANAGER_H
