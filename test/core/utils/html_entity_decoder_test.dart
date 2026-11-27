import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/core/utils/html_entity_decoder.dart';

void main() {
  final decoder = HtmlEntityDecoder();

  test('decodes named entities', () {
    expect(
      decoder.decode('A &amp; B &lt; C &gt; D &quot;E&quot; &apos;F&nbsp;G'),
      'A & B < C > D "E" \'F\u00A0G',
    );
  });

  test('decodes decimal and hexadecimal references', () {
    expect(decoder.decode('&#38; and &#x26;'), '& and &');
  });

  test('leaves unknown entities and plain text unchanged', () {
    expect(decoder.decode('&unknown; Marywood'), '&unknown; Marywood');
  });
}
