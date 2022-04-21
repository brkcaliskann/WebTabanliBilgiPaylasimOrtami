namespace Blog.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Log")]
    public partial class Log
    {
        public int LogID { get; set; }

        [StringLength(50)]
        public string MetotAdi { get; set; }

        [StringLength(50)]
        public string IP { get; set; }

        public string Tarayici { get; set; }

        public DateTime? Tarih { get; set; }

        [StringLength(50)]
        public string ControllerAdi { get; set; }

        [StringLength(50)]
        public string KullaniciAdi { get; set; }
    }
}
