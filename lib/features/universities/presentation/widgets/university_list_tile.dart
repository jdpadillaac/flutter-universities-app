import 'package:flutter/material.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/presentation/widgets/university_thumbnail.dart';

class UniversityListTile extends StatelessWidget {
  const UniversityListTile({
    required this.university,
    required this.onTap,
    this.imagePath,
    super.key,
  });

  final University university;
  final String? imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UniversityThumbnail(imagePath: imagePath),
      title: Text(university.name),
      subtitle: Text(university.country),
      onTap: onTap,
    );
  }
}
