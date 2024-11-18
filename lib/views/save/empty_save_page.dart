import 'dart:math';
import 'package:flutter/material.dart';
import 'package:grocery/core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';

class EmptySavePage extends StatelessWidget {
  const EmptySavePage({super.key});

  // Function to generate random data for the table
  String generateRandomString(int length) {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }

  // Function to generate random price
  String generateRandomPrice() {
    Random random = Random();
    double price = random.nextDouble() * 100; // Random price between 0 and 100
    return price.toStringAsFixed(2); // Format as string with two decimals
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    double nameColumnWidth = screenWidth * 0.20;
    double prixDColumnWidth = screenWidth * 0.175;
    double prixGColumnWidth = screenWidth * 0.175;
    double DateAColumnWidth = screenWidth * 0.175;
    double DateEColumnWidth = screenWidth * 0.175;

    return Scaffold(
      appBar: AppBar(title: const Text("Empty Save Page")),
      body: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity, // Ensure the table takes up full width
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Table(
                  border: TableBorder.all(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20))),
                  columnWidths: {
                    0: FixedColumnWidth(nameColumnWidth),
                    1: FixedColumnWidth(prixDColumnWidth),
                    2: FixedColumnWidth(prixGColumnWidth),
                    3: FixedColumnWidth(DateAColumnWidth),
                    4: FixedColumnWidth(DateEColumnWidth),
                  },
                  children: [
                    // Header Row
                    TableRow(
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'PrixD',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'PrixG',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'DA',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'DE',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Data Row 1
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(generateRandomString(6)),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(generateRandomString(8)),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(generateRandomPrice()),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(generateRandomPrice()),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(generateRandomPrice()),
                          ),
                        ),
                      ],
                    ),
                    // Data Row 2
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(generateRandomString(6)),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(generateRandomString(8)),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(generateRandomPrice()),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(generateRandomPrice()),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(generateRandomPrice()),
                          ),
                        ),
                      ],
                    ),
                    // Data Row 3
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(generateRandomString(6)),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(generateRandomString(8)),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(generateRandomPrice()),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(generateRandomPrice()),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(generateRandomPrice()),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Start Achat Button
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(AppDefaults.padding * 2),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Start Achat'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
