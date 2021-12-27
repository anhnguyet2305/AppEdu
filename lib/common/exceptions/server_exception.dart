import 'package:app_edu/common/const/string_const.dart';
import 'package:app_edu/common/exceptions/app_exception.dart';

class ServerException extends AppException {
  ServerException({
    String? message,
  }) : super(
          message: message ?? StringConst.someThingWentWrong,
        );
}
