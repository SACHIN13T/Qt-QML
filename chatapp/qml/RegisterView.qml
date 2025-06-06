import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 400
    height: 300

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
    }
}
