using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Reflection.Metadata;
using System.Text;
using System.Threading.Tasks;

namespace ArtCollective.DataProcessor.ImportDTOs
{
    using static Common.EntityValidationConstants.Artwork;
    public class ImportArtworkDto
    {
        [Required]
        [MinLength(ArtWorkTitleMinLength)]
        [MaxLength(ArtWorkTitleMaxLength)]
        [JsonProperty(nameof(Title))]
        public string Title { get; set; } = null!;

        [MinLength(ArtWorkDescriptionMinLength)]
        [MaxLength(ArtWorkDescriptionMaxLength)]
        public string? Description { get; set; }

        [Required]
        public string CreatedOn { get; set; } = null!;

        [Required]
        public int ArtistId { get; set; }
    }
}
