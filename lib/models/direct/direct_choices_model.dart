// To parse this JSON data, do
//
//     final directChoicesModel = directChoicesModelFromMap(jsonString);

import 'dart:convert';

import 'package:unipd_mobile/models/direct/istituti_tirocinio_diretto.dart';

import 'institute_tutor_model.dart';

class DirectChoicesModel {
    DirectChoicesModel({
        this.id,
        this.internshipYear,
        this.userId,
        this.calendarYear,
        this.createdAt,
        this.updatedAt,
        this.notes,

        this.choices,
        this.assignedChoices,
        this.isAssignedChoiceConfirmed=false,
        this.enhancedChoices,
        this.enhancedAssignedChoices,
        this.instituteTutor = const [],
    });

    final String? id, notes;
    final int? internshipYear;
    final String? userId;
    final int? calendarYear;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    final List<List<String>>? choices;
    final List<String>? assignedChoices;
    final bool? isAssignedChoiceConfirmed;
    List<List<InstituteModel>>? enhancedChoices = [];
    List<InstituteModel>? enhancedAssignedChoices = [];
    List<InstituteTutor> instituteTutor;

    DirectChoicesModel copyWith({
        String? id,
        int? internshipYear,
        String? userId,
        int? calendarYear,
        DateTime? createdAt,
        DateTime? updatedAt,

        List<List<String>>? choices,
        List<String>? assignedChoices,
        bool? isAssignedChoiceConfirmed,
        List<List<InstituteModel>>? enhancedChoices,
        List<InstituteModel>? enhancedAssignedChoices,
        List<InstituteTutor>? instituteTutor
    }) => 
        DirectChoicesModel(
            id: id ?? this.id,
            internshipYear: internshipYear ?? this.internshipYear,
            userId: userId ?? this.userId,
            calendarYear: calendarYear ?? this.calendarYear,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,

            choices: choices ?? this.choices,
            enhancedChoices: enhancedChoices ?? this.enhancedChoices,
            assignedChoices: assignedChoices ?? this.assignedChoices,
            isAssignedChoiceConfirmed: isAssignedChoiceConfirmed ?? this.isAssignedChoiceConfirmed,
            enhancedAssignedChoices: enhancedAssignedChoices ?? this.enhancedAssignedChoices,

        );

    factory DirectChoicesModel.fromJson(String str) => DirectChoicesModel.fromMap(json.decode(str));


    factory DirectChoicesModel.fromMap(Map<String, dynamic> json) => DirectChoicesModel(
        id: json["_id"] == null ? null : json["_id"],
        internshipYear: json["internshipYear"] == null ? null : json["internshipYear"],
        userId: json["user_id"] == null ? null : json["user_id"],
        calendarYear: json["calendarYear"] == null ? null : json["calendarYear"],
        choices: json["choices"] == null ? null : _normalizeChoices(json["choices"]),
        assignedChoices: json["assignedChoice"] == null ? [] : List<String>.from(json["assignedChoice"].map((x)=>x)), 
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        enhancedChoices: json["enhancedChoices"] == null ? null : List<List<InstituteModel>>.from(json["enhancedChoices"].map((x) => List<InstituteModel>.from(x.map((x) => InstituteModel.fromMap(x))))),
        notes: json["notes"] == null ? '' : json["notes"],
        isAssignedChoiceConfirmed: json["isAssignedChoiceConfirmed"] == null ? false : json["isAssignedChoiceConfirmed"],
        enhancedAssignedChoices: json["enhancedAssignedChoice"] == null ? [] : List<InstituteModel>.from(json["enhancedAssignedChoice"].map((x) => InstituteModel.fromMap(x))),
        instituteTutor: json["instituteTutor"] == null ? [] : List<InstituteTutor>.from(json["instituteTutor"].map((x)=> InstituteTutor.fromMap(x))),
    );

    // Custom
    static List<List<String>> _normalizeChoices(dynamic json) {

      List<List<String>> data = [];

      var dirty = List<dynamic>.from(json.map((x) => x));

      for(var d in dirty){
        if(d is List){
          List<String> choices = [];
          for(var s in d){
            choices.add(s);
          }

          data.add(choices);
        }
        else {
          data.add([d]);
        }
      }

      return data;
      
    }
}
