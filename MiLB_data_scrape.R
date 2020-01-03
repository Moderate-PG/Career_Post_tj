# In order to capture the MiLB data I will web scrape baseball reference. 
# I first need to generate the appropriate player page URLs. Each player is given a code based upon the first 5 letters of their last name
# or their whole last name if it is shorter than 5 latters, followed by the first 2 letters of their first name and 01 if they are the
# first with that name. The number increases if there are multiple players with the same name.. 
# This is precedded by the first letter of their last name.
# I can use the base template of "https://www.baseball-reference.com/players/*/*******01.shtml"
# Mike Trout would be "https://www.baseball-reference.com/players/t/troutmi01.shtml"
# I need to generate all the URLs for all the players in tJ list I have. With this in place I can then scrape the information on last
# game played from their page.

# 1) I first need to figure out what to do when a URL doesn't work. I don't want it just skipped, I need to insert NA's in place. 
# 2) I also need to check, if possible, that I won't be causing any issues by accessing the site this much. I read something about a
# robot.txt somewhere. 
# 3) How do I deal with players with the same name as previous players? i.e. players whose bbref ID doesn't end in 01 but 02, 03 or 
# higher?
# 4) I need to figure out how to cap memory usage so the web scraping doesn't overload things. Also set up parrallelisation as well.

# PROBLEM 1 - DEALING WITH BBREF 404 ERRORS
# Test 1
url <- "https://www.baseball-reference.com/players/r/roberda12.shtml"
webpage <- read_html(url)
# returns 404 error 
# To deal with the error I can use try()
t <- try(read_html(url))
if ("try-error" %in% class(t)) {
  print("This was a successful test")
}
# This manages to capture the error properly. I therefore should be able to save an NA if this comes up again 

# PROBLEM 2 - CHECKING THE PERMISSIONS
install.packages("robotstxt")
library(robotstxt)
url <- "https://www.baseball-reference.com/players/t/troutmi01.shtml"
robotstxt(url)
# I tried googling the robots.txt for baseball reference and found something. I'm not 100% sure how to read it but I think 
# I am allowed to scrape what I want but there is a 3 second delay. 

# PROBLEM 3 - PLAYERS WITH SAME LETTERS IN BBREF CODE
# This solved itself as the 'people' document contains the bbref player codes for each player so I can easily use that after merging
# the files together as I do. Just need to copy and paste it in and somehow capture the first letter for use in the url preceding the
# '/' before the player code.
# I do need to improve merging of the different files though. 

# PROBLEM 4 - CAPPING MEMORY USAGE
# I can't lower the memory limit, I think it should be fine. I just need to set up the parallelisation.
