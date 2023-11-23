import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/data/model/user_model.dart';
import 'package:ebayan/data/viewmodel/user_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class UserController {
  final Logger log = Logger();
  final FirebaseFirestore _dbFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _dbAuth = FirebaseAuth.instance;

  Future<String?> getCurrentUserName() async {
    return _dbAuth.currentUser?.displayName;
  }

  Future<void> updateInfo(UserUpdateModel data) async {
    try {
      await _dbFirestore.collection('users').doc(_dbAuth.currentUser?.uid).update(data.toJson());
      await _dbAuth.currentUser?.updateDisplayName(data.firstName);
      await _dbAuth.currentUser?.updateEmail(data.email);
    } on FirebaseAuthException catch (err) {
      final errorMessages = {
        'invalid-email': Validation.invalidEmail,
        'email-already-in-use': Validation.emailAlreadyInUse,
        'network-request-failed': Validation.networkFail,
      };

      log.e('${err.code}: $err');
      throw errorMessages[err.code.toLowerCase()].toString();
    }
  }

  Future<void> changePassword(String newPassword) async {
    await _dbAuth.currentUser?.updatePassword(newPassword);
  }

  Future<UserViewModel> getCurrentUserInfo() async {
    final userDoc = await _dbFirestore.collection('users').doc(_dbAuth.currentUser?.uid).get();

    if (userDoc.exists) {
      final userData = userDoc.data() as Map<String, dynamic>;
      return UserViewModel.map(userDoc.id, userData);
    } else {
      log.i('Document is not found!');
      throw 'Document is not found!';
    }
  }

  Future<String> getUserType(String uid) async {
    final userDoc = await _dbFirestore.collection('users').doc(uid).get();

    if (userDoc.exists) {
      return userDoc.data()?['userType'];
    } else {
      throw 'Document is not found!';
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    log.i('User has been logged out.');
  }
}
