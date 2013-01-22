define -> 
  parse_date: (input) ->
    parts = input.match(/(\d+)-(\d+)-(\d+) (\d+):(\d+)\s*(pm|am){0,1}/i)
    hours = if parts[6]?.toLowerCase() == 'pm' then parseInt(parts[4]) + 12 else parts[4]
    new Date(parts[1], parts[2]-1, parts[3], hours, parts[5])

  format_time: (input) ->
    date = if input not instanceof Date then new Date(input) else input
    hours = date.getHours() % 12 || 12
    minutes = date.getMinutes()
    padded_minutes = "#{if minutes < 10 then '0' else ''}#{minutes}"
    period = if date.getHours() < 12 then 'am' else 'pm'
    "#{hours}:#{padded_minutes} #{period}"

  format_otp_date: (input) ->
    date = if input not instanceof Date then new Date(input) else input
    month = date.getMonth() + 1
    padded_month = "#{if month < 10 then '0' else ''}#{month}"
    day = date.getDate()
    padded_day = "#{if day < 10 then '0' else ''}#{day}"
    year = date.getFullYear()
    "#{year}-#{padded_month}-#{padded_day}"

  format_otp_time: (input) ->
    date = if input not instanceof Date then new Date(input) else input
    hours = date.getHours()
    zone = if hours > 11 then 'pm' else 'am'
    minutes = date.getMinutes()
    padded_minutes = "#{if minutes < 10 then '0' else ''}#{minutes}"
    # "#{hours % 12}:#{padded_minutes} #{zone}" - no longer valid for Chrome input:time field
    "#{hours}:#{padded_minutes}"

  format_duration: (seconds, minimize) ->
    # if no second parameter specified then auto-minimize if time > 1 hour
    minimize = seconds > 3600 unless minimize?

    return "NOW!" if seconds < 60 and not minimize
    mins = Math.floor(seconds / 60)
    if mins > 59
      hrs = Math.floor(mins / 60)
      mins = mins % 60
    else hrs = 0

    if hrs > 0 then "#{hrs}#{if minimize then 'h' else ' hours'}, #{mins}#{if minimize then 'm' else ' minutes'}"
    else "#{mins}#{if minimize then 'm' else ' minutes'}"

  format_deviation: (seconds) ->
    minutes = Math.round(seconds / 60)
    if minutes > 0
      "#{minutes} minute#{if minutes > 1 then 's' else ''} early"
    else if minutes < 0
      "#{Math.abs(minutes)} minute#{if minutes < -1 then 's' else ''} late"
    else if minutes == 0
      'on time'
    else null

  deviation_class: (seconds) ->
    if seconds > 30 then 'early label-success'
    else if seconds > -30 then 'on-time label-info'
    else 'late label-important'