import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:universities_app/features/universities/presentation/bloc/list_layout.dart';

@injectable
class LayoutCubit extends Cubit<ListLayout> {
  LayoutCubit() : super(ListLayout.list);

  void toggle() {
    emit(state == ListLayout.list ? ListLayout.grid : ListLayout.list);
  }
}
