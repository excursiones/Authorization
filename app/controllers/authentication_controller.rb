class AuthenticationController < ApplicationController
  def sign_in
    ldap = Net::LDAP.new
    ldap.host = '3.13.112.89'
    ldap.port = 389
    ldap.auth "cn=ccgomezn@unal.edu.co,ou=excursions,dc=excursions,dc=com", "0506Gfcgfc123"
    if ldap.bind
      p "yes"
    else
      p "no"
    end
  end
end
