import QtQuick 6.0
import QtQuick.Controls 6.0

Item {
    width: 300
    height: 250

    property string username: ""
    property string password: ""
    property bool showError: false
    property string errorText: ""

    Column {
        anchors.centerIn: parent
        spacing: 16
        Label {
            text: "Register Here"
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
        }
        TextField {
            id: usernameField
            placeholderText: "Username"
            text: username
            onTextChanged: username = text
        }
        TextField {
            id: passwordField
            placeholderText: "Password"
            echoMode: TextInput.Password
            text: password
            onTextChanged: password = text
        }
        Button {
            text: "Register"
            onClicked: {
                if (!isValidUsername(username)) {
                    errorText = "Invalid username. Use at least 4 letters or numbers."
                    showError = true
                } else if (!isValidPassword(password)) {
                    errorText = "Invalid password. Use at least 6 characters, including a letter and a number."
                    showError = true
                } else {
                    showError = false
                    // Proceed with registration logic
                }
            }
        }
    }
    Dialog {
        id: errorDialog
        title: "Error"
        visible: showError
        modal: true
        standardButtons: Dialog.Ok
        onAccepted: showError = false
        contentItem: Label {
            text: errorText
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
