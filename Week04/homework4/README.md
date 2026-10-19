# GameVault

Aplikasi pengelola backlog video game yang dibuat dengan Flutter dan Material 3.

**Track A: The Fandom Vault (Collection & Log Tracker).**
Kasus penggunaan: pemain yang punya lebih banyak game daripada waktu untuk memainkannya. GameVault menyimpan semua game di satu tempat, menunjukkan mana yang sedang dimainkan, sudah tamat, ditinggalkan, atau masih menunggu di backlog, dan mencatat sejauh mana progres tiap game.

> Mata kuliah: Visual Programming (IMT01303305) · AFL 1

## Fitur

**Library**
- Cari game berdasarkan judul, dengan tombol hapus.
- Filter berdasarkan status lewat chip: All, Backlog, Playing, Finished, Dropped.
- Jumlah hasil, serta label status dan progress bar di setiap kartu.
- HP: daftar satu kolom. Layar lebar (600 dp ke atas): grid.

**Detail**
- Cover di atas latar yang diburamkan (tata letak berdampingan di layar lebar), status, progres, dan deskripsi.
- Cover beranimasi dari kartu di daftar ke layar detail (Hero).

**Progress**
- Cincin penyelesaian keseluruhan dan jumlah game per status.
- Daftar game yang sedang dimainkan atau sudah tamat.

**Kondisi data**
- Loading: kartu kerangka yang berdenyut.
- Terisi: daftar atau grid.
- Kosong dan pencarian tidak ditemukan: ikon, pesan, dan aksi untuk mengatur ulang pencarian dan filter.
- Error: pesan dengan tombol "Try again".

**Navigasi**
- Bottom navigation bar di HP, navigation rail di layar lebar.
- Tombol back di tab Progress kembali ke Library dulu sebelum keluar dari aplikasi.

**Desain**
- Material 3 dengan warna seed deep purple, tema terang dan gelap.
- Semua warna berasal dari tema, dan semua jarak dari skala 4 dp.
- Teks panjang dipotong dengan ellipsis, dan setiap layar bisa digulir sehingga tidak overflow.
- Area sentuh minimal 48 dp. Ukuran teks mengikuti pengaturan sistem.

## Arsitektur

Feature-first, berlapis di dalam fitur. `core/` hanya berisi kode yang bisa dipakai lebih dari satu fitur.

```
lib/
├── main.dart
├── app.dart
├── core/        tema, breakpoint layout, widget bersama
└── features/
    └── games/
        ├── data/            repository dan data contoh
        ├── models/          Game, GameStatus
        └── presentation/    screens, widgets, utils
```

Penjelasan lengkapnya ada di [docs/structure.md](docs/structure.md).

## Memulai

**Kebutuhan:** Flutter 3.47.4 (stable) dengan Dart 3.13.3, serta emulator atau perangkat Android.

```bash
git clone <url-repositori>
cd <folder-projek>
flutter pub get
flutter run
```

Gambar cover dimuat dari `assets/images/`. Game tanpa gambar (atau yang filenya tidak ada) menampilkan gradien berwarna tema sebagai pengganti.

## Tes dan pemeriksaan

```bash
flutter analyze
flutter test
```

- `test/game_vault_test.dart`: tes layout di ukuran HP kecil, HP besar, dan tablet, dalam landscape, dengan judul 200 karakter, 0 dan 500 game, keyboard terbuka, dark mode, notch, dan teks 2×, ditambah tes pencarian, filter, dan navigasi.
- `test/game_loading_test.dart`: kerangka loading, kondisi error, dan coba lagi.
- `test/theme_rules_test.dart`: gagal kalau kode fitur memuat warna, ukuran font, atau angka jarak yang ditulis langsung.

## Release APK

Bangun dengan:

```bash
flutter build apk --release
```

Hasilnya ada di `build/app/outputs/flutter-apk/app-release.apk`.
Unduh build yang sudah diuji dari halaman Releases: **TODO: tempel link release**.


## Keterbatasan saat ini

- Game berasal dari daftar di memori, jadi perubahan tidak tersimpan antar peluncuran.
- Progres dan status hanya bisa dibaca. Mengubahnya butuh state bersama, yang menjadi fokus Modul 2.