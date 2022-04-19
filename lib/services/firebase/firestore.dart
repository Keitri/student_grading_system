import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_grading_app/core/interface/idatabase.dart';
import 'package:student_grading_app/core/model/result.dart';
import 'package:student_grading_app/core/model/registrar.dart';
import 'package:student_grading_app/view/values/apptext.dart';

class Firestore implements IDatabase {
  final String registrarTable = "registrar";

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
}
