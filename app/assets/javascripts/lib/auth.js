var authenticateUser;

authenticateUser = function(email, password, callback) {
  return $.ajax('/users/sign_in.json', {
    type: 'POST',
    data: {
      email: email,
      password: password
    },
    success: function(resp) {
      return callback({
        authenticated: true,
        token: resp.auth_token
      });
    },
    error: function(resp) {
      return callback({
        authenticated: false
      });
    }
  });
};

module.exports = {
  login: function(email, pass, callback) {
    if (this.loggedIn()) {
      if (callback) {
        callback(true);
      }
      this.onChange(true);
      return;
    }
    return authenticateUser(email, pass, (function(_this) {
      return function(res) {
        var authenticated;
        authenticated = false;
        if (res.authenticated) {
          localStorage.token = res.token;
          authenticated = true;
        }
        if (callback) {
          callback(authenticated);
        }
        return _this.onChange(authenticated);
      };
    })(this));
  },
  getToken: function() {
    return localStorage.token;
  },
  logout: function(callback) {
    delete localStorage.token;
    if (callback) {
      callback();
    }
    return this.onChange(false);
  },
  loggedIn: function() {
    return !!localStorage.token;
  },
  onChange: function() {}
};
