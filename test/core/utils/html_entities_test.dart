import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/core/utils/html_entities.dart';

void main() {
  test('decodes named entities', () {
    expect(
      decodeHtmlEntities(
        'A &amp; B &lt; C &gt; D &quot;E&quot; &apos;F&nbsp;G',
      ),
      'A & B < C > D "E" \'F\u00A0G',
    );
  });

  test('decodes decimal and hexadecimal references', () {
    expect(decodeHtmlEntities('&#38; and &#x26;'), '& and &');
  });

  test('leaves unknown entities and plain text unchanged', () {
    expect(decodeHtmlEntities('&unknown; Marywood'), '&unknown; Marywood');
  });
}
