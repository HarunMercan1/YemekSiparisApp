import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/yemek_model.dart';
import '../../core/constants/api_urls.dart';
import '../../logic/yemek_bloc/yemek_bloc.dart';
import '../../logic/yemek_bloc/yemek_event.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.yemek.yemekAdi),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              "${ApiUrls.resimBaseUrl}${widget.yemek.yemekResimAdi}",
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            Text(
              widget.yemek.yemekAdi,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "${widget.yemek.yemekFiyat} ₺",
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    if (adet > 1) setState(() => adet--);
                  },
                ),
                Text(
                  "$adet",
                  style: const TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    setState(() => adet++);
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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
                      "${widget.yemek.yemekAdi} sepete eklendi! (x$adet)",
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text(
                "Sepete Ekle",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
