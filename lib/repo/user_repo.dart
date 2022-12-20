
import 'package:get/get.dart';
import 'package:misslog/misslog.dart';
import 'package:unipd_mobile/models/user.dart';
import 'package:unipd_mobile/services/api_service.dart';



class UserRepo {

  final _api = Get.find<ApiService>();

  /// Ritorna l'utente/studente loggato
  /// 
  Future<UserModel?> getUser() async {

    try {
      
      var data = await _api('/users/user',
        method: ApiMethod.GET,
      );
      
      if(data!=null){
        
        return UserModel.fromMap(data);

      } else {
        MissLog.e("data null");
      }
      
    } catch (e) {
      MissLog.e('Error getUser: $e', tag: 'UserRepo');
    }

    return null;
  }

  /// Ritorna l'utente/studente loggato
  /// 
  Future<UserModel?> editUser(UserModel user) async {

    try {
      
      var data = await _api('/user',
        method: ApiMethod.PUT,
        params: user.toMap()
      );
      
      if(data!=null){
        
        return UserModel.fromMap(data);

      } else {
        MissLog.e("data null");
      }
      
    } catch (e) {
      MissLog.e('Error editUser: $e', tag: 'UserRepo');
    }

    return null;
  }

}