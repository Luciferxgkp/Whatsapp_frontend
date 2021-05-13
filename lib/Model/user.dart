import 'dart:convert';
import 'package:flutter/foundation.dart';
class User{
  String firstName;
  String lastName;
  String email;
  String password;
  String fullName;
  String contactNumber;
  String id;
  String profilePicture;
  String token;
  User({
    this.firstName,
    this.fullName,
    this.id,
    this.lastName,
    this.email,
    this.password,
    this.contactNumber,
    this.profilePicture,
    this.token
  });

}