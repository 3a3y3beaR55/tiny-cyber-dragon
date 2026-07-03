# Sprint 002 Plan — Byte Alive

**Status: PLAN ONLY — approved architecture required before implementation.**
Objective: Byte stops being a picture in a card and becomes a living presence — he perches, moves, patrols, watches the cursor, and performs scan and threat-response animations. No real scanning; everything remains a visual and state foundation, consistent with the defensive-education mandate.

## Architecture approach

### One dragon, one flight layer

The central decision: there is exactly **one live Byte** in the app, rendered on a **flight layer** — a `Stack` overlay added inside `AppShell` above the routed content. Today Byte appears twice (rail mini-Byte and dashboard card); Sprint 002 unifies these as *perches* for the single overlay Byte. When Byte occupies a perch, the perch's placeholder is empty and the overlay Byte sits exactly over it; when he flies, the overlay animates his position between perch rectangles. This avoids two dragons ever being visible, keeps every screen ignorant of movement logic, and means any future screen gains a living Byte just by declaring a perch.

Why not Flutter's `Overlay`/`OverlayEntry`? A plain `Stack` in the shell is simpler, testable without overlay plumbing, and sufficient because Byte never needs to float above dialogs (during dialogs he pauses — deliberate, so he never obscures safety-critical UI).

### Position system and perches

