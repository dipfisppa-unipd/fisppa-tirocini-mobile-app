// To parse this JSON data, do
//
//     final territoriality = territorialityFromMap(jsonString);

import 'dart:convert';

class Territoriality {
    Territoriality({
        this.id,
        this.label,
        this.createdAt,
        this.updatedAt,
    });

    String? id;
    String? label;
    DateTime? createdAt;
    DateTime? updatedAt;

    Territoriality copyWith({
        String? id,
        String? label,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Territoriality(
            id: id ?? this.id,
            label: label ?? this.label,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Territoriality.fromJson(String str) => Territoriality.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Territoriality.fromMap(Map<String, dynamic> json) => Territoriality(
        id: json["_id"] == null ? null : json["_id"],
        label: json["label"] == null ? null : json["label"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "label": label == null ? null : label,
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt?.toIso8601String(),
    };
}
