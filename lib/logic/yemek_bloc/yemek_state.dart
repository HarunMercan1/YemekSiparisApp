import 'package:equatable/equatable.dart';
import '../../data/models/yemek_model.dart';

abstract class YemekState extends Equatable {
  const YemekState();

  @override
  List<Object?> get props => [];
}

// 🔹 1. Ilk durum
class YemekInitial extends YemekState {}

// 🔹 2. Yukleniyor
class YemekYukleniyor extends YemekState {}

// 🔹 3. Tum yemekler yuklendi
class YemekYuklendi extends YemekState {
  final List<Yemek> yemekListesi;

  const YemekYuklendi(this.yemekListesi);

  @override
  List<Object?> get props => [yemekListesi];
}

// 🔹 4. Sepet yuklendi
class SepetYuklendi extends YemekState {
  final List<Yemek> sepetListesi;

  const SepetYuklendi(this.sepetListesi);

  @override
  List<Object?> get props => [sepetListesi];
}

// 🔹 5. Hata durumu
class YemekHata extends YemekState {
  final String mesaj;

  const YemekHata(this.mesaj);

  @override
  List<Object?> get props => [mesaj];
}
