# Cambio de layout

`LayoutCubit` y `ListLayout`: `lib/features/universities/presentation/pages/universities/bloc/layout_cubit/`. `LayoutToggle`: `pages/universities/widgets/layout_toggle.dart`.

`LayoutCubit` expone `ListLayout` (`list`, `grid`). `LayoutToggle` en `UniversitiesHeader` alterna vista; `UniversitiesScrollView` pinta lista (card única con `DecoratedSliver`) o cuadrícula de dos columnas.