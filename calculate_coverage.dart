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
  print('Total Lines: $totalLines');
  print('Covered Lines: $coveredLines');
  print('Coverage: $coverage%');
}
