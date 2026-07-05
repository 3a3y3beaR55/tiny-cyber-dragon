import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'byte_controller.dart';

final byteControllerProvider = ChangeNotifierProvider<ByteController>((ref) {
  return ByteController();
});
