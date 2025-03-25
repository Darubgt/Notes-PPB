# Tugas PPB (Assignment (Github Repo URL)- 25/03/2025 18.00 GMT+7)

Orginal : https://github.com/nikolavish/flutter-notes-app

# Approach

Aplikasi ini mengimplementasi aksi CRUD dengan bantuan JSON. Approach ini tidak menggunakan database dan data bisa tersimpan tidak seperti
tugas kemarin dimana data string disimplan di list. Jadi saat aplikasi di close data akan tetap tersimpan. Dua widget utama pada aplikasi ini
adalah notesscreen dan notescreen. NotesScreen adalah home untuk semua note-note yang dibuat. Sedangkan NoteScreen adalah tempat dimana user
bisa membuat notenya, edit, dan delete. 

Jadi workflow adalah saat user membuat notes baru dengan menekan tombol '+' di kanan atas. Action dari tombol tersebut akan menggunakan Navigator
untuk memunculkan notescreen. Aksi ini juga menggunakan await agar menunggu note selesai di tulis. Saat sudah selesai maka akan balik ke NotesScreen.

Cara kerja penambahan tulisan di notesnya adalah dengan bantuan TextFormField. Lalu agar responsive ditambahkan onChange agar saat berubah tampilannya
juga akan berubah. Data stringnya akan disimpan di variable value yang berasal dari class 'note'. Disini tiap note dibuat dari class note via 'components/note.dart'. isi dari class adalah informasi
text seperti title dan isinya. Selain itu disini adalah otak dari save agar tersimpan ke JSON. Disini aplikasi menggunakan
bantuan package path_provider yang akan membantu tempat directory json akan tersimpan. Lalu JSON akan dibaca dan di decode
agar menjadi list. Dari situ list akan berisi informasi semua note. Function yang bertanggung jawab atas tugas ini adalah
readData(). Dari situ class note bisa tahu index note yang akan di save berada. Lalu data value yang diambil dari TextFormField tadi
akan ditambahkan ke List hasil readData() tadi dan akan di ubah formatnya menjadi JSON dan di encode menjadi JSON dan filenya akan
di save. 

Jadi di NoteScreen akan adalah tombol save dan delete yang akan menjalankan fungsi save() dan delete() respectively. Jika save() cara berjalannya adalah
penjelasan di atas, maka delete mirip sekali dimana index yang didapat dari readData() dipakai untuk hapus datanya. Untuk aksi editnya, sebenarnya sama seperti
saat add terjadi. Bedanya disini jika add, maka function tidak akan passing parameter. Tetapi jika edit maka akan passing parameter note. Jadi untuk edit di NotesScreen
masing-masing note akan diberi onTap yang akan menjalankan function dan passing note yang di tap. Jadi proses save setelah edit juga sama. 

Video Demo :

https://github.com/user-attachments/assets/7529036b-462d-430a-a021-3f16dd33fbf0

