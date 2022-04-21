namespace Blog.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Makale")]
    public partial class Makale
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Makale()
        {
            MakaleEtiket = new HashSet<MakaleEtiket>();
            Yorum = new HashSet<Yorum>();
        }

        public int MakaleID { get; set; }

        [Required]
        [StringLength(100)]
        public string Baslik { get; set; }

        [Required]
        public string Icerik { get; set; }

        public DateTime EklenmeTarihi { get; set; }

        public int? GoruntulenmeSayisi { get; set; }

        public int? BegeniSayisi { get; set; }

        public int? KategoriID { get; set; }

        public int? EtiketID { get; set; }

        public int? ResimID { get; set; }

        public int? KullaniciID { get; set; }

        public bool? AktifMi { get; set; }

        public bool? OnaylandiMi { get; set; }

        public virtual Etiket Etiket { get; set; }

        public virtual Kategori Kategori { get; set; }

        public virtual Kullanici Kullanici { get; set; }

        public virtual Resim Resim { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<MakaleEtiket> MakaleEtiket { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Yorum> Yorum { get; set; }
    }
}
