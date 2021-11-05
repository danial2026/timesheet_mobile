import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  void signOutFromGoogle({
    required Function error,
    required Function action,
  }) async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      action();
    } catch (e) {
      error();
    }
  }

  bool checkUserStatus() {
    User? user = _auth.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  void register({
    required String email,
    required String password,
    required Function error,
    required Function(User user) action,
  }) async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    if (user != null) {
      action(user);
    } else {
      error();
    }
  }

  void signInWithEmailAndPassword({
    required String email,
    required String password,
    required Function error,
    required Function(User user) action,
  }) async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user!;
      action(user);
    } catch (e) {
      error();
    }
  }

  User? getUserData() {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      return user;
    } catch (e) {
      print(e);
    }
  }
}
