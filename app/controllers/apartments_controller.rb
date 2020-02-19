class ApartmentsController < ApplicationController

  # set :views, "app/views/apartments"
  set :method_override, true


  get "/apartments" do
    @apartments = Apartment.all
    erb :"apartments/index"
  end

  get "/apartments/:id" do 
    @apartment = Apartment.find(params[:id])
    erb :"apartments/show"
  end

  get "/apartments/:id/edit" do
    @apartment = Apartment.find(params[:id])
    erb :"apartments/edit"
  end

  patch "/apartments/:id" do
    @apartment = Apartment.find(params[:id])
    @apartment.update(address: params[:address])
    redirect "/apartments/#{@apartment.id}"
  end

  delete '/apartments/:id' do
    Apartment.find(params[:id]).destroy
    redirect '/apartments'
  end

end
