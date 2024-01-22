class BranchModel {
  String? activeOrDeactive;
  String? password;
  String? address;
  String? managerDocId;
  String? contact;
  String? managerName;
  String? email;
  String? name;

  BranchModel(
      {this.activeOrDeactive,
      this.password,
      this.address,
      this.managerDocId,
      this.contact,
      this.managerName,
      this.name,
      this.email});

  BranchModel.fromJson(Map<String, dynamic> json) {
    activeOrDeactive = json['activeOrDeactive'];
    password = json['password'];
    address = json['address'];
    managerDocId = json['managerDocId'];
    contact = json['contact'];
    managerName = json['managerName'];
    email = json['email'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['activeOrDeactive'] = activeOrDeactive;
    data['password'] = password;
    data['address'] = address;
    data['managerDocId'] = managerDocId;
    data['contact'] = contact;
    data['managerName'] = managerName;
    data['email'] = email;
    data['name'] = name;
    return data;
  }
}
