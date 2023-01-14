import 'dart:convert';

Info? infoFromJson(String str) => Info.fromJson(json.decode(str));

String infoToJson(Info? data) => json.encode(data!.toJson());

class Info {
  Info({
    this.fname,
    this.lname,
    this.email,
    this.age,
  });

  String? fname;
  String? lname;
  String? email;
  int? age;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    fname: json["fname"],
    lname: json["lname"],
    email: json["email"],
    age: json["age"],
  );

  Map<String, dynamic> toJson() => {
    "fname": fname,
    "lname": lname,
    "email": email,
    "age": age,
  };
}