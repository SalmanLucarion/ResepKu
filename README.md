# ResepKu - Aplikasi Katalog Resep Masakan (Flutter)

Ini adalah proyek Ujian Tengah Semester (UTS) untuk mata kuliah Mobile Programming. Proyek ini adalah aplikasi resep masakan "ResepKu" yang dibuat menggunakan Flutter.

Aplikasi ini mencakup alur autentikasi, penjelajahan resep dari data *dummy* lokal, fitur pencarian, dan pengaturan aplikasi seperti Ganti Tema.

---

## 📸 Tangkapan Layar (Screenshots)

Berikut adalah beberapa tampilan utama dari aplikasi "ResepKu".

| Halaman Login | Halaman Beranda | Detail Resep (Atas) |
| :---: | :---: | :---: |
| `[MASUKKAN SCREENSHOT LOGIN DISINI]` | `[MASUKKAN SCREENSHOT BERANDA DISINI]` | `[MASUKKAN SCREENSHOT DETAIL 1 DISINI]` |
| *Desain UI Login baru* | *Carousel, Kategori & Daftar Populer* | *UI Detail Resep baru* |

| Detail Resep (Bawah) | Menu Samping (Drawer) | Halaman Pengaturan |
| :---: | :---: | :---: |
| `[MASUKKAN SCREENSHOT DETAIL 2 DISINI]` | `[MASUKKAN SCREENSHOT DRAWER DISINI]` | `[MASUKKAN SCREENSHOT PENGATURAN DISINI]` |
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
resepku/ ├── assets/ │ ├── images/ │ │ ├── brownies.jpg │ │ └── nasi_goren.jpg │ └── dummy_recipes.json ├── lib/ │ ├── models/ │ │ └── recipe_model.dart # Struktur data resep │ ├── providers/ │ │ └── theme_provider.dart # Logika ganti tema │ ├── screens/ │ │ ├── about_page.dart │ │ ├── home_page.dart # Halaman utama │ │ ├── login_page.dart # Halaman login │ │ ├── recipe_detail_page.dart # Halaman detail │ │ ├── recipe_list_page.dart # Halaman daftar per kategori │ │ ├── register_page.dart │ │ ├── search_page.dart # Halaman hasil pencarian │ │ └── settings_page.dart # Halaman pengaturan │ ├── services/ │ │ └── recipe_service.dart # Logika memuat data │ └── main.dart # Entry point, routing, & provider ├── .gitignore # Mengabaikan file build ├── pubspec.yaml # Konfigurasi proyek & dependencies └── README.md # File ini

---

## ⚙️ Cara Menjalankan

1.  Pastikan Anda memiliki [Flutter SDK](https://flutter.dev/docs/get-started/install) terinstal.
2.  *Clone* repositori ini:
    ```bash
    git clone [LINK_REPOSITORI_ANDA_DISINI]
    ```
3.  Pindah ke direktori proyek:
    ```bash
    cd resepku
    ```
4.  Instal semua *dependencies* yang dibutuhkan:
    ```bash
    flutter pub get
    ```
5.  Jalankan aplikasi di emulator atau perangkat fisik:
    ```bash
    flutter run
    ```
