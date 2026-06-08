import 'package:badargo_task/data/app_base_model.dart';
import 'package:badargo_task/data/clients/remote/firebase_firestore_client.dart';
import 'package:badargo_task/data/clients/remote/remote_data_client.dart';
import 'package:badargo_task/data/local/app_local_data.dart';
import 'package:badargo_task/data/local/local_data_dispatcher.dart';
import 'package:badargo_task/data/repos/home/home_repo_imp.dart';
import 'package:badargo_task/utils/app_permission_handler.dart';
import 'package:badargo_task/utils/location_utils.dart';
import 'package:get_it/get_it.dart';

import 'data/clients/local/local_db_data_client.dart';
import 'data/repos/home/home_repo.dart';
import 'data/repos/local_data/local_data_repo.dart';
import 'data/repos/local_data/local_data_repo_imp.dart';
import 'data/repos/remote_data/remote_data_repo.dart';
import 'data/repos/remote_data/remote_data_repo_imp.dart';

class AppDi {
  static Future<void> initDi() async {
    GetIt.I.registerSingleton<RemoteDataClient>(FirebaseFirestoreClient());
    GetIt.I.registerSingleton<LocalDataDispatcher>(AppLocalData());
    GetIt.I.registerSingleton<LocationUtils>(LocationUtils());
    GetIt.I.registerSingleton<AppPermissionHandler>(AppPermissionHandler());
    GetIt.I.registerSingleton<HomeRepo>(HomeRepoImp(GetIt.I.get<LocalDataDispatcher>()));
    GetIt.I.registerSingleton<LocalDataRepo>(LocalDataRepoImp(LocalDbDataClient()));
    GetIt.I.registerSingleton<RemoteDataRepo>(RemoteDataRepoImp(GetIt.I.get<RemoteDataClient>()));
    GetIt.I.registerSingleton<AppBaseModel>(AppBaseModel());
    await GetIt.I.allReady();
  }
}
