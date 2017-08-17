**Do not share this repo or post it publicly. We will take violations
very seriously.**

# The United States Senate

We'll take **45min** for this part of the assessment.

**NB: Run `bundle install` before you get started.**

Next, set up the database:

    ./setup_db.sh

We have been tasked to develop an application for the United States
Senate that will keep track of senators, bills, committees, parties,
ideologies, and desks.

Your task today is to build the relationships between all of these
models. The database has already been setup and the models have been
annotated with their respective table schemas.

## Building Associations

The specs (`bundle exec rspec`) will guide you through building a
series of associations. Refer to the `db/schema.rb` file to find the
format of the database; this will especially help you find the name of
foreign keys.

I would start by building `has_many`, `belongs_to` and `has_one`
associations. I would later build the various `:through` associations.

## Brief Description

Make sure to be looking at the specs and the `db/schema.rb`. Part of
your job is to be able to understand the structure and interrelations
of the data from these sources. However, here is a brief overview:

Senators write bills, which we will assume are implicitly endorsed by
that Senator's Party, as well. Bills can be "endorsed" by other
Senators.

Senators are assigned to work on one or more Committees. The Committee
is led by a chairperson (a Senator). Senators can chair at most one
Committee, but can be regular members of several committees.

Each Senator belongs to a Party. Each Party believes in an Ideology and
is led by a party leader (a Senator).

Lastly, Senators have a Desk, where they work.

**Copyright App Academy, please do not post online**
