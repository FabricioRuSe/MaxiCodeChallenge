import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AddEmployeeComponent } from './add-employee/add-employee.component';
import { EditEmployeeComponent } from './edit-employee/edit-employee.component';
import { HomeComponent } from './home/home.component';
import { AddBeneficiaryComponent } from './add-beneficiary/add-beneficiary.component';
import { EditBeneficiaryComponent } from './edit-beneficiary/edit-beneficiary.component';
import { AllEmployeesComponent } from './all-employees/all-employees.component';
import { AllBeneficiariesComponent } from './all-beneficiaries/all-beneficiaries.component';
import { AttachBeneficiariesComponent } from './attach-beneficiaries/attach-beneficiaries.component';

const routes: Routes = [
  { path: '', redirectTo: 'Home', pathMatch: 'full'},
  { path: 'Home', component: HomeComponent },

  { path: 'AllEmployees', component: AllEmployeesComponent },
  { path: 'AddEmployee', component: AddEmployeeComponent },
  { path: 'EditEmployee/:employeeId', component: EditEmployeeComponent }, 

  { path: 'AttachBeneficiaries/:employeeId', component: AttachBeneficiariesComponent },
  { path: 'AllBeneficiaries', component: AllBeneficiariesComponent },
  { path: 'AddBeneficiary', component: AddBeneficiaryComponent },
  { path: 'EditBeneficiary/:beneficiaryId', component: EditBeneficiaryComponent } 
];
  

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }