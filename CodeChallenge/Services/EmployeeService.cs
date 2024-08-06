using CodeChallenge.DataAccess;
using CodeChallenge.Helpers;
using CodeChallenge.Interfaces;
using CodeChallenge.Models.Dtos;
using Dapper;

namespace CodeChallenge.Services
{
    public class EmployeeService : IEmployeeService
    {
        public readonly IGenericRepository _repository;

        public EmployeeService(IGenericRepository repository)
        {
            _repository = repository;
        }

        public async Task<IEnumerable<EmployeeDto>> GetEmployees()
        {
            IEnumerable<EmployeeDto> result = await _repository.RunProcedureListAsync<EmployeeDto>(SpName.GetEmployees);
            return result;
        }

        public async Task<EmployeeDto> GetEmployee(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@Id", id);

            EmployeeDto result = await _repository.RunProcedureAsync<EmployeeDto, DynamicParameters>(parameters, SpName.GetEmployee);
            return result;
        }

        public async Task<EmployeeDto> AddEmployee(EmployeeDto employeeDto)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@Name", employeeDto.Name);
            parameters.Add("@FirstLastName", employeeDto.FirstLastName);
            parameters.Add("@SecondLastName", employeeDto.SecondLastName);
            parameters.Add("@DateOfBirth", employeeDto.DateOfBirth);
            parameters.Add("@Curp", employeeDto.Curp);
            parameters.Add("@Ssn", employeeDto.Ssn);
            parameters.Add("@Phone", employeeDto.Phone);
            parameters.Add("@Nationality", employeeDto.Nationality);

            EmployeeDto result = await _repository.RunProcedureAsync<EmployeeDto, DynamicParameters>(parameters, SpName.AddEmployee);
            return result;
        }

        public async Task<EmployeeDto> UpdateEmployee(EmployeeDto employeeDto)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@Id", employeeDto.Id);
            parameters.Add("@Name", employeeDto.Name);
            parameters.Add("@FirstLastName", employeeDto.FirstLastName);
            parameters.Add("@SecondLastName", employeeDto.SecondLastName);
            parameters.Add("@DateOfBirth", employeeDto.DateOfBirth);
            parameters.Add("@Curp", employeeDto.Curp);
            parameters.Add("@Ssn", employeeDto.Ssn);
            parameters.Add("@Phone", employeeDto.Phone);
            parameters.Add("@Nationality", employeeDto.Nationality);

            EmployeeDto result = await _repository.RunProcedureAsync<EmployeeDto, DynamicParameters>(parameters, SpName.UpdateEmployee);
            return result;
        }

        public async Task DeleteEmployee(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@Id", id);

            await _repository.RunProcedureAsync(parameters, SpName.DeleteEmployee);
        }

    }
}
