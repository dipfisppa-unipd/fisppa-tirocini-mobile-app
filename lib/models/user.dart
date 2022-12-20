// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';


class UserModel {
    UserModel({
        this.id,
        this.email,
        this.createdAt,
        this.registry,
        this.university,
        this.updatedAt,
        this.iscrizioneEffettuata = false, 
        this.sceltaIstitutiEffettuata = false, 
        this.sceltaGruppiEffettuata = false
    });

    String? id;
    String? email;
    DateTime? createdAt;
    Registry? registry;
    University? university;
    DateTime? updatedAt;

    // custom
    bool iscrizioneEffettuata;
    bool sceltaIstitutiEffettuata;
    bool sceltaGruppiEffettuata;

    String get name => registry==null ? '' : registry?.firstName ?? '';
    String get fullname => registry==null 
                        ? 'nd' 
                        : registry!.firstName==null && registry!.completeName!=null 
                          ? registry!.completeName ?? ''
                          : '${registry!.firstName ?? ''} ${registry!.lastName ?? ''}';

    /// This will return the current course year of the student.
    /// But, because the student of the first year will make the request for the
    /// first year of internship, then this value is ok for both data.
    int getStudentCourseYear() {

      // university!.year = 'Primo'; // MOCK

      if(university==null || university!.year==null || university!.year!.isEmpty) 
        return 0;

      switch(university!.year){
        case 'Primo': return 1;
        case 'Secondo': return 2;
        case 'Terzo': return 3;
        case 'Quarto': return 4;
        case 'Quinto': return 5;
      }

      return 5; // fuori corso
    }

    UserModel copyWith({
        String? id,
        String? email,
        DateTime? createdAt,
        Registry? registry,
        University? university,
        DateTime? updatedAt,
    }) => 
        UserModel(
            id: id ?? this.id,
            email: email ?? this.email,
            createdAt: createdAt ?? this.createdAt,
            registry: registry ?? this.registry,
            university: university ?? this.university,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["_id"] == null ? null : json["_id"],
        email: json["email"] == null ? null : json["email"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        registry: json["registry"] == null ? null : Registry.fromMap(json["registry"]),
        university: json["university"] == null ? null : University.fromMap(json["university"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toMap() => {
        "registry": registry == null ? null : registry?.toMap(),
        "university": university == null ? null : university?.toMap(),
    };
}

class Registry {
    Registry({
      this.completeName,
      this.firstName,
        this.lastName,
        this.personalEmail,
        this.cellNumber,
        this.residence,
        this.domicile,
    });

    String? firstName, lastName, completeName;
    String? personalEmail;
    String? cellNumber;
    House? residence;
    House? domicile;

    Registry copyWith({
        String? completeName,
        String? firstName,
        String? lastName,
        String? personalEmail,
        String? cellNumber,
        House? residence,
        House? domicile,
    }) => 
        Registry(
          completeName: completeName ?? this.completeName,
          firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            personalEmail: personalEmail ?? this.personalEmail,
            cellNumber: cellNumber ?? this.cellNumber,
            residence: residence ?? this.residence,
            domicile: domicile ?? this.domicile,
        );

    factory Registry.fromJson(String str) => Registry.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Registry.fromMap(Map<String, dynamic> json) => Registry(
        completeName: json["completeName"] == null ? null : json["completeName"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        personalEmail: json["personalEmail"] == null ? null : json["personalEmail"],
        cellNumber: json["cellNumber"] == null ? null : json["cellNumber"],
        residence: json["residence"] == null ? null : House.fromMap(json["residence"]),
        domicile: json["domicile"] == null ? null : House.fromMap(json["domicile"]),
    );

    Map<String, dynamic> toMap() => {
        // "completeName": completeName == null ? null : completeName,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "personalEmail": personalEmail == null ? null : personalEmail,
        "cellNumber": cellNumber == null ? null : cellNumber,
        "residence": residence == null ? null : residence?.toMap(),
        "domicile": domicile == null ? null : domicile?.toMap(),
    };
}

class House extends Equatable {
    House({
        this.street,
        this.city,
        this.cap,
        this.province
    });

    String? street;
    String? city, province;
    String? cap;

    House copyWith({
        String? street,
        String? city,
        String? province,
        String? cap,
    }) => 
        House(
            street: street ?? this.street,
            city: city ?? this.city,
            province: province ?? this.province,
            cap: cap ?? this.cap,
        );

    factory House.fromJson(String str) => House.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory House.fromMap(Map<String, dynamic> json) => House(
        street: json["street"] == null ? null : json["street"],
        city: json["city"] == null ? null : json["city"],
        province: json["province"] == null ? null : json["province"],
        cap: json["cap"] == null ? null : json["cap"],
    );

    Map<String, dynamic> toMap() => {
        "street": street == null ? null : street,
        "city": city == null ? null : city,
        "province": province == null ? null : province,
        "cap": cap == null ? null : cap,
    };

  @override
  List<Object?> get props => [street, city, cap, province];
}

class University {
    University({
      this.studentNumber,
        this.codCourse,
        this.codCourseType,
        this.faculty,
        this.year,
        this.earnedCreditsNotes,
        this.earnedCreditsNumber,
    });

    String? studentNumber;
    String? codCourse;
    String? codCourseType;
    String? faculty;
    String? year;
    String? earnedCreditsNotes;
    int? earnedCreditsNumber;

    University copyWith({
      String? studentNumber,
        String? codCourse,
        String? codCourseType,
        String? faculty,
        String? year,
        String? earnedCreditsNotes,
        int? earnedCreditsNumber,
    }) => 
        University(
          studentNumber: studentNumber ?? this.studentNumber,
            codCourse: codCourse ?? this.codCourse,
            codCourseType: codCourseType ?? this.codCourseType,
            faculty: faculty ?? this.faculty,
            year: year ?? this.year,
            earnedCreditsNotes: earnedCreditsNotes ?? this.earnedCreditsNotes,
            earnedCreditsNumber: earnedCreditsNumber ?? this.earnedCreditsNumber,
        );

    factory University.fromJson(String str) => University.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory University.fromMap(Map<String, dynamic> json) => University(
        studentNumber: json["studentNumber"] == null ? null : json["studentNumber"],
        codCourse: json["codCourse"] == null ? null : json["codCourse"],
        codCourseType: json["codCourseType"] == null ? null : json["codCourseType"],
        faculty: json["faculty"] == null ? null : json["faculty"],
        year: json["year"] == null ? null : json["year"],
        earnedCreditsNotes: json["earnedCreditsNotes"] == null ? null : json["earnedCreditsNotes"],
        earnedCreditsNumber: json["earnedCreditsNumber"] == null ? null : json["earnedCreditsNumber"],
    );

    /// Alcuni dati come codCourse sono immodificabili lato sbackend
    /// 
    Map<String, dynamic> toMap() => {
        // "codCourse": codCourse == null ? null : codCourse,
        // "codCourseType": codCourseType == null ? null : codCourseType,
        // "faculty": faculty == null ? null : faculty,
        // "year": year == null ? null : year,
        "earnedCreditsNotes": earnedCreditsNotes == null ? null : earnedCreditsNotes,
        "earnedCreditsNumber": earnedCreditsNumber == null ? null : earnedCreditsNumber,
    };

}
