# Folder Structure

```
tiny_cyber_dragon/
├── docs/                          Engineering documentation (first-class deliverable)
├── test/                          Widget and unit tests, mirroring lib/
└── lib/
    ├── main.dart                  Entry point — bootstrapping only
    ├── app/                       Application frame
    │   ├── app.dart               Root widget; theme + router wiring; themeModeProvider
    │   ├── router/
    │   │   └── app_router.dart    go_router config; AppRoutes path constants
    │   └── shell/
    │       └── app_shell.dart     NavigationRail desktop shell with mini Byte
    ├── core/                      Cross-cutting foundations (no feature knowledge)
    │   └── theme/                 Design token system — see THEME_SYSTEM.md
    │       ├── theme.dart         Barrel export
    │       ├── app_theme.dart     Assembles tokens into ThemeData (dark + light)
    │       ├── color_tokens.dart  Brand and surface colors
    │       ├── status_colors.dart StatusLevel enum + semantic colors
    │       ├── typography.dart    Type scale
    │       ├── spacing.dart       4px-grid spacing, radii, common gaps
    │       └── animation_constants.dart  Shared durations and curves
    ├── shared/                    UI used by multiple features
    │   ├── byte/                  The Byte companion system (see BYTE_STATUS_SYSTEM.md)
    │   │   ├── byte.dart          Barrel export
    │   │   ├── byte_enums.dart    ByteMood / ByteAnimationState / BytePosition
    │   │   ├── byte_status.dart   ByteStatus enum + ByteStatusData metadata
    │   │   ├── byte_state.dart    Immutable state model (status + overrides)
    │   │   ├── byte_provider.dart byteStatusProvider — global notifier
    │   │   ├── byte_avatar.dart   Face-only rendering widget (CustomPaint)
    │   │   ├── byte_message_bubble.dart  Standalone speech bubble
    │   │   ├── byte_status_card.dart     Dashboard status panel
    │   │   └── byte_widget.dart   Avatar + bubble composition
    │   └── widgets/               Reusable widget library — see WIDGET_CATALOG.md
    │       ├── widgets.dart       Barrel export
    │       ├── buttons/           PrimaryButton, SecondaryButton
    │       ├── cards/             AppCard (base), StatusCard, LessonCard,
    │       │                      MissionCard, ThreatCard
    │       ├── feedback/          LoadingWidget, ProgressWidget, AppDialog,
    │       │                      EmptyState
    │       └── layout/            SectionHeader
    └── features/                  One folder per product section
        ├── home/presentation/     Dashboard v0.1
        ├── learn/presentation/    Lessons hub (placeholder)
        ├── threat_library/presentation/
        ├── missions/presentation/
        └── settings/presentation/
```

## Why this shape

**Features are vertical slices.** Each section of the product owns its folder. Today each contains only `presentation/`; when real content arrives, `data/` (repositories, Supabase queries) and `domain/` (models, business logic) are added *inside the same feature* — nothing moves, nothing else changes. Deleting or shipping a feature is a folder operation.

**Core is the foundation layer.** It may not import from `shared/` or `features/`. Planned additions: `core/services/` (Supabase client, local storage, logging), `core/utils/`, `core/constants/`. Platform-specific code, when it becomes necessary, lives behind interfaces here so features stay platform-agnostic.

**Shared is cross-feature UI.** The rule for placement: used by one feature → lives in that feature; used by two or more → promoted to `shared/`. Byte gets his own subsystem folder rather than a single widget file because he has state, behavior, and rendering — he is a product pillar, not a component.

**Barrel files** (`theme.dart`, `widgets.dart`, `byte.dart`) keep imports short and give each subsystem a single public doorway, which makes future internal refactors invisible to callers.

## Future-proofing notes

Deep-linkable sub-screens (lesson detail, threat detail) nest as child routes inside their feature's branch in `app_router.dart`. New product sections (e.g., a Glossary in V2) are a new feature folder plus one branch and one rail destination. When offline-first content caching arrives, it lives in `core/services/` + feature `data/` layers — the presentation layer never knows the difference.
