

/// Configurazione app
/// [production] usato per i services 
/// 
/// 
abstract class AppConfig {
  static const bool PRODUCTION = true;

  static const String API_PRODUCTION = '<YOUR_BASE_URL>';
  static const String SHIBBOLETH_URL = '<YOUR_BASE_URL>/shibboleth/login';
  static const String SHIBBOLETH_ENDPOINT = '<YOUR_BASE_URL>/shibboleth';
  
  static const String REGOLAMENTO = '<PRIVACY_URL>';
  static const String PRIVACY = '<PRIVACY_URL>';

}


abstract class StudentCreditsPerYear {

  static const Map<int, int> limits = {
    1: 40,
    2: 85,
    3: 135,
    4: 185,
    5: 185,
    6: 185,
    7: 185,
    8: 185,
    9: 185,
    10: 185,
  };
  
}