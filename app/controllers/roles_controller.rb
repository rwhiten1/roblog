class RolesController < ApplicationController
  
  skip_before_filter :check_authentication, :only => ["new", "create", "view", "edit", "update", "destroy", "index"]
  skip_before_filter :check_authorization, :only => ["new", "create", "view", "edit", "update", "destroy", "index"]
  
  layout "admin_console"
  
  def new
  end
  
  def create
    
  end

  def show
  end

  def edit
    @role = Role.find(params[:id])
  end

  def update
    @role = Role.find(params[:id])
    #clear out the rights
    @role.rights.clear
    #now, add back in the checked rights
    params[:role][:rights].each do |role,val|
      unless val.to_i == -1
        @role.rights << Right.find(val.to_i)
      end
    end
    
    @roles = Role.all
    render "index"
  end

  def destroy
  end

  def index
    @roles = Role.all
  end

end
