class Sach {

  final int? id;
  final String tieuDe;
  final String tacGia;
  final String theLoai;
  final String duongDanFile;
  final String ngayThem;
  final int yeuThich;

  Sach({
    this.id,
    required this.tieuDe,
    required this.tacGia,
    required this.theLoai,
    required this.duongDanFile,
    required this.ngayThem,
    required this.yeuThich,
  });

  Map<String, dynamic> toMap() {

    return {
      'id': id,
      'tieuDe': tieuDe,
      'tacGia': tacGia,
      'theLoai': theLoai,
      'duongDanFile': duongDanFile,
      'ngayThem': ngayThem,
      'yeuThich': yeuThich,
    };

  }

  factory Sach.fromMap(Map<String, dynamic> map) {

    return Sach(

      id: map['id'],
      tieuDe: map['tieuDe'],
      tacGia: map['tacGia'] ?? "",
      theLoai: map['theLoai'] ?? "",
      duongDanFile: map['duongDanFile'],
      ngayThem: map['ngayThem'],
      yeuThich: map['yeuThich'] ?? 0,

    );
  }
}