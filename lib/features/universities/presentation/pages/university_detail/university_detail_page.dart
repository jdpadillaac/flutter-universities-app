import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities_app/core/di/injection.dart';
import 'package:universities_app/features/universities/presentation/helpers/failure_message_resolver.dart';
import 'package:universities_app/features/universities/presentation/pages/university_detail/bloc/university_detail_bloc/university_detail_bloc.dart';
import 'package:universities_app/features/universities/presentation/pages/university_detail/bloc/university_detail_bloc/university_detail_event.dart';
import 'package:universities_app/features/universities/presentation/pages/university_detail/bloc/university_detail_bloc/university_detail_state.dart';
import 'package:universities_app/features/universities/presentation/pages/university_detail/widgets/university_detail_app_bar.dart';
import 'package:universities_app/features/universities/presentation/pages/university_detail/widgets/university_detail_content.dart';
import 'package:universities_app/features/universities/presentation/pages/university_detail/widgets/university_not_found_view.dart';
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
      child: UniversityDetailView(
        failureMessageResolver: getIt<FailureMessageResolver>(),
      ),
    );
  }
}

class UniversityDetailView extends StatelessWidget {
  const UniversityDetailView({required this.failureMessageResolver, super.key});

  final FailureMessageResolver failureMessageResolver;

  @override
  Widget build(BuildContext context) {
    return _UniversityDetailFeedbackListener(
      failureMessageResolver: failureMessageResolver,
      child: const Scaffold(
        appBar: UniversityDetailAppBar(),
        body: _UniversityDetailBody(),
      ),
    );
  }
}

class _UniversityDetailFeedbackListener extends StatelessWidget {
  const _UniversityDetailFeedbackListener({
    required this.failureMessageResolver,
    required this.child,
  });

  final FailureMessageResolver failureMessageResolver;
  final Widget child;

  bool _shouldListen(
    UniversityDetailState previous,
    UniversityDetailState current,
  ) {
    if (previous is UniversityDetailLoaded &&
        current is UniversityDetailLoaded) {
      return previous.saveStatus != current.saveStatus ||
          previous.imageFailure != current.imageFailure;
    }
    return false;
  }

  String? _feedbackMessage(
    UniversityDetailLoaded state,
    AppLocalizations l10n,
  ) {
    return switch (state.saveStatus) {
      StudentCountSaveStatus.saved => l10n.savedSuccess,
      StudentCountSaveStatus.idle => switch (state.imageFailure) {
        final failure? => failureMessageResolver.resolve(failure, l10n),
        null => null,
      },
    };
  }

  void _showFeedback(BuildContext context, UniversityDetailState state) {
    if (state is! UniversityDetailLoaded) {
      return;
    }
    final message = _feedbackMessage(state, AppLocalizations.of(context));
    if (message == null) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
    context.read<UniversityDetailBloc>().add(
      const UniversityDetailFeedbackDismissed(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UniversityDetailBloc, UniversityDetailState>(
      listenWhen: _shouldListen,
      listener: _showFeedback,
      child: child,
    );
  }
}

class _UniversityDetailBody extends StatelessWidget {
  const _UniversityDetailBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UniversityDetailBloc, UniversityDetailState>(
      builder: (context, state) => switch (state) {
        UniversityDetailLoading() => const _UniversityDetailLoadingView(),
        UniversityDetailNotFound() => const UniversityNotFoundView(),
        UniversityDetailLoaded() => UniversityDetailContent(state: state),
      },
    );
  }
}

class _UniversityDetailLoadingView extends StatelessWidget {
  const _UniversityDetailLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
