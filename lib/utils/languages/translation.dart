import 'package:get/get_navigation/src/root/internacionalization.dart';

import 'arabic.dart';
import 'english.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'ar': ar, 'en': en};
}
