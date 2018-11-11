class ClientsController < ApplicationController
  skip_before_action :authenticate_user!

  soap_service namespace: 'urn:WashOut'
  #include WashOut::SOAP
  # Simple case
  soap_action "index",
              :return => {
              :UserDescription => [{:User => :string}]
            }
  def index
    @users = Client.all
    #render :soap => {'UserDescription' => {'@user_client' => "1", 'Name' => "Amin", 'Last' => "bhs"}}
    render :soap =>
    {:UserDescription => [
    {:User => @users.each {|user| user} }]}
  end

  soap_action "AddClient",
            :args   => { :client => {:nom => :string ,
                        :prenom => :string,
                        :numrue => :string,
                        :nomrue => :string,
                        :codepostal => :string,
                        :ville => :string,
                        :tel => :string,
                        :email => :string}
                         },
            :return => {id: :integer}, # [] for wash_out below 0.3.0
            :to     => :add_client
  def add_client
    client = params[:client].permit(:nom, :prenom, :numrue, :nomrue, :codepostal, :ville, :tel, :email).to_h
    client = client.select {|k,v| v.blank? == false}
    attribute_client = client.symbolize_keys
    client = Client.new(attribute_client)
    if client.save == true
      render :soap => {id: client.id}
    else
      raise SOAPError, "Tous les champs sont obligatoire"
    end
  end

  soap_action "SearchClient",
            :args   => { :search => {:nom => :string ,
                        :prenom => :string,
                        :id => :string,
                        :codepostal => :string,
                        :email => :string}
                         },
            :return => { }, # [] for wash_out below 0.3.0
            :to     => :search_client
  def search_client
    search = params[:search].permit(:prenom, :nom, :id, :codepostal, :email).to_h
    search = search.select {|k,v| v.blank? == false}
    search.symbolize_keys
    Client.where(search.symbolize_keys)
  end

  soap_action "UpdateClient",
            :args   => { :id_client => :integer,
                        :update_client => {:nom => :string ,
                        :prenom => :string,
                        :numrue => :string,
                        :nomrue => :string,
                        :codepostal => :string,
                        :ville => :string,
                        :tel => :string,
                        :email => :string}
                         },
            :return => { }, # [] for wash_out below 0.3.0
            :to     => :update_client
  def update_client
    id_client = params[:client].permit(:id)
    client = Client.find(id_client)
    new_attributes = params[:client].permit(:nom, :prenom, :numrue, :nomrue, :codepostal, :ville, :tel, :email).to_h
    new_attributes = new_attributes.select {|k,v| v.blank? == false}
    new_attributes.symbolize_keys
    client.update(new_attributes.symbolize_keys)
  end


    soap_action "DeleteClient",
            :args   => { :id => :integer },
            :return => :nil, # [] for wash_out below 0.3.0
            :to     => :delete_client
  def delete_client
    id_client = params[:search].permit(:id)
    client = Client.find(id_client)
    if client.nil?
      raise SOAPError, "Cet utilisateur n'existe pas"
    else
      client.destroy
    end
  end
end
