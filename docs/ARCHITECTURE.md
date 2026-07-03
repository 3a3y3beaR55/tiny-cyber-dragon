# Architecture

Tiny Cyber Dragon uses a **feature-first architecture with a shared core**, chosen so the codebase still makes sense at Version 5 when it has fifty screens instead of five.

## The big picture

`lib/app/` owns the application frame: the root widget, the router, and the navigation shell. `lib/core/` owns cross-cutting foundations that features build on — today that is the theme system; services (Supabase client, storage, logging) will join it. `lib/shared/` owns UI that is used by more than one feature: the reusable widget library and the Byte companion system. `lib/features/` owns the product itself, one folder per section, each with a `presentation/` layer now and `data/` + `domain/` layers when real content arrives.

The dependency rule is one-directional: features may depend on shared and core; shared may depend on core; core depends on nothing above it. Features never import each other — if two features need the same thing, it moves to shared or core. This rule is what keeps the codebase from tangling as it grows.

## Navigation

Routing uses go_router with `StatefulShellRoute.indexedStack`. Each section is a branch whose navigation stack survives tab switches — the behavior desktop users expect — and every screen gets a URL-style location for free, which becomes deep-linking to individual lessons and threats in later sprints. The shell (`AppShell`) renders a `NavigationRail` and knows nothing about individual screens; adding a section means one new branch in the router and one destination entry in the shell.

## Platform strategy

Sprint 001 targets Windows desktop, but no Dart code is Windows-specific. Anything platform-dependent in the future (notifications, file system, OS integrations) must be isolated behind a service interface in `core/services/` with platform implementations selected at startup — UI and features stay platform-agnostic. Adding macOS, Linux, or mobile should require runner generation and layout responsiveness work, not architectural change.

## Byte is a system, not a widget

Byte has an immutable state model (`ByteState`) driven by a nine-value `ByteStatus` enum, a single global writer (`ByteStatusNotifier` via `byteStatusProvider`, with intention-revealing methods like `setStatus`, `celebrate`, `warn`), and composable rendering widgets (`ByteAvatar`, `ByteMessageBubble`, `ByteWidget`, `ByteStatusCard`) used everywhere from the rail to empty states. Features direct Byte through the notifier; they never construct their own dragon. This guarantees Byte's personality stays consistent no matter which feature triggers him. See [BYTE_STATUS_SYSTEM.md](BYTE_STATUS_SYSTEM.md) for the full design.

## State management

Riverpod is the official standard — see [STATE_MANAGEMENT.md](STATE_MANAGEMENT.md) for the full decision record and rules.

## Design decisions worth remembering

Dark mode is the primary theme and the light theme is intentionally minimal until a design pass. The scan button is a placeholder that opens a dialog — real functionality is explicitly out of scope for Sprint 001. All card widgets compose a single `AppCard` base so card chrome changes in one file. Placeholder screens use `EmptyState`, which proves the reuse model on day one.

## Version 5 test

Can this be reused? Every visual element is a shared widget or composes one. Will this scale? New features are additive folders; the shell, router, theme, and Byte don't change. Does it follow the Genesis Framework? Documentation ships with the code, reuse is structural rather than aspirational, and nothing here is offensive tooling — defensive education only.
