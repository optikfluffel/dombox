module.exports = (builder, message = '', type) ->
    throw new Error 'missing builder' unless builder?
    {div} = builder
    clazz = 'alert'
    clazz = "alert alert-#{type}" if type?
    div class: clazz, message

