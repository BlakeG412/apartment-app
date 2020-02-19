class TenantsController < ApplicationController

  # set :views, "app/views/tenants"
  set :method_override, true


  get "/tenants" do 
    @tenants = Tenant.all 
    erb :"tenants/index"
  end

  get "/tenants/new" do
    @apartments = Apartment.all 
    erb :"tenants/new"
  end

  post "/tenants" do 
    # binding.pry
    if !params[:apartment][:address].empty?
      new_apt = Apartment.create(address: params[:apartment][:address])
      Tenant.create(name: params[:tenant][:name], apartment_id: new_apt.id)
    else
      Tenant.create(name: params[:tenant][:name], apartment_id: params[:apartment][:apartment_id])
    end
    redirect "/tenants"
  end


  get "/tenants/:id" do 
    @tenant = Tenant.find(params[:id])
    erb :"tenants/show"
  end

  get "/tenants/:id/edit" do
    @apartments= Apartment.all
    @tenant = Tenant.find(params[:id])
    erb :"tenants/edit"
  end

  patch "/tenants/:id" do
    @tenant = Tenant.find(params[:id])
    @tenant.update(name: params[:tenant][:name])
    if !params[:apartment][:address].empty?
      new_apt = Apartment.create(address: params[:apartment][:address])
      @tenant.update(apartment_id: new_apt.id)
    else
      @tenant.update( apartment_id: params[:apartment][:apartment_id])
    end
    redirect "/tenants/#{@tenant.id}"
  end

  delete '/tenants/:id' do
    Tenant.find(params[:id]).destroy
    redirect '/tenants'
  end

end
