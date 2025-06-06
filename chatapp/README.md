# ChatApp (Qt Quick + C++)

## Project Structure

```
chatapp/
├── backend/         # C++ logic classes
├── qml/             # All QML files
├── assets/          # Icons and images
├── main.cpp         # App entry point
├── chatapp.pro      # Qt Project File
├── CMakeLists.txt   # CMake Build File
└── README.md
```

## Setup Instructions

1. Open `chatapp` in Qt Creator.
2. Choose either `chatapp.pro` (qmake) or `CMakeLists.txt` (CMake) as the project file.
3. Build and run the project.
4. You should see a window with the heading "Register Here".

## Development
- Place all QML files in `qml/`.
- Place all C++ backend logic in `backend/` (and headers in `include/`).
- Place images, icons, and audio in `assets/`.

## Notes
- The project is ready for further development.
- Update `main.cpp` and QML as you add features.
