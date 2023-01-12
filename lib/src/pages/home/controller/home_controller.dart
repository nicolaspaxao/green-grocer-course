import 'package:get/get.dart';
import 'package:quitanda_com_getx/src/models/category_model.dart';
import 'package:quitanda_com_getx/src/pages/home/repositories/home_repository.dart';
import 'package:quitanda_com_getx/src/pages/home/result/home_result.dart';
import 'package:quitanda_com_getx/src/services/utils_services.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  List<CategoryModel> categoryList = [];

  CategoryModel? currentCategory;

  final homeRepository = HomeRepository();

  selectCategory(CategoryModel category) {
    currentCategory = category;
    update();
  }

  Future<void> getAllCategories() async {
    isLoading.value = true;
    HomeResult<CategoryModel> result = await homeRepository.getAllCategories();
    isLoading.value = false;

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
}
