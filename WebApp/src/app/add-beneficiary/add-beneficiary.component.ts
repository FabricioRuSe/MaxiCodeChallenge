import { Component, OnInit, ViewChild } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { HttpProviderService } from '../service/http-provider.service';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-add-beneficiary',
  templateUrl: './add-beneficiary.component.html',
  styleUrls: ['./add-beneficiary.component.scss']
})
export class AddBeneficiaryComponent implements OnInit {

  addBeneficiaryForm: beneficiaryForm = new beneficiaryForm();

  @ViewChild("beneficiaryForm")
  beneficiaryForm!: NgForm;

  isSubmitted: boolean = false;

  constructor(private router: Router, private httpProvider: HttpProviderService, private toastr: ToastrService) { }

  ngOnInit(): void {
  }

  AddBeneficiary(isValid: any) {
    this.isSubmitted = true;
    if (isValid) {
      this.httpProvider.saveBeneficiary(this.addBeneficiaryForm).subscribe(async data => {                  
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
  Name: string = "";
  FirstLastName: string = "";
  SecondLastName: string = "";
  DateOfBirth: string = "";
  Curp: string = "";
  Ssn: string = "";
  Phone: string = "";
  Nationality: string = "";
}