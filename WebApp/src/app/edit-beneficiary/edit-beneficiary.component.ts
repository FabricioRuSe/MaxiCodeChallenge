import { formatDate } from '@angular/common';
import { Component, OnInit, ViewChild } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { HttpProviderService } from '../service/http-provider.service';

@Component({
  selector: 'app-edit-beneficiary',
  templateUrl: './edit-beneficiary.component.html',
  styleUrls: ['./edit-beneficiary.component.scss']
})
export class EditBeneficiaryComponent implements OnInit {
  editBeneficiaryForm: beneficiaryForm = new beneficiaryForm();

  @ViewChild("employeeForm")
  beneficiaryForm!: NgForm;

  isSubmitted: boolean = false;
  beneficiaryId: any;

  constructor(private toastr: ToastrService, private route: ActivatedRoute, private router: Router,
    private httpProvider: HttpProviderService) { }

  ngOnInit(): void {
    this.beneficiaryId = this.route.snapshot.params['beneficiaryId'];
    this.getBeneficiaryById();
  }

  getBeneficiaryById() {
    this.httpProvider.getBeneficiaryById(this.beneficiaryId).subscribe((data: any) => {
      if (data != null && data.body != null) {
        var resultData = data.body;
        if (resultData) {
          this.editBeneficiaryForm.Id = resultData.id;
          this.editBeneficiaryForm.Name = resultData.name;
          this.editBeneficiaryForm.FirstLastName = resultData.firstLastName;
          this.editBeneficiaryForm.SecondLastName = resultData.secondLastName;
          this.editBeneficiaryForm.DateOfBirth = formatDate(new Date(resultData.dateOfBirth), 'yyyy-MM-dd', 'en');;
          this.editBeneficiaryForm.Curp = resultData.curp;
          this.editBeneficiaryForm.Ssn = resultData.ssn;
          this.editBeneficiaryForm.Phone = resultData.phone;
          this.editBeneficiaryForm.Nationality = resultData.nationality;
        }
      }
    },
      (error: any) => { });
  }

  EditEmployee(isValid: any) {
    this.isSubmitted = true;
    if (isValid) {
      this.httpProvider.updateBeneficiary(this.editBeneficiaryForm).subscribe(async data => {        
        this.toastr.success('Success');
        setTimeout(() => {
          this.router.navigate(['/AllBeneficiaries']);
        }, 500);
      },
        async error => {
          this.toastr.error('Error');
          setTimeout(() => {
            this.router.navigate(['/AllBeneficiaries']);
          }, 500);
        });
    }
  }
}

export class beneficiaryForm {
  Id: number = 0;
  Name: string = "";
  FirstLastName: string = "";
  SecondLastName: string = "";
  DateOfBirth: string = "";
  Curp: string = "";
  Ssn: string = "";
  Phone: string = "";
  Nationality: string = "";
}