import '../model/result.dart';

abstract class IAuth {
  Future ensureDefaultRegistrarCreated();

  Future<ResultModel> login(String mobileNumber, password);

  String? getCurrentLoggedInId();
}
