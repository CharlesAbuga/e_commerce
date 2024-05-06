import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:product_repository/product_repository.dart';

class AdminUpdatePage extends StatefulWidget {
  const AdminUpdatePage({super.key});
  @override
  State<AdminUpdatePage> createState() => _AdminUpdatePageState();
}

class _AdminUpdatePageState extends State<AdminUpdatePage> {
  final TextEditingController quantityController = TextEditingController();
  final Map<String, TextEditingController> _sizeControllers = {};
  final Map<String, TextEditingController> _colorControllers = {};
  final Map<String, List<String>> _itemsColor = {};
  final Map<String, List<String>> _itemsSize = {};
  List<Product> products = [];

  @override
  void dispose() {
    for (var controller in _sizeControllers.values) {
      controller.dispose();
    }
    for (var controller in _colorControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addSize(String productId) {
    final text = _sizeControllers[productId]!.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _itemsSize.putIfAbsent(productId, () => <String>[]);
        _itemsSize[productId]!.add(text);
        _sizeControllers[productId]!.text = '';

        FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .update({
          'size': FieldValue.arrayUnion([text])
        });
      });
    }
  }

  void _addColor(String productId) {
    final text = _colorControllers[productId]!.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _itemsColor.putIfAbsent(productId, () => <String>[]);
        _itemsColor[productId]!.add(text);
        _colorControllers[productId]!.text = '';

        FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .update({
          'color': FieldValue.arrayUnion([text])
        });
      });
    }
  }

  void _fetchProducts() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('products').get();
    final products = querySnapshot.docs
        .map(
            (doc) => Product.fromEntity(ProductEntity.fromDocument(doc.data())))
        .toList();
    for (var product in products) {
      _itemsSize[product.productId] = [];
      _sizeControllers[product.productId] = TextEditingController();
      _itemsColor[product.productId] = [];
      _colorControllers[product.productId] = TextEditingController();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Update'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('products').snapshots(),
            builder: (context, snapshot) {
              try {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
              } on FirebaseException catch (e) {
                return Text(e.toString());
              }
              if (snapshot.hasData) {
                final products = snapshot.data!.docs
                    .map((doc) => Product.fromEntity(ProductEntity.fromDocument(
                        doc.data() as Map<String, dynamic>)))
                    .toList();
                return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Card(
                          child: Column(
                        children: [
                          ListTile(
                            leading: Image.network(product.imageUrl[0]),
                            title: Text(product.name),
                            subtitle: Text('Price: ${product.price}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text('Quantity: ${product.stock}'),
                                const SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                  tooltip: 'Click to add Quantity',
                                  iconSize: 14,
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('products')
                                        .doc(product.productId)
                                        .update(
                                            {'stock': FieldValue.increment(1)});
                                  },
                                  icon: const Icon(CupertinoIcons.add),
                                ),
                                IconButton(
                                  tooltip: 'Click to subtract Quantity',
                                  iconSize: 14,
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('products')
                                        .doc(product.productId)
                                        .update({
                                      'stock': FieldValue.increment(-1)
                                    });
                                  },
                                  icon: const Icon(CupertinoIcons.minus),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CupertinoTextField(
                                        placeholder: 'Add Size',
                                        padding: const EdgeInsets.all(10),
                                        controller:
                                            _sizeControllers[product.productId],
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 0.5,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        onSubmitted: (_) =>
                                            _addSize(product.productId),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CupertinoTextField(
                                        placeholder: 'Add Color',
                                        padding: const EdgeInsets.all(10),
                                        controller: _colorControllers[
                                            product.productId],
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 0.5,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        onSubmitted: (_) =>
                                            _addColor(product.productId),
                                      ),
                                    ),
                                  ),
                                  Wrap(
                                    children: _itemsColor[product.productId]!
                                        .map((item) => Chip(label: Text(item)))
                                        .toList(),
                                  ),
                                  IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () =>
                                          _addSize(product.productId)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ));
                    });
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}
