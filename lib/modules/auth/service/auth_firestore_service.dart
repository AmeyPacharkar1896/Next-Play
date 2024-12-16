import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:next_play/core/util/firestore_collections.dart';
import 'package:next_play/modules/auth/model/user_model.dart';

class AuthFirestoreService {
  final _client = FirebaseFirestore.instance;

  Future<Either<String, void>> createUser({
    required UserModel userModel,
  }) async {
    try {
      final ref =
          _client.collection(FireStoreCollections.users).doc(userModel.id);
      await ref.set(
          userModel.toMap()); // userModel.toMap() now converts enum to string
      return const Right(null);
    } on FirebaseException catch (e) {
      log(e.toString());
      return Left(e.message ?? "Something went wrong while adding user.");
    }
  }
}
