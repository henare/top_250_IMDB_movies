# This is a template for a Ruby scraper on morph.io (https://morph.io)
# including some code snippets below that you should find helpful

require 'scraperwiki'
require 'mechanize'
#
agent = Mechanize.new
#
# # Read in a page
url = "http://www.imdb.com/chart/top?ref_=ft_250"
page = agent.get(url)

# # Find somehing on the page using css selectors

# p page.at('.lister-list').text
# p page.at('.titleColumn').text.split(/\D/)[7]       #number
# p page.at('.titleColumn a').text.split(/"/)      #movie
# p page.at('.titleColumn a').attr('href')            #link
# # p page.at('.secondaryInfo').text.split(/[()]/)[1]   #year
# p page.at('.lister-list').at('.titleColumn').text.split(/\D/)[7]


page.at('.lister-list').search('tr').each do |tr|

  movie = {
    rank: tr.at('.titleColumn').text.split(/\D/)[7],
    movie_name: tr.at('.titleColumn a').text.split(/"/).first,
    link: 'http://www.imdb.com' + tr.at('.titleColumn a').attr('href'),
    year: tr.at('.secondaryInfo').text.split(/[()]/)[1]
  }

  p movie
  ScraperWiki.save_sqlite([:movie_name], movie)

end
#
# # Write out to the sqlite database using scraperwiki library
# ScraperWiki.save_sqlite(["name"], {"name" => "susan", "occupation" => "software developer"})
#
# # An arbitrary query against the database
# ScraperWiki.select("* from data where 'name'='peter'")

# You don't have to do things with the Mechanize or ScraperWiki libraries.
# You can use whatever gems you want: https://morph.io/documentation/ruby
# All that matters is that your final data is written to an SQLite database
# called "data.sqlite" in the current working directory which has at least a table
# called "data".
