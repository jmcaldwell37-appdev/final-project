# Jonathan and Ravi's Final Project
 
This read me provides some context to the functionalities of the application not immediately apparent from the walkthrough.

The application relies on a series of rake tasks placed in '/lib/tasks/event_counters.rake', which are scheduled to run via HerokuScheduler.
Each specific task, or 'event', is indexed by users via the Events class, which simply contains a placeholder description.
Users can add these event 'dummy indicators' to their goals along with a transaction amount, thus creating a CustomizedPreference, the many<=>many relationship linking goals to events
Therefore, CustomizedPreference essentially becomes a ledger of user's savings preferences, which will be evaluated and acted upon appropriately every day.

We tried to keep the UI as clean as possible, meaning the only real database the user should be concerned with is their goals, and the goals of others.
Users can navigate their goals, make a new goal, view the goals of others, as well as browse unique events and add savings preferences to their goals.
Given the extensive logic associated with tracking the instance of an event, users must choose from a pre-populated selection of choices, we made 4 as a sample:

-Whenever the Milwaukee Bucks win a game
-Whenever Donald Trump Tweets
-Whenever the temperature falls below freezing
-Whenever ReliefWeb declares a natural disaster (included for those whose goals are charity-oriented)