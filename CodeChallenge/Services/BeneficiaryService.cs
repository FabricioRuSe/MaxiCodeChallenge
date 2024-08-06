using CodeChallenge.DataAccess;
using CodeChallenge.Helpers;
using CodeChallenge.Interfaces;
using CodeChallenge.Models.Dtos;
using CodeChallenge.Models.Entities;
using Dapper;

namespace CodeChallenge.Services
{
    public class BeneficiaryService : IBeneficiaryService
    {
        public readonly IGenericRepository _repository;

        public BeneficiaryService(IGenericRepository repository)
        {
            _repository = repository;
        }

        public async Task<IEnumerable<EmployeeBeneficiaryDto>> GetBeneficiariesByEmployee(int employeeId)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@EmployeeId", employeeId);

            IEnumerable<EmployeeBeneficiaryDto> result = await _repository.RunProcedureListAsync<EmployeeBeneficiaryDto, DynamicParameters>(parameters, SpName.GetBeneficiariesByEmployee);
            return result;
        }

        public async Task<IEnumerable<BeneficiaryDto>> GetBeneficiaries()
        {
            IEnumerable<BeneficiaryDto> result = await _repository.RunProcedureListAsync<BeneficiaryDto>(SpName.GetBeneficiaries);
            return result;
        }

        public async Task<BeneficiaryDto> GetBeneficiary(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@Id", id);

            BeneficiaryDto result = await _repository.RunProcedureAsync<BeneficiaryDto, DynamicParameters>(parameters, SpName.GetBeneficiary);
            return result;
        }

        public async Task<BeneficiaryDto> AddBeneficiary(BeneficiaryDto beneficiaryDto)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@Name", beneficiaryDto.Name);
            parameters.Add("@FirstLastName", beneficiaryDto.FirstLastName);
            parameters.Add("@SecondLastName", beneficiaryDto.SecondLastName);
            parameters.Add("@DateOfBirth", beneficiaryDto.DateOfBirth);
            parameters.Add("@Curp", beneficiaryDto.Curp);
            parameters.Add("@Ssn", beneficiaryDto.Ssn);
            parameters.Add("@Phone", beneficiaryDto.Phone);
            parameters.Add("@Nationality", beneficiaryDto.Nationality);

            BeneficiaryDto result = await _repository.RunProcedureAsync<BeneficiaryDto, DynamicParameters>(parameters, SpName.AddBeneficiary);
            return result;
        }

        public async Task<BeneficiaryDto> UpdateBeneficiary(BeneficiaryDto beneficiaryDto)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@Id", beneficiaryDto.Id);
            parameters.Add("@Name", beneficiaryDto.Name);
            parameters.Add("@FirstLastName", beneficiaryDto.FirstLastName);
            parameters.Add("@SecondLastName", beneficiaryDto.SecondLastName);
            parameters.Add("@DateOfBirth", beneficiaryDto.DateOfBirth);
            parameters.Add("@Curp", beneficiaryDto.Curp);
            parameters.Add("@Ssn", beneficiaryDto.Ssn);
            parameters.Add("@Phone", beneficiaryDto.Phone);
            parameters.Add("@Nationality", beneficiaryDto.Nationality);

            BeneficiaryDto result = await _repository.RunProcedureAsync<BeneficiaryDto, DynamicParameters>(parameters, SpName.UpdateBeneficiary);
            return result;
        }

        public async Task DeleteBeneficiary(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@Id", id);

            await _repository.RunProcedureAsync(parameters, SpName.DeleteBeneficiary);
        }

        public async Task BeneficiariesToEmployee(IEnumerable<BeneficiariesToEmployeeDto> employeeBeneficiaryDto)
        {
            DynamicParameters parameters = new DynamicParameters();

            foreach(var beneficiary in employeeBeneficiaryDto)
            {
                parameters.Add("@EmployeeId", beneficiary.EmployeeId);
                parameters.Add("@BeneficiaryId", beneficiary.Id);
                parameters.Add("@Percentage", beneficiary.Percentage);

                await _repository.RunProcedureAsync(parameters, SpName.AttachBeneficiaryToEmployee);
            }
        }

        public async Task RemoveAllBeneficiariesByEmployee(int employeeId)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@EmployeeId", employeeId);

            await _repository.RunProcedureAsync(parameters, SpName.RemoveAllBeneficiariesByEmployee);
        }

    }
}
