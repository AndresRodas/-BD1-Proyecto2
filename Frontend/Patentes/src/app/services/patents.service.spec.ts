import { TestBed } from '@angular/core/testing';

import { PatentsService } from './patents.service';

describe('PatentsService', () => {
  let service: PatentsService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(PatentsService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
