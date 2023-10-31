import 'package:traveller_app_riverpod_clean_arch/features/trip/domain/repositories/trip_repository.dart';

import '../entities/trip.dart';

class AddTrip {
  final TripRepository repository;

  AddTrip(this.repository);

  Future<void> call(Trip trip) {
    return repository.addTrips(trip);
  }
}
