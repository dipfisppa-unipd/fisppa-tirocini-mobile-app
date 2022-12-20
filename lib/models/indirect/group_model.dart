// To parse this JSON data, do
//
//     final groupModel = groupModelFromMap(jsonString);

import 'dart:convert';

import 'package:unipd_mobile/models/user.dart';

class GroupModel {
    GroupModel({
        this.id,
        this.name,
        this.foundationYear,
        this.internshipYear,
        this.coordinatorTutor,
        this.organizerTutor,
        this.territorialityId,
        this.createdAt,
        this.updatedAt,
    });

    final String? id;
    final String? name;
    final int? foundationYear;
    final int? internshipYear;
    final UserModel? coordinatorTutor, organizerTutor;
    final String? territorialityId;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    GroupModel copyWith({
        String? id,
        String? name,
        int? foundationYear,
        int? internshipYear,
        UserModel? coordinatorTutor,
        UserModel? organizerTutor,
        String? territorialityId,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        GroupModel(
            id: id ?? this.id,
            name: name ?? this.name,
            foundationYear: foundationYear ?? this.foundationYear,
            internshipYear: internshipYear ?? this.internshipYear,
            coordinatorTutor: coordinatorTutor ?? this.coordinatorTutor,
            territorialityId: territorialityId ?? this.territorialityId,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory GroupModel.fromJson(String str) => GroupModel.fromMap(json.decode(str));

    factory GroupModel.fromMap(Map<String, dynamic> json) => GroupModel(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        foundationYear: json["foundationYear"] == null ? null : json["foundationYear"],
        internshipYear: json["internshipYear"] == null ? null : json["internshipYear"],
        coordinatorTutor: json["coordinatorTutor"] == null ? null : UserModel.fromMap(json["coordinatorTutor"]),
        organizerTutor: json["organizerTutor"] == null ? null : UserModel.fromMap(json["organizerTutor"]),
        territorialityId: json["territoriality_id"] == null ? null : json["territoriality_id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

}
