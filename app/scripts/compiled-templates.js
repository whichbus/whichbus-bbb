this["JST"] = this["JST"] || {};

this["JST"]["about"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Handlebars.helpers; data = data || {};
  


  return "<div class=\"container-fluid\">\n    <div class=\"row-fluid\">\n        <img src=\"/images/logo.png\" class=\"logo-small\" alt=\"WhichBus logo\">\n    </div>\n    <div class=\"row-fluid\" >\n        <div class=\"span12 about\">\n            <div class=\"content\">\n                <h1 class=\"pacifico\">About WhichBus</h1>\n\n                <p>WhichBus started as a basic understanding: Riding the bus should be simple.</p>\n\n                <p>Unfortunately, this is not usually the case. It’s often difficult to navigate public transit, especially if riders don’t know which bus to take and when their bus is going to arrive. The concept that riding experiences can be simplified is what brought the WhichBus team together at the January 2012 Startup Weekend in Seattle where we received the award for “Best Design.”</p>\n\n                <p>We continued to develop the app at the April 2012 Startup Weekend Gov where WhichBus received the highest honor for “Best Overall Business.” This achievement awarded us a meeting with Seattle’s mayor, Mike McGinn, to discuss WhichBus, startups in Seattle, and open government.</p>\n\n                <p>At the EvergreenApps.org contest in October 2012, WhichBus won three awards, including 2nd Place Overall, People’s Choice, and Best Multi-Jurisdictional App.</p>\n\n                <p>Since our first Startup Weekend, we’ve been hard at work building out the site and testing the user experience with more than 1,200 unique users testing the private beta in the last three months. As a result of the direct feedback from our beta users, we’ve made dozens of improvements are are happy to now be public for all to use at <a href=\"http://whichbus.org\">http://whichbus.org</a>.</p>\n\n                <div class=\"span10 centered buttons\">\n                    <a class=\"btn span4\" href=\"https://docs.google.com/folder/d/0B0--R1aa2AkUVU05UGJJUi1Xd3c/edit\" target=\"_BLANK\">View our Press Kit</a>\n                    <a class=\"btn span4\" href=\"/about/terms\" target=\"_BLANK\">Terms of Service</a>\n                    <a class=\"btn span4\" href=\"/about/privacy\" target=\"_BLANK\">Privacy Policy</a>\n                </div><br/>\n\n                <h2>Team</h2>\n                <ul>\n                    <li>Gilad Gray, Team Lead/Developer</li>\n                    <li>Kim Manis, UX Design</li>\n                    <li>Daniel Miller, Developer</li>\n                    <li>Paige Pauli, UX/UI Design/Front-End Development</li>\n                    <li>Dave Rigotti, Business/Marketing</li>\n                </ul>\n\n                <h2>Contact</h2>\n                <p>Want to get in touch? Have critiques or accolades?</p>\n                <p>Send us an email at <a href=\"mailto:team@whichbus.org\">team@whichbus.org</a> or find us on <a href=\"http://www.facebook.com/whichbus\" target=\"_BLANK\">Facebook</a> and <a href=\"http://www.twitter.com/whichbus\">Twitter</a>  %>.</p>\n                <p>Feeling totally awesome? Give us some <a href=\"http://whichbus.uservoice.com/forums/181861-feedback\" target=\"_BLANK\">constructive feedback</a></p>\n\n                <h2>Special Thanks</h2>\n                <p>We couldn't have done it without these amazing folks and services: Eugeniy Kalinin, Joe Schulman, Farrin Reid, Kevin Wood, Dave Remy, Carter from Twilio, Mayor Mike McGinn, Sol Villarreal, the City of Seattle, Brian Ferris & OneBusAway, OpenTripPlanner, Socrata, LaunchRock, Seattle Department of Transportation, and perhaps most importantly, StartupWeekend for bringing us all together.</p>\n            </div>\n        </div>\n    </div>\n</div>";
  });

