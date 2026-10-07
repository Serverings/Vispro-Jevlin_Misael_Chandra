## Primary Screen

Primary screen pada aplikasi GameVault adalah `GameLibraryScreen`. Screen ini bertanggung jawab mengelola state utama seperti kata pencarian dan status filter game.

Agar kode lebih mudah dibaca dan setiap widget memiliki tanggung jawab yang jelas, beberapa bagian dari `GameLibraryScreen` diekstrak menjadi widget terpisah.

## 1. GameSearchBar

### Trigger

**Readability**

`GameSearchBar` dipisahkan dari `GameLibraryScreen` agar bagian kode yang menangani search bar tidak membuat kode primary screen terlalu panjang dan sulit dibaca.

### Apa yang dimiliki (Owns)

`GameSearchBar` bertanggung jawab terhadap tampilan search bar, seperti:

Text field
Icon pencarian
Hint text
Border

Widget ini tidak menyimpan state kata pencarian.

### Apa yang dilaporkan ke parent

`GameSearchBar` melaporkan perubahan teks pencarian melalui `onChanged`.

Ketika pengguna mengetik sesuatu, nilai tersebut dikirim kembali ke `GameLibraryScreen` untuk memperbarui `_searchQuery`.

## 2. GameStatusFilter

### Trigger

**Readability**

`GameStatusFilter` dipisahkan agar bagian tampilan filter status tidak bercampur dengan kode utama `GameLibraryScreen`.

### Apa yang dimiliki (Owns)

`GameStatusFilter` bertanggung jawab terhadap tampilan dropdown untuk memilih status game.

Pilihan status yang tersedia adalah:

All
Backlog
Playing
Finished
Dropped

Widget ini tidak menyimpan status filter sebagai state sendiri.

### Apa yang dilaporkan ke parent

Widget melaporkan status yang dipilih melalui `onChanged`.

`GameLibraryScreen` menerima nilai tersebut dan memperbarui `_selectedStatus`.

## 3. GameCard

### Trigger

**Reuse dan Readability**

`GameCard` dipisahkan karena setiap game pada daftar menggunakan struktur tampilan yang sama. Dengan membuat widget sendiri, satu `GameCard` dapat digunakan untuk banyak game dan kode `GameLibraryScreen` menjadi lebih mudah dibaca.

### Apa yang dimiliki (Owns)

`GameCard` bertanggung jawab menampilkan informasi satu game, yaitu:

* Nama game
* Genre
* Progress game

Widget menerima data game melalui objek `Game`.

### Apa yang dilaporkan ke parent

`GameCard` melaporkan ketika pengguna menekan card melalui `onTap`.

`GameLibraryScreen` kemudian menentukan tindakan yang dilakukan, yaitu membuka `GameDetailScreen`.

## 4. EmptyGameState

### Trigger

**Reuse dan Readability**

`EmptyGameState` dipisahkan karena kondisi ketika tidak ada game merupakan salah satu keadaan UI yang berbeda dari daftar game normal.

Widget ini juga dapat digunakan untuk beberapa kondisi, misalnya ketika daftar game kosong atau ketika pencarian tidak menemukan game.

### Apa yang dimiliki (Owns)

`EmptyGameState` bertanggung jawab menampilkan:

* Icon
* Pesan ketika tidak ada game
* Pengaturan posisi dan tampilan empty state

Widget menerima pesan melalui parameter `message`.

### Apa yang dilaporkan ke parent

`EmptyGameState` tidak melaporkan event ke parent karena widget ini hanya digunakan untuk menampilkan informasi dan tidak memiliki interaksi pengguna.
