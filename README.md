News App

A Flutter sample app that fetches top headlines from NewsAPI.org using a clean layered structure (app, presentation, domain, data), Retrofit + Dio, Bloc/Cubit, and DI with get_it.

Prerequisites

- Flutter SDK installed
- A NewsAPI API key from https://newsapi.org/

Project Structure (high-level)

- lib/app — app bootstrap, routing, styles
- lib/presentation — UI, widgets, cubits
- lib/domain — use cases, repository contracts
- lib/data — data sources (Retrofit), models, repository implementations
- lib/app/di — service locator (get_it)

Setup

1. Install dependencies

```
flutter pub get
```

2. Configure API key

- Open `lib/app/networking/dio_factory.dart` and replace the placeholder with your key:

```dart
options.queryParameters.addAll({
  "apiKey": "<PUT_YOUR_NEWSAPI_KEY_HERE>",
});
```

Alternatively, you can load it from secure storage or environment, then inject via headers/query params.

3. (If you modify Retrofit interfaces) regenerate code

```
flutter pub run build_runner build --delete-conflicting-outputs
```

Run

- Android/iOS:

```
flutter run
```

- Web (Device Preview is enabled):

```
flutter run -d chrome
```

Features

- Top headlines by category with pull-to-refresh
- Error/empty states with retry
- Article details (title, image, description/content)
- Open full article in browser (with URL normalization)
- DI via get_it and state management with Bloc/Cubit

Notes

- Some feeds return malformed URLs or images; the app normalizes URLs and shows placeholders when needed.
- If opening URLs fails on your device, ensure a default browser is installed and restart after any AndroidManifest changes.

# news

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
