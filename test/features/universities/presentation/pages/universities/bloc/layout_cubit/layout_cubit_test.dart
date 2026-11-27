import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/layout_cubit/layout_cubit.dart';
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/layout_cubit/list_layout.dart';

void main() {
  blocTest<LayoutCubit, ListLayout>(
    'starts in list layout',
    build: LayoutCubit.new,
    verify: (cubit) => expect(cubit.state, ListLayout.list),
  );

  blocTest<LayoutCubit, ListLayout>(
    'toggles between list and grid',
    build: LayoutCubit.new,
    act: (cubit) => cubit.toggle(),
    expect: () => [ListLayout.grid],
  );

  blocTest<LayoutCubit, ListLayout>(
    'toggles back to list',
    build: LayoutCubit.new,
    seed: () => ListLayout.grid,
    act: (cubit) => cubit.toggle(),
    expect: () => [ListLayout.list],
  );
}
