class GhiChu {

  final int? id;
  final int bookId;
  final int trang;
  final String noiDung;

  GhiChu({
    this.id,
    required this.bookId,
    required this.trang,
    required this.noiDung,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookId': bookId,
      'trang': trang,
      'noiDung': noiDung,
    };
  }

  factory GhiChu.fromMap(Map<String, dynamic> map) {
    return GhiChu(
      id: map['id'],
      bookId: map['bookId'],
      trang: map['trang'],
      noiDung: map['noiDung'],
    );
  }
}