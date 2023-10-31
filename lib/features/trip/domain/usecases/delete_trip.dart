import 'package:traveller_app_riverpod_clean_arch/features/trip/domain/repositories/trip_repository.dart';

class DeleteTrip {
  final TripRepository repository;

  DeleteTrip(this.repository);

  Future<void> call(int index) {
    return repository.deleteTrips(index);
  }
}
