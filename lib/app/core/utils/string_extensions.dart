import 'dart:math';

extension StringExten on String {
  String get usernameFromUrl {
    // Find the last '/' character in the URL.
    int lastIndex = lastIndexOf('/');

    if (lastIndex != -1 && lastIndex < length - 1) {
      // Extract the substring after the last '/' character.
      String username = substring(lastIndex + 1);
      return username;
    }

    return this; // Return the same url if no valid username is found.
  }

  String get initials {
    List<String> names = split(' ');
    String initials = '';

    if (names.length == 1) {
      // If the name has only one word, return the first two letters
      // if there is any
      initials = substring(0, min(length, 2)).toUpperCase();
    } else if (names.length >= 2) {
      // If the name has two or more words, return the first letter of the first two words
      initials = names[0][0].toUpperCase() + names[1][0].toUpperCase();
    }

    return initials;
  }
}

extension ConvertFromSnackCaseToTitleCase on String {
  String toTitle() {
    return replaceAll("_", " ");
  }

}
