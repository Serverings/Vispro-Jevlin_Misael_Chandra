# Struktur projek

## Konvensi

**Feature-first, berlapis di dalam tiap fitur.** Kode dikelompokkan menurut *untuk apa* kode itu dibuat (fitur games), dan di dalam fitur menurut *jenis kodenya* (data, model, presentation). Aturan yang sama diterapkan di semua tempat.

```
lib/
├── main.dart                    hanya titik masuk: runApp(GameVaultApp())
├── app.dart                     MaterialApp: tema, theme mode, home
├── core/                        dipakai bersama oleh fitur mana pun
│   ├── theme/
│   │   ├── app_theme.dart       membangun ThemeData terang dan gelap
│   │   ├── app_colors.dart      ThemeExtension untuk warna yang tidak ada di Material (success)
│   │   └── app_spacing.dart     AppSpacing (grid 4 dp) dan AppRadius
│   ├── layout/
│   │   └── breakpoints.dart     batas lebar (wide, lebar maksimum konten)
│   └── widgets/
│       └── pulse.dart           animasi pudar generik untuk placeholder
└── features/
    └── games/
        ├── models/
        │   └── game.dart                    Game, GameStatus
        ├── data/
        │   ├── game_data.dart               data game contoh
        │   ├── game_repository.dart         interface: fetchGames()
        │   └── in_memory_game_repository.dart
        └── presentation/
            ├── screens/         satu screen adalah satu halaman penuh
            │   ├── home_shell.dart          navigation bar / rail, memuat data
            │   ├── game_library_screen.dart
            │   ├── game_detail_screen.dart
            │   └── progress_screen.dart
            ├── widgets/         bagian layar yang bisa dipakai ulang
            │   ├── game_card.dart, game_card_skeleton.dart, game_cover.dart
            │   ├── detail_cover.dart
            │   ├── game_search_bar.dart, status_filter.dart, library_header.dart
            │   ├── status_pill.dart, progress_summary.dart, brand_title.dart
            │   ├── empty_game_state.dart
            │   └── games_loader.dart, games_loading_view.dart, games_error_view.dart
            └── utils/
                └── game_status_style.dart   label dan warna untuk sebuah GameStatus
test/
├── game_vault_test.dart         tes layout dan perilaku
├── widget_test.dart             mencoba di perangkat lain
└── theme_rules_test.dart        menjaga aturan "tanpa gaya yang ditulis langsung"
```

## Alasan pemilihan struktur

**`core/` hanya berisi yang benar-benar dipakai bersama.** Tema, jarak, breakpoint, dan animasi pulse tidak tahu apa-apa soal game. Tidak ada file di `core/` yang mengimpor dari `features/`, jadi isinya bisa dipindah ke aplikasi lain tanpa diubah. Semua yang menyebut game ada di `features/games/`.

**Lapisan di dalam fitur.** `models/` berisi data murni. `data/` tahu dari mana data berasal. `presentation/` menampilkannya. Ketergantungan hanya mengarah satu arah: presentation → data → models. Sebuah widget tidak pernah membuat daftar game sendiri, dan repository tidak pernah mengimpor widget Flutter.

**Screen, widget, dan utils dipisah.** Sebuah *screen* memegang state dan tata letak satu halaman. Sebuah *widget* adalah bagian yang bisa dipakai ulang dan menerima semua kebutuhannya lewat konstruktor. *utils* berisi pembantu yang bukan keduanya: extension yang memetakan `GameStatus` ke label dan warna.

**Satu kelas utama per file, dan tidak ada file di atas sekitar 200 baris.** Ketika sebuah screen melewati batas itu, header-nya dipecah menjadi `library_header.dart` dan efek cover menjadi `detail_cover.dart`.

**Penamaan.** File memakai `snake_case`. Kelas memakai `UpperCamelCase`. Anggota privat diawali `_`. Konstanta yang hanya milik satu widget dibuat sebagai static privat di widget itu. Konstanta yang dipakai lintas fitur ada di `core/`.

## Bagaimana kode dipisahkan

| Urusan | Lokasi | Aturan |
|---|---|---|
| Warna dan tipografi | `core/theme/` | Kode fitur membacanya dari `Theme.of(context)`, tidak pernah menulis angka langsung. |
| Jarak dan radius | `core/theme/app_spacing.dart` | Kode fitur memakai `AppSpacing` dan `AppRadius`. |
| Perilaku responsif | `core/layout/breakpoints.dart` | Satu definisi "wide" untuk semua layar. |
| Asal data game | `data/game_repository.dart` | Layar bergantung pada interface, bukan pada daftarnya. |
| Loading, error, data | `games_loader.dart` | Satu widget mengubah sebuah `Future` menjadi tiga kondisi. |

`test/theme_rules_test.dart` menegakkan aturan warna, ukuran font, dan jarak secara otomatis.

## Alur data

```
main → GameVaultApp(repository) → HomeShell
        HomeShell memanggil repository.fetchGames() satu kali
        GamesLoader: loading → kerangka, error → coba lagi, data → tab
        Library dan Progress menerima daftar yang sama lewat konstruktor
```

Repository dimasukkan dari atas, jadi tes bisa memberi repository yang instan, lambat, atau gagal tanpa menyentuh satu layar pun.

## State saat ini

Seluruh state bersifat lokal pada widget:

| State | Disimpan di |
|---|---|
| `Future` berisi daftar game, dan tab yang dipilih | `_HomeShellState` |
| Teks pencarian dan filter status | `_GameLibraryScreenState` |

Belum ada state bersama dan belum ada paket state management.
