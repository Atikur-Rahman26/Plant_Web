class SellPostsData {
  String plantName;
  String date;
  String location;
  String upzilla;
  String district;
  String division;
  double price;
  String plantImage;
  String note;
  String sellerID;
  String sellerName;
  String plantID;
  int totalPlants;
  int soldPlants;
  SellPostsData(
      {required this.plantName,
      required this.plantID,
      required this.plantImage,
      required this.date,
      required this.location,
      required this.upzilla,
      required this.district,
      required this.division,
      required this.price,
      required this.note,
      required this.soldPlants,
      required this.totalPlants,
      required this.sellerName,
      required this.sellerID});
  Map<String, dynamic> toMap() {
    return {
      'plantName': plantName,
      'plantID': plantID,
      'date': date,
      'location': location,
      'upzilla': upzilla,
      'district': district,
      'division': division,
      'price': price,
      'note': note,
      'soldPlants': soldPlants,
      'totalPlants': totalPlants,
      'sellerName': sellerName,
      'sellerID': sellerID,
      // Add other fields as needed
    };
  }
}
