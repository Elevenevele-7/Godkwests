# Godkwests

> You choose who you want to become. The system helps you become that person and shows you how far you've come.

A personal-growth app that combines habit tracking, financial discipline, long-term visions, learning and AI coaching in one system. Built with **Flutter** and **Supabase**.

- Product blueprint: [`docs/blueprint.md`](docs/blueprint.md)
- Architecture and folder layout: [`docs/architecture.md`](docs/architecture.md)
- Roadmap and open design decisions: [`docs/roadmap.md`](docs/roadmap.md)
- Learning & build plan (timeline and daily routine): [`docs/learning-plan.md`](docs/learning-plan.md)
- Database decisions (offline-first, encrypted finance): [`docs/database.md`](docs/database.md)
- Scoring rules (XP, levels, penalties, DP, VP): [`docs/scoring-spec.md`](docs/scoring-spec.md)
- **Setup: run on your phone, connect Supabase and the AI Council: [`docs/setup.md`](docs/setup.md)**

## Getting started

Requirements: Flutter (stable channel, Dart 3.13+).

```bash
flutter pub get
flutter run            # works fully offline; no account needed
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

The core app is built: missions, finance, visions, scoring, the Knowledge Hub reader, the AI Council, onboarding and encrypted sync, with 41 automated tests passing. It works fully offline. Sync and the AI Council switch on once a Supabase project is connected. Not yet tried on a real phone or against a live Supabase project; see [roadmap → Not yet verified](docs/roadmap.md#not-yet-verified).
