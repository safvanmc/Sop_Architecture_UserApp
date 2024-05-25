import 'dart:developer';
import 'package:architecture/general/core/sort_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import '../data/model/user_model.dart';

class UserRepository {
  factory UserRepository() {
    return UserRepository._();
  }
  UserRepository._();
  // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final firestore = FirebaseFirestore.instance;
  QueryDocumentSnapshot? lastDocs;

  //get users from firebase
  Future<Either<String, List<UserModel>>> getUsers(AgeType ageType) async {
    try {
      QuerySnapshot<Map<String, dynamic>>? ref;
      if (AgeType.all == ageType) {
        ref = (lastDocs == null)
            ? await FirebaseFirestore.instance
                .collection("users")
                .orderBy('createdAt', descending: true)
                .limit(15) //get initial limited users from firestore
                .get()
            : await FirebaseFirestore.instance
                .collection("users")
                .orderBy('createdAt', descending: true)
                .startAfterDocument(lastDocs!)
                .limit(6) //get more users from firestore
                .get();
        Future.delayed(Duration(seconds: 2));
      } else if (AgeType.younger == ageType) {
        ref = (lastDocs == null)
            ? await firestore
                .collection('users')
                .where('age', isLessThan: 60)
                .orderBy('age', descending: false)
                .limit(15)
                .get()
            : await firestore
                .collection('users')
                .where('age', isLessThan: 60)
                .orderBy('age', descending: false)
                .startAfterDocument(lastDocs!)
                .limit(6)
                .get();
        Future.delayed(Duration(seconds: 2));
      } else {
        ref = (lastDocs == null)
            ? await firestore
                .collection('users')
                .where('age', isGreaterThanOrEqualTo: 60)
                .orderBy('age', descending: false)
                .limit(15)
                .get()
            : await firestore
                .collection('users')
                .where('age', isGreaterThanOrEqualTo: 60)
                .orderBy('age', descending: false)
                .startAfterDocument(lastDocs!)
                .limit(6)
                .get();
        Future.delayed(Duration(seconds: 2));
      }
      if (ref.docs.isEmpty) {
        return left("No More Data");
      } else {
        lastDocs = ref.docs.last;
        return right(ref.docs.map((e) => UserModel.fromMap(e.data())).toList());
      }
    } catch (e) {
      log(e.toString());
      return left(e.toString());
    }
  }
}
