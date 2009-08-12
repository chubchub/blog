class UsersController < ApplicationController

  def login
    @user = User.new
  end

  def logoff
    @flash = "you have logged off"
    session[:user_id] = nil
    redirect_to(:action => 'index', :controller => 'blogs')
  end
  
  def try_login
    @user = User.find_by_login_and_password(params[:user][:login], params[:user][:password])
    
    if @user
      @user.last_login = Time.now
      session[:user_id] = @user.id
      redirect_to(:action => 'my_blogs')
    else
      @flash = "bad login. please try again"
      redirect_to(:action => 'login')
    end
    return false
  end
  
  def my_blogs
    if !session[:user_id].nil?
      @user = User.find(session[:user_id])
      @blogs = @user.blogs
    else
      @user = nil
      @flash = 'you need to be logged in to view this page.'
      redirect_to(:action => 'login')
    end
  end
  
  
  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
