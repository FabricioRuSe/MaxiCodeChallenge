using CodeChallenge.Models.Dtos;

namespace CodeChallenge.Interfaces
{
    public interface IBeneficiaryService
    {
        Task<IEnumerable<EmployeeBeneficiaryDto>> GetBeneficiariesByEmployee(int employeeId);
        Task<IEnumerable<BeneficiaryDto>> GetBeneficiaries();
        Task<BeneficiaryDto> GetBeneficiary(int id);
        Task<BeneficiaryDto> AddBeneficiary(BeneficiaryDto beneficiaryDto);
        Task<BeneficiaryDto> UpdateBeneficiary(BeneficiaryDto beneficiaryDto);
        Task DeleteBeneficiary(int id);
        Task BeneficiariesToEmployee(IEnumerable<BeneficiariesToEmployeeDto> employeeBeneficiaryDto);
        Task RemoveAllBeneficiariesByEmployee(int employeeId); 
    }
}
