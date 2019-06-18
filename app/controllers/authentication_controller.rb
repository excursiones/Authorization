class AuthenticationController < ApplicationController
  
  def generate_token
    token = Knock::AuthToken.new(payload: { id: @result[0]['uidnumber'],
                                               email: @result[0]['uid'], 
                                               type: @result[0]['gidnumber'] }).token
    render json: {token: token}
  end

  def sign_in
    ldap = Net::LDAP.new
    ldap.host = '3.13.112.89'
    ldap.port = 389

    email = auth_params[:email]
    password = auth_params[:password]
    ldap.authenticate 'cn=admin,dc=excursions,dc=com', 'admin'
    @result = ldap.bind_as(
      base: "ou=excursions,dc=excursions,dc=com",
      filter: "(cn=#{email})",
      password: password
    )
    if @result
      generate_token
    else
      render status: :unauthorized
    end
  end

  def sign_up
    ldap = Net::LDAP.new
        ldap.host = '3.13.112.89'
        ldap.port = 389
        ldap.authenticate 'cn=admin,dc=excursions,dc=com', 'admin'        
    ldap.bind
    email = auth_params[:email]
    password = auth_params[:password]
    name = auth_params[:name]
    dn = "cn=#{email},ou=excursions,dc=excursions,dc=com"

    attr = {
      :cn => "#{email}",
      :objectclass => ["top", "inetorgperson"],
      :sn => "#{name}",
      :mail => "#{email}",
      :userPassword => "#{password}"
    }

    if ldap.add(:dn => dn, :attributes => attr)
      render status: :created
    else
      render status: 422
    end
    Rails.logger.info("ldap.add: #{ldap.get_operation_result}")
  end

  private

    def auth_params
      params.require(:auth).permit(:email, :password, :name)
    end
end
