using System;
using System.Text.RegularExpressions;

namespace M4_Website.Models
{
    /// <summary>
    /// Centralized data validation utility class for common validation rules
    /// </summary>
    public static class ValidationHelper
    {
        #region Email Validation

        /// <summary>
        /// Validates email format
        /// </summary>
        /// <param name="email">Email address to validate</param>
        /// <returns>True if valid, false otherwise</returns>
        public static bool IsValidEmail(string email)
        {
            if (string.IsNullOrWhiteSpace(email))
                return false;

            try
            {
                // Standard email regex pattern
                string pattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
                return Regex.IsMatch(email.Trim(), pattern);
            }
            catch
            {
                return false;
            }
        }

        #endregion

        #region South African ID Number Validation

        /// <summary>
        /// Validates South African ID number (13 digits)
        /// Format: YYMMDDGSSSCAZ
        /// YY - Year of birth
        /// MM - Month of birth (01-12)
        /// DD - Day of birth (01-31)
        /// G - Gender (0-4 female, 5-9 male)
        /// SSS - Sequence number
        /// C - Citizenship (0 = SA citizen, 1 = permanent resident)
        /// A - Usually 8 or 9
        /// Z - Checksum digit
        /// </summary>
        /// <param name="idNumber">SA ID number to validate</param>
        /// <returns>True if valid, false otherwise</returns>
        public static bool IsValidSAIDNumber(string idNumber)
        {
            if (string.IsNullOrWhiteSpace(idNumber))
                return false;

            // Remove any spaces
            idNumber = idNumber.Trim().Replace(" ", "");

            // Must be exactly 13 digits
            if (!Regex.IsMatch(idNumber, @"^\d{13}$"))
                return false;

            try
            {
                // Extract date components
                int year = int.Parse(idNumber.Substring(0, 2));
                int month = int.Parse(idNumber.Substring(2, 2));
                int day = int.Parse(idNumber.Substring(4, 2));

                // Validate month (01-12)
                if (month < 1 || month > 12)
                    return false;

                // Validate day (01-31)
                if (day < 1 || day > 31)
                    return false;

                // Validate date is real (e.g., not Feb 30)
                try
                {
                    // Determine century (assume < 25 is 2000s, >= 25 is 1900s for people alive today)
                    int fullYear = year < 25 ? 2000 + year : 1900 + year;
                    DateTime testDate = new DateTime(fullYear, month, day);
                }
                catch
                {
                    return false; // Invalid date like Feb 30
                }

                // Validate using Luhn algorithm (checksum)
                return ValidateIDChecksum(idNumber);
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// Validates ID number checksum using modified Luhn algorithm for SA ID numbers
        /// </summary>
        private static bool ValidateIDChecksum(string idNumber)
        {
            try
            {
                // Take first 12 digits (exclude the checksum digit at position 12)
                string first12 = idNumber.Substring(0, 12);
                
                // Step 1: Add all digits in odd positions (1st, 3rd, 5th, 7th, 9th, 11th) - using 0-based index: 0, 2, 4, 6, 8, 10
                int oddSum = 0;
                for (int i = 0; i < 12; i += 2)
                {
                    oddSum += int.Parse(idNumber[i].ToString());
                }

                // Step 2: Take all digits in even positions (2nd, 4th, 6th, 8th, 10th, 12th) - using 0-based index: 1, 3, 5, 7, 9, 11
                // Concatenate them to form a number, multiply by 2
                string evenDigits = "";
                for (int i = 1; i < 12; i += 2)
                {
                    evenDigits += idNumber[i].ToString();
                }
                int evenNumber = int.Parse(evenDigits);
                int evenMultiplied = evenNumber * 2;

                // Step 3: Add all digits of the result from step 2
                int evenSum = 0;
                string evenMultipliedStr = evenMultiplied.ToString();
                foreach (char c in evenMultipliedStr)
                {
                    evenSum += int.Parse(c.ToString());
                }

                // Step 4: Add the results of step 1 and step 3
                int total = oddSum + evenSum;

                // Step 5: Subtract from next highest multiple of 10
                int checksum = (10 - (total % 10)) % 10;

                // Step 6: Compare with the 13th digit (checksum digit)
                int lastDigit = int.Parse(idNumber[12].ToString());

                return checksum == lastDigit;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// Extracts date of birth from SA ID number
        /// </summary>
        public static DateTime? GetDateOfBirthFromIDNumber(string idNumber)
        {
            if (!IsValidSAIDNumber(idNumber))
                return null;

            try
            {
                int year = int.Parse(idNumber.Substring(0, 2));
                int month = int.Parse(idNumber.Substring(2, 2));
                int day = int.Parse(idNumber.Substring(4, 2));

                // Determine century (assume < 25 is 2000s, >= 25 is 1900s)
                int fullYear = year < 25 ? 2000 + year : 1900 + year;

                return new DateTime(fullYear, month, day);
            }
            catch
            {
                return null;
            }
        }

        /// <summary>
        /// Extracts gender from SA ID number
        /// </summary>
        /// <returns>"Male", "Female", or null if invalid</returns>
        public static string GetGenderFromIDNumber(string idNumber)
        {
            if (!IsValidSAIDNumber(idNumber))
                return null;

            try
            {
                int genderDigit = int.Parse(idNumber[6].ToString());
                return genderDigit >= 5 ? "Male" : "Female";
            }
            catch
            {
                return null;
            }
        }

        #endregion

        #region Phone Number Validation

        /// <summary>
        /// Validates phone number format (South African format)
        /// Accepts: 0123456789, 012-345-6789, 012 345 6789, +27123456789
        /// </summary>
        /// <param name="phoneNumber">Phone number to validate</param>
        /// <returns>True if valid, false otherwise</returns>
        public static bool IsValidPhoneNumber(string phoneNumber)
        {
            if (string.IsNullOrWhiteSpace(phoneNumber))
                return false;

            // Remove spaces, dashes, and parentheses
            string cleanNumber = phoneNumber.Trim()
                .Replace(" ", "")
                .Replace("-", "")
                .Replace("(", "")
                .Replace(")", "");

            // Check for valid South African phone number patterns
            // Local: 0123456789 (10 digits starting with 0)
            // International: +27123456789 (12 digits starting with +27)
            // Mobile: 0712345678, 0823456789, etc.

            if (cleanNumber.StartsWith("+27"))
            {
                // International format: +27 followed by 9 digits
                return Regex.IsMatch(cleanNumber, @"^\+27\d{9}$");
            }
            else if (cleanNumber.StartsWith("0"))
            {
                // Local format: 0 followed by 9 digits
                return Regex.IsMatch(cleanNumber, @"^0\d{9}$");
            }

            return false;
        }

        /// <summary>
        /// Formats phone number to standard display format
        /// </summary>
        public static string FormatPhoneNumber(string phoneNumber)
        {
            if (string.IsNullOrWhiteSpace(phoneNumber))
                return phoneNumber;

            string cleanNumber = phoneNumber.Trim()
                .Replace(" ", "")
                .Replace("-", "")
                .Replace("(", "")
                .Replace(")", "");

            if (cleanNumber.StartsWith("+27") && cleanNumber.Length == 12)
            {
                // Format: +27 12 345 6789
                return $"+27 {cleanNumber.Substring(3, 2)} {cleanNumber.Substring(5, 3)} {cleanNumber.Substring(8)}";
            }
            else if (cleanNumber.StartsWith("0") && cleanNumber.Length == 10)
            {
                // Format: 012 345 6789
                return $"{cleanNumber.Substring(0, 3)} {cleanNumber.Substring(3, 3)} {cleanNumber.Substring(6)}";
            }

            return phoneNumber;
        }

        #endregion

        #region Name Validation

        /// <summary>
        /// Validates that a name contains only letters, spaces, hyphens, and apostrophes
        /// </summary>
        public static bool IsValidName(string name)
        {
            if (string.IsNullOrWhiteSpace(name))
                return false;

            // Allow letters, spaces, hyphens, and apostrophes
            string pattern = @"^[a-zA-Z\s\-']+$";
            return Regex.IsMatch(name.Trim(), pattern);
        }

        #endregion

        #region Postal Code Validation

        /// <summary>
        /// Validates South African postal code (4 digits)
        /// </summary>
        public static bool IsValidPostalCode(string postalCode)
        {
            if (string.IsNullOrWhiteSpace(postalCode))
                return false;

            string cleanCode = postalCode.Trim();
            return Regex.IsMatch(cleanCode, @"^\d{4}$");
        }

        #endregion

        #region Combined Validation

        /// <summary>
        /// Gets a list of validation errors for student data
        /// </summary>
        /// <returns>List of error messages, empty if all valid</returns>
        public static System.Collections.Generic.List<string> ValidateStudentData(
            string name, 
            string surname, 
            string email, 
            string phoneNumber, 
            string idNumber, 
            string postalCode = null)
        {
            var errors = new System.Collections.Generic.List<string>();

            if (string.IsNullOrWhiteSpace(name))
                errors.Add("Name is required");
            else if (!IsValidName(name))
                errors.Add("Name contains invalid characters");

            if (string.IsNullOrWhiteSpace(surname))
                errors.Add("Surname is required");
            else if (!IsValidName(surname))
                errors.Add("Surname contains invalid characters");

            if (string.IsNullOrWhiteSpace(email))
                errors.Add("Email is required");
            else if (!IsValidEmail(email))
                errors.Add("Email format is invalid");

            if (string.IsNullOrWhiteSpace(phoneNumber))
                errors.Add("Phone number is required");
            else if (!IsValidPhoneNumber(phoneNumber))
                errors.Add("Phone number format is invalid");

            if (string.IsNullOrWhiteSpace(idNumber))
                errors.Add("ID number is required");
            else if (!IsValidSAIDNumber(idNumber))
                errors.Add("ID number is invalid or checksum does not match");

            if (!string.IsNullOrWhiteSpace(postalCode) && !IsValidPostalCode(postalCode))
                errors.Add("Postal code must be 4 digits");

            return errors;
        }

        /// <summary>
        /// Gets validation error message for a specific field
        /// </summary>
        public static string GetFieldValidationError(string fieldName, string value)
        {
            switch (fieldName.ToLower())
            {
                case "email":
                    if (string.IsNullOrWhiteSpace(value))
                        return "Email is required";
                    if (!IsValidEmail(value))
                        return "Invalid email format";
                    break;

                case "phone":
                case "phonenumber":
                    if (string.IsNullOrWhiteSpace(value))
                        return "Phone number is required";
                    if (!IsValidPhoneNumber(value))
                        return "Invalid phone number format";
                    break;

                case "idnumber":
                case "idno":
                    if (string.IsNullOrWhiteSpace(value))
                        return "ID number is required";
                    if (!IsValidSAIDNumber(value))
                        return "Invalid SA ID number";
                    break;

                case "name":
                case "surname":
                    if (string.IsNullOrWhiteSpace(value))
                        return $"{fieldName} is required";
                    if (!IsValidName(value))
                        return $"{fieldName} contains invalid characters";
                    break;

                case "postalcode":
                    if (!string.IsNullOrWhiteSpace(value) && !IsValidPostalCode(value))
                        return "Postal code must be 4 digits";
                    break;
            }

            return null;
        }

        #endregion
    }
}
