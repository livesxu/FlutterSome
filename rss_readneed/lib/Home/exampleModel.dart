import 'package:json_annotation/json_annotation.dart';

part 'exampleModel.g.dart';

@JsonSerializable(nullable: false)
class Person {
   String firstName;
   String lastName;
   DateTime dateOfBirth;
   String nick;
   String hello;
  Person({this.firstName, this.lastName, this.dateOfBirth, this.nick});
  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}