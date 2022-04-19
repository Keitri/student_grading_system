class JsonHelper {
  static List<String> dynamicListToString(List<dynamic> inputList) {
    var result = <String>[];
    for (var row in inputList) {
      result.add(row.toString());
    }
    return result;
  }
}
