// Generated by CoffeeScript 1.4.0
(function() {
  var register_listeners;

  register_listeners = function() {
    return $('.add-filter').click(function() {
      var tmpl;
      tmpl = Handlebars.compile($(this).data('template-id'));
      debugger;
      return Event.get_events('url', function(data, status, xhr) {
        var context, html;
        context = {
          'events': data.events
        };
        return html = tmpl.context(context);
      });
    });
  };

  $(document).ready(function() {
    return register_listeners();
  });

}).call(this);
