import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities_app/core/di/injection.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_bloc.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_event.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_state.dart';
import 'package:universities_app/features/universities/presentation/l10n/failure_message.dart';
import 'package:universities_app/features/universities/presentation/widgets/university_detail_app_bar.dart';
import 'package:universities_app/features/universities/presentation/widgets/university_detail_content.dart';
import 'package:universities_app/features/universities/presentation/widgets/university_not_found_view.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

class UniversityDetailPage extends StatelessWidget {
  const UniversityDetailPage({required this.universityId, super.key});

  final String? universityId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<UniversityDetailBloc>()
            ..add(UniversityDetailRequested(universityId)),
      child: const UniversityDetailView(),
    );
  }
}

class UniversityDetailView extends StatelessWidget {
  const UniversityDetailView({super.key});

  static const FailureMessage _failureMessage = FailureMessage();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocListener<UniversityDetailBloc, UniversityDetailState>(
      listenWhen: (previous, current) {
        if (previous is UniversityDetailLoaded &&
            current is UniversityDetailLoaded) {
          return previous.saveStatus != current.saveStatus ||
              previous.imageFailure != current.imageFailure;
        }
        return false;
      },
      listener: (context, state) {
        if (state is! UniversityDetailLoaded) {
          return;
        }
        final message = switch (state.saveStatus) {
          StudentCountSaveStatus.saved => l10n.savedSuccess,
          StudentCountSaveStatus.idle => switch (state.imageFailure) {
            final failure? => _failureMessage.resolve(failure, l10n),
            null => null,
          },
        };
        if (message != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
          context.read<UniversityDetailBloc>().add(
            const UniversityDetailFeedbackDismissed(),
          );
        }
      },
      child: Scaffold(
        appBar: const UniversityDetailAppBar(),
        body: BlocBuilder<UniversityDetailBloc, UniversityDetailState>(
          builder: (context, state) {
            return switch (state) {
              UniversityDetailLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              UniversityDetailNotFound() => const UniversityNotFoundView(),
              UniversityDetailLoaded() => UniversityDetailContent(state: state),
            };
          },
        ),
      ),
    );
  }
}
