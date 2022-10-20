class TransaksiModel {
  /*
  tipe
  1 -> pemasukan
  2 -> pengeluaran
  */
  int? id, type, total, totalHarga;
  String? name, barang, createdAt, updatedAt;

  TransaksiModel(
      {this.id,
      this.type,
      this.total,
      this.totalHarga,
      this.name,
      this.barang,
      this.createdAt,
      this.updatedAt});

  factory TransaksiModel.fromJson(Map<String, dynamic> json) {
    return TransaksiModel(
        id: json['id'],
        type: json['type'],
        total: json['total'],
        totalHarga: json['totalHarga'],
        name: json['name'],
        barang: json['barang'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}
