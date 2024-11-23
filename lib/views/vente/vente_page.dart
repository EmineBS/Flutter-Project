import 'package:flutter/material.dart';
import 'package:grocery/core/constants/app_colors.dart';


class VentePage extends StatefulWidget {
  const VentePage({super.key});

  @override
  _VentePageState createState() => _VentePageState();

}

class _VentePageState extends State<VentePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    // Action for panier icon
                  },
                  icon: const Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                  ),
                ),
                //const SizedBox(width: 8),
                Text(
                  'Vente',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                // Action for search button
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),

      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Vente Details Form Here'),
      // Add form fields here for creating or editing a commande
          ],
        ),
      ),
    );
  }
  }