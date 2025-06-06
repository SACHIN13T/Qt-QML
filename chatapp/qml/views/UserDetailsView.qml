import QtQuick 6.0
import QtQuick.Controls 6.0

Item {
    width: 400
    height: 300

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "User Details"
            font.pixelSize: 24
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            id: userLabel
            text: "Welcome, " + (username ? username : "User")
            font.pixelSize: 18
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    property string username: ""
}
