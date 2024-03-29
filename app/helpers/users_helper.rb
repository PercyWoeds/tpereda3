include ApplicationHelper

module UsersHelper
  
  def getSalt()
    return 'mnygo_password_salt'
  end
  
  def doLogout()
    session[:company] = nil
    
    user = getSession().user
    
    if user
      # Delete old sessions if any
      sessions = Session.where(:user_id => user.id)

      for session in sessions
        session.delete
      end
    end
    
    cookies[getAppName() + '_login'] = nil
  end
  
  def doLogin(user)
    require "digest"
    
    # Delete old sessions if any
    old_sessions = Session.where(:session_id => user[0].id)
    
    for old_session in old_sessions
      old_session.delete
    end
    
    hash = Digest::MD5.hexdigest(getSalt() + user[0].id.to_s + user[0].username + user[0].password + Time.now.to_s)
    puts user[0].id 

    session = Session.new(:session_id=> user[0].id, :user => user, :session => hash)  
    session.save
    
    cookies[getAppName() + '_login'] = hash
  end
  
  def getLoginHash()
    return cookies[getAppName() + '_login']
  end
  
  def getSession()
    hash = getLoginHash()
    
    if hash
      session = Session.where(:session_id  => hash).first
      
      return session
    end
  end
  
  def isLogged()
    if(@is_logged)
      return @is_logged
    else
      session = getSession()
    
      if session
        return true
      end
    end
  end
  
  def isAdmin()
    if(@is_admin)
      return @is_admin
    else
      session = getSession()
    
      if session and session.user.level == 'admin'
        return true
      end
    end
  end
  
  def current_user
    if(@session_user)
      return @session_user
    else
      session = getSession()
    
      if session
        return session.user
      end
    end
  end
  
  def getUsername()
    user = current_user
    
    if user
      return user.username
    end
  end
  
  def getUserEmail()
    user = current_user
    
    if user
      return user.email
    end
  end
  
  def getUserId()
    user = current_user
    
    if user
      return user.id
    end
  end
  
  def errLogin()
    flash[:error] = 'You must login to view this.'
    redirect_to '/login'
  end
  
  def errPerms()
    redirect_to '/err_perms'
  end
  
  def checkAdmin()
    if(!isAdmin())
      errPerms()
    end
  end
  
  def authenticate_user!()
    if(!isLogged())
      errLogin
    end
  end
  
  def checkUserInfo
    @is_admin = isAdmin()
    @is_logged = isLogged()
    @session_user = current_user
  end
  
  def user_link()
    return ('<a href="/users/' + self.id.to_s + '">' + self.username + '</a>').html_safe
  end
end