import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  UserModel({
    this.name,
    this.email,
    this.uid,
  });

  String? name;
  String? email;
  String? uid;

  Map<String,dynamic> toJson(){
    return{
      'uid':uid,
      'name':name,
      'email':email,
    };
  }

  factory UserModel.fromFirestore(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String,dynamic>;
    return UserModel(
      name: data['name'].toString(),
      email: data['email'].toString(),
      uid: data['uid'].toString(),
    );
  }
}
