#include "usermanager.h"

UserManager::UserManager(QObject *parent) : QObject(parent) {}

bool UserManager::registerUser(const QString &username, const QString &password) {
    // Dummy logic for registration
    Q_UNUSED(username)
    Q_UNUSED(password)
    return true;
}
