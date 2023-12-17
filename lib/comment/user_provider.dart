import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'custom_exception.dart';
import 'user_model.dart';
import 'user_state.dart';
import 'profile_repository.dart';

class UserProvider extends StateNotifier<UserState> with LocatorMixin {
  UserProvider() : super(UserState.init());

  Future<void> getUserInfo() async {
    try {
      String uid = read<User>().uid;
      UserModel userModel = await read<ProfileRepository>().getProfile(nickName: uid);
      state = state.copyWith(userModel: userModel);
    } on CustomException catch (_) {
      rethrow;
    }
  }
}