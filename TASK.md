Projek Aplikasi FLutter yang menampilkan katalog film terpopuler dengan data yang berasal dari The Movie Database. Dalam pengembangannya, kita ingin menambahkan katalog bukan hanya film, tapi juga serial TV dengan nama "Fluxpert".

Dengan menerapkan :
- Memisahkan kode logika bisnis dengan framework atau teknologi luar menggunakan clean architecture.
- Menerapkan TDD dalam pengembangan aplikasi.
- Mengerti widget-widget dasar untuk membuat tampilan UI yang menarik.
- Menuliskan kode dengan bersih, mudah dibaca, dan memenuhi code convention Dart.
- Kamu bisa menerapkan linter pada project flutter dengan menjalankan perintah "dart pub add flutter_lints" pada terminal. Kemudian jalankan perintah dart fix --apply pada terminal/console.


Kriteria 1: Menerapkan Clean Architecture
Aplikasi wajib menerapkan clean architecture dan membagi source code menjadi 3 layer, yaitu:

- Domain : Berisi kebutuhan dan logika utama terkait kebutuhan bisnis & aplikasi
- Data : Berisi implementasi kode untuk mendapatkan data dari sumber eksternal.
- Presentation : Berisi implementasi widget dan tampilan aplikasi serta state management.

Kriteria 2: Daftar TV Series
Aplikasi harus menampilkan daftar TV Series populer, top rated, dan yang sedang tayang.

- Menampilkan TV series populer, top rated, dan sedang tayang pada satu halaman utama. (boleh menampilkan pada halaman utama yang sudah ada atau membuat halaman baru).
- Menampilkan daftar TV series populer, top rated, dan sedang tayang masing-masing pada satu halaman sendiri.

Kriteria 3: Detail TV Series
Aplikasi harus menampilkan detail TV Series berdasarkan item yang dipilih.

- Halaman detail menampilkan poster, judul, rating, dan sinopsis.
- Halaman detail menampilkan rekomendasi TV series lainnya.

- Pada halaman detail, bagian genre, sebaiknya menampilkan data genre.name daripada genre.id agar lebih mudah dibaca dan dipahami pengguna.

Kriteria 4: Pencarian TV Series
Terdapat fitur untuk mencari judul TV Series.

Fitur pencarian berdasarkan judul dengan memanfaatkan API (bukan filtering secara lokal).

Kriteria 5: Watchlist
Menambahkan daftar TV series yang ingin ditonton ke dalam suatu daftar yang disimpan secara lokal. Daftar watchlist harus tetap bertahan meskipun aplikasi ditutup dan dibuka kembali.

Kriteria 6: Menerapkan Automated Testing
Fitur yang dikembangkan harus memiliki unit testing dengan minimal testing coverage 70%.

- Kamu sudah menulis skenario test dengan baik, kembangkan lagi agar lebih banyak kode yang ter-coverage. Tambahkan juga integration test untuk menguji jalannya aplikasi secara keseluruhan.


Kriteria 7: 

- Menampilkan Informasi Season & Episode
Halaman detail tidak hanya menampilkan informasi umum terkait series, tetapi juga informasi mengenai season dan episodenya.

- Menambahkan Widget & Integration Test
Unit test hanyalah sebagian dari automated testing. Untuk memastikan aplikasi benar-benar teruji dengan baik, Anda bisa menambahkan widget test untuk memverifikasi tampilan dan integration test untuk menguji jalannya aplikasi secara keseluruhan.