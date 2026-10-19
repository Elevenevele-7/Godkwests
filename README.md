# Ascension

> You choose who you want to become. The system helps you become that person and shows you how far you've come.

A personal-growth app that combines habit tracking, financial discipline, long-term visions, learning and AI coaching in one system. Built with **Flutter** and **Supabase**.

- Product blueprint: [`docs/blueprint.md`](docs/blueprint.md)
- Architecture and folder layout: [`docs/architecture.md`](docs/architecture.md)
- Roadmap and open design decisions: [`docs/roadmap.md`](docs/roadmap.md)

## Getting started

Requirements: Flutter (stable channel, Dart 3.13+).

```bash
flutter pub get
flutter run            # runs without a backend; screens show empty states
```

To connect a Supabase project, copy `env.example.json` to `env.json` (git-ignored), fill in your project URL and publishable key, then:

```bash
flutter run --dart-define-from-file=env.json
```

## Checks

```bash
dart format lib test
flutter analyze
flutter test
```

## Status

Phase 1 (Foundation) is done: project scaffold, folder layout, dependencies, navigation shell and the Command Center layout with empty states. The next phase is the database design. See the [roadmap](docs/roadmap.md).
