import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_grading_app/core/interface/idatabase.dart';
import 'package:student_grading_app/core/model/attendance.dart';
import 'package:student_grading_app/core/model/base_user.dart';
import 'package:student_grading_app/core/model/class.dart';
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
  final String classTable = "class";
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

  Future<QuerySnapshot<Map<String, dynamic>>> _checkMobileNumber(
      String mobileNumber) async {
    var result = await FirebaseFirestore.instance
        .collection(registrarTable)
        .where('mobileNumber', isEqualTo: mobileNumber)
        .limit(1)
        .get();

    if (result.docs.isNotEmpty) {
      return result;
    }

    result = await FirebaseFirestore.instance
        .collection(facultyTable)
        .where('mobileNumber', isEqualTo: mobileNumber)
        .limit(1)
        .get();

    if (result.docs.isNotEmpty) {
      return result;
    }

    result = await FirebaseFirestore.instance
        .collection(studentTable)
        .where('mobileNumber', isEqualTo: mobileNumber)
        .limit(1)
        .get();

    return result;
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

  @override
  Future<ResultModel> saveNewFacultyUser(FacultyModel data) async {
    // Check first if Mobile Number is Used
    final existingUser = await _checkMobileNumber(data.mobileNumber);
    if (existingUser.docs.isNotEmpty) {
      // Mobile Number already used
      return const ResultModel.error(
          message: 'Mobile number already registered');
    } else {
      // Save New Faculty User
      try {
        await FirebaseFirestore.instance
            .collection(facultyTable)
            .doc(data.id)
            .set(data.toJSON());
        return const ResultModel.success(message: AppText.facultyCreated);
      } catch (e) {
        return ResultModel.error(message: e.toString());
      }
    }
  }

  @override
  Future<ResultModel> saveNewStudentUser(StudentModel data) async {
    // Check first if Mobile Number is Used
    final existingUser = await _checkMobileNumber(data.mobileNumber);
    if (existingUser.docs.isNotEmpty) {
      // Mobile Number already used
      return const ResultModel.error(
          message: 'Mobile number already registered');
    } else {
      // Save New Student User
      try {
        await FirebaseFirestore.instance
            .collection(studentTable)
            .doc(data.id)
            .set(data.toJSON());
        return const ResultModel.success(message: AppText.studentCreated);
      } catch (e) {
        return ResultModel.error(message: e.toString());
      }
    }
  }

  @override
  Future<ResultModel> saveAttendance(AttendanceModel data) {
    return FirebaseFirestore.instance
        .collection(attendanceTable)
        .doc(data.id)
        .set(data.toJSON())
        .then(
            (_) => const ResultModel.success(message: AppText.attendanceSaved))
        .onError((error, stackTrace) =>
            const ResultModel.error(message: AppText.attendanceError));
  }

  @override
  Future<ResultModel> saveClass(ClassModel data) {
    return FirebaseFirestore.instance
        .collection(classTable)
        .doc(data.id)
        .set(data.toJSON())
        .then((_) => const ResultModel.success(message: AppText.classSaved))
        .onError((error, stackTrace) =>
            const ResultModel.error(message: AppText.classError));
  }

  @override
  Future<ResultModel> saveGrade(GradeModel data) {
    return FirebaseFirestore.instance
        .collection(gradeTable)
        .doc(data.id)
        .set(data.toJSON())
        .then((_) => const ResultModel.success(message: AppText.gradeSaved))
        .onError((error, stackTrace) =>
            const ResultModel.error(message: AppText.gradeError));
  }

  @override
  Future<ResultModel> saveSubject(SubjectModel data) {
    return FirebaseFirestore.instance
        .collection(subjectTable)
        .doc(data.id)
        .set(data.toJSON())
        .then((_) => const ResultModel.success(message: AppText.subjectSaved))
        .onError((error, stackTrace) =>
            const ResultModel.error(message: AppText.subjectError));
  }

  @override
  Stream<List<SubjectModel>> getFacultySubjectStream(String facultyId) {
    return FirebaseFirestore.instance
        .collection(subjectTable)
        .where('facultyId', isEqualTo: facultyId)
        .snapshots()
        .map((snapshots) {
      final result = <SubjectModel>[];
      for (var element in snapshots.docs) {
        result.add(SubjectModel.map(element.data()));
      }
      return result;
    });
  }

  @override
  Stream<List<ClassModel>> getSubjectClassStream(String subjectId) {
    return FirebaseFirestore.instance
        .collection(classTable)
        .where('subjectId', isEqualTo: subjectId)
        .snapshots()
        .map((snapshots) {
      final result = <ClassModel>[];
      for (var element in snapshots.docs) {
        result.add(ClassModel.map(element.data()));
      }
      return result;
    });
  }

  @override
  Stream<List<GradeModel>> getSubjectGradeStream(String subjectId) {
    return FirebaseFirestore.instance
        .collection(gradeTable)
        .where('subjectId', isEqualTo: subjectId)
        .snapshots()
        .map((snapshots) {
      final result = <GradeModel>[];
      for (var element in snapshots.docs) {
        result.add(GradeModel.map(element.data()));
      }
      return result;
    });
  }
}
