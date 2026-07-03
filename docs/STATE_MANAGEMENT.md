# State Management Standard

**Official TradeSpark Technologies engineering standard for Tiny Cyber Dragon.** Adopted 2026-07-02, Sprint 001.

## The standard

Tiny Cyber Dragon standardizes on **Riverpod** (`flutter_riverpod`) for all application-level state. Local widget state may continue to use `setState` where appropriate.

## Why Riverpod

Riverpod was chosen over Provider, Bloc, and plain `setState` for four reasons. First, compile-time safety: providers are top-level declarations, so a missing or misused dependency is a compile error rather than a runtime `ProviderNotFoundException`. Second, testability: any provider can be overridden in a `ProviderScope` during tests, so features are testable without widget-tree scaffolding — essential as lesson engines and Supabase services arrive. Third, scalability: providers compose (a dashboard provider can watch lesson, mission, and threat providers) without the nesting and context gymnastics Provider requires. Fourth, it is the current community standard with strong maintenance, which matters for a codebase intended to live for years.

## Global vs. local state — the dividing line

**Application-level state uses Riverpod.** If more than one widget cares about it, if it must survive navigation, or if a feature other than the owner can change it, it belongs in a provider. Examples in the codebase today: `byteProvider` (Byte's mood, motion, and message are read by the shell and the dashboard and written by any feature) and `themeModeProvider` (written in Settings, consumed by the root app).

**Local widget state uses `setState`.** If the state is an implementation detail of one widget — an animation controller, a hover flag, a text field's transient contents, whether a panel is expanded — a `StatefulWidget` is correct and a provider would be ceremony. Examples in the codebase today: `ByteWidget`'s animation controller and `AppCard`'s hover state.

The test: *would any other widget ever need to read or change this?* Yes → Riverpod. No → `setState`.

## Conventions

**Provider naming (official standard, adopted 2026-07-02).** Providers are named after the system they expose: `byteStatusProvider`, `themeModeProvider`, and in future sprints `bytePositionProvider`, `lessonProgressProvider`, `missionProgressProvider`, `threatLibraryProvider`. Vague names — `dataProvider`, `stateProvider`, `managerProvider`, or anything that doesn't tell a reader which system it belongs to — are prohibited. The name should let someone grep the codebase and land in the right subsystem on the first try.

Providers are declared in the feature (or shared system) that owns the state, next to their notifier — never in a global providers file. Notifiers expose intention-revealing methods (`byte.celebrate()`, not `byte.state = ...`); raw state mutation from outside the notifier is prohibited. Widgets that read providers are `ConsumerWidget`/`ConsumerStatefulWidget`; use `ref.watch` to render, `ref.read` inside callbacks. Prefer `Notifier`/`NotifierProvider` for anything with behavior; `StateProvider` is acceptable only for trivial single values (like theme mode). When async data arrives in future sprints, model it with `AsyncNotifier` and render `AsyncValue` states through the shared `LoadingWidget` and `EmptyState`.

## Future direction

When Supabase integration lands, repositories will be exposed as providers so they can be swapped with fakes in tests. If code generation becomes worthwhile at scale, migration to `riverpod_generator` syntax is additive and incremental — another reason Riverpod is the safe long-term bet.
