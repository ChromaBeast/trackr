import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticationEvent {}

class AuthenticationStarted extends AuthenticationEvent {}

class GoogleSignInRequested extends AuthenticationEvent {}

class PhoneSignInRequested extends AuthenticationEvent {}

class SignOutRequested extends AuthenticationEvent {}

class AuthenticationUserChanged extends AuthenticationEvent {
  final User user;
  AuthenticationUserChanged(this.user);
}

enum AuthenticationState { signedout, signingin, signedin, signingout }

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthenticationBloc(this._firebaseAuth, this._googleSignIn)
      : super(AuthenticationState.signedout) {
    on<AuthenticationStarted>((event, emit) async {
      emit(AuthenticationState.signingin); // Show a loading state

      // Get the current user from Firebase
      final user = _firebaseAuth.currentUser;

      if (user != null) {
        emit(AuthenticationState.signedin);
      } else {
        emit(AuthenticationState.signedout);
      }
    });

    on<GoogleSignInRequested>((event, emit) async {
      emit(AuthenticationState.signingin);
      try {
        await _googleSignIn.signOut();
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _firebaseAuth.signInWithCredential(credential);
      } catch (e) {
        emit(AuthenticationState.signedout);
      }
      emit(AuthenticationState.signedin);
    });

    on<PhoneSignInRequested>((event, emit) async {
      emit(AuthenticationState.signingin);
      // Implement phone sign in here
      emit(AuthenticationState.signedin);
    });

    on<AuthenticationUserChanged>((event, emit) {
      emit(AuthenticationState.signedin);
    });

    on<SignOutRequested>((event, emit) async {
      emit(AuthenticationState.signingin);
      if (_firebaseAuth.currentUser != null) {
        if (_firebaseAuth.currentUser!.isAnonymous) {
          await _firebaseAuth.currentUser!.delete();
        } else {
          await _googleSignIn.signOut();
          await _firebaseAuth.signOut();
        }
      }
      emit(AuthenticationState.signedout);
    });
  }
}
