import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_tracking/pages/ui/navigation_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../blocs/authentication_bloc.dart';
import 'auth/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return NavigationPage(selectedIndex: 0) if user is authenticated
    // return LoginPage() if user is not authenticated
    FirebaseAuth auth = FirebaseAuth.instance;
    GoogleSignIn googleSignIn = GoogleSignIn();
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state == AuthenticationState.authenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => NavigationPage(
                selectedIndex: 0,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state == AuthenticationState.authenticating) {
          return const CircularProgressIndicator();
        }

        return const LoginPage();
      },
    );
  }
}
