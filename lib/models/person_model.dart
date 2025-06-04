import 'package:hive/hive.dart';
part 'person_model.g.dart';

@HiveType(typeId: 34)
class Person {
  @HiveField(0)
  String id;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String lastName;

  @HiveField(3)
  String email;

  @HiveField(4)
  String mobile;

  int? key;

  Person({
    required this.id,
    required this.mobile,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.key,
  }) ;

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'].toString(),
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      mobile: json['mobile'],
    );
  }
}
