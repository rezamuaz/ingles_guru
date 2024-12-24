import 'package:objectbox/objectbox.dart' as objectbox;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:sysbit/objectbox.g.dart';

// import 'objectbox.g.dart';

/// Repository to initilialize the ObjectBox Store object
class StoreRepository {
  late final objectbox.Store _store;

  /// Initializes the ObjectBox Store object.
  Future<void> initStore() async {
    final appSupportDirectory = await getApplicationSupportDirectory();

    _store = Store(
      getObjectBoxModel(),
      directory: path.join(appSupportDirectory.path, 'ingles-db'),
    );

    return;
  }

  /// Getter for the store object.
  objectbox.Store get store => _store;
}
