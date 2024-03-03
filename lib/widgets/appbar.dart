import 'package:flutter/material.dart';

class AppBarMain extends StatefulWidget {
  const AppBarMain({super.key});

  @override
  State<AppBarMain> createState() => _AppBarMainState();
}

class _AppBarMainState extends State<AppBarMain> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        const Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: SizedBox(
            width: 300,
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                counterStyle: TextStyle(fontSize: 13),
                hintStyle: TextStyle(fontSize: 13),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                hintText: 'Search',
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          ),
        ),
      ],
      shadowColor: Colors.black,
      backgroundColor: Colors.white,
      elevation: 2.0,
      centerTitle: true,
      title: Center(
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 15,
            ),
            InkWell(
                hoverColor: Colors.transparent,
                onHover: (value) {
                  setState(() {});
                },
                onTap: () {},
                child: const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width / 40,
            ),
            InkWell(
                hoverColor: Colors.transparent,
                onHover: (value) {
                  setState(() {});
                },
                onTap: () {},
                child: const Text(
                  'Men',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width / 40,
            ),
            InkWell(
                hoverColor: Colors.transparent,
                onHover: (value) {
                  setState(() {});
                },
                onTap: () {},
                child: const Text(
                  'Women',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width / 40,
            ),
            InkWell(
                hoverColor: Colors.transparent,
                onHover: (value) {
                  setState(() {});
                },
                onTap: () {},
                child: const Text(
                  'Kids',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width / 20,
            ),
          ],
        ),
      ),
    );
  }
}
