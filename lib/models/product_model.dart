class ProductModel {
  String productID, productCategory, productName, productImage, productDetails;
  num productPrice;
  List<dynamic> productUnit;

  ProductModel({
    required this.productID,
    required this.productCategory,
    required this.productName,
    required this.productImage,
    required this.productDetails,
    required this.productPrice,
    required this.productUnit,
  });
}
