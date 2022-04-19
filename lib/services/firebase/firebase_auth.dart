import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:student_grading_app/core/model/registrar.dart';

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
          firstName: "Admin",
          lastName: "");
      return defaultRegistrarUser;
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      return null;
    }
  }
}
