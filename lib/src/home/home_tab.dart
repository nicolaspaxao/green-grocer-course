import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../config/colors.dart';
import 'components/category_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<String> categorias = [
    'Frutas',
    'Grãos',
    'Verduras',
    'Temperos',
    'Cereais'
  ];

  String selectedCategory = 'Frutas';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(
          TextSpan(
            style: const TextStyle(
              fontSize: 26,
            ),
            children: [
              TextSpan(
                text: 'Green',
                style: TextStyle(
                  color: customSwatchColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'grocer',
                style: TextStyle(
                  color: customConstrastColor,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 15),
            child: GestureDetector(
              onTap: () {},
              child: Badge(
                badgeColor: customConstrastColor,
                badgeContent: const Text(
                  '4',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: customSwatchColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                isDense: true,
                hintText: 'Pesquise aqui...',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: customConstrastColor,
                  size: 21,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 25),
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return CategoryTile(
                  isSelected: categorias[index] == selectedCategory,
                  category: categorias[index],
                  onPressed: () {
                    setState(() {
                      selectedCategory = categorias[index];
                    });
                  },
                );
              },
              separatorBuilder: (_, index) => const SizedBox(width: 10),
              itemCount: categorias.length,
            ),
          ),
        ],
      ),
    );
  }
}
