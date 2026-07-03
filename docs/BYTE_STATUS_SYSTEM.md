# Byte Status System

The Byte Status System (added after Sprint 001's foundation) makes Byte's security state the single source of truth for how Byte looks and how the dashboard reacts. It is the visual and state foundation for future defensive features — no real scanning exists yet, by design.

## The model

`ByteStatus` (`lib/shared/byte/byte_status.dart`) is the primary axis of Byte's state, with nine values: `idle`, `scanning`, `warning`, `threat`, `critical`, `complete`, `learning`, `updating`, and `sleeping`. Each status resolves to a `ByteStatusData` record via `status.data`, which controls the eye color, glow color, a human-readable label ("All Clear", "Threat Detected"), a default message, the dashboard accent color, the recommended animation (`ByteAnimationState` for today's avatar plus a stable `animationName` string reserved for future Rive/Lottie assets), and the facial expression Byte wears.

Expression is the key architectural move: the original `ByteMood` enum was *demoted* from primary state to a derived rendering detail. Each status declares its expression, so the avatar painter knows nothing about statuses and the two systems can't disagree. Severity colors come from the shared `StatusLevel` palette, so a `threat` status, a threat card, and a danger dialog are always the same red.

`ByteState` (`byte_state.dart`) holds the current status plus optional momentary overrides (message bubble, eye color, animation). Its derived getters — `mood`, `eyeColor`, `glowColor`, `animationState`, `message` — preserve the Sprint 001 API, which is why this change touched no shell or screen layout code.

## The provider

`byteStatusProvider` (`byte_provider.dart`) is a Riverpod `NotifierProvider` and the only writer of Byte state, per the state standard. Features call `setStatus(ByteStatus.scanning)` or intention shortcuts (`warn`, `celebrate`, `think`, `relax`, `say`, `quiet`) — raw state mutation from outside the notifier is prohibited. A message passed to `setStatus` shows as a speech bubble; without one, the status's default message carries the card.

## The widgets

`ByteAvatar` renders the face only — expression, eye/glow colors, animation — with a `ByteAvatar.forStatus(status)` convenience factory. `ByteMessageBubble` is the standalone speech bubble with an optional status-colored border. `ByteWidget` composes the two with positioning (Sprint 001 API unchanged). `ByteStatusCard` is the dashboard panel: avatar + status label badge + message + accent stripe, with a `trailing` slot for contextual actions like the Run Safety Check button.

## Testing the system

The Home dashboard includes a clearly marked **temporary** test panel (`_ByteStatusTestPanel` in `home_screen.dart`) with a chip per status. Clicking one drives `setStatus`, and the avatar, rail mini-Byte, status card, badge, and accent color all update from the single state change. Remove the panel when real features begin driving statuses; it is deliberately private to the home screen so deleting it is one contained edit.

## Adding a status

Add the enum value and its `ByteStatusData` entry in `byte_status.dart`. Nothing else changes — the card, avatar, provider, and test panel all iterate `ByteStatus.values` or resolve `status.data`. The metadata-completeness unit test in `byte_widget_test.dart` will cover the new status automatically.
