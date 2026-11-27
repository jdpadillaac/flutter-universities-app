# Design system — Opción A · Claro y funcional

Tokens en `lib/core/theme/`. `AppTheme` (`@lazySingleton`) expone `light` para Material 3.

## Colores (`AppColors`)

background, surface, border, divider, segmentedBackground, textPrimary, textSecondary, textTertiary, icon, primary, onPrimary, primaryStrong, primaryContainer, primaryBorder, error, disabledBackground, disabledForeground.

## Espaciado y radios

`AppSpacing`: xs–xl (4–20). `AppRadius`: segmentedItem 9, control 12, card 16, pill 999. `AppSizes`: avatares, toggle, picker, controles táctiles y bordes de error.

## Tipografía (`AppTypography`)

Inter vía `google_fonts`: screenTitle, detailTitle, appBarTitle, itemTitle, body, bodyStrong, caption, chip, button, gridTitle, gridDomain, avatarInitials, fieldLabel, errorCaption.

## Componentes de lista

- `UniversitiesHeader`: caption + título y `LayoutToggle`.
- `LayoutToggle`: control segmentado 40×40; lee `LayoutCubit`.
- `UniversitiesScrollView`: scroll infinito; único `StatefulWidget` de lista.
- `UniversityListTile` / `UniversityGridCard`: ítems con `UniversityAvatar`.
- `UniversityAvatar`: imagen de sesión o iniciales (`UniversityInitialsResolver`).
- `LoadMoreIndicator` y vistas de estado en `universities_status_views.dart`.

## Componentes de detalle

- `UniversityDetailAppBar`, `UniversityImagePicker` (borde punteado con `DashedBorderPainter`), `UniversityCountryChip`, `UniversityInfoCard`, `StudentCountCard`, `StudentCountField` (único `StatefulWidget` del detalle).

## Textos

`lib/l10n/arb/app_es.arb` → `AppLocalizations`. `FailureMessageResolver` vive en `presentation/helpers/failure_message_resolver.dart`. `StudentCountErrorMessage` vive en `pages/university_detail/student_count_error_message.dart`.