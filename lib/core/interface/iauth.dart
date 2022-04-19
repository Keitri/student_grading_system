import '../model/result.dart';

abstract class IAuth {
  Future ensureDefaultRegistrarCreated();

  Future<ResultModel> login(String mobileNumber, password);

  Future<ResultModel> createFacultyUser(String mobileNumber, String firstName,
      String lastName, String defaultPassword);

  String? getCurrentLoggedInId();
}
