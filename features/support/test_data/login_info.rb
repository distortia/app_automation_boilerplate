LOGIN = {
  valid_login: {
    email_address: 'nick+qatest@beam.qa',
    password: 'test1234'
  },
  invalid_email_login: {
    email_address: 'invalid',
    password: 'test1234'
  },
  invalid_password_login: {
    email_address: 'nick+qatest@beam.qa',
    password: 'invalid'
  },
  blank_user: {
    email_address: '',
    password: ''
  },
  invalid_forgot_password_user: {
    email_address: 'invalid'
  },
  valid_forgot_password_user: {
    email_address: 'nick+qatest@beam.qa'
  },
  new_user: {
      email_address: 'test@test.qa',
      password: 'test1234'
  }
}
