import 'package:flutter_test/flutter_test.dart';
import 'package:parcel_mgmt/parcel.dart'; // Update with your actual import path
import 'package:parcel_mgmt/storage.dart'; // Update with your actual import path
import 'package:parcel_mgmt/parcel_management_system.dart'; // Update with your actual import path

void main() {
  testWidgets('Test parcel storage and processing',
      (WidgetTester tester) async {
    // Create a ParcelManagementSystem instance
    ParcelManagementSystem system = ParcelManagementSystem();

    // Test storing parcels
    Parcel parcel1 = Parcel('Sender1', 1);
    Parcel parcel2 = Parcel('Sender2', 5);

    system.storageSlots[0].storeParcel(parcel1);
    system.storageSlots[1].storeParcel(parcel2);

    // Trigger a frame to process the widgets
    await tester.pump();

    // Check if the parcels are stored correctly
    expect(system.storageSlots[0].parcels, contains(parcel1));
    expect(system.storageSlots[1].parcels, contains(parcel2));

    // Test processing parcels after 2 days
    await tester.pump(const Duration(days: 3));

    // Trigger a frame to process the widgets
    await tester.pump();

    // Check if the overdue parcel is returned
    expect(system.storageSlots[0].parcels, isEmpty);
    expect(system.storageSlots[1].parcels, isEmpty);
  });
}
