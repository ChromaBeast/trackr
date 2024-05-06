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
      backgroundColor: Color(0xFF5EA25F),
      body: Center(
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state == AuthenticationState.signedin) {
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
            if (state == AuthenticationState.signingin) {
              return const CircularProgressIndicator();
            }

            return Stack(
              children: [
                Positioned(
                  top: 20,
                  right: 0,
                  left: 0,
                  child: Image.asset(
                    'assets/images/bg.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        color: Colors.white),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Tasker',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Know where your time goes, before it goes\n bye-bye.',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildPhoneButton(),
                            _buildGoogleSignInButton(),
                          ],
                        ),
                      ],
                    ),
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
        width: MediaQuery.of(context).size.width * 0.5,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          color: Color(0xFFEBEFEB),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/google.png',
              height: 30,
              width: 30,
            ),
            Text(
              'Google',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneButton() {
    return InkWell(
      onTap: () {
        // BlocProvider.of<AuthenticationBloc>(context)
        //     .add(PhoneSignInRequested());
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 94, 162, 95),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/login_background.png',
              height: 30,
              width: 30,
            ),
            const Text(
              'Phone',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 30),
          ],
        ),
      ),
    );
  }
}
