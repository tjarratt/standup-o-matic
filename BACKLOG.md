# YE OLDE BACKLOG 
[ ] next week's MC cannot be the same as this week's
[ ] smarter suggestions for next week's MC
[ ] slack integration
[ ] randomize "X tool for X teams"
[ ] click to hide / show boxes when presenting
[ ] homepage says "Fancy a standup ? What else ?" before standup i srun
[ ] homepage says "Next standup will be ... $DATE" after it has been presented
[ ] work on deflaking the moment of zen test (see commit with "deflake")
[ ] page with historical record of sprints ?
[ ] (Chrome Warning) Indicate whether to send a cookie in a cross-site request by specifying its SameSite attribute
[ ] think about using ActiveRecord scopes -- https://guides.rubyonrails.org/active_record_querying.html
[ ] friendly messages for when no interestings or new team members
[ ] friendly messages when it's not standup yet (avant l'heure ... c'est pas l'heure)
[ ] nouvelles têtes
[ ] allow MC to be overriden during the week
[ ] randomize all lists when presenting (but not events)
[ ] users can add helps to standup


assumptions
===========
* we never need to support more than a single team
* users never belong to more than one team
* MC leverages external screen sharing to present (if they wish)
* basic auth is good enough
* true user accounts aren't really necessary


# DONE
[x] generate stub / route for /standup/ today
[x] remind myself how to setup e2e and unit tests w/ rails
[x] users can add new backmakers
[x] setup a system test for end to end to end
[x] make a halfway decent /backmakers/new page
[x] setup github actions
[x] deploy to heroku
[x] figure out Procfile w/ release for automatic migrations
[x] users can add interestings
[x] MC can present a standup
[x] root route
[x] once standup is presented, the board is cleared out
[x] halfway decent presentation
[x] basic auth
[x] friday standup --> moment of zen
[x] configure the team accordingly
[x] first release yay
[x] fix javascript errors
[x] moment of zen ONLY for fridays
[x] users can add events to standup
[x] show the MC for a standup if one is assigned
[x] friday standup --> pick next week's MC
[x] make new MC sticky at the end of the week
[x] make presentation of list items nicer
[x] README with ( tests | setup | ruby version )
[x] add a checkmark once MC is selected (and disable controls ?)
[x] fix moment of zen
  -- can't be saved (b/c standup doesn't exist yet)
  -- can't be loaded on /standups/today b/c none can be saved when no standups exist
[x] users can add moment of zen on thursday ONCE standup is presented
[x] ensure people can add interestings the day before standup
    or what if the standup isn't delivered for 2-3 or more days ?
[x] add details for interestings
[x] BUG : standups should not exist until PRESENTED (otherwise date will be wrong -- weekends, holidays, etc)
[x] hide team on the homepage
[x] randomize backmakers when presenting
[x] checkboxes are stateful while presenting

