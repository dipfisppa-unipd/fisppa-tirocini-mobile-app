import 'package:get/get.dart';
import 'package:misslog/core/misslog.dart';
import 'package:unipd_mobile/controllers/auth_controller.dart';
import 'package:unipd_mobile/controllers/calendar_controller.dart';
import 'package:unipd_mobile/models/direct/direct_choices_model.dart';
import 'package:unipd_mobile/models/indirect/indirect_choices_model.dart';
import 'package:unipd_mobile/repo/direct_internship_repo.dart';
import 'package:unipd_mobile/repo/indirect_internship_repo.dart';



class CareerController extends GetxController{

  static CareerController get to => Get.find();

  final DirectInternshipRepo _directInternshipRepo = DirectInternshipRepo();
  final IndirectInternshipRepo _inDirectInternshipRepo = IndirectInternshipRepo();

  bool isLoading = true;
  Map<String, bool> _currentInternshipYearNeeded = {
    'direct': true,
    'indirect': true,
  };

  int currentYear = CalendarController.to.currentYear; // prende l'anno in base a quello accademico
  int currentCourseYear = 0;
  int currentDirectInternshipYear = 0;
  int currentIndirectInternshipYear = 0;
  List<DirectChoicesModel> directs = [];
  List<IndirectChoicesModel> indirects = [];

  bool get isCurrentDirectInternshipNeeded => _currentInternshipYearNeeded['direct']!;
  bool get isCurrentIndirectInternshipNeeded => _currentInternshipYearNeeded['indirect']!;
  bool get noInternshipYearAvailable => currentDirectInternshipYear==0 
                                      && currentIndirectInternshipYear==0
                                      && isCurrentDirectInternshipNeeded
                                      && isCurrentIndirectInternshipNeeded;
  bool get isPrimaryInfancyRequired => currentDirectInternshipYear<2;

  
  @override
  void onInit() {
    // Check if the student has registered previous internships year
    _fetchPreviousYears();
    super.onInit();
  }

  void reload() => _fetchPreviousYears();
  
  void _fetchPreviousYears() async {

    isLoading = true;
    update();

    currentCourseYear = AuthController.to.user!.getStudentCourseYear();

    if(currentCourseYear==1){
      // Student of the first year do not need to add previous internships
      _currentInternshipYearNeeded = {
        'direct': false,
        'indirect': false,
      };
      
    }else{

      directs   = await _directInternshipRepo.getChoices();
      indirects = await _inDirectInternshipRepo.getChoices();
      
      // directs.clear(); // MOCK
      // indirects.clear(); // MOCK
      

      if(directs.isNotEmpty){
        var internship = directs.firstWhereOrNull((element) => element.calendarYear==currentYear);

        if(internship!=null){
          _currentInternshipYearNeeded['direct'] = false;
          currentDirectInternshipYear = internship.internshipYear ?? 0;
        }
      }

      if(indirects.isNotEmpty){
        var internship = indirects.firstWhereOrNull((element) => element.calendarYear==currentYear);

        if(internship!=null){
          _currentInternshipYearNeeded['indirect'] = false;
          currentIndirectInternshipYear = internship.internshipYear ?? 0;
        }
      }

    }

    if(currentDirectInternshipYear==0 && currentIndirectInternshipYear>0){
      currentDirectInternshipYear = currentIndirectInternshipYear;
    }else if(currentDirectInternshipYear>0 && currentIndirectInternshipYear==0){
      currentIndirectInternshipYear = currentDirectInternshipYear;
    }

    // currentIndirectInternshipYear = 2; // MOCK

    isLoading = false;
    update();

    MissLog.d('------------------$currentYear-------------------');
    MissLog.d('Student course year $currentCourseYear');
    MissLog.d('Student internships years D$currentDirectInternshipYear/I$currentIndirectInternshipYear');
    MissLog.d('- direct internship needed   : ${_currentInternshipYearNeeded['direct']}');
    MissLog.d('- indirect internship needed : ${_currentInternshipYearNeeded['indirect']}');
  }

  void setInternshipYear(int i){
    currentDirectInternshipYear = i;
    currentIndirectInternshipYear = i;
    update();
  }

  /// This method is used when the student is NOT at the first year of course,
  /// and HAS NOT any internships done before.
  /// 
  /// i.e: Student of the 3th year who needs to enroll at 1st internship year.
  void setFirstInternshipEnrollment(){
    _currentInternshipYearNeeded = {
        'direct': false,
        'indirect': false,
      };
    update();
  }

// end
}