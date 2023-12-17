import 'package:cloud_firestore/cloud_firestore.dart';
import 'custom_exception.dart';
import 'user_model.dart';

class ProfileRepository {
  final FirebaseFirestore firebaseFirestore;

  const ProfileRepository({
    required this.firebaseFirestore,
  });

  Future<UserModel> getProfile({
    required String nickName,
  }) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firebaseFirestore.collection('user').doc(nickName).get();
      return UserModel.fromMap(snapshot.data()!);
    } on FirebaseException catch (e) {
      throw CustomException(
        code: e.code,
        message: e.message!,
      );
    } catch (e) {
      throw CustomException(
        code: 'Exception',
        message: e.toString(),
      );
    }
  }
}