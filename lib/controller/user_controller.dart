import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:timesheet_flutter_app/model/local_data_source.dart';

class UserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'https://www.googleapis.com/auth/drive.appdata',
    "https://www.googleapis.com/auth/documents.currentonly",
    "https://www.googleapis.com/auth/script.scriptapp",
    "https://www.googleapis.com/auth/drive.readonly",
    "https://www.googleapis.com/auth/script.external_request",
    "https://www.googleapis.com/auth/spreadsheets",
    "https://www.googleapis.com/auth/sqlservice"
  ]);

  void signInWithGoogle({
    required Function(String error) error,
    required Function action,
  }) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      final String accessToken =
          await googleSignInAccount!.authentication.then((value) async {
        var token = value.accessToken!;

        return token;
      });

      LocalDataSource lds = LocalDataSource();
      lds.saveToken(accessToken);

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      action();
    } on FirebaseAuthException catch (e) {
      error(e.message!);
    }
  }

  void signOutFromGoogle({
    required Function(String error) error,
    required Function action,
  }) async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      action();
    } on FirebaseAuthException catch (e) {
      error(e.message!);
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
    required Function(String error) error,
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
      error("Error");
    }
  }

  void signInWithEmailAndPassword({
    required String email,
    required String password,
    required Function(String error) error,
    required Function(User user) action,
  }) async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user!;
      action(user);
    } on FirebaseAuthException catch (e) {
      error(e.message!);
    }
  }

  User? getUserData() {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  void refreshGoogleToken() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      final String accessToken =
          await googleSignInAccount!.authentication.then((value) async {
        var token = value.accessToken!;

        return token;
      });

      LocalDataSource lds = new LocalDataSource();
      lds.saveToken(accessToken);

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message!);
    }
  }
}