this["JST"]["itinerary"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Handlebars.helpers; data = data || {};
  var buffer = "", stack1, options, helperMissing=helpers.helperMissing, escapeExpression=this.escapeExpression;


  buffer += "<header class=\"gray\">\n	<i class=\"icon-affordance icon-chevron-right\"></i>\n	<h4>\n		<span class=\"summary\">";
  options = {hash:{},data:data};
  buffer += escapeExpression(((stack1 = helpers.itinerarySummary),stack1 ? stack1.call(depth0, depth0.legs, options) : helperMissing.call(depth0, "itinerarySummary", depth0.legs, options)))
    + "</span>\n		";
  options = {hash:{},data:data};
  buffer += escapeExpression(((stack1 = helpers.formatTime),stack1 ? stack1.call(depth0, depth0.startTime, options) : helperMissing.call(depth0, "formatTime", depth0.startTime, options)))
    + " (";
  options = {hash:{},data:data};
  buffer += escapeExpression(((stack1 = helpers.formatDuration),stack1 ? stack1.call(depth0, depth0.duration, options) : helperMissing.call(depth0, "formatDuration", depth0.duration, options)))
    + ")<br/>\n		<small>\n			";
  options = {hash:{},data:data};
  buffer += escapeExpression(((stack1 = helpers.fmtDuration),stack1 ? stack1.call(depth0, depth0.walkTime, options) : helperMissing.call(depth0, "fmtDuration", depth0.walkTime, options)))
    + " walking, ";
  options = {hash:{},data:data};
  buffer += escapeExpression(((stack1 = helpers.fmtDuration),stack1 ? stack1.call(depth0, depth0.transitTime, options) : helperMissing.call(depth0, "fmtDuration", depth0.transitTime, options)))
    + " transit\n		</small>\n	</h4>\n</header>\n<ol class=\"segments\" id=\"trip\"></ol>\n";
  return buffer;
  });

this["JST"]["map"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Handlebars.helpers; data = data || {};
  


  return "<div id=\"googlemap\"></div>";
  });

this["JST"]["navbar"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Handlebars.helpers; data = data || {};
  


  return "<div class=\"navbar navbar-fixed-top unselectable\">\n	<div class=\"navbar-inner\">\n		<div class=\"whichbus-nav\">\n			<div id=\"text-logo\" class=\"block pull-left\">\n				<a href=\"#\">WhichBus</a>\n			</div>\n			<div class=\"block pull-right\">\n	            <a class=\"icon settings dropdown\" rel=\"tooltip\" title=\"settings\" data-target=\"#\">\n	              <i class=\"icon-cog\"></i><label>Settings</label>\n	            </a>\n	            <ul class=\"dropdown-menu unstyled\" id=\"settings\">\n	            	<li><a href=\"#settings\"><i class=\"icon-wrench\"></i> Settings</a></li>\n	            	<li><a href=\"http://whichbus.uservoice.com/forums/181861-feedback\" target=\"_blank\">\n	            		<i class=\"icon-bullhorn\"></i> Feedback <i class=\"icon-external-link\"></i>\n	            	</a></li>\n	            	<li><a href=\"#about\"><i class=\"icon-question-sign\"></i> About</a></li>\n	            </ul>\n			</div>\n		</div>\n	</div>\n</div>";
  });

this["JST"]["partials/address-error"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Handlebars.helpers; data = data || {};
  var buffer = "", stack1, stack2, functionType="function", escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  
  return "\n	<input class=\"location\" type=\"text\" placeholder=\"Where ya at?\" id=\"fromQuery\" name=\"from\" onfocus=\"this.select()\" autocomplete=\"on\" autofocus>\n	";
  }

function program3(depth0,data) {
  
  
  return "\n	<input class=\"location\" type=\"text\" placeholder=\"Where ya headed?\" id=\"toQuery\" name=\"to\" onfocus=\"this.select()\" autocomplete=\"on\" autofocus>\n	";
  }

function program5(depth0,data) {
  
  
  return "Try again, from the top\n		";
  }

function program7(depth0,data) {
  
  
  return " Update that bus! ";
  }

  buffer += "<h4>";
  if (stack1 = helpers.title) { stack1 = stack1.call(depth0, {hash:{},data:data}); }
  else { stack1 = depth0.title; stack1 = typeof stack1 === functionType ? stack1.apply(depth0) : stack1; }
  buffer += escapeExpression(stack1)
    + "</h4>\n<p>"
    + escapeExpression(((stack1 = ((stack1 = depth0.error),stack1 == null || stack1 === false ? stack1 : stack1.message)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</p>\n<form class=\"update\">\n	";
  stack2 = helpers.unless.call(depth0, depth0.hasFrom, {hash:{},inverse:self.noop,fn:self.program(1, program1, data),data:data});
  if(stack2 || stack2 === 0) { buffer += stack2; }
  buffer += "\n	";
  stack2 = helpers.unless.call(depth0, depth0.hasTo, {hash:{},inverse:self.noop,fn:self.program(3, program3, data),data:data});
  if(stack2 || stack2 === 0) { buffer += stack2; }
  buffer += "\n\n	<button class=\"btn btn-update\" type=\"submit\">\n		";
  stack2 = helpers['if'].call(depth0, depth0.restart, {hash:{},inverse:self.program(7, program7, data),fn:self.program(5, program5, data),data:data});
  if(stack2 || stack2 === 0) { buffer += stack2; }
  buffer += "\n	</button>\n</form>";
  return buffer;
  });

this["JST"]["partials/copyright"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Handlebars.helpers; data = data || {};
  


  return "<div class=\"copyright\">\n    <span class=\"copy\">&copy;</span>2013 WhichBus, LLC -\n    <a href=\"/about\">About</a> -\n    <a href=\"/about/terms\">Terms</a> -\n    <a href=\"/about/privacy\">Privacy</a>\n</div>";
  });

