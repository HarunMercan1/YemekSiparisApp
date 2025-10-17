import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/yemek_model.dart';
import '../../core/constants/api_urls.dart';
import '../../logic/yemek_bloc/yemek_bloc.dart';
import '../../logic/yemek_bloc/yemek_event.dart';

class YemekCard extends StatelessWidget {
  final Yemek yemek;

  const YemekCard({super.key, required this.yemek});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            "${ApiUrls.resimBaseUrl}${yemek.yemekResimAdi}",
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          yemek.yemekAdi,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "${yemek.yemekFiyat} ₺",
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart, color: Colors.deepOrange),
          onPressed: () {
            // 🔹 Bloc’a event gönderiyoruz
            context.read<YemekBloc>().add(
              SepeteYemekEkleEvent(
                yemekAdi: yemek.yemekAdi,
                yemekResimAdi: yemek.yemekResimAdi,
                yemekFiyat: yemek.yemekFiyat,
                yemekSiparisAdet: 1,
                kullaniciAdi: "harun_mercan", // kendi belirleyeceğin username
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("${yemek.yemekAdi} sepete eklendi ✅")),
            );
          },
        ),
      ),
    );
  }
}
