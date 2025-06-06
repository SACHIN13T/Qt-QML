# ChatApp

A Qt Quick Application using QML for the frontend and C++ for the backend.

## Project Structure

```
chatapp/
├── CMakeLists.txt / chatapp.pro   # Project build file
├── README.md                      # Project overview & build guide
├── main.cpp                       # App entry point
├── include/                       # C++ header files (.h/.hpp)
│   └── usermanager.h              # Example: UserManager class header
├── src/                           # C++ source files (.cpp)
│   └── usermanager.cpp            # Example: UserManager class logic
├── qml/                           # All QML files
│   ├── main.qml                   # Root QML file
│   └── views/
│       └── RegisterView.qml       # Registration screen
├── assets/                        # Icons, images, fonts
│   └── logo.png                   # Example asset
```

## Setup Instructions

### Prerequisites
- Qt 5.15+ or Qt 6.x (with Qt Quick)
- CMake 3.14+
- C++17 compiler

### Build & Run (CMake)
```bash
cd chatapp
mkdir build && cd build
cmake ..
make
./chatapp
```

### Build & Run (Qt Creator)
- Open `chatapp.pro` or `CMakeLists.txt` in Qt Creator
- Click the Run button

### Development Notes
- Place new QML files in `qml/` and `qml/views/`
- Place new C++ backend files in `src/` and headers in `include/`
- Place images/icons in `assets/`

---
- The initial window loads `RegisterView.qml` as a test.
- Update `main.cpp` and QML files as you add features.
