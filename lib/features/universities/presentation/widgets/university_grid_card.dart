import 'package:flutter/material.dart';
import 'package:universities_app/features/universities/domain/entities/university.dart';
import 'package:universities_app/features/universities/presentation/widgets/university_thumbnail.dart';

class UniversityGridCard extends StatelessWidget {
  const UniversityGridCard({
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
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UniversityThumbnail(imagePath: imagePath),
              const SizedBox(height: 8),
              Text(
                university.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
