import 'package:campaign_application/screens/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';

class UpdateCampaignDialog extends StatefulWidget {
  final ProfileBloc bloc;
  final String userId;
  final int campaignId;
  final String initialName;
  final String initialDescription;
  final String initialStartDate;
  final String initialEndDate;

  const UpdateCampaignDialog({
    super.key,
    required this.bloc,
    required this.userId,
    required this.campaignId,
    required this.initialName,
    required this.initialDescription,
    required this.initialStartDate,
    required this.initialEndDate,
  });

  @override
  State<UpdateCampaignDialog> createState() => _UpdateCampaignDialogState();
}

class _UpdateCampaignDialogState extends State<UpdateCampaignDialog> {
  late TextEditingController nameController;
  late TextEditingController descController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialName);
    descController = TextEditingController(text: widget.initialDescription);
    startDateController = TextEditingController(text: widget.initialStartDate);
    endDateController = TextEditingController(text: widget.initialEndDate);
  }

  Future<void> _pickDate(TextEditingController controller) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(controller.text) ?? DateTime.now(),
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
      title: const Text('Update Campaign'),
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
              UpdateCampaignEvent(
                campaignId: widget.campaignId,
                userId: widget.userId,
                name: nameController.text,
                description: descController.text,
                startDate: startDateController.text,
                endDate: endDateController.text,
              ),
            );
            Navigator.of(context).pop();
          },
          child: const Text("Update"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
