using ArtCollective.Data.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace ArtCollective.DataProcessor.ExportDTOs
{
    [XmlType(nameof(Artist))]
    public class ExportArtistsDto
    {
        [XmlAttribute(nameof(Collaborations))]
        public int Collaborations { get; set; }

        [XmlElement(nameof(Username))]
        public string Username { get; set; } = null!;

        [XmlArray(nameof(Artworks))]
        public ExportArtworksDto[] Artworks { get; set; } = null!;
    }
}
