bool debugMode = false;
void printLog({String title = "Lifecycle", required String content}) {
  if (!debugMode) return;
  print(title.isEmpty ? content : "$title:$content");
}
