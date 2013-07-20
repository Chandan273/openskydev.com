

$(document).ready ->
  date = new Date()
  year = date.getFullYear()
  if year > 2013
    $('span#copy-year').text '-' + year
