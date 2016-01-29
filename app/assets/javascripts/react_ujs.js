var React = require('react');
var ReactDOM = require('react-dom');

var ReactRailsUJS = {
  CLASS_NAME_ATTR: 'data-react-class',
  PROPS_ATTR: 'data-react-props',

  findDOMNodes: function(searchSelector) {
    var selector, parent;

    switch (typeof searchSelector) {
      case 'undefined':
        selector = '[' + ReactRailsUJS.CLASS_NAME_ATTR + ']';
        parent = document;
        break;
      case 'object':
        selector = '[' + ReactRailsUJS.CLASS_NAME_ATTR + ']';
        parent = searchSelector;
        break;
      case 'string':
        selector = searchSelector + ' [' + ReactRailsUJS.CLASS_NAME_ATTR + ']';
        parent = document;
        break
      default:
        break;
    }

    return jQuery(selector, parent);
  },

  mountComponents: function(searchSelector) {
    var nodes = ReactRailsUJS.findDOMNodes(searchSelector);

    for (var i = 0; i < nodes.length; ++i) {
      var node = nodes[i];
      var className = node.getAttribute(ReactRailsUJS.CLASS_NAME_ATTR);

      // Assume className is simple and can be found at top-level (window).
      // Fallback to eval to handle cases like 'My.React.ComponentName'.

      var react_components = require('./react_components');
      try{
        var react_component = eval("react_components." + className);
      } catch(err){
        var error = err;
      }finally{
        if(error != undefined && error.name != "TypeError"){throw error;}
        if(react_component == undefined){
          ReactDOM.render(React.createElement(react_components.UnrealizedView, {name: className}), node);
        }
      }

      if(react_component != undefined){
        var propsJson = node.getAttribute(ReactRailsUJS.PROPS_ATTR);
        var props = propsJson && JSON.parse(propsJson);

        ReactDOM.render(React.createElement(react_component, props), node);
      }

    }
  },

  unmountComponents: function(searchSelector) {
    var nodes = ReactRailsUJS.findDOMNodes(searchSelector);

    for (var i = 0; i < nodes.length; ++i) {
      var node = nodes[i];

      ReactDOM.unmountComponentAtNode(node);
    }
  }
};

// functions not exposed publicly
function handleTurbolinksEvents () {
  var handleEvent;
  var unmountEvent;

  handleEvent = function(eventName, callback) {
    jQuery(document).on(eventName, callback);
  };

  if (Turbolinks.EVENTS) {
    unmountEvent = Turbolinks.EVENTS.BEFORE_UNLOAD;
  } else {
    unmountEvent = 'page:receive';
    Turbolinks.pagesCached(0);
    // if (window.ReactRailsUJS.RAILS_ENV_DEVELOPMENT) {
    //   console.warn('The Turbolinks cache has been disabled (Turbolinks >= 2.4.0 is recommended). See https://github.com/reactjs/react-rails/issues/87 for more information.');
    // }
  }

  handleEvent('page:change', function() {ReactRailsUJS.mountComponents()});
  handleEvent(unmountEvent, function() {ReactRailsUJS.unmountComponents()});
}

function handleNativeEvents() {
  jQuery(function() {ReactRailsUJS.mountComponents()});
}

if (typeof Turbolinks !== 'undefined' && Turbolinks.supported) {
  handleTurbolinksEvents();
} else {
  handleNativeEvents();
}
