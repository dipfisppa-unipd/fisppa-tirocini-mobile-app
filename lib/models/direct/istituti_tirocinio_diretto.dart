// To parse this JSON data, do
//
//     final istitutoModel = istitutoModelFromMap(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class InstituteModel {
    InstituteModel({
        this.id,
        this.convention,
        this.schoolType,
        this.academicYear,
        this.geographicArea,
        this.region,
        this.province,
        this.code,
        this.name,
        this.address,
        this.cap,
        this.cityCode,
        this.city,
        this.educationDegree,
        this.email,
        this.pec,
        this.website,
        this.referenceInstituteCode,
        this.referenceInstituteName,
        this.additionalCharacteristics,
        this.isHeadOffice,
        this.allEncompassingCode,
        this.v,
        this.createdAt,
        this.updatedAt,
        this.latitude,
        this.longitude,
    });

    String? id;
    dynamic convention;
    String? schoolType;
    String? academicYear;
    String? geographicArea;
    String? region;
    String? province;
    String? code;
    String? name;
    String? address;
    String? cap;
    String? cityCode;
    String? city;
    String? educationDegree;
    String? email;
    String? pec;
    String? website;
    String? referenceInstituteCode;
    String? referenceInstituteName;
    String? additionalCharacteristics;
    bool? isHeadOffice;
    String? allEncompassingCode;
    int? v;
    DateTime? createdAt;
    DateTime? updatedAt;
    double? latitude;
    double? longitude;
    List<InstituteModel> schools = [];

    factory InstituteModel.fromJson(String str) => InstituteModel.fromMap(json.decode(str));

    bool get isComprensivo => code == referenceInstituteCode;
    bool get isPrimaria => educationDegree == "SCUOLA PRIMARIA" || educationDegree == "ISTITUTO COMPRENSIVO";
    bool get isInfanzia => educationDegree == "SCUOLA INFANZIA" || isComprensivoConInfanzia();
    bool get isParitaria => schoolType == "PARITARIA";
    bool get isPrimariaParitaria => isParitaria && educationDegree == "SCUOLA PRIMARIA NON STATALE";
    bool get isInfanziaParitaria => isParitaria && educationDegree == "SCUOLA INFANZIA NON STATALE";

    bool isComprensivoConInfanzia() {
      for(var s in schools){
        if(s.educationDegree ==  "SCUOLA INFANZIA")
          return true;
      }

      return false;
    }

    String toJson() => json.encode(toMap());

    factory InstituteModel.fromMap(Map<String, dynamic> json) => InstituteModel(
        id: json["_id"] == null ? null : json["_id"],
        convention: json["convention"],
        schoolType: json["schoolType"] == null ? null : json["schoolType"],
        academicYear: json["academicYear"] == null ? null : json["academicYear"],
        geographicArea: json["geographicArea"] == null ? null : json["geographicArea"],
        region: json["region"] == null ? null : json["region"],
        province: json["province"] == null ? null : json["province"],
        code: json["code"] == null ? null : json["code"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        cap: json["cap"] == null ? null : json["cap"],
        cityCode: json["cityCode"] == null ? null : json["cityCode"],
        city: json["city"] == null ? null : json["city"],
        educationDegree: json["educationDegree"] == null ? null : json["educationDegree"],
        email: json["email"] == null ? null : json["email"],
        pec: json["pec"] == null ? null : json["pec"],
        website: json["website"] == null ? null : json["website"],
        referenceInstituteCode: json["referenceInstituteCode"] == null ? null : json["referenceInstituteCode"],
        referenceInstituteName: json["referenceInstituteName"] == null ? null : json["referenceInstituteName"],
        additionalCharacteristics: json["additionalCharacteristics"] == null ? null : json["additionalCharacteristics"],
        isHeadOffice: json["isHeadOffice"] == null ? null : json["isHeadOffice"],
        allEncompassingCode: json["allEncompassingCode"] == null ? null : json["allEncompassingCode"],
        v: json["__v"] == null ? null : json["__v"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "convention": convention,
        "schoolType": schoolType == null ? null : schoolType,
        "academicYear": academicYear == null ? null : academicYear,
        "geographicArea": geographicArea == null ? null : geographicArea,
        "region": region == null ? null : region,
        "province": province == null ? null : province,
        "code": code == null ? null : code,
        "name": name == null ? null : name,
        "address": address == null ? null : address,
        "cap": cap == null ? null : cap,
        "cityCode": cityCode == null ? null : cityCode,
        "city": city == null ? null : city,
        "educationDegree": educationDegree == null ? null : educationDegree,
        "email": email == null ? null : email,
        "pec": pec == null ? null : pec,
        "website": website == null ? null : website,
        "referenceInstituteCode": referenceInstituteCode == null ? null : referenceInstituteCode,
        "referenceInstituteName": referenceInstituteName == null ? null : referenceInstituteName,
        "additionalCharacteristics": additionalCharacteristics == null ? null : additionalCharacteristics,
        "isHeadOffice": isHeadOffice == null ? null : isHeadOffice,
        "allEncompassingCode": allEncompassingCode == null ? null : allEncompassingCode,
        "__v": v == null ? null : v,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
    };
}

class DirectInternshipChoice extends Equatable {
  InstituteModel istituto1;
  InstituteModel? istituto2;

  DirectInternshipChoice({required this.istituto1, this.istituto2});

  bool get isComplete => (istituto1.isInfanzia 
        || (istituto2 != null && istituto2!.isInfanzia) 
        || (istituto2 != null && istituto2!.isInfanziaParitaria)
      );


  @override
  List<Object?> get props => [istituto1, istituto2];
} 