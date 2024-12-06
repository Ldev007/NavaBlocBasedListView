import 'package:isar/isar.dart';
import 'package:navalistview/src/domain/models/album.dart';
import 'package:navalistview/src/domain/models/photo.dart';
import 'package:path_provider/path_provider.dart';

class IsarDb {
  static final IsarDb _instance = IsarDb();

  IsarDb get instance => _instance;

  static late final Isar isarDb;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isarDb = await Isar.open(
      [AlbumSchema, PhotoSchema],
      directory: dir.path,
    );
    return;
  }
}
