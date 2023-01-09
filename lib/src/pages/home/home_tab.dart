import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:quitanda_com_getx/src/pages/common/custom_shimmer.dart';
import 'package:quitanda_com_getx/src/pages/home/components/item_tile.dart';

import '../../config/app_data.dart' as app_data;
import '../../config/colors.dart';
import '../common/app_name_widget.dart';
import 'components/category_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = app_data.categorias[0];

  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  var _cartQuantityItems = 0;

  void itemSelectedCartAnimations(GlobalKey gkImage) async {
    runAddToCartAnimation(gkImage);
    await cartKey.currentState!
        .runCartAnimation((++_cartQuantityItems).toString());
  }

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartKey,
      createAddToCartAnimation: (addToCartAnimation) {
        runAddToCartAnimation = addToCartAnimation;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const AppNameWidget(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 10),
              child: GestureDetector(
                onTap: () {},
                child: AddToCartIcon(
                  badgeOptions: BadgeOptions(
                      active: true, backgroundColor: customConstrastColor),
                  key: cartKey,
                  icon: Icon(
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
              child: !isLoading
                  ? ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return CategoryTile(
                          isSelected:
                              app_data.categorias[index] == selectedCategory,
                          category: app_data.categorias[index],
                          onPressed: () {
                            setState(() {
                              selectedCategory = app_data.categorias[index];
                            });
                          },
                        );
                      },
                      separatorBuilder: (_, index) => const SizedBox(width: 10),
                      itemCount: app_data.categorias.length,
                    )
                  : ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        5,
                        (index) => Container(
                          margin: const EdgeInsets.only(right: 7),
                          alignment: Alignment.center,
                          child: CustomShimmer(
                            height: 20,
                            width: 62,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
            ),
            Expanded(
              child: !isLoading
                  ? GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 9 / 11.5,
                      ),
                      itemBuilder: (_, index) {
                        return ItemTile(
                          item: app_data.items[index],
                          cartAnimationMethod: itemSelectedCartAnimations,
                        );
                      },
                      itemCount: app_data.items.length,
                    )
                  : GridView.count(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 9 / 11.5,
                      children: List.generate(
                        6,
                        (index) => CustomShimmer(
                          height: double.infinity,
                          width: double.infinity,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
