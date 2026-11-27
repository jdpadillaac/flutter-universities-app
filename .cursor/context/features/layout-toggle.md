# Cambio de layout

`LayoutCubit` y `ListLayout`: `lib/features/universities/presentation/pages/universities/bloc/layout_cubit/`. `LayoutToggle`: `pages/universities/widgets/layout_toggle.dart`.

`LayoutCubit` arranca en `ListLayout.list` y `toggle()` alterna con `grid`. `LayoutToggle` vive en `UniversitiesHeader`. `UniversitiesScrollView` pinta lista (card única con `DecoratedSliver`) o cuadrícula de dos columnas (`mainAxisExtent` = `AppSizes.gridItemExtent`).
