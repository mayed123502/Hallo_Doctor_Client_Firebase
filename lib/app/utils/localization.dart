import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/translation/fr.dart';
import 'package:hallo_doctor_client/app/translation/ur_PK.dart';

import '../translation/en_US.dart';
import '../translation/ar.dart';
import '../translation/es.dart';

class LocalizationService extends Translations {
  // static final locale = Locale('en', "US");

  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'ur_PK': ur,
        'fr': fr,
        'ar': ar,
        'es': es,
        'def': {'def': 'def'}
      };

  // void changeLocalee() {
  //   print("done");
  // }

}
