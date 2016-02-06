define [
  'app'
], (app) ->
  app.registerFactory 'timeAgoService', [
    () ->
      timeAgoService =
        settings:
          refreshMillis: 60000
          allowPast: true
          allowFuture: false
          localeTitle: false
          cutoff: 0
          autoDispose: true
          strings:
            prefixAgo: null
            prefixFromNow: null
            suffixAgo: "ago"
            suffixFromNow: "from now"
            inPast: 'any moment now'
            seconds: "less than a minute"
            minute: "about a minute"
            minutes: "%d minutes"
            hour: "about an hour"
            hours: "about %d hours"
            day: "a day"
            days: "%d days"
            month: "about a month"
            months: "%d months"
            year: "about a year"
            years: "%d years"
            wordSeparator: " "
            numbers: []

        inWords: (distanceMillis) ->
          if not this.settings.allowPast and not this.settings.allowFuture
            throw 'timeago allowPast and allowFuture settings can not both be set to false.'

          $l = this.settings.strings
          prefix = $l.prefixAgo
          suffix = $l.suffixAgo
          if this.settings.allowFuture
            if distanceMillis < 0
              prefix = $l.prefixFromNow
              suffix = $l.suffixFromNow

          if not this.settings.allowPast and distanceMillis >= 0
            return this.settings.strings.inPast

          seconds = Math.abs(distanceMillis) / 1000
          minutes = seconds / 60
          hours = minutes / 60
          days = hours / 24
          years = days / 365

          substitute = (stringOrFunction, number) ->
            string = if angular.isFunction(stringOrFunction) then stringOrFunction(number, distanceMillis) else stringOrFunction
            value = ($l.numbers and $l.numbers[number]) or number
            return string.replace /%d/i, value

          words = seconds < 45 and substitute($l.seconds, Math.round(seconds)) or
            seconds < 90 and substitute($l.minute, 1) or
            minutes < 45 and substitute($l.minutes, Math.round(minutes)) or
            minutes < 90 and substitute($l.hour, 1) or
            hours < 24 and substitute($l.hours, Math.round(hours)) or
            hours < 42 and substitute($l.day, 1) or
            days < 30 and substitute($l.days, Math.round(days)) or
            days < 45 and substitute($l.month, 1) or
            days < 365 and substitute($l.months, Math.round(days / 30)) or
            years < 1.5 and substitute($l.year, 1) or
            substitute($l.years, Math.round(years));

          separator = $l.wordSeparator or ""
          separator = " " if $l.wordSeparator is undefined
          return [prefix, words, suffix].join(separator).trim()
  ]
