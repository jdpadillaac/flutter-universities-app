import 'package:equatable/equatable.dart';

class University extends Equatable {
  const University({
    required this.id,
    required this.name,
    required this.country,
    required this.countryCode,
    required this.domains,
    required this.webPages,
    this.stateProvince,
  });

  final String id;
  final String name;
  final String country;
  final String countryCode;
  final List<String> domains;
  final List<String> webPages;
  final String? stateProvince;

  @override
  List<Object?> get props => [
    id,
    name,
    country,
    countryCode,
    domains,
    webPages,
    stateProvince,
  ];
}
