import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/yemek_model.dart';
import '../../core/constants/api_urls.dart';
import '../../logic/yemek_bloc/yemek_bloc.dart';
import '../../logic/yemek_bloc/yemek_event.dart';
import '../../data/repositories/yemek_repository.dart';

class YemekDetaySayfasi extends StatefulWidget {
  final Yemek yemek;
  final String kullaniciAdi;

  const YemekDetaySayfasi({
    super.key,
    required this.yemek,
    required this.kullaniciAdi,
  });

  @override
  State<YemekDetaySayfasi> createState() => _YemekDetaySayfasiState();
}

class _YemekDetaySayfasiState extends State<YemekDetaySayfasi> {
  int adet = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => YemekBloc(YemekRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.yemek.yemekAdi),
          backgroundColor: Colors.deepOrange,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "${ApiUrls.resimBaseUrl}${widget.yemek.yemekResimAdi}",
                      height: 220,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.image_not_supported,
                        size: 120,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.yemek.yemekAdi,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  "${widget.yemek.yemekFiyat} ₺",
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),

                // 🔹 Adet seçimi
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      iconSize: 36,
                      color: Colors.deepOrange,
                      onPressed: () {
                        if (adet > 1) setState(() => adet--);
                      },
                    ),
                    Text(
                      "$adet",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      iconSize: 36,
                      color: Colors.deepOrange,
                      onPressed: () {
                        setState(() => adet++);
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // 🔹 Sepete ekle butonu
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      context.read<YemekBloc>().add(
                        SepeteYemekEkleEvent(
                          yemekAdi: widget.yemek.yemekAdi,
                          yemekResimAdi: widget.yemek.yemekResimAdi,
                          yemekFiyat: widget.yemek.yemekFiyat,
                          yemekSiparisAdet: adet,
                          kullaniciAdi: widget.kullaniciAdi,
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "${widget.yemek.yemekAdi} sepete eklendi ✅ (x$adet)",
                            style: const TextStyle(fontSize: 16),
                          ),
                          backgroundColor: Colors.green.shade600,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text(
                      "Sepete Ekle",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
