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

  def sign_up
    ldap = Net::LDAP.new
        ldap.host = '3.13.112.89'
        ldap.port = 389
        ldap.authenticate 'cn=admin,dc=excursions,dc=com', 'admin'        
    ldap.bind
    dn = "cn=gfcristhian2@unal.edu.co,ou=excursions,dc=excursions,dc=com"

    attr = {
      :cn => "gfcristhian2@unal.edu.co",
      :objectclass => ["top", "inetorgperson"],
      :sn => "Smith",
      :mail => "gfcristhian2@unal.edu.co",
      :userPassword => '0506Gfcgfc123'
    }

    ldap.add(:dn => dn, :attributes => attr)
    Rails.logger.info("ldap.add: #{ldap.get_operation_result}")

  end
end
