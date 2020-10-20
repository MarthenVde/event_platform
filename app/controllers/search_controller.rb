class SearchController < ApplicationController
  def province
    render json: CS.get(params[:country]).map { |k,v| {text: v, id: k.to_s, value: v} }.prepend({:text=>"Please Select...", :id=>"-1", :value=>"-1"})
  end

  def city
    render json: CS.get(params[:country], params[:province]).map { |k,v| {text: k.to_s, id: k.to_s, value: k.to_s} }.prepend({:text=>"Please Select...", :id=>"-1", :value=>"-1"})
  end

end
