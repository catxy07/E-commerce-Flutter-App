import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential?> signUpWithEmail(
    {required String email, required String password}) async {
  try {
    UserCredential userCredential =
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential;
  } catch (e) {
    print('error is $e');
    return null;
  }
}

Future<UserCredential?> loginWithEmail(
    {required String email, required String password}) async {
  try {
    UserCredential userCredential =
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential;
  } catch (e) {
    print('error iN LOGIN $e');
    return null;
  }
}

Future<void> logOut() async {
  await FirebaseAuth.instance.signOut();
}
