import './api.dart';
import '../utils/app_utils.dart';
import '../widgets/app_widget.dart';

class ApiServiceConfig {
  static final apiService = ApiService(
    baseUrl: AppEnvInfo.apiBaseUrl,
    defaultHeaders: {
      'Content-Type': 'application/json',
    },
    refreshTokenEndpoint: ApiEndpoints.refreshToken,
    enableLogging: true,
    onRefreshTokenExpired: () {
      // show dialog from here!
      Future.delayed(const Duration(seconds: 1), () {
        if (AppSessionExpired.isOpened == false) {
          AppSessionExpired.showBottomSheet();
        }
      });
    },
  );

  {{#uses_in_app_update_feature}}
  static final iTunesApiService = ApiService.iTunes(
    baseUrl: AppEnvInfo.iTunesBaseUrl,
    defaultHeaders: {
      'Content-Type': 'application/json',
    },
    enableLogging: true,
  );
  {{/uses_in_app_update_feature}}
}
