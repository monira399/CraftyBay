
import 'package:craftybay/app/set_up_network_caller.dart';
import 'package:craftybay/app/urls.dart';
import 'package:craftybay/core/services/network_caller.dart';

class ProfileService {

  // Get Profile
  static Future<NetworkResponse> getProfile() async {
    final NetworkResponse response =
    await getNetworkCaller().getRequest(
      url: Urls.getProfileUrl,
    );

    return response;
  }

  // Update Profile
  static Future<NetworkResponse> updateProfile({
    required Map<String, dynamic> body,
  }) async {
    final NetworkResponse response =
    await getNetworkCaller().patchRequest(
      url: Urls.updateProfileUrl,
      body: body,
    );

    return response;
  }
}
