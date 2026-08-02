import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalDbService {
  static Future<void> initialize() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
  }

  Future<Box<T>> openBox<T>(String boxName) async {
    return await Hive.openBox<T>(boxName);
  }
}

final localDbProvider = Provider<LocalDbService>((ref) {
  return LocalDbService();
});
