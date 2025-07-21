class UserModel {
  final String uid; // Firebase UID
  final String username;
  final String phoneNumber;
  final String email;
  final String image;

  UserModel({
    required this.uid,
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.image,
  });


  // Convert Firestore document to UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      image: map['image'] ?? '',
    );
  }

  // Convert UserModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'phoneNumber': phoneNumber,
      'email': email,
      'image': image,
    };
  }
}
