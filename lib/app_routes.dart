import 'package:get/get.dart';
import 'modules/home/bindings/home_binding.dart';
import 'modules/home/views/home_view.dart';

class AppRoutes {
  static const String home = '/home';

  static final pages = [
    GetPage(
      name: home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
