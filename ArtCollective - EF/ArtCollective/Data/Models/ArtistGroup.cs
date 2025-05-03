using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ArtCollective.Data.Models
{
    public class ArtistGroup
    {
        [Required]
        [ForeignKey(nameof(Artist))]
        public int ArtistId { get; set; }

        public virtual Artist Artist { get; set; } = null!;

        [Required]
        [ForeignKey(nameof(Group))]
        public int GroupId { get; set; }

        public virtual Group Group { get; set; } = null!;
    }
}