A `BytePerchAnchor` widget marks a spot where Byte may land. Screens place anchors declaratively; each anchor registers its `GlobalKey`-derived global rect (measured post-frame, re-measured on resize) into `bytePerchRegistryProvider` and unregisters on dispose. Perches are identified by a `BytePerchId` enum — planned locations: `railHome` (bottom of the NavigationRail, Byte's default home), `dashboardCard` (inside ByteStatusCard), `screenCorner` (bottom-right of the content area, available on every screen), plus room for future per-feature perches (lesson header, mission tracker). The registry is the single source of geometric truth; the flight layer never queries widgets directly.

`bytePositionProvider` (a `Notifier` — the single writer, per the state standard) holds `BytePositionState`: `currentPerch`, `targetPerch`, and a `ByteMovementState` enum with `perched`, `takingOff`, `flying`, `landing`, and `patrolling`. Movement is a tweened arc between perch rects (curved control point, `AnimationConstants` timings, size interpolating between perch sizes so rail-Byte is small and dashboard-Byte is large). Reduced-motion users get an instant crossfade instead of flight — same state machine, different presentation.

### Eye/fire color synchronization

`ByteStatusData` gains a `fireColor` field (defaulting to a brightened `glowColor`). Every effect painter — flight trail, fire-breath particles, scan sweep — takes its colors from the current `ByteState`'s status data, never from local constants. Because `byteStatusProvider` is already the single source of truth, eye, glow, fire, trail, accent, and dashboard all synchronize automatically when the status changes; this sprint adds no second color pathway, only more consumers of the existing one.

### Pointing behavior

Byte can *point at* UI elements to direct the user's attention — the teaching gesture that later powers "look at this suspicious link" moments in lessons and the threat demo. Implementation reuses the perch infrastructure: any widget can declare itself a `BytePointTarget` (same rect-registration mechanism as `BytePerchAnchor`, separate registry so perches and point targets stay distinct concepts). `bytePositionProvider` gains a `pointingAt` field; when set, Byte flies to the nearest perch, orients toward the target rect, and the avatar renders an extended wing/claw plus an animated dashed guide-line in the status `fireColor` from Byte to the target. Pointing is initiated only through the notifier API (`pointAt(targetId)`, `stopPointing()`), so features request attention direction the same way they request status changes.

### Color-matched fire breath

A short fire-breath burst is Byte's emphasis gesture — celebration on `complete`, the finale of the threat demo, a lesson milestone later. `FireBreathPainter` (particle arc from the mouth, ~800ms, honoring reduced-motion by swapping to a static glow flash) draws exclusively from the current status's `fireColor`, which itself defaults from `glowColor` — so fire, eyes, glow, trail, and dashboard accent can never disagree. Fire breath is triggered via the notifier (`breatheFire()`) and auto-expires; it is an effect layered on the avatar, not a status, so it composes with any status.

### Mouse-aware behavior

A `MouseRegion` on the shell feeds `pointerPositionProvider` (throttled to ~30 Hz writes; consumers repaint via the avatar's existing ticker, so cursor tracking adds no extra frame pressure). `ByteAvatar` gains an optional `lookTarget` offset: pupils shift a few logical pixels toward the cursor within the eye bounds. Behaviors, in order of ambition: eyes follow cursor (ships first), a happy blink + greeting bubble when the cursor hovers Byte, and a small dodge if the cursor "pokes" him repeatedly (stretch goal). Mouse-awareness is presentation-layer only — it never writes to `byteStatusProvider`, so a hover can't stomp a real warning state.

### Patrol mode

`bytePatrolProvider` (`Notifier` with an injectable clock for testability) is a timer-driven director: after N seconds of user inactivity (default 45s), Byte flies to a random other perch; after a few hops he returns home to the rail. Patrol pauses immediately on any pointer/keyboard activity, during dialogs, whenever status severity is `warning` or above (an alert dragon does not wander), and under reduced-motion. A Settings toggle ("Byte roams the app") turns it off entirely; the toggle state is `byteRoamingEnabledProvider` and later persists via the future storage service.

### Scan animation

While status is `scanning`, a `ScanSweepPainter` layered over/around the avatar draws a rotating radar arc plus expanding rings in `fireColor`. It is a pure presentation effect keyed off status — the existing status system needs no change beyond `fireColor`. The Run Safety Check button demo becomes: fly to `screenCorner` → sweep for ~3s → return with `complete`.

### Threat demo animation

`threatDemoProvider` (a `Notifier` acting as a scripted director) steps through a canned sequence with real timings: `scanning` (sweep, 3s) → `threat` ("Byte found a suspicious link — this is a demo") → user acknowledges via `AppDialog` → `complete` (celebration hop at the current perch). It only calls the public `byteStatusProvider` API — proving the status system can be driven by a real engine later, which is the point of this sprint. The demo is triggered from the (still temporary) dashboard test panel, clearly labeled as a demo. No scanning, no file access, no system APIs.

## Files to add

Position system: `lib/shared/byte/position/byte_perch.dart` (BytePerchId enum + perch metadata), `byte_perch_anchor.dart`, `byte_perch_registry_provider.dart`, `byte_position_provider.dart` (state + movement enum + `pointingAt`), `byte_flight_layer.dart` (the overlay), `byte_patrol_provider.dart`, `byte_point_target.dart` (attention-target registration). Interaction: `lib/shared/byte/interaction/pointer_position_provider.dart`. Effects: `lib/shared/byte/effects/scan_sweep_painter.dart`, `fire_breath_painter.dart` (color-matched burst), `flight_trail_painter.dart`, `pointing_guide_painter.dart` (dashed guide-line). Demo: `lib/shared/byte/demo/threat_demo_provider.dart`. Docs: `docs/BYTE_ALIVE_SYSTEM.md`. Tests: `test/shared/byte/position/byte_position_test.dart`, `byte_patrol_test.dart`, `test/shared/byte/demo/threat_demo_test.dart`, `test/shared/byte/effects/fire_color_sync_test.dart` (every status yields consistent eye/glow/fire colors).

## Files to modify

`byte_status.dart` (add `fireColor` to ByteStatusData — additive, no call-site churn), `byte_avatar.dart` (optional `lookTarget` pupil offset; effects slot), `byte_state.dart` (nothing expected — movement lives in its own provider by design), `app_shell.dart` (Stack + flight layer + MouseRegion; rail Byte becomes `BytePerchAnchor(railHome)`), `byte_status_card.dart` (its avatar becomes `BytePerchAnchor(dashboardCard)`), `home_screen.dart` (test panel gains patrol toggle + "Run threat demo" button), `settings_screen.dart` (roaming toggle), `byte.dart` barrel, and doc updates to ARCHITECTURE, FOLDER_STRUCTURE, WIDGET_CATALOG, BYTE_STATUS_SYSTEM.

## Phasing

Phase 1 — perch registry + flight layer + position provider (Byte visibly relocates between rail, dashboard, and corner — the fly-to-corner behavior). Phase 2 — patrol mode + settings toggle. Phase 3 — pointer tracking + hover reactions + pointing behavior. Phase 4 — scan sweep, fire breath, flight trail, threat demo. Each phase is independently shippable and reviewable; if the sprint must cut, cut from the tail.

## Testing plan

Unit: perch registry register/unregister/re-measure math; position provider state machine (illegal transitions rejected — e.g. new flight while `takingOff` queues rather than teleports); patrol timing with a fake clock (fires after threshold, pauses on activity, respects severity gate and toggle); threat demo step sequence and timings. Widget: anchors report correct rects after layout and resize; flight layer places Byte over the active perch; pupils offset toward an injected pointer position; reduced-motion yields crossfade (no position tween frames). All widget tests use fixed-duration `pump` — Byte's loops make `pumpAndSettle` hang (documented pattern from Sprint 001). Manual checklist: no double-Byte at any moment during flight; patrol never wanders while a warning/threat status is active; dialogs pause patrol; 60 fps during flight with DevTools repaint rainbow clean outside the flight layer (`RepaintBoundary` around routed content); Settings toggle kills all autonomous movement; Windows resize re-measures perches correctly.

## Risks and open questions

Perch rect staleness on window resize is the main technical risk — mitigated by post-frame re-measure and a "snap home" fallback if a perch disappears mid-flight (e.g. user navigates away from the dashboard while Byte is flying to it). Pointer throttling needs profiling on low-end hardware. Open product question for Irons: should patrol be **on or off by default**? Recommendation: on, with the Settings toggle prominent — Byte being alive is the product's personality, but accessibility settings must win. Second question: when your progression art PNG replaces the CustomPaint avatar (it slots behind the `ByteAvatar` API), do we want flight sprites in that art set? If so, the `animationName` strings from the status system become the asset naming contract.

## Git

Branch `feature/sprint-002-byte-alive`; one commit per phase (`feat(byte): perch registry and flight layer`, `feat(byte): patrol mode`, `feat(byte): pointer awareness`, `feat(byte): scan sweep and threat demo`); PR per phase or one PR with four reviewable commits — Irons's call.
