// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router/go_router.dart' as _i583;
import 'package:image_picker/image_picker.dart' as _i183;
import 'package:injectable/injectable.dart' as _i526;
import 'package:universities_app/core/di/register_module.dart' as _i786;
import 'package:universities_app/core/network/api_client.dart' as _i304;
import 'package:universities_app/core/theme/app_theme.dart' as _i321;
import 'package:universities_app/core/utils/html_entity_decoder.dart' as _i265;
import 'package:universities_app/features/universities/data/datasources/remote/universities_json_parser.dart'
    as _i127;
import 'package:universities_app/features/universities/data/datasources/remote/universities_remote_datasource.dart'
    as _i379;
import 'package:universities_app/features/universities/data/datasources/remote/university_dto_mapper.dart'
    as _i297;
import 'package:universities_app/features/universities/data/repositories/image_picker_repository_impl.dart'
    as _i354;
import 'package:universities_app/features/universities/data/repositories/universities_repository_impl.dart'
    as _i577;
import 'package:universities_app/features/universities/data/repositories/university_extras_repository_impl.dart'
    as _i759;
import 'package:universities_app/features/universities/domain/repositories/image_picker_repository.dart'
    as _i202;
import 'package:universities_app/features/universities/domain/repositories/universities_repository.dart'
    as _i874;
import 'package:universities_app/features/universities/domain/repositories/university_extras_repository.dart'
    as _i814;
import 'package:universities_app/features/universities/domain/services/university_id_generator.dart'
    as _i129;
import 'package:universities_app/features/universities/domain/usecases/get_all_university_extras.dart'
    as _i822;
import 'package:universities_app/features/universities/domain/usecases/get_universities_page.dart'
    as _i729;
import 'package:universities_app/features/universities/domain/usecases/get_university_by_id.dart'
    as _i172;
import 'package:universities_app/features/universities/domain/usecases/get_university_extras.dart'
    as _i31;
import 'package:universities_app/features/universities/domain/usecases/pick_university_image.dart'
    as _i886;
import 'package:universities_app/features/universities/domain/usecases/save_university_image.dart'
    as _i576;
import 'package:universities_app/features/universities/domain/usecases/save_university_student_count.dart'
    as _i267;
import 'package:universities_app/features/universities/presentation/helpers/failure_message_resolver.dart'
    as _i713;
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/layout_cubit/layout_cubit.dart'
    as _i221;
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/universities_bloc/universities_bloc.dart'
    as _i717;
import 'package:universities_app/features/universities/presentation/pages/universities/bloc/university_thumbnails_bloc/university_thumbnails_bloc.dart'
    as _i737;
import 'package:universities_app/features/universities/presentation/pages/universities/university_initials_resolver.dart'
    as _i330;
import 'package:universities_app/features/universities/presentation/pages/university_detail/bloc/university_detail_bloc/university_detail_bloc.dart'
    as _i781;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i221.LayoutCubit>(() => _i221.LayoutCubit());
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i583.GoRouter>(() => registerModule.goRouter);
    gh.lazySingleton<_i183.ImagePicker>(() => registerModule.imagePicker);
    gh.lazySingleton<_i321.AppTheme>(() => const _i321.AppTheme());
    gh.lazySingleton<_i265.HtmlEntityDecoder>(() => _i265.HtmlEntityDecoder());
    gh.lazySingleton<_i129.UniversityIdGenerator>(
      () => const _i129.UniversityIdGenerator(),
    );
    gh.lazySingleton<_i713.FailureMessageResolver>(
      () => const _i713.FailureMessageResolver(),
    );
    gh.lazySingleton<_i330.UniversityInitialsResolver>(
      () => const _i330.UniversityInitialsResolver(),
    );
    gh.lazySingleton<_i814.UniversityExtrasRepository>(
      () => _i759.UniversityExtrasRepositoryImpl(),
    );
    gh.lazySingleton<_i304.ApiClient>(() => _i304.ApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i202.ImagePickerRepository>(
      () => _i354.ImagePickerRepositoryImpl(gh<_i183.ImagePicker>()),
    );
    gh.lazySingleton<_i297.UniversityDtoMapper>(
      () => _i297.UniversityDtoMapper(
        gh<_i265.HtmlEntityDecoder>(),
        gh<_i129.UniversityIdGenerator>(),
      ),
    );
    gh.factory<_i886.PickUniversityImage>(
      () => _i886.PickUniversityImage(gh<_i202.ImagePickerRepository>()),
    );
    gh.factory<_i822.GetAllUniversityExtras>(
      () =>
          _i822.GetAllUniversityExtras(gh<_i814.UniversityExtrasRepository>()),
    );
    gh.factory<_i31.GetUniversityExtras>(
      () => _i31.GetUniversityExtras(gh<_i814.UniversityExtrasRepository>()),
    );
    gh.factory<_i576.SaveUniversityImage>(
      () => _i576.SaveUniversityImage(gh<_i814.UniversityExtrasRepository>()),
    );
    gh.factory<_i267.SaveUniversityStudentCount>(
      () => _i267.SaveUniversityStudentCount(
        gh<_i814.UniversityExtrasRepository>(),
      ),
    );
    gh.lazySingleton<_i127.UniversitiesJsonParser>(
      () => _i127.UniversitiesJsonParser(gh<_i297.UniversityDtoMapper>()),
    );
    gh.factory<_i737.UniversityThumbnailsBloc>(
      () => _i737.UniversityThumbnailsBloc(gh<_i822.GetAllUniversityExtras>()),
    );
    gh.factory<_i379.UniversitiesRemoteDataSource>(
      () => _i379.UniversitiesRemoteDataSourceImpl(
        gh<_i304.ApiClient>(),
        gh<_i127.UniversitiesJsonParser>(),
      ),
    );
    gh.lazySingleton<_i874.UniversitiesRepository>(
      () => _i577.UniversitiesRepositoryImpl(
        gh<_i379.UniversitiesRemoteDataSource>(),
      ),
    );
    gh.factory<_i729.GetUniversitiesPage>(
      () => _i729.GetUniversitiesPage(gh<_i874.UniversitiesRepository>()),
    );
    gh.factory<_i172.GetUniversityById>(
      () => _i172.GetUniversityById(gh<_i874.UniversitiesRepository>()),
    );
    gh.factory<_i717.UniversitiesBloc>(
      () => _i717.UniversitiesBloc(gh<_i729.GetUniversitiesPage>()),
    );
    gh.factory<_i781.UniversityDetailBloc>(
      () => _i781.UniversityDetailBloc(
        gh<_i172.GetUniversityById>(),
        gh<_i31.GetUniversityExtras>(),
        gh<_i576.SaveUniversityImage>(),
        gh<_i267.SaveUniversityStudentCount>(),
        gh<_i886.PickUniversityImage>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i786.RegisterModule {}
