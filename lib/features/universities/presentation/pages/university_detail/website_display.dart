class WebsiteDisplay {
  const WebsiteDisplay();

  String format(String url) {
    var value = url.trim();
    if (value.startsWith('https://')) {
      value = value.substring(8);
    } else if (value.startsWith('http://')) {
      value = value.substring(7);
    }
    while (value.endsWith('/')) {
      value = value.substring(0, value.length - 1);
    }
    return value;
  }
}
