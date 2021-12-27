import 'package:app_edu/common/const/string_const.dart';
import 'package:app_edu/common/exceptions/app_exception.dart';

class ConnectException extends AppException {
  ConnectException({String? message})
      : super(
          message: message ?? StringConst.connectError,
        );
}
