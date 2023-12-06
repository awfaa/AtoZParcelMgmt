// parcel.dart
//awfa
class Parcel {
  String sender;
  int houseNumber;
  DateTime deliveryDate;

  Parcel(this.sender, this.houseNumber) : deliveryDate = DateTime.now();

  @override
  String toString() {
    return 'From: $sender, # $houseNumber';
  }
}
