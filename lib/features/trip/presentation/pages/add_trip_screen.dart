// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller_app_riverpod_clean_arch/features/trip/domain/entities/trip.dart';
import 'package:traveller_app_riverpod_clean_arch/features/trip/presentation/providers/trip_provider.dart';

class AddTripScreen extends ConsumerWidget {
  AddTripScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController(text: 'Paris');
  final _descController = TextEditingController(text: 'Smells Shit');
  final _locationController = TextEditingController(text: 'Paris');
  final _pictureController = TextEditingController(text: 'https://picsum.photos/id/237/200/300');
  List<String> pictures = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          MyTextField(
            titleController: _titleController,
            text: 'Title',
          ),
          MyTextField(
            titleController: _descController,
            text: 'Description',
          ),
          MyTextField(
            titleController: _locationController,
            text: 'Location',
          ),
          MyTextField(
            titleController: _pictureController,
            text: 'Picture',
          ),
          ElevatedButton(
            child: const Text('Add Trips'),
            onPressed: () {
              pictures.add(_pictureController.text);
              if (_formKey.currentState!.validate()) {
                final newTrip = Trip(
                  title: _titleController.text,
                  description: _descController.text,
                  date: DateTime.now(),
                  location: _locationController.text,
                  pictures: pictures,
                );
                ref.read(tripListNotifierProvider.notifier).addNewTrip(newTrip);
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    titlePadding: EdgeInsets.all(20),
                    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    title: Text('Ekleme işlemi tamamlandı'),
                  ),
                  useSafeArea: true,
                );
              }
            },
          )
        ],
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required TextEditingController titleController,
    required this.text,
  }) : _titleController = titleController;

  final TextEditingController _titleController;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _titleController,
        decoration: InputDecoration(
          hintText: text,
          labelText: text,
          contentPadding: const EdgeInsets.all(20),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
