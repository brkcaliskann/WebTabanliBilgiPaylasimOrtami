namespace Blog.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Kullanici")]
    public partial class Kullanici
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Kullanici()
        {
            KullaniciRol = new HashSet<KullaniciRol>();
            Makale = new HashSet<Makale>();
            Yorum = new HashSet<Yorum>();
        }

        public int KullaniciID { get; set; }

        [StringLength(50)]
        public string Adi { get; set; }

        [StringLength(100)]
        public string Soyadi { get; set; }

        public DateTime? DogumTarihi { get; set; }

        [StringLength(50)]
        public string Mail { get; set; }

        [StringLength(50)]
        public string KullaniciAdi { get; set; }

        [StringLength(50)]
        public string Parola { get; set; }

        public DateTime? KayitTarihi { get; set; }

        public bool? OnaylandiMi { get; set; }

        public bool? YazarMi { get; set; }

        public bool? AktifMi { get; set; }

        [StringLength(1000)]
        public string Hakkinda { get; set; }

        public int? ResimID { get; set; }

        public bool BeniHatirla { get; set; }

        public virtual Resim Resim { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<KullaniciRol> KullaniciRol { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Makale> Makale { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Yorum> Yorum { get; set; }
    }
}
