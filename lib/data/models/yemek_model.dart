class Yemek {
  final String yemekId;
  final String yemekAdi;
  final String yemekResimAdi;
  final int yemekFiyat;

  Yemek({
    required this.yemekId,
    required this.yemekAdi,
    required this.yemekResimAdi,
    required this.yemekFiyat,
  });

  factory Yemek.fromJson(Map<String, dynamic> json) {
    return Yemek(
      yemekId: json["yemek_id"],
      yemekAdi: json["yemek_adi"],
      yemekResimAdi: json["yemek_resim_adi"],
      yemekFiyat: int.parse(json["yemek_fiyat"]),
    );
  }
}
