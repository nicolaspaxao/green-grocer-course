import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quitanda_com_getx/src/models/category_model.dart';
import 'package:quitanda_com_getx/src/models/item_model.dart';
import 'package:quitanda_com_getx/src/pages/home/repositories/home_repository.dart';
import 'package:quitanda_com_getx/src/pages/home/result/home_result.dart';
import 'package:quitanda_com_getx/src/services/utils_services.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  RxBool isLoadingCategory = false.obs;
  RxBool isLoadingProduct = false.obs;
  List<CategoryModel> categoryList = [];
  CategoryModel? currentCategory;
  List<ItemModel> get allProducts => currentCategory?.items ?? [];
  bool get isLastPage {
    if (currentCategory!.items.length < itemsPerPage) {
      return true;
    }
    return currentCategory!.pagination * itemsPerPage > allProducts.length;
  }

  RxString searchTitle = ''.obs;

  final homeRepository = HomeRepository();

  @override
  void onInit() {
    super.onInit();
    getAllCategories().then(
      (value) => getAllProducts(),
    );
    debounce(
      searchTitle,
      (_) {
        update();
      },
      time: const Duration(milliseconds: 600),
    );
  }

  selectCategory(CategoryModel category) {
    currentCategory = category;
    update();
    if (currentCategory!.items.isNotEmpty) {
      return;
    }
    getAllProducts();
  }

  Future<void> getAllCategories() async {
    isLoadingCategory.value = true;
    HomeResult<CategoryModel> result = await homeRepository.getAllCategories();
    isLoadingCategory.value = false;

    result.when(
      sucess: (data) {
        categoryList.assignAll(data);
        if (categoryList.isEmpty) return;
        selectCategory(categoryList.first);
      },
      error: (error) {
        UtilServices.showToast(
          title: error,
          isError: true,
        );
      },
    );
  }

  void loadMoreProducts() {
    currentCategory!.pagination++;
    getAllProducts(canLoad: false);
  }

  Future<void> getAllProducts({bool canLoad = true}) async {
    if (canLoad) {
      isLoadingProduct.value = true;
    }

    HomeResult<ItemModel> result = await homeRepository.getAllProducts(
      {
        'page': currentCategory!.pagination,
        'categoryId': currentCategory!.id,
        'itemsPerPage': itemsPerPage,
      },
    );
    isLoadingProduct.value = false;

    result.when(
      sucess: (data) {
        currentCategory!.items.addAll(data);
        debugPrint(data.toString());
      },
      error: (error) {
        UtilServices.showToast(
          title: error,
          isError: true,
        );
      },
    );
    update();
  }
}
