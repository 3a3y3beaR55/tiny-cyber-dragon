import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/byte/byte.dart';
import '../../../shared/widgets/widgets.dart';

/// ThreatLibraryScreen — plain-language encyclopedia of online threats and
/// how to defend against them.
///
/// Sprint 001: navigation placeholder. Threat catalog + detail views arrive
/// in a future sprint under `features/threat_library/{data,domain}`.
class ThreatLibraryScreen extends StatelessWidget {
  const ThreatLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SectionHeader(
            title: 'Threat Library',
            subtitle: 'Know the threats — in plain language, never fear',
          ),
          Expanded(
            child: EmptyState(
              title: 'The library is being stocked',
              message:
                  'Byte is cataloging common threats and how to beat them. '
                  'Check back soon.',
              byteMood: ByteMood.thinking,
            ),
          ),
        ],
      ),
    );
  }
}
