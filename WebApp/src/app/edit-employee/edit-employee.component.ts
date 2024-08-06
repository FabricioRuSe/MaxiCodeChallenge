import { Component, OnInit, ViewChild } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { HttpProviderService } from '../service/http-provider.service';
import { formatDate } from '@angular/common';

@Component({
  selector: 'app-edit-employee',
  templateUrl: './edit-employee.component.html',
  styleUrls: ['./edit-employee.component.scss']
})
export class EditEmployeeComponent implements OnInit {
  editEmployeeForm: employeeForm = new employeeForm();

  @ViewChild("employeeForm")
  employeeForm!: NgForm;

  isSubmitted: boolean = false;
  employeeId: any;

  constructor(private toastr: ToastrService, private route: ActivatedRoute, private router: Router,
    private httpProvider: HttpProviderService) { }

  ngOnInit(): void {
    this.employeeId = this.route.snapshot.params['employeeId'];
    this.getEmployeeDetailById();
  }

  getEmployeeDetailById() {
    this.httpProvider.getEmployeeById(this.employeeId).subscribe((data: any) => {
      if (data != null && data.body != null) {
        var resultData = data.body;
        if (resultData) {
          this.editEmployeeForm.Id = resultData.id;
          this.editEmployeeForm.Name = resultData.name;
          this.editEmployeeForm.FirstLastName = resultData.firstLastName;
          this.editEmployeeForm.SecondLastName = resultData.secondLastName;
          this.editEmployeeForm.DateOfBirth = formatDate(new Date(resultData.dateOfBirth), 'yyyy-MM-dd', 'en');;
          this.editEmployeeForm.Curp = resultData.curp;
          this.editEmployeeForm.Ssn = resultData.ssn;
          this.editEmployeeForm.Phone = resultData.phone;
          this.editEmployeeForm.Nationality = resultData.nationality;
        }
      }
    },
      (error: any) => { });
  }

  EditEmployee(isValid: any) {
    this.isSubmitted = true;
    if (isValid) {
      this.httpProvider.updateEmployee(this.editEmployeeForm).subscribe(async data => {        
        this.toastr.success('Success');
        setTimeout(() => {
          this.router.navigate(['/Home']);
        }, 500);
      },
        async error => {
          this.toastr.error('Error');
          setTimeout(() => {
            this.router.navigate(['/Home']);
          }, 500);
        });
    }
  }
}

export class employeeForm {
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