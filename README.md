# Web Tabanlı Bilgi Paylaşım Ortamı 

## Çalışma Amacı

<div align="justify">
ASP.NET Mvc yazılım mimarisi kullanılarak kişilerin farklı konularda bilgilerini, düşüncelerini ve tecrübelerini 
diğer insanlarla paylaşabildikleri web tabanlı bir bilgi paylaşım ortamı oluşturulmuştur. Oluşturulmuş olan bu paylaşım
alanı <em>"Blog"</em> ortamında hazırlanmış olup geliştirilmiştir.
</div><br>

Aşağıdaki link üzerinden proje içeriğine ait oluşturulmuş gerekli bilgilendirme metnine ulaşabilirsiniz.

Proje bilgilendirme dökumanına ulaşmak için [tıklayınız](https://drive.google.com/file/d/1YF7qUJi86SV1ZCZwyLv2O3Euis7K2Auk/view?usp=sharing).

## Çalışma İçeriği

 Çalışmaya ait Microsoft SQL Server üzerinde oluşturulmuş ilişkisel veritabanı diyagramı aşağıdaki gibidir. 
 
![Ekran görüntüsü 2022-04-21 021800](https://user-images.githubusercontent.com/85406429/164340145-010ba288-a506-42fd-a04a-31bb88b8fee5.png)

 <div align="justify">
  
  Geliştirilmiş olan <em>"Blog"</em> ortamı aşağıda verilen özellikler dahilinde tasarlanmıştır.
  
  1. ***Admin Paneli*** <br>
  Admin paneli, paylaşım yapılacak makalelerin kategori ve etiket bölümlerinin belirlenmesi adına ekleme, silme ve güncelleme işlemlerinin yapıldığı, yayınlanması istenen makale/makalelerin ekleme, silme ve güncelleme işlemlerinin gerçekleştirildiği, paylaşım yapılan tüm makalelerin yönetilebildiği, yazarlar ve kullanıcılar tarafından paylaşım yapılan tüm yorum ve makalelerin sistem üzerinde yayınlanmadan önce onay işleminin gerçekleştirildiği, paylaşımlara ait yorumların silinebildiği ve üye olan kullanıcılar arasından yazar olup paylaşım yapmak isteyen kullanıcılara yetki verildiği bölümlerden oluşmaktadır.<br>

  2. ***Yazar Paneli*** <br>
  Yazar paneli, yazar olma yetkisine sahip kullanıcıların kendilerine özgü paylaşımların yapılabildiği ve ilgili yazara ait yapılmış olan tüm paylaşımların görüntülenip içeriğinin tekrardan düzenlenebildiği bölümlerden oluşmaktadır.<br>
 
  3. ***Rol Bazlı Yetki Kontrolü*** <br>
  Sistem üzerinden role dayalı erişim kontrolü proje içerisindeki <em>"App.Classes"</em> dosyası içerisinde eklenen <em>"CustomRoleProvider.cs"</em> sınıfı aracılığıyla sağlanmış ve sınıf içerisinde bulunan <em>"GetRolesForUser"</em> metodu ile oturum açan kullanıcının rol adı geriye döndürülmüştür. Giriş yapan kullanıcının sayfalar üzerindeki erişim kontrolü <em>("Authorization")</em>, kimlik kontrolü ise <em>("Authentication")</em> ile gerçekleştirilmiştir.
 
  4. ***Makale Başlıklarından Arama Yapma(Search)*** <br>
  Paylaşım yapılmış tüm makalelerin başlık ve içerikleri üzerinden istenilen sözcüklere bağlı arama yapılabilmekte ve sorgu sonucu etkilenen kayıtlar   filtrelenebilmektedir.
 
  5. ***Görüntülenme Ve Beğeni Sayısı*** <br>
  Sistem üzerinden paylaşım yapılan her bir makale görüntülenme ve beğeni sayısına sahiptir.
 
  6. ***Görüntülenme Sayısına Göre Popüler Makalelerin Listelenmesi*** <br>
  Paylaşım yapılan makaleler arasından görüntülenme sayısı en fazla 3 makale ana sayfa üzerinde listelenmektedir.
 
  7. ***Paylaşımları Ait Yorumlar Yapabilme*** <br>
  Sistem üzerinden sadece kayıtlı kullanıcılar paylaşım yapılan makalelere yorum/yorumlar yapabiliyorken yorum yapan kişiler yorumları yayınlandıktan daha sonra   silme yetkisine sahiptir. Her bir paylaşıma yapılmış olan yorum sayıları veritabanında kaydedilmektedir.
 
  8. ***Etiket, Etiketlere Bağlı Makaleler Ve Etiketlere Bağlı Makale Sayıları*** <br>
  Admin panel üzerinden açılmış her bir etiket, etikete bağlı paylaşım yapılan makaleler ve sayıları ana sayfa üzerinde görüntülenmektedir.
 
  9. ***Kategori, Kategorilere Bağlı Makaleler Ve Kategorilere Bağlı Makale Sayıları*** <br>
  Admin panel üzerinden açılmış her bir kategori adı, kategorilere bağlı paylaşım yapılan makaleler ve sayıları ana sayfa üzerinde görüntülenmektedir.
 
  10. ***Log Kaydı Tutma*** <br>
  Geliştirilmiş uygulamada kullanıcıların sistem üzerindeki hareketlerini gözlemleme amacıyla basit olarak log tutma işlemi yapılmıştır. Log kaydı tutmak için proje içerisinde <em>"LogKayıtAttributes.cs"</em> sınıfı oluşturulmuş ve metot ile ilgili sayfa açılmadan hemen önce <em>"OnActionExecuting"</em> devreye girmekte ve log tutma işlemi gerçekleştirilmektedir. Loglama işlemi için oluşturulmuş metot kullanıcıların <em>"Hangi Metotlarda Gezindiğini"</em>, <em>"IP"</em> adreslerini, <em>"Tarayıcı"</em> bilgilerini, <em>"Tarihi"</em>, <em>"Controller adını"</em> ve <em>"Üyenin kullanıcı adı"</em> bilgisini veritabanında bulunan log tablosuna kaydetmektedir.
 
       ```csharp
        public class LogKayitAttributes : ActionFilterAttribute, IActionFilter
        {
          public override void OnActionExecuting(ActionExecutingContext filterContext)
          {
           
            BlogDB context = new BlogDB();
            Log yenilog = new Log();
            
                yenilog.MetotAdi = filterContext.ActionDescriptor.ActionName + " isimli metot çağrıldı";
                yenilog.IP = filterContext.HttpContext.Request.UserHostAddress;
                yenilog.Tarayici = filterContext.HttpContext.Request.UserAgent;
                yenilog.Tarih = DateTime.Now;
                yenilog.ControllerAdi = filterContext.ActionDescriptor.ControllerDescriptor.ControllerName;
                yenilog.KullaniciAdi = filterContext.HttpContext.User.Identity.Name;
                
            context.Log.Add(yenilog);
            context.SaveChanges();
          }
        }
       ```
  11. ***Şifremi Unuttum Seçeneği İle Şifre Güncelleme İşlemi*** <br>
 Kullanıcı giriş sayfasında bulunan şifremi unuttum seçeneği ile sistem üzerindeki kayıtlı kullanıcıların mail adreslerine gönderilen aktivasyon doğrulama kodu ile parola güncelleme işlemi gerçekleştirilebilmektedir.  
 
  12. ***Beni Hatırla Seçeneği*** <br>
 Kullanıcı giriş sayfasında bulunan beni hatırla seçeneği ile oturum açan kullanıcının sistemden çıkış yapıncaya kadar her defasında <em>"Kullanıcı Adı"</em> ve <em>"Parola"</em> ile giriş yapması engellenmiş ve çıkış yapılıncaya kadar oturum işleminin açık tutulması sağlanmıştır.
 
</div>

## Proje Ekran Görüntüleri

Aşağıda geliştirilmiş olan projenin ana sayfasına ait ekran çıktısı görülmektedir. 

![Ana_Sayfa1](https://user-images.githubusercontent.com/85406429/164337169-c9c1434d-768b-4cd2-81f9-f6c44070ec2e.png)
![Ana_Sayfa2](https://user-images.githubusercontent.com/85406429/164337183-51087f9f-aff0-4309-bb3c-44fa28a77aea.png)
![Ana_Sayfa3](https://user-images.githubusercontent.com/85406429/164337390-b5a08a85-18ed-41e9-b735-954da3322949.png)
![Makale_Detay](https://user-images.githubusercontent.com/85406429/164337880-70f3f4a3-c6c3-418f-9928-92c2a2952647.png)

## Kullanılan Teknolojiler
- ASP.NET Framework 4.7.2 Mvc
- Microsoft SQL Server Database
- Entity Framework DBFİRST Yaklaşımı
- Bootstrap
- Jquery
- Javascript
- HTML
- CSS

## Öngereklilikler
- Visual Studio 2019
- Microsoft SQL Server Management Studio 2018
- .NET Framework 4.7.2

## Nasıl Çalıştırırım?

<div align="justify">
Projeye ait gerekli dosyaları bilgisayarınıza indirdikten sonra .sql uzantılı <em>"BlogDB"</em> scriptini <em>"Execute"</em> ettikten sonra projeye ait gerekli veritabanı ve veritabanı tabloları SQL Server'ınız içerisinde oluşturulmuş olucaktır. Daha sonra indirmiş olduğunuz klasör içerisindeki sln uzantılı <em>"Blog.sln"</em> dosyasını açınız. Projeye ait solution üzerine sağ tıklayıp ilk önce <em>"Clean Solution"</em> seçeneğini ardından ise <em>"Rebuild Solution"</em>'ı seçerek projeyi derleyiniz. Derleme işlemlerini başarıyla tamamlandıktan sonra projeyi çalıştırabilirsiniz.  
</div>

## Çalışmaya Ait Detaylı Videolu Anlatım

Aşağıda bulunan youtube linkinden geliştirilmiş olan çalışmaya ait detaylı videolu anlatıma ulaşabilirsiniz.   

[![Everything Is AWESOME](https://user-images.githubusercontent.com/85406429/164260974-cf2dd6f6-e1d0-4cb3-aed2-f0203b955a39.png)](https://www.youtube.com/watch?v=knusr2Et8As)


