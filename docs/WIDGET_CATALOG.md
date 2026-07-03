# Widget Catalog

Every reusable widget lives in `lib/shared/widgets/` (import the `widgets.dart` barrel) or, for Byte, `lib/shared/byte/`. All of them are content-agnostic: they take plain values today and will accept model-backed factories when data models arrive, so call sites won't churn.

## Base

**AppCard** (`cards/app_card.dart`) — the foundation every content card composes: surface, hairline border, radius, hover glow, tap ripple, and an optional colored accent stripe. Card chrome changes happen here, once. Hover state is local `setState` per the state standard.

## Cards

**StatusCard** — communicates a security/education status: icon chip, title, optional uppercase badge, description, optional trailing widget. Color derives entirely from its `StatusLevel`. Used for the streak and daily-tip cards on Home; built for scan results and account health later.

**LessonCard** — a lesson entry: title, description, duration, and a progress bar that appears once `progress > 0`. Used on Home and, soon, the Learn catalog.

**MissionCard** — a guided-simulation entry: title, description, difficulty chip (beginner/intermediate/advanced with semantic colors), and a completed state that swaps the flag icon for a verified check.

**ThreatCard** — an educational threat entry: severity via `StatusLevel`, shield icon chip, plain-language summary, optional category label. Educational tone by design — informative, never alarming.

## Buttons

**PrimaryButton** — the one visual definition of a main action. Optional leading icon, `expanded` full-width mode, and a built-in `isLoading` state that swaps the label for a spinner and ignores taps. **SecondaryButton** — the outlined companion with a mirrored API, for supporting actions.

## Feedback

**LoadingWidget** — the standard async wait state, centered block or `compact` inline row, with an optional friendly message. **ProgressWidget** — a labeled, animated progress bar (0.0–1.0) used by lessons now and scans later. **AppDialog** — the standard dialog via `AppDialog.show(context, ...)`, returning `true` on confirm; optional `StatusLevel` accent keeps dialog semantics consistent. **EmptyState** — Byte-fronted placeholder for empty screens and sections, with optional action button; keeps "nothing here yet" encouraging instead of dead.

## Layout

**SectionHeader** — titles a content section with optional subtitle and trailing action ("See all"). Gives every screen identical section rhythm.

## Byte

The companion system lives in `shared/byte/` — full design in [BYTE_STATUS_SYSTEM.md](BYTE_STATUS_SYSTEM.md). **ByteAvatar** renders the face only: expression, eye/glow colors, animation (idle bob, attention pulse, still); `ByteAvatar.forStatus(status)` derives all of it from a `ByteStatus`. Rendering is a `CustomPaint`, so skins and new expressions are contained changes; motion honors reduced-motion settings and the avatar carries a semantic label for screen readers. **ByteMessageBubble** is the standalone speech bubble with an optional status-tinted border. **ByteWidget** composes avatar + bubble with positioning (right/left/below/none). **ByteStatusCard** is the dashboard panel: avatar, status label badge, message, dashboard accent stripe, and a `trailing` action slot. Screens feed these from `byteStatusProvider`; features direct Byte through the notifier (`setStatus`, `say`, `celebrate`, `warn`, `think`, `relax`).

## Rules for adding widgets

A widget enters this library when a second feature needs it — not before. It must style itself exclusively from theme tokens, accept a `StatusLevel` rather than raw colors where status is involved, document its purpose and reuse story in a doc comment, and get an entry here. Catalog and code must never drift apart.
