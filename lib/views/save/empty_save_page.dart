import 'dart:math';
import 'package:flutter/material.dart';
import 'package:grocery/core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';
import 'package:grocery/services/commande_service.dart';
import 'package:grocery/models/commande.dart';
import 'package:grocery/core/config/api_constants.dart';
import 'components/product_detail.dart';
import 'package:intl/intl.dart';
import 'achats_page.dart';
import 'components/add_achat.dart';

class EmptySavePage extends StatefulWidget {
  const EmptySavePage({super.key});

  @override
  _EmptySavePageState createState() => _EmptySavePageState();
}

class _EmptySavePageState extends State<EmptySavePage> {
  List<Commande> _commandes = [];
  bool _isLoading = true;

  Future<void> getCategoryProducts() async {
    try {
      const apiUrl = '${ApiConstants.baseUrl}/commande/commandes';
      CommandeService commandeService = CommandeService(apiUrl: apiUrl);
      final result = await commandeService.fetchCommandes();

      if (result.isNotEmpty) {
        setState(() {
          _commandes = result;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching category products: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCategoryProducts();
  }

  void _navigateToDetail(Commande commande) async {
    // Wait for the result from the CommandeDetailScreen (whether it's success or failure)
    bool? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommandeDetailScreen(commande: commande),
      ),
    );

    // Only proceed if the result is not null (success/failure)
    if (result == true) {
      getCategoryProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                ),
                //const SizedBox(width: 8),
                Text(
                  'Achat',
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
      body: Stack(
        children: [
          // Main body content (including list and other widgets)
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
            children: [
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    hintText: 'Products, Dates, Fournisseurs, ...',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  isExpanded: true,
                  value: null, // No default value
                  onChanged: (String? newValue) {
                    // Handle selection changes
                  },
                  items: <String>['Products', 'Dates', 'Fournisseurs', 'Categories']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                height: 1,
                color: Colors.grey.shade300,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              // ListView with items
              AchatsList(
                commandes: _commandes,
                onNavigateToDetail: _navigateToDetail,
              ),
            ],
          ),
          // Fixed Floating Button
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () async {
                bool? result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddAchatScreen(),
                  ),
                );

                if (result == true) {
                  // Trigger refresh of commandes
                  await getCategoryProducts(); // Replace this with your actual method to refresh the commandes
                }
              },
              backgroundColor: AppColors.primary, // Your custom color
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
