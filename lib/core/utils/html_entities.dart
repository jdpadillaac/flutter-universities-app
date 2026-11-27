final _entityPattern = RegExp(r'&(#x[0-9a-fA-F]+|#\d+|[a-zA-Z]+);');

const _namedEntities = <String, String>{
  'amp': '&',
  'lt': '<',
  'gt': '>',
  'quot': '"',
  'apos': "'",
  'nbsp': '\u00A0',
};

/// Decodes HTML entities in [input].
///
/// Covers amp, lt, gt, quot, apos and nbsp, plus decimal and hexadecimal
/// numeric references. Unknown entities are left unchanged.
String decodeHtmlEntities(String input) {
  return input.replaceAllMapped(_entityPattern, (match) {
    final token = match.group(1)!;
    if (token.startsWith('#x')) {
      final codePoint = int.parse(token.substring(2), radix: 16);
      return String.fromCharCode(codePoint);
    }
    if (token.startsWith('#')) {
      final codePoint = int.parse(token.substring(1));
      return String.fromCharCode(codePoint);
    }
    return _namedEntities[token] ?? match.group(0)!;
  });
}
