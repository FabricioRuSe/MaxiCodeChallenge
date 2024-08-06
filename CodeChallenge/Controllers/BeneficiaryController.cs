using CodeChallenge.Interfaces;
using CodeChallenge.Models.Dtos;
using CodeChallenge.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace CodeChallenge.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BeneficiaryController : ControllerBase
    {
        private readonly IBeneficiaryService _beneficiaryService;

        public BeneficiaryController(IBeneficiaryService beneficiaryService)
        {
            _beneficiaryService = beneficiaryService;
        }

        [HttpGet("all")]
        public async Task<IActionResult> GetBeneficiaries()
        {
            var beneficiaries = await _beneficiaryService.GetBeneficiaries();
            return Ok(beneficiaries);
        }

        [HttpGet("employee/{employeeId}")]
        public async Task<IActionResult> GetBeneficiariesByEmployee([FromRoute] int employeeId)
        {
            var beneficiaries = await _beneficiaryService.GetBeneficiariesByEmployee(employeeId);
            return Ok(beneficiaries);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetBeneficiary([FromRoute] int id)
        {
            var beneficiary = await _beneficiaryService.GetBeneficiary(id);
            return Ok(beneficiary);
        }

        [HttpPut]
        public async Task<IActionResult> UpdateBeneficiary(BeneficiaryDto beneficiary)
        {
            var updatedBeneficiary = await _beneficiaryService.UpdateBeneficiary(beneficiary);
            return Ok(updatedBeneficiary);
        }

        [HttpPost]
        public async Task<IActionResult> AddBeneficiary(BeneficiaryDto beneficiary)
        {
            var updatedBeneficiary = await _beneficiaryService.AddBeneficiary(beneficiary);
            return Ok(updatedBeneficiary);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteBeneficiary(int id)
        {
            await _beneficiaryService.DeleteBeneficiary(id);
            return Ok();
        }

        [HttpPost("toemployee")]
        public async Task<IActionResult> BeneficiariesToEmployee([FromBody] IEnumerable<BeneficiariesToEmployeeDto> beneficiaries)
        {
            await _beneficiaryService.BeneficiariesToEmployee(beneficiaries);
            return Ok();
        }

        [HttpDelete("removeall/{employeeId}")]
        public async Task<IActionResult> RemoveAllBeneficiariesByEmployee(int employeeId)
        {
            await _beneficiaryService.RemoveAllBeneficiariesByEmployee(employeeId);
            return Ok();
        }
    }
}
