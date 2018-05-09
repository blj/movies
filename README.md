# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
ruby 2.5.0p0

* System dependencies
External Document Store API Endpoint is at http://34.216.164.119

* Configuration

* Database creation

* Database initialization

* How to run the test suite
Run tests by command `rspec` in project root folder

* Services (job queues, cache servers, search engines, etc.)

## Specification

### Objective

Write a simple Ruby on Rails app let a user query against a private IMDB-esque document store.  The end product should meet all the requirements in the “Requirements” section.  Anything beyond that is open ended and up to you to decide.

### About the Document Store

Your app will be able to query against and fetch data from our private Document Store API. The specifications and example results are as follows:

GET http://34.216.164.119/features/

Returns a list of all Feature IDs in the database.
```json
{
	features: array of Feature IDs
}
```

GET http://34.216.164.119/features/{ID}

Returns 404 if no document is found matching the specified Feature ID.  If found, returns a JSON object in the following format:

```json
{
	title: string,
	release: number,
	director: Person ID,
	cast: array of Person IDs
}
```

The director Person ID can be used to lookup a director that endpoint, and the Person IDs in cast can be used to lookup actors at that endpoint.


GET http://34.216.164.119/actors/

Returns a list of all actor Person IDs in the database.

```json
{
	actors: array of Person IDs
}
```


GET http://34.216.164.119/actors/{ID}

Returns 404 if no document is found matching the specified Person ID.  If found, returns a JSON object in the following format:

```json
{
	name: string,
	movies: array of Feature IDs
}
```

The Feature IDs in movies can be used to lookup features at that endpoint.


GET http://34.216.164.119/directors/

Returns a list of all director Person IDs in the database.

```json
{
	directors: array of Person IDs
}
```

GET http://34.216.164.119/directors/{ID}

Returns 404 if no document is found matching the specified Person ID.  If found, returns a JSON object in the following format:

```json
{
	name: string,
	movies: array of Feature IDs
}
```

The Feature IDs in movies can be used to lookup features at that endpoint.

### Requirements

You will be making a website using Ruby on Rails that allows users to make customized queries and to display the results in a friendly manner. Your application should run via  rails server on the command line. It should be visible at http://localhost:3000 Your code will be run and tested in a clean sandboxed environment running Ruby v2.1 and Rails v4. The types of queries you must support are provided here:

Movies from selected director
Allow the user to select a director from a list, and then display a list of all movies from that director.

Find all movies starring any selected actors
Allow the user to select any number of actors from a list, and then display a list of all movie titles that have at least one of the selected actors.

Find all movies starring all selected actors
Allow the user to select any number of actors from a list, and then display a list of all movie titles that have all of the selected actors.

Find common actors
Allow the user to select any number of movies from a list, and then display a list of all actors that are common to all movies.

In addition:

Each movie title in the entire application should be a hyperlink.  Clicking this link should show Movie Details which displays the movie title, release year, director’s name, and names of each cast member.

Each director and actor name in the entire application should be a hyperlink.  Clicking this link should show Person Details which displays the person’s name, all movies s/he has directed, and all movies s/he has starred in.

(Dropdown, radio, and checkbox lists are excluded from the above hyperlink requirements.)

### Bonus

Create a set of unit tests to validate your functionality.  Include these in the project.  Include a set of instructions on how to run your unit tests from the command line in the README.md file.

### Submit the Solution

Please commit your code to a public GitHub repo and send us the link to it.
