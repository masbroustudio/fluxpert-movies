# TODOLIST - Fluxpert (Movie & TV Series Catalog)

## 📋 Overview
Aplikasi Flutter "Fluxpert" - Katalog film dan serial TV dari The Movie Database dengan Clean Architecture dan TDD.

---

## ✅ Kriteria 1: Menerapkan Clean Architecture
- [x] ✅ Struktur folder Domain layer (entities, repositories, usecases)
- [x] ✅ Struktur folder Data layer (models, datasources, repositories implementation)
- [x] ✅ Struktur folder Presentation layer dengan BLoC
- [x] ✅ Memastikan pemisahan logika bisnis dari framework
- [x] ✅ Tambah BLoC dependencies ke pubspec.yaml

---

## ✅ Kriteria 2: Daftar TV Series
- [x] ✅ Menampilkan TV Series populer di halaman utama
- [x] ✅ Menampilkan TV Series top rated di halaman utama
- [x] ✅ Menampilkan TV Series yang sedang tayang (on the air) di halaman utama
- [x] ✅ Membuat halaman tersendiri untuk daftar TV Series populer
- [x] ✅ Membuat halaman tersendiri untuk daftar TV Series top rated
- [x] ✅ Membuat halaman tersendiri untuk daftar TV Series yang sedang tayang
- [x] ✅ Integrasi API TMDB untuk TV Series

---

## ✅ Kriteria 3: Detail TV Series
- [x] ✅ Halaman detail menampilkan poster TV Series
- [x] ✅ Halaman detail menampilkan judul TV Series
- [x] ✅ Halaman detail menampilkan rating TV Series
- [x] ✅ Halaman detail menampilkan sinopsis TV Series
- [x] ✅ Halaman detail menampilkan genre.name (bukan genre.id)
- [x] ✅ Halaman detail menampilkan rekomendasi TV Series (struktur siap, tinggal UI jika mau ditampilkan)

---

## ✅ Kriteria 4: Pencarian TV Series
- [x] ✅ Implementasi fitur search TV Series berdasarkan judul
- [x] ✅ Menggunakan API search (bukan filtering lokal)
- [x] ✅ Membuat halaman search untuk TV Series (dengan debounce 500ms)

---

## ✅ Kriteria 5: Watchlist TV Series
- [x] ✅ Fitur tambah TV Series ke watchlist
- [x] ✅ Fitur hapus TV Series dari watchlist
- [x] ✅ Menyimpan watchlist secara lokal (SQLite)
- [x] ✅ Halaman untuk menampilkan daftar watchlist TV Series
- [x] ✅ Memastikan data watchlist persisten (tetap ada setelah app ditutup)
- [x] ✅ Auto-refresh watchlist dengan RouteAware

---

## ✅ Kriteria 7: Fitur Tambahan
### Informasi Season & Episode
- [x] ✅ Menampilkan informasi season di halaman detail TV Series
- [x] ✅ Menampilkan informasi episode di halaman detail TV Series
- [x] ✅ Integrasi API untuk detail season & episode (SeasonModel dengan episodeCount)

---

## ❌ Kriteria 6: Automated Testing (Coverage ≥70%) - BELUM DIKERJAKAN
### Unit Tests
- [ ] Unit test untuk Domain layer (entities, usecases)
- [ ] Unit test untuk Data layer (models, datasources, repositories)
- [ ] Unit test untuk Presentation layer (BLoC)

### BLoC Tests
- [ ] BLoC test untuk OnTheAirTvSeriesBloc
- [ ] BLoC test untuk PopularTvSeriesBloc
- [ ] BLoC test untuk TopRatedTvSeriesBloc
- [ ] BLoC test untuk TvSeriesDetailBloc
- [ ] BLoC test untuk TvSeriesSearchBloc
- [ ] BLoC test untuk TvSeriesWatchlistBloc

### Widget & Integration Tests
- [ ] Widget test untuk semua TV Series pages
- [ ] Integration test untuk flow lengkap aplikasi
- [ ] Test coverage minimal 70%

---

## 🔧 Code Quality & Convention
- [x] ✅ flutter_lints sudah ditambahkan
- [x] ✅ dart fix --apply sudah dijalankan (327 fixes)
- [ ] Menjalankan `flutter analyze` untuk cek warnings
- [ ] Code review dan refactoring jika diperlukan

---

## 📊 SUMMARY IMPLEMENTASI

### ✅ SUDAH SELESAI (Kriteria 1-5, 7):
1. **Clean Architecture** - Domain, Data, Presentation layers ✅
2. **TV Series List** - 3 categories (On The Air, Popular, Top Rated) ✅
3. **TV Series Detail** - Lengkap dengan Season & Episode info ✅
4. **Search TV Series** - API-based dengan debounce ✅
5. **Watchlist TV Series** - Add/Remove dengan SQLite ✅
6. **BLoC State Management** - 6 BLoCs terpisah ✅
7. **Navigation & UI** - Drawer, routing, auto-refresh ✅

### ❌ BELUM SELESAI (Kriteria 6):
- **Testing** - Unit, BLoC, Widget, Integration tests
- **Coverage** - Target minimal 70%

---

## 🎯 NEXT STEPS

### Opsi 1: Lanjut Testing Sekarang
- Implementasi semua unit tests
- BLoC tests dengan bloc_test package
- Widget & integration tests
- Generate coverage report

### Opsi 2: Testing Nanti (Manual Testing Dulu)
- Test manual semua fitur secara menyeluruh
- Dokumentasi bugs/issues yang ditemukan
- Fix bugs terlebih dahulu
- Baru kemudian implement automated testing

---

## 📝 Configuration
- **TMDB API Key**: `cbcc31ad5ae6f5704ff748bf46867ff7` ✅
- **State Management**: BLoC ✅
- **Database**: SQLite ✅
- **Architecture**: Clean Architecture ✅
- **Implementation**: Original (tidak copy dari GitHub lain) ✅
