import 'en_us.dart';
import 'zh_cn.dart';

abstract class BackTranslation {
  static Map<String, Map<String, String>>
  translations =
  {
    'en_US' : enUs,
    'zh_CN' : zhCn,
  };

}