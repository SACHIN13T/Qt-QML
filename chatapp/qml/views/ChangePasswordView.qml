import QtQuick 6.0
import QtQuick.Controls 6.0

Item {
    width: 400
    height: 300

    property string username: ""
    signal passwordChanged(string newPassword)

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "Change Password"
            font.pixelSize: 24
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
        TextField {
            id: newPasswordField
            placeholderText: "New Password"
            echoMode: TextInput.Password
            width: 200
        }
        TextField {
            id: confirmPasswordField
            placeholderText: "Confirm Password"
            echoMode: TextInput.Password
            width: 200
        }
        Button {
            text: "Change Password"
            onClicked: {
                if (newPasswordField.text.length < 6 || newPasswordField.text !== confirmPasswordField.text) {
                    errorDialog.text = "Passwords must match and be at least 6 characters."
                    errorDialog.open()
                } else {
                    passwordChanged(newPasswordField.text)
                }
            }
        }
    }
    Dialog {
        id: errorDialog
        title: "Error"
        modal: true
        standardButtons: Dialog.Ok
        contentItem: Label {
            text: errorDialog.text
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
