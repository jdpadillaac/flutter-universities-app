import 'package:injectable/injectable.dart';

@lazySingleton
class HtmlEntityDecoder {
  HtmlEntityDecoder()
    : _entityPattern = RegExp(r'&(#x[0-9a-fA-F]+|#\d+|[a-zA-Z]+);'),
      _namedEntities = const {
        'amp': '&',
        'lt': '<',
        'gt': '>',
        'quot': '"',
        'apos': "'",
        'nbsp': '\u00A0',
      };

  final RegExp _entityPattern;
  final Map<String, String> _namedEntities;

  String decode(String input) {
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
}
