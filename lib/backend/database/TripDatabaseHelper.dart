import 'package:sembast/sembast.dart';
import 'package:thepublictransport_app/backend/models/main/Trip.dart';

import 'AppDatabase.dart';

class TripDatabaseHelper {
  static const String TRIP_STORE = 'trips';
  final _userStore = intMapStoreFactory.store(TRIP_STORE);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Trip trip) async {
    await _userStore.add(await _db, trip.toJson());
  }

  Future update(Trip trip) async {
    final finder = Finder(filter: Filter.equals('id', trip.id));
    await _userStore.update(
      await _db,
      trip.toJson(),
      finder: finder,
    );
  }

  Future delete(Trip trip) async {
    final finder = Finder(filter: Filter.equals('id', trip.id));
    await _userStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<Trip>> get() async {
    final finder = Finder();

    final recordSnapshots = await _userStore.find(
      await _db,
      finder: finder,
    );

    return recordSnapshots.map((snapshot) {
      return Trip.fromJson(snapshot.value);
    }).toList();
  }
}
