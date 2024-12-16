import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:next_play/modules/auth/model/user_model.dart';

class AuthFirebaseService {
  final _client = FirebaseAuth.instance;

  Stream<bool> get isAuthenticated {
    return _client.authStateChanges().map((user) => user != null);
  }

  UserModel? get currentUser {
    if (_client.currentUser == null) return null;
    return UserModel.fromFirebaseUser(_client.currentUser!);
  }

  Future<Either<String, UserCredential>> loginAnomonously() async {
    try {
      final response = await _client.signInAnonymously();
      return Right(response);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? "Something went wrong");
    }
  }

  Future<Either<String, UserCredential>> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(response);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? "Something went wrong");
    }
  }

  Future<Either<String, UserCredential>> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(response);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? "Something went wrong");
    }
  }

  Future<Either<String, void>> logOut() async {
    try {
      return Right(
        await _client.signOut(),
      );
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? "Something went wrong");
    }
  }

  Future<Either<String, UserCredential>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return const Left("Google sign-in was canceled.");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? "Something went wrong during sign-in.");
    } catch (e) {
      return Left("An unexpected error occurred: ${e.toString()}");
    }
  }
}

Future<Either<String, void>> signOutWithGoogle() async {
  try {
    GoogleSignIn googleSignIn = GoogleSignIn();
    return Right(await googleSignIn.signOut());
  } on FirebaseAuthException catch (e) {
    return Left(e.message ?? "Something went wrong");
  }
}
