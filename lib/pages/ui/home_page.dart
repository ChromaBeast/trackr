import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../splash_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List activities = [
      'Swimming',
      'Running',
      'Cycling',
      'Coding',
      'Sleeping',
      'Meditation',
    ];
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Scrollbar(
        interactive: true,
        radius: const Radius.circular(10),
        child: GridView.builder(
          itemCount: activities.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  activities[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
        ),
      ),
    );
  }
}
