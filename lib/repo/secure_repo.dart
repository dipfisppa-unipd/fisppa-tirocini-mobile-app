


import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_keys.dart';


class SecureRepo extends GetxService{

  static SecureRepo get to => Get.find();
  final _storage = FlutterSecureStorage();

  String? _authCode, _accessToken, _refreshToken;

  String? get authCode => _authCode;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  /// Passare il [type] presente in AppKeys
  /// 
  void saveToken(String? token, String type){
    if(token==null || token.isEmpty){
      throw 'Token is null';
    }

    switch(type){
      case AppKeys.AUTH_CODE: _authCode=token; break;
      case AppKeys.ACCESS_TOKEN: _accessToken=token; break;
      case AppKeys.REFRESH_TOKEN: _refreshToken=token; break;
    }

    _storage.write(key: type, value: token);
  }

  /// Passare il [type] presente in AppKeys
  /// 
  Future<void> readTokens() async {
    _accessToken  = await _storage.read(key: AppKeys.ACCESS_TOKEN,);
    _refreshToken = await _storage.read(key: AppKeys.REFRESH_TOKEN,);

    if(!kReleaseMode){
      print('AccessToken: $_accessToken');
      print('RefreshToken: $_refreshToken');
    }
    
    return;
  }


  Future<void> deleteAll() async {
    _refreshToken = '';
    _accessToken = '';
    return await _storage.deleteAll();
  }

}