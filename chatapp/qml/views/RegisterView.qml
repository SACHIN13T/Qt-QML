import QtQuick 6.0
import QtQuick.Controls 6.0

Item {
    width: 400
    height: 300

    signal registerClicked(string username, string password)  //register click

    Column {
        anchors.centerIn: parent
        spacing: 20    

        Text {
            text: "Register Here"
            font.pixelSize: 28
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TextField {
            id: usernameField
            placeholderText: "Username"
            width: 200
        }
        TextField {
            id: passwordField
            placeholderText: "Password"
            echoMode: TextInput.Password
            width: 200
        }
        Button {
            text: "Register"
            onClicked: {
                registerClicked(usernameField.text, passwordField.text)
            }
        }
    }
}
