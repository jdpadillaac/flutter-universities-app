import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/presentation/pages/university_detail/website_display.dart';

void main() {
  const formatter = WebsiteDisplay();

  test('strips scheme and trailing slash', () {
    expect(formatter.format('https://sample.edu/'), 'sample.edu');
    expect(formatter.format('http://sample.edu/path/'), 'sample.edu/path');
  });
}
