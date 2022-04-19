import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_grading_app/core/interface/idatabase.dart';
import 'package:student_grading_app/core/model/base_user.dart';
import 'package:student_grading_app/core/model/faculty.dart';
import 'package:student_grading_app/core/model/grade.dart';
import 'package:student_grading_app/core/model/result.dart';
import 'package:student_grading_app/core/model/registrar.dart';
import 'package:student_grading_app/core/model/student.dart';
import 'package:student_grading_app/core/model/subject.dart';
import 'package:student_grading_app/view/values/apptext.dart';

class Firestore implements IDatabase {
  final String registrarTable = "registrar";
  final String facultyTable = "faculty";
  final String studentTable = "student";
  final String subjectTable = "subject";
  final String attendanceTable = "attendance";
  final String gradeTable = "grade";

  @override
  Future<ResultModel> saveRegistrarUser(RegistrarModel data) {
    return FirebaseFirestore.instance
        .collection(registrarTable)
        .doc(data.id)
        .set(data.toJSON())
        .then(
            (_) => const ResultModel.success(message: AppText.registrarCreated))
        .onError((error, stackTrace) =>
            const ResultModel.error(message: AppText.registrarError));
  }

  @override
  Future<BaseUser?> getUserDetails(String userId) async {
    // Check if Registrar
    final registrarDocument = await _checkUserId(registrarTable, userId);
    if (registrarDocument.exists) {
      return RegistrarModel.map(registrarDocument.data()!);
    }

    // Check if Faculty
    final facultyDocument = await _checkUserId(facultyTable, userId);
    if (facultyDocument.exists) {
      return FacultyModel.map(facultyDocument.data()!);
    }

    // Check if Student
    final studentDocument = await _checkUserId(studentTable, userId);
    if (studentDocument.exists) {
      return StudentModel.map(studentDocument.data()!);
    }

    return null;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _checkUserId(
      String table, String userId) {
    return FirebaseFirestore.instance.collection(table).doc(userId).get();
  }

  @override
  Stream<List<FacultyModel>> allFacultyStream() {
    return FirebaseFirestore.instance
        .collection(facultyTable)
        .snapshots()
        .map((snapshots) {
      final result = <FacultyModel>[];
      for (var element in snapshots.docs) {
        result.add(FacultyModel.map(element.data()));
      }
      return result;
    });
  }

  @override
  Stream<List<GradeModel>> allGradeStream() {
    return FirebaseFirestore.instance
        .collection(gradeTable)
        .snapshots()
        .map((snapshots) {
      final result = <GradeModel>[];
      for (var element in snapshots.docs) {
        result.add(GradeModel.map(element.data()));
      }
      return result;
    });
  }

  @override
  Stream<List<StudentModel>> allStudentStream() {
    return FirebaseFirestore.instance
        .collection(studentTable)
        .snapshots()
        .map((snapshots) {
      final result = <StudentModel>[];
      for (var element in snapshots.docs) {
        result.add(StudentModel.map(element.data()));
      }
      return result;
    });
  }

  @override
  Stream<List<SubjectModel>> allSubjectStream() {
    return FirebaseFirestore.instance
        .collection(subjectTable)
        .snapshots()
        .map((snapshots) {
      final result = <SubjectModel>[];
      for (var element in snapshots.docs) {
        result.add(SubjectModel.map(element.data()));
      }
      return result;
    });
  }
}
