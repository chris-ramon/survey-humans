#encoding: utf-8
# * *Page* *types*
#   - *0* -> new page
#   - *1* -> show page
#   - *2* -> edit page

class AccountManagement::UserController < ApplicationController
  layout "_content"  
  before_filter :authenticate_user!

  def index
    @current_view = "security"
    if current_user.has_access 2
      @search = User.search(params[:search])
      @list_users = @search.where(:deleted => 0).paginate(:page => params[:page]).order('id DESC')
      @list_profiles = Profile.where(:deleted => 0)
      respond_to do |format|
        format.html 
        format.js
      end
    else
      no_access
    end
  end

  def new
    if current_user.has_access 3
      @user = User.new
      @list_profiles = Profile.where(:deleted => 0)
      @int_page_type = 0
    else
      no_access
    end
  end

  def create
    if current_user.has_access 3
      user = User.new(params[:user])
      begin
        if user.save
          str_desc="Se registró el usuario "+user.fullname+" con id = "+user.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_created')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(user)
          redirect_to :action=>"new",:user=>user.attributes
        end
      rescue ActiveRecord::StatementInvalid => error
        flash[:alert] = t('messages.error_ocurred')
        redirect_to :action=>"new",:user=>user.attributes
      end
    else
      no_access
    end
  end

  def show
    if current_user.has_access 4
      @user = User.find params[:id]
      @list_profiles = Profile.where(:id => @user.profile.id)
      @int_page_type = 1
    else
      no_access
    end
  end

  def edit
    if current_user.has_access 5
      @user = User.find params[:id]
      @list_profiles = Profile.where(:deleted => 0)
      @int_page_type = 2
    else
      no_access
    end
  end

  def update

    if current_user.has_access 5
      user = User.find params[:id]
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
   
      user.attributes = params[:user]
      begin
        if user.save
          str_desc="Se editó el usuario "+user.fullname+" con id = "+user.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})            
          flash[:notice] = t('messages.successfully_updated')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(user)
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
    if current_user.has_access 6
      begin       
        if User.delete(params[:id])
          str_desc="Se eliminó el usuario "+User.find(params[:id]).fullname+" con id = "+params[:id].to_s
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
  
  def export_to_spreadsheet
    if current_user.has_access 2
      begin
        list_users = User.where(:deleted => 0)
        book = Spreadsheet::Workbook.new
        format = Spreadsheet::Format.new :weight => :bold,
                                       :size => 11,
                                       :horizontal_align => :center
                                       
        format2 = Spreadsheet::Format.new :horizontal_align => :center

        sheet = book.create_worksheet :name => 'Lista de Usuarios'
        sheet.row(1).default_format = format
        sheet.row(1).height = 15
        sheet.row(1).concat ['#', t('account_management.user.excel.name'),t('account_management.user.excel.lastname'),t('account_management.user.excel.lastname2'),t('account_management.user.excel.email'),t('account_management.user.excel.profile')]
        i = 2
        j = 1
        5.times do
          sheet.column(j).width = 18
          sheet.column(j).width = 30 unless j != 4
          j += 1 
        end
        list_users.each do |user|
          sheet.row(i).default_format = format2
          if user.lastname2.blank?
            user.lastname2 = '-'
          end
          sheet.row(i).concat [i-1,user.name,user.lastname,user.lastname2,user.email,user.profile.name]
          i += 1
        end
        book.write Rails.root + "public/excel-file.xls"
        send_file('public/excel-file.xls',:filename=>"#{t('account_management.user.index.title')}.xls")
      rescue ActiveRecord::StatementInvalid => error
        flash[:alert] = t('messages.error_ocurred')
        redirect_to :action => 'index'
      end
    else
      no_access
    end
  end

  def account_panel
    @current_view = "security"
  end

  def dashboard
    @current_view = "dashboard"
    @surveys=Match.where(:match_type_id => 1, :deleted=>0).order('updated_at DESC')
    @exams=Match.where(:match_type_id => 2, :deleted=>0).order('updated_at DESC')
  end

end
