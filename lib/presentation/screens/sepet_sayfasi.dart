import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/yemek_bloc/yemek_bloc.dart';
import '../../logic/yemek_bloc/yemek_event.dart';
import '../../logic/yemek_bloc/yemek_state.dart';
import '../../data/repositories/yemek_repository.dart';
import '../../core/constants/api_urls.dart';
import '../../data/models/yemek_model.dart';

class SepetSayfasi extends StatelessWidget {
  final String kullaniciAdi;

  const SepetSayfasi({super.key, required this.kullaniciAdi});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      YemekBloc(YemekRepository())..add(SepetiGetirEvent(kullaniciAdi)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sepetim 🛍️"),
          backgroundColor: Colors.deepOrange,
        ),
        body: BlocBuilder<YemekBloc, YemekState>(
          builder: (context, state) {
            if (state is YemekYukleniyor) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SepetYuklendi) {
              // 🔹 API'den gelen sepet verisi
              final sepetListesi = state.sepetListesi;

              if (sepetListesi.isEmpty) {
                return const Center(child: Text("Sepetiniz boş 😢"));
              }

              // 🔹 Aynı ürünleri grupla (örnek: 2 Ayran -> Ayran x2)
              final Map<String, Yemek> gruplanmisSepet = {};
              for (var yemek in sepetListesi) {
                if (gruplanmisSepet.containsKey(yemek.yemekAdi)) {
                  final mevcut = gruplanmisSepet[yemek.yemekAdi]!;
                  final yeniAdet =
                      (mevcut.yemekSiparisAdet ?? 1) + (yemek.yemekSiparisAdet ?? 1);
                  gruplanmisSepet[yemek.yemekAdi] = Yemek(
                    yemekId: mevcut.yemekId,
                    yemekAdi: mevcut.yemekAdi,
                    yemekResimAdi: mevcut.yemekResimAdi,
                    yemekFiyat: mevcut.yemekFiyat,
                    yemekSiparisAdet: yeniAdet,
                    sepetYemekId: mevcut.sepetYemekId,
                  );
                } else {
                  gruplanmisSepet[yemek.yemekAdi] = yemek;
                }
              }

              final gruplanmisListe = gruplanmisSepet.values.toList();

              // 🔹 Toplam fiyatı hesapla
              final toplamTutar = gruplanmisListe.fold<double>(
                0,
                    (sum, yemek) =>
                sum + (yemek.yemekFiyat * (yemek.yemekSiparisAdet ?? 1)),
              );

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: gruplanmisListe.length,
                      itemBuilder: (context, index) {
                        final yemek = gruplanmisListe[index];
                        return _buildSepetCard(context, yemek);
                      },
                    ),
                  ),
                  // 🔹 Toplam tutar barı
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, -2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Toplam: ${toplamTutar.toStringAsFixed(2)} ₺",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                Text("Siparişiniz alındı! 🚀 (simülasyon)"),
                              ),
                            );
                          },
                          icon: const Icon(Icons.check_circle_outline),
                          label: const Text(
                            "Onayla",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is YemekHata) {
              return Center(child: Text("Hata: ${state.mesaj}"));
            } else {
              return const Center(child: Text("Sepet yüklenemedi."));
            }
          },
        ),
      ),
    );
  }

  Widget _buildSepetCard(BuildContext context, Yemek yemek) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        leading: Image.network(
          "${ApiUrls.resimBaseUrl}${yemek.yemekResimAdi}",
          width: 70,
          height: 70,
          fit: BoxFit.cover,
        ),
        title: Text(yemek.yemekAdi),
        subtitle:
        Text("${yemek.yemekFiyat} ₺  x${yemek.yemekSiparisAdet ?? 1}"),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            context.read<YemekBloc>().add(
              SepettenYemekSilEvent(
                yemek.sepetYemekId ?? int.tryParse(yemek.yemekId) ?? 0,
                kullaniciAdi,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("${yemek.yemekAdi} sepetten silindi ❌")),
            );
          },
        ),
      ),
    );
  }
}
