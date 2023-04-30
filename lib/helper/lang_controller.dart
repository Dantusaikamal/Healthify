import 'package:get/get.dart';
import 'package:healthify/core/constants/languages.dart';
import 'package:translator/translator.dart';

class LangController extends GetxController {
  final translator = GoogleTranslator();

  String _languageCode = "en";

  final List<dynamic> _options = Languages.options;
  List<dynamic> get options => _options;

  String get getLanguageCode => _languageCode;

  void setLanguagecode(String data) {
    _languageCode = data;

    update();
  }
}
