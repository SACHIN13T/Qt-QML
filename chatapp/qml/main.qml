import QtQuick 6.0
import QtQuick.Controls 6.0
import Backend 1.0

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: qsTr("ChatApp")

    property UserManager userManager: UserManager {}
    property string currentView: "register"
    property string registeredUsername: ""
    property string registeredPassword: ""

    // Use BaseScreen as the main screen
    Loader {
        id: baseLoader
        anchors.fill: parent
        source: "views/BaseScreen.qml"
        onLoaded: {
            function showView(viewName) {
                if (viewName === "register") {
                    baseLoader.item.contentItem = Qt.createComponent("views/RegisterView.qml").createObject(baseLoader.item)
                    baseLoader.item.contentItem.registerClicked.connect(function(username, password) {
                        if (userManager.registerUser(username, password)) {
                            registeredUsername = username
                            registeredPassword = password
                            if (baseLoader.item.playLoginSuccess) baseLoader.item.playLoginSuccess()
                            currentView = "userDetails"
                            showView("userDetails")
                        } else {
                            if (baseLoader.item.playLoginFail) baseLoader.item.playLoginFail()
                        }
                    })
                } else if (viewName === "userDetails") {
                    baseLoader.item.contentItem = Qt.createComponent("views/UserDetailsView.qml").createObject(baseLoader.item)
                    baseLoader.item.contentItem.username = registeredUsername
                } else if (viewName === "changePassword") {
                    baseLoader.item.contentItem = Qt.createComponent("views/ChangePasswordView.qml").createObject(baseLoader.item)
                    baseLoader.item.contentItem.username = registeredUsername
                    baseLoader.item.contentItem.passwordChanged.connect(function(newPassword) {
                        if (userManager.changePassword(registeredUsername, newPassword)) {
                            currentView = "userDetails"
                            showView("userDetails")
                        }
                    })
                } else if (viewName === "login") {
                    // Dummy login screen for demonstration
                    // You should implement a real login screen
                    var loginDialog = Qt.createQmlObject('import QtQuick.Controls 6.0; Dialog { id: dlg; title: "Login"; modal: true; standardButtons: Dialog.Ok | Dialog.Cancel; property string username: ""; property string password: ""; contentItem: Column { spacing: 10; TextField { placeholderText: "Username"; text: dlg.username } TextField { placeholderText: "Password"; echoMode: TextInput.Password; text: dlg.password } } }', baseLoader.item)
                    loginDialog.open()
                    loginDialog.accepted.connect(function() {
                        if (userManager.loginUser(loginDialog.username, loginDialog.password)) {
                            registeredUsername = loginDialog.username
                            if (userManager.isPasswordExpired(registeredUsername)) {
                                currentView = "changePassword"
                                showView("changePassword")
                            } else {
                                currentView = "userDetails"
                                showView("userDetails")
                            }
                        } else {
                            if (baseLoader.item.playLoginFail) baseLoader.item.playLoginFail()
                        }
                    })
                }
            }
            showView(currentView)
        }
    }
}
