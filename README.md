# 🐉 Tiny Cyber Dragon

A cybersecurity education platform for beginners, built by **TradeSpark Technologies** under the Genesis Blueprint Protocol. Tiny Cyber Dragon teaches everyday people how to stay safe online through interactive lessons, guided simulations, and a friendly cyber companion named **Byte**.

Every feature should make the user feel more confident than they did five minutes ago.

## Status

Sprint 001 — Foundation. The app launches to a professional dashboard with full theme system, navigation shell, reusable widget library, and Byte integration. No cybersecurity functionality yet; all content is placeholder by design.

## Getting started

The repository ships the full Dart source. Generate the Windows runner once, fetch packages, and run:

```powershell
cd tiny_cyber_dragon
flutter create . --platforms=windows --org com.tradespark
flutter pub get
flutter run -d windows
```

Commit the generated `windows/` folder afterward — it is part of the project. To add macOS or Linux later, rerun `flutter create .` with those platforms; no Dart code changes are required because the architecture is platform-agnostic.

## Verifying the build

Run `flutter analyze` (should report no issues) and `flutter test` (widget tests for the shell and Byte). Manual smoke test: the app opens on Home showing Byte with a greeting; the five rail destinations switch screens; the Run Safety Check button shows a "coming soon" dialog and Byte's mood changes to thinking and back; Settings toggles dark/light theme live.

## Documentation

Engineering docs live in `docs/`: [ARCHITECTURE.md](docs/ARCHITECTURE.md) for the big picture, [STATE_MANAGEMENT.md](docs/STATE_MANAGEMENT.md) for the official Riverpod standard, [FOLDER_STRUCTURE.md](docs/FOLDER_STRUCTURE.md) for what goes where, [THEME_SYSTEM.md](docs/THEME_SYSTEM.md) for design tokens, and [WIDGET_CATALOG.md](docs/WIDGET_CATALOG.md) for the reusable widget library.

## Ethics

This is defensive, educational software only. The project never includes offensive tooling, exploit code, or anything intended for unauthorized access.
