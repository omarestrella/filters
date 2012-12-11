filters = exports ? this

# Valid operations
OPERATIONS =
    equals:
        short_code: 'eq'
        display: 'equals'
        operation: '=='
    doesnotequal:
        short_code: 'ne'
        display: 'does not equal'
        operation: '!='
    greaterthan:
        short_code: 'gt'
        display: 'greater than'
        operation: '>'
    greaterthanequalto:
        short_code: 'gte'
        display: 'greater than equal to'
        operation: '>='
    lessthan:
        short_code: 'lt'
        display: 'less than'
        operation: '<'
    lessthanequalto:
        short_code: 'lte'
        display: 'less than equal to'
        operation: '<='


# Represents a system event
class filters.Event
    constructor: (@event_name, @fields=[]) -> return;

    load_fields: (url) ->
        ###
        Given a url, perform a get request for the specific fields
        ###

        $.get(url, {event_name: @event_name}, (data, status, xhr) ->
            @fields = data.fields
        )

    @get_events: (url, cb) ->
        ###
        Given a url, get the possible events for the system
        and then call the callback function
        ###

        $.get(url, {}, cb)

# Represents a single rule
class filters.Rule
    constructor: (@field_name, @value, operation) ->
        if typeof operation == 'string'
            if OPERATIONS.hasOwnProperty(operation)
                @operation = OPERATIONS[operation]
            else
                throw Error('Not a valid operation.')
        else
            throw Error('Custom operations not supported yet.')

    to_json: () ->
        return {
            field: @field
            operation: @operation
            value: @value
        }


# A filter is made up of an operator and multiple rules
class filters.Filter
    constructor: (@operator, @event, @event_name) ->
        @rules = {}

    add_expression: (expr) ->
        if @rules.hasOwnProperty(expr.event_name)
            @rules[expr.event_name] = []

        @rules[expr.event_name].push(expr)

    to_json: () ->
        ###
        Format of the rules json that should be accepted by the server
        {
            "operator": "and|or",
            "event_name": String,
            "rules": [
                    "field": String,
                    "operation": Object,
                    "value": String|Number
                , ...
            ]
        }
        ###

        rules_list = []
        for rules in @rules
            rules_list.push(rule.to_json()) for rule in rules

        return {
            operator: @operator,
            event_name: @event_name,
            rules: rules_list
        }




