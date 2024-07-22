import 'package:coffee_new_app/components/manager_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/coffee.dart';
import '../model/coffee_shop.dart';

class CoffeeManager extends StatefulWidget {
  @override
  _CoffeeManagerState createState() => _CoffeeManagerState();
}

class _CoffeeManagerState extends State<CoffeeManager> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  void dispose() {
    productNameController.dispose();
    productPriceController.dispose();
    imageController.dispose();
    super.dispose();
  }

  void addItem() {
    if (productNameController.text.isNotEmpty &&
        productPriceController.text.isNotEmpty &&
        imageController.text.isNotEmpty) {
      final newCoffee = Coffee(
        name: productNameController.text,
        price: double.parse(productPriceController.text),
        imagePath: 'lib/images/${imageController.text}',
      );
      Provider.of<CoffeeShop>(context, listen: false).add(newCoffee);
      productNameController.clear();
      productPriceController.clear();
      imageController.clear();
    }
  }

  void removeItemFromCart(Coffee coffee) {
    Provider.of<CoffeeShop>(context, listen: false).removeFromCart(coffee);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Manager'),
      ),
      body: Consumer<CoffeeShop>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 25.0, top: 25, bottom: 25),
                  child: Text('Manage Products', style: TextStyle(fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: productNameController,
                        decoration: const InputDecoration(labelText: 'Product Name'),
                      ),
                      TextField(
                        controller: productPriceController,
                        decoration: const InputDecoration(labelText: 'Product Price'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: imageController,
                        decoration: const InputDecoration(labelText: 'Image URL', prefixText: 'lib/images/'),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: addItem,
                        child: const Text('Add Product'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text('Cart Items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.coffeeShop.length,
                  itemBuilder: (context, index) {
                    Coffee coffee = value.coffeeShop[index];
                    return ManagerTile(
                      coffee: coffee,
                      onPressed: () => removeItemFromCart(coffee),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
