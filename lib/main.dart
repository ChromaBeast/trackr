import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_tracking/blocs/authentication_bloc.dart';
import 'package:goal_tracking/pages/splash_screen.dart';
import 'package:goal_tracking/themes/dark_theme.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'blocs/navigation_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    GoogleSignIn googleSignIn = GoogleSignIn();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider(
          create: (context) => AuthenticationBloc(auth, googleSignIn),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Goal Tracking App",
        themeMode: ThemeMode.dark,
        darkTheme: darkTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