this["JST"]["partials/realtime"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Handlebars.helpers; data = data || {};
  var buffer = "", stack1, stack2, options, functionType="function", escapeExpression=this.escapeExpression, helperMissing=helpers.helperMissing, self=this;

function program1(depth0,data) {
  
  var stack1;
  if (stack1 = helpers.delta) { stack1 = stack1.call(depth0, {hash:{},data:data}); }
  else { stack1 = depth0.delta; stack1 = typeof stack1 === functionType ? stack1.apply(depth0) : stack1; }
  return escapeExpression(stack1);
  }

  options = {hash:{},data:data};
  buffer += escapeExpression(((stack1 = helpers.formatTime),stack1 ? stack1.call(depth0, depth0.arrival, options) : helperMissing.call(depth0, "formatTime", depth0.arrival, options)))
    + "<br/>";
  stack2 = helpers['if'].call(depth0, depth0.delta, {hash:{},inverse:self.noop,fn:self.program(1, program1, data),data:data});
  if(stack2 || stack2 === 0) { buffer += stack2; }
  buffer += "\n";
  return buffer;
  });

this["JST"]["partials/social_media"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Handlebars.helpers; data = data || {};
  


  return "<div class=\"social-media\">\n    <a href=\"https://www.facebook.com/whichbus\" class=\"facebook-icon\" target=\"_BLANK\"></a>\n    <a href=\"https://twitter.com/whichbus\" class=\"twitter-icon\" target=\"_BLANK\"></a>\n    <a href=\"http://whichbus.tumblr.com/\" class=\"tumblr-icon\" target=\"_BLANK\"></a>\n    <a href=\"http://eepurl.com/kdy2v\" class=\"email-icon\" target=\"_BLANK\"></a>\n</div>\n";
  });

