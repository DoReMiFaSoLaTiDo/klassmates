var NavbarLeftMenuBar=React.createClass({
render: function() {
    return(<ul className="nav navbar-nav">
                <li><a data-toggle="modal" href="#myModal" id="help">Help</a></li>
                <li> <a href="" className="dropdown-toggle" data-toggle="dropdown">Menu <b className="caret"></b></a>
                    <ul className="dropdown-menu">
                        <li><a href="">Menu1</a></li>
                        <li><a href="">Menu2 </a></li>
                        <li><a href="">Menu3 </a></li>
                        <li><a href="">Menu4 </a></li>
                    </ul>
                </li>
           </ul>);
}
});

var NavbarRightMenuBar=React.createClass({
render: function() {
    return(<div className="collapse navbar-collapse">
              <ul className="nav navbar-nav pull-right">
                <li><a data-toggle="modal" href="#myModal" id="about">About</a></li>
                <li> <a href="" className="dropdown-toggle" data-toggle="dropdown">Menu <b className="caret"></b></a>
                    <ul className="dropdown-menu">
                        <li><a href="">Menu1</a></li>
                        <li><a href="">Menu2 </a></li>
                        <li><a href="">Menu3 </a></li>
                        <li><a href="">Menu4 </a></li>
                    </ul>
                </li>
                {/* <LoginMenu /> */}
              </ul>

            </div>);
}
});

// var LoginMenu=React.createClass({
//   render: function(){
//     return(
//       if (props["user_id"]) {
//         <li>
//             <a href="" className="dropdown-toggle" data-toggle="dropdown">Welcome <b className="caret"></b></a>
//             <ul className="dropdown-menu">
//                 <li><a href="">Edit Profile</a></li>
//                 <li><a href="">Sign Out </a></li>
//             </ul>
//         </li>
//       } else {
//         <li><a href="">Sign In/Register</a></li>
//       }
//     )
//   }
// })

var NavbarSearchBar=React.createClass({
render: function() {
    var buttonStyle={ marginLeft:-20,borderLeft:0 };
    var ulStyle={marginLeft:-20,marginTop:12};
    return (<form className="navbar-form navbar-left" id="search" role="search">
                <div className="form-group">
                    <input type="text" className="form-control" placeholder="Search" value="{%if query is defined%}{{query}}{%endif%}"/>
                    <input type="hidden" value="{%if searchin is defined%}{{searchin}}{%else%}1{%endif%}" id="searchin"/>
                </div>
                <span className="dropdown">
                    <button style={buttonStyle} type="button" className="btn btn-white dropdown-toggle text-info-all" data-toggle="dropdown"><span data-bind="label" className="{%if searchin is not defined%}fa fa-users {%elseif searchin==1%}fa fa-users{%else%} fa fa-bell-o{%endif%}"></span> <span className="caret"></span></button>
                        <ul style={ulStyle} className="dropdown-menu">
                            <li data-search="1"><a href="#"><span className="fa fa-users"></span> Search for Users</a></li>
                            <li data-search="2"><a href="#"><span className="fa fa-bell-o"></span> Search in Status</a></li>
                        </ul>
                </span>
                <button type="submit" className="btn btn-default" id="searchbutton">Submit</button>
            </form>);
}
});
var Navbar = React.createClass({
render: function() {
 return(<nav className="navbar navbar-shadow navbar-fixed-top" role="navigation">
          <div className="container">
            <div className="navbar-header">
              <a className="navbar-brand" href="{{path('homepage')}}">UNILORIN Accounting & Finance Class of '99</a>
            </div>
            <NavbarRightMenuBar/>
          </div>
        </nav>);
}
});
