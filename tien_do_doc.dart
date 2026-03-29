class TienDoDoc {
  int? id;
  int bookId;
  int trang;

  TienDoDoc({
    this.id,
    required this.bookId,
    required this.trang,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookId': bookId,
      'trang': trang,
    };
  }
}