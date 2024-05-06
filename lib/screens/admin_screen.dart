import 'dart:developer';

import 'package:ecommerce_app/bloc/create_product_bloc/create_product_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';
import 'package:uuid/uuid.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late Product product;
  String? selectedCategory = 'Shoes';
  final categoryTextFieldController = TextEditingController();
  String? selectedAgeGroup = 'Adults';
  final ageGroupTextFieldController = TextEditingController();
  String? selectedGender = 'Male';
  final genderTextFieldController = TextEditingController();
  final nameTextFieldController = TextEditingController();
  final descriptionTextFieldController = TextEditingController();
  final priceTextFieldController = TextEditingController();
  final stockTextFieldController = TextEditingController();

  final List<String> _itemsSize = [];
  final List<String> _itemsColor = [];

  final sizeController = TextEditingController();
  final colorController = TextEditingController();
  bool isHovering = true;
  List<PlatformFile?> imageFile = [];
  List<Uint8List> files = [];

  Future<void> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: true);

      if (result != null) {
        setState(() {
          imageFile = result.files;
          files = imageFile.map((e) => e!.bytes!).toList();
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void dispose() {
    sizeController.dispose();
    colorController.dispose();
    super.dispose();
  }

  void _addSize() {
    final text = sizeController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _itemsSize.add(text);
        sizeController.text = '';
      });
    }
  }

  void _addColor() {
    final text = colorController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _itemsColor.add(text);
        colorController.text = '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    product = Product.empty;
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
              SizedBox(
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
                      controller: nameTextFieldController,
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
              SizedBox(
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
                      controller: descriptionTextFieldController,
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
              SizedBox(
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
                      controller: priceTextFieldController,
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
              SizedBox(
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
                      padding: const EdgeInsets.all(10),
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
                        'Clothes',
                        'Accessories',
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
              SizedBox(
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
                            onSubmitted: (_) => _addSize(),
                          ),
                        ),
                        IconButton(
                            icon: const Icon(Icons.add), onPressed: _addSize),
                      ],
                    ),
                    Wrap(
                      children: _itemsSize
                          .map((item) => Chip(label: Text(item)))
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: MediaQuery.of(context).size.width >= 600
                    ? MediaQuery.of(context).size.width * 0.2
                    : MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: colorController,
                            decoration:
                                const InputDecoration(hintText: 'Enter color'),
                            onSubmitted: (_) => _addColor(),
                          ),
                        ),
                        IconButton(
                            icon: const Icon(Icons.add), onPressed: _addColor),
                      ],
                    ),
                    Wrap(
                      children: _itemsColor
                          .map((item) => Chip(label: Text(item)))
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: MediaQuery.of(context).size.width >= 600
                    ? MediaQuery.of(context).size.width * 0.2
                    : MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      textAlign: TextAlign.left,
                      'Enter number of Products :',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: stockTextFieldController,
                      decoration: InputDecoration(
                        hintText: 'Enter number',
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
              SizedBox(
                width: MediaQuery.of(context).size.width >= 600
                    ? MediaQuery.of(context).size.width * 0.2
                    : MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      textAlign: TextAlign.left,
                      'Select Age group:',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    DropdownButton<String>(
                      padding: const EdgeInsets.all(10),
                      focusColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      iconDisabledColor: Colors.transparent,
                      icon: const Icon(Icons.arrow_drop_down),
                      value: selectedAgeGroup,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedAgeGroup = newValue;
                        });
                      },
                      items: <String>[
                        'Teens',
                        'Adults',
                        'Children',
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
              SizedBox(
                width: MediaQuery.of(context).size.width >= 600
                    ? MediaQuery.of(context).size.width * 0.2
                    : MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      textAlign: TextAlign.left,
                      'Select Gender:',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    DropdownButton<String>(
                      padding: const EdgeInsets.all(10),
                      focusColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      iconDisabledColor: Colors.transparent,
                      icon: const Icon(Icons.arrow_drop_down),
                      value: selectedGender,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGender = newValue;
                        });
                      },
                      items: <String>[
                        'Male',
                        'Female',
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
              AnimatedContainer(
                duration: const Duration(seconds: 2),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: isHovering
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.tertiary,
                  ),
                  onHover: (isHovering) {
                    setState(() {
                      this.isHovering = !isHovering;
                    });
                  },
                  onPressed: pickImage,
                  child: const Text(
                    'Add Images',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width > 500
                    ? MediaQuery.of(context).size.width / 5
                    : MediaQuery.of(context).size.width * 0.8,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.memory(
                        width: 100,
                        height: 100,
                        files[index],
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () async {
                  List<String> downloadUrls = [];
                  for (var file in files) {
                    Reference ref = FirebaseStorage.instance.ref(
                        '/product_images/${product.productId}/${const Uuid().v1()}');
                    await ref.putData(file);
                    String downloadUrl = await ref.getDownloadURL();
                    downloadUrls.add(downloadUrl);
                  }
                  setState(() {
                    product.name = nameTextFieldController.text;
                    product.description = descriptionTextFieldController.text;
                    product.price = double.parse(priceTextFieldController.text);
                    product.category = selectedCategory!;
                    product.size = _itemsSize;
                    product.color = _itemsColor;
                    product.ageGroup = selectedAgeGroup!;
                    product.imageUrl = downloadUrls;
                    product.gender = selectedGender!;
                    product.stock = int.parse(stockTextFieldController.text);
                  });
                  context.read<CreateProductBloc>().add(CreateProduct(product));
                },
                child: const Text(
                  'Post Product',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
