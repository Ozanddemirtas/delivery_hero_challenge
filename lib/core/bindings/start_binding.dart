import '../../_.dart';

class StartBinding extends Bindings {
  @override
  void dependencies() {
    AppController c = Get.put<AppController>(AppController());
    print(c);
  }
}
