import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 5.15

Item {
    id: baseScreen
    width: 400
    height: 300

    property alias contentItem: contentLoader.item

    // Welcome/Caution overlay  //need to add some timer to play background audio play
    Rectangle {
        id: welcomeOverlay
        anchors.fill: parent
        color: "#333"
        visible: showWelcome
        z: 2

        // Play welcome audio when overlay is shown
        Audio {
            id: welcomeAudio
            source: "../assets/welcome.mp3" // Place your welcome audio file here
            autoPlay: false
        }

        Timer {
            interval: 200 // short delay to ensure overlay is visible
            running: showWelcome
            repeat: false
            onTriggered: {
                if (showWelcome) welcomeAudio.play()
            }
        }

        Column {
            anchors.centerIn: parent
            spacing: 24

            Image {
                source: "../assets/logo.png" // Use your chatapp logo or symbol
                width: 64; height: 64
                fillMode: Image.PreserveAspectFit
            }
            Text {
                text: "Welcome to ChatApp!"
                color: "white"
                font.pixelSize: 26
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text {
                text: "Your secure chat starts here."
                color: "#ccc"
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button {
                text: "Continue"
                onClicked: baseScreen.showWelcome = false
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    property bool showWelcome: true

    // Main content area
    Loader {
        id: contentLoader
        anchors.fill: parent
        z: 1
    }

    // For login success/fail audio, expose methods for main.qml to call
    Audio {
        id: loginSuccessAudio
        source: "../assets/login_success.mp3"
        autoPlay: false
    }
    Audio {
        id: loginFailAudio
        source: "../assets/login_fail.mp3"
        autoPlay: false
    }

    function playLoginSuccess() {
        loginSuccessAudio.play()
    }
    function playLoginFail() {
        loginFailAudio.play()
    }
}
