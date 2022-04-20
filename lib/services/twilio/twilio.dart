import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:student_grading_app/core/interface/isms.dart';
import 'package:student_grading_app/core/model/result.dart';
import 'package:student_grading_app/core/model/grade.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class Twilio implements ISms {
  @override
  Future<ResultModel> sendGrade(GradeModel grade) async {
    final twilioPlugin = TwilioFlutter(
        accountSid: dotenv.env['TWILIO_ACCOUNTSID']!,
        authToken: dotenv.env['TWILIO_AUTHTOKEN']!,
        twilioNumber: dotenv.env['TWILIO_NUMBER']!);

    try {
      await twilioPlugin.sendSMS(
          toNumber: grade.parentsMobileNumber,
          messageBody:
              "${grade.studentName}'s final grade for subject: ${grade.subjectName} is ${grade.totalGrade.toStringAsFixed(2)}");
      return const ResultModel.success(message: 'Message sent');
    } catch (e) {
      return const ResultModel.error(message: 'Error sending sms');
    }
  }
}
