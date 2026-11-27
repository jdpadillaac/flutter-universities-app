mixin UniversityInitialsResolver {
  String initialsFrom(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      return '';
    }
    final words = trimmed.split(RegExp(r'\s+'));
    if (words.isEmpty) {
      return '';
    }
    final first = words.first;
    if (first.isNotEmpty && RegExp(r'^\d').hasMatch(first)) {
      return first.length <= 2 ? first.toUpperCase() : first.substring(0, 2);
    }
    if (words.length == 1) {
      return first.isEmpty ? '' : first[0].toUpperCase();
    }
    final second = words[1];
    final firstLetter = first.isEmpty ? '' : first[0].toUpperCase();
    final secondLetter = second.isEmpty ? '' : second[0].toUpperCase();
    return '$firstLetter$secondLetter';
  }
}
