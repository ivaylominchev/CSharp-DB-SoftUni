using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static ArtCollective.Common.EntityValidationConstants.Artist;
namespace ArtCollective.Data.Models
{
    public class Artist
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(ArtistUserNameMaxLength)]
        public string Username { get; set; } = null!;

        [Required]
        [MaxLength(ArtistEmailMaxLength)]
        public string Email { get; set; } = null!;

        [Required]
        public string Password { get; set; } = null!;

        public virtual ICollection<Artwork> Artworks { get; set; }
            = new HashSet<Artwork>();

        public virtual ICollection<Feedback> Feedbacks { get; set; } 
            = new HashSet<Feedback>();

        public virtual ICollection<ArtistGroup> ArtistsGroups { get; set; } 
            = new HashSet<ArtistGroup>();
    }
}
