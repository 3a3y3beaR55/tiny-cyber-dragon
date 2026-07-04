import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/byte/byte.dart';
import '../../../shared/widgets/widgets.dart';

/// MissionsScreen — guided simulations that practice safety skills in a
/// safe environment.
///
/// Sprint 001: navigation placeholder. Mission engine arrives in a future
/// sprint under `features/missions/{data,domain}`.
class MissionsScreen extends StatelessWidget {
  const MissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SectionHeader(
            title: 'Missions',
            subtitle: 'Practice real scenarios with Byte at your side',
          ),
          Expanded(
            child: EmptyState(
              title: 'Missions are being planned',
              message:
                  'Guided practice missions are on the way. '
                  "You'll earn your first badge soon.",
              byteMood: ByteMood.celebrating,
            ),
          ),
        ],
      ),
    );
  }
}
