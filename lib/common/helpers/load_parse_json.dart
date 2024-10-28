import 'dart:convert';

Map<String, dynamic> loadparseJson(Map<String, dynamic> audioDataMap) {
  final data = jsonDecode(audioDataMap["json"]);

  final List<int> rawSamples = List.castFrom<dynamic, int>(data['data']);

  return {
    "samples": rawSamples.map((e) => e.toDouble()).toList(),
  };
}
