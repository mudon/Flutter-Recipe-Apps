import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_project/data_layer/repo/utils/direct_firebase.dart';
import 'package:recipe_project/data_layer/services/auth_service.dart';

class FetchUser {
  static Future<DocumentSnapshot<Map<String, dynamic>>> mapUserData() async {
    DocumentSnapshot<Map<String, dynamic>> userDoc = await DirectFirebase
        .firestoreDatabase
        .collection('user')
        .doc(AuthService.user?.uid)
        .get();

    return userDoc;
  }
}
