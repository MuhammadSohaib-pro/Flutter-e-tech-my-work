class PaymentModel {

  final String participentprice;
  final String totalParticipent;
  //final String totaltoPay;
  final String bookingDate;


  PaymentModel({

    required this.participentprice,
    required this.totalParticipent,
    required this.bookingDate,

});

  // Method to convert PaymentModel data to JSON format
  Map<String, dynamic> toJson() {
    return {
      'participentprice': participentprice,
      'totalParticipent': totalParticipent,
      'bookingDate': bookingDate,
      //'totaltoPay': totaltoPay,
    };
  }





}