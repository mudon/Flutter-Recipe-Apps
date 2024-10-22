import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_project/data_layer/services/auth_service.dart';

class DirectFirebase {
  static FirebaseFirestore firestoreDatabase = FirebaseFirestore.instance;
}
