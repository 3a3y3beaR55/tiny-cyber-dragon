import 'dart:io';
import 'package:image/image.dart' as img;

void main(List<String> args) {
  final input = _arg(args, '--input');
  final output = _arg(args, '--output') ?? 'assets/byte/generated';
  final cols = int.tryParse(_arg(args, '--cols') ?? '');
  final rows = int.tryParse(_arg(args, '--rows') ?? '');
  final prefix = _arg(args, '--prefix') ?? 'sprite';

  if (input == null || cols == null || rows == null) {
    print('Usage: dart run tools/slice_assets.dart --input path.png --cols 8 --rows 4 --output assets/byte/generated --prefix byte');
    exit(1);
  }

  final file = File(input);
  if (!file.existsSync()) {
    print('Input file not found: $input');
    exit(1);
  }

  final image = img.decodeImage(file.readAsBytesSync());
  if (image == null) {
    print('Could not decode image: $input');
    exit(1);
  }

  final outDir = Directory(output);
  outDir.createSync(recursive: true);

  final frameWidth = image.width ~/ cols;
  final frameHeight = image.height ~/ rows;
  var count = 1;

  for (var row = 0; row < rows; row++) {
    for (var col = 0; col < cols; col++) {
      final frame = img.copyCrop(
        image,
        x: col * frameWidth,
        y: row * frameHeight,
        width: frameWidth,
        height: frameHeight,
      );

      final fileName = '${prefix}_${count.toString().padLeft(2, '0')}.png';
      final outFile = File('${outDir.path}/$fileName');
      outFile.writeAsBytesSync(img.encodePng(frame));
      print('Exported: ${outFile.path}');
      count++;
    }
  }

  print('Done. Exported ${count - 1} frames.');
}

String? _arg(List<String> args, String name) {
  final index = args.indexOf(name);
  if (index == -1 || index + 1 >= args.length) return null;
  return args[index + 1];
}
