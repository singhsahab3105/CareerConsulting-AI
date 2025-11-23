import 'package:flutter/material.dart';

import '../widgets/responsive_shell.dart';
import 'assessment_screen.dart';
import 'chatbot_screen.dart';

/// Main screen that the user sees after opening the app.
/// It combines a short description on top + the two sub flows (assessment & chatbot).
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final pages = [
      const AssessmentScreen(),
      const ChatbotScreen(),
    ];

    final header = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.surface,
          ],
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Career Consulting-AI',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'A small AI-powered portal to explore your career direction, '
            'identify skill gaps and ask specific questions – designed as a '
            'college major project.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          const Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _TagChip(label: 'Student focused'),
              _TagChip(label: 'AI-assisted'),
              _TagChip(label: 'Built with Flutter Web'),
            ],
          ),
        ],
      ),
    );

    final body = Column(
      children: [
        header,
        const SizedBox(height: 8),
        Expanded(child: pages[_index]),
      ],
    );

    return ResponsiveShell(
      currentIndex: _index,
      onIndexChanged: (value) {
        setState(() => _index = value);
      },
      body: body,
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Chip(
      label: Text(label),
      backgroundColor: scheme.secondaryContainer.withOpacity(0.8),
    );
  }
}
