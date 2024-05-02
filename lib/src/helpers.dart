import "package:wamp/src/wsjoiner.dart";
import "package:wampproto/messages.dart";
import "package:wampproto/serializers.dart";

String getSubProtocol(Serializer serializer) {
  if (serializer is JSONSerializer) {
    return WAMPSessionJoiner.jsonSubProtocol;
  } else if (serializer is CBORSerializer) {
    return WAMPSessionJoiner.cborSubProtocol;
  } else if (serializer is MsgPackSerializer) {
    return WAMPSessionJoiner.msgpackSubProtocol;
  } else {
    throw ArgumentError("invalid serializer");
  }
}

String wampErrorString(Error err) {
  String errStr = err.uri;
  if (err.args.isNotEmpty) {
    String args = err.args.map((arg) => arg.toString()).join(", ");
    errStr += ": $args";
  }
  if (err.kwargs.isNotEmpty) {
    String kwargs = err.kwargs.entries.map((entry) => "${entry.key}=${entry.value}").join(", ");
    errStr += ": $kwargs";
  }
  return errStr;
}