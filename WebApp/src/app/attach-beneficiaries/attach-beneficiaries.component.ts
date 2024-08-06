import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { ToastrService } from 'ngx-toastr';
import { HttpProviderService } from '../service/http-provider.service';

@Component({
  selector: 'app-attach-beneficiaries',
  templateUrl: './attach-beneficiaries.component.html',
  styleUrls: ['./attach-beneficiaries.component.scss']
})
export class AttachBeneficiariesComponent implements OnInit {

  beneficiaryList: any = [];
  attachedBeneficiariesList: any = [];
  selectedBeneficiary: any = {};
  percentage: number | null = null;
  employeeId: number = 0;

  constructor(private router: Router, private route: ActivatedRoute, private modalService: NgbModal,
    private toastr: ToastrService, private httpProvider : HttpProviderService) { }

  ngOnInit(): void {
    this.employeeId = this.route.snapshot.params['employeeId'];
    this.getAllBeneficiaries();
    this.getBeneficiariesByEmployee();
  }

  async getBeneficiariesByEmployee() {
    this.httpProvider.getBeneficiariesByEmployee(this.employeeId).subscribe((data : any) => {
      if (data != null && data.body != null) {
        var resultData = data.body;
        if (resultData) {
          this.attachedBeneficiariesList = resultData;
        }
      }
    },
    (error : any)=> {
      if (error) {
        if (error.status == 404) {
          if(error.error && error.error.message){
            this.beneficiaryList = [];
          }
        }
      }
    });
}

  async getAllBeneficiaries() {
    this.httpProvider.getBeneficiaries().subscribe((data : any) => {
      if (data != null && data.body != null) {
        var resultData = data.body;
        if (resultData) {
          this.beneficiaryList = resultData;
        }
      }
    },
    (error : any)=> {
        if (error) {
          if (error.status == 404) {
            if(error.error && error.error.message){
              this.beneficiaryList = [];
            }
          }
        }
      });
  }
  AddBeneficiaryToTable() : void {
    this.selectedBeneficiary['percentage'] = this.percentage;
    this.selectedBeneficiary['employeeId'] = this.employeeId;
    this.attachedBeneficiariesList.push(this.selectedBeneficiary);
    this.selectedBeneficiary = null;
    this.percentage = null;
  }

  AttachBeneficiaries() : void {
    const total = this.attachedBeneficiariesList.reduce((n: any, {percentage}: any) => n + percentage, 0)
    if (total != 100)
    {
      this.toastr.error('The sum of percentages should be 100');
      return;
    }

    this.httpProvider.attachBeneficiariesToEmployee(this.attachedBeneficiariesList).subscribe(async data => {
      this.toastr.success('Success');
      setTimeout(() => {
        this.router.navigate(['/AllEmployees']);
      }, 500);        
    },
    async error => {
      this.toastr.error('Error');
      setTimeout(() => {
        this.router.navigate(['/AllEmployees']);
      }, 500);
    });
  }

  RemoveBeneficiary(id: any) : void {
    alert(id);
    this.attachedBeneficiariesList = this.attachedBeneficiariesList.filter((beneficiary: { id: any; }) => beneficiary.id != id);
  }

  RemoveAllBeneficiaries() : void {
    this.httpProvider.removeAllBeneficiariesByEmployee(this.employeeId).subscribe(async data => {
      this.toastr.success('Success');
      this.attachedBeneficiariesList = [];        
    });
  }

  OnSelected() : void {
    this.selectedBeneficiary = this.selectedBeneficiary
  }

}
