import 'field_names.dart';

enum ObservableCallbackType { onNext, onComplete, onError }

class ObservableCallbackTypeHandler {
  static ObservableCallbackType valueOf(String value) {
    switch (value) {
      case "onNext":
        return ObservableCallbackType.onNext;
      case "onComplete":
        return ObservableCallbackType.onComplete;
      case "onError":
        return ObservableCallbackType.onError;
    }
    throw Exception("Unable to derive ObservableCallback from value of: $value");
  }

  static String stringValue(ObservableCallbackType oc) {
    switch (oc) {
      case ObservableCallbackType.onError:
        return "onError";
      case ObservableCallbackType.onComplete:
        return "onComplete";
      case ObservableCallbackType.onNext:
        return "onNext";
    }
  }
}

class ObservableCallback {
  final ObservableCallbackType type;
  final int requestId;
  final dynamic payload;

  //Error from observable
  final String? errorMessage;

  ObservableCallback(Map<dynamic, dynamic> map)
      : type = ObservableCallbackTypeHandler.valueOf(map[Field.OBSERVABLE_CALLBACK]),
        requestId = map[Field.REQUEST_ID],
        payload = map[Field.PAYLOAD],
        errorMessage = map[Field.ERROR_MESSAGE];
}
