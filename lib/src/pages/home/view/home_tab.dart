import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_com_getx/src/pages/common/custom_shimmer.dart';
import 'package:quitanda_com_getx/src/pages/home/components/item_tile.dart';
import 'package:quitanda_com_getx/src/pages/home/controller/home_controller.dart';

import '../../../config/colors.dart';
import '../../base/controller/navigation_controller.dart';
import '../../cart/controller/cart_controller.dart';
import '../../common/app_name_widget.dart';
import '../components/category_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  var _cartQuantityItems = 0;

  void itemSelectedCartAnimations(GlobalKey gkImage) async {
    runAddToCartAnimation(gkImage);
    await cartKey.currentState!
        .runCartAnimation((++_cartQuantityItems).toString());
  }

  final controller = Get.find<HomeController>();

  final searchController = TextEditingController();

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
              child: GetBuilder<NavigationController>(
                builder: (controller) {
                  return GestureDetector(
                    onTap: () =>
                        controller.navigatePageView(NavigationTabs.cart),
                    child: AddToCartIcon(
                      badgeOptions: BadgeOptions(
                        active: false,
                        backgroundColor: customConstrastColor,
                      ),
                      key: cartKey,
                      icon: GetBuilder<CartController>(
                        builder: (controller) {
                          return Badge(
                            badgeColor: customConstrastColor,
                            badgeContent: Text(
                              controller.getCartTotalItems().toString(),
                              style: const TextStyle(
                                fontSize: 9,
                                color: Colors.white,
                              ),
                            ),
                            child: Icon(
                              Icons.shopping_cart,
                              color: customSwatchColor,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            GetBuilder<HomeController>(
              builder: (controller) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    controller: searchController,
                    onChanged: ((value) {
                      controller.searchTitle.value = value;
                    }),
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
                      suffixIcon: controller.searchTitle.value.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                searchController.clear();
                                controller.searchTitle.value = '';
                                FocusScope.of(context).unfocus();
                              },
                              icon: Icon(
                                Icons.close,
                                color: customConstrastColor,
                                size: 21,
                              ),
                            )
                          : null,
                    ),
                  ),
                );
              },
            ),
            GetBuilder<HomeController>(
              builder: (controller) {
                return Container(
                  padding: const EdgeInsets.only(left: 25),
                  height: 40,
                  child: !controller.isLoadingCategory.value
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return CategoryTile(
                              isSelected: controller.categoryList[index] ==
                                  controller.currentCategory!,
                              category: controller.categoryList[index].title!,
                              onPressed: () {
                                controller.selectCategory(
                                  controller.categoryList[index],
                                );
                              },
                            );
                          },
                          separatorBuilder: (_, index) =>
                              const SizedBox(width: 10),
                          itemCount: controller.categoryList.length,
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
                );
              },
            ),
            GetBuilder<HomeController>(
              builder: (controll) {
                return Expanded(
                  child: !controll.isLoadingProduct.value
                      ? Visibility(
                          visible: (controller.currentCategory?.items ?? [])
                              .isNotEmpty,
                          replacement: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 40,
                                color: customSwatchColor,
                              ),
                              const Text('Não há itens para apresentar'),
                            ],
                          ),
                          child: GridView.builder(
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
                              if ((index + 1 == controll.allProducts.length) &&
                                  !controll.isLastPage) {
                                controll.loadMoreProducts();
                              }
                              return ItemTile(
                                item: controll.allProducts[index],
                                cartAnimationMethod: itemSelectedCartAnimations,
                              );
                            },
                            itemCount: controll.allProducts.length,
                          ),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
