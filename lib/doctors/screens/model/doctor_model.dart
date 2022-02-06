class DoctorModel {
  String uid;
  String email;
  String firstName;
  String secondName;

  DoctorModel({this.uid, this.email, this.firstName, this.secondName});

  // receiving data from server
  factory DoctorModel.fromMap(map) {
    return DoctorModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
    };
  }
}
