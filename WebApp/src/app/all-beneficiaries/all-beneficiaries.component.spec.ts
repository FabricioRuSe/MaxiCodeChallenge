import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AllBeneficiariesComponent } from './all-beneficiaries.component';

describe('AllBeneficiariesComponent', () => {
  let component: AllBeneficiariesComponent;
  let fixture: ComponentFixture<AllBeneficiariesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AllBeneficiariesComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AllBeneficiariesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
