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
import 'package:injectable/injectable.dart' as _i526;

import '../../data/api/api_client.dart' as _i681;
import '../../data/data_source/online_remote_data_source_implementation.dart'
    as _i525;
import '../../data/repo/repository_implementation.dart' as _i958;
import '../../domain/data_source/online_remote_data_source.dart' as _i602;
import '../../domain/repo/Repository.dart' as _i223;
import '../../domain/use_case/get_all_classes_use_case.dart' as _i690;
import '../../UI/classes_screen/classes_view_model.dart' as _i291;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    gh.singleton<_i681.ApiClient>(() => _i681.ApiClient(gh<_i361.Dio>()));
    gh.factory<_i602.OnlineRemoteDataSource>(
      () => _i525.OnlineRemoteDataSourceImplementation(gh<_i681.ApiClient>()),
    );
    gh.factory<_i223.Repository>(
      () => _i958.RepositoryImplementation(gh<_i602.OnlineRemoteDataSource>()),
    );
    gh.factory<_i690.GetAllClassesUseCase>(
      () => _i690.GetAllClassesUseCase(gh<_i223.Repository>()),
    );
    gh.factory<_i291.CourseViewModel>(
      () => _i291.CourseViewModel(gh<_i690.GetAllClassesUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
