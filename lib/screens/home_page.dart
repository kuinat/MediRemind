import 'package:flutter/material.dart';
import '../models/medecine.dart';
import '../services/database_service.dart';
import 'add_edit_medecine_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Medicine> medicines = [];

  @override
  void initState() {
    super.initState();
    _loadMeds();
  }

  Future<void> _loadMeds() async {
    final meds = await DatabaseService().getAllMedicines();
    setState(() => medicines = meds);
  }

  Future<void> _delete(Medicine med) async {
    await DatabaseService().deleteMedicine(med.id!);
    await _loadMeds();
  }

  Future<void> _toggleTaken(Medicine med) async {
    med.taken = !med.taken;
    await DatabaseService().updateMedicine(med);
    await _loadMeds();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('MediRemind')),
    floatingActionButton: FloatingActionButton(
      onPressed: () async {

        await Navigator.push(context, MaterialPageRoute(builder: (_) => AddEditPage()));
        await _loadMeds();
      },
      child: const Icon(Icons.add),
    ),
    body: ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: medicines.map((med) => Card(
          child: ListTile(
            title: Text(med.name),
            subtitle: Text('${med.dosage} - ${med.hour.toString().padLeft(2, '0')}:${med.minute.toString().padLeft(2, '0')}'),
            leading: Checkbox(
              value: med.taken,
              onChanged: (_) => _toggleTaken(med),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AddEditPage(medicine: med)),
                    );
                    await _loadMeds();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _delete(med),
                ),
              ],
            ),
          ),
        )),
      ).toList(),
    ),
  );
}
