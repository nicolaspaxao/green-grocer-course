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
      (_) => filterByTitle(),
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

  void filterByTitle() {
    for (var category in categoryList) {
      category.items.clear();
      category.pagination = 0;
    }
    if (searchTitle.value.isEmpty) {
      categoryList.removeAt(0);
    } else {
      CategoryModel? c = categoryList.firstWhereOrNull((cat) => cat.id == '');

      if (c == null) {
        final allProductsCategories = CategoryModel(
          title: 'Todos',
          id: '',
          items: [],
          pagination: 0,
        );

        categoryList.insert(0, allProductsCategories);
      } else {
        c.items.clear();
        c.pagination = 0;
      }
    }

    currentCategory = categoryList.first;
    update();

    getAllProducts();
  }

  void loadMoreProducts() {
    currentCategory!.pagination++;
    getAllProducts(canLoad: false);
  }

  Future<void> getAllProducts({bool canLoad = true}) async {
    if (canLoad) {
      isLoadingProduct.value = true;
    }

    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      'itemsPerPage': itemsPerPage,
    };

    if (searchTitle.value.isNotEmpty) {
      body['title'] = searchTitle.value;
      if (currentCategory!.id == '') {
        body.remove('categoryId');
      }
    }

    HomeResult<ItemModel> result = await homeRepository.getAllProducts(body);

    isLoadingProduct.value = false;

    result.when(
      sucess: (data) {
        if (currentCategory!.items.isNotEmpty) {
          for (var item in data) {
            currentCategory!.items.addIf(
              (ItemModel value) {
                data.firstWhere((e) => e.id != value.id);
              },
              item,
            );
          }
        } else {
          currentCategory!.items.addAll(data);
        }
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
