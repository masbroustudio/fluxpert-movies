import 'dart:io';

void main() {
  final file = File('coverage/lcov.info');
  final lines = file.readAsLinesSync();
  
  int totalLines = 0;
  int coveredLines = 0;
  
  for (var line in lines) {
    if (line.startsWith('LF:')) {
      totalLines += int.parse(line.substring(3));
    } else if (line.startsWith('LH:')) {
      coveredLines += int.parse(line.substring(3));
    }
  }
  
  final coverage = (coveredLines / totalLines * 100).toStringAsFixed(2);
  // ignore: avoid_print
  print('Total Lines: $totalLines');
  // ignore: avoid_print
  print('Covered Lines: $coveredLines');
  // ignore: avoid_print
  print('Coverage: $coverage%');
}
