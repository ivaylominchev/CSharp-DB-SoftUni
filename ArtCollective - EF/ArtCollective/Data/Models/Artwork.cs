using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static ArtCollective.Common.EntityValidationConstants.Artwork;
namespace ArtCollective.Data.Models
{
    public class Artwork
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(ArtWorkTitleMaxLength)]
        public string Title { get; set; } = null!;

        [MaxLength(ArtWorkDescriptionMaxLength)]
        public string? Description { get; set; }


        [Required]
        public DateTime CreatedOn { get; set; }

        [Required]
        [ForeignKey(nameof(Artist))]
        public int ArtistId { get; set; }

        public virtual Artist Artist { get; set; } = null!;
    }
}
