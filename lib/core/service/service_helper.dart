import 'package:deliveryherochallenge/core/service/service_config.dart';

class ServiceHelper {
  static Uri getURl(String endpoint) => Uri.parse("${ServiceConfig.baseUrl}$endpoint");
  static String getImgUrl(String img) => ServiceConfig.imgUrl + img;
}
