namespace Blog.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("KullaniciRol")]
    public partial class KullaniciRol
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int KullaniciID { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int RolID { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int KullaniciRolID { get; set; }

        public virtual Kullanici Kullanici { get; set; }

        public virtual Rol Rol { get; set; }
    }
}
