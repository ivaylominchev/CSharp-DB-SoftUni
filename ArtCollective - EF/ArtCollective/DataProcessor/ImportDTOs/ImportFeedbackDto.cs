using ArtCollective.Common;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;
using static ArtCollective.Common.EntityValidationConstants;
namespace ArtCollective.DataProcessor.ImportDTOs
{
    using static Common.EntityValidationConstants.Feedback;
    [XmlType(nameof(Feedback))]
    public class ImportFeedbackDto
    {
        [Required]
        [XmlElement(nameof(Content))]
        [MinLength(FeedbackContentMinLength)]
        [MaxLength(FeedbackContentMaxLength)]
        public string Content { get; set; } = null!;

        [XmlElement(nameof(Status))]
        public string Status { get; set; } = null!;

        [XmlElement(nameof(GroupId))]
        [Required]
        public string GroupId { get; set; } = null!;

        [XmlElement(nameof(ArtistId))]
        [Required]
        public string ArtistId { get; set; } = null!;

        [XmlAttribute("GivenOn")]
        [Required]
        public string GivenOn { get; set; } = null!;
    }
}
