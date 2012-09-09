#encoding: utf-8
# * *Page* *types*
#   - *0* -> new page
#   - *1* -> show page
#   - *2* -> edit page
class OrganizationManagement::CompanyController < ApplicationController
	layout "_content"
	before_filter :authenticate_user!
  
	def index
		if current_user.has_access 17
			@search = Company.search(params[:search])
			@list_companies = @search.where(:deleted => 0).paginate(:page => params[:page]).order('id DESC')
			@list_users = User.where(:deleted=>0)
			respond_to do |format|
				format.html
				format.js
			end
		else
			no_access
		end
	end

	def new
		if current_user.has_access 18
      @company = Company.new
      @list_users = User.where(:deleted=>0)
      @int_page_type = 0
    else
      no_access
    end
	end

  def create
    if current_user.has_access 18
      company = Company.new(params[:company])
      begin
        if company.save
          str_desc="Se registró el company "+company.name+" con id = "+company.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_created')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(company)
          redirect_to :action=>"new",:company=>company.attributes
        end
      rescue ActiveRecord::StatementInvalid => error
        flash[:alert] = t('messages.error_ocurred')
        redirect_to :action=>"new",:company=>company.attributes
      end
    else
      no_access
    end
  end

	def show
		if current_user.has_access 19
      @company = Company.find(params[:id])
      @list_users = User.where(:deleted=>0)
      @int_page_type = 1
    else
      no_access
    end
	end

	def edit
		if current_user.has_access 20
      @company = Company.find(params[:id])
      @list_users = User.where(:deleted=>0)
      @int_page_type = 2
    else
      no_access
    end
	end

	def update
		if current_user.has_access 20
      company = Company.find(params[:id])
      company.attributes = params[:company]

      begin
        if company.save
          str_desc="Se editó el company "+company.name+" con id = "+company.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_updated')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(company)
          redirect_to :action=>"edit",:id=>params[:id]
        end
      rescue ActiveRecord::StatementInvalid => error
        flash[:alert] = t('messages.error_ocurred')
        redirect_to :action=>"edit",:id=>params[:id]
      end
    else
      no_access
    end
  end

	def destroy
		if current_user.has_access 21
      begin
        if Company.delete(params[:id])
          str_desc="Se eliminó el company "+Company.find(params[:id]).name+" con id = "+params[:id].to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_deleted')
        else
          flash[:alert] = t('messages.error_ocurred')
        end
      rescue ActiveRecord::StatementInvalid => error
        flash[:alert] = t('messages.error_ocurred')
      end
      redirect_to :action=>"index"
    else
      no_access
    end
	end

	def organization_panel

	end

end

