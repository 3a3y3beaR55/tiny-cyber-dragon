import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/byte/byte.dart';
import '../../../shared/widgets/widgets.dart';

/// LearnScreen — interactive lessons hub.
///
/// Sprint 001: navigation placeholder. Lesson catalog, categories, and
/// progress tracking arrive in a future sprint under
/// `features/learn/{data,domain}`.
class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Learn',
            subtitle: 'Interactive lessons that build real-world safety skills',
          ),
          const Expanded(
            child: EmptyState(
              title: 'Lessons are hatching',
              message:
                  'Your first cybersecurity lessons arrive in the next update. '
                  "Byte can't wait to teach you.",
              byteMood: ByteMood.happy,
            ),
          ),
        ],
      ),
    );
  }
}
