
import '../../routes/routes_list.dart';

extension RoutesExtensions on String {
  void go({Object? extra}) {
    RoutesPages.router.goNamed(this, extra: extra);
  }

  void push({Object? extra}) {
    RoutesPages.router.pushNamed(this, extra: extra);
  }

  void replace({Object? extra}) {
    RoutesPages.router.replaceNamed(this, extra: extra);
  }
}
 