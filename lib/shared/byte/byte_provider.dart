import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'byte_state.dart';
import 'byte_status.dart';

/// ByteStatusNotifier — the single writer of app-wide Byte state.
///
/// Features change Byte through [setStatus] or the intention-revealing
/// shortcuts; they never mutate raw state. This keeps Byte's personality
/// and the dashboard's reaction consistent product-wide.
///
/// No real scanning exists yet — statuses are a visual/state foundation.
class ByteStatusNotifier extends Notifier<ByteState> {
  @override
  ByteState build() => const ByteState(
        messageOverride: "Hi! I'm Byte. I'll help you stay safe online.",
      );

  /// Move Byte to [status]. Optional [message] shows a speech bubble;
  /// otherwise any previous bubble is cleared so the status's own default
  /// message (shown by ByteStatusCard) takes over.
  void setStatus(ByteStatus status, {String? message}) {
    state = ByteState(status: status, messageOverride: message);
  }

  /// Byte says something without changing status.
  void say(String message) => state = state.copyWith(messageOverride: message);

  /// Clear the speech bubble.
  void quiet() => state = state.copyWith(clearMessage: true);

  // ── Intention shortcuts (Sprint 001 API, now status-backed) ──────────

  void celebrate([String? message]) =>
      setStatus(ByteStatus.complete, message: message);

  void warn(String message) =>
      setStatus(ByteStatus.warning, message: message);

  void think([String? message]) =>
      setStatus(ByteStatus.learning, message: message);

  void relax() => setStatus(ByteStatus.idle);
}

/// Global Byte status state. Watch to render; read the notifier to direct
/// Byte: `ref.read(byteStatusProvider.notifier).setStatus(ByteStatus.scanning)`.
final NotifierProvider<ByteStatusNotifier, ByteState> byteStatusProvider =
    NotifierProvider<ByteStatusNotifier, ByteState>(ByteStatusNotifier.new);
