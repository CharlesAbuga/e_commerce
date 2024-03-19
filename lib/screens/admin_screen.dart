import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  String? selectedCategory = 'Shoes';
  final categoryTextFieldController = TextEditingController();

  List<String> _items = [];
  final sizeController = TextEditingController();

  @override
  void dispose() {
    sizeController.dispose();
    super.dispose();
  }

  void _addItem() {
    final text = sizeController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _items.add(text);
        sizeController.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width >= 600
                    ? MediaQuery.of(context).size.width * 0.2
                    : MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      textAlign: TextAlign.left,
                      'Enter Product',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter product name :',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width >= 600
                    ? MediaQuery.of(context).size.width * 0.2
                    : MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      textAlign: TextAlign.left,
                      'Enter Description of Product :',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      maxLines: 10,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Enter description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width >= 600
                    ? MediaQuery.of(context).size.width * 0.2
                    : MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      textAlign: TextAlign.left,
                      'Enter Price of Product :',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter price',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width >= 600
                    ? MediaQuery.of(context).size.width * 0.2
                    : MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      textAlign: TextAlign.left,
                      'Select Category:',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    DropdownButton<String>(
                      padding: EdgeInsets.all(10),
                      focusColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      iconDisabledColor: Colors.transparent,
                      icon: const Icon(Icons.arrow_drop_down),
                      value: selectedCategory,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategory = newValue;
                        });
                      },
                      items: <String>[
                        'Shoes',
                        'Jeans',
                        'Shirts',
                        'Trousers',
                        'Handbags',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width >= 600
                    ? MediaQuery.of(context).size.width * 0.2
                    : MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: sizeController,
                            decoration:
                                const InputDecoration(hintText: 'Enter size'),
                            onSubmitted: (_) => _addItem(),
                          ),
                        ),
                        IconButton(
                            icon: const Icon(Icons.add), onPressed: _addItem),
                      ],
                    ),
                    Wrap(
                      children: _items
                          .map((item) => Chip(label: Text(item)))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
