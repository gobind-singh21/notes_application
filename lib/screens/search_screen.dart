import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Enter search product",
                labelText: "Search",
                prefixIcon: Icon(
                  Icons.search_outlined,
                  size: 30,
                )),
          )
        ],
      ),
    );
  }
}
