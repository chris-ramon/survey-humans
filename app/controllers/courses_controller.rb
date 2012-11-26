#encoding: utf-8
class CoursesController < ApplicationController
  layout "_content"
  before_filter :authenticate_user!
  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.where(:user_id=>current_user.id,:deleted=>0)

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new
    2.times do
      course=@course.students.build
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  # POST /courses
  # POST /courses.json
  def create
    if !params[:course].nil?
      @course = Course.new(params[:course])
      @course.user_id=current_user.id
      if Student.where(:course_id=>@course.id).count<=50
        begin
          if @course.save
            str_desc="Se registró un estudiante para el curso con id = "+@course.id.to_s
            @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
            respond_to do |format|
              format.html { redirect_to(@course, :notice => 'Course was successfully created.') }
              format.json  { render :json => @course, :status => :created, :location => @course }
            end
          else
            respond_to do |format|
              format.html { render :action => "new" }
              format.json  { render :json => @course.errors, :status => :unprocessable_entity }
            end
          end
        rescue ActiveRecord::StatementInvalid => error
          flash[:alert] = t('messages.error_ocurred')
          respond_to do |format|
            format.html { render :action => "new" }
            format.json  { render :json => @course.errors, :status => :unprocessable_entity }
          end
        end
      else
        flash[:alert] = "You cannot add more students. Has been added 50 students."
        respond_to do |format|
          format.html { render :action => "new" }
          format.json  { render :json => @course.errors, :status => :unprocessable_entity }
        end
      end
    else
      flash[:notice] = "You have not added any student to the selected course."
      respond_to do |format|
        format.html { render :action => "new" }
        format.json  { render :json => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @course = Course.find(params[:id])
    @course.user_id=current_user.id
    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to(@course, :notice => 'Course was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    begin
      if Course.delete(params[:id])
        str_desc="Se elimino la curso "+Course.find(params[:id]).name+" con id = "+params[:id].to_s
        @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
        flash[:notice] = t('messages.successfully_deleted')
      else
        flash[:alert] = t('messages.error_ocurred')
      end
    rescue ActiveRecord::StatementInvalid => error
      flash[:alert] = t('messages.error_ocurred')
    end
    respond_to do |format|
      format.html { redirect_to(courses_url) }
      format.json  { head :ok }
    end
  end
end
