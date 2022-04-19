import 'package:student_grading_app/core/model/registrar.dart';

import '../model/base_user.dart';
import '../model/result.dart';

abstract class IDatabase {
  Future<ResultModel> saveRegistrarUser(RegistrarModel data);

  Future<BaseUser?> getUserDetails(String userId);
}
