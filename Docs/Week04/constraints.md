## Homework2 H2

1. Yang saya ubah adalah Mengganti ListTile di GameCard dengan Row berisi dua Text tanpa Expanded, lalu memakai judul 200 karakter.
Aturan yang saya terapkan dengan mengatur agar Row memberi lebar tak terbatas ke child yang tidak fleksibel, jadi Text memakai lebar penuh teksnya dan melewati tepi parent.
Kenapa fixnya berhasil karena Expanded memberi Text batas lebar yang pasti, sehingga maxLines dan ellipsis bisa memotong teks.

2. Yang saya ubah: Menaruh ListView.builder langsung di dalam Column tanpa Expanded. Aturannya adalah Column memberi tinggi tak terbatas ke child-nya, sedangkan ListView ingin mengisi seluruh tinggi yang diberikan, jadi ukurannya tidak bisa dihitung. Kenapa fixku berhasil karena Expanded memberi ListView tinggi yang pasti, yaitu sisa ruang di dalam Column. Saya tidak memakai shrinkWrap: true karena membangun semua item sekaligus.

3. Yang saya ubah adalah Mengganti SingleChildScrollView di layar detail dengan Padding, lalu membuka layar dalam landscape.
Aturannya Column lebih tinggi dari ruang yang diberikan parent-nya dan tidak bisa menggulir, jadi sisanya itu jadi ingin keluar layar.
Kenapa fix yang saya lakukan berhasil karena SingleChildScrollView memberi child tinggi bebas, dan kelebihannya bisa dijangkau dengan menggulir.