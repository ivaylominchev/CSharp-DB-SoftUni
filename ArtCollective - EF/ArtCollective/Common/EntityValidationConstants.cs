using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ArtCollective.Common
{
    public class EntityValidationConstants
    {
        public static class Artist
        {
            public const int ArtistUserNameMinLength = 5;
            public const int ArtistUserNameMaxLength = 30;

            public const int ArtistEmailMinLength = 6;
            public const int ArtistEmailMaxLength = 50;

            public const int ArtistPasswordMinLength = 4;

        }

        public static class Group
        {
            public const int GroupTitleMinLength = 3;
            public const int GroupTitleMaxLength = 50;

        }

        public static class Artwork
        {
            public const int ArtWorkTitleMinLength = 3;
            public const int ArtWorkTitleMaxLength = 50;

            public const int ArtWorkDescriptionMinLength = 10;
            public const int ArtWorkDescriptionMaxLength = 300;

        }

        public static class Feedback
        {
            public const int FeedbackContentMinLength = 3;
            public const int FeedbackContentMaxLength = 200;

            public const string FeedbackDateFormat = "yyyy-MM-dd";

        }

    }
}
