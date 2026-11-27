import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities_app/core/theme/app_sizes.dart';
import 'package:universities_app/core/theme/app_spacing.dart';
import 'package:universities_app/core/theme/app_typography.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_bloc.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_event.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_state.dart';
import 'package:universities_app/features/universities/presentation/l10n/student_count_error_message.dart';
import 'package:universities_app/features/universities/presentation/widgets/student_count_field.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

class StudentCountCard extends StatelessWidget {
  const StudentCountCard({required this.state, super.key});

  final UniversityDetailLoaded state;

  static const StudentCountErrorMessage _errorMessage =
      StudentCountErrorMessage();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final visibleError = state.visibleError;
    final errorText = visibleError == null
        ? null
        : _errorMessage.resolve(visibleError, l10n);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.studentCountLabel, style: AppTypography.fieldLabel),
            const SizedBox(height: AppSizes.studentCountCardGap),
            StudentCountField(
              initialValue: state.studentsInput,
              errorText: errorText,
            ),
            const SizedBox(height: AppSizes.studentCountCardGap),
            SizedBox(
              width: double.infinity,
              height: AppSizes.fieldHeight,
              child: FilledButton(
                onPressed: state.isValid
                    ? () => context.read<UniversityDetailBloc>().add(
                        const UniversityStudentsSaveRequested(),
                      )
                    : null,
                child: Text(l10n.save),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
