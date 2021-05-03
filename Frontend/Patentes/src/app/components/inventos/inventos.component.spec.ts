import { ComponentFixture, TestBed } from '@angular/core/testing';

import { InventosComponent } from './inventos.component';

describe('InventosComponent', () => {
  let component: InventosComponent;
  let fixture: ComponentFixture<InventosComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ InventosComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(InventosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
