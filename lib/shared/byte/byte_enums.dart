/// Byte's expressive vocabulary.
///
/// Byte is part of the user experience, not decoration — these enums are the
/// contract every feature uses to talk to Byte. Adding a mood here (plus its
/// rendering in `byte_widget.dart`) makes it available product-wide.
library;

/// How Byte feels. Drives face rendering and default glow color.
enum ByteMood {
  /// Default companion state — relaxed and friendly.
  happy,

  /// Something needs the user's attention (never scary, just alert).
  alert,

  /// Processing / teaching moment.
  thinking,

  /// Idle for a long time or app-quiet moments.
  sleeping,

  /// User completed a lesson or mission.
  celebrating,
}

/// How Byte moves. Kept separate from mood so any mood can use any motion.
enum ByteAnimationState {
  /// Gentle breathing bob (default).
  idle,

  /// Rhythmic glow pulse — draws attention.
  pulse,

  /// No motion — respects reduced-motion settings and static contexts.
  still,
}

/// Where Byte's message bubble appears relative to the avatar.
enum BytePosition { messageRight, messageLeft, messageBelow, messageNone }
