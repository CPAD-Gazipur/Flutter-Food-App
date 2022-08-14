class CartModel {
  String cartID;
  String cartName;
  String cartImage;
  num cartPrice;
  int cartQuantity;

  CartModel({
    required this.cartID,
    required this.cartName,
    required this.cartImage,
    required this.cartPrice,
    required this.cartQuantity,
  });
}
