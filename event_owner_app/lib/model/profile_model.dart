class ProfileModel {
  String? restaurantImage;
  String? restaurantName;
  String? ownerName;
  String? email;
  String? contact;
  String? address;
  String? restaurantDescription;
  String? password;

  ProfileModel(
      {this.restaurantImage,
      this.restaurantName,
      this.password,
      this.address,
      this.contact,
      this.restaurantDescription,
      this.ownerName,
      this.email});
}
