import 'package:get/get.dart';
import 'package:misslog/core/misslog.dart';
import 'package:unipd_mobile/models/direct/direct_choices_model.dart';
import 'package:unipd_mobile/models/direct/istituti_tirocinio_diretto.dart';
import 'package:unipd_mobile/services/api_service.dart';

import '../models/direct/institute_tutor_model.dart';


class DirectInternshipRepo{

  final api = Get.find<ApiService>();

  Future<List<InstituteModel>> getInstitutes({String param = ""}) async {

    List<InstituteModel> institutes = []; 

    try {
      
      var data = await api('/institutes?text=$param',
        method: ApiMethod.GET,
      );
      
      if(data!=null){
        
        for(var i in data){
          var istituto = InstituteModel.fromMap(i);
            institutes.add(istituto);
        }

        MissLog.i("Numero istituti: ${institutes.length}");

      } else {
        MissLog.e("data null");
      }
      
    } catch (e) {
      MissLog.e(e.toString());
    }

    return institutes;
  }

  /// [internshipYear] is a value 1,2,3,4 for the
  /// internship year
  Future<List<DirectChoicesModel>> getChoices({int? internshipYear}) async {

    List<DirectChoicesModel> choices = [];

    try {
      
      var data = await api('/internships/direct',);
      
      if(data!=null && data is List && data.isNotEmpty){

        for(var d in data){
          
          if(d!=null){
            var choice = DirectChoicesModel.fromMap(d);
            choices.add(choice);
          }
            
        }
          
      } 
      
    } catch (e) {
      MissLog.e(e.toString(), tag: 'getChoices|DirectInternshipRepo');
    }

    return choices;
  }

  /// [internshipYear] is a value 1,2,3,4 for the
  /// internship year
  Future<bool> saveChoices(int internshipYear, List<dynamic> params, String notes) async {

    try {

      var data = await api('/internships/direct',
        method: ApiMethod.PUT,
        params: {
          "internshipYear": internshipYear,
          "choices": params,
          "notes": notes
        }
      );
      
      if(data!=null){
        return true;
      } 
      
    } catch (e) {
      MissLog.e(e.toString());
    }

    return false;
  }

  /// [internshipYear] is a value 1,2,3,4 for the
  /// internship year
  /// [yearOfStudy] optional is the course year from 1 top 5
  Future<bool> savePreviousChoices(int yearOfStudy, int internshipYear, int calendarYear, DirectInternshipChoice? choices, String notes) async {

    try {

      var params = [];
      
      if(choices!=null){
        params = [];
        params.add(choices.istituto1.code);
        if(choices.istituto2!=null)
        params.add(choices.istituto2!.code);
      }

      var data = await api('/internships/direct/previous',
        method: ApiMethod.PUT,
        params: {
          "yearOfStudy": yearOfStudy,
          "internshipYear": internshipYear,
          "calendarYear": calendarYear,
          "assignedChoice": params,
          "notes": notes
        }
      );
      
      if(data!=null){
        return true;
      } 
      
    } catch (e) {
      MissLog.e(e.toString());
    }

    return false;
  }


  /// Save tutors
  /// 
  Future<bool> saveTutors(String id, List<InstituteTutor> tutors) async {
  
    try {
      
      var data = await api('/internships/direct',
        method: ApiMethod.PATCH,
        params: {
          "id": id,
          "data": {
            "instituteTutor": List<dynamic>.from(tutors.map((e) => e.toMap()))
          }
        },
      );
      
      if(data!=null){
        return data['_id']!=null;
      } else {
        MissLog.e("data null");
      }
      
    } catch (e) {
      MissLog.e(e.toString());
    }

    return false;
  }

}