import 'package:bookbuddy/core/api%20base/api_endpoint/api_endpoints.dart';

enum Flavor { dev, prod }

class FlavorConfig {
  static Flavor appFlavor = Flavor.dev;

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return ApiEndpoints.baseUrlDev;
      case Flavor.prod:
        return ApiEndpoints.baseUrlProd;
    }
  }

  static String get apiKey {
    switch (appFlavor) {
      case Flavor.dev:
        return "AIzaSyCv0Kxfh_xeQ_eicjoO7wlOthm3DYjgff0";
      case Flavor.prod:
        return "AIzaSyCv0Kxfh_xeQ_eicjoO7wlOthm3DYjgff0";
    }
  }
}
