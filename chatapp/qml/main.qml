import QtQuick 2.15
import QtQuick.Controls 2.15

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
                    currentView = "userDetails"
                    // Switch to user details view
                    baseLoader.item.contentItem = Qt.createComponent("views/UserDetailsView.qml").createObject(baseLoader.item)
                    baseLoader.item.contentItem.username = registeredUsername
                })
            } else if (currentView === "userDetails") {
                baseLoader.item.contentItem.username = registeredUsername
            }
        }
    }
}
