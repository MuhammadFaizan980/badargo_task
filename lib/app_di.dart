import 'package:badargo_task/data/app_base_model.dart';
import 'package:badargo_task/data/repos/home/home_repo_imp.dart';
import 'package:badargo_task/utils/app_permission_handler.dart';
import 'package:badargo_task/utils/location_utils.dart';
import 'package:get_it/get_it.dart';

import 'data/repos/home/home_repo.dart';

class AppDi {
  static Future<void> initDi() async {
    GetIt.I.registerSingleton<LocationUtils>(LocationUtils());
    GetIt.I.registerSingleton<AppBaseModel>(AppBaseModel());
    GetIt.I.registerSingleton<AppPermissionHandler>(AppPermissionHandler());
    GetIt.I.registerSingleton<HomeRepo>(HomeRepoImpHomeRepo());
    await GetIt.I.allReady();
  }
}
