import 'package:get/get.dart';

class HomeController extends GetxController {
  var url = "".obs;

  updateUrl(urlV) => url(urlV);
}
