register_listeners = () ->
    $('.add-filter').click () ->
        tmpl = Handlebars.compile $(this).data('template-id')
        debugger;

        Event.get_events('url', (data, status, xhr) ->
            context =
                'events': data.events
            html = tmpl.context(context)
        )


$(document).ready () ->
    register_listeners()
