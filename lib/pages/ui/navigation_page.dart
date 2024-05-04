import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_tracking/pages/ui/home_page.dart';
import 'package:goal_tracking/pages/ui/settings_page.dart';

import '../../blocs/navigation_bloc.dart';

class NavigationPage extends StatelessWidget {
  final int selectedIndex;

  NavigationPage({super.key, required this.selectedIndex});

  final List _widgetOptions = [
    const HomePage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return _widgetOptions.elementAt(state.selectedIndex);
        },
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.titled, // Choose a curved style
        backgroundColor: Colors.black, // Background color
        color: Colors.grey.shade400, // Inactive color
        activeColor: Colors.white,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.settings, title: 'Settings'),
        ],
        initialActiveIndex: selectedIndex, // Set initial index
        onTap: (index) =>
            BlocProvider.of<NavigationBloc>(context).add(TabTapped(index)),
      ),
    );
  }
}
