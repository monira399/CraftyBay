class ShippingAddressModel {
  final String fullName;
  final String address;
  final String city;
  final String postalCode;
  final String phone;

  ShippingAddressModel({
    required this.fullName,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.phone,
  });

  factory ShippingAddressModel.fromJson(
      Map<String, dynamic> json) {
    return ShippingAddressModel(
      fullName: json['full_name'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      postalCode: json['postal_code'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'address': address,
      'city': city,
      'postal_code': postalCode,
      'phone': phone,
    };
  }
}