class Nhom {
  int? id;
  String tenNhom;

  Nhom({
    this.id,
    required this.tenNhom,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tenNhom': tenNhom,
    };
  }
}