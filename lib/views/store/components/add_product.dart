import 'package:flutter/material.dart';
import 'package:grocery/core/constants/app_colors.dart';
import 'package:grocery/services/commande_service.dart';
import 'package:grocery/services/product_service.dart';
import 'package:grocery/models/product.dart';
import 'package:grocery/core/config/api_constants.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController fournisseurController = TextEditingController();
  final TextEditingController cinController = TextEditingController();
  List<Product> products = [];
  final List<Map<String, dynamic>> selectedProducts = [];
  String? selectedProduct;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    const apiUrl = '${ApiConstants.baseUrl}/product/products';
    ProductService productService = ProductService(apiUrl: apiUrl);

    try {
      List<Product> fetchedProducts = await productService.fetchProducts();
      setState(() {
        products = fetchedProducts;
      });
    } catch (e) {
      print('Error fetching products: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading products: $e')),
      );
    }
  }

  void _addProduct() {
    if (selectedProduct != null) {
      final product = products.firstWhere((p) => p.id.toString() == selectedProduct);
      setState(() {
        selectedProducts.add({
          'id': product.id,
          'name': product.name, // Ensure name is added for UI display
          'quantity': 1,
        });
        selectedProduct = null; // Reset selection
      });
    }
  }

  void _updateProductQuantity(int index, int quantity) {
    setState(() {
      selectedProducts[index]['quantity'] = quantity;
    });
  }

  void _removeProduct(int index) {
    setState(() {
      selectedProducts.removeAt(index);
    });
  }

  Future<void> _submitAchat() async {
    final fournisseur = fournisseurController.text.trim();
    final cin = cinController.text.trim();

    if (fournisseur.isEmpty || selectedProducts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and add products.')),
      );
      return;
    }

    try {
      final apiUrl = '${ApiConstants.baseUrl}/product/products';
      CommandeService commandeService = CommandeService(apiUrl: apiUrl);
      var commande = {
        'actorName': fournisseur,
        'actorCin': cin.isEmpty ? null : cin,
        //'type': '${widget.type}',
        'products': selectedProducts,
      };
      final result = await commandeService.createCommande(commande);

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product submitted successfully!')),
        );
        Navigator.pop(context, true);
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
        title: const Text(
          'Add Achat',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Commande Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: fournisseurController,
                          decoration: const InputDecoration(
                            labelText: 'Fournisseur',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: cinController,
                          decoration: const InputDecoration(
                            labelText: 'CIN (Optional)',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Products',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: selectedProduct,
                                onChanged: (value) {
                                  setState(() {
                                    selectedProduct = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Select a Product',
                                  border: OutlineInputBorder(),
                                ),
                                items: products
                                    .map((product) => DropdownMenuItem(
                                  value: product.id.toString(),
                                  child: Text(product.name),
                                ))
                                    .toList(),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: _addProduct,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                              ),
                              child: const Text('Add'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        selectedProducts.isEmpty
                            ? Center(
                          child: Text(
                            'No products added yet.',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        )
                            : Column(
                          children: selectedProducts
                              .map((product) {
                            int index = selectedProducts.indexOf(product);
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                title: Text(product['name']),
                                subtitle: Row(
                                  children: [
                                    const Text('Quantity: '),
                                    SizedBox(
                                      width: 60,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          isDense: true,
                                          contentPadding:
                                          EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        ),
                                        controller: TextEditingController(
                                          text: product['quantity'].toString(),
                                        ),
                                        onChanged: (value) {
                                          final int? newQuantity = int.tryParse(value);
                                          if (newQuantity != null) {
                                            _updateProductQuantity(index, newQuantity);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _removeProduct(index),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 75),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: _submitAchat,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
