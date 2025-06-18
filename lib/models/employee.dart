class Employee {
  final String id;
  final String name;
  final String? email;
  final String? position;
  final String? phone;

  Employee({
    required this.id,
    required this.name,
    this.email,
    this.position,
    this.phone,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      position: json['position'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'position': position,
      'phone': phone,
    };
  }

  Employee copyWith({
    String? id,
    String? name,
    String? email,
    String? position,
    String? phone,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      position: position ?? this.position,
      phone: phone ?? this.phone,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Employee && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Employee(id: $id, name: $name, email: $email, position: $position, phone: $phone)';
  }
}
