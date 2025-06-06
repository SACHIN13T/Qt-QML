import QtQuick 6.0
import QtQuick.Controls 6.0

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: qsTr("ChatApp")

    property string currentView: "register"
    property string registeredUsername: ""
    property string registeredPassword: ""

    // Use BaseScreen as the main screen
    Loader {
        id: baseLoader
        anchors.fill: parent
        source: "views/BaseScreen.qml"
        onLoaded: {
            // Set the main content of BaseScreen
            baseLoader.item.contentItem = Qt.createComponent(currentView === "register" ? "views/RegisterView.qml" : "views/UserDetailsView.qml").createObject(baseLoader.item)
            if (currentView === "register") {
                baseLoader.item.contentItem.registerClicked.connect(function(username, password) {
                    registeredUsername = username
                    registeredPassword = password
                    // Simulate login logic (replace with real backend call)
                    var loginSuccess = username && password && username.length > 0 && password.length > 0 // Dummy logic
                    if (loginSuccess) {
                        if (baseLoader.item.playLoginSuccess) baseLoader.item.playLoginSuccess()
                        currentView = "userDetails"
                        baseLoader.item.contentItem = Qt.createComponent("views/UserDetailsView.qml").createObject(baseLoader.item)
                        baseLoader.item.contentItem.username = registeredUsername
                    } else {
                        if (baseLoader.item.playLoginFail) baseLoader.item.playLoginFail()
                    }
                })
            } else if (currentView === "userDetails") {
                baseLoader.item.contentItem.username = registeredUsername
            }
        }
    }
}
