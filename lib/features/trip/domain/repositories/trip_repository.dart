import 'package:traveller_app_riverpod_clean_arch/features/core/utils/failures.dart';
import 'package:traveller_app_riverpod_clean_arch/features/trip/domain/entities/trip.dart';
import 'package:dartz/dartz.dart';

abstract class TripRepository {
  Future<Either<Failure, List<Trip>>> getTrips();

  Future<void> addTrips(Trip trip);

  Future<void> deleteTrips(int index);
}
