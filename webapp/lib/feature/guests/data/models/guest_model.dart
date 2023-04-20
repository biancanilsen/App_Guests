import 'dart:convert';

List<Guest> guestFromJson(String str) =>
    List<Guest>.from(json.decode(str).map((x) => Guest.fromJson(x)));

String guestToJson(List<Guest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Guest {
  Guest({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
  });

  String? id;
  String name;
  String phone;
  String email;

// Transformando a resposta em um objeto
  factory Guest.fromJson(Map<String, dynamic> json) => Guest(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
      };

  Guest copy({
    String? id,
    String? name,
    String? phone,
    String? email,
  }) =>
      Guest(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
      );
}
