import 'dart:convert';

List<Guest> guestFromJson(String str) =>
    List<Guest>.from(json.decode(str).map((x) => Guest.fromJson(x)));

String guestToJson(List<Guest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Guest {
  Guest({
    this.GuestId,
    required this.Name,
    required this.Phone,
    required this.Email,
  });

  int? GuestId;
  String Name;
  String Phone;
  String Email;

// Transformando a resposta em um objeto
  factory Guest.fromJson(Map<String, dynamic> json) => Guest(
        GuestId: json["GuestId"],
        Name: json["Name"],
        Phone: json["Phone"],
        Email: json["Email"],
      );

  Map<String, dynamic> toJson() => {
        "GuestId": GuestId,
        "Name": Name,
        "Phone": Phone,
        "Email": Email,
      };

  Guest copy({
    int? GuestId,
    String? Name,
    String? Phone,
    String? Email,
  }) =>
      Guest(
        GuestId: GuestId ?? this.GuestId,
        Name: Name ?? this.Name,
        Phone: Phone ?? this.Phone,
        Email: Email ?? this.Email,
      );
}
