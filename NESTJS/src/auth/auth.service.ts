import { Injectable } from '@nestjs/common';


@Injectable({})
export class AuthService {
  signin() {
    return { msg: 'Good bye' };
  }

  signup() {
    return { msg: 'Hello' };
  }
}
