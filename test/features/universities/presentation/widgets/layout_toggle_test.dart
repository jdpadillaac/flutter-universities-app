import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:universities_app/features/universities/presentation/bloc/layout_cubit.dart';
import 'package:universities_app/features/universities/presentation/bloc/list_layout.dart';
import 'package:universities_app/features/universities/presentation/widgets/layout_toggle.dart';
import '../../../../support/localized_material_app.dart';

void main() {
  testWidgets('notifies layout cubit when switching to grid', (tester) async {
    final cubit = LayoutCubit();
    await tester.pumpWidget(
      LocalizedMaterialApp(
        child: BlocProvider<LayoutCubit>.value(
          value: cubit,
          child: const Scaffold(body: LayoutToggle()),
        ),
      ),
    );

    expect(cubit.state, ListLayout.list);
    await tester.tap(find.byIcon(Icons.grid_view));
    await tester.pump();
    expect(cubit.state, ListLayout.grid);
  });

  testWidgets('notifies layout cubit when switching to list', (tester) async {
    final cubit = LayoutCubit()..emit(ListLayout.grid);
    await tester.pumpWidget(
      LocalizedMaterialApp(
        child: BlocProvider<LayoutCubit>.value(
          value: cubit,
          child: const Scaffold(body: LayoutToggle()),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.view_list));
    await tester.pump();
    expect(cubit.state, ListLayout.list);
  });
}
