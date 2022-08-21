class ProductModel {
  String productID, productName, productImage, productDetails;
  num productPrice;
  List<dynamic> productUnit;

  ProductModel({
    required this.productID,
    required this.productName,
    required this.productImage,
    required this.productDetails,
    required this.productPrice,
    required this.productUnit,
  });
}
