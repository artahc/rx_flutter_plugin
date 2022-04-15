import 'stream_type.dart';
import 'observable_action.dart';
import 'package:flutter/services.dart';
import 'field_names.dart';
import 'logger.dart';

final _log = RxPluginLogger("ObservableRegistration");

class ObservableRegistrationRequest {
  final String method;
  final StreamType streamType;
  final int requestId;
  final dynamic arguments;

  final ObservableAction oa;

  ObservableRegistrationRequest(this.method, this.streamType, this.requestId, this.arguments, this.oa);

  Future<ObservableRegistrationResponse> invokeObservableRegistration(MethodChannel channel) async {
    _log.d("Platform channel request: $this");
    final response = await channel.invokeMethod(this.method, {
      Field.STREAM_TYPE: StreamTypeHandler.stringValue(this.streamType),
      Field.METHOD: this.method,
      Field.PAYLOAD: this.arguments,
      Field.REQUEST_ID: this.requestId,
      Field.OBSERVABLE_ACTION: ObservableActionHandler.stringValue(this.oa)
    }) as Map;
    _log.d("Platform channel response: $response");
    //Cast back to Observable Registration Response
    final orResponse = ObservableRegistrationResponse(response);
    return orResponse;
  }

  @override
  String toString() {
    return "ObservableRegistrationRequest {" +
        "method: $method, " +
        "streamType: ${StreamTypeHandler.stringValue(streamType)}, " +
        "requestId: $requestId, " +
        "arguments: $arguments, " +
        "observableAction: $oa" +
        "}";
  }
}

class ObservableRegistrationResponse {
  final int errorCode;
  final String errorMessage;

  ObservableRegistrationResponse(Map<dynamic, dynamic> map)
      : errorCode = map[Field.ERROR_CODE],
        errorMessage = map[Field.ERROR_MESSAGE];
}
