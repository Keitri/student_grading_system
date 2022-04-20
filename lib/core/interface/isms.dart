import '../model/grade.dart';
import '../model/result.dart';

abstract class ISms {
  Future<ResultModel> sendGrade(GradeModel grade);
}
