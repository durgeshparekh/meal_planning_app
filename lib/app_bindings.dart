import 'package:get/get.dart';
import 'modules/home/bindings/home_binding.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    HomeBinding().dependencies();
  }
}
