import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Routes/router_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List searchResults = [];
  TextEditingController searchController = TextEditingController();
  List allResults = [];
  FocusNode searchFocusNode = FocusNode();

  getSearchResults() async {
    try {
      final results = await FirebaseFirestore.instance
          .collection('products')
          .orderBy('name')
          .get();

      setState(() {
        allResults = results.docs;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      _onSearchChanged();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchFocusNode.requestFocus();
    });
  }

  @override
  void didChangeDependencies() {
    getSearchResults();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
  }

  _onSearchChanged() {
    if (searchController.text != "" && searchResults != allResults) {
      searchResultList();
    }
  }

  searchResultList() {
    var showResult = [];
    if (searchController.text != "") {
      for (var product in allResults) {
        var name = product['name'].toString().toLowerCase();
        if (name.contains(searchController.text.toLowerCase())) {
          showResult.add(product);
        }
      }
    } else {
      showResult = allResults;
    }
    setState(() {
      searchResults = showResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: SizedBox(
                height: 35,
                child: CupertinoTextField(
                  cursorHeight: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  controller: searchController,
                  focusNode: searchFocusNode,
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final product = searchResults[index];
                    return GestureDetector(
                      child: GestureDetector(
                        onTap: () {
                          GoRouter.of(context).pushNamed(RouteConstants.details,
                              pathParameters: {
                                'productId': product['productId']
                              },
                              extra: product);
                        },
                        child: ListTile(
                          leading: Image.network(product['imageUrl'][0]),
                          title: Text(product['name']),
                          subtitle: Text(product['price'].toString()),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
