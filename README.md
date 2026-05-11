# NoteKeeper

A modern Flutter note-taking application with onboarding, authentication, remote note fetching, search, and note statistics.

## Overview

NoteKeeper is built with Flutter and GetX. It connects to a remote backend service to authenticate users and fetch notes, then displays them in a polished mobile interface.

The app includes:

- Onboarding flow for first-time users
- Email/password authentication
- Notes dashboard with search and statistics
- Remote data fetching from a REST API
- Local persistence for onboarding and user session using GetStorage

## Key Features

- **Onboarding screens** to introduce the app experience
- **User authentication** with login and account creation
- **Notes list** with support for search and pinned note display
- **Note statistics** showing total, pinned, and unpinned notes
- **Refresh control** and responsive layout for mobile
- **Snackbar/toast notifications** for user feedback

## CRUD Notes Support

### Current implementation

The application currently implements the following remote note operations through the backend API:

- **Read**: Fetch all notes from the API (`GET /notes`)
- **Read**: Fetch note statistics (`GET /notes/stats`)

### Planned / scaffolded operations

The code contains UI placeholders and controller state for full CRUD support, including:

- **Create note** (floating add button is present in the UI)
- **Update note** (note card tap handler is scaffolded)
- **Delete note** (not yet wired in the UI)

Those flows can be completed by adding the corresponding API calls and UI screens for note creation, editing, and deletion.

## Architecture

The app follows a modular GetX architecture:

- `lib/main.dart` - application entry point and route initialization
- `lib/app/routes/app_pages.dart` - app navigation routes
- `lib/app/modules/onboarding` - onboarding flow and controller
- `lib/app/modules/user` - authentication screens, provider, model, controller
- `lib/app/modules/home` - notes dashboard, data provider, models, controller
- `lib/app/components` - shared UI components like cards, forms, buttons, and messages
- `lib/app/utils` - constants, helper functions, shared exports

## API Configuration

The backend service is configured in `lib/app/utils/api_constants.dart`:

- Base URL: `https://notes-backend-bootcamp.vercel.app/api/v1/`

### Auth endpoints

- `POST auth/users/signup` - create account
- `POST auth/users/login` - sign in

### Notes endpoints

- `GET notes` - retrieve current user notes
- `GET notes/stats` - retrieve notes summary statistics

## Getting Started

### Prerequisites

- Flutter SDK `>=3.11.4`
- Dart SDK matching Flutter SDK
- An Android/iOS emulator or physical device

### Run locally

1. Open the project in VS Code or Android Studio.
2. Run dependency installation:

```bash
flutter pub get
```

3. Start the app:

```bash
flutter run
```

## Project structure

The app is organized into feature modules and shared utilities.

```
lib/
├─ main.dart
├─ app/
│  ├─ routes/
│  │  ├─ app_pages.dart
│  │  └─ app_routes.dart
│  ├─ modules/
│  │  ├─ onboarding/
│  │  │  ├─ bindings/
│  │  │  ├─ controllers/
│  │  │  ├─ views/
│  │  │  └─ widgets/
│  │  ├─ user/
│  │  │  ├─ bindings/
│  │  │  ├─ controllers/
│  │  │  ├─ model/
│  │  │  ├─ providers/
│  │  │  └─ views/
│  │  └─ home/
│  │     ├─ bindings/
│  │     ├─ controllers/
│  │     ├─ model/
│  │     ├─ providers/
│  │     └─ views/
│  ├─ components/
│  └─ utils/
```

- `lib/main.dart` - app bootstrap and initial route selection
- `lib/app/routes/app_pages.dart` - route definitions for onboarding, auth, and home
- `lib/app/modules/onboarding` - onboarding pages and controller
- `lib/app/modules/user` - login/signup flow and local user storage
- `lib/app/modules/home` - notes dashboard, note model, statistics, and data provider
- `lib/app/components` - reusable widgets for cards, text fields, buttons, and messages
- `lib/app/utils` - shared constants, helpers, and navigation utilities

## Notes for Developers

- The sign-in screen is implemented in `lib/app/modules/user/views/user_view.dart`
- Account creation is implemented in `lib/app/modules/user/views/create_account.dart`
- Notes are displayed in `lib/app/modules/home/views/home_view.dart`
- `lib/app/modules/home/providers/home_provider.dart` handles API requests for notes
- `lib/app/modules/user/providers/user_provider.dart` handles authentication and token storage

## Future Improvements

- Enable full note creation, editing, and deletion UI flows
- Add note detail and edit screens
- Support offline note editing and local caching
- Improve error handling and offline experience
- Add theme / dark mode support

## Contact

For questions or contributions, open an issue or pull request in this repository.
