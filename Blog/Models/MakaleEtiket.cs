namespace Blog.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("MakaleEtiket")]
    public partial class MakaleEtiket
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int MakaleID { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int EtiketID { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int MakaleEtiketID { get; set; }

        public virtual Etiket Etiket { get; set; }

        public virtual Makale Makale { get; set; }
    }
}
