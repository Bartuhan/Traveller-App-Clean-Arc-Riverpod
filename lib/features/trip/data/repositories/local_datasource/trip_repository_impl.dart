import 'package:dartz/dartz.dart';
import 'package:traveller_app_riverpod_clean_arch/features/core/utils/failures.dart';
import 'package:traveller_app_riverpod_clean_arch/features/trip/data/data_sources/local_database/trip_local_data_source.dart';
import 'package:traveller_app_riverpod_clean_arch/features/trip/data/models/trip_model.dart';
import 'package:traveller_app_riverpod_clean_arch/features/trip/domain/entities/trip.dart';
import 'package:traveller_app_riverpod_clean_arch/features/trip/domain/repositories/trip_repository.dart';

class TripRepositoryImpl extends TripRepository {
  final TripLocalDataSource localDataSource;

  TripRepositoryImpl(this.localDataSource);

  @override
  Future<void> addTrips(Trip trip) async {
    final tripModel = TripModel.fromEntities(trip);
    await localDataSource.addTrip(tripModel);
  }

  @override
  Future<void> deleteTrips(int index) async {
    await localDataSource.deleteTrip(index);
  }

  @override
  Future<Either<Failure, List<Trip>>> getTrips() async {
    try {
      final tripModels = localDataSource.getTrips();
      final res = tripModels.map((e) => e.toEntity()).toList();
      return Right(res);
    } catch (e) {
      return Left(SomeSpecificError(e.toString()));
    }
  }
}
