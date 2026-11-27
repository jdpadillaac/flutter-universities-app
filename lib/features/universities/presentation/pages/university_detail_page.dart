import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities_app/core/di/injection.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_bloc.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_event.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_state.dart';
import 'package:universities_app/features/universities/presentation/widgets/university_detail_app_bar.dart';
import 'package:universities_app/features/universities/presentation/widgets/university_detail_content.dart';
import 'package:universities_app/l10n/generated/app_localizations.dart';

class UniversityDetailPage extends StatelessWidget {
  const UniversityDetailPage({required this.universityId, super.key});

  final String universityId;

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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocListener<UniversityDetailBloc, UniversityDetailState>(
      listenWhen: (previous, current) => previous.notice != current.notice,
      listener: (context, state) {
        final message = switch (state.notice) {
          UniversityDetailNotice.none => null,
          UniversityDetailNotice.saved => l10n.savedSuccess,
          UniversityDetailNotice.permissionDenied => l10n.permissionDenied,
          UniversityDetailNotice.imageFailed =>
            state.imageFailedMessage ?? l10n.imagePickFailed,
        };
        if (message != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
          context.read<UniversityDetailBloc>().add(
            const UniversityDetailNoticeShown(),
          );
        }
      },
      child: Scaffold(
        appBar: const UniversityDetailAppBar(),
        body: BlocBuilder<UniversityDetailBloc, UniversityDetailState>(
          builder: (context, state) {
            return switch (state.status) {
              UniversityDetailStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
              UniversityDetailStatus.notFound => Center(
                child: Text(
                  l10n.universityNotFound,
                  textAlign: TextAlign.center,
                ),
              ),
              UniversityDetailStatus.ready when state.university != null =>
                UniversityDetailContent(state: state),
              UniversityDetailStatus.ready => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}
