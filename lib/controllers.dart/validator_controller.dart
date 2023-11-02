import 'package:get/get.dart';

class ValidatorController extends GetxController {
  var name = Rx<String>('');
  var errorMessage = Rxn<String>(null);

  var regexWordAllow = RegExp(r"[A-Za-z. ]");
  var regexWord = RegExp(r"^[A-Z]'?[a-z]{1,}$");
  var regexInitial = RegExp(r"^[A-Z][.]$");
  var regexCaps = RegExp(r"[A-Z]");
  bool startCaps(String text) => text.startsWith(regexCaps);
  bool endDots(String text) => text.endsWith('.');

  String? getErrorInitial(String text, {bool isMiddle = false}) {
    String? message;
    if (!startCaps(text)) {
      message = 'Incorrect capitalization';
    } else if (regexWord.hasMatch(text)) {
      message = isMiddle
          ? 'Cannot have: initial first name + word middle name'
          : 'Must be 1 character initial';
    } else if (!endDots(text)) {
      message = 'Missing dot after initial';
    } else if (text.length > 2 && text.contains('.')) {
      message = 'Words cannot contains a dot';
    }
    return message;
  }

  String? getErrorWord(String text) {
    String? message;

    if (regexInitial.hasMatch(text)) {
      message = 'Last name cannot be initial';
    } else if (!startCaps(text) || regexCaps.hasMatch(text.substring(1))) {
      message = 'Incorrect capitalization';
    } else if (text.length == 1) {
      message = 'Missing dot after initial';
    } else if (endDots(text)) {
      message = 'Words cannot end with a dot (only initials can)';
    } else if (text.contains('.')) {
      message = 'Words cannot contains a dot';
    }
    return message;
  }

  String? getErrorMessage(String text) {
    String? message;
    var split = text.split(' ');
    var firstName = regexInitial.hasMatch(split[0])
        ? getErrorInitial(split[0])
        : getErrorWord(split[0]);
    if (!(split.length > 1)) {
      message = 'Must be 2 or 3 words';
    } else if (split.length == 2) {
      message = firstName ?? getErrorWord(split[1]);
    } else {
      var middleName = regexWord.hasMatch(split[0])
          ? regexInitial.hasMatch(split[1])
              ? getErrorInitial(split[1], isMiddle: true)
              : getErrorWord(split[1])
          : getErrorInitial(split[1], isMiddle: true);
      message = firstName ?? middleName ?? getErrorWord(split[2]);
    }
    return message;
  }

  bool validName(String name) {
    var split = name.split(' ');
    if (!(split.length > 1)) return false;
    var result = split.every((e) {
      if (e == split.last) return regexWord.hasMatch(e);
      if (e == split.first) {
        return regexInitial.hasMatch(e) || regexWord.hasMatch(e);
      }
      if (e != split.last && e != split.last) {
        if (regexInitial.hasMatch(split[0])) {
          return regexInitial.hasMatch(e);
        } else {
          return regexInitial.hasMatch(e) || regexWord.hasMatch(e);
        }
      }
      return false;
    });
    return result;
  }
}
