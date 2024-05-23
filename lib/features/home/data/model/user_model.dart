import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final int age;
  final String url;
  final String? docId;
  final List? search;
  final Timestamp? createdAt;

  UserModel(
      {required this.name,
      required this.age,
      required this.search,
      required this.url,
      this.docId,
      this.createdAt});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'] as String,
        age: map['age'] as int,
        url: map['url'] as String,
        createdAt: map['createdAt'] as Timestamp?,
        docId: map['docID'] != null ? map['docID'] as String : null,
        search: map['search'] as List);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
      'url': url,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'docID': docId,
      'search': search
    };
  }

  UserModel copyWith({
    String? name,
    int? age,
    String? image,
    String? docID,
  }) {
    return UserModel(
      name: name ?? this.name,
      age: age ?? this.age,
      url: image ?? this.url,
      docId: docID ?? this.docId,
      search: search,
    );
  }
}
