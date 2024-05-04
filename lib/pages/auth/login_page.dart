import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_tracking/pages/ui/navigation_page.dart';

import '../../blocs/authentication_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
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

            return Column(
              children: [
                Placeholder(
                  fallbackHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: const Border(
                      top: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.grey[900],
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Sign in to Goal Tracker using',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildGoogleSignInButton(),
                        ],
                      ),
                      //role based login
                      // role selection
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildGoogleSignInButton() {
    return InkWell(
      onTap: () {
        BlocProvider.of<AuthenticationBloc>(context)
            .add(GoogleSignInRequested());
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          'assets/images/google.png',
          height: 30,
        ),
      ),
    );
  }
}
