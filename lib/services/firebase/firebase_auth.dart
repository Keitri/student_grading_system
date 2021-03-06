import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:student_grading_app/core/model/registrar.dart';
import 'package:student_grading_app/core/model/result.dart';

import '../../core/interface/iauth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FBAuth implements IAuth {
  @override
  Future<RegistrarModel?> ensureDefaultRegistrarCreated() async {
    // Get Default Registrar Info
    final String registrarNumber = dotenv.env['REGISTRAR_ACCOUNT']!;
    final String registrarDefaultPass =
        dotenv.env['REGISTRAR_INITIAL_PASSWORD']!;

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: registrarNumber + '@keitri.com',
              password: registrarDefaultPass);
      // Create a Registrar User
      final defaultRegistrarUser = RegistrarModel(
          id: userCredential.user!.uid,
          mobileNumber: registrarNumber,
          defaultPassword: registrarDefaultPass,
          firstName: "Admin",
          lastName: "");
      return defaultRegistrarUser;
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      return null;
    }
  }

  @override
  Future<ResultModel> login(String mobileNumber, password) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: mobileNumber + "@keitri.com", password: password);
      return ResultModel.success(message: "", args: userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      return ResultModel.error(message: e.message.toString());
    }
  }

  @override
  String? getCurrentLoggedInId() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return currentUser.uid;
    }

    return null;
  }

  @override
  Future logout() {
    return FirebaseAuth.instance.signOut();
  }

  @override
  Future<ResultModel> changePassword(String newPassword) async {
    if (FirebaseAuth.instance.currentUser != null) {
      try {
        await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
        return const ResultModel.success(message: '');
      } on FirebaseAuthException catch (e) {
        return ResultModel.error(message: e.message.toString());
      }
    } else {
      return const ResultModel.error(message: 'Cannot validate user!');
    }
  }
}
