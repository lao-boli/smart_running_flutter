import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'api_exception.dart';

Future request(
  Function() block, {
  bool showLoading = false,
  bool Function(ApiException)? onError,
}) async {
  try {
    await loading(block, isShowLoading: showLoading);
  } catch (e) {
    handleException(ApiException.from(e), onError: onError);
  }
  return;
}

Future loading(Function block, {bool isShowLoading = false}) async {
  if (isShowLoading) {
    showLoading();
  }
  try {
    await block();
  } catch (e) {
    rethrow;
  } finally {
    dismissLoading();
  }
  return;
}

void showLoading() {
  EasyLoading.show(status: "加载中...");
}

void dismissLoading() {
  EasyLoading.dismiss();
}

bool handleException(ApiException exception,
    {bool Function(ApiException)? onError}) {
  if (onError?.call(exception) == true) {
    return true;
  }

  if (exception.code == 401) {
    ///todo to login
    return true;
  }

  return false;
}
