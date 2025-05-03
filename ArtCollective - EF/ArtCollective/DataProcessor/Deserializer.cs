using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Text;
using ArtCollective.Data;
using ArtCollective.Data.Models;
using ArtCollective.Data.Models.Enums;
using ArtCollective.DataProcessor.ImportDTOs;
using ArtCollective.Utilities;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualBasic;
using Newtonsoft.Json;
using static ArtCollective.Common.EntityValidationConstants.Feedback;
using static ArtCollective.Common.EntityValidationConstants.Artist;


namespace ArtCollective.DataProcessor
{
    public class Deserializer
    {
        private const string ErrorMessage = "Invalid data format.";
        private const string DuplicatedData = "Data is duplicated.";
        private const string SuccessfullyImportedFeedbackEntity = "Successfully imported feedback (Given on: {0}, Status: {1})";
        private const string SuccessfullyImportedArtworkEntity = "Successfully imported artwork (Artist: {0}, Created on: {1})";

        public static string ImportFeedbacks(ArtCollectiveDbContext dbContext, string xmlString)
        {
            const string xmlRootName = "Feedbacks";

            StringBuilder output = new StringBuilder();

            ImportFeedbackDto[]? feedbackDtos = XmlHelper
                .Deserialize<ImportFeedbackDto[]>(xmlString, xmlRootName);
            if (feedbackDtos != null && feedbackDtos.Length > 0)
            {
                ICollection<Feedback> validFeedbacks = new List<Feedback>();
                foreach (ImportFeedbackDto feedbackDto in feedbackDtos)
                {
                    if (!IsValid(feedbackDto))
                    {
                        output
                        .AppendLine(ErrorMessage);
                        continue;
                    }

                    if (!DateTime.TryParseExact(feedbackDto.GivenOn, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out var givenOn))
                    {
                        output
                            .AppendLine(ErrorMessage);
                        continue;
                    }

                    if (!Enum.TryParse<Status>(feedbackDto.Status, true, out var status) ||
                        !Enum.IsDefined(typeof(Status), status))
                    {
                        output
                            .AppendLine(ErrorMessage);
                        continue;
                    }

                    if (!int.TryParse(feedbackDto.GroupId, out var groupId) || !dbContext.Groups.Any(g => g.Id == groupId))
                    {
                        output
                            .AppendLine(ErrorMessage);
                        continue;
                    }

                    if (!int.TryParse(feedbackDto.ArtistId, out var artistId) || !dbContext.Artists.Any(a => a.Id == artistId))
                    {
                        output
                            .AppendLine(ErrorMessage);
                        continue;
                    }

                    bool isDuplicate = dbContext
                        .Feedbacks.Any(f =>
                        f.Content == feedbackDto.Content &&
                        f.GivenOn == givenOn &&
                        f.Status == status &&
                        f.ArtistId == artistId &&
                        f.GroupId == groupId);

                    bool isToBeImported = validFeedbacks
                        .Any(f =>
                        f.Content == feedbackDto.Content &&
                        f.GivenOn == givenOn &&
                        f.Status == status &&
                        f.ArtistId == artistId &&
                        f.GroupId == groupId);

                    if (isDuplicate || isToBeImported)
                    {
                        output 
                            .AppendLine(DuplicatedData);
                        continue;
                    }

                    Feedback feedback = new Feedback()
                    {
                        Content = feedbackDto.Content,
                        GivenOn = givenOn,
                        Status = status,
                        GroupId = groupId,
                        ArtistId = artistId
                    };
                    validFeedbacks.Add(feedback);

                    string successMessage = string
                        .Format(SuccessfullyImportedFeedbackEntity, feedbackDto.GivenOn, feedbackDto.Status);
                    output
                        .AppendLine(successMessage);
                }
                dbContext.Feedbacks.AddRange(validFeedbacks);
                dbContext.SaveChanges();
            }
            return output.ToString().TrimEnd();
        }

        public static string ImportArtworks(ArtCollectiveDbContext dbContext, string jsonString)
        {
            StringBuilder output = new StringBuilder();

            ImportArtworkDto[]? artworkDtos = JsonConvert.DeserializeObject<ImportArtworkDto[]>(jsonString);

            if (artworkDtos != null && artworkDtos.Length > 0)
            {
                ICollection<Artwork> validArtworks = new List<Artwork>();
                foreach (ImportArtworkDto artworkDto in artworkDtos)
                {
                    if (!IsValid(artworkDto))
                    {
                        output.AppendLine(ErrorMessage);
                        continue;
                    }

                    if (!DateTime.TryParseExact(artworkDto.CreatedOn, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out var createdOn))
                    {
                        output.AppendLine(ErrorMessage);
                        continue;
                    }

                    Artist? artist = dbContext.Artists.FirstOrDefault(a => a.Id == artworkDto.ArtistId);
                    if (artist == null)
                    {
                        output.AppendLine(ErrorMessage);
                        continue;
                    }

                    string normalizedTitle = artworkDto.Title.Trim().ToLower();

                    bool isDuplicate = dbContext.Artworks.Any(a =>
                        a.Title.Trim().ToLower() == normalizedTitle &&
                        a.ArtistId == artworkDto.ArtistId);

                    bool isDuplicateInBatch = validArtworks.Any(a =>
                        a.Title.Trim().ToLower() == normalizedTitle &&
                        a.ArtistId == artworkDto.ArtistId);

                    if (isDuplicate || isDuplicateInBatch)
                    {
                        output.AppendLine(DuplicatedData);
                        continue;
                    }

                    Artwork artwork = new Artwork
                    {
                        Title = artworkDto.Title,
                        Description = artworkDto.Description,
                        CreatedOn = createdOn,
                        ArtistId = artworkDto.ArtistId,
                        Artist = artist
                    };
                    validArtworks.Add(artwork);

                    string successMessage = string.Format(
                        SuccessfullyImportedArtworkEntity,
                        artist.Username,
                        createdOn.ToString("yyyy-MM-dd"));
                    output.AppendLine(successMessage);
                }

                dbContext.Artworks.AddRange(validArtworks);
                dbContext.SaveChanges();
            }

            return output.ToString().TrimEnd();
        }

        public static bool IsValid(object dto)
        {
            ValidationContext validationContext = new ValidationContext(dto);
            List<ValidationResult> validationResults = new List<ValidationResult>();

            List<string> errorMessages = new List<string>();
            bool isValid = Validator.TryValidateObject(dto, validationContext, validationResults, true);

            errorMessages = validationResults.Select(r => r.ErrorMessage!).ToList();

            return isValid;
        }
    }
}
