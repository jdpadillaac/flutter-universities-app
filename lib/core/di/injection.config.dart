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
import 'package:injectable/injectable.dart' as _i526;
import 'package:universities_app/core/di/register_module.dart' as _i786;
import 'package:universities_app/core/network/api_client.dart' as _i304;
import 'package:universities_app/core/utils/html_entity_decoder.dart' as _i265;
import 'package:universities_app/features/universities/data/datasources/remote/universities_json_parser.dart'
    as _i127;
import 'package:universities_app/features/universities/data/datasources/remote/universities_remote_datasource.dart'
    as _i379;
import 'package:universities_app/features/universities/data/datasources/remote/university_dto_mapper.dart'
    as _i297;
import 'package:universities_app/features/universities/data/repositories/universities_repository_impl.dart'
    as _i577;
import 'package:universities_app/features/universities/domain/repositories/universities_repository.dart'
    as _i874;
import 'package:universities_app/features/universities/domain/services/university_id_generator.dart'
    as _i129;
import 'package:universities_app/features/universities/domain/usecases/get_universities_page.dart'
    as _i729;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i583.GoRouter>(() => registerModule.goRouter);
    gh.lazySingleton<_i265.HtmlEntityDecoder>(() => _i265.HtmlEntityDecoder());
    gh.lazySingleton<_i129.UniversityIdGenerator>(
      () => const _i129.UniversityIdGenerator(),
    );
    gh.lazySingleton<_i304.ApiClient>(() => _i304.ApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i297.UniversityDtoMapper>(
      () => _i297.UniversityDtoMapper(
        gh<_i265.HtmlEntityDecoder>(),
        gh<_i129.UniversityIdGenerator>(),
      ),
    );
    gh.lazySingleton<_i127.UniversitiesJsonParser>(
      () => _i127.UniversitiesJsonParser(gh<_i297.UniversityDtoMapper>()),
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
    return this;
  }
}

class _$RegisterModule extends _i786.RegisterModule {}
