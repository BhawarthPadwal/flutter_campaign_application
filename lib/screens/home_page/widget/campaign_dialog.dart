import 'package:campaign_application/screens/home_page/bloc/home_bloc.dart';
import 'package:flutter/material.dart';

class CampaignDialog extends StatefulWidget {
  final HomeBloc bloc;
  final String userId;

  const CampaignDialog(this.bloc, this.userId, {super.key});

  @override
  State<CampaignDialog> createState() => CampaignDialogState();
}

class CampaignDialogState extends State<CampaignDialog> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  Future<void> _pickDate(TextEditingController controller) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = pickedDate.toIso8601String().substring(0, 10);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Campaign'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Description cannot be empty';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: startDateController,
                decoration: const InputDecoration(labelText: 'Start Date'),
                readOnly: true,
                onTap: () => _pickDate(startDateController),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please select a start date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: endDateController,
                decoration: const InputDecoration(labelText: 'End Date'),
                readOnly: true,
                onTap: () => _pickDate(endDateController),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please select an end date';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.bloc.add(
                CreateNewCampaignEvent(
                  name: nameController.text.trim(),
                  description: descController.text.trim(),
                  userId: widget.userId,
                  startDate: startDateController.text,
                  endDate: endDateController.text,
                ),
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text("Submit"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
