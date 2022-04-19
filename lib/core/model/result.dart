import 'package:equatable/equatable.dart';

enum MessageType { success, error, warning, information }

class ResultModel extends Equatable {
  final MessageType type;
  final String message;
  final Object? args;

  const ResultModel._({required this.type, required this.message, this.args});

  const ResultModel.success({required String message, Object? args})
      : this._(type: MessageType.success, message: message, args: args);

  const ResultModel.error({required String message})
      : this._(type: MessageType.error, message: message);

  const ResultModel.warning({required String message})
      : this._(type: MessageType.warning, message: message);

  const ResultModel.info({required String message})
      : this._(type: MessageType.information, message: message);

  bool get isSuccess => type == MessageType.success;
  bool get isError => type == MessageType.error;

  @override
  List<Object?> get props => [type, message, args];
}
