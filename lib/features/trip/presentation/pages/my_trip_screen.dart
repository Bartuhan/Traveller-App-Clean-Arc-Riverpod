import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller_app_riverpod_clean_arch/features/trip/presentation/providers/trip_provider.dart';
import 'package:traveller_app_riverpod_clean_arch/features/trip/presentation/wigdets/custom_search_bar.dart';
import 'package:traveller_app_riverpod_clean_arch/features/trip/presentation/wigdets/travel_card.dart';

class MyTripScreen extends ConsumerWidget {
  const MyTripScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripList = ref.watch(tripListNotifierProvider);

    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          CustomSearchBar(),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: tripList.length,
            itemBuilder: (context, index) {
              final trip = tripList[index];
              return TravelCard(
                trip: trip,
                onDelete: () async {
                  await ref.read(tripListNotifierProvider.notifier).removeTrip(index);
                  await ref.read(tripListNotifierProvider.notifier).loadTrips();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
