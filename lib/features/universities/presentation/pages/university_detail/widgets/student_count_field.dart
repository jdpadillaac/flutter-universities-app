import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities_app/features/universities/presentation/pages/university_detail/bloc/university_detail_bloc/university_detail_bloc.dart';
import 'package:universities_app/features/universities/presentation/pages/university_detail/bloc/university_detail_bloc/university_detail_event.dart';

class StudentCountField extends StatefulWidget {
  const StudentCountField({
    required this.initialValue,
    this.errorText,
    super.key,
  });

  final String initialValue;
  final String? errorText;

  @override
  State<StudentCountField> createState() => StudentCountFieldState();
}

class StudentCountFieldState extends State<StudentCountField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant StudentCountField oldWidget) {
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
      decoration: InputDecoration(errorText: widget.errorText),
      onChanged: (value) {
        context.read<UniversityDetailBloc>().add(
          UniversityStudentsChanged(value),
        );
      },
    );
  }
}
