<% api_version = Rails.application.config.ember.api_version -%>
class Api::V<%= api_version %>::<%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= singular_table_name %>, only: [:show, :update, :destroy]
  respond_to :json

  # GET <%= route_url %>
  def index
    respond_with <%= orm_class.all(class_name) %>
  end

  # GET <%= route_url %>/1
  def show
    respond_with <%= "@#{singular_table_name}" %>
  end

  # POST <%= route_url %>
  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>

    if @<%= orm_instance.save %>
      respond_with <%= "@#{singular_table_name}" %>, status: :created, location: [:api, :v<%= api_version %>, <%= "@#{singular_table_name}" %>]
    else
      render json: <%= "@#{orm_instance.errors}" %>, status: :unprocessable_entity
    end
  end

  # PATCH/PUT <%= route_url %>/1
  def update
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      respond_with <%= "@#{singular_table_name}" %>, status: :ok, location: [:api, :v<%= api_version %>, <%= "@#{singular_table_name}" %>]
    else
      render json: <%= "@#{orm_instance.errors}" %>, status: :unprocessable_entity
    end
  end

  # DELETE <%= route_url %>/1
  def destroy
    @<%= orm_instance.destroy %>
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_<%= singular_table_name %>
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def <%= "#{singular_table_name}_params" %>
    <%- if attributes_names.empty? -%>
    params[<%= ":#{singular_table_name}" %>]
    <%- else -%>
    params.require(<%= ":#{singular_table_name}" %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
    <%- end -%>
  end
end
