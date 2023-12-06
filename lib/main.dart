import 'dart:io';
import 'parcel.dart';
import 'storage.dart';
import 'parcel_management_system.dart';

void main() {
  ParcelManagementSystem system = ParcelManagementSystem();

  while (true) {
    print('\nOptions:');
    print('1. Store Parcel');
    print('2. Collect Parcel');
    print('3. View Parcels');
    print('4. Exit');
    stdout.write('Enter your choice (1-4): ');

    String input = stdin.readLineSync() ?? '';
    switch (input) {
      case '1':
        storeParcel(system);
        break;
      case '2':
        collectParcel(system);
        break;
      case '3':
        viewParcels(system);
        break;
      case '4':
        exit(0);
      default:
        print('Invalid choice. Please enter a number between 1 and 4.');
    }
  }
}

//awfa
void storeParcel(ParcelManagementSystem system) {
  stdout.write('Enter sender name: ');
  String sender = stdin.readLineSync() ?? '';

  stdout.write('Enter house number: ');
  int houseNumber = int.parse(stdin.readLineSync() ?? '');

  Parcel parcel = Parcel(sender, houseNumber);
  system.storageSlots[houseNumber % 30].storeParcel(parcel);

  print('Storage updated');
}

//izzaty
void collectParcel(ParcelManagementSystem system) {
  stdout.write('Enter house number to collect parcel from: ');
  int houseNumber = int.parse(stdin.readLineSync() ?? '');

  Storage storage = system.storageSlots[houseNumber % 30];
  if (storage.parcels.isNotEmpty) {
    print('Collected parcel: ${storage.parcels.removeAt(0)}');
  } else {
    print('No parcels to collect in Storage $houseNumber.');
  }
}

//jia
void viewParcels(ParcelManagementSystem system) {
  print('\nParcels in Storage:');
  for (int i = 0; i < system.storageSlots.length; i++) {
    print('Storage $i: ${system.storageSlots[i].parcels}');
  }
}
