import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/medecine.dart';
import '../services/database_service.dart';
import '../services/notification_service.dart';
import '../services/permission_service.dart';

class AddEditPage extends StatefulWidget {
  final Medicine? medicine;
  const AddEditPage({super.key, this.medicine});

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final _nameCtrl = TextEditingController();
  final _dosageCtrl = TextEditingController();
  TimeOfDay? _time;

  @override
  void initState() {
    super.initState();
    if (widget.medicine != null) {
      _nameCtrl.text = widget.medicine!.name;
      _dosageCtrl.text = widget.medicine!.dosage;
      _time = TimeOfDay(hour: widget.medicine!.hour, minute: widget.medicine!.minute);
    }
  }

  void _save() async {
    if (_nameCtrl.text.isEmpty || _dosageCtrl.text.isEmpty || _time == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs.")),
      );
      return;
    }

    final med = Medicine(
      _nameCtrl.text,
      _dosageCtrl.text,
      _time!.hour,
      _time!.minute,
      taken: widget.medicine?.taken ?? false,
      id: widget.medicine?.id,
    );

    if (widget.medicine == null) {
      final id = await DatabaseService().insertMedicine(med);
      med.id = id;
    } else {
      await DatabaseService().updateMedicine(med);
    }

    // ✅ Planification de la notification quotidienne
    try {
      await NotificationService().scheduleDailyNotification(
        id: med.id!,
        title: 'Rappel Médicament',
        body: 'Prends ton médicament : ${med.name}',
        hour: med.hour,
        minute: med.minute,
      );
    } on PlatformException catch (e) {
      if (e.code == 'exact_alarms_not_permitted') {
        await requestExactAlarmPermission();
        // puis re-essaye après que l'utilisateur ait autorisé
      }
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.medicine == null ? 'Ajouter un médicament' : 'Modifier le médicament')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(labelText: "Nom du médicament"),
          ),
          TextField(
            controller: _dosageCtrl,
            decoration: const InputDecoration(labelText: "Dosage"),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.schedule),
            onPressed: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: _time ?? TimeOfDay.now(),
              );
              if (picked != null) {
                setState(() => _time = picked);
              }
            },
            label: Text(
              _time == null ? "Choisir l’heure" : "Heure : ${_time!.format(context)}",
            ),
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save),
            label: const Text("Sauvegarder"),
            style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
          ),
        ],
      ),
    ),
  );
}
