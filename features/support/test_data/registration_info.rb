REGISTRATION = {
  invalid_email_registration: {
    first_name: 'Nick',
    last_name: 'Stalter',
    email_address: 'invalid',
    password: 'test1234'
  },
  invalid_password_registration: {
    first_name: 'Nick',
    last_name: 'Stalter',
    email_address: 'nick+qatest@beam.qa',
    password: '2short'
  },
  blank_last_name: {
    first_name: 'Nick',
    last_name: '',
    email_address: 'nick+qatest@beam.qa',
    password: 'test1234'
  },
  blank_first_name: {
    first_name: '',
    last_name: 'Stalter',
    email_address: 'nick+qatest@beam.qa',
    password: 'test1234'
  }
}
