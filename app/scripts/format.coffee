define -> 
  pad = (num, zeroes) -> (1e10+num+'').slice(-zeroes)

  parse_date: (input) ->
    parts = input.match(/(\d+)-(\d+)-(\d+) (\d+):(\d+)\s*(pm|am){0,1}/i)
    hours = if parts[6]?.toLowerCase() == 'pm' then parseInt(parts[4]) + 12 else parts[4]
    new Date(parts[1], parts[2]-1, parts[3], hours, parts[5])

  format_time: (input, period=true) ->
    # make sure we have a Date object and extract relevant bits
    date = if input not instanceof Date then new Date(input) else input
    hours = date.getHours() 
    # assemble main time string
    time = "#{hours % 12 || 12}:#{pad(date.getMinutes(), 2)}"
    # add period string if enabled (default = true)
    if period then time += " #{if hours < 12 then 'a' else 'p'}m"
    time

  # YYYY-MM-DD format with custom separator
  format_date: (input, separator='-') ->
    date = if input not instanceof Date then new Date(input) else input
    [date.getFullYear(), pad(date.getMonth() + 1, 2), pad(date.getDate(), 2)].join(separator)

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
    