class UserAttacksController < ApplicationController
  # GET /user_attacks
  # GET /user_attacks.xml
  def index
    @user_attacks = UserAttack.all

    respond_to do |format|
	  format.mobilesafari { render :text => "Trying to get user attacks" }
      format.html # index.html.erb
      format.xml  { render :xml => @user_attacks }
    end
  end

  # GET /user_attacks/lookup/:email&:lastid
  # Lookup recent attacks to :email and send them back, as long as the id is greater than :lastid
  # The client sends up -1 for the lastid if it has nothing saved
  def lookup
    @user = User.find_by_email(params[:email])
	@user_attacks = UserAttack.where("id > ?", params[:lastid]).find_all_by_victim_id(@user.id)

	attack_array = []
	@user_attacks.each do |single_attack|
		attack_data = {}
		attacker = User.find(single_attack.attacker_id)
		attack_type = Attack.find(single_attack.attack_id)
		
		attack_data['attack_id'] = single_attack.id
		attack_data['attacker_email'] = attacker.email
		attack_data['attacker_name'] = attacker.name
		attack_data['attack_image'] = attack_type.attack_image
		attack_data['message'] = single_attack.message
		
		attack_array.push(attack_data)
	end

    respond_to do |format|
	  format.mobilesafari { render :json => attack_array }
      format.html # show.html.erb
      format.xml  { render :xml => @user_attack }
    end
  end

  # POST /user_attacks/phone
  def createFromPhone
	#Find the attacker by email.  If not found, create a new user with that email address.
	attacker = User.find_by_email(params[:user_attack][:attacker_email])
	if !attacker
		attacker = User.new
		attacker.name = "Unknown"
		attacker.email = params[:user_attack][:attacker_email]
		if !attacker.save
			# Not sure what to do here if the save fails
		end
	end
	
	params[:user_attack][:attacker_id] = attacker.id
	params[:user_attack].delete(:attacker_email)
	  
	#Find the victim by email.  If not found, create a new user with that email address.
	victim = User.find_by_email(params[:user_attack][:victim_email])
	if !victim
		victim = User.new
		victim.name = params[:user_attack][:victim_name]
		victim.email = params[:user_attack][:victim_email]
		if !victim.save
			# Not sure what to do here if the save fails
		end
	end
	
	params[:user_attack][:victim_id] = victim.id
	params[:user_attack].delete(:victim_email)
	
	#Find the attack by name.  If not found, do not create entry.
	attack = Attack.find_by_attack_image(params[:user_attack][:attack_name])
	if !attack
		# Not sure what to do here if the lookup fails
	end
	
	params[:user_attack][:attack_id] = attack.id
	params[:user_attack].delete(:attack_name)
	
    @user_attack = UserAttack.new(params[:user_attack])

    respond_to do |format|
      if @user_attack.save
		format.mobilesafari { render :text => "Saved!" }
        format.html { redirect_to(@user_attack, :notice => 'User attack was successfully created.') }
        format.xml  { render :xml => @user_attack, :status => :created, :location => @user_attack }
      else
	    format.mobilesafari { render :text => "Save failed!" }
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_attack.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /user_attacks/1
  # GET /user_attacks/1.xml
  def show
    @user_attack = UserAttack.find(params[:id])

    respond_to do |format|
	  format.mobilesafari { render :text => "Trying to get user attacks by id" }
      format.html # show.html.erb
      format.xml  { render :xml => @user_attack }
    end
  end

  # GET /user_attacks/new
  # GET /user_attacks/new.xml
  def new
    @user_attack = UserAttack.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_attack }
    end
  end

  # GET /user_attacks/1/edit
  def edit
    @user_attack = UserAttack.find(params[:id])
  end

  # POST /user_attacks
  # POST /user_attacks.xml
  def create
    @user_attack = UserAttack.new(params[:user_attack])

    respond_to do |format|
      if @user_attack.save
		format.mobilesafari { render :text => "Saved!" }
        format.html { redirect_to(@user_attack, :notice => 'User attack was successfully created.') }
        format.xml  { render :xml => @user_attack, :status => :created, :location => @user_attack }
      else
	    format.mobilesafari { render :text => "Save failed!" }
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_attack.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_attacks/1
  # PUT /user_attacks/1.xml
  def update
    @user_attack = UserAttack.find(params[:id])

    respond_to do |format|
      if @user_attack.update_attributes(params[:user_attack])
        format.html { redirect_to(@user_attack, :notice => 'User attack was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_attack.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_attacks/1
  # DELETE /user_attacks/1.xml
  def destroy
    @user_attack = UserAttack.find(params[:id])
    @user_attack.destroy

    respond_to do |format|
      format.html { redirect_to(user_attacks_url) }
      format.xml  { head :ok }
    end
  end
end
