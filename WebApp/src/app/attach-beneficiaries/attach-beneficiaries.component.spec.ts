import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AttachBeneficiariesComponent } from './attach-beneficiaries.component';

describe('AttachBeneficiariesComponent', () => {
  let component: AttachBeneficiariesComponent;
  let fixture: ComponentFixture<AttachBeneficiariesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AttachBeneficiariesComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AttachBeneficiariesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
