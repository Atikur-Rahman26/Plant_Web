class Carts {
  static String firebaseCartDocumentName = "Carts";
  static String firebaseCartId = "cartId";
  static String firebaseCartPlantName = "plantName";
  static String firebaseCartPlantSellerID = "plantSellerID";
  static String firebaseCartPlantSellerName = "plantSellerName";
  static String firebaseCartPlantImage = "plantImage";
  static String firebaseCartBuyerName = "buyerName";
  static String firebaseCartBuyerId = "buyerId";
  static String firebaseCartPerItemPrice = "perItemPrice";
  static String firebaseCartCurrentSelectItem = "currentSelectItem";
  static String firebaseCartTotalItem = "totalItem";
  static String firebaseCartAvailableItem = "availableItem";

  String cartId;
  String plantName;
  String plantSellerID;
  String plantSellerName;
  String plantImage;
  String buyerName;
  String buyerId;
  double perItemPrice;
  int totalItem;
  int currentSelectItem;
  int availableItem;

  Carts(
      {required this.buyerId,
      required this.buyerName,
      required this.cartId,
      required this.plantName,
      required this.plantSellerID,
      required this.plantSellerName,
      required this.perItemPrice,
      required this.totalItem,
      required this.plantImage,
      required this.currentSelectItem,
      required this.availableItem});
}
