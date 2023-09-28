double extractMonth(String date) {
  try {
    final parts = date.split('-'); // Memecah tanggal menjadi bagian-bagian
    if (parts.length == 3) {
      final day = double.tryParse(parts[0]);
      if (day != null) {
        return day;
      }
    }
  } catch (e) {
    // Menangani kesalahan jika ada
    print('Error: $e');
  }
  return 0.0; // Memberi nilai default jika gagal mengambil hari
}
