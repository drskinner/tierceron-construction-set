# README

The Tierceron Construction Set (TCS) is a Ruby on Rails app to improve the building experience for Covenant MUD.

Let's face it, SMAUG's built in On-Line Creation (OLC) was adequate for the 1990s, but it's never made for a great user experience. Offline
tools like ORB never quite reached maturity and aren't without their shortcomings. The finished version of TCS will allow you to create and
edit Rooms, Objects, Mobiles, and Zone metadata. There are multiple user roles in TCS: lower-level roles will only be allowed to edit VNUMs
within their assigned range; higher-level roles will have broader access. The System Admin can poulate the database by importing SMAUG's text files via
the admin interface; for example: an upload form on `mobiles#index` will import the mobiles from any Covenant MUD area file.

You can also edit socials in TCS so you aren't stuck using the clumsy `sedit` command within the MUD.

Covenant MUD has fields that stock SMAUG does not, so TCS will not work for other SMAUG MUDs without some (admittedly minor) tweaking.

Currently running with Ruby 2.6.1, Rails 5.2.2, and PostgreSQL. Uses Devise for authentication and CanCanCan for authorization. Deployed to 
a free Heroku dyno at https://tierceron-construction-set.herokuapp.com.
