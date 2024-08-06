import { Component, OnInit, Type } from '@angular/core';
import { Router } from '@angular/router';
import { NgbActiveModal, NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { ToastrService } from 'ngx-toastr';
import { HttpProviderService } from '../service/http-provider.service';


@Component({
  selector: 'ng-modal-confirm',
  template: `
  <div class="modal-header">
    <h5 class="modal-title" id="modal-title">Delete Confirmation</h5>
    <button type="button" class="btn close" aria-label="Close button" aria-describedby="modal-title" (click)="modal.dismiss('Cross click')">
      <span aria-hidden="true">&times;</span>
    </button>
  </div>
  <div class="modal-body">
    <p>Are you sure you want to delete?</p>
  </div>
  <div class="modal-footer">
    <button type="button" class="btn btn-outline-secondary" (click)="modal.dismiss('cancel click')">CANCEL</button>
    <button type="button" ngbAutofocus class="btn btn-success" (click)="modal.close('Ok click')">OK</button>
  </div>
  `,
})
export class NgModalConfirm {
  constructor(public modal: NgbActiveModal) { }
}

const MODALS: { [name: string]: Type<any> } = {
  deleteModal: NgModalConfirm,
};

@Component({
  selector: 'app-all-beneficiaries',
  templateUrl: './all-beneficiaries.component.html',
  styleUrls: ['./all-beneficiaries.component.scss']
})
export class AllBeneficiariesComponent implements OnInit {
  closeResult = '';
  beneficiaryList: any = [];
  constructor(private router: Router, private modalService: NgbModal,
    private toastr: ToastrService, private httpProvider : HttpProviderService) { }

  ngOnInit(): void {
    this.getAllBeneficiaries();
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

  AddBeneficiary() {
    this.router.navigate(['AddBeneficiary']);
  }

  deleteBeneficiaryConfirmation(employee: any) {
    this.modalService.open(MODALS['deleteModal'],
      {
        ariaLabelledBy: 'modal-basic-title'
      }).result.then((result) => {
        this.deleteBeneficiary(employee);
      },
        (reason) => {});
  }

  deleteBeneficiary(beneficiary: any) {
    this.httpProvider.deleteBeneficiaryById(beneficiary.id).subscribe((data : any) => {      
          this.toastr.success('Success');
          this.getAllBeneficiaries();       
    },
    (error : any) => {});
  }
}