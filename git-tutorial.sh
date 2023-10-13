#!/bin/bash

# Bu script, git komutlarının nasıl kullanılacağını göstermek için hazırlanmıştır.

REPO_URL="https://github.com/algoritimbilisim/git-tutorial"

# Komutları panoya kopyalamak için kullanılacak fonksiyon
copy_to_clipboard() {
    if command -v xclip > /dev/null; then
        echo -n "$1" | xclip -selection clipboard
    elif command -v pbcopy > /dev/null; then
        echo -n "$1" | pbcopy
    else
        echo "Panoya kopyalama aracı bulunamadı. xclip için aşağıdaki komutu kullanabilirsiniz veya kendi platformunuzdaki kopyalama aracını araştırabilirsiniz."
        echo "sudo apt install xclip"
        exit 1
    fi
}

# Komutları adım adım çalıştırmak için kullanılacak fonksiyon
run_step() {
    echo "------------------------------"
    echo -e "Adım: $1"
    echo "Komut: $2"
    echo "------------------------------"
    copy_to_clipboard "$2"
    read -p "Bu komutu denemek için panodan yapıştırın. Sonraki adıma devam etmek için ENTER tuşuna basın..."
}

# Adımlar

echo "Bu script dosyası içerisinde git komutları ve Github kullanımı incelenmiştir. Git bir versiyon kontrol sistemidir. Ekiple veya tekil çalışmalarda kodlarınızın standart bir şekilde versiyonlanmasına yardımcı olur. Ayrıca aynı dosya üzerinde çalışma durumlarında uyumsuzluk(conflict) varsa çözmeyi sağlar. Özellikle ekip çalışmalarında çok önemlidir."

echo -e "\e[5;33mİçeriği beğenirseniz Youtube kanalımızı takip etmeyi, beğenmeyi, yorumlamayı ve paylaşmayı unutmayın :) \e[0m"

echo -e "\e[1;33mKanal Linki: https://www.youtube.com/@algoritimbilisim \e[0m"

read -p "Birinci yöntem: Klonlama. Github'dan repo oluşturup geriye dönün. Sonraki adıma devam etmek için ENTER tuşuna basın..."

run_step "Repo'yu klonlama" "git clone $REPO_URL"

run_step "Klonlanmış repoya giriş yapma" "cd git-tutorial"

run_step "Durumu kontrol etme: Şu anda main dalındayız ve uzak repo ile güncel durumdayız" "git status"

run_step "Dizin içeriğini  görme: Buradaki içerik main dalındaki içeriktir" "ls -l"

run_step "İkinci yöntem: Yerelden başlama. Önce bir önceki dizine gidin." "cd .."

run_step "Klonlanmış repoyu silme" "sudo rm -r git-tutorial"

run_step "Yeni repo dizini oluşturma ve içine girme" "mkdir git-tutorial-local && cd  git-tutorial-local"

run_step "Yeni yerel repo oluşturma" "git init"

run_step "Yeni yerel reponun durumunu görme" "git status"

run_step "Yerel reponun ana dalını yeniden adlandırma. master->main" "git branch -M main"

run_step "Yerel repoya remote(uzak) repoyu bağlama" "git remote add origin git@github.com:algoritimbilisim/git-tutorial.git"

echo "İki yöntemle de ulaşılacak ortak nokta burası"

run_step "Bir branch oluşturma: \e[33m\n-----main\n  \\ \n   ----kullanici1\e[0m" "git branch kullanici1"

run_step "İkinci bir branch oluşturma: \e[33m\n-----main\n  \\ \n   ----kullanici2\e[0m" "git checkout -b kullanici2"

run_step "Dizin içeriğini  görme. Buradaki içerik main ile aynıdır" "ls -l"

run_step "Dal değişiklikleri sonrası durumu kontrol etme" "git status"

run_step "Dosya değişiklikliği" "echo 'Bu kullanıcı2 in içeriği'> yeni_dosya.txt"

run_step "Dizin içeriğini  görme" "ls -l"

run_step "Dosya değişiklikliğini görme" "cat yeni_dosya.txt"

run_step "Dosya değişiklikleri sonrası durumu kontrol etme" "git status"

run_step "Değişiklikleri stage'e ekleme/Değişiklikleri Kabul Etme" "git add ."

run_step "Commit oluşturma/Onaylama" "git commit -m 'kullanıcı2 in içeriği eklendi'"

run_step "Yerel değişiklikleri uzaktaki repoya gönderme" "git push --set-upstream origin kullanici2"

run_step "Bu aşamada işlemleri Github üzerinden devam ettirmelisiniz. \nGithub'da pull request ve merge işlemleri yapılacak.\nİşlemler sonucunda kullanici2 içindekiler main'e aktarılacak.\e[33m\n-----main\n       / \n----kullanici2\e[0m" "$REPO_URL"

run_step "kullanici1 adlı branch'e girme" "git checkout kullanici1"

run_step "Dizin içeriğini  görme. Buradaki içerik main ve kullanici2 ile farklı" "ls -l"

run_step "Dal değişiklikleri sonrası durumu kontrol etme" "git status"

run_step "Dosya değişiklikliği" "echo 'Bu kullanıcı1 in içeriği'> yeni_dosya.txt"

run_step "Dizin içeriğini  görme" "ls -l"

run_step "Dosya değişiklikliğini görme" "cat yeni_dosya.txt"

run_step "Dosya değişiklikleri sonrası durumu kontrol etme" "git status"

run_step "Değişiklikleri stage'e ekleme/Değişiklikleri Kabul Etme" "git add ."

run_step "Commit oluşturma/Onaylama" "git commit -m 'kullanıcı1 in içeriği eklendi'"

run_step "Yerel değişiklikleri uzaktaki repoya gönderme" "git push --set-upstream origin kullanici1"

run_step "Bu aşamada işlemleri Github üzerinden devam ettirmelisiniz. \nGithub'da pull request ve merge işlemleri yapılacak.\nİşlemler sonucunda kullanici1 içindekiler main'e aktarılacak.\e[33m\n-----main\n       / \n----kullanici1\e[0m" "$REPO_URL"

echo "Uzak repo'daki main en güncel, önce yereldeki main dalı sonra diğer dalların hepsi güncellenmeli"

run_step "main branch'e geçiş yapma" "git checkout main"

run_step "Branch'leri listeleme" "git branch"

run_step "Uzaktaki değişiklikleri alma" "git pull"

run_step "Güncellemek için kullanıcı1 dalına git" "git checkout kullanici1"

run_step "kullanici1 adlı branch'i güncelleme: \e[33m\n-----main\n  \\!değişiklikler \n   ----kullanici1\e[0m" "git rebase main"

run_step "Dizin içeriğini  görme" "ls -l"

run_step "Güncellemek için kullanıcı2 dalına git" "git checkout kullanici2"

run_step "kullanici2 adlı branch'i güncelleme: \e[33m\n-----main\n  \\!değişiklikler \n   ----kullanici2\e[0m" "git rebase main"

run_step "Dizin içeriğini  görme" "ls -l"

echo "Tüm adımlar tamamlandı! Artık herkes güncel"

echo -e "\e[5;33mİçeriği beğenirseniz Youtube kanalımızı takip etmeyi, beğenmeyi, yorumlamayı ve paylaşmayı unutmayın :) \e[0m"

echo -e "\e[1;33mKanal Linki: https://www.youtube.com/@algoritimbilisim \e[0m"
