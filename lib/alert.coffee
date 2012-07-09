v2 = (type) -> if type? then "alert alert-#{type}" else 'alert'
v1 = (type) -> if type? then "alert-message #{type}" else 'alert-message'

module.exports = (builder, message = '', type, classFun = v2) ->
    throw new Error 'missing builder' unless builder?
    builder.div class: classFun(type), message

module.exports.strategy =
    v1: v1
    v2: v2

