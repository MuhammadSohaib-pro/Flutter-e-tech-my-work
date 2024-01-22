class ManagerModel {
  String? activeOrDeactive;
  String? image;
  String? mangerEmail;
  String? address;
  String? managerName;
  String? contact;
  String? deleteStatus;

  ManagerModel(
      {this.activeOrDeactive,
      this.image,
      this.deleteStatus,
      this.mangerEmail,
      this.address,
      this.managerName,
      this.contact});

  ManagerModel.fromJson(Map<String, dynamic> json) {
    activeOrDeactive = json['activeOrDeactive'];
    image = json['image'];
    deleteStatus = json['deleteStatus'];
    mangerEmail = json['mangerEmail'];
    address = json['address'];
    managerName = json['managerName'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activeOrDeactive'] = activeOrDeactive;
    data['image'] = image;
    data['mangerEmail'] = mangerEmail;
    data['address'] = address;
    data['managerName'] = managerName;
    data['deleteStatus'] = deleteStatus;
    data['contact'] = contact;
    return data;
  }
}