this["JST"]["partials/transit"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Handlebars.helpers; data = data || {};
  var buffer = "", stack1, options, functionType="function", escapeExpression=this.escapeExpression, helperMissing=helpers.helperMissing;


  buffer += "<span class=\"timing\"></span>\n<span class=\"action\">\n	<a class=\"btn btn-small btn-route\" href=\"#routes/";
  if (stack1 = helpers.agencyId) { stack1 = stack1.call(depth0, {hash:{},data:data}); }
  else { stack1 = depth0.agencyId; stack1 = typeof stack1 === functionType ? stack1.apply(depth0) : stack1; }
  buffer += escapeExpression(stack1)
    + "/";
  if (stack1 = helpers.route) { stack1 = stack1.call(depth0, {hash:{},data:data}); }
  else { stack1 = depth0.route; stack1 = typeof stack1 === functionType ? stack1.apply(depth0) : stack1; }
  buffer += escapeExpression(stack1)
    + "\">";
  if (stack1 = helpers.route) { stack1 = stack1.call(depth0, {hash:{},data:data}); }
  else { stack1 = depth0.route; stack1 = typeof stack1 === functionType ? stack1.apply(depth0) : stack1; }
  buffer += escapeExpression(stack1)
    + "</a> to\n		<a class=\"btn btn-stop\" href=\"#stops/"
    + escapeExpression(((stack1 = ((stack1 = ((stack1 = depth0.to),stack1 == null || stack1 === false ? stack1 : stack1.stopId)),stack1 == null || stack1 === false ? stack1 : stack1.agencyId)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "/"
    + escapeExpression(((stack1 = ((stack1 = ((stack1 = depth0.to),stack1 == null || stack1 === false ? stack1 : stack1.stopId)),stack1 == null || stack1 === false ? stack1 : stack1.id)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\">"
    + escapeExpression(((stack1 = ((stack1 = depth0.to),stack1 == null || stack1 === false ? stack1 : stack1.name)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n		</a>\n</span>\n<span class=\"details\">\n	<i class=\"icon-arrow-right\"></i>Ride for "
    + escapeExpression(((stack1 = ((stack1 = depth0.intermediateStops),stack1 == null || stack1 === false ? stack1 : stack1.length)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + " stops (";
  options = {hash:{},data:data};
  buffer += escapeExpression(((stack1 = helpers.formatDuration),stack1 ? stack1.call(depth0, depth0.duration, options) : helperMissing.call(depth0, "formatDuration", depth0.duration, options)))
    + ")\n</span>\n";
  return buffer;
  });

this["JST"]["partials/walk"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Handlebars.helpers; data = data || {};
  var buffer = "", stack1, stack2, options, functionType="function", escapeExpression=this.escapeExpression, helperMissing=helpers.helperMissing, self=this;

function program1(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\"href='/stops/"
    + escapeExpression(((stack1 = ((stack1 = ((stack1 = depth0.to),stack1 == null || stack1 === false ? stack1 : stack1.stopId)),stack1 == null || stack1 === false ? stack1 : stack1.agencyId)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "/"
    + escapeExpression(((stack1 = ((stack1 = ((stack1 = depth0.to),stack1 == null || stack1 === false ? stack1 : stack1.stopId)),stack1 == null || stack1 === false ? stack1 : stack1.id)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "'\"";
  return buffer;
  }

  buffer += "<span class=\"timing\">\n	<span class=\"duration label\">";
  options = {hash:{},data:data};
  buffer += escapeExpression(((stack1 = helpers.formatTime),stack1 ? stack1.call(depth0, depth0.startTime, options) : helperMissing.call(depth0, "formatTime", depth0.startTime, options)))
    + "</span>\n</span>\nWalk to <a class=\"btn btn-stop\" ";
  stack2 = helpers['if'].call(depth0, ((stack1 = depth0.to),stack1 == null || stack1 === false ? stack1 : stack1.stopId), {hash:{},inverse:self.noop,fn:self.program(1, program1, data),data:data});
  if(stack2 || stack2 === 0) { buffer += stack2; }
  buffer += ">"
    + escapeExpression(((stack1 = ((stack1 = depth0.to),stack1 == null || stack1 === false ? stack1 : stack1.name)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</a>\n";
  return buffer;
  });

this["JST"]["plan"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Handlebars.helpers; partials = partials || Handlebars.partials; data = data || {};
  var buffer = "", stack1, stack2, functionType="function", escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n		<strong>"
    + escapeExpression(((stack1 = ((stack1 = depth0.fromPlace),stack1 == null || stack1 === false ? stack1 : stack1.name)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</strong> "
    + escapeExpression(((stack1 = ((stack1 = depth0.fromPlace),stack1 == null || stack1 === false ? stack1 : stack1.vicinity)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "<br/>\n		<strong>"
    + escapeExpression(((stack1 = ((stack1 = depth0.toPlace),stack1 == null || stack1 === false ? stack1 : stack1.name)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</strong> "
    + escapeExpression(((stack1 = ((stack1 = depth0.toPlace),stack1 == null || stack1 === false ? stack1 : stack1.vicinity)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n		";
  return buffer;
  }

function program3(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n		"
    + escapeExpression(((stack1 = ((stack1 = depth0.from),stack1 == null || stack1 === false ? stack1 : stack1.name)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "<br/>"
    + escapeExpression(((stack1 = ((stack1 = depth0.to),stack1 == null || stack1 === false ? stack1 : stack1.name)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n		";
  return buffer;
  }

function program5(depth0,data) {
  
  
  return "<div class=\"progress progress-striped active\"><div class=\"bar\"></div></div>";
  }

  buffer += "<header class=\"teal\" id=\"title\">\n	<i class=\"icon-affordance icon-reply\"></i>\n	<div>\n		";
  stack2 = helpers['if'].call(depth0, ((stack1 = depth0.fromPlace),stack1 == null || stack1 === false ? stack1 : stack1.name), {hash:{},inverse:self.program(3, program3, data),fn:self.program(1, program1, data),data:data});
  if(stack2 || stack2 === 0) { buffer += stack2; }
  buffer += "\n	    <a class=\"icon popout\" id=\"options\" title=\"customize journey\">\n	        <i class=\"icon-reorder icon-affordance right\"></i>\n	    </a>\n	</div>\n</header>\n\n<ol class=\"itineraries\" id=\"itineraries\"></ol>\n";
  stack2 = helpers['if'].call(depth0, depth0.loading, {hash:{},inverse:self.noop,fn:self.program(5, program5, data),data:data});
  if(stack2 || stack2 === 0) { buffer += stack2; }
  buffer += "\n<div class=\"alert alert-error\"></div>\n<div id=\"plan-footer\">\n	";
  stack2 = self.invokePartial(partials.copyright, 'copyright', depth0, helpers, partials, data);
  if(stack2 || stack2 === 0) { buffer += stack2; }
  buffer += " ";
  stack2 = self.invokePartial(partials.social_media, 'social_media', depth0, helpers, partials, data);
  if(stack2 || stack2 === 0) { buffer += stack2; }
  buffer += "\n</div>";
  return buffer;
  });

this["JST"]["splash"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Handlebars.helpers; partials = partials || Handlebars.partials; data = data || {};
  var buffer = "", stack1, self=this;


  buffer += "<div class=\"row-fluid\">\n	<div class=\"logo span9 centered\"><img src=\"/images/logo.png\" alt=\"WhichBus\" /></div>\n</div>\n<div class=\"row-fluid\">\n	<div class=\"centered directions\">\n		<h2 class=\"row pacifico\">We'll get you there!</h2>\n		<form id=\"splash-form\" class=\"\">\n			<table class=\"row-fluid\">\n				<tr class=\"span11 centered\">\n					<td style=\"width:100%\">\n						<input class=\"location\" type=\"text\" placeholder=\"Where ya at?\" id=\"from_query\" name=\"from\" onfocus=\"this.select()\" autocomplete=\"on\">\n					</td>\n					<td style=\"width:0\"><button class=\"btn btn-large geolocate\" type=\"button\" id=\"from-location\"><i class=\"icon-map-marker\"></i></button></td>\n				</tr>\n				<tr class=\"span11 centered\">\n					<td style=\"width:100%\">\n						<input class=\"location\" type=\"text\" placeholder=\"Where ya headed?\" id=\"to_query\" name=\"to\" onfocus=\"this.select()\" autocomplete=\"on\">\n					</td>\n					<td style=\"width:0\"><button class=\"btn btn-large geolocate\" type=\"button\" id=\"to-location\"><i class=\"icon-map-marker\"></i></button></td>\n				</tr>\n			</table>\n			<div class=\"row-fluid\">\n				<button class=\"btn btn-map btn-go span8 centered\" type=\"submit\">MAP THAT BUS!</button>\n			</div>\n		</form>\n	</div>\n</div>\n<div id=\"splash-footer\">\n";
  stack1 = self.invokePartial(partials.copyright, 'copyright', depth0, helpers, partials, data);
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += " ";
  stack1 = self.invokePartial(partials.social_media, 'social_media', depth0, helpers, partials, data);
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n</div>";
  return buffer;
  });

this["JST"]["layouts/index"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Handlebars.helpers; data = data || {};
  


  return "<div id=\"navbar\"></div>\n<div id=\"map\"></div>\n<div id=\"navigation\"></div>";
  });

this["JST"]["layouts/splash"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Handlebars.helpers; data = data || {};
  


  return "<div class=\"row-fluid\">\n	<div class=\"logo span9 centered\"><img src=\"/images/logo.png\" alt=\"WhichBus\" /></div>\n</div>\n<div class=\"row-fluid\">\n	<div class=\"span11 centered directions\">\n		<h2 class=\"row\">We'll get you there!</h2>\n		<form id=\"splash-form\" class=\"\">\n			<table class=\"row-fluid\">\n				<tr class=\"span11 centered\">\n					<td style=\"width:100%\">\n						<input class=\"location\" type=\"text\" placeholder=\"Where ya at?\" id=\"from_query\" name=\"from\" onfocus=\"this.select()\" autocomplete=\"on\">\n					</td>\n					<td style=\"width:0\"><button class=\"btn btn-large geolocate\" type=\"button\" id=\"from-location\"><i class=\"icon-map-marker\"></i></button></td>\n				</tr>\n				<tr class=\"span11 centered\">\n					<td style=\"width:100%\">\n						<input class=\"location\" type=\"text\" placeholder=\"Where ya headed?\" id=\"to_query\" name=\"to\" onfocus=\"this.select()\" autocomplete=\"on\">\n					</td>\n					<td style=\"width:0\"><button class=\"btn btn-large geolocate\" type=\"button\" id=\"to-location\"><i class=\"icon-map-marker\"></i></button></td>\n				</tr>\n			</table>\n			<div class=\"row-fluid\">\n				<button class=\"btn btn-map btn-go span8 centered\" type=\"submit\">MAP THAT BUS!</button>\n			</div>\n		</form>\n	</div>\n</div>\n\n<!-- <div id=\"splash-footer\">\n	<%- Transit.copyright %>\n	<%- Transit.social_media %>\n</div> -->";
  });