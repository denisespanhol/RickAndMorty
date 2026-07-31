# Rick & Morty App

A modular iOS application built with SwiftUI and Swift Package Manager (SPM). The app features Firebase Authentication, a Rick and Morty API home experience (characters, locations, and episodes), and a shared design system.

---

## Architecture

The project is composed of 3 independent SPM modules integrated into a main app target:

```
Rick-and-Morty-App/              ← workspace root
├── RickAndMorty/                ← Main App (Xcode Project)
├── DSM/                         ← Design System Module (SPM)
├── NetworkKit/                  ← Networking Layer (SPM)
└── LoginModule/                 ← Firebase Auth Module (SPM)
```

### Module dependency graph

```
RickMortyApp (Main App)
    ├── LoginModule  →  DSM
    ├── NetworkKit
    └── DSM
```

### Design pattern

All modules follow **MVVM** (Model-View-ViewModel):
- **Model** — Codable structs from NetworkKit
- **ViewModel** — business logic, state management via `@Published`
- **View** — SwiftUI views, purely declarative

---

## Prerequisites

| Tool | Version |
|------|---------|
| Xcode | 16.0+ |
| iOS Simulator | 26.5+ |
| Swift | 5.9+ (SPM tools: 6.3) |
| Firebase account | Required for authentication |

---

## Firebase Setup

> The `GoogleService-Info.plist` file is **not committed** to this repository for security reasons. You must generate your own.

**1.** Go to [console.firebase.google.com](https://console.firebase.google.com)

**2.** Create a new project (e.g. `RickMortyApp`)

**3.** Click **Add app** → choose **iOS**

**4.** Enter the Bundle ID: `denis.Rick-and-Morty-App`

**5.** Download the `GoogleService-Info.plist` file

**6.** In Xcode, drag the file into `RickAndMorty/Rick-and-Morty-App/Rick-and-Morty-App/RickMortyApp/`
   - Check **Copy items if needed**
   - Make sure the target `Rick-and-Morty-App` is selected

**7.** In the Firebase Console, go to **Authentication → Sign-in method**

**8.** Enable **Email/Password**

**9.** Go to **Authentication → Users** and create a test user

---

## How to Run

**1.** Clone the repository:
```bash
git clone <your-repo-url>
cd Rick-and-Morty-App
```

**2.** Open the project in Xcode:
```bash
open RickAndMorty/Rick-and-Morty-App/Rick-and-Morty-App.xcodeproj
```

**3.** Add the local SPM modules via `File > Add Package Dependencies... > Add Local`:
   - `../DSM`
   - `../NetworkKit`
   - `../LoginModule`

**4.** Add the downloaded `GoogleService-Info.plist` to the project (see Firebase Setup above)

**5.** Select the `Rick-and-Morty-App` scheme and an iOS Simulator

**6.** Press `Cmd + R` to build and run

---

## How to Run Tests

```bash
xcodebuild test \
  -project RickAndMorty/Rick-and-Morty-App/Rick-and-Morty-App.xcodeproj \
  -scheme Rick-and-Morty-App \
  -destination 'platform=iOS Simulator,name=iPhone 16'
```

Or inside Xcode: press `Cmd + U`

### Test coverage

| Module | Tests |
|--------|-------|
| Main App — `CharacterListViewModel` | idle state, success, failure, empty list |
| Main App — `LocationListViewModel` | idle state, success, failure |
| Main App — `EpisodeListViewModel` | idle state, success, failure |

---

## Project Structure

```
RickAndMorty/
└── Rick-and-Morty-App/
    └── Rick-and-Morty-App/
        ├── RickMortyApp/
        │   ├── RickMortyApp.swift       ← App entry point
        │   ├── AppState.swift           ← Global auth state
        │   └── RootView.swift           ← Navigation root (login vs home)
        ├── Home/
        │   └── HomeView.swift           ← TabView with 3 tabs
        ├── Characters/
        │   ├── CharacterListViewModel.swift
        │   ├── CharacterListView.swift
        │   ├── CharacterDetailViewModel.swift
        │   └── CharacterDetailView.swift
        ├── Locations/
        │   ├── LocationListViewModel.swift
        │   ├── LocationListView.swift
        │   ├── LocationDetailViewModel.swift
        │   └── LocationDetailView.swift
        └── Episodes/
            ├── EpisodeListViewModel.swift
            ├── EpisodeListView.swift
            ├── EpisodeDetailViewModel.swift
            └── EpisodeDetailView.swift

DSM/Sources/DSM/
├── Components/
│   ├── DSMButton.swift
│   ├── DSMCell.swift
│   ├── DSMErrorView.swift
│   ├── DSMLabel.swift
│   ├── DSMLoadingView.swift
│   └── DSMTextField.swift
└── Tokens/
    ├── DSMColors.swift
    └── DSMTypography.swift

NetworkKit/Sources/NetworkKit/
├── APIClient.swift
├── Endpoints/
├── Errors/
└── Models/
    ├── APIResponse.swift
    ├── Character.swift
    ├── Location.swift
    └── Episode.swift

LoginModule/Sources/LoginModule/
├── LoginModule.swift
├── AuthService/
├── View/
└── ViewModel/
```

---

## API Reference

This app consumes the public [Rick and Morty API](https://rickandmortyapi.com/documentation).

| Resource | Endpoint |
|----------|----------|
| Characters | `GET https://rickandmortyapi.com/api/character` |
| Character detail | `GET https://rickandmortyapi.com/api/character/{id}` |
| Locations | `GET https://rickandmortyapi.com/api/location` |
| Location detail | `GET https://rickandmortyapi.com/api/location/{id}` |
| Episodes | `GET https://rickandmortyapi.com/api/episode` |
| Episode detail | `GET https://rickandmortyapi.com/api/episode/{id}` |

---

## Security Notes

- `GoogleService-Info.plist` is listed in `.gitignore` and must **never** be committed
- No API keys or secrets are hardcoded in source files
