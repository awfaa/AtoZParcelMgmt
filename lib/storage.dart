// storage.dart
//zaty
import 'parcel.dart';

class Storage {
  int capacity = 5;
  List<Parcel> parcels = [];

  bool isFull() {
    return parcels.length >= capacity;
  }

  void storeParcel(Parcel parcel) {
    if (!isFull()) {
      parcels.add(parcel);
      print('Parcel for house ${parcel.houseNumber} stored successfully.');
    } else {
      print('Storage is full. Cannot store more parcels.');
    }
  }

  Parcel collectParcel() {
    if (parcels.isNotEmpty) {
      return parcels.removeAt(0);
    } else {
      print('No parcels in storage.');
      return Parcel('', 0); // Placeholder for no parcel
    }
  }

  @override
  String toString() {
    return 'Parcels in Storage: $parcels';
  }
}
