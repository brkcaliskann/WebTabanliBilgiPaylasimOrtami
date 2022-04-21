--BlogDB adında veritabanı oluşturma. 
Create DATABASE BlogDB
GO

--Oluşturulmuş BlogDB veritabanına kullanarak tabloları oluşturma.
USE [BlogDB]
GO
/****** Object:  Table [dbo].[Etiket]    Script Date: 21.04.2022 16:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Etiket](
	[EtiketID] [int] IDENTITY(1,1) NOT NULL,
	[Adi] [nvarchar](50) NULL,
	[AktifMİ] [bit] NULL,
 CONSTRAINT [PK_dbo.Etiket] PRIMARY KEY CLUSTERED 
(
	[EtiketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kategori]    Script Date: 21.04.2022 16:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kategori](
	[KategoriID] [int] IDENTITY(1,1) NOT NULL,
	[Adi] [nvarchar](50) NOT NULL,
	[Aciklama] [nvarchar](500) NULL,
 CONSTRAINT [PK_dbo.Kategori] PRIMARY KEY CLUSTERED 
(
	[KategoriID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kullanici]    Script Date: 21.04.2022 16:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kullanici](
	[KullaniciID] [int] IDENTITY(1,1) NOT NULL,
	[Adi] [nvarchar](50) NULL,
	[Soyadi] [nvarchar](100) NULL,
	[DogumTarihi] [datetime] NULL,
	[Mail] [nvarchar](50) NULL,
	[KullaniciAdi] [nvarchar](50) NULL,
	[Parola] [nvarchar](50) NULL,
	[KayitTarihi] [datetime] NULL,
	[OnaylandiMi] [bit] NULL,
	[YazarMi] [bit] NULL,
	[AktifMi] [bit] NULL,
	[Hakkinda] [nvarchar](1000) NULL,
	[BeniHatirla] [bit] NOT NULL,
	[ResimID] [int] NULL,
 CONSTRAINT [PK_dbo.Kullanici] PRIMARY KEY CLUSTERED 
(
	[KullaniciID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KullaniciRol]    Script Date: 21.04.2022 16:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KullaniciRol](
	[KullaniciID] [int] NOT NULL,
	[RolID] [int] NOT NULL,
	[KullaniciRolID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_dbo.KullaniciRol] PRIMARY KEY CLUSTERED 
(
	[KullaniciID] ASC,
	[RolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 21.04.2022 16:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[MetotAdi] [nvarchar](50) NULL,
	[IP] [nvarchar](50) NULL,
	[Tarayici] [nvarchar](max) NULL,
	[Tarih] [datetime] NULL,
	[ControllerAdi] [nvarchar](50) NULL,
	[KullaniciAdi] [nvarchar](50) NULL,
 CONSTRAINT [PK_dbo.Log] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Makale]    Script Date: 21.04.2022 16:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Makale](
	[MakaleID] [int] IDENTITY(1,1) NOT NULL,
	[Baslik] [nvarchar](100) NULL,
	[Icerik] [nvarchar](max) NULL,
	[EklenmeTarihi] [datetime] NULL,
	[GoruntulenmeSayisi] [int] NULL,
	[BegeniSayisi] [int] NULL,
	[KategoriID] [int] NULL,
	[EtiketID] [int] NULL,
	[ResimID] [int] NULL,
	[KullaniciID] [int] NULL,
	[AktifMi] [bit] NULL,
	[OnaylandiMi] [bit] NULL,
 CONSTRAINT [PK_dbo.Makale] PRIMARY KEY CLUSTERED 
(
	[MakaleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MakaleEtiket]    Script Date: 21.04.2022 16:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MakaleEtiket](
	[MakaleID] [int] NOT NULL,
	[EtiketID] [int] NOT NULL,
	[MakaleEtiketID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_dbo.MakaleEtiket] PRIMARY KEY CLUSTERED 
(
	[MakaleID] ASC,
	[EtiketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Resim]    Script Date: 21.04.2022 16:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Resim](
	[ResimID] [int] IDENTITY(1,1) NOT NULL,
	[KucukBoyutResim] [nvarchar](250) NULL,
	[OrtaBoyutResim] [nvarchar](250) NULL,
	[BuyukBoyutResim] [nvarchar](250) NULL,
	[MakaleID] [int] NULL,
 CONSTRAINT [PK_dbo.Resim] PRIMARY KEY CLUSTERED 
(
	[ResimID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 21.04.2022 16:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rol](
	[RolID] [int] IDENTITY(1,1) NOT NULL,
	[RolAdi] [nvarchar](50) NULL,
 CONSTRAINT [PK_dbo.Rol] PRIMARY KEY CLUSTERED 
(
	[RolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Yorum]    Script Date: 21.04.2022 16:27:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Yorum](
	[YorumID] [int] IDENTITY(1,1) NOT NULL,
	[Icerik] [nvarchar](1500) NULL,
	[EklenmeTarihi] [datetime] NULL,
	[AktifMi] [bit] NOT NULL,
	[MakaleID] [int] NULL,
	[OnaylandiMi] [bit] NULL,
	[KullaniciID] [int] NULL,
 CONSTRAINT [PK_dbo.Yorum] PRIMARY KEY CLUSTERED 
(
	[YorumID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Etiket] ON 

INSERT [dbo].[Etiket] ([EtiketID], [Adi], [AktifMİ]) VALUES (1, N'YAZILIM GELİŞTİRİCİ', 1)
INSERT [dbo].[Etiket] ([EtiketID], [Adi], [AktifMİ]) VALUES (2, N'YÖNETİM ', 1)
INSERT [dbo].[Etiket] ([EtiketID], [Adi], [AktifMİ]) VALUES (3, N'GİTHUB', 1)
INSERT [dbo].[Etiket] ([EtiketID], [Adi], [AktifMİ]) VALUES (4, N'MOBİL UYGULAMA NEDİR', 1)
INSERT [dbo].[Etiket] ([EtiketID], [Adi], [AktifMİ]) VALUES (5, N'YAZILIM GELİŞTİRİCİ KİTAP ÖNERİLERİ', 1)
INSERT [dbo].[Etiket] ([EtiketID], [Adi], [AktifMİ]) VALUES (6, N'YÜZ TANIMA TEKNOLOJİSİ', 1)
INSERT [dbo].[Etiket] ([EtiketID], [Adi], [AktifMİ]) VALUES (7, N'YAPAY ZEKA', 1)
INSERT [dbo].[Etiket] ([EtiketID], [Adi], [AktifMİ]) VALUES (8, N'OPEN SOURCE', 1)
INSERT [dbo].[Etiket] ([EtiketID], [Adi], [AktifMİ]) VALUES (9, N'INSTAGRAM', 1)
INSERT [dbo].[Etiket] ([EtiketID], [Adi], [AktifMİ]) VALUES (10, N'JAVA', 1)
INSERT [dbo].[Etiket] ([EtiketID], [Adi], [AktifMİ]) VALUES (11, N'SANAL GERÇEKLİK', 1)
INSERT [dbo].[Etiket] ([EtiketID], [Adi], [AktifMİ]) VALUES (12, N'TEKNOLOJİK GELİŞMELER', 1)
SET IDENTITY_INSERT [dbo].[Etiket] OFF
GO
SET IDENTITY_INSERT [dbo].[Kategori] ON 

INSERT [dbo].[Kategori] ([KategoriID], [Adi], [Aciklama]) VALUES (1, N'Yazılım', N'Yazılım Hakkında')
INSERT [dbo].[Kategori] ([KategoriID], [Adi], [Aciklama]) VALUES (2, N'Kariyer Tavsiyeleri', N'Kariyer Tavsiyeleri Hakkında')
INSERT [dbo].[Kategori] ([KategoriID], [Adi], [Aciklama]) VALUES (3, N'Web Yazılım', N'Web Yazılım Hakkında')
INSERT [dbo].[Kategori] ([KategoriID], [Adi], [Aciklama]) VALUES (4, N'Teknoloji', N'Teknoloji Hakkında')
INSERT [dbo].[Kategori] ([KategoriID], [Adi], [Aciklama]) VALUES (5, N'Mobil Uygulama', N'Mobil Uygulama Hakkında')
SET IDENTITY_INSERT [dbo].[Kategori] OFF
GO
SET IDENTITY_INSERT [dbo].[Kullanici] ON 

INSERT [dbo].[Kullanici] ([KullaniciID], [Adi], [Soyadi], [DogumTarihi], [Mail], [KullaniciAdi], [Parola], [KayitTarihi], [OnaylandiMi], [YazarMi], [AktifMi], [Hakkinda], [BeniHatirla], [ResimID]) VALUES (3, N'Admin', N'Admin', CAST(N'2022-04-07T00:00:00.000' AS DateTime), N'Admin@gmail.com', N'Admin', N'1', CAST(N'2022-04-16T17:20:53.057' AS DateTime), 1, 1, 1, N'Admin', 0, 6)
INSERT [dbo].[Kullanici] ([KullaniciID], [Adi], [Soyadi], [DogumTarihi], [Mail], [KullaniciAdi], [Parola], [KayitTarihi], [OnaylandiMi], [YazarMi], [AktifMi], [Hakkinda], [BeniHatirla], [ResimID]) VALUES (4, N'Baki', N'Can', CAST(N'2022-04-07T00:00:00.000' AS DateTime), N'baki@gmail.com', N'Baki', N'1', CAST(N'2022-04-16T17:20:53.057' AS DateTime), 1, 1, 1, N'Baki Can kullanıcının hakkında bölümü', 0, 6)
INSERT [dbo].[Kullanici] ([KullaniciID], [Adi], [Soyadi], [DogumTarihi], [Mail], [KullaniciAdi], [Parola], [KayitTarihi], [OnaylandiMi], [YazarMi], [AktifMi], [Hakkinda], [BeniHatirla], [ResimID]) VALUES (5, N'Burak', N'Çalışkan', CAST(N'2022-04-07T00:00:00.000' AS DateTime), N'CaliskanBurak97@gmail.com', N'Burak', N'1', CAST(N'2022-04-16T17:18:28.680' AS DateTime), 1, 1, 1, N'Burak Çalışkan adlı kullanıcının hakkında bölümü', 0, 2)
INSERT [dbo].[Kullanici] ([KullaniciID], [Adi], [Soyadi], [DogumTarihi], [Mail], [KullaniciAdi], [Parola], [KayitTarihi], [OnaylandiMi], [YazarMi], [AktifMi], [Hakkinda], [BeniHatirla], [ResimID]) VALUES (6, N'Ayşen', N'Aksoy', CAST(N'2022-04-12T00:00:00.000' AS DateTime), N'Aysen@gmail.com', N'Aysen', N'1', CAST(N'2022-04-18T14:44:20.010' AS DateTime), 1, 1, 1, N'Ayşen Aksoy adlı kullanıcının hakkında bölümü', 0, 24)
INSERT [dbo].[Kullanici] ([KullaniciID], [Adi], [Soyadi], [DogumTarihi], [Mail], [KullaniciAdi], [Parola], [KayitTarihi], [OnaylandiMi], [YazarMi], [AktifMi], [Hakkinda], [BeniHatirla], [ResimID]) VALUES (7, N'Ozan', N'Çiftçi', CAST(N'2022-04-11T00:00:00.000' AS DateTime), N'Ozan@gmail.com', N'Ozan', N'1', CAST(N'2022-04-16T17:14:55.237' AS DateTime), 0, 0, 1, NULL, 0, NULL)
INSERT [dbo].[Kullanici] ([KullaniciID], [Adi], [Soyadi], [DogumTarihi], [Mail], [KullaniciAdi], [Parola], [KayitTarihi], [OnaylandiMi], [YazarMi], [AktifMi], [Hakkinda], [BeniHatirla], [ResimID]) VALUES (8, N'Melek', N'Güler', CAST(N'2022-04-02T00:00:00.000' AS DateTime), N'Melek@gmail.com', N'Melek', N'1', CAST(N'2022-04-16T17:19:14.933' AS DateTime), 1, 1, 1, N'Melek Güler adlı kullanıcının hakkında bölümü', 0, 3)
INSERT [dbo].[Kullanici] ([KullaniciID], [Adi], [Soyadi], [DogumTarihi], [Mail], [KullaniciAdi], [Parola], [KayitTarihi], [OnaylandiMi], [YazarMi], [AktifMi], [Hakkinda], [BeniHatirla], [ResimID]) VALUES (9, N'Selin', N'Hancı', CAST(N'2022-04-29T00:00:00.000' AS DateTime), N'Selin@gmail.com', N'Selin', N'1', CAST(N'2022-04-16T17:19:47.023' AS DateTime), 1, 1, 1, N'Selin Hancı kullanıcının hakkında bölümü', 0, 4)
INSERT [dbo].[Kullanici] ([KullaniciID], [Adi], [Soyadi], [DogumTarihi], [Mail], [KullaniciAdi], [Parola], [KayitTarihi], [OnaylandiMi], [YazarMi], [AktifMi], [Hakkinda], [BeniHatirla], [ResimID]) VALUES (10, N'Can', N'Güven', CAST(N'2022-03-29T00:00:00.000' AS DateTime), N'Can@gmail.com', N'Can', N'1', CAST(N'2022-04-16T17:20:20.510' AS DateTime), 1, 1, 1, N'Can Güven kullanıcının hakkında bölümü', 0, 5)
SET IDENTITY_INSERT [dbo].[Kullanici] OFF
GO
SET IDENTITY_INSERT [dbo].[KullaniciRol] ON 

INSERT [dbo].[KullaniciRol] ([KullaniciID], [RolID], [KullaniciRolID]) VALUES (3, 1, 7)
INSERT [dbo].[KullaniciRol] ([KullaniciID], [RolID], [KullaniciRolID]) VALUES (4, 2, 9)
INSERT [dbo].[KullaniciRol] ([KullaniciID], [RolID], [KullaniciRolID]) VALUES (4, 3, 16)
INSERT [dbo].[KullaniciRol] ([KullaniciID], [RolID], [KullaniciRolID]) VALUES (5, 2, 10)
INSERT [dbo].[KullaniciRol] ([KullaniciID], [RolID], [KullaniciRolID]) VALUES (5, 3, 17)
INSERT [dbo].[KullaniciRol] ([KullaniciID], [RolID], [KullaniciRolID]) VALUES (6, 2, 11)
INSERT [dbo].[KullaniciRol] ([KullaniciID], [RolID], [KullaniciRolID]) VALUES (6, 3, 21)
INSERT [dbo].[KullaniciRol] ([KullaniciID], [RolID], [KullaniciRolID]) VALUES (7, 2, 12)
INSERT [dbo].[KullaniciRol] ([KullaniciID], [RolID], [KullaniciRolID]) VALUES (8, 2, 13)
INSERT [dbo].[KullaniciRol] ([KullaniciID], [RolID], [KullaniciRolID]) VALUES (8, 3, 18)
INSERT [dbo].[KullaniciRol] ([KullaniciID], [RolID], [KullaniciRolID]) VALUES (9, 2, 14)
INSERT [dbo].[KullaniciRol] ([KullaniciID], [RolID], [KullaniciRolID]) VALUES (9, 3, 19)
INSERT [dbo].[KullaniciRol] ([KullaniciID], [RolID], [KullaniciRolID]) VALUES (10, 2, 15)
INSERT [dbo].[KullaniciRol] ([KullaniciID], [RolID], [KullaniciRolID]) VALUES (10, 3, 20)
SET IDENTITY_INSERT [dbo].[KullaniciRol] OFF
GO
SET IDENTITY_INSERT [dbo].[Makale] ON 

INSERT [dbo].[Makale] ([MakaleID], [Baslik], [Icerik], [EklenmeTarihi], [GoruntulenmeSayisi], [BegeniSayisi], [KategoriID], [EtiketID], [ResimID], [KullaniciID], [AktifMi], [OnaylandiMi]) VALUES (1, N'TÜRKİYE, 140 BİN YAZILIM GELİŞTİRİCİSYLE AVRUPA''DA 12. OLDU', N'Teknoloji ile alakalı basına yansıyan haber adetlerini inceleyen Ajans Press, PRNet’in de dijital basın basın arşivinden derlediği bilgilere göre bu yıl teknoloji ile alakalı basında 50 bin 570 haberin yer aldığını tespit etti.

Yazılımlarla ilgili yapılan haber adetlerine bakıldığı zaman ise geçen yıldan bu yana 30 bin 136 haber olduğu görüldü. Kontrol edilen haber içerikleri ise son yıllarda yazılım için yapılan yatırımlar dışında, Türkiye’den yapılan yazılım ithalatından, yapay zekâ kullanımına geçişe kadar birçok başlık görüldü.

Birinci Sırada Almanya

Avrupa ülkelerindeki yazılım geliştirici sayıları, Ajans Press’in stackoverflow.com verilerinden elde edilen bilgilere göre açıklandı. Türkiye’de 140 bin yazılım geliştirici olduğu ifade edilirken, birinci sıraya 837 bin ile Almanya’nın yerleştiği açıklandı. Almanya’ya en yakın ülke ise 814 bin ile İngiltere olurken, üçüncü ülke 467 bin yazılım geliştiriciyle Fransa olarak kayıtlara geçti. İlk üçü takip eden ve en çok yazılım geliştiriciye sahip diğer ülkeler ise sırasıyla, Rusya, Hollanda, İtalya, İspanya, Polonya ve Ukrayna olarak sıralandı.

Türkiye ise sıralamaya göre 12. oldu. Türkiye’den sonra gelen bazı ülkeler ise; Romanya, Danimarka, Belçika ve Norveç olarak kayıtlara geçti.', CAST(N'2022-04-18T00:57:30.933' AS DateTime), 5, 7, 1, 1, 7, 5, 1, 1)
INSERT [dbo].[Makale] ([MakaleID], [Baslik], [Icerik], [EklenmeTarihi], [GoruntulenmeSayisi], [BegeniSayisi], [KategoriID], [EtiketID], [ResimID], [KullaniciID], [AktifMi], [OnaylandiMi]) VALUES (12, N'YÜZ TANIMA NEDİR VE NASIL ÇALIŞIR?', N'Kapı zili çalma; hatta evlerimize, ofislerimize ve diğer binalara girmek için anahtarlara ihtiyaç duyma noktasından geleceğe doğru uzun bir yol kat ettik. Teknoloji bize akıllı telefon uygulamaları, parmak izi tarayıcıları ve anahtar kartları verdi. Ve şimdi, yüz tanıma teknolojisi erişimi daha da rahat ve güvenli hale getiriyor. Yine de, geçiş teknolojisindeki en önemli son sıçramalardan biri olan otomatik yüz tanıma hakkında hala birçok gizem ve yanlış kanı var.

Yüz tanıma teknolojilerinin, kameraların ve tarayıcıların birçok çeşidi mevcut. Yüz tanımanın evrimi de son derece hızlı gerçekleşiyor. Bu durum, biyometrik tanımlama teknolojisine itimat etmede hem bazı yararlar hem de bazı zorluklar yaratır.

Birlikte, yüz tanımanın nereden geldiğine, şimdi nerede olduğuna ve sırada ne olduğuna bir bakalım.

Yüz Tanıma Nasıl Çalışır?

Michigan Eyalet Üniversitesi’nde biyometri tanıma uzmanı ve seçkin bir bilgisayar bilimi profesörü olan Anil Jain, “Yüz tanıma yaklaşık yirmi beş yıl önce ciddi şekilde başladı” diyor.

“Ancak erken otomatik yüz tanıma sistemlerinin performansı oldukça zayıftı” diye devam ediyor. “Sabıka fotoğraflarını veya ehliyet fotoğraflarını kontrollü koşullar altında karşılaştırırken bile, sistemin doğruluğu hala çok düşüktü.”

Prof. Jain, 1960’lardan bazı öncü yüz tanıma araştırmaları ve teknolojisine atıfta bulunuyor. Profesör Woody Bledsoe, çoğunlukla ilk yüz haritalama sistemlerini oluşturarak bu alanı ön plana çıkarmasıyla tanınır.

Bugünün yüz tanıma yazılımı, Prof. Bledsoe’nin çalışmalarından bir sürü ışık yılı ileride. Yüz tanıma ile kimliğin -artan doğruluk seviyeleri ile- doğrulanması artık sadece birkaç saniye sürüyor.

Prof. Jain, “Kullanıcılar kısıtlı ortamlarda bulunduklarında ve talimatları izlediklerinde yüzde 99 doğruluk noktasına ulaştık” diyor. “Zorluk, insanların ifadelerine doğrudan komuta edemeyeceğiniz veya kontrol edemeyeceğiniz sınırları belirsiz koşullarda gerçekleşti.”

Teknoloji, sınırlandırılmamış koşullar engelini neredeyse tamamen aştı. En yeni akıllı telefonlar, kullanıcılardan “gülümsemelerini” veya “kameraya bakmalarını” istemez. Bunun nedeni, yazılımın en başından itibaren benzersiz bir kullanıcı yüzleri şablonu oluşturmasıdır.

Her kullanıcıda bu benzersiz şablonları oluşturmak için, resimler birden çok açıdan çekilir. Bu sürece kayıt denir ve bir kullanıcının yüzünün her koşulda tanınmasını sağlar.

İnsanlar ister dışarıda olsun, ister yeni gözlüklerle olsun, ister sakal bıraksın… bugün, yüz tanıma nadiren yanılır.. Ve çoğunlukla, rahatlığı ve güvenliği artırır. Devam eden etik tartışmalara rağmen, yüz tanımanın geleceği parlak ve umut verici görünüyor.

Yüz Tanımanın Zorlukları

Yüz tanıma pazarının 2019’da 3,2 milyar dolar iken 2024’e kadar tahmini 7,0 milyar dolara çıkması bekleniyor. Ancak yoldaki en büyük engellerden bazıları kullanıcı gizliliği, veri güvenliği ve hatta ırkçılığı içeriyor.

Örneğin, Ulusal Standartlar ve Teknoloji Enstitüsü (NIST) yakın zamanda yüz tanıma yazılımının belirli ırklar ve cilt tonları ile ilgili olarak daha düşük doğruluğa sahip olduğunu buldu. Asyalıları doğru bir şekilde tanımlamak daha zordu ve Afrikalı-Amerikalı kadınlarda daha yüksek oranda yanlış pozitif sonuç vardı.

Yüz tanıma modelleri oluşturmak için hangi görüntülerin yasal olarak kullanılabileceği konusunda veri güvenliği ve gizlilik endişeleri de vardır. Çevrimiçi etkinliklerin artması ve kameraların yaygınlaşmasıyla, şirketler veya hükümetler, bilgi veya rıza olmaksızın insanların 3D yüz modelini kolayca oluşturabilir.

Yarının yüz tanıma sistemleri, bilinen suçluları okullardan uzak tutmaya veya akıllı binalarla ve evlerle daha derin entegrasyona yardımcı olabilir. Bankacılık işlemleri veya bir havalimanına girmek -birkaç saniye içinde- güvenli bir şekilde gerçekleşebilir. Jain, makine öğreniminin zamanla, kullanıcılar yaşlandıkça, sistemin kendini yeniden ayarlamasında büyük bir rol oynayacağını tahmin ediyor..

Neyse ki, hükümetler ve özel sektörler, halkın yüz tanıma konusundaki endişelerini gidermek için politik çözümler için el ele çalışıyorlar. Bu teknolojinin kalıcı olduğu artık açık.', CAST(N'2022-04-18T14:14:28.733' AS DateTime), 4, 8, 4, 6, 18, 3, 1, 1)
INSERT [dbo].[Makale] ([MakaleID], [Baslik], [Icerik], [EklenmeTarihi], [GoruntulenmeSayisi], [BegeniSayisi], [KategoriID], [EtiketID], [ResimID], [KullaniciID], [AktifMi], [OnaylandiMi]) VALUES (14, N'ETKİLİ BİR WEB TASARIMI NASIL OLMALIDIR?', N'Web tasarım kişi ya da kurumsal kimliğin tanıtılması için internet ortamındaki en önemli noktalardan biridir. Web sayfası görüntü, ses, video ve metin gibi araçların kullanılması ile oluşturulmuş olan sayfaları düzenler ve internet sitesini oluşturur. Artık internet birçok noktada sıkça kullanıldığı için sanal dünyada tanıtım için internet ve özellikle web tasarım büyük önem kazanmıştır. Web tasarım internet üzerinden tarayıcılar aracılığıyla ulaşıldığı için HTML diline sahiptir. Bu sebeple etkili bir web tasarım için uzman desteği almakta fayda var. Özenli şekilde hazırlanmış olan bir web sitesi sayesinde de istenilen hedef kitleye ulaşmak mümkün olur. Web sitesi ulaşılabilir ve rahat kullanıma sahip olması kullanıcının ilgisini daha çok çekecektir. Kişisel web siteleri sunduğunuz bilgileri ya da hizmeti aktarırken de sizi kullanıcıların ilk olarak tanıyacağı yerdir. Uzman desteği de bu tanıtımın ilk andan itibaren başarılı şekilde kurulmasını sağlar. İnternet dilini ve internette kullanılan görsel tasarımı yaparken alınacak olan profesyonel destek sayesinde de web siteniz kullanıma en uygun ara yüze sahip olacaktır.  Web siteleri kurumlarında kullanıcılara açılan yüzü olduğu için kurum bazında önem teşkil eder. Kurumsal hizmet ve ürün sunumunda web tasarımın tartışılmaz önemi vardır.

Kurumsal Web Tasarımın Avantajları

İnternet kullanımının zamanla artması kuruluşlar için yeni fırsatları da berberinde getiri. Özellikle hedef kitlenin büyümesi ile ulaşılabilirlik artacaktır. Bu noktada da kurumsal web tasarım önem kazanmakta. Kurumun ve sunduğu hizmetin dünyaya açılan önemli kapılarından biri de web sitesinden geçmektedir. Bu konular göz önünde bulundurularak hazırlanmış olan web siteleri tanıtım ve yeni kullanıcılara ulaşılması için oldukça güçlü adımlardır. Kurumsal web tasarım hizmeti alarak hazırlanmış olan web siteleri başarıyı yakalamak konusunda avantajlıdır. Kurumsal web tasarım sunduğunuz hizmetin kolay ve etkili bir biçimde kullanıcıya ulaşmasını sağlar ve bu ne kadar başarılı yapılırsa kurum kimliği o kadar başarılı yansıtılır. Uzman bir destek alarak hazırlanmış olan web sitelerindeki trafik akışı artar ve bu sayede hedef kitle daha geniş bir hale ulaşır. Kurumun tanıtımda en önemli yüzlerinden olan internet sitesi sayesinde kurum imajınızı çizebilirsiniz v bu imajı web tasarım sayesinde sağlayabilirsiniz. Kurum hakkında bilgi veren bir sayfa da tanıtım için uygun olacaktır.

Etkili Bir Web Tasarımı Nasıl Olmalıdır?
Web tasarımı çeşitli adımlardan oluşur. Her şeyden önce etkili ve iyi bir web sitesi sunmuş olduğunuz ürünü ya da hizmeti en iyi tanıtan sitedir. Bu da üzerinde düşünülmüş ve çalışılmış bir web tasarım sayesinde olur. İyi bir web sitesi kullanıcı siteyi girdiği andan itibaren kolay kullanıma ve anlaşılabilir olmaya sahip olmalıdır. Kullanıcıyı yormayan, doğrudan tüm tanıtım araçlarıyla kullanıcıya kolaylık sağlayan bir tasarım olması avantaj sağlar. Ürünü sunmakla birlikte ürünü iyi tanıtan ve soru işaretlerin gideren site kulacılar tarafından daha fazla tercih edilmektedir. Ürünü sunarken estetik açıdan da iyi bir sunum her zaman bi adım önde olmanızı sağlar. Bu açıdan web sitesi içinde kullanılan görseller, metinler ve videolar gibi tasarım araçları iyi bir dizayn sunmalı ve bütünlüklü bir yapı oluşturmalıdır. Kullanıcının site içersinde gezinmesini kolaylaştıracak olan linkler kolay ulaşılabilir olmalıdır. Site içerisinde yer alan gezinme menüsü de kullanıcı için kolay kullanım sunmalıdır. Ürün tanıtım metinleri görsellerle beraber sunacağınız önemli araçlardandır. Metinler anlaşılabilir ve ürünü tanıtıma odaklanmalı ve gerekli olmayan detaylardan temizlenmelidir. Bu sayede hizmeti en iyi şekilde kullanıcıya ulaştırır.', CAST(N'2022-04-18T14:22:20.223' AS DateTime), 2, 3, 3, 1, 20, 8, 1, 1)
INSERT [dbo].[Makale] ([MakaleID], [Baslik], [Icerik], [EklenmeTarihi], [GoruntulenmeSayisi], [BegeniSayisi], [KategoriID], [EtiketID], [ResimID], [KullaniciID], [AktifMi], [OnaylandiMi]) VALUES (15, N'YAPAY ZEKA NEDİR?', N'Yapay zeka terimi 1956’da ortaya çıktığında, çoğunlukla akademik araştırmalarda geçiyor, dama öğrenmek veya matematiksel problemleri çözmek gibi görevler için kullanılıyordu.

1990’lı yıllarda, yapay zeka lojistik, veri madenciliği, tıbbi teşhiş ve Dünya satranç şampiyonunu yenmek gibi daha karmaşık görevler için kullanılmaya başlandı.

2000’li yılların başlarında, yapay zeka teknolojileri; makine öğrenimi araştırmalarında, Google gibi arama motorları tarafından ve Amazon gibi büyük web siteleri tarafından kullanılmaya devam edildi.

Günümüzde yapay zekanın pratik uygulamaları büyük ölçüde makine öğrenimi ve derin öğrenmeye indirgenmiştir. Makine öğrenimi yapay zekanın alt kümesidir.

Yapay Zeka Nerelerde Kullanılır?

Kolaylık, hız, doğruluk, güven ve deneyim gibi faktörler, yapay zekanın daha geniş alanda kabul görmesi için oldukça önemlidir. Yapay zeka, bankacılık, nakliye, ulaşım gibi hemen hemen her alanda kullanılan yüksek bir potansiyele sahiptir. Sonsuz yapay zeka uygulamaları arasında fark yaratanlara ve sağlık, finans, seyahat, alışveriş gibi sektörler bazında en yaygın kullanım alanlarına sahip olanlara göz atalım mı?

Finans
Günümüzde finans sektöründe veri analistlerinin saatlerce çalışarak ortaya koyabileceği raporlara kısa sürede ulaşılması yapay zekanın eseridir.

Finans sektörünün büyük miktarlarda sayısal verilerin gerçek zamanlı raporlanması, doğruluğu ve işlenmesi gibi titizlikle yürütülmesi gereken konuları; onu yapay zeka ile en iyi eşleşen sektörlerden biri haline getirmiştir.

Bankacılık sektörü, olağan dışı banka kartı kullanımı gibi dolandırıcılık faaliyetlerini tespit etmek için de yapay zeka uygulamalarını kullanır.

Hatta piyasa verilerini tarayarak, tercihinize göre en iyi portföyü veya stoğu tahmin edebilen yapay zeka destekli otomatik finans danışmanlarının da görevini başarıyla yerine getirdiklerini ekleyelim.

Alışveriş
Kullandığınız online satış siteleri, beğenileriniz konusunda bilgiler toplar ve depolar. Google Analytics, herhangi bir online satış sitesine, hangi sayfasında ne kadar zaman harcadığınıza, konumunuza, tarayıcınıza, cihazınıza hatta mouse kullanımınıza dair bilgiler sunabilir.

Bu tip kişisel verileri kullanarak firmalar; size özel anlık bildirim, mesaj ve görsellerle sizi elde tutmaya çalışır.

Bu amaçla yapay zeka; en çok satan ürünlerde indirim hakkında bildirim gönderebilir, istenen öğeler için zaman sınırları sunabilir ve konumunuz gibi kriterlere göre arayüzü ya da para birimini otomatik olarak değiştirebilir,

Sağlık
Hastalıkları tahmin etmek ve doğru tedaviyi sunmak için verilerinden yararlanılan yapay zeka, sağlık sektöründe aktif olarak kullanılıyor.

Sağlık hizmetlerinde yapay zekaya, siber suçlulara karşı hasta kayıtlarını korumak, cerrahi prosedürler, ilaç dozu belirlemek gibi alanlarda zaman ve maliyet avantajı nedeniyle başvurulmakta.

Ayrıca yapay zeka destekli teknolojiler; patologların doku örneklerini analiz etmelerine ve doğru tanı koymalarına da yardımcı oluyor.

Sosyal Medya

Facebook, Twitter, Instagram gibi sosyal medya platformlarını her kullandığınızda yapay zeka; kullanıcı deneyimini geliştirmek için geçmişteki tüm aramalarınızı, etkileşimlerinizi, davranışlarınızı göz önünde bulundurur.

Chatboatlar ve Müşteri Desteği

E-posta veya telefon yoluyla erişilebilen geleneksel destek kanalları işletmeler için para ve insan kaynakları israfı anlamına gelir.

Yapay zeka destekli müşteri yardımcıları, siparişinizin durumunu bildirmek ve açıklamanıza göre belirli bir ürünü bulmanıza yardımcı olmak gibi basit soruları yanıtlayabilir.

Chatbotlar yazılı veya sözlü metni ayrıştırabilen ve uygun şekilde yapılandırılmış içeriği kullanarak yanıt verebilen bilgisayar sistemleridir. Chatbotlar, hem uygun bilgileri oluşturmak hem de kullanıcı hakkında bilgi edinmek için anlambilim, Bayes analizi ve makine öğrenimi kombinasyonunu kullanır.

Hatırlatıcılar ve bildirimler göndererek müşteriyi elde tutma oranını artırdığından, insanlara kıyasla anında cevaplar sunarak yanıt süresini azalttığından ve günün her saatinde hizmet sunabildiğinden online alışverişte chatbot kullanımı oldukça avantajlıdır.

LinkedIn, Facebook ve diğer web sitelerinde bulabileceğiniz sohbet araçlarını chatbot örneği olarak ekleyebiliriz.

Sürücüsüz Arabalar, Dronelar, Otopilot

Otonom araçlar da denen sürücüsüz arabalar, yapay zekanın otomotiv endüstrisini nasıl etkilediğinin başlıca örnekleridir. Statik ve hareketli engelleri öngörmek ve hedeflere dayalı eylemleri belirlemek için görsel tanıma sistemlerini ve gerçek zamanlı modellemeyi kullanırlar. Yüz tanıma ve biyometrik sistem, sürücüsüz araçların insan yüzlerini analiz etmesini ve güvenli bir şekilde yol almasını sağlar.

Kendi kendine giden arabalar, mümkün olan en düşük risk ve en az kayba odaklıdır. Çarpışma senaryolarında, sürücüsüz arabaların en az miktarda hasara neden olan seçeneği hesaplaması için çalışılmaktadır.

Yolcusuz hava aracı olarak bilinen dronlar yusufçuk kadar küçük ya da jet kadar büyük olabilir. Dronlar, sürü davranışını veya önceden programlanmış talimatları izleyerek koordineli bir şekilde hareket edebilir.

Sürücüsüz araçlar ve sevkiyatları teslim eden dronelarla, ulaşım ve nakliyat ile ilgili önemli miktarda sorunun hızlı ve etkili şekilde çözülebileceği öngörülmekte.

Uçuşlarda kullanılan otopilot teknolojisi de yapay zekanın insanlığa sunduğu en büyük kolaylıklardan sadece biri.

Seyahat

Google Haritalar; yapay zeka özellikli algoritmalarla yol bilgilerini tarayıp bisiklet, araba, otobüs, tren ya da yaya olarak gidilebilecek en uygun rotayı belirler.

Navigasyonlarla etkili rotalar önermek dışında yapay zeka; chatbotlar ile de seyahat endüstrisini hızla değiştirmekte. Seyahat önerileri, en uygun rezervasyon fiyatları ve hızlı yanıt süreleri için tüketicilerle insan benzeri etkileşimi kolaylaştıran chatbotlar, kullanıcıların seyahat ipuçlarını incelemesine, gezi alanları ve yemek seçeneklerini araştırmalarına olanak tanır.

Akıllı Cihazlar

Seçimlerimize tepki verebilen yapay zeka destekli evler görmemiz için biraz daha beklememiz gerekse de zamana göre yoğunluğu ve rengi değişebilen akıllı ışıklar ve sıcaklığı kullanıcı tercihine göre ayarlayabilen termostatlar gibi yapay zeka destekli cihazlar giderek yaygınlaşıyor.

Alexa ve Siri gibi otomatik sesli yardım sistemleri kullanıcıların günlük hayatlarını kolaylaştırmaya yardımcı olan yapay zeka örnekleridir.

Müzik – Yemek

Yapay zeka milyonlarca konuşmadan elde edilen verilere dayanarak müzisyenlerin tema oluşturmasına, farklı müzikal ögeler üretmesine yardımcı olabiliyor. Seyircilerin ne istediğini anlayabilen yapay zeka, müzisyenlerin buna göre besteler yapmasını sağlayabilir.

Yiyeceklerin uyumuna göre önerilerde bulunmak ve yemek tarifleri geliştirmenize yardımcı olmak da yapay zekanın oyun alanlarından biri.

Eğlence

Görsel ve ses tanıma sistemleri medya ögelerini kodlanmış bir sıkıştırılmış forma dönüştürerek çalışır. En yakın eşleşmeler için dizinler veya makine öğrenme sistemleri aracılığıyla algoritmalar kullanılır ve bu genellikle Bayes Analizi ile güçlendirilir. Belirli paternler birbirine göre meydana gelme sıklıklarına göre analiz edilir.

Fraktallar ve yapay zeka arasında derin bir bağlantı vardır; suyun hareketi, ateşin alevleri, havadaki dumanın salınımı gibi fraktal görüntüleme teknolojileri gişe rekorları kıran filmlerde standart halini almıştır.

Güvenlik

Yapay zekanın güvenlik kameraları görüntülerini yüz ve ses tanıma teknolojileri ile izleyebilmesi, insanlardan aynı anda çok sayıda kameradan gelen yayınları takip etmesini istemekten çok daha verimli ve uygulanabilirdir.

Depolama ve Tedarik Zinciri

Yapay Zeka destekli otomatik depolama ve tedarik zinciri yönetim sistemleri; envanterlerin yönetilmesine, e-ticaret endüstrisinin daha verimli çalışmasına yardımcı olmaktadır.

Nesnelerin İnterneti ve Robotik

Cihazların birbiriyle iletişimine odaklanan nesnelerin interneti ve hareket edebilen otonom fiziksel ajanlar oluşturmayı içeren robotik doğrudan yapay zeka diyemeyeceğimiz ama yapay zeka tabanlı sistemlere dayanan teknolojilerdir. Her ikisi de sinyalleri tanımlamak, yanıtı belirlemek ve içinde bulundukları durumları yönetebilmek için yapay zekayı kullanır.

Blockchain

En yüksek önlemlerle tasarlandığında yapay zeka inanılmaz derecede devrimci olabilir. Buna büyük ölçüde yardımcı olacak teknoloji blockchaindir. Şifrelenmiş verileri depolamak için kullanılan Blockchain ve toplanan verilerden karar vermeyi sağlayacak beyne sahip yapay zeka; birbirlerinden faydalanabilecek ve birbirlerine yardım edebilecek özelliklere sahiptir. Bu iki teknolojinin bir araya gelmesi birbirlerinin potansiyelini artırabilir ve verilerin yeni düzeylere erişmesini sağlayabilir.

Yapay Zekaya Yönelik Eleştiriler

Yapay zeka konusunda en yaygın endişe, ilerde makinelerin kendilerini yeniden tasarlayacakları kadar gelişebilecekleri ve insanların buna ayak uyduramayacağına yöneliktir.

Bir diğer endişe makinelerin insanların özel hayatına yönelik tehdit oluşturabileceği hatta silahlandırılabileceği yönündedir.

Robotlar gibi akıllı sistemlerin insanlarla eşit haklara sahip olup olmaması konularında da etiksel argümanlar sürmektedir.

Yapay zeka ile ilgili en yaygın tartışmalardan biri de istihdamı nasıl etkileyeceği konusudur. Kendi kendine giden arabaların taksiciliği ortadan kaldıracağı düşünülmektedir. Akıllı makinelerin kullanılmasıyla belirli işleri otomatikleştirmek isteyen birçok sektör, maliyet ve zaman avantajı nedeniyle yapay zeka teknolojilerini bünyesine entegre etme eğilimindedir.

Yapay zeka teknolojilerine empati kurma, insanlara öncelik verme gibi beceriler kazandırılarak ve bu becerilerin değiştirilmesini önleyecek sistemlerin entegre edilerek bu endişelerin bir kısmına engel olunabileceği düşünülmektedir.

Özet

Yapay zeka teknolojisi, doğru ve hızlı tıbbi teşhis ve güvenli otonom araçlar gibi fırsatlar için umut vaat etse de neredeyse her sektöre uygulanabilir olduğundan birçok insanın işten çıkarılma potansiyeli ve bilişsel görevler açısından yapay zeka uygulamalarına aşırı bağımlılık gibi endişelere neden olmaktadır.

Özetle, “Yapay zeka nedir?” sorusunun yanıtında sadece sorunları düşünme ve çözme yeteneğine sahip robotlar değil derinlemesine raporlar oluşturmaya yarayan pazarlama araçları ve minimal insan müdahalesi ile hayatımızı kolaylaştırabilecek sayısız detay saklı.', CAST(N'2022-04-18T14:27:19.440' AS DateTime), 5, 12, 4, 7, 21, 8, 1, 1)
INSERT [dbo].[Makale] ([MakaleID], [Baslik], [Icerik], [EklenmeTarihi], [GoruntulenmeSayisi], [BegeniSayisi], [KategoriID], [EtiketID], [ResimID], [KullaniciID], [AktifMi], [OnaylandiMi]) VALUES (16, N'OPEN SOURCE NEDİR?', N'Opensource nedir?

Opensource yani açık veri, paylaşma, var etme ve kullanma üzerine bir birliktelik hareketidir. Eğer ilgili ve bilgiliysen çalışan bir programın temelinde verinin nasıl kullanıldığına da ulaşabilirsin, eğer istersen onu geliştirmeye de çalışabilirsin veyahut istersen benzer uygulaman için kendine de fayda sağlayabilirsin. Yani açık veri, kocaman bir komuniteye(opensource community) mal olmuş bir ürünü amacına uygun şekilde dilediğince kullanabilme özgürlüğüne sahip olmak demektir. Üçüncü kişilere verilen bu serbestiyet açık verinin genel bağlamda felsefesini oluşturur.

Opensource çıkış noktası nedir ve neden önemlidir?

Ortaya çıkışında sağlık, yönetimsel ve pozitif bilimler verilerinin paylaşılması fikri etkili olmuştur. Bu tarz verilerin çeşitli kısıtlamalar ve koruma altında olmasının paylaşılması önünde engel olduğu ve tam tersine paylaşılması durumunda bunlardan fayda sağlanabileceğine inanılmıştır. Sonrasında ise içinde bulunduğumuz yakın milenyum çağıyla birlikte nedenleri ve çerçeveleri çokça tartışılmıştır. Sonucunda bu tartışmalar çeşitli konferansları, akademik makaleleri beraberinde getirmiştir. Açık verinin önem arz etmesi onun hem erişilebilir ve hem de geliştirilebilir olmasıyla ilgilidir. Yani bir bağlamda erişimin artması gelişimin artmasını tetikler ve erişim güdümünde gelişimsel faaliyetler gerçekleşir. Açık verinin kıymeti işte bu felsefenin içerisindedir. Bu noktada açık verinin yararlarından biraz daha bahsedersek eğer geniş katılım potansiyeli yaratma, gelişime açıklık fırsatı sağlama, inovasyonu destekleme ve böylece verimliliği arttırabilme potansiyeli sağlama konularının üzerinde durulabilir.

Opensource varlığı ve potansiyeli

Açık veri günümüz veri çağının trendidir, birlikte geliştirme kültürünün kurucu değeridir.Bu kapsamda devlet verileri üzerinde bile hatırı sayılır vaziyette açık veriye geçiş söz konusudur. Bu oranlar günümüzde yüzde 10 ların üzerine çıkmış haldedir. Günübirlik artan bu yönelim internet üzerinden rahatlıkla çeşitli organizasyonlar ile kontrol edilebilir. Bu veriler doğru işleme yapıldığı takdirde mükemmel bir araştırma ve geliştirme olanağı sağlayabilir, bu olanak pozitif bilim alanında gelişmelere yorulabilir. Ayrıca bu veriler tekrar tekrar kullanılabilir ya da tekrar tekrar ihtiyaca uygun dağıtılabilir, böylelikle farklı araştırmaların aynı veri ihtiyaçları zamandan tasarruf edilerek kullanılabilmiş olur.Ayrıca avantaj sağladığı birlikte çalışabilme kültürüyle ortak sonuç ortaya çıkarabilme ve farklı iş bağlantılarını aynı bağlamda kullanabilme becerilerinin sağlanabilmesi mümkün olabilir.Yapısal olarak farklı grupların farklı koşullarına aldırış etmeden eşit kullanım imkanları sağlamasıyla potansiyel olarak temelinde tüm ticari erişim anlaşmalarını ortadan kaldırmaya meyillidir.

Opensource Varlığı ve İlkeleri

Ücretsiz ve sürekli erişim
Yeniden kullanım ve paylaşım
Geliştirilebilirlik ve yenilik odaklı olması
Kapsayıcı ve şeffaf olması
Güncellik ve işlenebilirlik
Standartlaşma/Normallerin belirlenmesi

Opensource ve Closed Source karşılaştırılması

Closed source yani kapalı veri yaklaşımları, bir ürünün kaynak kodlarına ulaşamadığın, göremediğin ya da değiştiremediğin yaklaşımlardır.Günümüz veri dünyasında uygulamaların yüksek çoğunluğu kapalı veri yaklaşımını kullanarak hizmet vermektedir, ancak bu uygulamaların açık veri yaklaşımlı alternatifleri de yok değildir. Örneğin, ofis programları ihtiyacınız için açık veri kaynak kodlu bir uygulama arıyorsunuz, LibreOffice uygulaması kapalı kodlu Microsoft Office yerine iyi bir muadil olacaktır.Bu örnekleri kolaylıkla çoğaltabiliriz; örneğin web browserınız için tescilli yazılım olarak geçen kapalı kodlu Google Chrome yerine iyisinden bir açık veri örneği arıyorsunuz. Bu durumda Firefox işinizi rahatlıkla görecektir. Text editör mü arıyorsunuz? Açık veri alternatifi Notepad++, medya oynatıcı mı lazım? VLC oynatıcı ne güne duruyor öyle değil mi? En can alıcı noktayı işletim sistemi için ayırmakta fayda var, koskoca Linux ve türevleri bir cümle ile geçilmemeli diye düşünüyorum.Nispeten biraz daha detaylı halde yazımızın sonunda değineceğim.

Ürünümü nasıl açık veri haline getirebilirim?

Ürününüzü açık veri haline getirme işleminin birkaç adımı vardır,bunları şu şekilde özetleyebiliriz:

Kaynak kodunu paylaşmayı düşündüğünüz alt başlıklara karar verin ve verilerinizi açık bir lisans ile kategorize edin, kullanım hakları hususunda kendi normallerinizi belirleyin ve bu işlemi tamamlayın. Kapsamına karar verdikten sonra lisanslamasını da yapıp normalleriniz üzerinde kafa yorduktan sonra işlem tamamdır. Yine de eğer talep ederseniz, ürününüzün kısmi kullanımını açık veri halinde sunmak adına API kullandırma benzeri bir yolu da tercih edebilirsiniz.

En başarılı Opensource örneklerinden Linux

Yazının bu kısmını açık veri örneklerinin belki de en başarılısı olan Linux için ayırdım. Linux en iyi bilinen ve en çok kullanılan açık veri işletim sistemi tabanıdır.Onun da diğer benzerleri gibi grafik arayüzü vardır ve benzer yazılımlar kullanılır. Ama Linux açık veri olması yoluyla aslında çok farklıdır, böylece onu oluşturan kaynak kodlar ücretsiz şekilde görüntülenebilir, kullanıcının yeteneği doğrultusunda editlenebilir ve böylece ürüne katkıda bulunulabilir. Yani Linux aktif katılımla birlikte her geçen gün daha da iyiye gidebilir. Böyle karmaşıklık olur mu kim peki bu işletim sisteminin sahibi yahu dediğinizi duyar gibiyim. Farklı Linux tabanlı işletim sistemi varyasyonları var, bazıları farklı komüniteleri oluşturmuş ve farklı amaçlara hizmet etmekte fakat tam anlamıyla bir sahiplik olayı mevcut değil.Açık veri lisanslamasıyla Linux varyasyonları olan işletim sistemlerinin sadece kurucuları bilinmekte ve Linux kernel iletişiminde belirli erişim hakları tanımlanmakta kullanıcılar için. Ve bu gelişim kar amacı olmayan belirli bir kuruluş tarafından da GNU felsefesiyle desteklenip profesyonel anlamda sürdürülmekte.İsmi ücretsiz yazılım vakfı anlamına gelen Free Software Foundation’dır.
', CAST(N'2022-04-18T14:33:50.310' AS DateTime), 5, 6, 4, 8, 22, 10, 1, 1)
INSERT [dbo].[Makale] ([MakaleID], [Baslik], [Icerik], [EklenmeTarihi], [GoruntulenmeSayisi], [BegeniSayisi], [KategoriID], [EtiketID], [ResimID], [KullaniciID], [AktifMi], [OnaylandiMi]) VALUES (17, N'KARİYER TAVSİYELERİ', N'Kariyerimize hepimiz hızlı başlangıç yapıp istediğimiz hedefi gerçekleştirmek isteriz. Fakat günümüz şartlarında belirli bir zaman, belirli alışma ve düzeni sağlayamadığımızda sonuç başarısız olur. İşte sizlere sunmak istediğim başlıklar halindeki kariyer hedefleri için gerekli olanlar.

Hedef Belirleme Nasıl Olmalı?

İlk önce ne yapmak istediğimize karar verip bu doğrultuda plan ve çalışma yapmamız gerekir. Ama hedefi belirlemeden yola çıkarsak yarı yolda kalacağımızı bilerek çalışma yapmalıyız. Hedefimizi ısrarla istememiz gerekir. Peşini bırakmamalı ve üstüne gitmeliyiz.

Plan Yapma ve Süreklilik Şart

İlk adımımızı belirledikten sonra konuyla ilgili detaylı plan yapmalıyız. Planı oluştururken gereksiz konu ve ayrıntılara yer vermemeliyiz. Bu çalışma planını oluşturduktan sonra çalışma düzenini sürekli olacak şekilde yapmalıyız. Eğer ki yapmamız durumunda oluşturduğumuz plan yarım kalacaktır. Günü gününe plana uyulmalı ki kariyerimiz için iyi bir sonuç alalım.

Zamanı Doğru Kullanmak

Hedefe ulaşabilmemiz için en önemli adımlardan biri de zaman yönetimidir. Zamanı verimli bir şekilde kullanırsak hedefe ve kariyerimize bir an evvel başlamış oluruz.  Beklemeyin derhal harekete geçin. Çünkü doğru zaman beklemekle gelmeyecektir.

Merak ve İstek Olmalı

Merak ve isteğimiz her daim olmalı. Aksi takdirde başarılı olamayız. Gerçekten de biz bu kariyer hedefini istediğimizi ve merakımızı göstermeliyiz. Kendimize samimi olmalıyız. Sizlerin, başkalarının düşüncelerini önemsemeden yeri geldiğinde kendi bildiğini yapması en doğru olanıdır.

Yapabileceklerimizi Bilmek Gerek

Kendimizi iyi tanımalıyız. Başkalarından çok, kendimiz neyi yapıp, neyi yapamayacağımızı iyi bilmek gerekir. Kendimizi tanırsak, hedefe ulaşmak çok daha kolay ve rahat olacaktır. Bazı konu, deney, araştırma gibi önceden kendimizi denemeliyiz.

Kariyer İçin Çevre Şart Mı?

Çalışan veya çalışmayan size bu yolda destek verecek, fikirlerini paylaşacak arkadaş, dost gibi yanınızda birilerinin olduğunu hissedeceğiniz bir grup olmalı ve sizi teşvik etmeli. Mümkünse çeşitli bölümlerde çalışan arkadaşlarımız önemli. Çünkü her bölümün işleyişi, düzeni, disiplini farklıdır. O bölümde çalışmayan onları bilmez. Tabii kararı yine düşünüp biz kendimiz vermeliyiz.

Karar ve Eylem 

Bütün buraya kadar olan adımları gerçekleştirsek bile karar ve eylemi gerçekleştiremezsek, kariyer hedefimize ulaşamayız. Hayatımız aslında karar ve eylemlerden oluşmaktadır. Verdiğimiz bu karar ve eylemler bizi sonuca ulaştırmaktadır. Başkalarının bizi yönlendirmesine veya bizim adımıza karar alıp eyleme geçmesine izin vermemeliyiz.

Hobi ve Etkinlikler Önemli

İşimiz olsun veya olmasın en az bir tane hobimiz olmalıdır. Mesela, futbol, tiyatro, kitap okumak, sinema, ilgilendiğimiz alanla ilgili bir panel, sempozyum, konferans gibi kendimizi sosyal ve kültürel alanda gelişimimizi sağlayan faaliyetlere katılmalıyız. Bizi bu konu ilgilendirmiyor, bu bize bir şey katmaz diye düşünmeyelim. 

İş hayatında da aynı şeyler başımıza geldiğinde aynı şeyleri düşünmemiz durumunda işimizden olabiliriz. Bu bir sivil toplum kuruluşunda gönüllülük esasına dayanan bir etkinlik olabilir, bir proje, bir vaka analizi olabilir, örnekleri çoğaltabiliriz. Onun için sosyal olan ve bizi geliştiren özellikle bunlarla ilgilenmeliyiz.  

Başarı Bir Bütündür Ayrı Ayrı Düşünemeyiz

Sürekli ileriyi hedeflemeliyiz ve başarının arkasını sürekli kovalayarak hedefimize en kısa sürede ulaşmaya çalışmalıyız. Etrafımıza baktığımızda bunları gerçekleştirenlerin olması bizi daha da teşvik eder. Bu bir iş değil de bunu kendimize bir değer katmak için yapıyoruz diye düşünürsek çok daha ileri seviyelere ulaşabiliriz. ', CAST(N'2022-04-18T14:37:57.067' AS DateTime), 7, 24, 2, 1, 23, 5, 1, 1)
INSERT [dbo].[Makale] ([MakaleID], [Baslik], [Icerik], [EklenmeTarihi], [GoruntulenmeSayisi], [BegeniSayisi], [KategoriID], [EtiketID], [ResimID], [KullaniciID], [AktifMi], [OnaylandiMi]) VALUES (18, N'ÇALIŞMA VE EĞİTİM HAYATINIZDA ASİSTANINIZ OLACAK 3 MOBİL UYGULAMA', N'Bilindiği gibi günümüzde akıllı telefonlar iletişim aracı olarak kullanılmasının yanı sıra iş, eğitim vb. birçok alanda kullanılan yararlı birer araç haline gelmiş durumda. Akıllı telefonlar yaşamımızı büyük ölçüde kolaylaştırıyor ve geliştirilen yeni birçok uygulamalarla birlikte hayatımızı daha da kolaylaştırmaya devam ediyor.

Bu yazımızda hem iş hem de okul hayatınızda daha verimli çalışabilmeniz ve hayatınızı kolaylaştırabilmeniz için telefonunuzda daima bulundurmak isteyeceğiniz mobil uygulamaları sıraladık.

TRELLO
Bu uygulama sayesinde işlerinizi ve derslerinizi istediğiniz gibi planlayabilirsiniz. İstediğiniz şekilde kartlar hazırlayıp üzerinde düzenlemeler yaparak, yapılacaklar listesi oluşturabilirsiniz. İster ekip arkadaşlarınızla ister ailenizle ortak şekilde listeler üzerinde düzenlemeler yapabilirsiniz.  Üstelik Google Drive ya da Dropbox’tan dosyalar ekleyip, istediğiniz fotoğraf ve videoları yükleyebiliyorsunuz. Trello‘da çevrimdışı olarak çalışmanız da mümkün. Uygulama birçok özelliği barındırmasının yanı sıra ücretsiz olup uygulamaya aşağıdaki linklerden ulaşabilirsiniz.

TODOİST
Yaklaşık 20 milyon kullanıcı tarafından indirilen, yapılacaklar listesi ve hatırlatıcı olan Todoist Google 2020 Editörün Seçimi listesinde yer almıştır. Kolay anlayabileceğimiz bir arayüze sahip olan bu uygulamayı severek kullanacaksınız. Hatırlatıcılar ekleyerek günlerinizi planlayabilir, başkalarına görevler atayabilirsiniz. Görevlerinizin öncelik sıralarını belirleyebiliyorsunuz. Üstelik Gmail, Google Calendar gibi birçok plarformu entegre edebiliyorsunuz.  Uygulamaya aşağıdaki linklerden ulaşabilirsiniz.

NOTION
Listemizin 3. Sırasında yer alan Notion uygulaması proje yönetiminizi ve not almanızı oldukça kolaylaştırıyor. Zengin bir medya içeriğine sahip olan bu uygulamada günlük görevler ve yapılacak listesi oluşturabilir, içeriğinizi sayfalar sayesinde düzenleyebilirsiniz. Uygulamaya aşağıdaki linklerden ulaşabilirsiniz.', CAST(N'2022-04-18T14:46:24.000' AS DateTime), 10, 20, 5, 12, 25, 6, 1, 1)
SET IDENTITY_INSERT [dbo].[Makale] OFF
GO
SET IDENTITY_INSERT [dbo].[MakaleEtiket] ON 

INSERT [dbo].[MakaleEtiket] ([MakaleID], [EtiketID], [MakaleEtiketID]) VALUES (1, 1, 1)
INSERT [dbo].[MakaleEtiket] ([MakaleID], [EtiketID], [MakaleEtiketID]) VALUES (12, 6, 12)
INSERT [dbo].[MakaleEtiket] ([MakaleID], [EtiketID], [MakaleEtiketID]) VALUES (14, 1, 14)
INSERT [dbo].[MakaleEtiket] ([MakaleID], [EtiketID], [MakaleEtiketID]) VALUES (15, 7, 15)
INSERT [dbo].[MakaleEtiket] ([MakaleID], [EtiketID], [MakaleEtiketID]) VALUES (16, 8, 16)
INSERT [dbo].[MakaleEtiket] ([MakaleID], [EtiketID], [MakaleEtiketID]) VALUES (17, 1, 17)
INSERT [dbo].[MakaleEtiket] ([MakaleID], [EtiketID], [MakaleEtiketID]) VALUES (18, 12, 18)
SET IDENTITY_INSERT [dbo].[MakaleEtiket] OFF
GO
SET IDENTITY_INSERT [dbo].[Resim] ON 

INSERT [dbo].[Resim] ([ResimID], [KucukBoyutResim], [OrtaBoyutResim], [BuyukBoyutResim], [MakaleID]) VALUES (1, N'/Content/MakaleResim/KucukBoyut/WhatsApp Image 2022-04-01 at 14.13.19.jpeg', NULL, NULL, NULL)
INSERT [dbo].[Resim] ([ResimID], [KucukBoyutResim], [OrtaBoyutResim], [BuyukBoyutResim], [MakaleID]) VALUES (2, N'/Content/MakaleResim/KucukBoyut/avatardefault_92824.png', NULL, NULL, NULL)
INSERT [dbo].[Resim] ([ResimID], [KucukBoyutResim], [OrtaBoyutResim], [BuyukBoyutResim], [MakaleID]) VALUES (3, N'/Content/MakaleResim/KucukBoyut/avatardefault_92824.png', NULL, NULL, NULL)
INSERT [dbo].[Resim] ([ResimID], [KucukBoyutResim], [OrtaBoyutResim], [BuyukBoyutResim], [MakaleID]) VALUES (4, N'/Content/MakaleResim/KucukBoyut/avatardefault_92824.png', NULL, NULL, NULL)
INSERT [dbo].[Resim] ([ResimID], [KucukBoyutResim], [OrtaBoyutResim], [BuyukBoyutResim], [MakaleID]) VALUES (5, N'/Content/MakaleResim/KucukBoyut/avatardefault_92824.png', NULL, NULL, NULL)
INSERT [dbo].[Resim] ([ResimID], [KucukBoyutResim], [OrtaBoyutResim], [BuyukBoyutResim], [MakaleID]) VALUES (6, N'/Content/MakaleResim/KucukBoyut/avatardefault_92824.png', NULL, NULL, NULL)
INSERT [dbo].[Resim] ([ResimID], [KucukBoyutResim], [OrtaBoyutResim], [BuyukBoyutResim], [MakaleID]) VALUES (7, N'/Content/MakaleResim/KucukBoyut/d684ed1ce9c46b76b86e04cd759791065309c5a6-66ca910f-9a01-45e1-a312-9104d716bc73.jpeg', N'/Content/MakaleResim/OrtaBoyut/d684ed1ce9c46b76b86e04cd759791065309c5a6-66ca910f-9a01-45e1-a312-9104d716bc73.jpeg', N'/Content/MakaleResim/BuyukBoyut/d684ed1ce9c46b76b86e04cd759791065309c5a6-66ca910f-9a01-45e1-a312-9104d716bc73.jpeg', NULL)
INSERT [dbo].[Resim] ([ResimID], [KucukBoyutResim], [OrtaBoyutResim], [BuyukBoyutResim], [MakaleID]) VALUES (18, N'/Content/MakaleResim/KucukBoyut/yuz_tanima_teknolojisi_ofix_blog_4-11517246-3021-44e4-bf52-19c34377821f.jpg', N'/Content/MakaleResim/OrtaBoyut/yuz_tanima_teknolojisi_ofix_blog_4-11517246-3021-44e4-bf52-19c34377821f.jpg', N'/Content/MakaleResim/BuyukBoyut/yuz_tanima_teknolojisi_ofix_blog_4-11517246-3021-44e4-bf52-19c34377821f.jpg', NULL)
INSERT [dbo].[Resim] ([ResimID], [KucukBoyutResim], [OrtaBoyutResim], [BuyukBoyutResim], [MakaleID]) VALUES (20, N'/Content/MakaleResim/KucukBoyut/etkili-web-tasarim-2f76b761-e06c-49e3-a195-ec2d4c8c260d.jpg', N'/Content/MakaleResim/OrtaBoyut/etkili-web-tasarim-2f76b761-e06c-49e3-a195-ec2d4c8c260d.jpg', N'/Content/MakaleResim/BuyukBoyut/etkili-web-tasarim-2f76b761-e06c-49e3-a195-ec2d4c8c260d.jpg', NULL)
INSERT [dbo].[Resim] ([ResimID], [KucukBoyutResim], [OrtaBoyutResim], [BuyukBoyutResim], [MakaleID]) VALUES (21, N'/Content/MakaleResim/KucukBoyut/kapak-9-800x800-930a8186-9ef9-4ff7-9e23-f3d5633dd2d6.jpg', N'/Content/MakaleResim/OrtaBoyut/kapak-9-800x800-930a8186-9ef9-4ff7-9e23-f3d5633dd2d6.jpg', N'/Content/MakaleResim/BuyukBoyut/kapak-9-800x800-930a8186-9ef9-4ff7-9e23-f3d5633dd2d6.jpg', NULL)
INSERT [dbo].[Resim] ([ResimID], [KucukBoyutResim], [OrtaBoyutResim], [BuyukBoyutResim], [MakaleID]) VALUES (22, N'/Content/MakaleResim/KucukBoyut/Open-Source-37012090-d796-4dfd-ad6e-e82a2a9285d7.jpg', N'/Content/MakaleResim/OrtaBoyut/Open-Source-37012090-d796-4dfd-ad6e-e82a2a9285d7.jpg', N'/Content/MakaleResim/BuyukBoyut/Open-Source-37012090-d796-4dfd-ad6e-e82a2a9285d7.jpg', NULL)
INSERT [dbo].[Resim] ([ResimID], [KucukBoyutResim], [OrtaBoyutResim], [BuyukBoyutResim], [MakaleID]) VALUES (23, N'/Content/MakaleResim/KucukBoyut/kariyer-baslangici-icin-tavsiyeler-1_w1145_h572_op-aa096468-831d-477e-8966-683d19701afa.jpg', N'/Content/MakaleResim/OrtaBoyut/kariyer-baslangici-icin-tavsiyeler-1_w1145_h572_op-aa096468-831d-477e-8966-683d19701afa.jpg', N'/Content/MakaleResim/BuyukBoyut/kariyer-baslangici-icin-tavsiyeler-1_w1145_h572_op-aa096468-831d-477e-8966-683d19701afa.jpg', NULL)
INSERT [dbo].[Resim] ([ResimID], [KucukBoyutResim], [OrtaBoyutResim], [BuyukBoyutResim], [MakaleID]) VALUES (24, N'/Content/MakaleResim/KucukBoyut/avatardefault_92824.png', NULL, NULL, NULL)
INSERT [dbo].[Resim] ([ResimID], [KucukBoyutResim], [OrtaBoyutResim], [BuyukBoyutResim], [MakaleID]) VALUES (25, N'/Content/MakaleResim/KucukBoyut/mobil-uygulama-c0a36595-8e73-4690-ba94-366d192b9f55.png', N'/Content/MakaleResim/OrtaBoyut/mobil-uygulama-c0a36595-8e73-4690-ba94-366d192b9f55.png', N'/Content/MakaleResim/BuyukBoyut/mobil-uygulama-c0a36595-8e73-4690-ba94-366d192b9f55.png', NULL)
SET IDENTITY_INSERT [dbo].[Resim] OFF
GO
SET IDENTITY_INSERT [dbo].[Rol] ON 

INSERT [dbo].[Rol] ([RolID], [RolAdi]) VALUES (1, N'Admin')
INSERT [dbo].[Rol] ([RolID], [RolAdi]) VALUES (2, N'Kullanici')
INSERT [dbo].[Rol] ([RolID], [RolAdi]) VALUES (3, N'Yazar')
SET IDENTITY_INSERT [dbo].[Rol] OFF
GO
SET IDENTITY_INSERT [dbo].[Yorum] ON 

INSERT [dbo].[Yorum] ([YorumID], [Icerik], [EklenmeTarihi], [AktifMi], [MakaleID], [OnaylandiMi], [KullaniciID]) VALUES (1, N'Bilgilendirici bir paylaşım olmuş.', CAST(N'2022-04-18T16:20:45.627' AS DateTime), 1, 18, 1, 5)
INSERT [dbo].[Yorum] ([YorumID], [Icerik], [EklenmeTarihi], [AktifMi], [MakaleID], [OnaylandiMi], [KullaniciID]) VALUES (2, N'Gayet güzel açıklayıcı bir paylaşım olmuş .Emeğinize sağlık.', CAST(N'2022-04-18T16:22:08.037' AS DateTime), 1, 17, 1, 5)
INSERT [dbo].[Yorum] ([YorumID], [Icerik], [EklenmeTarihi], [AktifMi], [MakaleID], [OnaylandiMi], [KullaniciID]) VALUES (3, N'Bilgilendirme yazınız için teşekkür ederim . Vermiş olduğunuz bilgiler için teşekkür ederim.', CAST(N'2022-04-18T16:23:37.247' AS DateTime), 1, 16, 1, 8)
INSERT [dbo].[Yorum] ([YorumID], [Icerik], [EklenmeTarihi], [AktifMi], [MakaleID], [OnaylandiMi], [KullaniciID]) VALUES (4, N'Yazınızı çok beğendim. Teşekkürler.', CAST(N'2022-04-18T16:24:08.233' AS DateTime), 1, 15, 1, 6)
INSERT [dbo].[Yorum] ([YorumID], [Icerik], [EklenmeTarihi], [AktifMi], [MakaleID], [OnaylandiMi], [KullaniciID]) VALUES (5, N'Paylaşımınız için teşekkür ederim. Açıklayıcı ve yalın bir anlatım olmuş
', CAST(N'2022-04-18T16:24:59.570' AS DateTime), 1, 12, 1, 10)
INSERT [dbo].[Yorum] ([YorumID], [Icerik], [EklenmeTarihi], [AktifMi], [MakaleID], [OnaylandiMi], [KullaniciID]) VALUES (6, N'Paylaşımınızı çok faydalı buldum. Çalışmanız, emeğiniz ve bilgilendirmeleriniz için teşekkür ederim.', CAST(N'2022-04-20T13:53:40.947' AS DateTime), 1, 18, 1, 8)
INSERT [dbo].[Yorum] ([YorumID], [Icerik], [EklenmeTarihi], [AktifMi], [MakaleID], [OnaylandiMi], [KullaniciID]) VALUES (7, N'Gayet güzel ve açıklayıcı bir anlatım olmuş.', CAST(N'2022-04-20T13:54:18.220' AS DateTime), 1, 18, 1, 10)
SET IDENTITY_INSERT [dbo].[Yorum] OFF
GO
ALTER TABLE [dbo].[KullaniciRol]  WITH CHECK ADD  CONSTRAINT [FK_dbo.KullaniciRol_dbo.Kullanici_KullaniciID] FOREIGN KEY([KullaniciID])
REFERENCES [dbo].[Kullanici] ([KullaniciID])
GO
ALTER TABLE [dbo].[KullaniciRol] CHECK CONSTRAINT [FK_dbo.KullaniciRol_dbo.Kullanici_KullaniciID]
GO
ALTER TABLE [dbo].[KullaniciRol]  WITH CHECK ADD  CONSTRAINT [FK_dbo.KullaniciRol_dbo.Rol_RolID] FOREIGN KEY([RolID])
REFERENCES [dbo].[Rol] ([RolID])
GO
ALTER TABLE [dbo].[KullaniciRol] CHECK CONSTRAINT [FK_dbo.KullaniciRol_dbo.Rol_RolID]
GO
ALTER TABLE [dbo].[Makale]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Makale_dbo.Etiket_EtiketID] FOREIGN KEY([EtiketID])
REFERENCES [dbo].[Etiket] ([EtiketID])
GO
ALTER TABLE [dbo].[Makale] CHECK CONSTRAINT [FK_dbo.Makale_dbo.Etiket_EtiketID]
GO
ALTER TABLE [dbo].[Makale]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Makale_dbo.Kategori_KategoriID] FOREIGN KEY([KategoriID])
REFERENCES [dbo].[Kategori] ([KategoriID])
GO
ALTER TABLE [dbo].[Makale] CHECK CONSTRAINT [FK_dbo.Makale_dbo.Kategori_KategoriID]
GO
ALTER TABLE [dbo].[Makale]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Makale_dbo.Kullanici_KullaniciID] FOREIGN KEY([KullaniciID])
REFERENCES [dbo].[Kullanici] ([KullaniciID])
GO
ALTER TABLE [dbo].[Makale] CHECK CONSTRAINT [FK_dbo.Makale_dbo.Kullanici_KullaniciID]
GO
ALTER TABLE [dbo].[Makale]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Makale_dbo.Resim_ResimID] FOREIGN KEY([ResimID])
REFERENCES [dbo].[Resim] ([ResimID])
GO
ALTER TABLE [dbo].[Makale] CHECK CONSTRAINT [FK_dbo.Makale_dbo.Resim_ResimID]
GO
ALTER TABLE [dbo].[MakaleEtiket]  WITH CHECK ADD  CONSTRAINT [FK_dbo.MakaleEtiket_dbo.Etiket_EtiketID] FOREIGN KEY([EtiketID])
REFERENCES [dbo].[Etiket] ([EtiketID])
GO
ALTER TABLE [dbo].[MakaleEtiket] CHECK CONSTRAINT [FK_dbo.MakaleEtiket_dbo.Etiket_EtiketID]
GO
ALTER TABLE [dbo].[MakaleEtiket]  WITH CHECK ADD  CONSTRAINT [FK_dbo.MakaleEtiket_dbo.Makale_MakaleID] FOREIGN KEY([MakaleID])
REFERENCES [dbo].[Makale] ([MakaleID])
GO
ALTER TABLE [dbo].[MakaleEtiket] CHECK CONSTRAINT [FK_dbo.MakaleEtiket_dbo.Makale_MakaleID]
GO
ALTER TABLE [dbo].[Yorum]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Yorum_dbo.Kullanici_KullaniciID] FOREIGN KEY([KullaniciID])
REFERENCES [dbo].[Kullanici] ([KullaniciID])
GO
ALTER TABLE [dbo].[Yorum] CHECK CONSTRAINT [FK_dbo.Yorum_dbo.Kullanici_KullaniciID]
GO
ALTER TABLE [dbo].[Yorum]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Yorum_dbo.Makale_MakaleID] FOREIGN KEY([MakaleID])
REFERENCES [dbo].[Makale] ([MakaleID])
GO
ALTER TABLE [dbo].[Yorum] CHECK CONSTRAINT [FK_dbo.Yorum_dbo.Makale_MakaleID]
GO
