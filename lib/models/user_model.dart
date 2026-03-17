import 'package:cloud_firestore/cloud_firestore.dart'; // Corrected import

class UserModel {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final List followers;
  final List following;

  UserModel({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.followers,
    required this.following,
  });

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      uid: snapshot["uid"] ?? '',
      email: snapshot["email"] ?? '',
      firstName: snapshot["firstName"] ?? '',
      lastName: snapshot["lastName"] ?? '',
      gender: snapshot["gender"] ?? '',
      followers: snapshot["followers"] ?? [],
      following: snapshot["following"] ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
    "gender": gender,
    "followers": followers,
    "following": following,
  };
}