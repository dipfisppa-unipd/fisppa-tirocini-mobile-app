import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:misslog/misslog.dart';
import 'package:unipd_mobile/controllers/auth_controller.dart';
import 'package:unipd_mobile/repo/secure_repo.dart';
import 'package:unipd_mobile/utils/utils.dart';

import '../app/app_config.dart';

enum ApiMethod { GET, POST, PUT, PATCH, DELETE }

class ApiService {
  // static final ApiService _instance = ApiService._create();

  Dio? _dio;

  // factory ApiService() => _instance;

  initApi({String? refreshToken}) {
    
    Map<String, dynamic>? headers;

    if(refreshToken!=null){
      headers = {
        'x-refresh': refreshToken,
      };
    }else if(SecureRepo.to.accessToken!=null){
      headers = {
        'Authorization': 'Bearer ${SecureRepo.to.accessToken}',
      };
    }

    // new Dio with a BaseOptions instance.
    BaseOptions options = BaseOptions(
      contentType: 'application/json',
      followRedirects: true,
      headers: headers,
      baseUrl: AppConfig.API_PRODUCTION,
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );

    _dio = Dio(options);
    _dio?.interceptors.clear();

    if(refreshToken==null) // if refreshing accessToken, we do not need to intercept
    _dio?.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (RequestOptions requestOptions, RequestInterceptorHandler handler,) {
          
          handler.next(requestOptions);
        },
        onResponse: (Response response, handler){
          handler.next(response);
        },
        onError: (DioError e, handler) async { 

          if(e.response!=null && e.response!.statusCode==401){

            RequestOptions requestOptions = e.requestOptions;

            MissLog.e('ApiService 401, token expired: locking Dio and requesting fresh token');
            var refresh = await AuthController.to.refreshAccessToken();
            if(refresh==null){
              return;
            }

            final opts = Options(method: requestOptions.method);
            _dio?.options.headers['accessToken'] = refresh;
            _dio?.options.headers['Accept'] = '*/*';

            requestOptions.headers['accessToken'] = refresh;
            requestOptions.headers['Accept'] = '*/*';

            final response = await _dio?.request(
              requestOptions.path,
              options: opts,
              cancelToken: requestOptions.cancelToken,
              onReceiveProgress: requestOptions.onReceiveProgress,
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters
            );

            if(response!=null){
              handler.resolve(response);
              return;
            }
          }

          return handler.next(e);
          
        } ,
      )
    );

  }

  /// [call] method make the ApiService callable
  /// You can call the method as: api('/path')
  /// [method] default is GET
  /// [verbose] set false to avoid toasts messages
  Future<dynamic> call(String path, {
    dynamic params, 
    ApiMethod method = ApiMethod.GET,
    bool verbose = true,
    bool refreshToken = false,
  }) async {
    if(_dio == null){
      print("ApiService non inizializato");
      return null;
    }

    if(!kReleaseMode)
    print('Calling: $path');

    try {
      Response response;
      
      switch (method) {
        case ApiMethod.GET:
          response = await _dio!.get(path,);
          break;
        case ApiMethod.POST:
          response = await _dio!.post(path, data: params);
          break;
        case ApiMethod.PUT:
          response = await _dio!.put(path, data: params);
          break;
        case ApiMethod.PATCH:
          response = await _dio!.patch(path, data: params);
          break;
        case ApiMethod.DELETE:
          response = await _dio!.delete(
            path,
          );
          break;
      }

      if (response.statusCode == 200) {
        // print(response.data.toString());
        return response.data!=null ? response.data : true;
      }
    } on DioError catch (e) {
      if(!kReleaseMode) 
        MissLog.e('${e.response?.statusCode}', tag: 'ErrCode');

      if(e.response!.statusCode==400){
        Utils.showToast(isError: true, text: 'Errore dati');

      }else if(e.response!.statusCode==401){
        if(verbose)
        Utils.showToast(isError: true, text: 'Utente o password errati');
      }else if(e.response!.statusCode==403){
        // Forbidden, the user is not allowed
        // Used in long-polling
        return 403;
      }else if(e.response!.statusCode==404){
        if(verbose)
        Utils.showToast(isError: true, text: 'Errore, risorsa non trovata');
      }else if(e.response!.statusCode==406){
        if(verbose)
        Utils.showToast(isError: true, text: 'Non disponibile');
      }else if(e.response!.statusCode==500){
        if(verbose)
        Utils.showToast(isError: true, text: 'Errore del server, contattare un amministratore');
        return 500;
      }else if(e.response!.statusCode==503){
        if(verbose)
        Utils.showToast(isError: true, text: 'Servizio temporaneamente indisponibile, riprova tra poco.');
      }

      if(e.response!=null) {
        throw '${e.response}';
      }else{
        throw 'Bad error: 000';
      }
      
      
      
    } catch (e) {
      throw 'Errore sconosciuto';
    } finally {}

    return null;
  }
}
