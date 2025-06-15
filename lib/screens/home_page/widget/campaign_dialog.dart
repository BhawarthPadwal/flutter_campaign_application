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
      controller.text = pickedDate.toIso8601String().substring(0, 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Campaign'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: startDateController,
              decoration: const InputDecoration(labelText: 'Start Date'),
              readOnly: true,
              onTap: () => _pickDate(startDateController),
            ),
            TextField(
              controller: endDateController,
              decoration: const InputDecoration(labelText: 'End Date'),
              readOnly: true,
              onTap: () => _pickDate(endDateController),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.bloc.add(
              CreateNewCampaignEvent(
                name: nameController.text,
                description: descController.text,
                userId: widget.userId,
                startDate: startDateController.text,
                endDate: endDateController.text,
              ),
            );
            Navigator.of(context).pop();
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
