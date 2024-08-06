namespace CodeChallenge.Models.Dtos
{
    public class BeneficiaryDto
    {
        public int? Id { get; set; }
        public string Name { get; set; }
        public string FirstLastName { get; set; }
        public string SecondLastName { get; set; }
        public DateTime DateOfBirth { get; set; }
        public string Curp { get; set; }
        public string Ssn { get; set; }
        public string Phone { get; set; }
        public string Nationality { get; set; }
    }
}
