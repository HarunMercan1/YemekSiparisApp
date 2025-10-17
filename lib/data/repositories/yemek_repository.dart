import 'package:dio/dio.dart';
import '../../core/constants/api_urls.dart';
import '../models/yemek_model.dart';
import 'dart:convert';

class YemekRepository {
  final Dio _dio = Dio();

  // 🔹 1. Tum yemekleri getir
  Future<List<Yemek>> tumYemekleriGetir() async {
    try {
      final response = await _dio.get(ApiUrls.tumYemekler);

      if (response.statusCode == 200) {
        // 💥 JSON string ise decode et
        final data = response.data is String
            ? jsonDecode(response.data)
            : response.data;

        final List<dynamic> jsonList = data["yemekler"];
        return jsonList.map((e) => Yemek.fromJson(e)).toList();
      } else {
        throw Exception("Sunucudan beklenmeyen cevap kodu: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Tum yemekleri getirirken hata olustu: $e");
    }
  }


  // 🔹 2. Sepete yemek ekle
  Future<void> sepeteYemekEkle({
    required String yemekAdi,
    required String yemekResimAdi,
    required int yemekFiyat,
    required int yemekSiparisAdet,
    required String kullaniciAdi,
  }) async {
    try {
      await _dio.post(
        ApiUrls.sepeteYemekEkle,
        data: {
          "yemek_adi": yemekAdi,
          "yemek_resim_adi": yemekResimAdi,
          "yemek_fiyat": yemekFiyat,
          "yemek_siparis_adet": yemekSiparisAdet,
          "kullanici_adi": kullaniciAdi,
        },
      );
    } catch (e) {
      throw Exception("Sepete yemek eklenemedi: $e");
    }
  }

  // 🔹 3. Sepeti getir
  Future<List<Yemek>> sepettekiYemekleriGetir(String kullaniciAdi) async {
    try {
      final response = await _dio.post(
        ApiUrls.sepettekiYemekler,
        data: {"kullanici_adi": kullaniciAdi},
      );

      final List<dynamic> jsonList = response.data["sepet_yemekler"] ?? [];
      return jsonList.map((e) => Yemek.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Sepet getirilemedi: $e");
    }
  }

  // 🔹 4. Sepetten yemek sil
  Future<void> sepettenYemekSil({
    required int sepetYemekId,
    required String kullaniciAdi,
  }) async {
    try {
      await _dio.post(
        ApiUrls.sepettenYemekSil,
        data: {
          "sepet_yemek_id": sepetYemekId,
          "kullanici_adi": kullaniciAdi,
        },
      );
    } catch (e) {
      throw Exception("Sepetten silinemedi: $e");
    }
  }
}
