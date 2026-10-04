FilmSepeti — TechCareerNet Final Project (SwiftUI)

**TR:** TechCareerNet bitirme kapsamında geliştirilen bir **film sipariş** uygulaması: sepete ekleme/çıkarma, hızlı ekleme, toplu silme ve grid listeleme akışlarını gösterir.  
**EN:** A **movie ordering** app for the TechCareerNet capstone: add/remove to cart, quick add, bulk delete, and grid-based listing.

---

## Özellikler (TR)
- Hızlı sepete ekleme, adet güncelleme
- Sepetten silme ve **toplu silme**
- Grid listeleme + detay sayfası (fiyat/puan)
- Yükleniyor / hata durumları
- **MVVM + Repository**, async/await networking

## Features (EN)
- Quick add-to-cart with quantity update
- Remove from cart & **bulk delete**
- Grid listing + detail view (price/rating)
- Loading / error states
- **MVVM + Repository**, async/await networking

---

## Teknolojiler / Tech Stack
- Swift 5+, SwiftUI, URLSession (async/await)
- MVVM, Repository pattern

---

## Mimari / Architecture
- **Views:** Home (grid), Detail, Cart  
- **ViewModels:** `MoviesViewModel`, `CartViewModel`  
- **Repository:** `MoviesRepository : MoviesRepo`  
- **Models:** `Movie`, `CartItem`  
- **State:** `@State`, `@ObservedObject`, `@EnvironmentObject`

<p align="center">
  <a href="https://github.com/user-attachments/assets/8e52bcb0-b3c7-4e19-91cf-e07a0d05b8fb">
    <img src="https://github.com/user-attachments/assets/8e52bcb0-b3c7-4e19-91cf-e07a0d05b8fb" alt="Screen 1" width="280">
  </a>
  <a href="https://github.com/user-attachments/assets/e736a775-dbf8-4ebc-9add-8828fdfab200">
    <img src="https://github.com/user-attachments/assets/e736a775-dbf8-4ebc-9add-8828fdfab200" alt="Screen 2" width="280">
  </a>
  <a href="https://github.com/user-attachments/assets/fb0d8384-6111-457a-848b-c71d76d88615">
    <img src="https://github.com/user-attachments/assets/fb0d8384-6111-457a-848b-c71d76d88615" alt="Screen 3" width="280">
  </a>
</p>

<p align="center">
  <a href="https://github.com/user-attachments/assets/cc9ed94c-3dd8-411f-89ae-085abf084715">
    <img src="https://github.com/user-attachments/assets/cc9ed94c-3dd8-411f-89ae-085abf084715" alt="Screen 4" width="280">
  </a>
  <a href="https://github.com/user-attachments/assets/de100794-d9a5-4d0d-9211-3655e65f7047">
    <img src="https://github.com/user-attachments/assets/de100794-d9a5-4d0d-9211-3655e65f7047" alt="Screen 5" width="280">
  </a>
  <a href="https://github.com/user-attachments/assets/de0788a1-d7e2-4dc9-a59b-b50c7bad0856">
    <img src="https://github.com/user-attachments/assets/de0788a1-d7e2-4dc9-a59b-b50c7bad0856" alt="Screen 6" width="280">
  </a>
</p>
