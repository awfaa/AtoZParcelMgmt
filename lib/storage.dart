// storage.dart
//awfa
import 'parcel.dart';

class Storage {
  Map<int, List<Parcel>> parcelsByHouse =
      {}; // Map of house numbers to list of parcels

  get parcels => null;

  bool storeParcel(Parcel parcel) {
    if (parcelsByHouse.containsKey(parcel.houseNumber)) {
      // Check if the storage limit for the house is reached
      if (parcelsByHouse[parcel.houseNumber]!.length < 5) {
        parcelsByHouse[parcel.houseNumber]!.add(parcel);
        return true;
      }
    } else {
      // Initialize the list for the house if it doesn't exist
      parcelsByHouse[parcel.houseNumber] = [parcel];
      return true;
    }
    return false;
  }

  List<Parcel> getParcelsByHouseNumber(int houseNumber) {
    return parcelsByHouse[houseNumber] ?? [];
  } // Return empty list if house number does not exist

  List<int> getHouseNumbersWithParcels() {
    return parcelsByHouse.keys.toList();
  } // Return empty list if no parcels are stored

  List<int> getHouseNumbersWithoutParcels() {
    List<int> allHouseNumbers = List.generate(30, (index) => index + 1);
    List<int> houseNumbersWithParcels = getHouseNumbersWithParcels();
    return allHouseNumbers
        .where((number) => !houseNumbersWithParcels.contains(number))
        .toList();
  } // Return empty list if all houses have parcels

// Nurul Izzaty Binti Muhammad Aris 2022876
  void removeExpiredParcels() {
    parcelsByHouse.forEach((houseNumber, parcels) {
      parcels.removeWhere((parcel) {
        return DateTime.now().difference(parcel.dateSent).inDays > 2;
      });
    });
  }

  void removeExpiredParcelsBasedOnInputDate(DateTime currentDate) {
    parcelsByHouse.forEach((houseNumber, parcels) {
      parcels.removeWhere((parcel) {
        return currentDate.difference(parcel.dateSent).inDays > 2;
      });
    });
  }
}
