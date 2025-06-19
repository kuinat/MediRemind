class Medicine {
  int? id;
  String name;
  String dosage;
  int hour;
  int minute;
  bool taken;

  Medicine(this.name, this.dosage, this.hour, this.minute, {this.taken = false, this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
      'hour': hour,
      'minute': minute,
      'taken': taken ? 1 : 0,
    };
  }

  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      map['name'],
      map['dosage'],
      map['hour'],
      map['minute'],
      taken: map['taken'] == 1,
      id: map['id'],
    );
  }
}
