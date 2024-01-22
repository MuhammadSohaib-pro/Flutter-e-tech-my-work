class ItemModel {
  String? itemName;
  double? itemPrice;
  String? itemImage;
  String? itemDescription;
  String? selectedCategoryDoc;

  ItemModel(
      {this.itemName,
      this.itemPrice,
      this.itemImage,
      this.itemDescription,
      this.selectedCategoryDoc});

  ItemModel.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    itemPrice = json['itemPrice'];
    itemImage = json['itemImage'];
    itemDescription = json['itemDescription'];
    selectedCategoryDoc = json['selectedCategoryDoc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemName'] = itemName;
    data['itemPrice'] = itemPrice;
    data['itemImage'] = itemImage;
    data['itemDescription'] = itemDescription;
    data['selectedCategoryDoc'] = selectedCategoryDoc;
    return data;
  }
}
