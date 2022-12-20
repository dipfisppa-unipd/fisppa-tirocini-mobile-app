
// To parse this JSON data, do
//
//     final instituteTutor = instituteTutorFromMap(jsonString);

import 'dart:convert';

/// export const instituteTutorSchema = object({
///   firstName: string().nullable(),
///   lastName: string().nullable(),
///   phoneNumber: string().nullable(),
///   email: string().email().nullable(),
///   notes: string().nullable(),
///   order: literal("primaria").or(literal("infanzia")).nullable(),
///   schoolCode: string().optional()
/// }).deepPartial().strict(),
/// 
class InstituteTutor {
    InstituteTutor({
        this.firstName,
        this.lastName,
        this.phoneNumber,
        this.email,
        this.notes,
        this.isPrimary = true,
        this.schoolCode
    });

    final String? firstName;
    final String? lastName;
    final String? phoneNumber;
    final String? email;
    final String? notes;
    final bool isPrimary;
    final String? schoolCode;

    InstituteTutor copyWith({
        String? firstName,
        String? lastName,
        String? phoneNumber,
        String? email,
        String? notes,
    }) => 
        InstituteTutor(
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            phoneNumber: phoneNumber ?? this.phoneNumber,
            email: email ?? this.email,
            notes: notes ?? this.notes,
        );

    factory InstituteTutor.fromJson(String str) => InstituteTutor.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory InstituteTutor.fromMap(Map<String, dynamic> json) => InstituteTutor(
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        email: json["email"] == null ? null : json["email"],
        notes: json["notes"] == null ? null : json["notes"],
        schoolCode: json["schoolCode"],
        isPrimary: json["order"] == null ? true : json["order"]=='primaria',
    );

    Map<String, dynamic> toMap() => {
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "email": email == null ? null : email,
        "notes": notes == null ? null : notes,
        "schoolCode": schoolCode,
        "order": isPrimary ? 'primaria' : 'infanzia',
    };
}