class UserModel {

  UserModel({
    required this.name,
    required this.email,
    required this.uid,
  });

  final String name;
  final String email;
  final String uid;

  Map<String,dynamic> toJson(){
    return{
      'uid':uid,
      'name':name,
      'email':email,
    };
  }
}
