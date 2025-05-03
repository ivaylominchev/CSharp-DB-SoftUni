using System.Xml.Serialization;
using System.Xml;
using ArtCollective.Data;
using Newtonsoft.Json;
using System.Globalization;
using Microsoft.EntityFrameworkCore;
using ArtCollective.DataProcessor.ExportDTOs;
using ArtCollective.Utilities;
using ArtCollective.DataProcessor.ImportDTOs;
using Formatting = Newtonsoft.Json.Formatting;

namespace ArtCollective.DataProcessor
{
    public class Serializer
    {
        public static string ExportArtistsWithCollaborationsCountAndTheirArtworks(ArtCollectiveDbContext dbContext)
        {
            const string xmlRootName = "Artists";
            var artists = dbContext.Artists
            .Include(a => a.Artworks)
            .Select(a => new ExportArtistsDto
            {
                Username = a.Username,
                Collaborations = dbContext.Collaborations
                    .Count(c => c.ArtistOneId == a.Id || c.ArtistTwoId == a.Id),
                Artworks = a.Artworks
                    .OrderBy(aw => aw.Id)
                    .Select(aw => new ExportArtworksDto
                    {
                        Title = aw.Title,
                        CreatedOn = aw.CreatedOn.ToString("yyyy-MM-dd")
                    })
                    .ToArray()
            })
            .OrderBy(a => a.Username)
            .ToList();

            string result = XmlHelper
                .Serialize(artists, xmlRootName);

            return result;
        }
        public static string ExportGroupsWithFeedbacksChronologically(ArtCollectiveDbContext dbContext)
        {
            var feedbacks = dbContext.Groups
                .OrderBy(g => g.StartedOn)
                .Select(g => new
                {
                    Id = g.Id,
                    Title = g.Title,
                    StartedOn = g.StartedOn.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture),
                    Feedbacks = g.Feedbacks
                        .OrderBy(f => f.GivenOn)
                        .Select(f => new
                        {
                            Content = f.Content,
                            GivenOn = f.GivenOn.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture),
                            Status = (int)f.Status, 
                            ArtistUsername = f.Artist.Username
                        })
                        .ToArray()
                })
                .ToArray();

            string result = JsonConvert
                .SerializeObject(feedbacks, Formatting.Indented);
            return result;
        }
    }
}
