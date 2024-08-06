import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { WebApiService } from './web-api.service';

var apiUrl = "https://localhost:7276";


var httpLink = {
  getEmployees: apiUrl + "/api/employee/all",
  deleteEmployee: apiUrl + "/api/employee",
  getEmployee: apiUrl + "/api/employee",
  saveEmployee: apiUrl + "/api/employee",
  updateEmployee: apiUrl + "/api/employee",

  getBeneficiaries: apiUrl + "/api/beneficiary/all",
  getBeneficiariesByEmployee: apiUrl + "/api/beneficiary/employee",
  deleteBeneficiary: apiUrl + "/api/beneficiary",
  getBeneficiary: apiUrl + "/api/beneficiary",
  saveBeneficiary: apiUrl + "/api/beneficiary",
  updateBeneficiary: apiUrl + "/api/beneficiary",
  attachBeneficiariesToEmployee: apiUrl + "/api/beneficiary/toemployee",
  removeAllBeneficiariesByEmployee: apiUrl + "/api/beneficiary/removeall",
}

@Injectable({
  providedIn: 'root'
})
export class HttpProviderService {

  constructor(private webApiService: WebApiService) { }

  public getEmployees(): Observable<any> {
    return this.webApiService.get(httpLink.getEmployees);
  }

  public getEmployeeById(model: any): Observable<any> {
    return this.webApiService.get(httpLink.getEmployee + '/' + model);
  }

  public deleteEmployeeById(model: any): Observable<any> {
    return this.webApiService.delete(httpLink.deleteEmployee + '/' + model);
  }

  public saveEmployee(model: any): Observable<any> {
    return this.webApiService.post(httpLink.saveEmployee, model);
  }

  public updateEmployee(model: any): Observable<any> {
    return this.webApiService.put(httpLink.updateEmployee, model);
  }


  public getBeneficiaries(): Observable<any> {
    return this.webApiService.get(httpLink.getBeneficiaries);
  }

  public getBeneficiariesByEmployee(model: any): Observable<any> {
    return this.webApiService.get(httpLink.getBeneficiariesByEmployee + '/' + model);
  }

  public getBeneficiaryById(model: any): Observable<any> {
    return this.webApiService.get(httpLink.getBeneficiary + '/' + model);
  }

  public deleteBeneficiaryById(model: any): Observable<any> {
    return this.webApiService.delete(httpLink.deleteBeneficiary + '/' + model);
  }

  public saveBeneficiary(model: any): Observable<any> {
    return this.webApiService.post(httpLink.saveBeneficiary, model);
  }

  public updateBeneficiary(model: any): Observable<any> {
    return this.webApiService.put(httpLink.updateBeneficiary, model);
  }
  
  public attachBeneficiariesToEmployee(model: any): Observable<any> {
    return this.webApiService.post(httpLink.attachBeneficiariesToEmployee, model);
  }

  public removeAllBeneficiariesByEmployee(model: any): Observable<any> {
    return this.webApiService.delete(httpLink.removeAllBeneficiariesByEmployee + '/' + model);
  }
}
