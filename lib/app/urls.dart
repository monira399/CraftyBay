class Urls {
  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';
  
  static const String signUpUrl = '$_baseUrl/auth/signup';

  static const String verifyOtpUrl = '$_baseUrl/auth/verify-otp';

  static const String signInUrl = '$_baseUrl/auth/login';
  static const String homeSliderUrl = '$_baseUrl/slides';

  static String categoryListUrl(int pageSize, int pageNo) =>
      '$_baseUrl/categories?count=$pageSize&page=$pageNo';

  static String productByCategoryUrl (
      int pageSize,
      int pageNo,
      String categoryId,
      ) => '$_baseUrl/products?count=$pageSize&page=$pageNo&category=$categoryId';

  static String productDetailsUrl(String productId) =>
      '$_baseUrl/product/id/$productId';

  static const String addToCartUrl = '$_baseUrl/cart' ;
}
