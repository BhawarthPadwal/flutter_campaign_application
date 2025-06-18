import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../apis/api_manager.dart';
import '../../../apis/app_req.dart';
import '../../../auth_services/auth_service.dart';
import 'package:logger/logger.dart';

part 'auth_event.dart';

part 'auth_state.dart';

Logger logger = Logger();

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInEvent>(signInEvent);
    on<SignUpEvent>(signUpEvent);
    on<GoogleSignInEvent>(googleSignInEvent);
  }

  /// LOGIN
  FutureOr<void> signInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    Future.delayed(const Duration(seconds: 2));
    try {
      bool isSignedIn = await AuthService().signin(
        email: event.email,
        password: event.password,
      );
      if (isSignedIn) {
        emit(AuthSuccess(message: "Logged in successfully!"));
        emit(NavigateToHome());
      } else {
        emit(AuthError(message: "Login failed. Please try again."));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  FutureOr<void> signUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    Future.delayed(const Duration(seconds: 2));
    try {
      final userCredential = await AuthService().signup(
        email: event.email.trim(),
        password: event.password.trim(),
      );
      if (userCredential != null) {
        String? uid = userCredential.user?.uid;
        String? email = userCredential.user?.email;

        if (uid != null) {
          bool exists = await ApiManager.isUserExistsInDB(uid);
          if (!exists) {
            // Create user if not found
            await ApiManager.post(AppReqEndPoint.createUser(), {
              "userId": uid,
              "emailId": email,
            });
            logger.i("User created in DB.");
          } else {
            logger.i("User already exists in DB.");
          }
          emit(AuthSuccess(message: "Signup successful! Please log in."));
          emit(NavigateToLogin());
        } else {
          emit(AuthError(message: "User ID not found."));
        }
      } else {
        emit(AuthError(message: "Signup failed. Please try again."));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  FutureOr<void> googleSignInEvent(
    GoogleSignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final userCredential = await AuthService().signInWithGoogle();
      if (userCredential != null) {
        String? uid = userCredential.user?.uid;
        String? email = userCredential.user?.email;

        if (uid != null && email != null) {
          bool exists = await ApiManager.isUserExistsInDB(uid);

          if (!exists) {
            await ApiManager.post(AppReqEndPoint.createUser(), {
              "userId": uid,
              "emailId": email,
            });
            logger.i("Google user created in DB.");
          } else {
            logger.i("Google user already exists in DB.");
          }
          emit(AuthSuccess(message: "Signed in successfully!"));
          emit(NavigateToHome());
        } else {
          logger.e("Google Sign-In failed: UID or email is null");
          emit(AuthError(message: "Google Sign-In failed."));
        }
      } else {
        logger.e("Google Sign-In cancelled or failed");
        emit(AuthError(message: "Google Sign-In cancelled or failed."));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
