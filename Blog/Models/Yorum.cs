namespace Blog.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Yorum")]
    public partial class Yorum
    {
        public int YorumID { get; set; }

        [StringLength(1500)]
        public string Icerik { get; set; }

        public DateTime? EklenmeTarihi { get; set; }

        public bool AktifMi { get; set; }

        public int? MakaleID { get; set; }

        public bool? OnaylandiMi { get; set; }

        public int? KullaniciID { get; set; }

        public virtual Kullanici Kullanici { get; set; }

        public virtual Makale Makale { get; set; }
    }
}
