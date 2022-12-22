import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes/services/auth/auth_exceptions.dart';
import '../../firebase_options.dart';

class FirebaseAuthService {
  FirebaseAuthService();

  static initialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  static User? currentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static signIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password") {
        throw WrongPassAuthException();
      } else if (e.code == "user-not-found") {
        throw UserNotFoundAuthException();
      } else if (e.code == "invalid-email") {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

  static registerNewUser(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == "invalid-email") {
        throw InvalidEmailAuthException();
      } else if (e.code == "weak-password") {
        throw WeekpasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

  static logoutUser() async {
    if (currentUser() != null) {
      try {
        await FirebaseAuth.instance.signOut();
      } catch (e) {
        throw GenericAuthException();
      }
    } else {
      throw UserNotLoggedInAuthException();
    }
  }
}
