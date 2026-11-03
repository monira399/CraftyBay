
import 'package:craftybay/app/set_up_network_caller.dart';
import 'package:craftybay/core/services/network_caller.dart';
import '../../../../app/urls.dart';

class WishlistService {
  Future<NetworkResponse> getWishlist() async {
    return await getNetworkCaller().getRequest(
      url: Urls.wishListUrl,
    );
  }

  Future<NetworkResponse> addToWishlist(String productId) async {
    return await getNetworkCaller().postRequest(
      url: Urls.wishListUrl,
      body: {
        'product': productId,
      },
    );
  }

  Future<NetworkResponse> removeFromWishlist(
      String wishlistItemId,
      ) async {
    return await getNetworkCaller().deleteRequest(
      url: '${Urls.wishListUrl}/$wishlistItemId',
    );
  }
}
