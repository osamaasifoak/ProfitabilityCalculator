// To parse this JSON data, do
//
//     final userWrapper = userWrapperFromJson(jsonString);

import 'dart:convert';

class UserWrapper {
    UserWrapper({
        this.name,
        this.email,
        this.phone,
    });

    String name;
    String email;
    String phone;

    factory UserWrapper.fromRawJson(String str) => UserWrapper.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserWrapper.fromJson(Map<String, dynamic> json) => UserWrapper(
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
    };
}
