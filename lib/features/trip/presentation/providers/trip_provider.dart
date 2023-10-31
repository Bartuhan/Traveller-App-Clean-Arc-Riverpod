import 'package:hive_flutter/hive_flutter.dart';
import 'package:traveller_app_riverpod_clean_arch/features/trip/data/data_sources/local_database/trip_local_data_source.dart';
import 'package:traveller_app_riverpod_clean_arch/features/trip/data/models/trip_model.dart';
import 'package:traveller_app_riverpod_clean_arch/features/trip/data/repositories/local_datasource/trip_repository_impl.dart';
import 'package:traveller_app_riverpod_clean_arch/features/trip/domain/entities/trip.dart';
import 'package:traveller_app_riverpod_clean_arch/features/trip/domain/repositories/trip_repository.dart';
import 'package:traveller_app_riverpod_clean_arch/features/trip/domain/usecases/add_trips.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller_app_riverpod_clean_arch/features/trip/domain/usecases/delete_trip.dart';
import 'package:traveller_app_riverpod_clean_arch/features/trip/domain/usecases/get_trips.dart';

//-------------------------------------------------LOCALDATA SOURCE PROVİDER
final tripLocalDataSourceProvider = Provider<TripLocalDataSource>((ref) {
  final Box<TripModel> tripBox = Hive.box('trips');
  return TripLocalDataSource(tripBox);
});
//-------------------------------------------------LOCALDATA SOURCE PROVİDER //

//-------------------------------------------------REPOSİTORY PROVİDER
final tripRepositoryProvider = Provider<TripRepository>((ref) {
  final localDataSource = ref.read(tripLocalDataSourceProvider);
  return TripRepositoryImpl(localDataSource);
});
//-------------------------------------------------REPOSİTORY PROVİDER //

//--------------------------------------------------USECASE PROVİDER
final addTripsProvider = Provider<AddTrip>(
  (ref) {
    final repository = ref.read(tripRepositoryProvider);
    return AddTrip(repository);
  },
);

final getTripsProvider = Provider<GetTrips>(
  (ref) {
    final repository = ref.read(tripRepositoryProvider);
    return GetTrips(repository);
  },
);

final deleteTripsProvider = Provider<DeleteTrip>(
  (ref) {
    final repository = ref.read(tripRepositoryProvider);
    return DeleteTrip(repository);
  },
);
//--------------------------------------------------USECASE PROVİDER //

//--------------------------------------------------STATE NOTİFİER PROVİDER
final tripListNotifierProvider = StateNotifierProvider<TripListNotifier, List<Trip>>((ref) {
  final getTrips = ref.read(getTripsProvider);
  final addTrip = ref.read(addTripsProvider);
  final deleteTrip = ref.read(deleteTripsProvider);

  return TripListNotifier(getTrips, addTrip, deleteTrip);
});
//--------------------------------------------------STATE NOTİFİER PROVİDER //

class TripListNotifier extends StateNotifier<List<Trip>> {
  final GetTrips _getTrips;
  final AddTrip _addTrips;
  final DeleteTrip _deleteTrip;

  TripListNotifier(this._getTrips, this._addTrips, this._deleteTrip) : super([]);

  Future<void> addNewTrip(Trip trip) async {
    await _addTrips(trip);
  }

  Future<void> removeTrip(int index) async {
    await _deleteTrip(index);
  }

  Future<void> loadTrips() async {
    final tripsOrFailure = await _getTrips();
    tripsOrFailure.fold((err) => state = [], (trips) => state = trips);
  }
}
