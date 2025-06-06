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

    Loader {
        id: viewLoader
        anchors.fill: parent
        source: currentView === "register" ? "views/RegisterView.qml" : "views/UserDetailsView.qml"
        onLoaded: {
            if (currentView === "register") {
                viewLoader.item.registerClicked.connect(function(username, password) {
                    registeredUsername = username
                    registeredPassword = password
                    currentView = "userDetails"
                })
            } else if (currentView === "userDetails") {
                viewLoader.item.username = registeredUsername
            }
        }
    }
}
