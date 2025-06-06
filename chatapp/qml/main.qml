import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: qsTr("ChatApp")

    // Load RegisterView
    Loader {
        anchors.fill: parent
        source: "views/RegisterView.qml"
    }
}
