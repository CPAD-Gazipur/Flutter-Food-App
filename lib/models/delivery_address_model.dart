class DeliveryAddressModel {
  String uID;
  String name;
  String phoneNumber;
  String altPhoneNumber;
  String streetAddress;
  String zipCode;
  String city;
  String addressType;
  String latitude;
  String longitude;

  DeliveryAddressModel({
    required this.uID,
    required this.name,
    required this.phoneNumber,
    required this.altPhoneNumber,
    required this.streetAddress,
    required this.zipCode,
    required this.city,
    required this.addressType,
    required this.latitude,
    required this.longitude,
  });
}
