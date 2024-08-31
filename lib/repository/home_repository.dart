import 'package:get/get.dart';

import '../data_services/api_helper.dart';
import '../data_services/api_type_enum.dart';
import '../helper/error_handler.dart';
import '../models/text_response_model.dart';
import '../utils/api_end_points.dart';

class HomeRepository {
  final ApiHelper _apiHelper = Get.find();

  Future<dynamic> textApi() async {
    var data = await errorHandler(
      _apiHelper.multiMethod(
        baseUrl,
        textUrl,
        methodType: ApiTypeEnum.get,
        type: 2,
      ),
    );
    if (data == null) return null;

    ///data load error
    var testResponseModel = modelErrorHandler(() {
      return TextResponseModel.fromMap(data);
    });
    return testResponseModel;
  }
}
