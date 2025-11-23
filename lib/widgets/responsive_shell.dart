import 'package:flutter/material.dart';

/// Basic responsive shell which shows a side navigation rail on large screens
/// and a bottom navigation bar on smaller screens.
class ResponsiveShell extends StatelessWidget {
  const ResponsiveShell({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
    required this.body,
  });

  final int currentIndex;
  final ValueChanged<int> onIndexChanged;
  final Widget body;

  @override
Widget build(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final isWide = constraints.maxWidth >= 900;

      if (isWide) {
        // 👇 FIXED: Wrap Row in a Scaffold so there is a Material ancestor
        return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: currentIndex,
                onDestinationSelected: onIndexChanged,
                labelType: NavigationRailLabelType.all,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.psychology_alt_outlined),
                    selectedIcon: Icon(Icons.psychology_alt),
                    label: Text('Assessment'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.chat_outlined),
                    selectedIcon: Icon(Icons.chat),
                    label: Text('Chatbot'),
                  ),
                ],
              ),
              const VerticalDivider(width: 1),
              Expanded(child: body),
            ],
          ),
        );
      }

      // small-screen version is already fine
      return Scaffold(
        body: body,
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: onIndexChanged,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.psychology_alt_outlined),
              selectedIcon: Icon(Icons.psychology_alt),
              label: 'Assessment',
            ),
            NavigationDestination(
              icon: Icon(Icons.chat_outlined),
              selectedIcon: Icon(Icons.chat),
              label: 'Chatbot',
            ),
          ],
        ),
      );
    },
  );
}
}