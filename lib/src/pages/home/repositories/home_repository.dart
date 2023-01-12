import 'package:quitanda_com_getx/src/constants/endpoints.dart';
import 'package:quitanda_com_getx/src/models/category_model.dart';
import 'package:quitanda_com_getx/src/pages/home/result/home_result.dart';

import '../../../services/http_manager.dart';

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllCategories,
      method: HttpMethods.post,
    );

    if (result['result'] != null) {
      List<CategoryModel> data = (result['result'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e))
          .toList();
      return HomeResult<CategoryModel>.sucess(data);
    } else {
      return HomeResult.error(
        'Ocorreu um erro inesperado ao recuperar as categorias.',
      );
    }
  }
}
