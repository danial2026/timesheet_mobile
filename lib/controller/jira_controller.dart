import 'package:get/get.dart';

class JiraController extends GetxController {
  @override
  void onInit() {
    // Here you can fetch you product from server
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // Here, you can dispose your StreamControllers
    // you can cancel timers
    super.onClose();
  }

  Rx<String> test3 = '0'.obs;
  final count = 0.obs;

  void getJiraToken(String test) {
    print('test : ${test}');

    test3 = test.obs;

    update();
    print(test3);
  }

  increment() => count.value++;
}
