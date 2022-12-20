// To parse this JSON data, do
//
//     final indirectChoicesModel = indirectChoicesModelFromMap(jsonString);

import 'dart:convert';

import 'package:unipd_mobile/models/indirect/group_model.dart';
import 'package:unipd_mobile/models/indirect/territoriality_model.dart';

class IndirectChoicesModel {
    IndirectChoicesModel({
        this.id,
        this.internshipYear,
        this.userId,
        this.calendarYear,
        this.choices = const [],
        this.createdAt,
        this.updatedAt,
        this.enhancedChoices = const [],
        this.enhancedAssignedChoice,
        this.notes,
        this.isAssignedChoiceConfirmed=false,
    });

    final String? id, notes;
    final int? internshipYear;
    final String? userId;
    final int? calendarYear;
    final List<String> choices;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final List<Territoriality> enhancedChoices;
    final GroupModel? enhancedAssignedChoice;
    final bool isAssignedChoiceConfirmed;

    IndirectChoicesModel copyWith({
        String? id,
        int? internshipYear,
        String? userId,
        int? calendarYear,
        List<String>? choices,
        DateTime? createdAt,
        DateTime? updatedAt,
        List<Territoriality>? enhancedChoices,
        bool? isAssignedChoiceConfirmed
    }) => 
        IndirectChoicesModel(
            id: id ?? this.id,
            internshipYear: internshipYear ?? this.internshipYear,
            userId: userId ?? this.userId,
            calendarYear: calendarYear ?? this.calendarYear,
            choices: choices ?? this.choices,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            enhancedChoices: enhancedChoices ?? this.enhancedChoices,
            isAssignedChoiceConfirmed: isAssignedChoiceConfirmed ?? this.isAssignedChoiceConfirmed
        );

    factory IndirectChoicesModel.fromJson(String str) => IndirectChoicesModel.fromMap(json.decode(str));

    

    factory IndirectChoicesModel.fromMap(Map<String, dynamic> json) => IndirectChoicesModel(
        id: json["_id"] == null ? null : json["_id"],
        internshipYear: json["internshipYear"] == null ? null : json["internshipYear"],
        userId: json["user_id"] == null ? null : json["user_id"],
        calendarYear: json["calendarYear"] == null ? null : json["calendarYear"],
        choices: json["choices"] == null ? const [] : List<String>.from(json["choices"].map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        enhancedChoices: json["enhancedChoices"] == null ? const [] : List<Territoriality>.from(json["enhancedChoices"].map((x) => Territoriality.fromMap(x))),
        enhancedAssignedChoice: json["enhancedAssignedChoice"]==null ? null : GroupModel.fromMap(json["enhancedAssignedChoice"]),
        notes: json["notes"] == null ? '' : json["notes"],
        isAssignedChoiceConfirmed: json["isAssignedChoiceConfirmed"] == null ? false : json["isAssignedChoiceConfirmed"],
    );

    
}

