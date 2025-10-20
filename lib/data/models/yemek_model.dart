class Yemek {
  final String yemekId;
  final String yemekAdi;
  final String yemekResimAdi;
  final int yemekFiyat;
  final int? yemekSiparisAdet;
  final int? sepetYemekId;

  Yemek({
    required this.yemekId,
    required this.yemekAdi,
    required this.yemekResimAdi,
    required this.yemekFiyat,
    this.yemekSiparisAdet,
    this.sepetYemekId,
  });

  factory Yemek.fromJson(Map<String, dynamic> json) {
    int? _toInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is String) return int.tryParse(value);
      return null;
    }

    return Yemek(
      yemekId: json["yemek_id"] ?? json["sepet_yemek_id"]?.toString() ?? "",
      yemekAdi: json["yemek_adi"] ?? "",
      yemekResimAdi: json["yemek_resim_adi"] ?? "",
      yemekFiyat: _toInt(json["yemek_fiyat"]) ?? 0,
      yemekSiparisAdet: _toInt(json["yemek_siparis_adet"]),
      sepetYemekId: _toInt(json["sepet_yemek_id"]),
    );
  }
}
