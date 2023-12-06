// parcel_management.dart
import 'package:flutter/material.dart';
import 'storage.dart';
import 'parcel.dart';

class ParcelManagement extends StatefulWidget {
  @override
  _ParcelManagementState createState() => _ParcelManagementState();
}

class _ParcelManagementState extends State<ParcelManagement> {
  Storage storage = Storage();
  TextEditingController senderController = TextEditingController();
  TextEditingController recipientController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController dateSentController = TextEditingController();

  void showStorageFullDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Storage Full'),
          content: Text('The storage is full. Cannot store more parcels.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parcel Management'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: senderController,
                decoration: InputDecoration(labelText: 'Sender Name'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: recipientController,
                decoration: InputDecoration(labelText: 'Recipient Name'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: houseNumberController,
                decoration: InputDecoration(labelText: 'House Number'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: dateSentController,
                decoration:
                    InputDecoration(labelText: 'Date Sent (YYYY-MM-DD)'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Example of storing a parcel
                  String sender = senderController.text;
                  String recipient = recipientController.text;
                  int houseNumber =
                      int.tryParse(houseNumberController.text) ?? 0;
                  String dateSentString = dateSentController.text;

                  if (sender.isNotEmpty &&
                      recipient.isNotEmpty &&
                      houseNumber > 0 &&
                      dateSentString.isNotEmpty) {
                    DateTime dateSent = DateTime.parse(dateSentString);

                    Parcel newParcel = Parcel(
                      sender: sender,
                      recipient: recipient,
                      houseNumber: houseNumber,
                      storageDate: DateTime.now(),
                      dateSent: dateSent,
                    );

                    bool success = storage.storeParcel(newParcel);

                    if (success) {
                      print('Parcel stored successfully!');
                      setState(() {});
                    } else {
                      print('Storage is full. Cannot store parcel.');
                      showStorageFullDialog(context);
                    }
                  } else {
                    print('Please enter valid parcel details.');
                  }
                },
                child: Text('Store Parcel'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Remove expired parcels
                  storage.removeExpiredParcelsBasedOnInputDate(DateTime.now());
                  print('Expired parcels removed.');
                  await Future.delayed(Duration(
                      milliseconds: 300)); // Delay to ensure proper removal
                  setState(() {});
                },
                child: Text('Remove Expired Parcels'),
              ),
              SizedBox(height: 20),
              Text('Stored Parcels:'),
              Container(
                // Wrap ListView.builder with a Container
                height: 300, // Provide a fixed height
                child: ListView.builder(
                  itemCount: storage.getHouseNumbersWithParcels().length,
                  itemBuilder: (context, index) {
                    int houseNumber =
                        storage.getHouseNumbersWithParcels()[index];
                    List<Parcel> parcels =
                        storage.getParcelsByHouseNumber(houseNumber);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('House Number: $houseNumber'),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: parcels.length,
                          itemBuilder: (context, index) {
                            Parcel parcel = parcels[index];
                            return ListTile(
                              title: Text(
                                'Sender: ${parcel.sender}, Recipient: ${parcel.recipient}',
                              ),
                              subtitle: Text(
                                'Date Sent: ${parcel.dateSent.toString()}, Storage Date: ${parcel.storageDate.toString()}',
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                  'House Numbers without Parcels: ${storage.getHouseNumbersWithoutParcels()}'),
            ],
          ),
        ),
      ),
    );
  }
}
