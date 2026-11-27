import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities_app/core/di/injection.dart';
import 'package:universities_app/core/media/image_picker_service.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_bloc.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_event.dart';
import 'package:universities_app/features/universities/presentation/bloc/university_detail_state.dart';
import 'package:universities_app/features/universities/presentation/extensions/student_count_error_messages.dart';
import 'package:universities_app/features/universities/presentation/widgets/university_thumbnail.dart';

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
    return BlocListener<UniversityDetailBloc, UniversityDetailState>(
      listenWhen: (previous, current) => previous.notice != current.notice,
      listener: (context, state) {
        final message = switch (state.notice) {
          UniversityDetailNotice.none => null,
          UniversityDetailNotice.saved => 'Guardado correctamente.',
          UniversityDetailNotice.permissionDenied =>
            'Se denegó el permiso para usar la cámara o la galería.',
          UniversityDetailNotice.imageFailed =>
            state.imageFailedMessage ?? 'No se pudo seleccionar la imagen.',
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
        appBar: AppBar(title: const Text('University detail')),
        body: BlocBuilder<UniversityDetailBloc, UniversityDetailState>(
          builder: (context, state) {
            return switch (state.status) {
              UniversityDetailStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
              UniversityDetailStatus.notFound => const Center(
                child: Text('University was not found.'),
              ),
              UniversityDetailStatus.ready when state.university != null =>
                _UniversityDetailContent(state: state),
              UniversityDetailStatus.ready => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}

class _UniversityDetailContent extends StatelessWidget {
  const _UniversityDetailContent({required this.state});

  final UniversityDetailState state;

  @override
  Widget build(BuildContext context) {
    final university = state.university!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: InkWell(
              onTap: () => _showImageSourceSheet(context),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: UniversityThumbnail(imagePath: state.imagePath),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            university.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text('Country: ${university.country}'),
          Text(
            'State / province: ${university.stateProvince ?? 'No disponible'}',
          ),
          const SizedBox(height: 16),
          Text('Domains', style: Theme.of(context).textTheme.titleSmall),
          ...university.domains.map(Text.new),
          const SizedBox(height: 16),
          Text('Web pages', style: Theme.of(context).textTheme.titleSmall),
          ...university.webPages.map(Text.new),
          const SizedBox(height: 24),
          _StudentsCountField(
            initialValue: state.studentsInput,
            errorText: state.visibleError?.message,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: state.isFormValid
                ? () => context.read<UniversityDetailBloc>().add(
                    const UniversityStudentsSaveRequested(),
                  )
                : null,
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  Future<void> _showImageSourceSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: const Text('Cámara'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  context.read<UniversityDetailBloc>().add(
                    const UniversityImagePickRequested(ImagePickSource.camera),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Galería'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  context.read<UniversityDetailBloc>().add(
                    const UniversityImagePickRequested(ImagePickSource.gallery),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StudentsCountField extends StatefulWidget {
  const _StudentsCountField({required this.initialValue, this.errorText});

  final String initialValue;
  final String? errorText;

  @override
  State<_StudentsCountField> createState() => _StudentsCountFieldState();
}

class _StudentsCountFieldState extends State<_StudentsCountField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant _StudentsCountField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue &&
        _controller.text != widget.initialValue) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: 'Number of students',
        errorText: widget.errorText,
        border: const OutlineInputBorder(),
      ),
      onChanged: (value) {
        context.read<UniversityDetailBloc>().add(
          UniversityStudentsChanged(value),
        );
      },
    );
  }
}
