import 'dart:convert';

void main(List<String> args) {
  var userJson = '{"key": "value1","key2": "value2",}';
  Map<String, dynamic> userdata = jsonDecode(userJson);
  print(userdata["key1"]);
  print(userdata["key2"]);
}
