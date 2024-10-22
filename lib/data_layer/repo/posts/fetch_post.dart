import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_project/data_layer/repo/utils/direct_firebase.dart';

class FetchPost {
  static Future<QuerySnapshot<Map<String, dynamic>>> mapPostData() async {
    QuerySnapshot<Map<String, dynamic>> allPostCollection =
        await DirectFirebase.firestoreDatabase.collection('posts').get();

    return allPostCollection;
  }
}
