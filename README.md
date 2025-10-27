# ResepKu - Aplikasi Katalog Resep Masakan (Flutter)

Ini adalah proyek Ujian Tengah Semester (UTS) untuk mata kuliah Mobile Programming. Proyek ini adalah aplikasi resep masakan "ResepKu" yang dibuat menggunakan Flutter.

Aplikasi ini mencakup alur autentikasi, penjelajahan resep dari data *dummy* lokal, fitur pencarian, dan pengaturan aplikasi seperti Ganti Tema.

---

## 📸 Tangkapan Layar (Screenshots)

Berikut adalah beberapa tampilan utama dari aplikasi "ResepKu".

| Halaman Login | Halaman Beranda | Detail Resep (Atas) |
| :---: | :---: | :---: |
| <img src="[MASUKKAN LINK SCREENSHOT LOGIN DISINI]" width="250"> | <img src="[MASUKKAN LINK SCREENSHOT BERANDA DISINI]" width="250"> | <img src="[MASUKKAN LINK SCREENSHOT DETAIL 1 DISINI]" width="250"> |
| *Desain UI Login baru* | *Carousel, Kategori & Daftar Populer* | *UI Detail Resep baru* |

| Detail Resep (Bawah) | Menu Samping (Drawer) | Halaman Pengaturan |
| :---: | :---: | :---: |
| <img src="[MASUKKAN LINK SCREENSHOT DETAIL 2 DISINI]" width="250"> | <img src="[MASUKKAN LINK SCREENSHOT DRAWER DISINI]" width="250"> | <img src="[MASUKKAN LINK SCREENSHOT PENGATURAN DISINI]" width="250"> |
| *Info Nutrisi & Instruksi* | *Navigasi & Opsi Logout* | *Fitur Ganti Tema (Dark/Light)* |

---

## 📋 Spesifikasi Proyek (Sesuai Soal UTS)

Proyek ini dirancang untuk memenuhi semua kriteria dari file `Soal UTS.pdf`:

* **Struktur Aplikasi:** Memiliki lebih dari 3 halaman yang saling terhubung (Login, Register, Home, List, Detail, Search, Settings, About).
* **Pengolahan Data Dummy:** Memuat dan mem-parsing data dari file `assets/dummy_recipes.json` secara asinkron.
* **Desain & Navigasi:** Menggunakan navigasi *routing* (`/login`, `/home`, `/settings`) dan `MaterialPageRoute` (untuk detail). Mengimplementasikan `Drawer` untuk navigasi menu.
* **Implementasi Widget & Layout:** Menggunakan berbagai widget seperti `Column`, `Row`, `ListView`, `Card`, `TextField`, `SingleChildScrollView`, dan widget kustom (`_buildFeaturedCard`, dll).
* **Kreativitas & Orisinalitas:** Mengimplementasikan fitur-fitur modern untuk meningkatkan nilai UI/UX, seperti:
    * **UI Profesional:** Desain UI kustom untuk halaman Login dan Detail Resep.
    * **Efek Shimmer:** Menampilkan *skeleton loading* saat memuat data.
    * **Carousel:** Menggunakan `card_swiper` untuk *banner* resep yang geser otomatis di beranda.

---

## ✨ Fitur Utama

* **Autentikasi & Sesi:**
    * Halaman Login dan Register dengan UI kustom.
    * **Memulihkan Sesi (Ingat Saya):** Menyimpan status login menggunakan `SharedPreferences`. Pengguna tidak perlu login ulang saat membuka aplikasi.
    * Fungsi **Logout** yang menghapus sesi dan mengembalikan ke Halaman Login.

* **Halaman Beranda (Homepage):**
    * *Carousel* geser otomatis (`card_swiper`) untuk resep pilihan.
    * Daftar Kategori dengan Ikon (`ActionChip`).
    * Daftar "Resep Populer" dengan *thumbnail* gambar.

* **Pencarian (Data Lokal):**
    * *Search bar* fungsional di `HomePage`.
    * Hasil pencarian memfilter data dari `dummy_recipes.json` berdasarkan nama resep.

* **Halaman Detail Resep:**
    * UI kustom baru yang menampilkan *Tags*, Deskripsi, Info (Waktu, Porsi, Kesulitan), Fakta Nutrisi, Bahan, dan Instruksi.
    * Desain adaptif yang dapat menampilkan gambar dari `Image.asset` (data dummy) atau `Image.network` (jika dari API).

* **Halaman Pengaturan:**
    * **Ganti Tema (Dark/Light Mode):** Menggunakan `Provider` (`ThemeProvider`) untuk manajemen state tema secara global.
    * Pilihan tema (terang/gelap) disimpan di `SharedPreferences` dan akan dimuat ulang saat aplikasi dibuka.
    * Tautan ke halaman "Tentang Aplikasi".

---

## 🚀 Teknologi & Package

* **Framework:** Flutter
* **Manajemen State:** `Provider` (untuk Tema), `StatefulWidget` (untuk state halaman)
* **Penyimpanan Lokal:** `shared_preferences` (untuk sesi login & preferensi tema)
* **Navigasi:** Flutter Routing (Named Routes)
* **Data:** `assets/dummy_recipes.json`
* **Package Eksternal:**
    * `provider`: Untuk state management global (Tema).
    * `card_swiper`: Untuk *carousel* geser di beranda.
    * `shimmer`: Untuk efek *skeleton loading*.
    * `http`: (Disiapkan untuk pengembangan API di masa depan).

---

## 📂 Struktur Folder Proyek
