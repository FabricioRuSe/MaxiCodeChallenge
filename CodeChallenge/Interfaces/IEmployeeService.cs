using CodeChallenge.Models.Dtos;
using Microsoft.AspNetCore.Mvc;

namespace CodeChallenge.Interfaces
{
    public interface IEmployeeService
    {
        Task<IEnumerable<EmployeeDto>> GetEmployees();
        Task<EmployeeDto> GetEmployee(int id);
        Task<EmployeeDto> AddEmployee(EmployeeDto employeeDto);
        Task<EmployeeDto> UpdateEmployee(EmployeeDto employeeDto);
        Task DeleteEmployee(int id);
    }
}
