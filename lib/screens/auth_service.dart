import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ✅ Get Current User
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // ✅ Google Sign-In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      await _saveUserDetails(userCredential.user);
      return userCredential;
    } catch (e) {
      return Future.error("Google Sign-In failed. Please try again.");
    }
  }

  // ✅ Email & Password Sign-In
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      await _saveUserDetails(userCredential.user);
      return userCredential;
    } catch (e) {
      return Future.error("Invalid email or password.");
    }
  }

  // ✅ Register User
  Future<UserCredential?> registerWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _saveUserDetails(userCredential.user);
      return userCredential;
    } catch (e) {
      return Future.error("Registration failed. Please try again.");
    }
  }

  // ✅ Save user details
  Future<void> _saveUserDetails(User? user) async {
    if (user != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', user.displayName ?? "User");
      await prefs.setString('email', user.email ?? "");
      await prefs.setString('profilePhoto', user.photoURL ?? "");
    }
  }

  // ✅ Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
