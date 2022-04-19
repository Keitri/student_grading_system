import 'package:student_grading_app/core/model/faculty.dart';
import 'package:student_grading_app/core/model/grade.dart';
import 'package:student_grading_app/core/model/registrar.dart';
import 'package:student_grading_app/core/model/student.dart';
import 'package:student_grading_app/core/model/subject.dart';

import '../model/base_user.dart';
import '../model/result.dart';

abstract class IDatabase {
  Future<ResultModel> saveRegistrarUser(RegistrarModel data);

  Future<ResultModel> saveNewFacultyUser(FacultyModel data);

  Future<ResultModel> saveNewStudentUser(StudentModel data);

  Future<BaseUser?> getUserDetails(String userId);

  Stream<List<SubjectModel>> allSubjectStream();

  Stream<List<FacultyModel>> allFacultyStream();

  Stream<List<StudentModel>> allStudentStream();

  Stream<List<GradeModel>> allGradeStream();
}
