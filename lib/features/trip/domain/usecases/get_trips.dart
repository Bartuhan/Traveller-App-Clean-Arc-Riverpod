import 'package:dartz/dartz.dart';
import 'package:traveller_app_riverpod_clean_arch/features/core/utils/failures.dart';
import 'package:traveller_app_riverpod_clean_arch/features/trip/domain/entities/trip.dart';
import 'package:traveller_app_riverpod_clean_arch/features/trip/domain/repositories/trip_repository.dart';

class GetTrips {
  final TripRepository repository;

  GetTrips(this.repository);

  Future<Either<Failure, List<Trip>>> call() async {
    return await repository.getTrips();
  }
}
