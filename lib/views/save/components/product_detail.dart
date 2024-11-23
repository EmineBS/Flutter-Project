import 'package:flutter/material.dart';
import 'package:grocery/models/commande.dart';
import 'package:grocery/core/constants/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:grocery/core/config/api_constants.dart';
import 'package:grocery/services/commande_service.dart';
import 'package:grocery/models/commande.dart';

class CommandeDetailScreen extends StatelessWidget {
  final Commande commande;

  const CommandeDetailScreen({
    Key? key,
    required this.commande,
  }) : super(key: key);

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  Future<void> deleteCommande(BuildContext context, int id) async {
    const apiUrl = '${ApiConstants.baseUrl}/commande/commandes';
    CommandeService commandeService = CommandeService(apiUrl: apiUrl);

    try {
      await commandeService.deleteCommande(id);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Commande deleted successfully!')),
      );
      Navigator.pop(context, true);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete commande, Retry Again!')),
      );
    }
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            capitalize(label),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
        title: const Text(
          'Achat Detail',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            onPressed: () {
              // Action for search button
              print('Search button pressed');
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        commande.actorName.toUpperCase() ?? 'Retail',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Date: ${DateFormat('yyyy-MM-dd HH:mm').format(commande.createdAt)}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 28,
                    ),
                    onPressed: () async {
                      // Call the delete function and await it
                      await deleteCommande(context, commande.id);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Details Section
        Column(
          children: [
            // Loop through products and create individual Containers for each
            ...commande.products.map((product) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(
                          'Product',
                          product.name[0].toUpperCase() + product.name.substring(1),
                        ),
                        const Divider(height: 1),
                        _buildInfoRow(
                          'Quantity',
                          '${product.quantity ?? 'N/A'}',
                        ),
                        const Divider(height: 1),
                        _buildInfoRow(
                          'Price per gros',
                          '${product.priceWholesale ?? 'N/A'}',
                        ),
                        const Divider(height: 1),
                        _buildInfoRow(
                          'Price per detail',
                          '${product.pricePerDetail ?? 'N/A'}',
                        ),
                        const Divider(height: 1),
                        _buildInfoRow(
                          'Buy Date',
                          DateFormat('yyyy-MM-dd').format(product.buyDate),
                        ),
                        const Divider(height: 1),
                        _buildInfoRow(
                          'Expire Date',
                          DateFormat('yyyy-MM-dd').format(product.expireDate),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8), // Space between products
                ],
              );
            }).toList(),

            // Commande details in a separate Container
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                    'Created At',
                    DateFormat('yyyy-MM-dd HH:mm:ss').format(commande.createdAt),
                  ),
                  const Divider(height: 1),
                  _buildInfoRow(
                    'Updated At',
                    DateFormat('yyyy-MM-dd HH:mm:ss').format(commande.updatedAt),
                  ),
                ],
              ),
            ),
          ],
        ),

        ],
        ),
      ),
    );
  }
}
