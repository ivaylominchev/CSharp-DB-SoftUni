using ArtCollective.Data.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace ArtCollective.DataProcessor.ExportDTOs
{
    [XmlType(nameof(Artwork))]
    public class ExportArtworksDto
    {
        [XmlElement(nameof(Title))]
        public string Title { get; set; } = null!;

        [XmlElement(nameof(CreatedOn))]
        public string CreatedOn { get; set; } = null!;
    }
    

    
}
