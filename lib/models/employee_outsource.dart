import 'package:employee_management/models/employee.dart';

class EmployeeOutsource extends Employee {
  String company;
  String username;
  String address;
  String zip;
  String state;
  String country;
  String? photo;

  EmployeeOutsource({
    required super.id,
    required super.name,
    required super.email,
    super.position,
    required super.phone,
    required this.address,
    String? addressEmployee,
    required this.company,
    required this.username,
    required this.zip,
    required this.state,
    required this.country,
    this.photo,
  });

  factory EmployeeOutsource.fromJson(Map<String, dynamic> json) {
    return EmployeeOutsource(
      id: '${json['id'] ?? ''}',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      position: json['position'] ?? '',
      phone: json['phone'] ?? '',
      addressEmployee: json['addressEmployee'],
      company: json['company'] ?? '',
      username: json['username'] ?? '',
      address: json['address'] ?? '',
      zip: json['zip'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      photo: json['photo'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'company': company,
      'username': username,
      'address': address,
      'zip': zip,
      'state': state,
      'country': country,
      'photo': photo,
    });
    return data;
  }

  @override
  EmployeeOutsource copyWith({
    String? id,
    String? name,
    String? email,
    String? position,
    String? phone,
    String? addressEmployee,
    String? company,
    String? username,
    String? address,
    String? zip,
    String? state,
    String? country,
    String? photo,
  }) {
    return EmployeeOutsource(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      position: position ?? this.position,
      phone: phone ?? this.phone ?? '',
      addressEmployee: addressEmployee ?? this.address,
      company: company ?? this.company,
      username: username ?? this.username,
      address: address ?? this.address,
      zip: zip ?? this.zip,
      state: state ?? this.state,
      country: country ?? this.country,
      photo: photo ?? this.photo,
    );
  }
}
