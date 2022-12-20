import 'package:get/get.dart';
import 'package:misslog/core/misslog.dart';
import 'package:unipd_mobile/models/indirect/group_model.dart';
import 'package:unipd_mobile/models/indirect/indirect_choices_model.dart';
import 'package:unipd_mobile/models/indirect/territoriality_model.dart';
import 'package:unipd_mobile/services/api_service.dart';


class IndirectInternshipRepo{

  final api = Get.find<ApiService>();

  Future<List<Territoriality>> getTerritorialities() async {

    List<Territoriality> territorialities = []; 

    try {
      
      var data = await api('/territorialities',
        method: ApiMethod.GET,
      );
      
      if(data!=null){
        
        for(var i in data){
          var terr = Territoriality.fromMap(i);
            territorialities.add(terr);
        }

        MissLog.i("Numero territorialità: ${territorialities.length}");

      }
      
    } catch (e) {
      MissLog.e(e.toString(), tag: 'getTerritorialities|IndirectInternshipRepo');
    }

    return territorialities;
  }

  /// [internshipYear] is a value 1,2,3,4 for the
  /// internship year
  Future<List<IndirectChoicesModel>> getChoices({int? internshipYear}) async {

    List<IndirectChoicesModel> choices = [];

    try {
      
      var data = await api('/internships/indirect',);
      
      if(data!=null && data is List){
        for(var d in data){
          var i = IndirectChoicesModel.fromMap(d);
          choices.add(i);
        }
      } 
      
    } catch (e) {
      MissLog.e(e.toString(), tag: 'getChoices|IndirectInternshipRepo');
    }

    // choices.removeAt(0); // MOCK

    return choices;
  }

  /// [internshipYear] is a value 1,2,3,4 for the
  /// internship year
  Future<bool> saveChoices(int internshipYear, List<dynamic> params, String notes) async {

    try {

      var data = await api('/internships/indirect',
        method: ApiMethod.PUT,
        params: {
          "internshipYear": internshipYear,
          "choices": params,
          "notes": notes,
        }
      );
      
      if(data!=null){
        return true;
      } 
      
    } catch (e) {
      MissLog.e(e.toString(), tag: 'saveChoices|IndirectInternshipRepo');
    }

    return false;
  }


  
  /// Groups of internal internships 
  /// are identified by [internshipYear] with a value from 1-4
  /// and [calendarYear] in numeric format eg: 2022
  /// 
  /// NOTE: a student at the first year of course will start a request 
  /// for the next year for the first internship year.
  /// 
  /// [internshipYear] is here always referred to the next internship year
  /// 
  Future<List<GroupModel>> getGroups(int internshipYear,) async {

    List<GroupModel> groups = [];

    try {

      var data = await api('/territorialities/groups',);
      
      if(data!=null && data is List){
        for(var d in data)
          groups.add(GroupModel.fromMap(d));
      } 
      
    } catch (e) {
      MissLog.e(e.toString(), tag: 'getGroups|IndirectInternshipRepo');
    }

    return groups;
  }

  /// [internshipYear] is a value 1,2,3,4 for the
  /// internship year
  /// [yearOfStudy] is the year when the internship was...
  /// internshipYear < yearOfStudy
  Future<bool> savePreviousGroupChoice(int internshipYear, int calendarYear, int yearOfStudy, {String? notes, String? confirmedChoice}) async {

    try {

      var data = await api('/internships/indirect/previous',
        method: ApiMethod.PUT,
        params: {
          "yearOfStudy": yearOfStudy,
          "calendarYear": calendarYear,
          "internshipYear": internshipYear,
          "assignedChoice": confirmedChoice,
          "notes": notes,
        }
      );
      
      if(data!=null){
        return true;
      } 
      
    } catch (e) {
      MissLog.e(e.toString(), tag: 'savePreviousGroupChoice|IndirectInternshipRepo');
    }

    return false;
  }

  /// This is used to confirm the current group for the next internship year
  Future<bool> confirmGroup(int internshipYear, String groupId, ) async {

    try {

      var data = await api('/internships/indirect',
        method: ApiMethod.PUT,
        params: {
          "internshipYear": internshipYear,
          "assignedChoice": groupId,
        }
      );
      
      if(data!=null){
        return true;
      } 
      
    } catch (e) {
      MissLog.e(e.toString(), tag: 'confirmGroup|IndirectInternshipRepo');
    }

    return false;
  }
}