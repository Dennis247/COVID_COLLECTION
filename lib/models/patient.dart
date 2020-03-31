import 'package:flutter/cupertino.dart';

enum Gender { MALE, FEMALE }

class Patient {
  final String city;
  final String firstname;
  final String gender;
  final String lastname;
  final String lat;
  final String lng;
  final String state;
  final String street;

  Patient(
      {@required this.city,
      @required this.firstname,
      @required this.gender,
      @required this.lastname,
      @required this.lat,
      @required this.lng,
      @required this.state,
      @required this.street});

  static List<Patient> patientsListFromJson(List collection) {
    List<Patient> patientList =
        collection.map((json) => Patient.fromJson(json)).toList();
    return patientList;
  }

  Patient.fromJson(Map<String, dynamic> json)
      : this.city = json['city'],
        this.firstname = json['firstname'],
        this.gender = json['gender'],
        this.lastname = json['lastname'],
        this.lat = json['lat'],
        this.lng = json['lng'],
        this.state = json['state'],
        this.street = json['street'];

  Map<String, dynamic> toMap() {
    return {
      'city': this.city,
      'firstname': this.firstname,
      'gender': this.gender,
      'lastname': this.lastname,
      'lat': this.lat,
      'lng': this.lng,
      'state': this.state,
      'street': this.street,
    };
  }
}
