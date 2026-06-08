import 'models/app_data_provider_response_model.dart';

abstract class AppBaseMapper {
  AppDataProviderResponseModel toGenericSuccessResponseModel({required dynamic response}) {
    return AppDataProviderResponseModel(success: true, message: null, data: response);
  }

  AppDataProviderResponseModel toGenericFailureResponseModel({
    required String message,
    required dynamic response,
  }) {
    return AppDataProviderResponseModel(success: false, message: null, data: response);
  }
}
